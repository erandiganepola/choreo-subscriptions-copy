// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import choreo_subscriptions.utils;

configurable string url = utils:readFromEnvVar("CHOREO_STEP_DB_URL", 
    "jdbc:sqlserver://localhost:1433;databaseName=choreo_step_db");
configurable string user = utils:readFromEnvVar("CHOREO_STEP_DB_USER", "SA");
configurable string password = utils:readSecretFromEnvVar("CHOREO_STEP_DB_PASSWORD");
configurable int loginTimeout = utils:readIntFromEnvVar("CHOREO_STEP_DB_LOGIN_TIMEOUT", 60);
configurable boolean useSsl = utils:readBooleanFromEnvVar("CHOREO_STEP_DB_USE_SSL", false);
configurable int poolSize = utils:readIntFromEnvVar("CHOREO_STEP_DB_POOL_SIZE", 15);
configurable int minIdle = utils:readIntFromEnvVar("CHOREO_STEP_DB_MIN_IDLE", 5);
