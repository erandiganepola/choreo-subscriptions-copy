// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/log;
import ballerina/uuid;
import choreo_subscriptions.asb;
import choreo_subscriptions.db;
import choreo_subscriptions.cache;
import choreo_subscriptions.utils;
import choreo_subscriptions.rpc;

# Returns the list of available tiers
#
# + internal - Internal tiers flag
# + return - Tier list with count  
public function getTiers(boolean internal) returns rpc:GetTiersResponse|error {
    log:printDebug("Getting list of tiers", is_internal = internal);
    return getTiersFromDB(internal);
}

# Returns the subscribed tier object for the given organization uuid
#
# + orgId - uuid of the interested organization
# + return - Subscribed tier object
public function getTierDetailsForOrgId(string orgId) returns rpc:GetTierDetailResponse|error {
    log:printDebug("Getting subscribed tier details for the organization", orgUuid = orgId);
    rpc:GetTierDetailResponse|error getTierDetailResponse = getTierForOrgFromCache(orgId);
    if (getTierDetailResponse is rpc:GetTierDetailResponse) {
        return getTierDetailResponse;
    } else {
        return getTierForOrgIdFromDB(orgId);
    }
}

# Returns the subscribed tier object for the given organization handle
#
# + orgHandle - Handle of the interested organization
# + return - Subscribed tier object
public function getTierDetailsForOrgHandle(string orgHandle) returns rpc:GetTierDetailResponse|error {
    log:printDebug("Getting subscribed tier details for the organization", orgHandle = orgHandle);
    rpc:GetTierDetailResponse|error getTierDetailResponse = getTierForOrgFromCache(orgHandle);
    if (getTierDetailResponse is rpc:GetTierDetailResponse) {
        return getTierDetailResponse;
    } else {
        return getTierForOrgHandleFromDB(orgHandle);
    }
}

# Returns the subscription object for the given subscription id
#
# + subscriptionId - Id of the interested subscription
# + return - Subscription object requested
public function getSubscription(string subscriptionId) returns rpc:GetSubscriptionResponse|error {
    log:printDebug("Getting subscription details for the subscription id", subscriptionId = subscriptionId);
    db:SubscriptionDAO|error subscription = db:getSubscription(subscriptionId);
    if (subscription is db:SubscriptionDAO) {
        rpc:GetSubscriptionResponse getSubscriptionResponse = {
            subscription: {
                id: <string>subscription?.id,
                org_id: subscription.org_id,
                org_handle: subscription.org_handle,
                tier_id: subscription.tier_id,
                billing_date: subscription.billing_date,
                status: subscription.status,
                is_paid: subscription.is_paid,
                step_quota: subscription.step_quota
            }
        };
        return getSubscriptionResponse;
    } else {
        return subscription;
    }
}

# Returns the subscription object for the given organization uuid
#
# + orgId - Id of the interested organization
# + return - Subscription object requested
public function getSubscriptionByOrgId(string orgId) returns rpc:GetSubscriptionResponse|error {
    log:printDebug("Getting subscription details for the organization uuid", orgId = orgId);
    db:SubscriptionDAO|error subscription = db:getSubscriptionForOrgId(orgId);
    if (subscription is db:SubscriptionDAO) {
        rpc:GetSubscriptionResponse getSubscriptionResponse = {
            subscription: {
                id: <string>subscription?.id,
                org_id: subscription.org_id,
                org_handle: subscription.org_handle,
                tier_id: subscription.tier_id,
                billing_date: subscription.billing_date,
                status: subscription.status,
                is_paid: subscription.is_paid,
                step_quota: subscription.step_quota
            }
        };
        return getSubscriptionResponse;
    } else {
        return subscription;
    }
}

