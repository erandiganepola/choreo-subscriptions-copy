import ballerina/http;
import ballerina/io;
import choreo/choreo_subscriptions.services as _;

# Choreo Subscription service for manipulating Choreo subscriptions.
service /subscriptions on new http:Listener(9090) {

    # Get subscriptions
    #
    # + caller - the client invoking this resource
    # + request - the inbound request
    resource function get subscriptions(http:Caller caller, http:Request request) {

        // Send a response back to the caller.
        error? result = caller->respond("Hello Ballerina!");
        if (result is error) {
            io:println("Error in responding: ", result);
        }
    }
}
