public type SubscriptionTierMappingsRequest record {|
    Pagination pagination = {};
|};

public type UpdateSubscriptionResponse record {|
    Subscription subscription = {};
|};

public type CreateTierRequest record {|
    Tier tier = {};
|};

public type CreateAttributeRequest record {|
    Attribute attribute = {};
|};

public type GetSubscriptionResponse record {|
    Subscription subscription = {};
|};

public type SubscriptionTierMappingsResponse record {|
    SubscriptionTierMappings subscription_tier_mappings = {};
    Pagination pagination = {};
|};

public type UpdateSubscriptionRequest record {|
    Subscription subscription = {};
|};

public type Tier record {|
    string id = "";
    string name = "";
    string description = "";
    int cost = 0;
    int created_at = 0;
    int service_quota = 0;
    int integration_quota = 0;
    int api_quota = 0;
    int remote_app_quota = 0;
    int step_quota = 0;
    int developer_count = 0;
|};

public type Attribute record {|
    string id = "";
    string name = "";
    string description = "";
    int created_at = 0;
|};

public type SubscriptionTierMapping record {|
    string org_id = "";
    string org_handle = "";
    string tier_id = "";
    string tier_name = "";
    int billing_date = 0;
    int step_quota = 0;
|};

public type CreateSubscriptionRequest record {|
    Subscription subscription = {};
|};

public type GetTiersRequest record {|
    boolean internal = false;
|};

public type GetTierDetailRequest record {|
    string org_identifier = "";
|};

public type DeleteSubscriptionRequest record {|
    string identifier = "";
|};

public type CreateTierResponse record {|
    Tier tier = {};
|};

public type DeleteSubscriptionResponse record {|
    string identifier = "";
|};

public type Pagination record {|
    int offset = 0;
    int 'limit = 0;
    int total = 0;
|};

public type GetSubscriptionRequest record {|
    string identifier = "";
|};

public type CreateSubscriptionResponse record {|
    Subscription subscription = {};
|};

public type Subscription record {|
    string id = "";
    string org_id = "";
    string org_handle = "";
    string tier_id = "";
    int billing_date = 0;
    string status = "";
    int created_at = 0;
|};

public type GetTiersResponse record {|
    int count = 0;
    Tier[] list = [];
|};

public type GetTierDetailResponse record {|
    Tier tier = {};
|};

public type CreateAttributeResponse record {|
    Attribute attribute = {};
|};

public type SubscriptionTierMappingResponse record {|
    SubscriptionTierMapping subscription_tier_mapping = {};
|};

public type SubscriptionTierMappings record {|
    SubscriptionTierMapping[] subscription_tier_mappings = [];
|};

public type SubscriptionTierMappingRequest record {|
    string org_identifier = "";
|};