# Returns the subscription object for the given organization handle
#
# + orgHandle - Handle of the interested organization
# + return - Subscription object requested
public function getSubscriptionByOrgHandle(string orgHandle) returns rpc:GetSubscriptionResponse|error {
    log:printDebug("Getting subscription details for the organization handle", orgHandle = orgHandle);
    db:SubscriptionDAO|error subscription = db:getSubscriptionForOrgHandle(orgHandle);
    if (subscription is db:SubscriptionDAO) {
        rpc:GetSubscriptionResponse getSubscriptionResponse = {
            subscription: {
                id: <string>subscription?.id,
                org_id: subscription.org_id,
                org_handle: subscription.org_handle,
                tier_id: subscription.tier_id,
                billing_date: subscription.billing_date,
                status: subscription.status,
                is_paid: subscription.is_paid,
                step_quota: subscription.step_quota
            }
        };
        return getSubscriptionResponse;
    } else {
        return subscription;
    }
}

# Returns the subscription tier mapping object for the given organization uuid
#
# + orgId - UUID of the interested organization
# + return - Subscription tier mapping object
public function getSubscriptionTierMappingForOrgId(string orgId) returns rpc:SubscriptionTierMappingResponse|error {
    db:SubscriptionTierMapping|error subscriptionTierMapping = db:getSubscriptionTierMappingForOrgId(orgId);
    if (subscriptionTierMapping is db:SubscriptionTierMapping) {
        rpc:SubscriptionTierMappingResponse subscriptionTierMappingResponse = {
            subscription_tier_mapping: {
                org_id: subscriptionTierMapping.org_id,
                org_handle: subscriptionTierMapping.org_handle,
                tier_id: subscriptionTierMapping.tier_id,
                tier_name: subscriptionTierMapping.tier_name,
                billing_date: subscriptionTierMapping.billing_date,
                is_paid: subscriptionTierMapping.is_paid,
                step_quota: subscriptionTierMapping.step_quota
            }
        };
        return subscriptionTierMappingResponse;
    } else {
        return subscriptionTierMapping;
    }
}

