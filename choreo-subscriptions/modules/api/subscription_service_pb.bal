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

    isolated remote function CreateTier(CreateTierRequest|ContextCreateTierRequest req) returns (CreateTierResponse|grpc:Error) {
        map<string|string[]> headers = {};
        CreateTierRequest message;
        if (req is ContextCreateTierRequest) {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("subscription.services.SubscriptionService/CreateTier", message, headers);
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
        var payload = check self.grpcClient->executeSimpleRPC("subscription.services.SubscriptionService/CreateTier", message, headers);
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
        var payload = check self.grpcClient->executeSimpleRPC("subscription.services.SubscriptionService/CreateSubscription", message, headers);
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
        var payload = check self.grpcClient->executeSimpleRPC("subscription.services.SubscriptionService/CreateSubscription", message, headers);
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
        var payload = check self.grpcClient->executeSimpleRPC("subscription.services.SubscriptionService/CreateAttribute", message, headers);
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
        var payload = check self.grpcClient->executeSimpleRPC("subscription.services.SubscriptionService/CreateAttribute", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CreateAttributeResponse>result, headers: respHeaders};
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

public const string ROOT_DESCRIPTOR = "0A1A737562736372697074696F6E5F736572766963652E70726F746F1215737562736372697074696F6E2E73657276696365731A1B737562736372697074696F6E5F6D657373616765732E70726F746F32DA030A13537562736372697074696F6E53657276696365126D0A0E4765745469657244657461696C73122B2E737562736372697074696F6E2E6D657373616765732E4765745469657244657461696C526571756573741A2C2E737562736372697074696F6E2E6D657373616765732E4765745469657244657461696C526573706F6E7365220012630A0A4372656174655469657212282E737562736372697074696F6E2E6D657373616765732E43726561746554696572526571756573741A292E737562736372697074696F6E2E6D657373616765732E43726561746554696572526573706F6E73652200127B0A12437265617465537562736372697074696F6E12302E737562736372697074696F6E2E6D657373616765732E437265617465537562736372697074696F6E526571756573741A312E737562736372697074696F6E2E6D657373616765732E437265617465537562736372697074696F6E526573706F6E7365220012720A0F437265617465417474726962757465122D2E737562736372697074696F6E2E6D657373616765732E437265617465417474726962757465526571756573741A2E2E737562736372697074696F6E2E6D657373616765732E437265617465417474726962757465526573706F6E73652200620670726F746F33";

public isolated function getDescriptorMap() returns map<string> {
    return {"subscription_messages.proto": "0A1B737562736372697074696F6E5F6D657373616765732E70726F746F1215737562736372697074696F6E2E6D65737361676573222D0A144765745469657244657461696C5265717565737412150A066F72675F696418012001280952056F7267496422480A154765745469657244657461696C526573706F6E7365122F0A047469657218012001280B321B2E737562736372697074696F6E2E6D657373616765732E5469657252047469657222CC010A11437265617465546965725265717565737412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12120A04636F73741803200128095204636F737412230A0D736572766963655F71756F7461180420012805520C7365727669636551756F7461122B0A11696E746567726174696F6E5F71756F74611805200128055210696E746567726174696F6E51756F7461121B0A096170695F71756F7461180620012805520861706951756F746122450A1243726561746554696572526573706F6E7365122F0A047469657218012001280B321B2E737562736372697074696F6E2E6D657373616765732E546965725204746965722286010A19437265617465537562736372697074696F6E5265717565737412150A066F72675F696418012001280952056F7267496412170A07746965725F6964180220012809520674696572496412210A0C62696C6C696E675F64617465180320012809520B62696C6C696E674461746512160A06737461747573180420012809520673746174757322650A1A437265617465537562736372697074696F6E526573706F6E736512470A0C737562736372697074696F6E18012001280B32232E737562736372697074696F6E2E6D657373616765732E537562736372697074696F6E520C737562736372697074696F6E22780A1843726561746551756F74615265636F72645265717565737412170A07746965725F6964180120012809520674696572496412250A0E6174747269627574655F6E616D65180220012809520D6174747269627574654E616D65121C0A097468726573686F6C6418032001280552097468726573686F6C6422620A1943726561746551756F74615265636F7264526573706F6E736512450A0C71756F74615F7265636F726418012001280B32222E737562736372697074696F6E2E6D657373616765732E51756F74615265636F7264520B71756F74615265636F7264224E0A164372656174654174747269627574655265717565737412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E22590A17437265617465417474726962757465526573706F6E7365123E0A0961747472696275746518012001280B32202E737562736372697074696F6E2E6D657373616765732E417474726962757465520961747472696275746522EE010A0454696572120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12120A04636F73741804200128095204636F7374121D0A0A637265617465645F6174180520012809520963726561746564417412230A0D736572766963655F71756F7461180620012805520C7365727669636551756F7461122B0A11696E746567726174696F6E5F71756F74611807200128055210696E746567726174696F6E51756F7461121B0A096170695F71756F7461180820012805520861706951756F746122A8010A0C537562736372697074696F6E120E0A0269641801200128095202696412150A066F72675F696418022001280952056F7267496412170A07746965725F6964180320012809520674696572496412210A0C62696C6C696E675F64617465180420012809520B62696C6C696E674461746512160A067374617475731805200128095206737461747573121D0A0A637265617465645F61741806200128095209637265617465644174226B0A0B51756F74615265636F726412170A07746965725F6964180120012809520674696572496412250A0E6174747269627574655F6E616D65180220012809520D6174747269627574654E616D65121C0A097468726573686F6C6418032001280552097468726573686F6C6422700A09417474726962757465120E0A0269641801200128095202696412120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E121D0A0A637265617465645F61741804200128095209637265617465644174620670726F746F33", "subscription_service.proto": "0A1A737562736372697074696F6E5F736572766963652E70726F746F1215737562736372697074696F6E2E73657276696365731A1B737562736372697074696F6E5F6D657373616765732E70726F746F32DA030A13537562736372697074696F6E53657276696365126D0A0E4765745469657244657461696C73122B2E737562736372697074696F6E2E6D657373616765732E4765745469657244657461696C526571756573741A2C2E737562736372697074696F6E2E6D657373616765732E4765745469657244657461696C526573706F6E7365220012630A0A4372656174655469657212282E737562736372697074696F6E2E6D657373616765732E43726561746554696572526571756573741A292E737562736372697074696F6E2E6D657373616765732E43726561746554696572526573706F6E73652200127B0A12437265617465537562736372697074696F6E12302E737562736372697074696F6E2E6D657373616765732E437265617465537562736372697074696F6E526571756573741A312E737562736372697074696F6E2E6D657373616765732E437265617465537562736372697074696F6E526573706F6E7365220012720A0F437265617465417474726962757465122D2E737562736372697074696F6E2E6D657373616765732E437265617465417474726962757465526571756573741A2E2E737562736372697074696F6E2E6D657373616765732E437265617465417474726962757465526573706F6E73652200620670726F746F33"};
}
