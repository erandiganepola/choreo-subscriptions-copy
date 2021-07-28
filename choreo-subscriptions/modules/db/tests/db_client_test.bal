// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/test;
import ballerinax/java.jdbc;

TierQuotas mockTierQuotas = {
    integration_quota: 15,
    service_quota: 10,
    api_quota: 20,
    remote_app_quota: 10
};

Tier mockTier = {
    id: "0ccca02-643a43ae-a38-200f2b",
    name: "Free Tier",
    description: "Free allocation to tryout choreo",
    cost: "0$ per Month",
    created_at: "2021-07-13 12:58:15",
    quota_limits: mockTierQuotas
};

SubscriptionDAO mockSubscriptionDAO = {
    id: "01ebe42f-9f13-1c18-9e38-cd24f0ebd234",
    org_id: "496b70d7-2ab6-440-405-dde8f64",
    tier_id: "7a13129e-b663-4724-ae7e-5c2e1c364d1c",
    billing_date: "2021-07-13 12:58:15.0",
    status: "ACTIVE",
    created_at: "2021-07-13 22:32:42.0"
};

AttributeDAO mockAttributeDAO = {
    id: "496b70d7-2ab6-440-405-dde8f64",
    name: "organization_quota",
    description: "Limit for the number of organization can be created by a user",
    created_at: "2021-07-13 12:58:15"
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
function testGetSubscriptionForOrg() {
    dbClient = test:mock(jdbc:Client);
    test:prepare(dbClient).when("query").thenReturn(returnMockedSubscriptionDAOStream());
    SubscriptionDAO|error result = getSubscriptionForOrg("0000");

    test:assertEquals(result, mockSubscriptionDAO);
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
        {attribute_name: "service_quota", threshold: 10}, 
        {attribute_name: "integration_quota", threshold: 15}, 
        {attribute_name: "api_quota", threshold: 20}, 
        {attribute_name: "remote_app_quota", threshold: 10}
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
        name: "Free Tier",
        description: "Free allocation to tryout choreo",
        cost: "0$ per Month",
        created_at: "2021-07-13 12:58:15",
        attribute_name: "service_quota",
        threshold: 10
    }, 
    {
        id: "0ccca02-643a43ae-a38-200f2b",
        name: "Free Tier",
        description: "Free allocation to tryout choreo",
        cost: "0$ per Month",
        created_at: "2021-07-13 12:58:15",
        attribute_name: "integration_quota",
        threshold: 15
    }, 
    {
        id: "0ccca02-643a43ae-a38-200f2b",
        name: "Free Tier",
        description: "Free allocation to tryout choreo",
        cost: "0$ per Month",
        created_at: "2021-07-13 12:58:15",
        attribute_name: "api_quota",
        threshold: 20
    }, 
    {
        id: "0ccca02-643a43ae-a38-200f2b",
        name: "Free Tier",
        description: "Free allocation to tryout choreo",
        cost: "0$ per Month",
        created_at: "2021-07-13 12:58:15",
        attribute_name: "remote_app_quota",
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

class SubscriptionDAOStreamImplementor {
    private int index = 0;
    private SubscriptionDAO[] currentEntries = [{
        id: "01ebe42f-9f13-1c18-9e38-cd24f0ebd234",
        org_id: "496b70d7-2ab6-440-405-dde8f64",
        tier_id: "7a13129e-b663-4724-ae7e-5c2e1c364d1c",
        billing_date: "2021-07-13 12:58:15.0",
        status: "ACTIVE",
        created_at: "2021-07-13 22:32:42.0"
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
        created_at: "2021-07-13 12:58:15"
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
