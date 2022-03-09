// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/test;
import ballerinax/java.jdbc;

TierQuotas mockTierQuotas = {
    running_app_quota: 5,
    component_quota: 10
};

Tier mockTier = {
    id: "0ccca02-643a43ae-a38-200f2b",
    name: "Free",
    description: "Free allocation to tryout choreo",
    is_paid: false,
    created_at: 1627639797657,
    quota_limits: mockTierQuotas
};

TierQuotas[] mockTierQuotasArray = [
    {
    running_app_quota: 5,
    component_quota: 10
}, 
    {
    running_app_quota: 1000000,
    component_quota: 1000000
}
];

Tier[] mockTierArray = [
    {
    id: "0ccca02-643a43ae-a38-200f2b",
    name: "Free",
    description: "Free allocation to tryout choreo",
    is_paid: false,
    created_at: 1627639797657,
    quota_limits: mockTierQuotasArray[0]
}, 
    {
    id: "01ec1f8e-7ba6-1f88-bd74-41709200d0c0",
    name: "Pay-As-You-Go",
    description: "Tier for paid users",
    is_paid: true,
    created_at: 1627639797657,
    quota_limits: mockTierQuotasArray[1]
}
];

SubscriptionDAO mockSubscriptionDAO = {
    id: "01ebe42f-9f13-1c18-9e38-cd24f0ebd234",
    org_id: "496b70d7-2ab6-440-405-dde8f64",
    org_handle: "jhondoe",
    tier_id: "7a13129e-b663-4724-ae7e-5c2e1c364d1c",
    billing_date: 1627639797657,
    status: "ACTIVE",
    is_paid: false,
    step_quota: 5000,
    created_at: 1627639797657
};

SubscriptionTierMapping mockSubscriptionTierMapping = {
    org_id: "0ccca02-643a43ae-a38-200f2b",
    tier_id: "9nffg02-612k12ae-a38-kiod2b",
    org_handle: "jhondoe",
    tier_name: "Free",
    billing_date: 1627639797657,
    is_paid: false,
    step_quota: 5000
};

SubscriptionTierMapping[] mockSubscriptionTierMappings = [{
    org_id: "0ccca02-643a43ae-a38-200f2b",
    tier_id: "9nffg02-612k12ae-a38-kiod2b",
    org_handle: "jhondoe",
    tier_name: "Free",
    billing_date: 1627639797667,
    is_paid: false,
    step_quota: 5000
}, 
{
    org_id: "lk78ot-643a43ae-a38-2oof2b",
    tier_id: "9nffg02-600ki98ae-a38g-kbnjb",
    org_handle: "bessjob",
    tier_name: "Enterprise",
    billing_date: 1627639797677,
    is_paid: true,
    step_quota: 10000000
}];

AttributeDAO mockAttributeDAO = {
    id: "496b70d7-2ab6-440-405-dde8f64",
    name: "organization_quota",
    description: "Limit for the number of organization can be created by a user",
    created_at: 1627639797657
};

@test:Mock {
    functionName: "getClient"
}
function getMockClient() returns jdbc:Client|error {
    return test:mock(jdbc:Client);
}

@test:Config {
    groups: ["db"]
}
function testGetSubscriptionForOrgId() {
    dbClient = test:mock(jdbc:Client);
    test:prepare(dbClient).when("query").thenReturn(returnMockedSubscriptionDAOStream());
    SubscriptionDAO|error result = getSubscriptionForOrgId("0000");

    test:assertEquals(result, mockSubscriptionDAO);
}

@test:Config {
    groups: ["db"]
}
function testGetSubscriptionForOrgHandle() {
    dbClient = test:mock(jdbc:Client);
    test:prepare(dbClient).when("query").thenReturn(returnMockedSubscriptionDAOStream());
    SubscriptionDAO|error result = getSubscriptionForOrgHandle("jhondoe");

    test:assertEquals(result, mockSubscriptionDAO);
}

@test:Config {
    groups: ["db"]
}
function testGetSubscriptionTierMappingForOrgId() {
    test:prepare(dbClient).when("query").thenReturn(returnMockedSubscriptionTierJoinStream());
    SubscriptionTierMapping|error result = getSubscriptionTierMappingForOrgId("0000");

    test:assertEquals(result, mockSubscriptionTierMapping);
}

@test:Config {
    groups: ["db"]
}
function testGetSubscriptionTierMappings() {
    test:prepare(dbClient).when("query").thenReturn(returnMockedSubscriptionTierJoinsStream());
    SubscriptionTierMapping[]|error result = getSubscriptionTierMappings(0, 10);

    test:assertEquals(result, mockSubscriptionTierMappings);
}

@test:Config {
    groups: ["db"]
}
function testGetSubscription() {
    test:prepare(dbClient).when("query").thenReturn(returnMockedSubscriptionDAOStream());
    SubscriptionDAO|error result = getSubscription("0000");

    test:assertEquals(result, mockSubscriptionDAO);
}

