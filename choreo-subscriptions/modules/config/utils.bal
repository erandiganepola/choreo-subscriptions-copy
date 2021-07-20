// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/os;
import ballerina/log;

function readIntFromEnvVar(string envKey, int defaultVal) returns int {
    string envVarStr = os:getEnv(envKey);
    log:printDebug("Read environment variable", (), {"key": envKey, "value": envVarStr});
    if envVarStr != "" {
        int|error envVarInt = int:fromString(envVarStr);
        if envVarInt is int {
            return envVarInt;
        } else {
            log:printError("Invalid value for environment variable. Continue with default value", envVarInt, {
                "key": envKey, "value": envVarStr, "default_value": defaultVal
            });
        }
    }
    log:printDebug("Get default value instead of environment variable", (), {
        "key": envKey, "value": envVarStr, "default_value": defaultVal
    });
    return defaultVal;
}
