// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/grpc;
import choreo_subscriptions.api;
import choreo_subscriptions.rpc;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: rpc:ROOT_DESCRIPTOR, descMap: rpc:getDescriptorMap()}
service "SubscriptionService" on ep {

    remote function GetTiers(rpc:GetTiersRequest value) returns rpc:GetTiersResponse|error {
        return api:getTiers(value.internal);
    }
    remote function GetTierDetailsForOrgId(rpc:GetTierDetailRequest value) returns rpc:GetTierDetailResponse|error {
        return api:getTierDetailsForOrgId(value.org_identifier);
    }
    remote function GetTierDetailsForOrgHandle(rpc:GetTierDetailRequest value) returns rpc:GetTierDetailResponse|error {
        return api:getTierDetailsForOrgHandle(value.org_identifier);
    }
    remote function GetSubscription(rpc:GetSubscriptionRequest value) returns rpc:GetSubscriptionResponse|error {
        return api:getSubscription(value.identifier);
    }
    remote function GetSubscriptionByOrgId(rpc:GetSubscriptionRequest value) returns rpc:GetSubscriptionResponse|error {
        return api:getSubscriptionByOrgId(value.identifier);
    }
    remote function GetSubscriptionByOrgHandle(rpc:GetSubscriptionRequest value) returns rpc:GetSubscriptionResponse|error {
        return api:getSubscriptionByOrgHandle(value.identifier);
    }
    remote function GetSubscriptionTierMappingForOrgId(rpc:SubscriptionTierMappingRequest value) returns rpc:SubscriptionTierMappingResponse|error {
        return api:getSubscriptionTierMappingForOrgId(value.org_identifier);
    }
    remote function GetSubscriptionTierMappings(rpc:SubscriptionTierMappingsRequest value) returns rpc:SubscriptionTierMappingsResponse|error {
        return api:getSubscriptionTierMappings(value.pagination.offset, value.pagination.'limit);
    }
    remote function CreateSubscription(rpc:CreateSubscriptionRequest value) returns rpc:CreateSubscriptionResponse|error {
        return api:createSubscription(value);
    }
    remote function UpdateSubscription(rpc:UpdateSubscriptionRequest value) returns rpc:UpdateSubscriptionResponse|error {
        return api:updateSubscription(value);
    }
    remote function DeleteSubscription(rpc:DeleteSubscriptionRequest value) returns rpc:DeleteSubscriptionResponse|error {
        return api:deleteSubscription(value.identifier);
    }
    remote function DeleteSubscriptionByOrgId(rpc:DeleteSubscriptionRequest value) returns rpc:DeleteSubscriptionResponse|error {
        return api:deleteSubscriptionByOrgId(value.identifier);
    }
    remote function DeleteSubscriptionByOrgHandle(rpc:DeleteSubscriptionRequest value) returns rpc:DeleteSubscriptionResponse|error {
        return api:deleteSubscriptionByOrgHandle(value.identifier);
    }
    remote function CreateAttribute(rpc:CreateAttributeRequest value) returns rpc:CreateAttributeResponse|error {
        return api:createAttribute(value);
    }
    remote function GetDailyStepUsageForOrgId(rpc:GetTotalStepCountRequest value) returns rpc:GetTotalStepCountResponse|error {
        return api:getDailyStepUsageForOrg(value);
    }
    remote function GetOrgIdSubItemIdMappings(rpc:GetOrgIdSubItemIdMappingsRequest value) returns rpc:GetOrgIdSubItemIdMappingsResponse|error {
        return api:getOrgIdSubItemIdMappings(value.pagination.offset, value.pagination.'limit);
    }
}
