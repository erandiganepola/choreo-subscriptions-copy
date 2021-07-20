# Copyright (c) 2021, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.

PROJECT_ROOT := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

all: build

.PHONY: clean
clean:
	rm -rf choreo-subscriptions/target

.PHONY: build
build: clean
	bal build choreo-subscriptions

.PHONY: test
test: clean
	bal test --code-coverage choreo-subscriptions

.PHONY: build.docker
build.docker:
	docker build -t choreoipaas/choreo-subscriptions:latest .
