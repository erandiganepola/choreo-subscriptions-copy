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

#### Run
After completing the above configurations you can start the service with one of the following commands.
```
bal run <path to jar file>
java -jar <path to jar file>
```
`ex: bal run choreo-subscriptions/target/bin/choreo-subscriptions.jar`
