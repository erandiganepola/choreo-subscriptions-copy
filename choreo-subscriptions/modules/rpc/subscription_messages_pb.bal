public type GetTiersResponse record {|
    int count = 0;
    Tier[] list = [];
|};

public type CreateAttributeRequest record {|
    Attribute attribute = {};
|};

public type GetSubscriptionResponse record {|
    Subscription subscription = {};
|};

public type Attribute record {|
    string id = "";
    string name = "";
    string description = "";
    int created_at = 0;
|};

public type CreateSubscriptionRequest record {|
    Subscription subscription = {};
|};

public type OrgIdSubItemIdMappings record {|
    OrgIdSubItemIdMapping[] org_sub_item_id_mappings = [];
|};

public type DeleteSubscriptionResponse record {|
    string identifier = "";
|};

public type Pagination record {|
    int offset = 0;
    int 'limit = 0;
    int total = 0;
|};

public type TotalStepCount record {|
    string start_date = "";
    int step_count = 0;
|};

public type GetSubscriptionRequest record {|
    string identifier = "";
|};

public type Subscription record {|
    string id = "";
    string org_id = "";
    string org_handle = "";
    string tier_id = "";
    int billing_date = 0;
    string status = "";
    int created_at = 0;
    string subscription_item_id = "";
    boolean is_paid = false;
    int step_quota = 0;
|};

public type GetTierDetailResponse record {|
    Tier tier = {};
|};

public type SubscriptionTierMappingResponse record {|
    SubscriptionTierMapping subscription_tier_mapping = {};
|};

public type SubscriptionTierMappingRequest record {|
    string org_identifier = "";
|};

public type GetOrgIdSubItemIdMappingsResponse record {|
    OrgIdSubItemIdMappings org_sub_item_id_mappings = {};
    Pagination pagination = {};
|};

public type SubscriptionTierMappingsRequest record {|
    Pagination pagination = {};
|};

public type UpdateSubscriptionResponse record {|
    Subscription subscription = {};
|};

public type CreateTierRequest record {|
    Tier tier = {};
|};

public type SubscriptionTierMappingsResponse record {|
    SubscriptionTierMappings subscription_tier_mappings = {};
    Pagination pagination = {};
|};

public type UpdateSubscriptionRequest record {|
    Subscription subscription = {};
|};

public type GetOrgIdSubItemIdMappingsRequest record {|
    Pagination pagination = {};
|};

public type Tier record {|
    string id = "";
    string name = "";
    string description = "";
    boolean is_paid = false;
    int created_at = 0;
    int running_app_quota = 0;
    int component_quota = 0;
|};

public type SubscriptionTierMapping record {|
    string org_id = "";
    string org_handle = "";
    string tier_id = "";
    string tier_name = "";
    int billing_date = 0;
    boolean is_paid = false;
    int step_quota = 0;
|};

public type OrgIdSubItemIdMapping record {|
    string org_id = "";
    string subscription_item_id = "";
|};

public type GetTiersRequest record {|
    boolean internal = false;
|};

public type GetTotalStepCountResponse record {|
    TotalStepCount[] total_step_count = [];
|};

public type GetTierDetailRequest record {|
    string org_identifier = "";
|};

public type DeleteSubscriptionRequest record {|
    string identifier = "";
|};

public type GetTotalStepCountRequest record {|
    string org_identifier = "";
    string start_date = "";
    string end_date = "";
|};

public type CreateTierResponse record {|
    Tier tier = {};
|};

public type CreateSubscriptionResponse record {|
    Subscription subscription = {};
|};

public type CreateAttributeResponse record {|
    Attribute attribute = {};
|};

public type SubscriptionTierMappings record {|
    SubscriptionTierMapping[] subscription_tier_mappings = [];
|};
