// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/sql;
import ballerina/log;
import ballerinax/java.jdbc;

sql:ConnectionPool stepDbConnPool = {
    maxOpenConnections: poolSize,
    minIdleConnections: minIdle
};

jdbc:Options stepDbOptions = {
    properties: {
        "loginTimeout": loginTimeout,
        "useSSL": useSsl
    }
};

jdbc:Client stepDbClient = check getStepDbClient();

function getStepDbClient() returns jdbc:Client|error {
    return new (
        url, 
        user, 
        password, 
        connectionPool = stepDbConnPool, 
        options = stepDbOptions
    );
}

# Retrieve the threshold event status whether it sent for a given organization for a given month
#
# + orgId - The org UUID of the interested organization
# + month - The month of year the billing is concerned
# + return - The threshold event status object
public function getThresholdEventStatusForOrgId(string orgId, int month) returns ThresholdEventStatusDAO|()|error {
    log:printDebug("Getting threshold event status for the organization uuid from the database", orgId = orgId, month = month);
    sql:ParameterizedQuery thresholdEventStatusQuery = `SELECT org_uuid, billing_month, threshold_1_event_sent,
        threshold_2_event_sent, billing_cycle_reset FROM threshold_event_status WHERE org_uuid = ${orgId} AND
        billing_month = ${month}`;
    stream<record {}, error?> resultStream = stepDbClient->query(thresholdEventStatusQuery);
    var result = resultStream.next();

    error? closeError = resultStream.close();
    if (closeError is error) {
        log:printWarn("Error while closing database connection", 'error = closeError);
    }

    if result is error {
        log:printError("Error retrieving threshold event status for org uuid from the database.", 'error = result);
        return error("Error retrieving threshold event status from the database.");
    } else if result is () {
        log:printDebug("Threshold event status is not available for the organization", orgId = orgId, month = month);
        return ();
    } else {
        log:printDebug("Successfully retrieved threshold event status for org handle from the database", 
            orgId = orgId);
        return {
            org_uuid: <string>(result.value["org_uuid"]),
            billing_month: <int>(result.value["billing_month"]),
            threshold_1_event_sent: (<boolean>result.value["threshold_1_event_sent"]) ? 1 : 0,
            threshold_2_event_sent: (<boolean>result.value["threshold_2_event_sent"]) ? 1 : 0,
            billing_cycle_reset: (<boolean>result.value["billing_cycle_reset"]) ? 1 : 0
        };
    }
}

# Updates the threshold event status object
#
# + thresholdEventStatus - Threshold event status object with updated values
# + return - Error if happened during the database insertion
public function updateThresholdEventStatus(ThresholdEventStatusDAO thresholdEventStatus) returns error? {
    log:printDebug("Updating threshold event status", thresholdEventStatus = thresholdEventStatus);
    sql:ParameterizedQuery updateThresholdEventStatusQuery = `UPDATE threshold_event_status SET threshold_1_event_sent
        = ${thresholdEventStatus.threshold_1_event_sent}, threshold_2_event_sent = ${thresholdEventStatus
        .threshold_2_event_sent}, billing_cycle_reset = ${thresholdEventStatus.billing_cycle_reset} WHERE
        org_uuid = ${thresholdEventStatus.org_uuid} AND billing_month = ${thresholdEventStatus.billing_month}`;
    sql:ExecutionResult|sql:Error result = stepDbClient->execute(updateThresholdEventStatusQuery);

    if (result is sql:Error) {
        log:printError("Error while updating threshold event status in database.", eventStatus = thresholdEventStatus, 
            'error = result);
        return error("Error while updating threshold event status in database.");
    } else {
        log:printDebug("Successfully updated threshold event status in database.", eventStatus = thresholdEventStatus);
    }
}
