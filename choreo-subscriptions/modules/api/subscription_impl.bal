// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/log;
import ballerina/uuid;
import choreo_subscriptions.db;
import choreo_subscriptions.cache;


# Returns the subscribed tier object for the given organization
#
# + orgId - Id of the interested organization
# + return - Subscribed tier object
public function getSubscriptionForOrg(string orgId) returns GetTierDetailResponse|error {
    GetTierDetailResponse|error getTierDetailResponse = getTierForOrgFromCache(orgId);
    if (getTierDetailResponse is GetTierDetailResponse) {
        return getTierDetailResponse;
    } else {
        return getTierForOrgFromDB(orgId);
    }
}

# Creates a new Tier and returns
#
# + createTierRequest - The tier object needs to be created
# + return - Created tier object
public function createTier(CreateTierRequest createTierRequest) returns CreateTierResponse|error {
    string uuid = uuid:createType1AsString();
    db:TierDAO tierDAOIn = {
        id: uuid,
        name: createTierRequest.name,
        description: createTierRequest.description,
        cost: createTierRequest.cost
    };

    CreateTierResponse createTierResponse = {};
    boolean isRollbacked = false;
    boolean isCommitFailed = false;
    transaction {
        error? resultAddTier = db:addTier(tierDAOIn);
        if (resultAddTier is error) {
            log:printError("Error occured while adding tier to database.", tier = createTierRequest);
            isRollbacked = true;
            rollback;
        } else {
            db:QuotaRecord[] quotaRecords = [];
            quotaRecords[0] = { tier_id: uuid, attribute_name: "service_quota",
                threshold: createTierRequest.service_quota };
            quotaRecords[1] = { tier_id: uuid, attribute_name: "integration_quota",
                threshold: createTierRequest.integration_quota };
            quotaRecords[2] = { tier_id: uuid, attribute_name: "api_quota",
                threshold: createTierRequest.api_quota };
            quotaRecords[3] = { tier_id: uuid, attribute_name: "remote_app_quota",
                threshold: createTierRequest.remote_app_quota };

            error? resultAddTierQuotas = db:addQuotaRecords(quotaRecords);
            if (resultAddTierQuotas is error) {
                log:printError("Error occured while adding the tier quota limits to database",
                    quotaRecords = quotaRecords, 'error = resultAddTierQuotas);
                isRollbacked = true;
                rollback;
            } else {
                error? err = commit;
                if (err is error) {
                    isCommitFailed = true;
                    log:printError("Error occured while commiting the transaction to add tier", 'error = err);
                }
            }
        }
    }

    if (isRollbacked || isCommitFailed) {
        log:printError("Error while adding tier to the database.", tierId = uuid);
        return error("Error while adding tier to the database.", tierId = uuid);
    } else {
        db:Tier|error tier = db:getTier(uuid);
        if (tier is error) {
            return tier;
        } else {
            createTierResponse = {
                tier: {
                    id: <string>tier?.id,
                    name: tier.name,
                    description: tier.description,
                    cost: tier.cost,
                    created_at: <string>tier?.created_at,
                    service_quota: <int>tier?.quota_limits?.service_quota,
                    integration_quota: <int>tier?.quota_limits?.integration_quota,
                    api_quota: <int>tier?.quota_limits?.api_quota,
                    remote_app_quota: <int>tier?.quota_limits?.remote_app_quota
                }
            }; 
        }
        return createTierResponse;
    }
}

# Creates a new subscription object
#
# + createSubscriptionRequest - The subscription object need to be created
# + return - created subscription object
public function createSubscription(CreateSubscriptionRequest createSubscriptionRequest) returns
        CreateSubscriptionResponse|error {
    string uuid = uuid:createType1AsString();
    db:SubscriptionDAO subscriptionDAOin = {
        id: uuid,
        org_id: createSubscriptionRequest.org_id,
        tier_id: createSubscriptionRequest.tier_id,
        billing_date: createSubscriptionRequest.billing_date,
        status: createSubscriptionRequest.status
    };
    
    error? result = db:addSubscription(subscriptionDAOin);
    if (result is error) {
        return result;
    } else {
        db:SubscriptionDAO|error subscriptionDAOOut = db:getSubscription(uuid);
        if (subscriptionDAOOut is db:SubscriptionDAO) {
            CreateSubscriptionResponse createSubscriptionResponse = {
                subscription: {
                    id: <string>subscriptionDAOOut?.id,
                    org_id: subscriptionDAOOut.org_id,
                    tier_id: subscriptionDAOOut.tier_id,
                    billing_date: subscriptionDAOOut.billing_date,
                    status: subscriptionDAOOut.status,
                    created_at: <string>subscriptionDAOOut?.created_at
                }
            };
            return createSubscriptionResponse;
        } else {
            return subscriptionDAOOut;
        }
    }
}

# Creates a new attribute for rate limiting. Ex : number_of_organizations per user
#
# + createAttributeRequest - The attribute object needs to be created
# + return - The created attribute object
public function createAttribute(CreateAttributeRequest createAttributeRequest) returns CreateAttributeResponse|error {
    string uuid = uuid:createType1AsString();
    db:AttributeDAO attibuteDAOIn = {
        id: uuid,
        name: createAttributeRequest.name,
        description: createAttributeRequest.description
    };

    error? result = db:addAttribute(attibuteDAOIn);
    if (result is error) {
        return result;
    } else {
        db:AttributeDAO|error attributeDAOOut = db:getAttribute(uuid);
        if (attributeDAOOut is db:AttributeDAO) {
            CreateAttributeResponse createAttributeResponse = {
                attribute: {
                    id: <string>attributeDAOOut?.id,
                    name: attributeDAOOut.name,
                    description: attributeDAOOut.description,
                    created_at: <string>attributeDAOOut?.created_at
                }
            };
            return createAttributeResponse;
        } else {
            return attributeDAOOut;
        }
    }
}

function getTierForOrgFromCache(string orgId) returns GetTierDetailResponse|error {
    (string|error)? tierString = cache:getEntry(orgId);
    if (tierString is string) {
        json|error tierJson = tierString.fromJsonString();
        if (tierJson is json) {
            GetTierDetailResponse getTierDetailResponse = {
                tier: {
                    id: (check tierJson.id).toString(),
                    name: (check tierJson.name).toString(),
                    description: (check tierJson.description).toString(),
                    cost: (check tierJson.cost).toString(),
                    created_at: (check tierJson.created_at).toString(),
                    integration_quota: <int>(check tierJson.integration_quota),
                    service_quota: <int>(check tierJson.service_quota),
                    api_quota: <int>(check tierJson.api_quota),
                    remote_app_quota: <int>(check tierJson.remote_app_quota)
                }
            };
            return getTierDetailResponse;
        } else {
            log:printError("Error while parsing cached value to tier object.", cache = tierString, 'error = tierJson);
            return tierJson;    
        }
    } else {
        return error("Subscription corresponding to the organization id not available in the cache", orgId = orgId);
    }
}

function getTierForOrgFromDB(string orgId) returns GetTierDetailResponse|error {
    db:SubscriptionDAO|error subscriptionDAO = db:getSubscriptionForOrg(orgId);
    if (subscriptionDAO is db:SubscriptionDAO) {
        string tierId = subscriptionDAO.tier_id;
        db:Tier|error tier = db:getTier(tierId);
        if (tier is db:Tier) {
            Tier tierDTO = {
                id: <string>tier?.id,
                name: tier.name,
                description: tier.description,
                cost: tier.cost,
                created_at: <string>tier?.created_at,
                service_quota: <int>tier?.quota_limits?.service_quota,
                integration_quota: <int>tier?.quota_limits?.integration_quota,
                api_quota: <int>tier?.quota_limits?.api_quota,
                remote_app_quota: <int>tier?.quota_limits?.remote_app_quota
            };
            string|error entry = cache:setEntry(orgId, tierDTO.toString());
            GetTierDetailResponse getTierDetailResponse = { tier: tierDTO };
            return getTierDetailResponse;
        } else {
            return tier;
        }
    } else {
        return subscriptionDAO;
    } 
}
