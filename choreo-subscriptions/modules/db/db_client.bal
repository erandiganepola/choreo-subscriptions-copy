// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/sql;
import ballerina/log;
import ballerinax/java.jdbc;
import choreo_subscriptions.config;

sql:ConnectionPool connPool = {
    maxOpenConnections: config:database.poolSize,
    minIdleConnections: config:database.minIdle
};

jdbc:Options options = {
    properties: {
        "loginTimeout": config:database.loginTimeout,
        "useSSL": config:database.useSsl
    }
};

jdbc:Client dbClient = check getClient();

function getClient() returns jdbc:Client|error {
    return new (
        config:database.url, 
        config:database.user, 
        config:database?.password, 
        connectionPool = connPool, 
        options = options
    );
}

# Retrieve the subscription for the given organization uuid from the DB
#
# + orgId - The id of the interested organization
# + return - The subscription object
public function getSubscriptionForOrgId(string orgId) returns SubscriptionDAO|error {
    log:printDebug("Getting subscription for the organization uuid from the database", orgId = orgId);
    sql:ParameterizedQuery subscriptionQuery = `SELECT id, org_id, org_handle, tier_id, billing_date, status, created_at
        FROM subscription WHERE org_id=${orgId}`;
    stream<record {}, error> subscriptionResult = dbClient->query(subscriptionQuery, SubscriptionDAO);
    stream<SubscriptionDAO, sql:Error> subscriptionStream = <stream<SubscriptionDAO, sql:Error>>subscriptionResult;
    record {|SubscriptionDAO value;|}|error? subscriptionRecord = subscriptionStream.next();

    error? closeError = subscriptionResult.close();
    if (closeError is error) {
        log:printWarn("Error while closing database connection", 'error = closeError);
    }

    if (subscriptionRecord is record {|SubscriptionDAO value;|}) {
        log:printDebug("Successfully retrieved subscription for organization uuid from the database", orgId = orgId);
        return subscriptionRecord.value;
    } else {
        log:printError("Error retrieving subscription for organization uuid from the database.", 
            'error = subscriptionRecord);
        return error("Error retrieving subscription from the database for orgId: " + orgId);
    }
}

# Retrieve the subscription for the given organization handle from the DB
#
# + orgHandle - The org handle of the interested organization
# + return - The subscription object
public function getSubscriptionForOrgHandle(string orgHandle) returns SubscriptionDAO|error {
    log:printDebug("Getting subscription for the organization handle from the database", orgHandle = orgHandle);
    sql:ParameterizedQuery subscriptionQuery = `SELECT id, org_id, org_handle, tier_id, billing_date, status, created_at
        FROM subscription WHERE org_handle=${orgHandle}`;
    stream<record {}, error> subscriptionResult = dbClient->query(subscriptionQuery, SubscriptionDAO);
    stream<SubscriptionDAO, sql:Error> subscriptionStream = <stream<SubscriptionDAO, sql:Error>>subscriptionResult;
    record {|SubscriptionDAO value;|}|error? subscriptionRecord = subscriptionStream.next();

    error? closeError = subscriptionResult.close();
    if (closeError is error) {
        log:printWarn("Error while closing database connection", 'error = closeError);
    }

    if (subscriptionRecord is record {|SubscriptionDAO value;|}) {
        log:printDebug("Successfully retrieved subscription for org handle from the database", orgHandle = orgHandle);
        return subscriptionRecord.value;
    } else {
        log:printError("Error retrieving subscription for org handle from the database.", 'error = subscriptionRecord);
        return error("Error retrieving subscription from the database for orgHandle: " + orgHandle);
    }
}

# Retrieve the subscription tier mapping for the given organization id from the DB
#
# + orgId - The uuid of the interested organization
# + return - The subscription tier mapping object 
public function getSubscriptionTierMappingForOrgId(string orgId) returns SubscriptionTierMapping|error {
    log:printDebug("Getting subscription tier mapping from the database", orgId = orgId);
    sql:ParameterizedQuery mappingQuery = `SELECT subscription.org_id, subscription.org_handle,
        subscription.billing_date, tier.id AS tier_id, tier.name AS tier_name, quota.attribute_name, quota.threshold
        FROM ((tier INNER JOIN quota ON tier.id = quota.tier_id) INNER JOIN subscription ON
        tier.id = subscription.tier_id) WHERE subscription.org_id = ${orgId} AND quota.attribute_name = 'step_quota'`;
    stream<record {}, error> mappingResult = dbClient->query(mappingQuery, SubscriptionTierJoin);
    stream<SubscriptionTierJoin, sql:Error> mappingStream = <stream<SubscriptionTierJoin, sql:Error>>mappingResult;
    record {|SubscriptionTierJoin value;|}|error? mappingRecord = mappingStream.next();

    error? closeErr = mappingStream.close();
    if (closeErr is error) {
        log:printWarn("Error occured while closing database connection.", 'error = closeErr);
    }

    if (mappingRecord is record {|SubscriptionTierJoin value;|}) {
        log:printDebug("Successfully retrieved subscription tier mapping for org uuid from the database", orgId = orgId);
        SubscriptionTierMapping subscriptionTierMapping = {
            org_id: mappingRecord.value.org_id,
            org_handle: mappingRecord.value.org_handle,
            tier_id: mappingRecord.value.tier_id,
            tier_name: mappingRecord.value.tier_name,
            billing_date: mappingRecord.value.billing_date,
            step_quota: mappingRecord.value.threshold
        };
        return subscriptionTierMapping;
    } else {
        log:printError("Error retrieving subscription tier mapping for org uuid from the database.", 
            'error = mappingRecord);
        return error("Error retrieving subscription from the database.");
    }
}

# Retrieve a list of subscription tier mappings with given offset and limit values
#
# + offset - The offset value from where the records to be retrieved
# + limit - The number of records required
# + return - Array of subscription tier mapping objects
public function getSubscriptionTierMappings(int offset, int 'limit) returns SubscriptionTierMapping[]|error {
    log:printDebug("Getting subscription tier mappings from the database", offset = offset, 'limit = 'limit);
    sql:ParameterizedQuery mappingsQuery = `SELECT subscription.org_id, subscription.org_handle, subscription
        .billing_date, tier.id AS tier_id, tier.name AS tier_name, quota.attribute_name, quota.threshold FROM ((tier
        INNER JOIN quota ON tier.id = quota.tier_id) INNER JOIN subscription ON tier.id = subscription.tier_id) WHERE
        quota.attribute_name = 'step_quota' ORDER BY subscription.org_id OFFSET ${offset} ROWS FETCH
        NEXT ${'limit} ROWS ONLY`;

    stream<record {}, error> mappingsResult = dbClient->query(mappingsQuery, SubscriptionTierJoin);
    stream<SubscriptionTierJoin, sql:Error> mappingsStream = <stream<SubscriptionTierJoin, sql:Error>>mappingsResult;

    SubscriptionTierMapping[] subscriptionTierMappings = [];
    int count = 0;
    error? loopError = mappingsStream.forEach(function(SubscriptionTierJoin subscriptionTierJoin) {
        SubscriptionTierMapping subscriptionTierMapping = {
            org_id: subscriptionTierJoin.org_id,
            org_handle: subscriptionTierJoin.org_handle,
            tier_id: subscriptionTierJoin.tier_id,
            tier_name: subscriptionTierJoin.tier_name,
            billing_date: subscriptionTierJoin.billing_date,
            step_quota: subscriptionTierJoin.threshold
        };
        subscriptionTierMappings[count] = subscriptionTierMapping;
        count += 1;
    });

    error? closeErr = mappingsStream.close();
    if (closeErr is error) {
        log:printWarn("Error occured while closing database connection.", 'error = closeErr);
    }

    if (loopError is error) {
        log:printError("Error occured while retrieving subscription tier mappings from the database.", 
            'error = loopError);
        return error("Error occured while retrieving subscription tier mappings.");
    } else {
        log:printDebug("Successfully retrieved the tier from the database");
        return subscriptionTierMappings;
    }
}

# Retrieves the number of subscriptions available in the DB
#
# + return - Number of subscriptions available in the DB
public function getSubscriptionsCount() returns int|error {
    log:printDebug("Getting the count of subscriptions from the database");
    sql:ParameterizedQuery subscriptionCountQuery = `SELECT COUNT(*) AS total FROM subscription`;
    stream<record {}, error?> subscriptionCountResult = dbClient->query(subscriptionCountQuery);
    record {|record {} value;|}|error? countResult = subscriptionCountResult.next();

    error? closeError = subscriptionCountResult.close();
    if (closeError is error) {
        log:printWarn("Error while closing database connection", 'error = closeError);
    }

    if (countResult is record {|record {} value;|}) {
        return <int>countResult.value["total"];
    } else {
        log:printError("Error occured while retrieving subsription count from the database", 'error = countResult);
        return error("Error occured while retrieving subsription count from the database");
    }
}

# Retrieves the subscription object with the given id from the database
#
# + subscriptionId - The id of the subscription interested in
# + return - The subscription object
public function getSubscription(string subscriptionId) returns SubscriptionDAO|error {
    log:printDebug("Getting subscription from the database", subscriptionId = subscriptionId);
    sql:ParameterizedQuery subscriptionQuery = `SELECT id, org_id, org_handle, tier_id, billing_date, status, created_at 
        FROM subscription WHERE id = ${subscriptionId}`;
    stream<record {}, error> subscriptionResult = dbClient->query(subscriptionQuery, SubscriptionDAO);
    stream<SubscriptionDAO, sql:Error> subscriptionStream = <stream<SubscriptionDAO, sql:Error>>subscriptionResult;
    record {|SubscriptionDAO value;|}|sql:Error subscription = subscriptionStream.next();

    error? closeErr = subscriptionStream.close();
    if (closeErr is error) {
        log:printWarn("Error while closing database connection.", 'error = closeErr);
    }

    if (subscription is record {|SubscriptionDAO value;|}) {
        log:printDebug("Successfully retrieved subscription from the database", subscriptionId = subscriptionId);
        return <SubscriptionDAO>subscription.value;
    } else {
        log:printError("Error while retrieving subscription details", id = subscriptionId, 'error = subscription);
        return error("Error while retrieving subscription details from the database for id: " + subscriptionId);
    }
}

# Retrieves the Attribute details for the given id from the database
#
# + attributeId - The id of the interested attribute
# + return - The attribute object
public function getAttribute(string attributeId) returns AttributeDAO|error {
    log:printDebug("Getting attribute from the database", attributeId = attributeId);
    sql:ParameterizedQuery attributeQuery = `SELECT id, name, description, created_at FROM attribute WHERE
        id=${attributeId}`;
    stream<record {}, error> attributeResult = dbClient->query(attributeQuery, AttributeDAO);
    stream<AttributeDAO, sql:Error> attributeStream = <stream<AttributeDAO, sql:Error>>attributeResult;
    record {|AttributeDAO value;|}|sql:Error attribute = attributeStream.next();

    error? closeErr = attributeStream.close();
    if (closeErr is error) {
        log:printWarn("Error while closing database connection.", 'error = closeErr);
    }

    if (attribute is record {|AttributeDAO value;|}) {
        log:printDebug("Successfully retrieved subscription from the database", attributeId = attributeId);
        return <AttributeDAO>attribute.value;
    } else {
        log:printError("Error while retrieving attribute details", id = attributeId, 'error = attribute);
        return error("Error while retrieving attribute details from the database for the attribute Id: " + attributeId);
    }
}

# Retrieves the tier object with the given id from the database
#
# + tierId - The id of the interested tier
# + return - The tier object
public function getTier(string tierId) returns Tier|error {
    log:printDebug("Getting tier from the database", tierId = tierId);
    sql:ParameterizedQuery tierQuery = `SELECT tier.id, tier.name, tier.description, tier.cost, tier.created_at,
        quota.attribute_name, quota.threshold FROM tier INNER JOIN quota ON tier.id = quota.tier_id WHERE
        tier.id = ${tierId}`;

    stream<record {}, error> tierResult = dbClient->query(tierQuery, TierQuotaJoin);
    stream<TierQuotaJoin, sql:Error> tierStream = <stream<TierQuotaJoin, sql:Error>>tierResult;

    Tier tier = {};
    TierQuotas tierQuotas = {};
    int count = 0;
    error? loopError = tierStream.forEach(function(TierQuotaJoin tierQuotaJoin) {
        if (count == 0) {
            tier = {
                id: tierQuotaJoin.id,
                name: tierQuotaJoin.name,
                description: tierQuotaJoin.description,
                cost: tierQuotaJoin.cost,
                created_at: tierQuotaJoin.created_at
            };
        }
        tierQuotas[tierQuotaJoin.attribute_name] = tierQuotaJoin.threshold;
        count += 1;
    });

    error? closeErr = tierStream.close();
    if (closeErr is error) {
        log:printWarn("Error occured while closing database connection.", 'error = closeErr);
    }

    if (loopError is error) {
        log:printError("Error occured while retrieving tier from the database.", tierId = tierId, 'error = loopError);
        return error("Error while getting tier resource quotas from the database for tier Id: " + tierId);
    } else {
        tier.quota_limits = tierQuotas;
        log:printDebug("Successfully retrieved the tier from the database", tierId = tierId);
        return tier;
    }
}

# Retrieves the list of tiers from the database
#
# + internal - Internal tiers flag
# + return - The list of all the Tier objects  
public function getTiers(boolean internal) returns Tier[]|error {
    Tier[] tiers = [];
    Tier tier = {};
    TierQuotas tierQuotas = {};
    string prevTierId = "";
    int uniqueRecordCount = 0;
    int quotaFieldCount = 0;
    sql:ParameterizedQuery tiersQuery;

    log:printDebug("Getting tiers from the database.", is_internal = internal);
    if (internal) {
        tiersQuery = `SELECT tier.id, tier.name, tier.description, tier.cost, tier.created_at,
        quota.attribute_name, quota.threshold FROM tier INNER JOIN quota ON tier.id = quota.tier_id WHERE
        tier.is_internal=1 ORDER BY cost`;
    } else {
        tiersQuery = `SELECT tier.id, tier.name, tier.description, tier.cost, tier.created_at,
        quota.attribute_name, quota.threshold FROM tier INNER JOIN quota ON tier.id = quota.tier_id WHERE
        tier.is_internal=0 ORDER BY cost`;
    }

    stream<record {}, error> tierResult = dbClient->query(tiersQuery, TierQuotaJoin);
    stream<TierQuotaJoin, sql:Error> tierStream = <stream<TierQuotaJoin, sql:Error>>tierResult;

    error? loopError = tierStream.forEach(function(TierQuotaJoin tierQuotaJoin) {
        if (tierQuotaJoin.id != prevTierId) {
            tier = {
                id: tierQuotaJoin.id,
                name: tierQuotaJoin.name,
                description: tierQuotaJoin.description,
                cost: tierQuotaJoin.cost,
                created_at: tierQuotaJoin.created_at
            };
            prevTierId = tierQuotaJoin.id;
        }
        if (tierQuotaJoin.attribute_name != config:REMOTE_APP_QUOTA) {
            tierQuotas[tierQuotaJoin.attribute_name] = tierQuotaJoin.threshold;
            quotaFieldCount += 1;
            if (quotaFieldCount == 5) {
                tier.quota_limits = tierQuotas;
                tiers[uniqueRecordCount] = tier;
                tierQuotas = {};
                uniqueRecordCount += 1;
                quotaFieldCount = 0;
            }
        }
    });

    error? closeErr = tierStream.close();
    if (closeErr is error) {
        log:printWarn("Error occured while closing database connection.", 'error = closeErr);
    }

    if (loopError is error) {
        log:printError("Error occured while retrieving tiers from the database.", 'error = loopError);
        return error("Error while getting tier resource quotas from the database.");
    } else {
        log:printDebug("Successfully retrieved tiers from the database.");
        return tiers;
    }
}

# Retrieves the limites attribute set and threshold from the database
#
# + tierId - The id of the interested tier
# + return - The tier quotas set
public function getTierQuotas(string tierId) returns TierQuotas|error {
    log:printDebug("Getting tier quotas from the database", tierId = tierId);
    TierQuotas tierQuotas = {};
    sql:ParameterizedQuery quotaQuery = `SELECT attribute_name, threshold FROM quota WHERE tier_id=${tierId}`;
    stream<record {}, error> quotaResult = dbClient->query(quotaQuery, QuotaRecord);
    stream<QuotaRecord, sql:Error> tierQuotasStream = <stream<QuotaRecord, sql:Error>>quotaResult;

    error? loopError = tierQuotasStream.forEach(function(QuotaRecord quotaRecord) {
        tierQuotas[quotaRecord.attribute_name] = quotaRecord.threshold;
    });

    error? closeErr = quotaResult.close();
    if (closeErr is error) {
        log:printWarn("Error while closing connection.", 'error = closeErr);
    }

    if (loopError is error) {
        log:printError("Error retrieving quota from the database.", tierId = tierId, 'error = loopError);
        return error("Error while getting tier quotas from the database for tier id: " + tierId);
    } else {
        log:printDebug("Successfully retrieved tier limits from the database", tierId = tierId);
        return tierQuotas;
    }
}

# Adds a tier to the database
#
# + tier - The tier object needs to be added
# + return - Error if happened during the database insertion
public function addTier(TierDAO tier) returns error? {
    log:printDebug("Adding tier to the database", tier = tier);
    sql:ParameterizedQuery addTierQuery = `INSERT INTO tier(id, name, description, cost) values (${tier?.id},
        ${tier.name}, ${tier.description}, ${tier.cost})`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(addTierQuery);

    if (result is sql:Error) {
        log:printError("Error while creating tier in database.", name = tier.name, 'error = result);
        return error("Error while creating tier in the database.");
    } else {
        log:printDebug("Successfully created the tier in database.", name = tier.name);
    }
}

# Adds a subscription to the database
#
# + subscription - The subscription object needs to be added to the database
# + return - Error if happened during the database insertion
public function addSubscription(SubscriptionDAO subscription) returns error? {
    log:printDebug("Adding subscription to the database", subscription = subscription);
    sql:ParameterizedQuery addSubscriptionQuery = `INSERT INTO subscription(id, org_id, org_handle, tier_id,
        billing_date, status) values(${subscription?.id}, ${subscription.org_id}, ${subscription.org_handle},
        ${subscription.tier_id}, ${subscription.billing_date}, ${subscription.status})`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(addSubscriptionQuery);

    if (result is sql:Error) {
        log:printError("Error while creating subscription.", org_id = subscription.org_id, 
            org_handle = subscription.org_handle, tier_id = subscription.tier_id, 'error = result);
        return error("Error while creating subscription in the database.");
    } else {
        log:printDebug("Successfully created the subscription in database.", org_id = subscription.org_id, 
            org_handle = subscription.org_handle, tier_id = subscription.tier_id);
    }
}

# Update a subscription available in the database
#
# + subscription - The subscription object with the updated properties
# + return - Error if happened during the database update
public function updateSubscription(SubscriptionDAO subscription) returns error? {
    log:printDebug("Updating the subscription in the database", orgId = subscription.org_id, 
        orgHandle = subscription.org_handle);
    sql:ParameterizedQuery updateSubscriptionQuery = `UPDATE subscription SET org_id = ${subscription.org_id},
        org_handle = ${subscription.org_handle}, tier_id = ${subscription.tier_id},
        billing_date = ${subscription.billing_date}, status = ${subscription.status}
        WHERE id = ${subscription?.id}`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(updateSubscriptionQuery);

    if (result is sql:Error) {
        log:printError("Error while updating subscription.", orgId = subscription.org_id, 
            orgHandle = subscription.org_handle, 'error = result);
        return error("Error while updating the subscription in the database");
    } else {
        log:printDebug("Successfully updated the subscription.", orgId = subscription.org_id, 
            orgHandle = subscription.org_handle);
    }
}

# Delete a subscription based on the subscription id
#
# + subscriptionId - The id of the subscription object to be deleted
# + return - Error if happened during the database deletion
public function deleteSubscription(string subscriptionId) returns error? {
    log:printDebug("Deleting the subscription in the database based on id", subscriptionId = subscriptionId);
    sql:ParameterizedQuery deleteSubscriptionQuery = `DELETE FROM subscription WHERE id = ${subscriptionId}`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(deleteSubscriptionQuery);

    if (result is sql:Error) {
        log:printError("Error while deleting the subscription identified by id.", subscriptionId = subscriptionId, 
            'error = result);
        return error("Error while deleting the subscription in the database");
    } else {
        log:printDebug("Successfully deleted the subscription.", subscriptionId = subscriptionId);
    }
}

# Delete a subscription based on the organization id
#
# + orgId - The organization uuid of the subscription object to be deleted
# + return - Error if happened during the database deletion
public function deleteSubscriptionByOrgId(string orgId) returns error? {
    log:printDebug("Deleting the subscription in the database based on orgId", orgId = orgId);
    sql:ParameterizedQuery deleteSubscriptionQuery = `DELETE FROM subscription WHERE org_id = ${orgId}`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(deleteSubscriptionQuery);

    if (result is sql:Error) {
        log:printError("Error while deleting the subscription identified by orgId.", orgId = orgId, 'error = result);
        return error("Error while deleting the subscription in the database");
    } else {
        log:printDebug("Successfully deleted the subscription.", orgId = orgId);
    }
}

# Delete a subscription based on the organization handle
#
# + orgHandle - The organization handle of the subscription object to be deleted
# + return - Error if happened during the database deletion
public function deleteSubscriptionByOrgHandle(string orgHandle) returns error? {
    log:printDebug("Deleting the subscription in the database based on orgHandle", orgHandle = orgHandle);
    sql:ParameterizedQuery deleteSubscriptionQuery = `DELETE FROM subscription WHERE org_handle = ${orgHandle}`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(deleteSubscriptionQuery);

    if (result is sql:Error) {
        log:printError("Error while deleting the subscription identified by orgHandle.", orgHandle = orgHandle, 
            'error = result);
        return error("Error while deleting the subscription in the database");
    } else {
        log:printDebug("Successfully deleted the subscription.", orgHandle = orgHandle);
    }
}

# Adds attribute object to the database
#
# + attribute - The object needs to be added to the database
# + return - Error if happened during the database insertion
public function addAttribute(AttributeDAO attribute) returns error? {
    log:printDebug("Adding attribute to the database", attribute = attribute);
    sql:ParameterizedQuery addAttributeQuery = `INSERT INTO attribute(id, name, description) values (${attribute?.id},
        ${attribute.name}, ${attribute.description})`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(addAttributeQuery);

    if (result is sql:Error) {
        log:printError("Error while creating quota attribute.", name = attribute.name, 'error = result);
        return error("Error while creating quota attribute in database");
    } else {
        log:printDebug("Successfully added the attribute.", name = attribute.name);
    }
}

# Adds a quota limit attribute, thresholds to the database
#
# + quotaRecord - The quota limit object needs to be added
# + return - Error if happened during the database insertion
public function addQuotaRecord(QuotaRecord quotaRecord) returns error? {
    log:printDebug("Adding quota limit to the database", quotaRecord = quotaRecord);
    sql:ParameterizedQuery addAttributeRecordQuery = `INSERT INTO quota(tier_id, attribute_name, threshold)
        values(${quotaRecord?.tier_id}, ${quotaRecord.attribute_name}, ${quotaRecord.threshold})`;
    sql:ExecutionResult|sql:Error result = dbClient->execute(addAttributeRecordQuery);

    if (result is sql:Error) {
        log:printError("Error while adding attribute to quota.", name = quotaRecord.attribute_name, 
            tier_id = quotaRecord?.tier_id, 'error = result);
        return error("Error while adding a quota attribute to the database");
    } else {
        log:printDebug("Successfully added new attribute to quota.", name = quotaRecord.attribute_name, 
            tier_id = quotaRecord?.tier_id);
    }
}

# Adds an array of quota limits to the database
#
# + quotaRecords - Array of quota limits need to be added
# + return - Error if happened during the database insertion
public function addQuotaRecords(QuotaRecord[] quotaRecords) returns error? {
    log:printDebug("Adding quoto limits to the database", quotaRecords = quotaRecords);
    boolean isRollbacked = false;
    boolean commitFailed = false;

    transaction {
        foreach QuotaRecord quotaRecord in quotaRecords {
            sql:ParameterizedQuery addQuotaRecordQuery = `INSERT INTO quota (tier_id, attribute_name, threshold)
                values (${quotaRecord?.tier_id}, ${quotaRecord.attribute_name}, ${quotaRecord.threshold})`;
            sql:ExecutionResult|sql:Error result = dbClient->execute(addQuotaRecordQuery);

            if (result is sql:Error) {
                log:printError("Adding tier quotas to the database failed. This transaction will be rollbacked", 
                    'error = result);
                isRollbacked = true;
                break;
            }
        }

        if (isRollbacked) {
            rollback;
        } else {
            error? err = commit;
            if (err is error) {
                log:printError("Error occured while commiting the transaction to add quota limits", 'error = err);
                commitFailed = true;
            } else {
                log:printDebug("Successfully added the quota records to the database");
            }
        }

    }

    if (isRollbacked || commitFailed) {
        return error("Error occured while adding tier quotas to the database", quotaRecords = quotaRecords);
    } else {
        log:printDebug("Successfully added quota records to the database");
    }
}
