-- Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.

-- This software is the property of WSO2 Inc. and its suppliers, if any.
-- Dissemination of any information or reproduction of any material contained
-- herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
-- You may not alter or remove any copyright or other notice from copies of this content.

CREATE DATABASE choreo-subscriptions-db;
GO
USE choreo-subscriptions-db;
GO
CREATE TABLE tier (
    id VARCHAR(128) NOT NULL,
    name VARCHAR(256) NOT NULL,
    description VARCHAR(1024) NOT NULL,
    cost VARCHAR(256) NOT NULL,
    created_at DATETIME2(0) DEFAULT GETDATE(),
    PRIMARY KEY (ID)
);
GO

CREATE TABLE subscription (
    id VARCHAR(128) NOT NULL,
    org_id VARCHAR(128) NOT NULL,
    tier_id VARCHAR(128) NOT NULL,
    billing_date DATETIME2(0) NOT NULL,
    status VARCHAR(128) NOT NULL,
    created_at DATETIME2(0) DEFAULT GETDATE(),
    PRIMARY KEY (ID),
    UNIQUE (ORG_ID),
    CONSTRAINT FK_TierSubscription FOREIGN KEY (tier_id) REFERENCES tier(id)
);
GO

CREATE TABLE quota (    
    id INTEGER IDENTITY(1,1),
    tier_id VARCHAR(128) NOT NULL,
    attribute_name VARCHAR(256) NOT NULL,
    threshold INTEGER NOT NULL,
    PRIMARY KEY (ID),
    UNIQUE (TIER_ID, ATTRIBUTE_NAME),
    CONSTRAINT FK_TierQuota FOREIGN KEY (tier_id) REFERENCES tier(id)
);
GO

CREATE TABLE attribute (
    id VARCHAR(128) NOT NULL,
    name VARCHAR(256) NOT NULL,
    description VARCHAR(256),
    created_at DATETIME2(0) DEFAULT GETDATE(),
    PRIMARY KEY (ID),
    UNIQUE (NAME)
);
GO
