// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import choreo_subscriptions.utils;

configurable string url = utils:readFromEnvVar("CHOREO_SUBSCRIPTIONS_ASB_URL", 
    "https://choreo-dev-servicebus.servicebus.windows.net");
configurable string auth_token = utils:readSecretFromEnvVar("CHOREO_SUBSCRIPTIONS_ASB_AUTH_TOKEN");
