
// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/os;
import ballerina/log;
import ballerina/time;

public isolated function getTimestampInMillis() returns int {
    time:Utc utcNow = time:utcNow(3);
    return utcNow[0] * 1000 + <int>decimal:round(utcNow[1] * 1000d);
}

public function getMonthOfYear(int billingDay) returns int {
    time:Utc utc = time:utcNow();
    time:Civil civil = time:utcToCivil(utc);
    int monthCount = civil.month;
    int dayOfMonth = civil.day;
    int monthOfYear = monthCount;
    if (dayOfMonth >= billingDay) {
        if (monthCount == 12) {
            monthOfYear = 1;
        } else {
            monthOfYear = monthCount + 1;
        }
    }
    return monthOfYear;
}

# Returns an env variable from the given key
#
# + envKey - the key for the env variable
# + defaultVal - the default value (int) to return if that is not set
# + return - returns the env variable or default value if not set
public function readFromEnvVar(string envKey, string defaultVal) returns string {
    string envVarStr = os:getEnv(envKey);
    log:printDebug("Read environment variable", key = envKey, value = envVarStr);
    if envVarStr != "" {
        return envVarStr;
    }
    log:printDebug("Get default value instead of environment variable", key = envKey, value = envVarStr, 
        default_value = defaultVal);
    return defaultVal;
}

# Returns an env variable (integer) from the given key
#
# + envKey - the key for the env variable
# + defaultVal - the default value (int) to return if that is not set
# + return - returns the env variable or default value if not set
public function readIntFromEnvVar(string envKey, int defaultVal) returns int {
    string envVarStr = os:getEnv(envKey);
    log:printDebug("Read environment variable", key = envKey, value = envVarStr);
    if envVarStr != "" {
        int|error envVarInt = int:fromString(envVarStr);
        if envVarInt is int {
            return envVarInt;
        } else {
            log:printError("Invalid value for environment variable.", envVarInt, key = envKey, value = envVarStr);
            panic envVarInt;
        }
    }
    log:printDebug("Get default value instead of environment variable", key = envKey, value = envVarStr, default_value = defaultVal);
    return defaultVal;
}

# Returns an env variable (decimal) from the given key
#
# + envKey - the key for the env variable
# + defaultVal - the default value to return if that is not set
# + return - returns the env variable or default value if not set
public function readDecimalFromEnvVar(string envKey, decimal defaultVal) returns decimal {
    string envVarStr = os:getEnv(envKey);
    log:printDebug("Read environment variable", key = envKey, value = envVarStr);
    if envVarStr != "" {
        decimal|error envVarDecimal = decimal:fromString(envVarStr);
        if envVarDecimal is decimal {
            return envVarDecimal;
        } else {
            log:printError("Invalid value for environment variable", envVarDecimal, key = envKey, value = envVarStr);
            panic envVarDecimal;
        }
    }
    log:printDebug("Get default value instead of environment variable", key = envKey, value = envVarStr, 
        default_value = defaultVal);
    return defaultVal;
}

# Returns an env variable (boolean) from the given key
#
# + envKey - the key for the env variable
# + defaultVal - the default value to return if that is not set
# + return - returns the env variable or default value if not set
public function readBooleanFromEnvVar(string envKey, boolean defaultVal) returns boolean {
    string envVarStr = os:getEnv(envKey);
    log:printDebug("Read environment variable", key = envKey, value = envVarStr);
    if envVarStr != "" {
        boolean|error envVarBoolean = boolean:fromString(envVarStr);
        if envVarBoolean is boolean {
            return envVarBoolean;
        } else {
            log:printError("Invalid value for environment variable.", envVarBoolean, key = envKey, value = envVarStr);
            panic envVarBoolean;
        }
    }
    log:printDebug("Get default value instead of environment variable", key = envKey, value = envVarStr, 
        default_value = defaultVal);
    return defaultVal;
}

# Returns an env variable (secret) from the given key
#
# + envKey - the key for the env variable
# + return - returns the env variable or default value if not set
public function readSecretFromEnvVar(string envKey) returns string {
    string envVarStr = os:getEnv(envKey);
    log:printDebug("Read environment variable", key = envKey);
    if envVarStr == "" {
        log:printWarn("Requested environment variable is not set to a non-empty value. Considering this as an empty" + 
            " string", key = envKey);
    }
    return envVarStr;
}
