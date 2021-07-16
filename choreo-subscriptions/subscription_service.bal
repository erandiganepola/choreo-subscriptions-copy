// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/grpc;
import choreo_subscriptions.api;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: api:ROOT_DESCRIPTOR, descMap: api:getDescriptorMap()}
service "SubscriptionService" on ep {

    remote function GetTierDetails(api:GetTierDetailRequest value) returns api:GetTierDetailResponse|error {
        return api:getSubscriptionForOrg(value.org_id);
    }
    remote function CreateTier(api:CreateTierRequest value) returns api:CreateTierResponse|error {
        return api:createTier(value);
    }
    remote function CreateSubscription(api:CreateSubscriptionRequest value) returns api:CreateSubscriptionResponse|error {
        return api:createSubscription(value);
    }
    remote function CreateAttribute(api:CreateAttributeRequest value) returns api:CreateAttributeResponse|error {
        return api:createAttribute(value);
    }
}