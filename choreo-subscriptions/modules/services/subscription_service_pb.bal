// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/grpc;

public isolated client class SubscriptionServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR, getDescriptorMap());
    }

    isolated remote function GetTierDetails(GetTierDetailRequest|ContextGetTierDetailRequest req) returns (GetTierDetailResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetTierDetailRequest message;
        if (req is ContextGetTierDetailRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("subscription.services.SubscriptionService/GetTierDetails", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetTierDetailResponse>result;
    }

    isolated remote function GetTierDetailsContext(GetTierDetailRequest|ContextGetTierDetailRequest req) returns (ContextGetTierDetailResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetTierDetailRequest message;
        if (req is ContextGetTierDetailRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("subscription.services.SubscriptionService/GetTierDetails", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetTierDetailResponse>result, headers: respHeaders};
    }
}

public client class SubscriptionServiceGetTierDetailResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendGetTierDetailResponse(GetTierDetailResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextGetTierDetailResponse(ContextGetTierDetailResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }
}

public type ContextGetTierDetailRequest record {|
    GetTierDetailRequest content;
    map<string|string[]> headers;
|};

public type ContextGetTierDetailResponse record {|
    GetTierDetailResponse content;
    map<string|string[]> headers;
|};

const string ROOT_DESCRIPTOR = "0A1A737562736372697074696F6E5F736572766963652E70726F746F1215737562736372697074696F6E2E73657276696365731A1B737562736372697074696F6E5F6D657373616765732E70726F746F3284010A13537562736372697074696F6E53657276696365126D0A0E4765745469657244657461696C73122B2E737562736372697074696F6E2E6D657373616765732E4765745469657244657461696C526571756573741A2C2E737562736372697074696F6E2E6D657373616765732E4765745469657244657461696C526573706F6E73652200620670726F746F33";

isolated function getDescriptorMap() returns map<string> {
    return {"subscription_messages.proto": "0A1B737562736372697074696F6E5F6D657373616765732E70726F746F1215737562736372697074696F6E2E6D65737361676573222D0A144765745469657244657461696C5265717565737412150A066F72675F696418012001280952056F7267496422480A154765745469657244657461696C526573706F6E7365122F0A047469657218012001280B321B2E737562736372697074696F6E2E6D657373616765732E5469657252047469657222DE010A045469657212120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12120A04636F73741803200128095204636F7374121D0A0A637265617465645F6174180420012809520963726561746564417412230A0D736572766963655F71756F7461180520012805520C7365727669636551756F7461122B0A11696E746567726174696F6E5F71756F74611806200128055210696E746567726174696F6E51756F7461121B0A096170695F71756F7461180720012805520861706951756F7461620670726F746F33", "subscription_service.proto": "0A1A737562736372697074696F6E5F736572766963652E70726F746F1215737562736372697074696F6E2E73657276696365731A1B737562736372697074696F6E5F6D657373616765732E70726F746F3284010A13537562736372697074696F6E53657276696365126D0A0E4765745469657244657461696C73122B2E737562736372697074696F6E2E6D657373616765732E4765745469657244657461696C526571756573741A2C2E737562736372697074696F6E2E6D657373616765732E4765745469657244657461696C526573706F6E73652200620670726F746F33"};
}