@test:Config {
    groups: ["db"]
}
function testGetAttribute() {
    test:prepare(dbClient).when("query").thenReturn(returnMockedAttributeDAOStream());
    AttributeDAO|error result = getAttribute("0000");

    test:assertEquals(result, mockAttributeDAO);
}

@test:Config {
    groups: ["db"]
}
function testGetTier() {
    string tierId = "0000";
    test:prepare(dbClient).when("query").thenReturn(returnMockedTierQuotaJoinStream());
    Tier|error result = getTier(tierId);

    test:assertEquals(result, mockTier);
}

@test:Config {
    groups: ["db"]
}
function testGetTiers() {
    boolean internal = false;
    test:prepare(dbClient).when("query").thenReturn(returnMockedTiersQuotaJoinStream());
    Tier[]|error result = getTiers(internal);

    test:assertEquals(result, mockTierArray);
}

@test:Config {
    groups: ["db"]
}
function testGetTierQuotas() {
    string tierId = "0000";
    test:prepare(dbClient).when("query").thenReturn(returnMockedTierQuotasStream());
    TierQuotas|error result = getTierQuotas(tierId);

    test:assertEquals(result, mockTierQuotas);
}

function returnMockedTierQuotasStream() returns stream<QuotaRecord, error> {
    stream<QuotaRecord, error> quotaStream = new (new TierQuotasStreamImplementor());
    return quotaStream;
}

function returnMockedTierQuotaJoinStream() returns stream<TierQuotaJoin, error> {
    stream<TierQuotaJoin, error> tierQuotaJoinStream = new (new TierQuotaJoinStreamImplementor());
    return tierQuotaJoinStream;
}

function returnMockedTiersQuotaJoinStream() returns stream<TierQuotaJoin, error> {
    stream<TierQuotaJoin, error> tierQuotaJoinStream = new (new TiersQuotaJoinStreamImplementor());
    return tierQuotaJoinStream;
}

function returnMockedSubscriptionTierJoinStream() returns stream<SubscriptionTierJoin, error> {
    stream<SubscriptionTierJoin, error> subscriptionTierJoinStream = new (new SubscriptionTierJoinStreamImplementor());
    return subscriptionTierJoinStream;
}

function returnMockedSubscriptionTierJoinsStream() returns stream<SubscriptionTierJoin, error> {
    stream<SubscriptionTierJoin, error> subscriptionTierJoinStream = new (new SubscriptionTierJoinsStreamImplementor());
    return subscriptionTierJoinStream;
}

function returnMockedSubscriptionDAOStream() returns stream<SubscriptionDAO, error> {
    stream<SubscriptionDAO, error> subscriptionDAOStream = new (new SubscriptionDAOStreamImplementor());
    return subscriptionDAOStream;
}

function returnMockedAttributeDAOStream() returns stream<AttributeDAO, error> {
    stream<AttributeDAO, error> attributeDAOStream = new (new AttributeDAOStreamImplementor());
    return attributeDAOStream;
}

class TierQuotasStreamImplementor {
    private int index = 0;
    private QuotaRecord[] currentEntries = [
        {attribute_name: "running_app_quota", threshold: 5}, 
        {attribute_name: "component_quota", threshold: 10}
    ];

    isolated function init() {
    }

    public isolated function next() returns record {|QuotaRecord value;|}|error? {
        if (self.index < self.currentEntries.length()) {
            record {|QuotaRecord value;|} quotaRecord = {value: self.currentEntries[self.index]};
            self.index += 1;
            return quotaRecord;
        }
    }
}

class TierQuotaJoinStreamImplementor {
    private int index = 0;
    private TierQuotaJoin[] currentEntries = [{
        id: "0ccca02-643a43ae-a38-200f2b",
        name: "Free",
        description: "Free allocation to tryout choreo",
        is_paid: false,
        created_at: 1627639797657,
        attribute_name: "running_app_quota",
        threshold: 5
    }, 
    {
        id: "0ccca02-643a43ae-a38-200f2b",
        name: "Free Tier",
        description: "Free allocation to tryout choreo",
        is_paid: false,
        created_at: 1627639797657,
        attribute_name: "component_quota",
        threshold: 10
    }];

    isolated function init() {
    }

    public isolated function next() returns record {|TierQuotaJoin value;|}|error? {
        if (self.index < self.currentEntries.length()) {
            record {|TierQuotaJoin value;|} tierQuotaJoin = {value: self.currentEntries[self.index]};
            self.index += 1;
            return tierQuotaJoin;
        }
    }
}

