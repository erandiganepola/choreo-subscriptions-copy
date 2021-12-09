// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/test;
import ballerinax/java.jdbc;

ThresholdEventStatusDAO mockThresholdEventStatusDAO = {
    org_uuid: "496b70d7-2ab6-440-405-dde8f64",
    billing_month: 11,
    threshold_1_event_sent: 1,
    threshold_2_event_sent: 1,
    billing_cycle_reset: 1
};

TotalStepCountDAO[] mockTotalStepCountDAO = [
    {
    start_date: "2021-12-01T00:00:00.000",
    step_count: 10
}, 
    {
    start_date: "2021-12-02T00:00:00.000",
    step_count: 15
}
];

@test:Mock {
    functionName: "getStepDbClient"
}
function getMockStepDbClient() returns jdbc:Client|error {
    return test:mock(jdbc:Client);
}

@test:Config {
    groups: ["db"]
}
function testGetThresholdEventStatusForOrgId() {
    test:prepare(stepDbClient).when("query").thenReturn(returnMockedThresholdEventStatusDAOStream());
    ThresholdEventStatusDAO|()|error result = getThresholdEventStatusForOrgId("496b70d7-2ab6-440-405-dde8f64", 11);

    test:assertEquals(result, mockThresholdEventStatusDAO);
}

@test:Config {
    groups: ["db"]
}
function testGetDailyTotalStepCountForOrg() {
    test:prepare(stepDbClient).when("query").thenReturn(returnMockedTotalStepCountDAOStream());
    TotalStepCountDAO[]|error result = getDailyTotalStepCountForOrg("e628f45c-d4fc-4d2a-9105-350b60beb84e", 
        "2021-12-01T00:00:00.000", "2021-12-02T00:00:00.000");

    test:assertEquals(result, mockTotalStepCountDAO);
}

function returnMockedThresholdEventStatusDAOStream() returns stream<record {}, error?> {
    stream<record {}, error?> thresholdEventStatusDAOStream = new (new ThresholdEventStatusDAOStreamImplementor());
    return thresholdEventStatusDAOStream;
}

function returnMockedTotalStepCountDAOStream() returns stream<record {}, error?> {
    stream<TotalStepCountDAO, error> TotalStepCountStream = new (new TotalStepCountStreamImplementor());
    return TotalStepCountStream;
}

class ThresholdEventStatusDAOStreamImplementor {
    private int index = 0;
    private record {|record {} value;|}[] currentEntries = [{
        value: {
            "org_uuid": "496b70d7-2ab6-440-405-dde8f64",
            "billing_month": 11,
            "threshold_1_event_sent": true,
            "threshold_2_event_sent": true,
            "billing_cycle_reset": true
        }
    }];

    isolated function init() {
    }

    public isolated function next() returns record {|record {} value;|}|error? {
        if (self.index < self.currentEntries.length()) {
            record {|record {} value;|} eventRecord = {value: self.currentEntries[self.index].value};
            self.index += 1;
            return eventRecord;
        }
    }
}

class TotalStepCountStreamImplementor {
    private int index = 0;
    private TotalStepCountDAO[] currentEntries = [{
        start_date: "2021-12-01T00:00:00.000",
        step_count: 10
    }, 
    {
        start_date: "2021-12-02T00:00:00.000",
        step_count: 15
    }];

    isolated function init() {
    }

    public isolated function next() returns record {|TotalStepCountDAO value;|}|error? {
        if (self.index < self.currentEntries.length()) {
            record {|TotalStepCountDAO value;|} totalStepCount = {value: self.currentEntries[self.index]};
            self.index += 1;
            return totalStepCount;
        }
    }

}
