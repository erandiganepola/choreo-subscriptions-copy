public type CreateTierResponse record {|
    Tier tier = {};
|};

public type CreateTierRequest record {|
    string name = "";
    string description = "";
    string cost = "";
    int service_quota = 0;
    int integration_quota = 0;
    int api_quota = 0;
    int remote_app_quota = 0;
|};

public type CreateAttributeRequest record {|
    string name = "";
    string description = "";
|};

public type Tier record {|
    string id = "";
    string name = "";
    string description = "";
    string cost = "";
    string created_at = "";
    int service_quota = 0;
    int integration_quota = 0;
    int api_quota = 0;
    int remote_app_quota = 0;
|};

public type Attribute record {|
    string id = "";
    string name = "";
    string description = "";
    string created_at = "";
|};

public type CreateSubscriptionRequest record {|
    string org_id = "";
    string tier_id = "";
    string billing_date = "";
    string status = "";
|};

public type CreateSubscriptionResponse record {|
    Subscription subscription = {};
|};

public type Subscription record {|
    string id = "";
    string org_id = "";
    string tier_id = "";
    string billing_date = "";
    string status = "";
    string created_at = "";
|};

public type GetTierDetailRequest record {|
    string org_id = "";
|};

public type GetTierDetailResponse record {|
    Tier tier = {};
|};

public type CreateAttributeResponse record {|
    Attribute attribute = {};
|};
