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
    maxOpenConnections: config:jdbcConnection.poolSize,
    minIdleConnections: config:jdbcConnection.minIdle
};

jdbc:Options options = {
    properties: {
        "loginTimeout": config:jdbcConnection.loginTimeout,
        "useSSL": config:jdbcConnection.useSsl
    }
};

jdbc:Client choreoDbClient = check new (
    config:jdbcConnection.url,
    config:jdbcConnection.user,
    config:jdbcConnection.password,
    connectionPool = connPool,
    options = options
);

public function getTierForOrgFromDB(string orgId) returns Tier|error? {
    string tierId = "";
    sql:ParameterizedQuery tierQuery = `SELECT tier_id FROM subscription WHERE org_id=${orgId}`;
    stream<record{}, error> tierResult = choreoDbClient->query(tierQuery);
    record {|record {} value;|}|error? tierRecord = tierResult.next();
    if (tierRecord is record {|record {} value;|}) {
        tierId = <string>tierRecord.value["tier_id"];
    } else {
        log:printError("Error retrieving data from the database.", 'error=tierRecord);
        return tierRecord;
    }
    error? closeError = tierResult.close();
    if (closeError is error) {
        log:printWarn("Error while closing connection. ", 'error=closeError);
    }

    Tier tier = {};
    TierDAO|error? tierDAO = getTierFromDB(tierId);
    if (tierDAO is error) {
        return tierDAO;
    } else {
        tier.name = (<TierDAO>tierDAO).name;
        tier.description = (<TierDAO>tierDAO).description;
        tier.cost = (<TierDAO>tierDAO).cost;
        tier.created_at = (<TierDAO>tierDAO).name;
    }

    TierQuotas|error? tierQuotas = getTierQuotasFromDB(tierId);
    if (tierQuotas is error) {
        return tierQuotas;
    } else {
        tier.integration_quota = (<TierQuotas>tierQuotas).integration_quota;
        tier.service_quota = (<TierQuotas>tierQuotas).service_quota;
        tier.api_quota = (<TierQuotas>tierQuotas).api_quota;
    }
    return tier;
}

public function getTierFromDB(string tierId) returns TierDAO|error? {
    TierDAO|error? tierDAO;
    sql:ParameterizedQuery tierQuery = `SELECT name, description, cost, created_at FROM tier WHERE id=${tierId}`;
    stream<record{}, error> tierResult = choreoDbClient->query(tierQuery, TierDAO);
    record {|record {} value;|}|error? tierRecord = tierResult.next();

    error? closeErr = tierResult.close();
    if (closeErr is error) {
        log:printWarn("Error while closing connection.", 'error=closeErr);
    }

    if (tierRecord is record {|record {} value;|}) {
        tierDAO = <TierDAO>tierRecord.value;
    } else {
        log:printError("Error retrieving tier from the database.", tierId=tierId, 'error=tierRecord);
        tierDAO = tierRecord;
    }
    
    return tierDAO;
}

public function getTierQuotasFromDB(string tierId) returns TierQuotas|error? {
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
