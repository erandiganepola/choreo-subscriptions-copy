// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/os;

public type Database record {|
    string url;
    string user;
    string password = os:getEnv("DB_PASSWORD");
    int loginTimeout;
    boolean useSsl;
    int poolSize;
    int minIdle;
|};

public type RedisClient record {|
    string host;
    string password = os:getEnv("CACHE_PASSWORD");
    string cacheKeyPrefix;
    boolean connectionPooling;
    boolean isClusterConnection;
    boolean startTls;
    boolean verifyPeer;
    int database;
    boolean enableSsl;
    int connectionTimeout;
|};

// time duration for healthz state caching
public int HC_CACHED_TIME_DURATION = 30000; //30s
const string HC_CACHED_TIME_DURATION_ENV = "HC_CACHED_TIME_DURATION_MILI_SEC";

function init() {
    HC_CACHED_TIME_DURATION = readIntFromEnvVar(HC_CACHED_TIME_DURATION_ENV, HC_CACHED_TIME_DURATION);
}

public configurable Database database = {
    url: "jdbc:sqlserver://localhost:1433;databaseName=choreo_subscriptions_db",
    user: "SA",
    loginTimeout: 10000,
    useSsl: false,
    poolSize: 5,
    minIdle: 5
};

public configurable RedisClient redisClient = {
    host: "localhost:6379",
    cacheKeyPrefix: "choreo_subscriptions.",
    enableSsl: false,
    connectionTimeout: 500,
    connectionPooling: true,
    isClusterConnection: false,
    startTls: false,
    verifyPeer: false,
    database: 0
};
