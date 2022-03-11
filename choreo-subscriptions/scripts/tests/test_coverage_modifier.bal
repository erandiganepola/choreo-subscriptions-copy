// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/io;
import ballerina/log;

type coverage record {|
    string projectName;
    int totalTests;
    int passed;
    int failed;
    int skipped;
    int coveredLines;
    int missedLines;
    float coveragePercentage;
    json[] moduleStatus;
    json[] moduleCoverage;
|};

public function main() returns error? {
    log:printInfo("Running test coverage modification");
    string coverageJsonFilePath = "./target/report/test_results.json";
    json coverageJson = check io:fileReadJson(coverageJsonFilePath);

    int totalTestsCount = 0;
    int failedCount = 0;
    int passedCount = 0;
    int skippedCount = 0;
    int totalCoveredLines = 0;
    int totalMissedLines = 0;
    json[] requiredModuleStatus = [];
    json[] requiredModuleCoverage = [];
    string generatedModuleSuffix = ".rpc";

    json|error allModulesStatus = check coverageJson.moduleStatus;
    if allModulesStatus is json[] {
        foreach json moduleStatus in allModulesStatus {
            string name = check moduleStatus.name;
            if name.endsWith(generatedModuleSuffix) {
                continue;
            }
            totalTestsCount += <int>check moduleStatus.totalTests;
            failedCount += <int>check moduleStatus.failed;
            passedCount += <int>check moduleStatus.passed;
            skippedCount += <int>check moduleStatus.skipped;
            requiredModuleStatus.push(moduleStatus);
        }
    }

    json|error allModulesCoverage = check coverageJson.moduleCoverage;
    if allModulesCoverage is json[] {
        foreach json moduleCoverage in allModulesCoverage {
            json|error moduleName = moduleCoverage.name;
            if moduleName is json {
                if (<string>moduleName).endsWith(generatedModuleSuffix) {
                    continue;
                }
                totalCoveredLines += <int>check moduleCoverage.coveredLines;
                totalMissedLines += <int>check moduleCoverage.missedLines;
                requiredModuleCoverage.push(moduleCoverage);
            } else {
                log:printError("Error occurred while extracting module name from test");
            }
        }
    }

    float coveragePercentage = calculateCoveragePercentage(totalCoveredLines, totalMissedLines);

    coverage outputCoverageRecord = {
        projectName: (check coverageJson.projectName).toString(),
        totalTests: totalTestsCount,
        passed: passedCount,
        failed: failedCount,
        skipped: skippedCount,
        coveredLines: totalCoveredLines,
        missedLines: totalMissedLines,
        coveragePercentage: coveragePercentage,
        moduleStatus: requiredModuleStatus,
        moduleCoverage: requiredModuleCoverage
    };

    json outputCoverage = outputCoverageRecord.toJson();
    check io:fileWriteJson(coverageJsonFilePath, outputCoverage);
}

function calculateCoveragePercentage(int coveredLines, int missedLines) returns float {
    int totalLines = coveredLines + missedLines;
    float fraction = <float>coveredLines / <float>totalLines;
    float ceiling = fraction.ceiling();
    return fraction * 100.00;
}
