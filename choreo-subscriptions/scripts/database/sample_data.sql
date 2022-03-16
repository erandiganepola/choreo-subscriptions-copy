INSERT INTO choreo_subscriptions_db.dbo.[attribute] (id,name,description,created_at) VALUES
	 (N'01ebea30-6199-152a-b9c8-53a5e8c83008',N'running_app_quota',N'Number of running applications quota',1627639797657),
	 (N'01ebea3b-2dba-182a-9aad-b68df13c86d0',N'component_quota',N'Number of components can be created',1627639797657);
GO

INSERT INTO choreo_subscriptions_db.dbo.tier (id,name,description,is_paid,created_at,is_internal) VALUES
	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'Free',N'Free tier to tryout choreo',0,1627639797657,0),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'Enterprise',N'Tier for enterprise users',1,1627639797657,0),
	 (N'01ec1f8e-7ba6-1f88-bd74-41709200d0c0',N'Pay-As-You-Go',N'Tier for paid users',1,1627639797657,0),
	 (N'01ec1d1e-0e9c-16e4-b6c9-1904e9ef9567',N'Internal',N'Tier for internal users',1,1627639797657,1);	 
GO

INSERT INTO choreo_subscriptions_db.dbo.quota (tier_id,attribute_name,threshold) VALUES
	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'running_app_quota',5),
	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'component_quota',10),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'running_app_quota',1000000000),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'component_quota',1000000000),
	 (N'01ec1f8e-7ba6-1f88-bd74-41709200d0c0',N'running_app_quota',1000000000),
	 (N'01ec1f8e-7ba6-1f88-bd74-41709200d0c0',N'component_quota',1000000000),
	 (N'01ec1d1e-0e9c-16e4-b6c9-1904e9ef9567',N'running_app_quota',1000000),
	 (N'01ec1d1e-0e9c-16e4-b6c9-1904e9ef9567',N'component_quota',1000000);
GO

INSERT INTO choreo_subscriptions_db.dbo.subscription (id,org_id,org_handle,tier_id,billing_date,status) VALUES
	 (N'0000060f-569d-4394-b689-4624b9a31b5b',N'0000',N'jhondoe',N'01ebea3a-7735-10be-b3c0-ba95f991e877',1627639797657,N'ACTIVE'),
	 (N'00151c87-07c0-48b5-ad68-103b1f6f1a90',N'1111',N'jackbob',N'01ebea43-be76-1d7a-b410-2d1b873c57af',1627639797657,N'ACTIVE');
