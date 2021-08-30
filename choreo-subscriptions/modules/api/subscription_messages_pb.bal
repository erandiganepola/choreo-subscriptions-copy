public type UpdateSubscriptionResponse record {|
    Subscription subscription = {};
|};

public type CreateTierRequest record {|
    Tier tier = {};
|};

public type CreateAttributeRequest record {|
    Attribute attribute = {};
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

public type GetTierDetailResponse record {|
    Tier tier = {};
|};

public type CreateAttributeResponse record {|
    Attribute attribute = {};
|};
