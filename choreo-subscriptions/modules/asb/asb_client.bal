// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/log;
import ballerina/http;

http:Client asbClient = check new(url);

public function publishSubscriptionUpdateEvent(string orgUuid, string orgHandle) returns error? {
    map<string> headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": auth_token
    };

    http:Response|http:ClientError postResponse = asbClient->post("/billingcycleresetevent/messages?timeout=" + timeout.toString(), {
        "orgUuid": orgUuid,
        "orgHandle": orgHandle,
        "monthOfYear": 0
    }, headers = headers);
    
    if postResponse is http:Response {
        if postResponse.statusCode != 201 {
            string errMsg = string`Error while sending event to the azure service bus topic with status code ${
                postResponse.statusCode}`;
            log:printError(errMsg, statusCode=postResponse.statusCode, url = url);
            return error(errMsg, orgUuid = orgUuid, orgHandle = orgHandle);
        }
        log:printDebug("Successfully sent the event to the azure service bus", orgUuid = orgUuid, orgHandle = orgHandle);
    } else {
        string errMsg = "Error while sending event to azure service bus topic";
        log:printError(errMsg, postResponse);
        return error(errMsg, orgUuid = orgUuid, orgHandle = orgHandle);   
    }
}
