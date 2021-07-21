-- Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.

-- This software is the property of WSO2 Inc. and its suppliers, if any.
-- Dissemination of any information or reproduction of any material contained
-- herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
-- You may not alter or remove any copyright or other notice from copies of this content.

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'choreo-subscriptions-db')
    BEGIN
        CREATE DATABASE choreo-subscriptions-db;
    END
GO
USE choreo-subscriptions-db;
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tier' and xtype='U')
BEGIN
    CREATE TABLE tier (
        id VARCHAR(128) NOT NULL,
        name VARCHAR(256) NOT NULL,
        description VARCHAR(1024) NOT NULL,
        cost VARCHAR(256) NOT NULL,
        created_at DATETIME2(0) DEFAULT GETDATE(),
        PRIMARY KEY (ID)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='subscription' and xtype='U')
BEGIN
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
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='quota' and xtype='U')
BEGIN
    CREATE TABLE quota (    
        id INTEGER IDENTITY(1,1),
        tier_id VARCHAR(128) NOT NULL,
        attribute_name VARCHAR(256) NOT NULL,
        threshold INTEGER NOT NULL,
        PRIMARY KEY (ID),
        UNIQUE (TIER_ID, ATTRIBUTE_NAME),
        CONSTRAINT FK_TierQuota FOREIGN KEY (tier_id) REFERENCES tier(id)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='attribute' and xtype='U')
BEGIN
    CREATE TABLE attribute (
        id VARCHAR(128) NOT NULL,
        name VARCHAR(256) NOT NULL,
        description VARCHAR(256),
        created_at DATETIME2(0) DEFAULT GETDATE(),
        PRIMARY KEY (ID),
        UNIQUE (NAME)
    );
END
GO
