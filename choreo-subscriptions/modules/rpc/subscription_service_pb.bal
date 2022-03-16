import ballerina/grpc;

public isolated client class SubscriptionServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR, getDescriptorMap());
    }

    isolated remote function GetTiers(GetTiersRequest|ContextGetTiersRequest req) returns (GetTiersResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetTiersRequest message;
        if (req is ContextGetTiersRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetTiers", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetTiersResponse>result;
    }

    isolated remote function GetTiersContext(GetTiersRequest|ContextGetTiersRequest req) returns (ContextGetTiersResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetTiersRequest message;
        if (req is ContextGetTiersRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetTiers", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetTiersResponse>result, headers: respHeaders};
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

    isolated remote function GetSubscription(GetSubscriptionRequest|ContextGetSubscriptionRequest req) returns (GetSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetSubscriptionRequest message;
        if (req is ContextGetSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetSubscription", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetSubscriptionResponse>result;
    }

    isolated remote function GetSubscriptionContext(GetSubscriptionRequest|ContextGetSubscriptionRequest req) returns (ContextGetSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetSubscriptionRequest message;
        if (req is ContextGetSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetSubscription", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetSubscriptionResponse>result, headers: respHeaders};
    }

    isolated remote function GetSubscriptionByOrgId(GetSubscriptionRequest|ContextGetSubscriptionRequest req) returns (GetSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetSubscriptionRequest message;
        if (req is ContextGetSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetSubscriptionByOrgId", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetSubscriptionResponse>result;
    }

    isolated remote function GetSubscriptionByOrgIdContext(GetSubscriptionRequest|ContextGetSubscriptionRequest req) returns (ContextGetSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetSubscriptionRequest message;
        if (req is ContextGetSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetSubscriptionByOrgId", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetSubscriptionResponse>result, headers: respHeaders};
    }

    isolated remote function GetSubscriptionByOrgHandle(GetSubscriptionRequest|ContextGetSubscriptionRequest req) returns (GetSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetSubscriptionRequest message;
        if (req is ContextGetSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetSubscriptionByOrgHandle", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetSubscriptionResponse>result;
    }

    isolated remote function GetSubscriptionByOrgHandleContext(GetSubscriptionRequest|ContextGetSubscriptionRequest req) returns (ContextGetSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetSubscriptionRequest message;
        if (req is ContextGetSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetSubscriptionByOrgHandle", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetSubscriptionResponse>result, headers: respHeaders};
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

    isolated remote function UpdateSubscription(UpdateSubscriptionRequest|ContextUpdateSubscriptionRequest req) returns (CreateSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        UpdateSubscriptionRequest message;
        if (req is ContextUpdateSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/UpdateSubscription", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CreateSubscriptionResponse>result;
    }

    isolated remote function UpdateSubscriptionContext(UpdateSubscriptionRequest|ContextUpdateSubscriptionRequest req) returns (ContextCreateSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        UpdateSubscriptionRequest message;
        if (req is ContextUpdateSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/UpdateSubscription", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CreateSubscriptionResponse>result, headers: respHeaders};
    }

    isolated remote function DeleteSubscription(DeleteSubscriptionRequest|ContextDeleteSubscriptionRequest req) returns (DeleteSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        DeleteSubscriptionRequest message;
        if (req is ContextDeleteSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/DeleteSubscription", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <DeleteSubscriptionResponse>result;
    }

    isolated remote function DeleteSubscriptionContext(DeleteSubscriptionRequest|ContextDeleteSubscriptionRequest req) returns (ContextDeleteSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        DeleteSubscriptionRequest message;
        if (req is ContextDeleteSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/DeleteSubscription", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <DeleteSubscriptionResponse>result, headers: respHeaders};
    }

    isolated remote function DeleteSubscriptionByOrgId(DeleteSubscriptionRequest|ContextDeleteSubscriptionRequest req) returns (DeleteSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        DeleteSubscriptionRequest message;
        if (req is ContextDeleteSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/DeleteSubscriptionByOrgId", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <DeleteSubscriptionResponse>result;
    }

    isolated remote function DeleteSubscriptionByOrgIdContext(DeleteSubscriptionRequest|ContextDeleteSubscriptionRequest req) returns (ContextDeleteSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        DeleteSubscriptionRequest message;
        if (req is ContextDeleteSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/DeleteSubscriptionByOrgId", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <DeleteSubscriptionResponse>result, headers: respHeaders};
    }

    isolated remote function DeleteSubscriptionByOrgHandle(DeleteSubscriptionRequest|ContextDeleteSubscriptionRequest req) returns (DeleteSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        DeleteSubscriptionRequest message;
        if (req is ContextDeleteSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/DeleteSubscriptionByOrgHandle", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <DeleteSubscriptionResponse>result;
    }

    isolated remote function DeleteSubscriptionByOrgHandleContext(DeleteSubscriptionRequest|ContextDeleteSubscriptionRequest req) returns (ContextDeleteSubscriptionResponse|grpc:Error) {
        map<string|string[]> headers = {};
        DeleteSubscriptionRequest message;
        if (req is ContextDeleteSubscriptionRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/DeleteSubscriptionByOrgHandle", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <DeleteSubscriptionResponse>result, headers: respHeaders};
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

    isolated remote function GetDailyStepUsageForOrgId(GetTotalStepCountRequest|ContextGetTotalStepCountRequest req) returns (GetTotalStepCountResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetTotalStepCountRequest message;
        if (req is ContextGetTotalStepCountRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetDailyStepUsageForOrgId", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetTotalStepCountResponse>result;
    }

    isolated remote function GetDailyStepUsageForOrgIdContext(GetTotalStepCountRequest|ContextGetTotalStepCountRequest req) returns (ContextGetTotalStepCountResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetTotalStepCountRequest message;
        if (req is ContextGetTotalStepCountRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetDailyStepUsageForOrgId", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetTotalStepCountResponse>result, headers: respHeaders};
    }

    isolated remote function GetOrgIdSubItemIdMappings(GetOrgIdSubItemIdMappingsRequest|ContextGetOrgIdSubItemIdMappingsRequest req) returns (GetOrgIdSubItemIdMappingsResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetOrgIdSubItemIdMappingsRequest message;
        if (req is ContextGetOrgIdSubItemIdMappingsRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetOrgIdSubItemIdMappings", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <GetOrgIdSubItemIdMappingsResponse>result;
    }

    isolated remote function GetOrgIdSubItemIdMappingsContext(GetOrgIdSubItemIdMappingsRequest|ContextGetOrgIdSubItemIdMappingsRequest req) returns (ContextGetOrgIdSubItemIdMappingsResponse|grpc:Error) {
        map<string|string[]> headers = {};
        GetOrgIdSubItemIdMappingsRequest message;
        if (req is ContextGetOrgIdSubItemIdMappingsRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("choreo.service.subscriptions.v1.SubscriptionService/GetOrgIdSubItemIdMappings", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <GetOrgIdSubItemIdMappingsResponse>result, headers: respHeaders};
    }
}

public client class SubscriptionServiceGetTotalStepCountResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendGetTotalStepCountResponse(GetTotalStepCountResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextGetTotalStepCountResponse(ContextGetTotalStepCountResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
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

public client class SubscriptionServiceGetTiersResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendGetTiersResponse(GetTiersResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextGetTiersResponse(ContextGetTiersResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }
}

public client class SubscriptionServiceDeleteSubscriptionResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendDeleteSubscriptionResponse(DeleteSubscriptionResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextDeleteSubscriptionResponse(ContextDeleteSubscriptionResponse response) returns grpc:Error? {
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

public client class SubscriptionServiceGetOrgIdSubItemIdMappingsResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendGetOrgIdSubItemIdMappingsResponse(GetOrgIdSubItemIdMappingsResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextGetOrgIdSubItemIdMappingsResponse(ContextGetOrgIdSubItemIdMappingsResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }
}

public client class SubscriptionServiceGetSubscriptionResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendGetSubscriptionResponse(GetSubscriptionResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextGetSubscriptionResponse(ContextGetSubscriptionResponse response) returns grpc:Error? {
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

public type ContextGetTiersResponse record {|
    GetTiersResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateAttributeRequest record {|
    CreateAttributeRequest content;
    map<string|string[]> headers;
|};

public type ContextGetSubscriptionResponse record {|
    GetSubscriptionResponse content;
    map<string|string[]> headers;
|};

public type ContextSubscriptionTierMappingsResponse record {|
    SubscriptionTierMappingsResponse content;
    map<string|string[]> headers;
|};

public type ContextUpdateSubscriptionRequest record {|
    UpdateSubscriptionRequest content;
    map<string|string[]> headers;
|};

public type ContextGetOrgIdSubItemIdMappingsRequest record {|
    GetOrgIdSubItemIdMappingsRequest content;
    map<string|string[]> headers;
|};

public type ContextGetTiersRequest record {|
    GetTiersRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateSubscriptionRequest record {|
    CreateSubscriptionRequest content;
    map<string|string[]> headers;
|};

public type ContextGetTotalStepCountResponse record {|
    GetTotalStepCountResponse content;
    map<string|string[]> headers;
|};

public type ContextGetTierDetailRequest record {|
    GetTierDetailRequest content;
    map<string|string[]> headers;
|};

public type ContextDeleteSubscriptionRequest record {|
    DeleteSubscriptionRequest content;
    map<string|string[]> headers;
|};

public type ContextGetTotalStepCountRequest record {|
    GetTotalStepCountRequest content;
    map<string|string[]> headers;
|};

public type ContextDeleteSubscriptionResponse record {|
    DeleteSubscriptionResponse content;
    map<string|string[]> headers;
|};

public type ContextGetSubscriptionRequest record {|
    GetSubscriptionRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateSubscriptionResponse record {|
    CreateSubscriptionResponse content;
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

public type ContextGetOrgIdSubItemIdMappingsResponse record {|
    GetOrgIdSubItemIdMappingsResponse content;
    map<string|string[]> headers;
|};

public const string ROOT_DESCRIPTOR = "0A13737562736372697074696F6E732E70726F746F121F63686F72656F2E736572766963652E737562736372697074696F6E732E76311A0B74797065732E70726F746F32D7120A13537562736372697074696F6E5365727669636512710A08476574546965727312302E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657273526571756573741A312E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657273526573706F6E736522001289010A164765745469657244657461696C73466F724F7267496412352E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526571756573741A362E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526573706F6E73652200128D010A1A4765745469657244657461696C73466F724F726748616E646C6512352E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526571756573741A362E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526573706F6E736522001286010A0F476574537562736372697074696F6E12372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526571756573741A382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526573706F6E73652200128D010A16476574537562736372697074696F6E42794F7267496412372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526571756573741A382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526573706F6E736522001291010A1A476574537562736372697074696F6E42794F726748616E646C6512372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526571756573741A382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526573706F6E7365220012A9010A22476574537562736372697074696F6E546965724D617070696E67466F724F72674964123F2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E67526571756573741A402E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E67526573706F6E7365220012A4010A1B476574537562736372697074696F6E546965724D617070696E677312402E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E6773526571756573741A412E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E6773526573706F6E73652200128F010A12437265617465537562736372697074696F6E123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465537562736372697074696F6E526573706F6E73652200128F010A12557064617465537562736372697074696F6E123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E557064617465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465537562736372697074696F6E526573706F6E73652200128F010A1244656C657465537562736372697074696F6E123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526573706F6E736522001296010A1944656C657465537562736372697074696F6E42794F72674964123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526573706F6E73652200129A010A1D44656C657465537562736372697074696F6E42794F726748616E646C65123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526573706F6E736522001286010A0F43726561746541747472696275746512372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465417474726962757465526571756573741A382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465417474726962757465526573706F6E736522001294010A194765744461696C79537465705573616765466F724F7267496412392E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574546F74616C53746570436F756E74526571756573741A3A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574546F74616C53746570436F756E74526573706F6E7365220012A4010A194765744F726749645375624974656D49644D617070696E677312412E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765744F726749645375624974656D49644D617070696E6773526571756573741A422E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765744F726749645375624974656D49644D617070696E6773526573706F6E7365220042475A456769746875622E636F6D2F77736F322D656E74657270726973652F63686F72656F2D6170692F63686F72656F2F736572766963652F737562736372697074696F6E732F7631620670726F746F33";

public isolated function getDescriptorMap() returns map<string> {
    return {"subscriptions.proto": "0A13737562736372697074696F6E732E70726F746F121F63686F72656F2E736572766963652E737562736372697074696F6E732E76311A0B74797065732E70726F746F32D7120A13537562736372697074696F6E5365727669636512710A08476574546965727312302E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657273526571756573741A312E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657273526573706F6E736522001289010A164765745469657244657461696C73466F724F7267496412352E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526571756573741A362E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526573706F6E73652200128D010A1A4765745469657244657461696C73466F724F726748616E646C6512352E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526571756573741A362E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765745469657244657461696C526573706F6E736522001286010A0F476574537562736372697074696F6E12372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526571756573741A382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526573706F6E73652200128D010A16476574537562736372697074696F6E42794F7267496412372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526571756573741A382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526573706F6E736522001291010A1A476574537562736372697074696F6E42794F726748616E646C6512372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526571756573741A382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574537562736372697074696F6E526573706F6E7365220012A9010A22476574537562736372697074696F6E546965724D617070696E67466F724F72674964123F2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E67526571756573741A402E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E67526573706F6E7365220012A4010A1B476574537562736372697074696F6E546965724D617070696E677312402E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E6773526571756573741A412E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E6773526573706F6E73652200128F010A12437265617465537562736372697074696F6E123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465537562736372697074696F6E526573706F6E73652200128F010A12557064617465537562736372697074696F6E123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E557064617465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465537562736372697074696F6E526573706F6E73652200128F010A1244656C657465537562736372697074696F6E123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526573706F6E736522001296010A1944656C657465537562736372697074696F6E42794F72674964123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526573706F6E73652200129A010A1D44656C657465537562736372697074696F6E42794F726748616E646C65123A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526571756573741A3B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E44656C657465537562736372697074696F6E526573706F6E736522001286010A0F43726561746541747472696275746512372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465417474726962757465526571756573741A382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E437265617465417474726962757465526573706F6E736522001294010A194765744461696C79537465705573616765466F724F7267496412392E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574546F74616C53746570436F756E74526571756573741A3A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E476574546F74616C53746570436F756E74526573706F6E7365220012A4010A194765744F726749645375624974656D49644D617070696E677312412E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765744F726749645375624974656D49644D617070696E6773526571756573741A422E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4765744F726749645375624974656D49644D617070696E6773526573706F6E7365220042475A456769746875622E636F6D2F77736F322D656E74657270726973652F63686F72656F2D6170692F63686F72656F2F736572766963652F737562736372697074696F6E732F7631620670726F746F33", "types.proto": "0A0B74797065732E70726F746F121F63686F72656F2E736572766963652E737562736372697074696F6E732E7631222D0A0F476574546965727352657175657374121A0A08696E7465726E616C1801200128085208696E7465726E616C22630A104765745469657273526573706F6E736512140A05636F756E741801200128055205636F756E7412390A046C69737418022003280B32252E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E5469657252046C697374223D0A144765745469657244657461696C5265717565737412250A0E6F72675F6964656E746966696572180120012809520D6F72674964656E74696669657222520A154765745469657244657461696C526573706F6E736512390A047469657218012001280B32252E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E5469657252047469657222380A16476574537562736372697074696F6E52657175657374121E0A0A6964656E746966696572180120012809520A6964656E746966696572226C0A17476574537562736372697074696F6E526573706F6E736512510A0C737562736372697074696F6E18012001280B322D2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E520C737562736372697074696F6E22470A1E537562736372697074696F6E546965724D617070696E675265717565737412250A0E6F72675F6964656E746966696572180120012809520D6F72674964656E7469666965722297010A1F537562736372697074696F6E546965724D617070696E67526573706F6E736512740A19737562736372697074696F6E5F746965725F6D617070696E6718012001280B32382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E675217737562736372697074696F6E546965724D617070696E67226E0A1F537562736372697074696F6E546965724D617070696E677352657175657374124B0A0A706167696E6174696F6E18012001280B322B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E506167696E6174696F6E520A706167696E6174696F6E22E8010A20537562736372697074696F6E546965724D617070696E6773526573706F6E736512770A1A737562736372697074696F6E5F746965725F6D617070696E677318012001280B32392E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E67735218737562736372697074696F6E546965724D617070696E6773124B0A0A706167696E6174696F6E18022001280B322B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E506167696E6174696F6E520A706167696E6174696F6E224E0A11437265617465546965725265717565737412390A047469657218012001280B32252E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E54696572520474696572224F0A1243726561746554696572526573706F6E736512390A047469657218012001280B32252E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E54696572520474696572226E0A19437265617465537562736372697074696F6E5265717565737412510A0C737562736372697074696F6E18012001280B322D2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E520C737562736372697074696F6E226E0A19557064617465537562736372697074696F6E5265717565737412510A0C737562736372697074696F6E18012001280B322D2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E520C737562736372697074696F6E226F0A1A557064617465537562736372697074696F6E526573706F6E736512510A0C737562736372697074696F6E18012001280B322D2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E520C737562736372697074696F6E223B0A1944656C657465537562736372697074696F6E52657175657374121E0A0A6964656E746966696572180120012809520A6964656E746966696572223C0A1A44656C657465537562736372697074696F6E526573706F6E7365121E0A0A6964656E746966696572180120012809520A6964656E746966696572226F0A1A437265617465537562736372697074696F6E526573706F6E736512510A0C737562736372697074696F6E18012001280B322D2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E520C737562736372697074696F6E22620A164372656174654174747269627574655265717565737412480A0961747472696275746518012001280B322A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E417474726962757465520961747472696275746522630A17437265617465417474726962757465526573706F6E736512480A0961747472696275746518012001280B322A2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4174747269627574655209617474726962757465226F0A204765744F726749645375624974656D49644D617070696E677352657175657374124B0A0A706167696E6174696F6E18012001280B322B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E506167696E6174696F6E520A706167696E6174696F6E22E1010A214765744F726749645375624974656D49644D617070696E6773526573706F6E7365126F0A186F72675F7375625F6974656D5F69645F6D617070696E677318012001280B32372E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4F726749645375624974656D49644D617070696E677352146F72675375624974656D49644D617070696E6773124B0A0A706167696E6174696F6E18022001280B322B2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E506167696E6174696F6E520A706167696E6174696F6E22D9010A0454696572120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12170A0769735F706169641804200128085206697350616964121D0A0A637265617465645F61741805200128035209637265617465644174122A0A1172756E6E696E675F6170705F71756F7461180620012805520F72756E6E696E6741707051756F746112270A0F636F6D706F6E656E745F71756F7461180720012805520E636F6D706F6E656E7451756F746122B1020A0C537562736372697074696F6E120E0A0269641801200128095202696412150A066F72675F696418022001280952056F72674964121D0A0A6F72675F68616E646C6518032001280952096F726748616E646C6512170A07746965725F6964180420012809520674696572496412210A0C62696C6C696E675F64617465180520012803520B62696C6C696E674461746512160A067374617475731806200128095206737461747573121D0A0A637265617465645F6174180720012803520963726561746564417412300A14737562736372697074696F6E5F6974656D5F69641808200128095212737562736372697074696F6E4974656D496412170A0769735F706169641809200128085206697350616964121D0A0A737465705F71756F7461180A2001280552097374657051756F746122700A09417474726962757465120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E121D0A0A637265617465645F6174180420012803520963726561746564417422E0010A17537562736372697074696F6E546965724D617070696E6712150A066F72675F696418012001280952056F72674964121D0A0A6F72675F68616E646C6518022001280952096F726748616E646C6512170A07746965725F69641803200128095206746965724964121B0A09746965725F6E616D651804200128095208746965724E616D6512210A0C62696C6C696E675F64617465180520012803520B62696C6C696E674461746512170A0769735F706169641806200128085206697350616964121D0A0A737465705F71756F746118072001280552097374657051756F74612292010A18537562736372697074696F6E546965724D617070696E677312760A1A737562736372697074696F6E5F746965725F6D617070696E677318012003280B32382E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E537562736372697074696F6E546965724D617070696E675218737562736372697074696F6E546965724D617070696E677322500A0A506167696E6174696F6E12160A066F666673657418012001280552066F666673657412140A056C696D697418022001280552056C696D697412140A05746F74616C1803200128055205746F74616C227B0A18476574546F74616C53746570436F756E745265717565737412250A0E6F72675F6964656E746966696572180120012809520D6F72674964656E746966696572121D0A0A73746172745F64617465180220012809520973746172744461746512190A08656E645F646174651803200128095207656E644461746522760A19476574546F74616C53746570436F756E74526573706F6E736512590A10746F74616C5F737465705F636F756E7418012003280B322F2E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E546F74616C53746570436F756E74520E746F74616C53746570436F756E74224E0A0E546F74616C53746570436F756E74121D0A0A73746172745F646174651801200128095209737461727444617465121D0A0A737465705F636F756E74180220012805520973746570436F756E7422600A154F726749645375624974656D49644D617070696E6712150A066F72675F696418012001280952056F7267496412300A14737562736372697074696F6E5F6974656D5F69641802200128095212737562736372697074696F6E4974656D49642288010A164F726749645375624974656D49644D617070696E6773126E0A186F72675F7375625F6974656D5F69645F6D617070696E677318012003280B32362E63686F72656F2E736572766963652E737562736372697074696F6E732E76312E4F726749645375624974656D49644D617070696E6752146F72675375624974656D49644D617070696E6773620670726F746F33"};
}

