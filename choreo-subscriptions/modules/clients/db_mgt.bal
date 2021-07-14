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

jdbc:Client choreoDbClient = check new (
    config:database.url,
    config:database.user,
    config:database.password,
    connectionPool = connPool,
    options = options
);

public function getSubscriptionForOrgFromDB(string orgId) returns SubscriptionDAO|error {
    sql:ParameterizedQuery subscriptionQuery = `SELECT id, org_id, tier_id, billing_date, status, created_at
        FROM subscription WHERE org_id=${orgId}`;
    stream<record {}, error> subscriptionResult = choreoDbClient->query(subscriptionQuery, SubscriptionDAO);
    stream<SubscriptionDAO, sql:Error> subscriptionStream = <stream<SubscriptionDAO, sql:Error>>subscriptionResult;
    record {| SubscriptionDAO value; |}|error? subscriptionRecord = subscriptionStream.next();

    error? closeError = subscriptionResult.close();
    if (closeError is error) {
        log:printWarn("Error while closing connection.", 'error=closeError);
    }

    if (subscriptionRecord is record {| SubscriptionDAO value; |}) {
        return subscriptionRecord.value;
    } else {
        log:printError("Error retrieving data from the database.", 'error = subscriptionRecord);
        return error("Error retrieving data from the database.");
    }
}

public function getSubscriptionFromDB(string subscriptionId) returns SubscriptionDAO|error {
    sql:ParameterizedQuery subscriptionQuery = `SELECT id, org_id, tier_id, billing_date, status, created_at 
        FROM subscription WHERE id = ${subscriptionId}`;
    stream<record{}, error> subscriptionResult = choreoDbClient->query(subscriptionQuery, SubscriptionDAO);
    stream<SubscriptionDAO, sql:Error> subscriptionStream = <stream<SubscriptionDAO, sql:Error>>subscriptionResult;
    record{| SubscriptionDAO value; |}|sql:Error subscription = subscriptionStream.next();

    error? closeErr = subscriptionStream.close();
    if (closeErr is error) {
        log:printWarn("Error while closing database connection.", 'error = closeErr);
    }

    if (subscription is record {| SubscriptionDAO value; |}) {
        return <SubscriptionDAO>subscription.value;
    } else {
        log:printError("Error while retrieving subscription details", id = subscriptionId, 'error = subscription);
        return subscription;
    }
}

public function getAttributeFromDB(string attributeId) returns AttributeDAO|error {
    sql:ParameterizedQuery attributeQuery = `SELECT id, name, description, created_at FROM attribute WHERE
        id=${attributeId}`;
    stream<record{}, error> attributeResult = choreoDbClient->query(attributeQuery, AttributeDAO);
    stream<AttributeDAO, sql:Error> attributeStream = <stream<AttributeDAO, sql:Error>>attributeResult;
    record {| AttributeDAO value; |}|sql:Error attribute = attributeStream.next();

    error? closeErr = attributeStream.close();
    if (closeErr is error) {
        log:printWarn("Error while closing database connection.", 'error = closeErr);
    }

    if (attribute is record {| AttributeDAO value; |}) {
        return <AttributeDAO>attribute.value;
    } else {
        log:printError("Error while retrieving attribute details", id = attributeId, 'error = attribute);
        return attribute;
    }
}

public function getTierFromDB(string tierId) returns TierDAO|error {
    sql:ParameterizedQuery tierQuery = `SELECT id, name, description, cost, created_at FROM tier WHERE id=${tierId}`;
    stream<record{}, error> tierResult = choreoDbClient->query(tierQuery, TierDAO);
    stream<TierDAO, sql:Error> tierStream = <stream<TierDAO, sql:Error>>tierResult;
    record {| TierDAO value; |}|error? tierRecord = tierStream.next();

    error? closeErr = tierResult.close();
    if (closeErr is error) {
        log:printWarn("Error while closing database connection.", 'error = closeErr);
    }

    if (tierRecord is record {| TierDAO value; |}) {
        return <TierDAO>tierRecord.value;
    } else {
        log:printError("Error retrieving tier from the database.", tierId = tierId, 'error = tierRecord);
        return error("Error retrieving tier from the database.");
    }
}

public function getTierQuotasFromDB(string tierId) returns TierQuotas|error {
    TierQuotas tierQuotas = {};
    sql:ParameterizedQuery quotaQuery = `SELECT attribute_name, threshold FROM quota WHERE tier_id=${tierId}`;
    stream<record{}, error> quotaResult = choreoDbClient->query(quotaQuery, QuotaRecord);
    stream<QuotaRecord, sql:Error> tierQuotasStream = <stream<QuotaRecord, sql:Error>>quotaResult;

    error? loopError = tierQuotasStream.forEach(function(QuotaRecord quotaRecord) {
        tierQuotas[quotaRecord.attribute_name] = quotaRecord.threshold;
    });

    error? closeErr = quotaResult.close();
    if (closeErr is error) {
        log:printWarn("Error while closing connection.", 'error=closeErr);
    }

    if (loopError is error) {
        log:printError("Error retrieving quota from the database.", tierId=tierId, 'error=loopError);
        return loopError;
    } else {
        return tierQuotas;
    }
}

public function addTierToDB(TierDAO tier) returns error? {
    sql:ParameterizedQuery addTierQuery = `INSERT INTO tier(id, name, description, cost) values (${tier?.id},
        ${tier.name}, ${tier.description}, ${tier.cost})`;
    sql:ExecutionResult|sql:Error result = choreoDbClient->execute(addTierQuery);

    if (result is sql:Error) {
        log:printError("Error while creating tier in database.", name = tier.name, 'error = result);
        return result;
    } else {
        log:printDebug("Successfully created the tier in database.", name = tier.name);
    }
}

public function addSubscriptionToDB(SubscriptionDAO subscription) returns error? {
    sql:ParameterizedQuery addSubscriptionQuery = `INSERT INTO subscription(id, org_id, tier_id, billing_date, status)
        values(${subscription?.id}, ${subscription.org_id}, ${subscription.tier_id}, ${subscription.billing_date},
        ${subscription.status})`;
    sql:ExecutionResult|sql:Error result = choreoDbClient->execute(addSubscriptionQuery);

    if (result is sql:Error) {
        log:printError("Error while creating subscription.", org_id = subscription.org_id,
            tier_id = subscription.tier_id, 'error = result);
        return result;
    } else {
        log:printDebug("Successfully created the subscription in database.", org_id = subscription.org_id,
            tier_id = subscription.tier_id);
    }
}

public function addAttributeToDB(AttributeDAO attribute) returns error? {
    sql:ParameterizedQuery addAttributeQuery = `INSERT INTO attribute(id, name, description) values (${attribute?.id},
        ${attribute.name}, ${attribute.description})`;
    sql:ExecutionResult|sql:Error result = choreoDbClient->execute(addAttributeQuery);

    if (result is sql:Error) {
        log:printError("Error while creating quota attribute.", name = attribute.name, 'error = result);
        return result;
    } else {
        log:printDebug("Successfully added the attribute.", name = attribute.name);
    }
}

public function addQuotaRecordToDB(QuotaRecord quotaRecord) returns error? {
    sql:ParameterizedQuery addAttributeRecordQuery = `INSERT INTO quota(tier_id, attribute_name, threshold)
        values(${quotaRecord?.tier_id}, ${quotaRecord.attribute_name}, ${quotaRecord.threshold})`;
    sql:ExecutionResult|sql:Error result = choreoDbClient->execute(addAttributeRecordQuery);

    if (result is sql:Error) {
        log:printError("Error while adding attribute to quota.", name = quotaRecord.attribute_name,
            tier_id = quotaRecord?.tier_id, 'error = result);
        return result;
    } else {
        log:printDebug("Successfully added new attribute to quota.", name = quotaRecord.attribute_name,
            tier_id = quotaRecord?.tier_id);
    }
}
