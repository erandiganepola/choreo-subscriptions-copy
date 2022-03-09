-- Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.

-- This software is the property of WSO2 Inc. and its suppliers, if any.
-- Dissemination of any information or reproduction of any material contained
-- herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
-- You may not alter or remove any copyright or other notice from copies of this content.

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'choreo_subscriptions_db')
    BEGIN
        CREATE DATABASE choreo_subscriptions_db;
    END
GO
USE choreo_subscriptions_db;
GO

-- TODO: Remove the DEFAULT constraint in the "is_internal" column when the addTier method is modified
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tier' and xtype='U')
BEGIN
    CREATE TABLE tier (
        id VARCHAR(128) NOT NULL,
        name VARCHAR(256) NOT NULL,
        description VARCHAR(1024) NOT NULL,
        is_paid BIT NOT NULL,
        created_at BIGINT DEFAULT DATEDIFF_BIG(MILLISECOND,'1970-01-01 00:00:00.000', SYSUTCDATETIME()),
        is_internal BIT NOT NULL DEFAULT 1,
        PRIMARY KEY (ID)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='subscription' and xtype='U')
BEGIN
    CREATE TABLE subscription (
        id VARCHAR(128) NOT NULL,
        org_id VARCHAR(128) NOT NULL,
        org_handle VARCHAR(255) NOT NULL,
        tier_id VARCHAR(128) NOT NULL,
        stripe_subscription_item_id VARCHAR(128) DEFAULT NULL,
        billing_date BIGINT DEFAULT DATEDIFF_BIG(MILLISECOND,'1970-01-01 00:00:00.000', SYSUTCDATETIME()),
        status VARCHAR(128) NOT NULL,
        is_paid BIT NOT NULL DEFAULT 0,
        step_quota INTEGER NOT NULL DEFAULT 5000,
        created_at BIGINT DEFAULT DATEDIFF_BIG(MILLISECOND,'1970-01-01 00:00:00.000', SYSUTCDATETIME()),
        PRIMARY KEY (org_id, tier_id),
        UNIQUE (id),
        UNIQUE (org_id),
        UNIQUE (org_handle),
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
        created_at BIGINT DEFAULT DATEDIFF_BIG(MILLISECOND,'1970-01-01 00:00:00.000', SYSUTCDATETIME()),
        PRIMARY KEY (ID),
        UNIQUE (NAME)
    );
END
GO
