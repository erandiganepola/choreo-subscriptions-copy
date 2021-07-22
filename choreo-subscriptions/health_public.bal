// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/http;
import ballerina/log;
import choreo_subscriptions.config;
import choreo_subscriptions.health;
import choreo_subscriptions.utils;

isolated int hcPrevStatus = http:STATUS_OK;
isolated int hcPrevTimestamp = utils:getTimestampInMillis();
final int HC_CACHED_TIME_DURATION = config:HC_CACHED_TIME_DURATION;

# Health check endpoint to be used externally
service /subscriptions on new http:Listener(9092) {

    isolated resource function get healthz(http:Caller caller, http:Request req) {
        int now = utils:getTimestampInMillis();
        int status;
        int timeDuration;
        lock {
            status = hcPrevStatus;
        }
        lock {
            timeDuration = now - hcPrevTimestamp;
        }
        if (timeDuration > HC_CACHED_TIME_DURATION) {
            status = health:getOverallHealthStatus();
            lock {
                hcPrevTimestamp = now;
            }
            lock {
                hcPrevStatus = status;
            }
        }
        http:Response res = new;
        res.statusCode = status;
        if (status == http:STATUS_OK) {
            res.setJsonPayload({status: "OK"});
        } else {
            res.setJsonPayload({status: "ERROR"});
        }
        var result = caller->respond(res);
        if (result is error) {
            log:printError("error occurred while responding to external health check request ", result);
        }
    }
}
