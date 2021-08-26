// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerinax/redis;
import ballerina/log;
import choreo_subscriptions.config;

redis:Client cacheClient = check new ({
    host: config:redisClient.host,
    password: <string>config:redisClient?.password,
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

# Retrieve the associated cache value in redis cache for a given key
#
# + cacheKey - Key value to search in the redis cache
# + return - Associated value with the key
public function getEntry(string cacheKey) returns (string|error)? {
    log:printDebug("Trying to get the cached value in redis for the key", key = getPrefixedKey(cacheKey));
    string key = getPrefixedKey(cacheKey);
    var value = cacheClient->get(key);
    if (value is ()) {
        log:printDebug("Cache miss.", key = key);
        return error("Cache miss.", key = key);
    } else if (value is string) {
        log:printDebug("Cache hits for key", key = key, value = value);
        return value;
    } else {
        log:printError("Error occured looking for cache.", key = key, 'error = value);
        return value;
    }
}

# Adds a value to the redis cache with the given key
#
# + cacheKey - The key for the pair need to be cached
# + value - The value need to be cached
# + return - Caching request result or error
public function setEntry(string cacheKey, string value) returns string|error {
    log:printDebug("Trying to add a key, value pair in redis", key = getPrefixedKey(cacheKey), value = value);
    string key = getPrefixedKey(cacheKey);
    var stringSetresult = cacheClient->set(key, value);
    if (stringSetresult is string) {
        log:printDebug("Successfully added entry to the cache. Reply from the redis server.",
            response = stringSetresult);
    } else {
        log:printError("Error occurred while storing the pair in redis.", key = key, value = value, 'error = stringSetresult);
    }
    return stringSetresult;
}

function getPrefixedKey(string key) returns string {
    return config:redisClient.cacheKeyPrefix + key;
}
