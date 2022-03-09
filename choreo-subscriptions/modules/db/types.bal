// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

public type QuotaRecord record {|
    string tier_id?;
    string attribute_name;
    int threshold;
|};

public type TierRecord record {|
    string tier_id;
|};

public type TierQuotas record {|
    int running_app_quota = 5;
    int component_quota = 10;
|};

public type TierDAO record {|
    string id?;
    string name;
    string description;
    boolean is_paid;
    int created_at?;
|};

public type Tier record {|
    string id?;
    string name = "";
    string description = "";
    boolean is_paid?;
    int created_at = 0;
    TierQuotas quota_limits?;
|};

public type TierQuotaJoin record {|
    string id;
    string name;
    string description;
    boolean is_paid;
    int created_at;
    string attribute_name;
    int threshold;
|};

public type SubscriptionTierJoin record {|
    string org_id;
    string org_handle;
    string tier_id;
    string tier_name;
    int billing_date;
    boolean is_paid;
    int step_quota;
|};

public type SubscriptionTierMapping record {|
    string org_id = "";
    string org_handle = "";
    string tier_id = "";
    string tier_name = "";
    int billing_date;
    boolean is_paid;
    int step_quota = 0;
|};

public type SubscriptionDAO record {|
    string id?;
    string org_id;
    string org_handle;
    string tier_id;
    string subscription_item_id?;
    int billing_date;
    string status;
    boolean is_paid;
    int step_quota;
    int created_at?;
|};

public type OrgIdSubItemIdMapping record {|
    string org_id = "";
    string subscription_item_id = "";
|};

public type AttributeDAO record {|
    string id?;
    string name;
    string description;
    int created_at?;
|};

public type ThresholdEventStatusDAO record {|
    string org_uuid;
    int billing_month;
    int threshold_1_event_sent;
    int threshold_2_event_sent;
    int billing_cycle_reset;
|};

public type TotalStepCountDAO record {|
    string start_date;
    int step_count;
|};
