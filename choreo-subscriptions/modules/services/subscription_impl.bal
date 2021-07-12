// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.


import choreo_subscriptions.clients;

public function getTier(string orgId) returns GetTierDetailResponse|error? {
    (string|error)? tierString = clients:getValueFromRedis(orgId);
    if (tierString is string) {
        json|error tierJson = tierString.fromJsonString();
        if (tierJson is json) {
            Tier tier = {};
            tier.name = (check tierJson.name).toString();
            tier.description = (check tierJson.description).toString();
            tier.cost = (check tierJson.cost).toString();
            tier.created_at = (check tierJson.created_at).toString();
            tier.integration_quota = <int>(check tierJson.integration_quota);
            tier.service_quota = <int>(check tierJson.service_quota);
            tier.api_quota = <int>(check tierJson.api_quota);
            return { tier };
        }
    } else {
        (clients:Tier|error)? tierJson = clients:getTierForOrgFromDB(orgId);
        if (tierJson is clients:Tier) {
            string|error setResult = clients:setValueInRedis(orgId, tierJson.toString());
            Tier tier = {
                name: tierJson.name,
                description: tierJson.description,
                cost: tierJson.cost,
                created_at: tierJson.created_at,
                service_quota: tierJson.service_quota,
                integration_quota: tierJson.integration_quota,
                api_quota: tierJson.api_quota
            };
            return {tier};
        } else {
            return tierJson;
        }
    }
}
