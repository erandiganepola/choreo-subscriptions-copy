// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.
 
public type Database record {|
    string url;
    string user;
    string password;
    int loginTimeout;
    boolean useSsl;
    int poolSize;
    int minIdle;
|};

public type RedisClient record {|
    string host;
    string password;
    boolean connectionPooling;
    boolean isClusterConnection;
    boolean startTls;
    boolean verifyPeer;
    int database;
    boolean enableSsl;
    int connectionTimeout;
|};

public configurable Database database = {
    url: "jdbc:mysql://localhost:3306/choreo?autoReconnect=true",
    user: "root",
    password: "password",
    loginTimeout: 10000,
    useSsl: false,
    poolSize: 5,
    minIdle: 5
};

public configurable RedisClient redisClient = {
    host: "localhost:6379",
    password: "",
    enableSsl: false,
    connectionTimeout: 500,
    connectionPooling: true,
    isClusterConnection: false,
    startTls: false,
    verifyPeer: false,
    database: 0
};
