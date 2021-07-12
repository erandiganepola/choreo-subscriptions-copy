// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerinax/redis;
import ballerina/log;
import choreo_subscriptions.config;

redis:Client conn = check new ({
    host: config:redisClient.host,
    password: config:redisClient.password,
    options: {
        connectionPooling: config:redisClient.connectionPooling,
        isClusterConnection: config:redisClient.isClusterConnection,
        ssl: config:redisClient.enableSsl,
        startTls: config:redisClient.startTls,
        verifyPeer: config:redisClient.verifyPeer,
        database: config:redisClient.database,
        connectionTimeout: config:redisClient.connectionTimeout
    }
});

public function getValueFromRedis(string key) returns (string|error)? {
    var value = conn->get(key);
    if (value is ()) {
        log:printDebug("Cache miss.", key = key);
        return error("Cache miss.", key = key);
    } else if (value is string) {
        log:printDebug("Cache hits for key", key = key);
        return value;
    } else if (value is error) {
        log:printError("Error occured looking for chache.", key = key, 'error=value);
        return value;
    }
}

public function setValueInRedis(string key, string value) returns string|error {
    var stringSetresult = conn->set(key, value);
    if (stringSetresult is string) {
        log:printDebug("Reply from the redis server.", response = stringSetresult);
    } else {
        log:printError("Error occurred while storing the pair in redis.", key = key, value = value, 'error = stringSetresult);
    }
    return stringSetresult;
}
