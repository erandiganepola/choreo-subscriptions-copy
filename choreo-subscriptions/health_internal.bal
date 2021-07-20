// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/http;
import ballerina/log;
import choreo_subscriptions.health;

// Health check endpoint to be used with Kubernetes readiness/liveness probes
service / on new http:Listener(9091) {

    isolated resource function get liveness(http:Caller caller, http:Request req) {
        var result = caller->respond("OK");
        if (result is error) {
            log:printError("error occurred while responding to liveness health check request ", result);
        }
    }

    isolated resource function get readiness(http:Caller caller, http:Request req) {
        http:Response res = new;
        res.statusCode = health:getOverallHealthStatus();
        if (res.statusCode == http:STATUS_OK) {
            res.setJsonPayload({status: "OK"});
        } else {
            res.setJsonPayload({status: "ERROR"});
        }
        var result = caller->respond(res);
        if (result is error) {
            log:printError("error occurred while responding to readiness health check request ", result);
        }
    }
}
