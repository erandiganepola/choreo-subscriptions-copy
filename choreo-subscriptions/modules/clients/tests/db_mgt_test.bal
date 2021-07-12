// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/test;
import ballerinax/java.jdbc;

TierDAO mockedTierDAO = {
    name: "Free Tier",
    description: "Free allocation to tryout choroe",
    cost: "0$ per Month",
    created_at: "2021/07/07"
};

TierQuotas mockTierQuotas = {
    integration_quota: 10,
    service_quota: 10,
    api_quota: 10
};

@test:Config {
    groups:["clients"]
}
function testGetTierFromDB() {
    string tierId = "0000";
    string quotaQuery = "SELECT name, description, cost, created_at FROM tier WHERE id='0000'";
    choreoDbClient = test:mock(jdbc:Client);
    test:prepare(choreoDbClient).when("query").thenReturn(returnMockedTierDAO());
    TierDAO|error? result = getTierFromDB(tierId);

    test:assertEquals(result, mockedTierDAO);
}

@test:Config {
    groups:["clients"]
}
function testGetTierQuotasFromDB() {
    string tierId = "0000";
    string quotaQuery = "SELECT attribute_name, threshold FROM quota WHERE tier_id='0000'";
    choreoDbClient = test:mock(jdbc:Client);
    test:prepare(choreoDbClient).when("query").thenReturn(returnMockedTierQuotas());
    TierQuotas|error? result = getTierQuotasFromDB(tierId);

    test:assertEquals(result, mockTierQuotas);
}

@test:Mock { functionName: "getTierFromDB" }
test:MockFunction getTierFromDBFn = new();

@test:Mock { functionName: "getTierQuotasFromDB" }
test:MockFunction getTierQuotasFromDBFn = new();

@test:Config {
    groups:["clients"]
}
function testGetTierForOrgFromDB() {
    string orgId = "0000";
    Tier mockedTier = {
        name: "Free Tier",
        description: "Free allocation to tryout choroe",
        cost: "0$ per Month",
        created_at: "2021/07/07",
        service_quota: 10,
        integration_quota: 10,
        api_quota: 10
    };
    string tierQuery = "SELECT tier_id FROM subscription WHERE org_id='0000'";
    choreoDbClient = test:mock(jdbc:Client);
    test:prepare(choreoDbClient).when("query").thenReturn(returnMockedTierRecord());
    test:when(getTierFromDBFn).thenReturn(mockedTierDAO);
    test:when(getTierQuotasFromDBFn).thenReturn(mockTierQuotas);
    Tier|error? result = getTierForOrgFromDB(orgId);

    test:assertEquals(result, mockedTier);
}

function returnMockedTierRecord() returns stream<TierRecord, error> {
    stream<TierRecord, error> tierRecordStream = new (new TierRecordStreamImplementor());
    return tierRecordStream;
}

function returnMockedTierQuotas() returns stream<QuotaRecord, error> {
    stream<QuotaRecord, error> quotaStream = new (new TierQuotasStreamImplementor());
    return quotaStream;
}

function returnMockedTierDAO() returns stream<TierDAO, error> {
    stream<TierDAO, error> tierDaoStream = new (new TierDaoStreamImplementor());
    return tierDaoStream;
}

class TierQuotasStreamImplementor {
    private int index = 0;
    private QuotaRecord[] currentEntries = [
        {attribute_name: "service_quota", threshold : 10},
        {attribute_name: "integration_quota", threshold: 10},
        {attribute_name: "api_quota", threshold : 10}
    ];

    isolated function init() {}

    public isolated function next() returns record {| QuotaRecord value; |}|error? {       
        if (self.index < self.currentEntries.length()) {
            record {| QuotaRecord value; |} quotaRecord = {value: self.currentEntries[self.index]};
            self.index += 1;
            return quotaRecord;
        }
    }
}

class TierDaoStreamImplementor {
    private int index = 0;
    private TierDAO[] currentEntries = [{
        name: "Free Tier",
        description: "Free allocation to tryout choroe",
        cost: "0$ per Month",
        created_at: "2021/07/07"
    }];

    isolated function init() {}

    public isolated function next() returns record {| TierDAO value; |}|error? {       
        if (self.index < self.currentEntries.length()) {
            record {| TierDAO value; |} tierDAO = {value: self.currentEntries[self.index]};
            self.index += 1;
            return tierDAO;
        }
    }
}

class TierRecordStreamImplementor {
    private int index = 0;
    private TierRecord[] currentEntries = [{tier_id: "0000"}];

    isolated function init() {}

    public isolated function next() returns record {| TierRecord value; |}|error? {       
        if (self.index < self.currentEntries.length()) {
            record {| TierRecord value; |} tierRecord = {value: self.currentEntries[self.index]};
            self.index += 1;
            return tierRecord;
        }
    }
}
