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

    isolated remote function GetTierDetailsForOrgId(GetTierDetailRequest|ContextGetTierDetailRequest req) returns (GetTierDetailResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetTierDetailRequest message;
        if (req is ContextGetTierDetailRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetTierDetailsForOrgId", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetTierDetailResponse>result;
    }

    isolated remote function GetTierDetailsForOrgIdContext(GetTierDetailRequest|ContextGetTierDetailRequest req) returns (ContextGetTierDetailResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetTierDetailRequest message;
        if (req is ContextGetTierDetailRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetTierDetailsForOrgId", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetTierDetailResponse>result, headers: respHeaders};
    }

    isolated remote function GetTierDetailsForOrgHandle(GetTierDetailRequest|ContextGetTierDetailRequest req) returns (GetTierDetailResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetTierDetailRequest message;
        if (req is ContextGetTierDetailRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetTierDetailsForOrgHandle", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetTierDetailResponse>result;
    }

    isolated remote function GetTierDetailsForOrgHandleContext(GetTierDetailRequest|ContextGetTierDetailRequest req) returns (ContextGetTierDetailResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetTierDetailRequest message;
        if (req is ContextGetTierDetailRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetTierDetailsForOrgHandle", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetTierDetailResponse>result, headers: respHeaders};
    }

    isolated remote function GetSubscriptionTierMappingForOrgId(SubscriptionTierMappingRequest|ContextSubscriptionTierMappingRequest req) returns (SubscriptionTierMappingResponse|grpc:Error) {
        map<string|string[]> headers = {};
        SubscriptionTierMappingRequest message;
        if (req is ContextSubscriptionTierMappingRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetSubscriptionTierMappingForOrgId", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SubscriptionTierMappingResponse>result;
    }

    isolated remote function GetSubscriptionTierMappingForOrgIdContext(SubscriptionTierMappingRequest|ContextSubscriptionTierMappingRequest req) returns (ContextSubscriptionTierMappingResponse|grpc:Error) {
        map<string|string[]> headers = {};
        SubscriptionTierMappingRequest message;
        if (req is ContextSubscriptionTierMappingRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetSubscriptionTierMappingForOrgId", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SubscriptionTierMappingResponse>result, headers: respHeaders};
    }

    isolated remote function GetSubscriptionTierMappings(SubscriptionTierMappingsRequest|ContextSubscriptionTierMappingsRequest req) returns (SubscriptionTierMappingsResponse|grpc:Error) {
        map<string|string[]> headers = {};
        SubscriptionTierMappingsRequest message;
        if (req is ContextSubscriptionTierMappingsRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetSubscriptionTierMappings", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SubscriptionTierMappingsResponse>result;
    }

    isolated remote function GetSubscriptionTierMappingsContext(SubscriptionTierMappingsRequest|ContextSubscriptionTierMappingsRequest req) returns (ContextSubscriptionTierMappingsResponse|grpc:Error) {
        map<string|string[]> headers = {};
        SubscriptionTierMappingsRequest message;
        if (req is ContextSubscriptionTierMappingsRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetSubscriptionTierMappings", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SubscriptionTierMappingsResponse>result, headers: respHeaders};
    }

    isolated remote function CreateTier(CreateTierRequest|ContextCreateTierRequest req) returns (CreateTierResponse|grpc:Error) {
        map<string|string[]> headers = {};
        CreateTierRequest message;
        if (req is ContextCreateTierRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/CreateTier", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CreateTierResponse>result;
    }

    isolated remote function CreateTierContext(CreateTierRequest|ContextCreateTierRequest req) returns (ContextCreateTierResponse|grpc:Error) {
        map<string|string[]> headers = {};
        CreateTierRequest message;
        if (req is ContextCreateTierRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/CreateTier", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CreateTierResponse>result, headers: respHeaders};
    }

    isolated remote function CreateSubscription(CreateSubscriptionRequest|ContextCreateSubscriptionRequest req) returns (CreateSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        CreateSubscriptionRequest message;
        if (req is ContextCreateSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/CreateSubscription", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CreateSubscriptionResponse>result;
    }

    isolated remote function CreateSubscriptionContext(CreateSubscriptionRequest|ContextCreateSubscriptionRequest req) returns (ContextCreateSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        CreateSubscriptionRequest message;
        if (req is ContextCreateSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/CreateSubscription", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CreateSubscriptionResponse>result, headers: respHeaders};
    }

    isolated remote function CreateAttribute(CreateAttributeRequest|ContextCreateAttributeRequest req) returns (CreateAttributeResponse|grpc:Error) {
        map<string|string[]> headers = {};
        CreateAttributeRequest message;
        if (req is ContextCreateAttributeRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/CreateAttribute", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CreateAttributeResponse>result;
    }

    isolated remote function CreateAttributeContext(CreateAttributeRequest|ContextCreateAttributeRequest req) returns (ContextCreateAttributeResponse|grpc:Error) {
        map<string|string[]> headers = {};
        CreateAttributeRequest message;
        if (req is ContextCreateAttributeRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/CreateAttribute", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CreateAttributeResponse>result, headers: respHeaders};
    }
}

public client class SubscriptionServiceSubscriptionTierMappingsResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendSubscriptionTierMappingsResponse(SubscriptionTierMappingsResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextSubscriptionTierMappingsResponse(ContextSubscriptionTierMappingsResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }
}

public client class SubscriptionServiceSubscriptionTierMappingResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendSubscriptionTierMappingResponse(SubscriptionTierMappingResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextSubscriptionTierMappingResponse(ContextSubscriptionTierMappingResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
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

public client class SubscriptionServiceCreateSubscriptionResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateSubscriptionResponse(CreateSubscriptionResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateSubscriptionResponse(ContextCreateSubscriptionResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }
}

public client class SubscriptionServiceCreateAttributeResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateAttributeResponse(CreateAttributeResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateAttributeResponse(ContextCreateAttributeResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }
}

public client class SubscriptionServiceCreateTierResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateTierResponse(CreateTierResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateTierResponse(ContextCreateTierResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }
}

public type ContextSubscriptionTierMappingsRequest record {|
    SubscriptionTierMappingsRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateTierResponse record {|
    CreateTierResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateTierRequest record {|
    CreateTierRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateAttributeRequest record {|
    CreateAttributeRequest content;
    map<string|string[]> headers;
|};

public type ContextSubscriptionTierMappingsResponse record {|
    SubscriptionTierMappingsResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateSubscriptionRequest record {|
    CreateSubscriptionRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateSubscriptionResponse record {|
    CreateSubscriptionResponse content;
    map<string|string[]> headers;
|};

public type ContextGetTierDetailRequest record {|
    GetTierDetailRequest content;
    map<string|string[]> headers;
|};

public type ContextGetTierDetailResponse record {|
    GetTierDetailResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateAttributeResponse record {|
    CreateAttributeResponse content;
    map<string|string[]> headers;
|};

public type ContextSubscriptionTierMappingResponse record {|
    SubscriptionTierMappingResponse content;
    map<string|string[]> headers;
|};

public type ContextSubscriptionTierMappingRequest record {|
    SubscriptionTierMappingRequest content;
    map<string|string[]> headers;
|};

public const string ROOT_DESCRIPTOR = "0A13737562736372697074696F6E732E70726F746F121F63686F72656F2E736572766963652E737562736372697074696F6E732E76311A0B74797065732E70726F746F3298080A13537562736372697074696F6E536572766963651289010A164765745469657244657461696C73466F724F7267496412352E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526571756573741A362E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526573706F6E73652200128D010A1A4765745469657244657461696C73466F724F726748616E646C6512352E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526571756573741A362E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526573706F6E7365220012A9010A22476574537562736372697074696F6E546965724D617070696E67466F724F72674964123F2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E67526571756573741A402E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E67526573706F6E7365220012A4010A1B476574537562736372697074696F6E546965724D617070696E677312402E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E6773526571756573741A412E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E6773526573706F6E7365220012770A0A4372656174655469657212322E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E43726561746554696572526571756573741A332E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E43726561746554696572526573706F6E73652200128F010A12437265617465537562736372697074696F6E123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465537562736372697074696F6E526573706F6E736522001286010A0F43726561746541747472696275746512372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465417474726962757465526571756573741A382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465417474726962757465526573706F6E7365220042475A456769746875622E636F6D2F77736F322D656E74657270726973652F63686F72656F2D6170692F63686F72656F2F736572766963652F737562736372697074696F6E732F7631620670726F746F33";

public isolated function getDescriptorMap() returns map<string> {
    return {"subscriptions.proto": "0A13737562736372697074696F6E732E70726F746F121F63686F72656F2E736572766963652E737562736372697074696F6E732E76311A0B74797065732E70726F746F3298080A13537562736372697074696F6E536572766963651289010A164765745469657244657461696C73466F724F7267496412352E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526571756573741A362E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526573706F6E73652200128D010A1A4765745469657244657461696C73466F724F726748616E646C6512352E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526571756573741A362E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526573706F6E7365220012A9010A22476574537562736372697074696F6E546965724D617070696E67466F724F72674964123F2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E67526571756573741A402E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E67526573706F6E7365220012A4010A1B476574537562736372697074696F6E546965724D617070696E677312402E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E6773526571756573741A412E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E6773526573706F6E7365220012770A0A4372656174655469657212322E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E43726561746554696572526571756573741A332E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E43726561746554696572526573706F6E73652200128F010A12437265617465537562736372697074696F6E123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465537562736372697074696F6E526573706F6E736522001286010A0F43726561746541747472696275746512372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465417474726962757465526571756573741A382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465417474726962757465526573706F6E7365220042475A456769746875622E636F6D2F77736F322D656E74657270726973652F63686F72656F2D6170692F63686F72656F2F736572766963652F737562736372697074696F6E732F7631620670726F746F33", "types.proto": "0A0B74797065732E70726F746F121F63686F72656F2E736572766963652E737562736372697074696F6E732E7631223D0A144765745469657244657461696C5265717565737412250A0E6F72675F6964656E746966696572180120012809520D6F72674964656E74696669657222520A154765745469657244657461696C526573706F6E736512390A047469657218012001280B32252E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E5469657252047469657222470A1E537562736372697074696F6E546965724D617070696E675265717565737412250A0E6F72675F6964656E746966696572180120012809520D6F72674964656E7469666965722297010A1F537562736372697074696F6E546965724D617070696E67526573706F6E736512740A19737562736372697074696F6E5F746965725F6D617070696E6718012001280B32382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E675217737562736372697074696F6E546965724D617070696E67224F0A1F537562736372697074696F6E546965724D617070696E67735265717565737412160A066F666673657418012001280552066F666673657412140A056C696D697418022001280552056C696D697422E8010A20537562736372697074696F6E546965724D617070696E6773526573706F6E736512770A1A737562736372697074696F6E5F746965725F6D617070696E677318012001280B32392E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E67735218737562736372697074696F6E546965724D617070696E6773124B0A0A706167696E6174696F6E18022001280B322B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E506167696E6174696F6E520A706167696E6174696F6E224E0A11437265617465546965725265717565737412390A047469657218012001280B32252E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E54696572520474696572224F0A1243726561746554696572526573706F6E736512390A047469657218012001280B32252E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E54696572520474696572226E0A19437265617465537562736372697074696F6E5265717565737412510A0C737562736372697074696F6E18012001280B322D2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E520C737562736372697074696F6E226F0A1A437265617465537562736372697074696F6E526573706F6E736512510A0C737562736372697074696F6E18012001280B322D2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E520C737562736372697074696F6E22620A164372656174654174747269627574655265717565737412480A0961747472696275746518012001280B322A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E417474726962757465520961747472696275746522630A17437265617465417474726962757465526573706F6E736512480A0961747472696275746518012001280B322A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E417474726962757465520961747472696275746522B7020A0454696572120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12120A04636F73741804200128055204636F7374121D0A0A637265617465645F6174180520012803520963726561746564417412230A0D736572766963655F71756F7461180620012805520C7365727669636551756F7461122B0A11696E746567726174696F6E5F71756F74611807200128055210696E746567726174696F6E51756F7461121B0A096170695F71756F7461180820012805520861706951756F746112280A1072656D6F74655F6170705F71756F7461180920012805520E72656D6F746541707051756F7461121D0A0A737465705F71756F7461180A2001280552097374657051756F746122C7010A0C537562736372697074696F6E120E0A0269641801200128095202696412150A066F72675F696418022001280952056F72674964121D0A0A6F72675F68616E646C6518032001280952096F726748616E646C6512170A07746965725F6964180420012809520674696572496412210A0C62696C6C696E675F64617465180520012803520B62696C6C696E674461746512160A067374617475731806200128095206737461747573121D0A0A637265617465645F6174180720012803520963726561746564417422700A09417474726962757465120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E121D0A0A637265617465645F6174180420012803520963726561746564417422C7010A17537562736372697074696F6E546965724D617070696E6712150A066F72675F696418012001280952056F72674964121D0A0A6F72675F68616E646C6518022001280952096F726748616E646C6512170A07746965725F69641803200128095206746965724964121B0A09746965725F6E616D651804200128095208746965724E616D6512210A0C62696C6C696E675F64617465180520012803520B62696C6C696E6744617465121D0A0A737465705F71756F746118062001280552097374657051756F74612292010A18537562736372697074696F6E546965724D617070696E677312760A1A737562736372697074696F6E5F746965725F6D617070696E677318012003280B32382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E675218737562736372697074696F6E546965724D617070696E677322500A0A506167696E6174696F6E12160A066F666673657418012001280552066F666673657412140A056C696D697418022001280552056C696D697412140A05746F74616C1803200128055205746F74616C620670726F746F33"};
}
