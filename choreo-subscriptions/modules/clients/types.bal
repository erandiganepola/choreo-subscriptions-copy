// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

type QuotaRecord record {|
    string attribute_name;
    int threshold;
|};

type TierRecord record {|
    string tier_id;
|};

type TierQuotas record {|
    int service_quota = 10;
    int integration_quota = 10;
    int api_quota = 10;
|};

type TierDAO record {|
    string name;
    string description;
    string cost;
    string created_at;
|};

public type Tier record {|
    string name = "";
    string description = "";
    string cost = "";
    string created_at = "";
    int service_quota = 0;
    int integration_quota = 0;
    int api_quota = 0;
|};
