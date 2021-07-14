// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/log;
import ballerina/uuid;
import choreo_subscriptions.clients;

public function getSubscriptionForOrg(string orgId) returns GetTierDetailResponse|error {
    GetTierDetailResponse|error getTierDetailResponse = getTierForOrgFromCache(orgId);
    if (getTierDetailResponse is GetTierDetailResponse) {
        return getTierDetailResponse;
    } else {
        return getTierForOrgFromDB(orgId);
    }
}

public function createTier(CreateTierRequest createTierRequest) returns CreateTierResponse|error {
    string uuid = uuid:createType1AsString();
    clients:TierDAO tierDAOIn = {
        id: uuid,
        name: createTierRequest.name,
        description: createTierRequest.description,
        cost: createTierRequest.cost
    };

    error? result = clients:addTierToDB(tierDAOIn);
    if (result is error) {
        return result;
    } else {
        clients:TierDAO|error tierDAOOut = clients:getTierFromDB(uuid);
        if (tierDAOOut is clients:TierDAO) {
            CreateTierResponse createTierResponse = {
                tier_meta_data: {
                    id: <string>tierDAOOut?.id,
                    name: tierDAOOut.name,
                    description: tierDAOOut.description,
                    cost: tierDAOOut.cost,
                    created_at: <string>tierDAOOut?.created_at
                }
            };
            return createTierResponse;
        } else {
            return tierDAOOut;
        }
    }
}

public function createSubscription(CreateSubscriptionRequest createSubscriptionRequest) returns
        CreateSubscriptionResponse|error {
    string uuid = uuid:createType1AsString();
    clients:SubscriptionDAO subscriptionDAOin = {
        id: uuid,
        org_id: createSubscriptionRequest.org_id,
        tier_id: createSubscriptionRequest.tier_id,
        billing_date: createSubscriptionRequest.billing_date,
        status: createSubscriptionRequest.status
    };
    
    error? result = clients:addSubscriptionToDB(subscriptionDAOin);
    if (result is error) {
        return result;
    } else {
        clients:SubscriptionDAO|error subscriptionDAOOut = clients:getSubscriptionFromDB(uuid);
        if (subscriptionDAOOut is clients:SubscriptionDAO) {
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

public function createQuotaRecord(CreateQuotaRecordRequest createQuotaRecordRequest) returns
        CreateQuotaRecordResponse|error {
    clients:QuotaRecord quotaRecordIn = {
        tier_id: createQuotaRecordRequest.tier_id,
        attribute_name: createQuotaRecordRequest.attribute_name,
        threshold: createQuotaRecordRequest.threshold
    };

    error? result = clients:addQuotaRecordToDB(quotaRecordIn);
    if (result is error) {
        return result;
    } else {
        CreateQuotaRecordResponse createQuotaRecordRespone = {
            quota_record: {
                tier_id: <string>quotaRecordIn?.tier_id,
                attribute_name: quotaRecordIn.attribute_name,
                threshold: quotaRecordIn.threshold
            }
        };
        return createQuotaRecordRespone;
    }
}

public function createAttribute(CreateAttributeRequest createAttributeRequest) returns CreateAttributeResponse|error {
    string uuid = uuid:createType1AsString();
    clients:AttributeDAO attibuteDAOIn = {
        id: uuid,
        name: createAttributeRequest.name,
        description: createAttributeRequest.description
    };

    error? result = clients:addAttributeToDB(attibuteDAOIn);
    if (result is error) {
        return result;
    } else {
        clients:AttributeDAO|error attributeDAOOut = clients:getAttributeFromDB(uuid);
        if (attributeDAOOut is clients:AttributeDAO) {
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
    (string|error)? tierString = clients:getValueFromRedis(orgId);
    if (tierString is string) {
        json|error tierJson = tierString.fromJsonString();
        if (tierJson is json) {
            GetTierDetailResponse getTierDetailResponse = {
                tier: {
                    name: (check tierJson.name).toString(),
                    description: (check tierJson.description).toString(),
                    cost: (check tierJson.cost).toString(),
                    created_at: (check tierJson.created_at).toString(),
                    integration_quota: <int>(check tierJson.integration_quota),
                    service_quota: <int>(check tierJson.service_quota),
                    api_quota: <int>(check tierJson.api_quota)
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
    clients:SubscriptionDAO|error subscriptionDAO = clients:getSubscriptionForOrgFromDB(orgId);
    if (subscriptionDAO is clients:SubscriptionDAO) {
        string tierId = subscriptionDAO.tier_id;
        clients:TierDAO|error tierDAO = clients:getTierFromDB(tierId);
        if (tierDAO is clients:TierDAO) {
            clients:TierQuotas|error tierQuotas = clients:getTierQuotasFromDB(tierId);
            if (tierQuotas is clients:TierQuotas) {
                GetTierDetailResponse getTierDetailResponse = {
                    tier: {
                        id: <string>(<clients:TierDAO>tierDAO)?.id,
                        name: (<clients:TierDAO>tierDAO).name,
                        description: (<clients:TierDAO>tierDAO).description,
                        cost: (<clients:TierDAO>tierDAO).cost,
                        created_at: <string>(<clients:TierDAO>tierDAO)?.created_at,
                        integration_quota: (<clients:TierQuotas>tierQuotas).integration_quota,
                        service_quota: (<clients:TierQuotas>tierQuotas).service_quota,
                        api_quota: (<clients:TierQuotas>tierQuotas).api_quota
                    }
                };
                return getTierDetailResponse;
            } else {
                return tierQuotas;
            }
        } else {
            return tierDAO;
        }
    } else {
        return subscriptionDAO;
    } 
}