# Returns a list of subscription tier mappings with pagination
#
# + offset - The offset value where the pagination start from
# + limit - Number of objects need to be returned
# + return - List of subscription tier object, pagination params
public function getSubscriptionTierMappings(int offset, int 'limit) returns rpc:SubscriptionTierMappingsResponse|error {
    int|error subscriptionCount = db:getSubscriptionsCount();
    if (subscriptionCount is int) {
        db:SubscriptionTierMapping[]|error subscriptionTierMappings = db:getSubscriptionTierMappings(offset, 'limit);
        if (subscriptionTierMappings is db:SubscriptionTierMapping[]) {
            int length = subscriptionTierMappings.length();
            rpc:SubscriptionTierMapping[] paginatedSubscriptions = [];
            foreach var i in 0 ..< length {
                db:SubscriptionTierMapping subTierMapping = subscriptionTierMappings[i];
                rpc:SubscriptionTierMapping subTierMappingDTO = {
                    org_id: subTierMapping.org_id,
                    org_handle: subTierMapping.org_handle,
                    tier_id: subTierMapping.tier_id,
                    tier_name: subTierMapping.tier_name,
                    billing_date: subTierMapping.billing_date,
                    is_paid: subTierMapping.is_paid,
                    step_quota: subTierMapping.step_quota
                };
                paginatedSubscriptions[i] = subTierMappingDTO;
            }

            rpc:SubscriptionTierMappingsResponse subscriptionTierMappingsResponse = {
                subscription_tier_mappings: {
                    subscription_tier_mappings: paginatedSubscriptions
                },
                pagination: {
                    offset: offset,
                    'limit: 'limit,
                    total: subscriptionCount
                }
            };
            return subscriptionTierMappingsResponse;
        } else {
            return subscriptionTierMappings;
        }
    } else {
        return subscriptionCount;
    }
}

# Returns a list of organization id subscription item id mappings with pagination
#
# + offset - The offset value where the pagination start from
# + limit - Number of objects need to be returned
# + return - List of org_id subscription_item_id mappings object, pagination params  
public function getOrgIdSubItemIdMappings(int offset, int 'limit) returns rpc:GetOrgIdSubItemIdMappingsResponse|error {
    log:printDebug("Getting organization id, subscription item id mappings", offset = offset, 'limit = 'limit);
    int|error subscriptionCount = db:getPaidSubscriptionsCount();
    if (subscriptionCount is int) {
        db:OrgIdSubItemIdMapping[]|error orgIdSubItemIdMappings = db:getOrgIdSubItemIdMappings(offset, 'limit);
        if (orgIdSubItemIdMappings is db:OrgIdSubItemIdMapping[]) {
            rpc:GetOrgIdSubItemIdMappingsResponse orgIdSubItemIdMappingsResponse = {
                org_sub_item_id_mappings: {
                    org_sub_item_id_mappings: orgIdSubItemIdMappings
                },
                pagination: {
                    offset: offset,
                    'limit: 'limit,
                    total: subscriptionCount
                }
            };
            return orgIdSubItemIdMappingsResponse;
        } else {
            return orgIdSubItemIdMappings;
        }
    } else {
        return subscriptionCount;
    }
}

# Creates a new subscription object
#
# + createSubscriptionRequest - The subscription object need to be created
# + return - created subscription object
public function createSubscription(rpc:CreateSubscriptionRequest createSubscriptionRequest) returns 
        rpc:CreateSubscriptionResponse|error {
    log:printDebug("Creating a subscription with the given values", orgId = createSubscriptionRequest.subscription.org_id, 
        tierId = createSubscriptionRequest.subscription.tier_id);
    string uuid = uuid:createType1AsString();
    db:SubscriptionDAO subscriptionDAOin = {
        id: uuid,
        org_id: createSubscriptionRequest.subscription.org_id,
        org_handle: createSubscriptionRequest.subscription.org_handle,
        tier_id: createSubscriptionRequest.subscription.tier_id,
        billing_date: createSubscriptionRequest.subscription.billing_date,
        status: createSubscriptionRequest.subscription.status,
        is_paid: createSubscriptionRequest.subscription.is_paid,
        step_quota: createSubscriptionRequest.subscription.step_quota
    };

    error? result = db:addSubscription(subscriptionDAOin);
    if (result is error) {
        return result;
    } else {
        db:SubscriptionDAO|error subscriptionDAOOut = db:getSubscription(uuid);
        if (subscriptionDAOOut is db:SubscriptionDAO) {
            rpc:CreateSubscriptionResponse createSubscriptionResponse = {
                subscription: {
                    id: <string>subscriptionDAOOut?.id,
                    org_id: subscriptionDAOOut.org_id,
                    org_handle: subscriptionDAOOut.org_handle,
                    tier_id: subscriptionDAOOut.tier_id,
                    billing_date: subscriptionDAOOut.billing_date,
                    status: subscriptionDAOOut.status,
                    is_paid: subscriptionDAOOut.is_paid,
                    step_quota: subscriptionDAOOut.step_quota,
                    created_at: <int>subscriptionDAOOut?.created_at
                }
            };
            return createSubscriptionResponse;
        } else {
            return subscriptionDAOOut;
        }
    }
}

# Updates an existing subscription object in the database
#
# + updateSubscriptionRequest - The subscription object with new attributes
# + return - updated subscription object
public function updateSubscription(rpc:UpdateSubscriptionRequest updateSubscriptionRequest) returns 
        rpc:UpdateSubscriptionResponse|error {
    // TODO : This method need to be updated to identify this is a subscription upgrade method
    string orgId = updateSubscriptionRequest.subscription.org_id;
    string orgHandle = updateSubscriptionRequest.subscription.org_handle;
    log:printDebug("Updating a subscription in the database", orgId = orgId, orgHandle = orgHandle);
    db:SubscriptionDAO subscriptionDAOin = {
        id: updateSubscriptionRequest.subscription.id,
        org_id: orgId,
        org_handle: orgHandle,
        tier_id: updateSubscriptionRequest.subscription.tier_id,
        subscription_item_id: updateSubscriptionRequest.subscription.subscription_item_id,
        billing_date: updateSubscriptionRequest.subscription.billing_date,
        status: updateSubscriptionRequest.subscription.status,
        is_paid: updateSubscriptionRequest.subscription.is_paid,
        step_quota: updateSubscriptionRequest.subscription.step_quota
    };

    error? result = db:updateSubscription(subscriptionDAOin);
    if (result is error) {
        return result;
    } else {
        int monthOfYear = utils:getMonthOfYear(billingDay);
        db:ThresholdEventStatusDAO|()|error thresholdEventStatus = db:getThresholdEventStatusForOrgId(orgId, monthOfYear);
        if (thresholdEventStatus is db:ThresholdEventStatusDAO) {
            log:printDebug("Threshold event status exists", eventStatus = thresholdEventStatus);
            if (thresholdEventStatus.threshold_1_event_sent == 1 || thresholdEventStatus.threshold_2_event_sent == 1) {
                log:printDebug("Updating the threshold event status since the events are already sent");
                thresholdEventStatus.threshold_1_event_sent = 0;
                thresholdEventStatus.threshold_2_event_sent = 0;
                error? updateResult = db:updateThresholdEventStatus(thresholdEventStatus);

                if (updateResult is error) {
                    log:printError("Error occured while updating the subscription");
                    return error("Error occured while updating the subscription");
                }
            } else {
                log:printDebug("Skipped updating since threshold event is not yet sent", orgId = orgId);
            }
        } else if thresholdEventStatus is () {
            log:printDebug("Not updating threshold event status as that is not available for this organization", 
                orgId = orgId);
        } else {
            log:printError("Error occured while updating the subscription", 'error = thresholdEventStatus);
            return error("Error occured while updating the subscription");
        }

        error? asbClientError = asb:publishSubscriptionUpdateEvent(orgId, orgHandle);

        if (asbClientError is error) {
            return error("Error occured while sending subscription update event");
        } else {
            db:SubscriptionDAO|error subscriptionDAOOut = db:getSubscription(updateSubscriptionRequest.subscription.id);
            if (subscriptionDAOOut is db:SubscriptionDAO) {
                rpc:UpdateSubscriptionResponse updateSubscriptionResponse = {
                    subscription: {
                        id: <string>subscriptionDAOOut?.id,
                        org_id: subscriptionDAOOut.org_id,
                        org_handle: subscriptionDAOOut.org_handle,
                        tier_id: subscriptionDAOOut.tier_id,
                        billing_date: subscriptionDAOOut.billing_date,
                        status: subscriptionDAOOut.status,
                        is_paid: subscriptionDAOOut.is_paid,
                        step_quota: subscriptionDAOOut.step_quota,
                        created_at: <int>subscriptionDAOOut?.created_at
                    }
                };
                error? cacheResultByOrgHandle = cache:deleteEntry(subscriptionDAOOut.org_handle);
                error? cacheResultByOrgId = cache:deleteEntry(subscriptionDAOOut.org_id);
                return updateSubscriptionResponse;
            } else {
                return subscriptionDAOOut;
            }
        }
    }
}

# Deletes an existing subscription object in the database identified by id
#
# + subscriptionId - The id attribute of the subscription to be deleted
# + return - id of the deleted subscription
public function deleteSubscription(string subscriptionId) returns rpc:DeleteSubscriptionResponse|error {
    log:printDebug("Deleting a subscription in the database identified by id", subscriptionId = subscriptionId);
    log:printDebug("Getting the subscription from the database to get the orgHandle and invalidate the cache");
    db:SubscriptionDAO|error subscriptionDAO = db:getSubscription(subscriptionId);
    if (subscriptionDAO is db:SubscriptionDAO) {
        error? result = db:deleteSubscription(subscriptionId);
        if (result is error) {
            return result;
        } else {
            error? cacheResultByOrgHandle = cache:deleteEntry(subscriptionDAO.org_handle);
            error? cacheResultByOrgId = cache:deleteEntry(subscriptionDAO.org_id);
            return {
                identifier: subscriptionId
            };
        }
    } else {
        return error("Error occured while deleting subscription");
    }
}

# Deletes an existing subscription object in the database identified by organization uuid
#
# + orgId - The org uuid attribute of the subscription to be deleted
# + return - org uuid of the deleted subscription
public function deleteSubscriptionByOrgId(string orgId) returns rpc:DeleteSubscriptionResponse|error {
    log:printDebug("Deleting a subscription in the database identified by organization UUID", orgId = orgId);
    log:printDebug("Getting the subscription from the database to get the orgHandle and invalidate the cache");
    db:SubscriptionDAO|error subscriptionDAO = db:getSubscriptionForOrgId(orgId);
    if (subscriptionDAO is db:SubscriptionDAO) {
        error? result = db:deleteSubscriptionByOrgId(orgId);
        if (result is error) {
            return result;
        } else {
            error? cacheResultByOrgHandle = cache:deleteEntry(subscriptionDAO.org_handle);
            error? cacheResultByOrgId = cache:deleteEntry(subscriptionDAO.org_id);
            return {
                identifier: orgId
            };
        }
    } else {
        return error("Error occured while deleting subscription");
    }
}

# Deletes an existing subscription object in the database identified by organization handle
#
# + orgHandle - The org handle attribute of the subscription to be deleted
# + return - org handle of the deleted subscription
public function deleteSubscriptionByOrgHandle(string orgHandle) returns rpc:DeleteSubscriptionResponse|error {
    log:printDebug("Deleting a subscription in the database identified by organization handle", orgHandle = orgHandle);
    error? result = db:deleteSubscriptionByOrgHandle(orgHandle);
    if (result is error) {
        return result;
    } else {
        error? cacheResult = cache:deleteEntry(orgHandle);
        return {
            identifier: orgHandle
        };
    }
}

# Creates a new attribute for rate limiting. Ex : number_of_organizations per user
#
# + createAttributeRequest - The attribute object needs to be created
# + return - The created attribute object
public function createAttribute(rpc:CreateAttributeRequest createAttributeRequest) returns rpc:CreateAttributeResponse|error {
    log:printDebug("Creating a tier attribute with the given metadata", attribute = createAttributeRequest.attribute);
    string uuid = uuid:createType1AsString();
    db:AttributeDAO attibuteDAOIn = {
        id: uuid,
        name: createAttributeRequest.attribute.name,
        description: createAttributeRequest.attribute.description
    };

    error? result = db:addAttribute(attibuteDAOIn);
    if (result is error) {
        return result;
    } else {
        db:AttributeDAO|error attributeDAOOut = db:getAttribute(uuid);
        if (attributeDAOOut is db:AttributeDAO) {
            rpc:CreateAttributeResponse createAttributeResponse = {
                attribute: {
                    id: <string>attributeDAOOut?.id,
                    name: attributeDAOOut.name,
                    description: attributeDAOOut.description,
                    created_at: <int>attributeDAOOut?.created_at
                }
            };
            return createAttributeResponse;
        } else {
            return attributeDAOOut;
        }
    }
}

function getTierForOrgFromCache(string orgIdentifier) returns rpc:GetTierDetailResponse|error {
    (string|error)? tierString = cache:getEntry(orgIdentifier);
    if (tierString is string) {
        json|error tierJson = tierString.fromJsonString();
        if (tierJson is json) {
            rpc:GetTierDetailResponse getTierDetailResponse = {
                tier: {
                    id: (check tierJson.id).toString(),
                    name: (check tierJson.name).toString(),
                    description: (check tierJson.description).toString(),
                    is_paid: check tierJson.is_paid,
                    created_at: <int>(check tierJson.created_at),
                    running_app_quota: <int>(check tierJson.quota_limits?.running_app_quota),
                    component_quota: <int>(check tierJson.quota_limits?.component_quota)
                }
            };
            return getTierDetailResponse;
        } else {
            log:printError("Error while parsing cached value to tier object.", cache = tierString, 'error = tierJson);
            return tierJson;
        }
    } else {
        return error("Subscription corresponding to the organization id not available in the cache", orgIdentifier = orgIdentifier);
    }
}

function getTierForOrgIdFromDB(string orgId) returns rpc:GetTierDetailResponse|error {
    db:SubscriptionDAO|error subscriptionDAO = db:getSubscriptionForOrgId(orgId);
    if (subscriptionDAO is db:SubscriptionDAO) {
        string tierId = subscriptionDAO.tier_id;
        db:Tier|error tier = db:getTier(tierId);
        if (tier is db:Tier) {
            rpc:Tier tierDTO = {
                id: <string>tier?.id,
                name: tier.name,
                description: tier.description,
                is_paid: <boolean>tier?.is_paid,
                created_at: <int>tier?.created_at,
                running_app_quota: <int>tier?.quota_limits?.running_app_quota,
                component_quota: <int>tier?.quota_limits?.component_quota
            };
            string|error entry = cache:setEntry(orgId, tierDTO.toString());
            rpc:GetTierDetailResponse getTierDetailResponse = {tier: tierDTO};
            return getTierDetailResponse;
        } else {
            return tier;
        }
    } else {
        return subscriptionDAO;
    }
}

function getTiersFromDB(boolean internal) returns rpc:GetTiersResponse|error {
    //get tiers from database
    rpc:Tier[] apiTiers = [];
    int tierCount = 0;
    db:Tier[]|error tiers = db:getTiers(internal);
    if (tiers is db:Tier[]) {
        foreach db:Tier tier in tiers {
            rpc:Tier tierDTO = {
                id: <string>tier?.id,
                name: tier.name,
                description: tier.description,
                is_paid: <boolean>tier?.is_paid,
                created_at: tier.created_at,
                running_app_quota: <int>tier?.quota_limits?.running_app_quota,
                component_quota: <int>tier?.quota_limits?.component_quota
            };
            apiTiers[tierCount] = tierDTO;
            tierCount += 1;
        }
        rpc:GetTiersResponse getTiersResponse = {
            count: tierCount,
            list: apiTiers
        };
        return getTiersResponse;
    } else {
        log:printDebug("Error while retrieving tiers from the database.");
        return error("Error while retrieving tiers from the database.");
    }
}

function getTierForOrgHandleFromDB(string orgHandle) returns rpc:GetTierDetailResponse|error {
    db:SubscriptionDAO|error subscriptionDAO = db:getSubscriptionForOrgHandle(orgHandle);
    if (subscriptionDAO is db:SubscriptionDAO) {
        string tierId = subscriptionDAO.tier_id;
        db:Tier|error tier = db:getTier(tierId);
        if (tier is db:Tier) {
            rpc:Tier tierDTO = {
                id: <string>tier?.id,
                name: tier.name,
                description: tier.description,
                is_paid: <boolean>tier?.is_paid,
                created_at: tier.created_at,
                running_app_quota: <int>tier?.quota_limits?.running_app_quota,
                component_quota: <int>tier?.quota_limits?.component_quota
            };
            string|error entry = cache:setEntry(orgHandle, tierDTO.toString());
            rpc:GetTierDetailResponse getTierDetailResponse = {tier: tierDTO};
            return getTierDetailResponse;
        } else {
            return tier;
        }
    } else {
        return subscriptionDAO;
    }
}

public function getDailyStepUsageForOrg(rpc:GetTotalStepCountRequest totalStepCountRequest) returns rpc:GetTotalStepCountResponse|error {
    log:printDebug("Getting daily step usage details for the organization ", organizationId = totalStepCountRequest.org_identifier);
    db:TotalStepCountDAO[]|error totalStepCount = db:getDailyTotalStepCountForOrg(totalStepCountRequest.org_identifier, 
        totalStepCountRequest.start_date, totalStepCountRequest.end_date);
    if totalStepCount is db:TotalStepCountDAO[] {
        rpc:TotalStepCount[] totalStepCountList = totalStepCount;
        rpc:GetTotalStepCountResponse response = {
            total_step_count: totalStepCountList
        };
        return response;
    } else {
        return totalStepCount;
    }
}
