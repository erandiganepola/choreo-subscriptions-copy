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

    remote function GetTiers() returns api:GetTiersResponse|error {
        return api:getTiers();
    }
    remote function GetTierDetailsForOrgId(api:GetTierDetailRequest value) returns api:GetTierDetailResponse|error {
        return api:getTierDetailsForOrgId(value.org_identifier);
    }
    remote function GetTierDetailsForOrgHandle(api:GetTierDetailRequest value) returns api:GetTierDetailResponse|error {
        return api:getTierDetailsForOrgHandle(value.org_identifier);
    }
    remote function GetSubscription(api:GetSubscriptionRequest value) returns api:GetSubscriptionResponse|error {
        return api:getSubscription(value.identifier);
    }
    remote function GetSubscriptionByOrgId(api:GetSubscriptionRequest value) returns api:GetSubscriptionResponse|error {
        return api:getSubscriptionByOrgId(value.identifier);
    }
    remote function GetSubscriptionByOrgHandle(api:GetSubscriptionRequest value) returns api:GetSubscriptionResponse|error {
        return api:getSubscriptionByOrgHandle(value.identifier);
    }
    remote function GetSubscriptionTierMappingForOrgId(api:SubscriptionTierMappingRequest value) returns api:SubscriptionTierMappingResponse|error {
        return api:getSubscriptionTierMappingForOrgId(value.org_identifier);
    }
    remote function GetSubscriptionTierMappings(api:SubscriptionTierMappingsRequest value) returns api:SubscriptionTierMappingsResponse|error {
        return api:getSubscriptionTierMappings(value.pagination.offset, value.pagination.'limit);
    }
    remote function CreateTier(api:CreateTierRequest value) returns api:CreateTierResponse|error {
        return api:createTier(value);
    }
    remote function CreateSubscription(api:CreateSubscriptionRequest value) returns api:CreateSubscriptionResponse|error {
        return api:createSubscription(value);
    }
    remote function UpdateSubscription(api:UpdateSubscriptionRequest value) returns api:UpdateSubscriptionResponse|error {
        return api:updateSubscription(value);
    }
    remote function DeleteSubscription(api:DeleteSubscriptionRequest value) returns api:DeleteSubscriptionResponse|error {
        return api:deleteSubscription(value.identifier);
    }
    remote function DeleteSubscriptionByOrgId(api:DeleteSubscriptionRequest value) returns api:DeleteSubscriptionResponse|error {
        return api:deleteSubscriptionByOrgId(value.identifier);
    }
    remote function DeleteSubscriptionByOrgHandle(api:DeleteSubscriptionRequest value) returns api:DeleteSubscriptionResponse|error {
        return api:deleteSubscriptionByOrgHandle(value.identifier);
    }
    remote function CreateAttribute(api:CreateAttributeRequest value) returns api:CreateAttributeResponse|error {
        return api:createAttribute(value);
    }
}
