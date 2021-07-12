// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/test;
import ballerinax/redis;

@test:Config {
    groups:["clients"]
}
function testGetValueFromRedis() {
    string orgId = "0000";
    conn = test:mock(redis:Client);
    test:prepare(conn).when("get").withArguments(orgId).thenReturn(returnCachedValueForGet());
    (string|error)? result = checkpanic getValueFromRedis(orgId);
    test:assertEquals(result, "0000");
}

@test:Config {}
function testSetValueInRedis() {
    string orgId = "0000";
    string tier =  "{\"integration\": 10, \"service\": 10 }";
    conn = test:mock(redis:Client);
    test:prepare(conn).when("set").withArguments(orgId, tier).thenReturn(returnCachedValueForSet());
    string|error? result = setValueInRedis(orgId, tier);
    test:assertEquals(result, "OK");
}

function returnCachedValueForGet() returns string {
    return "0000";
}

function returnCachedValueForSet() returns string {
    return "OK";
}
