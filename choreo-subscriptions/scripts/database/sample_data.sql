INSERT INTO choreo_subscriptions_db.dbo.[attribute] (id,name,description,created_at) VALUES
	 (N'01ebea30-6199-152a-b9c8-53a5e8c83008',N'service_quota',N'Number of services can be created',1627639797657),
	 (N'01ebea3b-2dba-182a-9aad-b68df13c86d0',N'api_quota',N'Number of apis can be created',1627639797657),
	 (N'01ebea3c-0b3c-1bf8-a1a7-22eb4cc3566e',N'remote_app_quota',N'Number of remote apps can be created',1627639797657),
	 (N'01ebea43-d02d-1c12-8ae0-1b5947056fc1',N'integration_quota',N'Number of integrations can be created',1627639797657),
	 (N'01ebeasw-d02d-1c12-8ae0-1b5947056fc1',N'step_quota',N'Number of steps allocated',1627639797657),
	 (N'01ec1c6d-956e-175a-ad64-0f27c561adb8',N'developer_count',N'Number of developers can be allocated',1627639797657);
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
	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'step_quota',1000),
	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'developer_count',1),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'service_quota',100),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'integration_quota',100),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'api_quota',100),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'remote_app_quota',100),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'step_quota',1000000),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'developer_count',-1);
GO

INSERT INTO choreo_subscriptions_db.dbo.subscription (id,org_id,org_handle,tier_id,billing_date,status) VALUES
	 (N'0000060f-569d-4394-b689-4624b9a31b5b',N'0000',N'jhondoe',N'01ebea3a-7735-10be-b3c0-ba95f991e877',1627639797657,N'ACTIVE'),
	 (N'00151c87-07c0-48b5-ad68-103b1f6f1a90',N'1111',N'jackbob',N'01ebea43-be76-1d7a-b410-2d1b873c57af',1627639797657,N'ACTIVE');

INSERT INTO choreo_subscriptions_db.dbo.billing_tier (id,tier_id,product_id,price_id,currency,recurring_interval) VALUES
	 (N'01ec1491-3eff-1aec-b511-2eec6e3c92d2',N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'prod_K8pD0xG5AqXUzG',N'price_1JY0lgEeYOVsvOhWyxCaQmNy',N'USD',N'month'),
	 (N'01ec1491-316e-1c84-9195-5bbb347a8a0b',N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'prod_K7pD0xG5AqXUzG',N'price_2JY0lgEeYOVsvOhWyxCaQmNy',N'USD',N'month');
GO

INSERT INTO choreo_subscriptions_db.dbo.billing_subscription (id,subscription_id,stripe_subscription_id,stripe_subscription_item_id) VALUES
	 (N'01ec148a-c530-1e10-9d57-44bf012eb896',N'0000060f-569d-4394-b689-4624b9a31b5b',N'sub_KCPaTebN0yENzY',N'si_KCPa3qnZBTVqO3'),
	 (N'01ec148a-c367-11d8-b08c-8c01a83304e7',N'00151c87-07c0-48b5-ad68-103b1f6f1a90',N'sub_KCPaTebN1yENzY',N'si_KCPa4qnZBTVqO3');
GO

INSERT INTO choreo_subscriptions_db.dbo.billing_account (id,org_id,customer_id) VALUES
	 (N'01ec148a-c163-15e4-aaa7-a098f46fe579',N'0000',N'cus_KCPa1wMr4UJjDX'),
	 (N'01ec148a-c008-1fe6-938c-04fd4734d900',N'1111',N'cus_KCPa1wMr3UJjDX');
GO

INSERT INTO choreo_subscriptions_db.dbo.billing_history (id,subscribed_user,customer_id,timestamp,operation) VALUES
	 (N'01ec1491-6d7a-17c8-81df-0c658bb60511',N'Jhon Marcus',N'cus_KCPa1wMr4UJjDX',1627639797657,N'upgrade'),
	 (N'01ec1490-6a98-1fce-a8b8-41b6ae8735a6',N'Pillip Json',N'cus_KCPa1wMr3UJjDX',1627639797657,N'downgrade');
GO
