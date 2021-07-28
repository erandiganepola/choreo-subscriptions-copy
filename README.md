# Choreo Subscriptions
Choreo Subscriptions microservice is the interface to retrieve and manipulate Choreo customer subscriptions.

## Prerequisites
- Ballerina Swan Lake Beta 1
- MSSQL database
- Redis Cache
- Make
- Docker

## Developer Guide
This section explains the required steps for running and testing this service locally.
First clone this repository and get into the root directory. Here onwards the root directory will be referred as `Choreo_Subscriptions_Home`.

### Test
In order to run the unit tests execute the following command from `Choreo_Subscriptions_Home`.

```sh
make test
```

### Build Locally
In order to build the service execute the following command from `Choreo_Subscriptions_Home`.

```sh
make build
```

### Running locally
Subscription service uses MSSQL database to persist the subscription information. Also uses Redis cache for quick retrieval of subscription information of a particular organizaiton. Hence this requires both services running locally in order to run the subscription service without issues.

#### Configurations
There are two ways to provide the configurations for the service
1. You can directly add the configurations to the default configuraton file can be found at `Choreo_Subscriptions_Home/choreo-subscriptions/Config.toml`. Then build the service with the modified configurations.

2. You can take a copy of the configuration file resides in `Choreo_Subscriptions_Home/choreo-subscriptions/Config.toml` and do the modifications and provide the path of the modified file as an envrionment variable with the key of `BAL_CONFIG_FILES`

#### Secret Configurations
The credentials for the MSSQL Server and Redis Cache are not provided via the config file to avoid keeping them there in plain text format. Hence you have to set the following two environment variable keys to the password of MSSQL Server and Redis Cache.

```
DB_PASSWORD=<MSSQL Server Password>
CACHE_PASSWORD=<Redis Cache Password>
```
#### Database initialization
In order to create the required schemas in the database, navigate to `Choreo_Subscriptions_Home/choreo-subscriptions/scripts/database` and execute the following command

`sqlcmd -S <database host name> -U <database user name> -i mssql.sql`
Provide the corresponding database password when prompted.

For example with default configurations:
`sqlcmd -S localhost -U SA -i mssql.sql`

Now the schemas would have been generated. In order to invoke the endpoints and test we should have some tiers and subscriptions created in the database. To do that execute the following command from the same directory.

`sqlcmd -S <database host name> -U <database user name> -i sample-data.sql`
Provide the corresponding database password when prompted.

Now organization ids `0000` and `1111` will be available with Free Tier and Enterprise Tier subscriptions respectively.

#### Run
After completing the above configurations you can start the service with one of the following commands.
```
bal run <path to jar file>
java -jar <path to jar file>
```
`ex: bal run choreo-subscriptions/target/bin/choreo-subscriptions.jar`

You will get the following logs printed when the service starts successfully.

```
[ballerina/http] started HTTP/WS listener 172.19.0.1:39133
[ballerina/grpc] started HTTP/WS listener 0.0.0.0:9090
[ballerina/http] started HTTP/WS listener 0.0.0.0:9092
[ballerina/http] started HTTP/WS listener 0.0.0.0:9091
```

The gRPC protofiles for the service can be found [here](https://github.com/wso2-enterprise/choreo-api/tree/main/choreo/service/subscriptions/v1).

You can construct the request using those protofiles and test the service. These tools [grpcurl](https://github.com/fullstorydev/grpcurl), [BloomRPC](https://github.com/uw-labs/bloomrpc) might be useful to acheive this. Follow these steps to trigger a gRPC endpoint.

1. Clone the proto [repository](https://github.com/wso2-enterprise/choreo-api). Here onwards will refer the cloned root directory as `Choreo_Api_Home`.

2. Navigate to `Choreo_Api_Home/choreo/service/subscription/v1`.

3. Execute the following command

```sh
grpcurl -plaintext \
    -proto subscriptions.proto \
    -import-path . \
    -d '{ "org_id": "0000" }' \
    localhost:9090 choreo.service.subscriptions.v1.SubscriptionService/GetTierDetails
```
Successful invocation will return a similar response to the following.

```json
{
  "tier": {
    "id": "0000",
    "name": "Free Tier",
    "description": "Free allocation to tryout choreo",
    "cost": "0$ per Month",
    "createdAt": "2021-07-22 08:28:09.0",
    "serviceQuota": 10,
    "integrationQuota": 10,
    "apiQuota": 20,
    "remoteAppQuota": 10
  }
}
```

## Health Checks

Following endpoints can be used for the health check purposes in subscription service.

```sh
curl http://localhost:9091/readiness
curl http://localhost:9091/liveness
curl http://localhost:9092/subscriptions/healthz
