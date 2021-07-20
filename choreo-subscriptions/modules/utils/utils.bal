
// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/time;

public isolated function getTimestampInMillis() returns int {
    time:Utc utcNow = time:utcNow(3);
    return utcNow[0] * 1000 + <int>decimal:round(utcNow[1] * 1000d);
}
