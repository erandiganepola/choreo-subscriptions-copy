// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/grpc;

listener grpc:Listener ep = new (9091);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR, descMap: getDescriptorMap()}
service "SubscriptionService" on ep {

    remote function GetTierDetails(GetTierDetailRequest value) returns GetTierDetailResponse|error {
        return getSubscriptionForOrg(value.org_id);
    }
    remote function CreateTier(CreateTierRequest value) returns CreateTierResponse|error {
        return createTier(value);
    }
    remote function CreateSubscription(CreateSubscriptionRequest value) returns CreateSubscriptionResponse|error {
        return createSubscription(value);
    }
    remote function CreateQuotaRecord(CreateQuotaRecordRequest value) returns CreateQuotaRecordResponse|error {
        return createQuotaRecord(value);
    }
    remote function CreateAttribute(CreateAttributeRequest value) returns CreateAttributeResponse|error {
        return createAttribute(value);
    }
}