class TiersQuotaJoinStreamImplementor {
    private int index = 0;
    private TierQuotaJoin[] currentEntries = [{
        id: "0ccca02-643a43ae-a38-200f2b",
        name: "Free",
        description: "Free allocation to tryout choreo",
        is_paid: false,
        created_at: 1627639797657,
        attribute_name: "running_app_quota",
        threshold: 5
    }, 
    {
        id: "0ccca02-643a43ae-a38-200f2b",
        name: "Free Tier",
        description: "Free allocation to tryout choreo",
        is_paid: false,
        created_at: 1627639797657,
        attribute_name: "component_quota",
        threshold: 10
    }, 
    {
        id: "01ec1f8e-7ba6-1f88-bd74-41709200d0c0",
        name: "Pay-As-You-Go",
        description: "Tier for paid users",
        is_paid: true,
        created_at: 1627639797657,
        attribute_name: "running_app_quota",
        threshold: 1000000
    }, 
    {
        id: "01ec1f8e-7ba6-1f88-bd74-41709200d0c0",
        name: "Pay-As-You-Go",
        description: "Tier for paid users",
        is_paid: true,
        created_at: 1627639797657,
        attribute_name: "component_quota",
        threshold: 1000000
    }];

    isolated function init() {
    }

    public isolated function next() returns record {|TierQuotaJoin value;|}|error? {
        if (self.index < self.currentEntries.length()) {
            record {|TierQuotaJoin value;|} tierQuotaJoin = {value: self.currentEntries[self.index]};
            self.index += 1;
            return tierQuotaJoin;
        }
    }
}

class SubscriptionTierJoinStreamImplementor {
    private int index = 0;
    private SubscriptionTierJoin[] currentEntries = [{
        org_id: "0ccca02-643a43ae-a38-200f2b",
        tier_id: "9nffg02-612k12ae-a38-kiod2b",
        org_handle: "jhondoe",
        tier_name: "Free",
        billing_date: 1627639797657,
        is_paid: false,
        step_quota: 5000
    }];

    isolated function init() {
    }

    public isolated function next() returns record {|SubscriptionTierJoin value;|}|error? {
        if (self.index < self.currentEntries.length()) {
            record {|SubscriptionTierJoin value;|} subscriptionTierJoin = {value: self.currentEntries[self.index]};
            self.index += 1;
            return subscriptionTierJoin;
        }
    }
}

class SubscriptionTierJoinsStreamImplementor {
    private int index = 0;
    private SubscriptionTierJoin[] currentEntries = [{
        org_id: "0ccca02-643a43ae-a38-200f2b",
        tier_id: "9nffg02-612k12ae-a38-kiod2b",
        org_handle: "jhondoe",
        tier_name: "Free",
        billing_date: 1627639797667,
        is_paid: false,
        step_quota: 5000
    }, 
    {
        org_id: "lk78ot-643a43ae-a38-2oof2b",
        tier_id: "9nffg02-600ki98ae-a38g-kbnjb",
        org_handle: "bessjob",
        tier_name: "Enterprise",
        billing_date: 1627639797677,
        is_paid: true,
        step_quota: 10000000
    }];

    isolated function init() {
    }

    public isolated function next() returns record {|SubscriptionTierJoin value;|}|error? {
        if (self.index < self.currentEntries.length()) {
            record {|SubscriptionTierJoin value;|} subscriptionTierJoin = {value: self.currentEntries[self.index]};
            self.index += 1;
            return subscriptionTierJoin;
        }
    }
}

class SubscriptionDAOStreamImplementor {
    private int index = 0;
    private SubscriptionDAO[] currentEntries = [{
        id: "01ebe42f-9f13-1c18-9e38-cd24f0ebd234",
        org_id: "496b70d7-2ab6-440-405-dde8f64",
        org_handle: "jhondoe",
        tier_id: "7a13129e-b663-4724-ae7e-5c2e1c364d1c",
        billing_date: 1627639797657,
        status: "ACTIVE",
        is_paid: false,
        step_quota: 5000,
        created_at: 1627639797657
    }];

    isolated function init() {
    }

    public isolated function next() returns record {|SubscriptionDAO value;|}|error? {
        if (self.index < self.currentEntries.length()) {
            record {|SubscriptionDAO value;|} subscriptionDAO = {value: self.currentEntries[self.index]};
            self.index += 1;
            return subscriptionDAO;
        }
    }
}

class AttributeDAOStreamImplementor {
    private int index = 0;
    private AttributeDAO[] currentEntries = [{
        id: "496b70d7-2ab6-440-405-dde8f64",
        name: "organization_quota",
        description: "Limit for the number of organization can be created by a user",
        created_at: 1627639797657
    }];

    isolated function init() {
    }

    public isolated function next() returns record {|AttributeDAO value;|}|error? {
        if (self.index < self.currentEntries.length()) {
            record {|AttributeDAO value;|} attributeDAO = {value: self.currentEntries[self.index]};
            self.index += 1;
            return attributeDAO;
        }
    }
}
