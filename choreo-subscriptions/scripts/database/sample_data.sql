INSERT INTO choreo_subscriptions_db.dbo.[attribute] (id,name,description,created_at) VALUES
	 (N'01ebea30-6199-152a-b9c8-53a5e8c83008',N'service_quota',N'Number of services can be created',1627639797657),
	 (N'01ebea3b-2dba-182a-9aad-b68df13c86d0',N'api_quota',N'Number of apis can be created',1627639797657),
	 (N'01ebea3c-0b3c-1bf8-a1a7-22eb4cc3566e',N'remote_app_quota',N'Number of remote apps can be created',1627639797657),
	 (N'01ebea43-d02d-1c12-8ae0-1b5947056fc1',N'integration_quota',N'Number of integrations can be created',1627639797657);
GO

INSERT INTO choreo_subscriptions_db.dbo.tier (id,name,description,cost,created_at) VALUES
	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'Free Tier',N'Free tier to tryout choreo',0,1627639797657),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'Enterprise Tier',N'Tier for enterprise users',100000,1627639797657);
GO

INSERT INTO choreo_subscriptions_db.dbo.quota (tier_id,attribute_name,threshold) VALUES
	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'service_quota',10),
	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'integration_quota',10),
	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'api_quota',20),
 	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'remote_app_quota',10),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'service_quota',100),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'integration_quota',100),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'api_quota',100),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'remote_app_quota',100);
GO

INSERT INTO choreo_subscriptions_db.dbo.subscription (id,org_id,org_handle,tier_id,billing_date,status) VALUES
	 (N'0000060f-569d-4394-b689-4624b9a31b5b',N'0000',N'jhondoe',N'01ebea3a-7735-10be-b3c0-ba95f991e877',1627639797657,N'ACTIVE'),
	 (N'00151c87-07c0-48b5-ad68-103b1f6f1a90',N'1111',N'jackbob',N'01ebea43-be76-1d7a-b410-2d1b873c57af',1627639797657,N'ACTIVE');
