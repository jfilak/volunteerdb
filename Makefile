GO ?= GOROOT= GOPATH=$$(pwd) go
GOBUILD=$(GO) build
GOTEST=$(GO) test

SHELL_BIN ?= /usr/bin/bash

PROJECT := github.com/jfilak/volunteerdb


all: binaries

.PHONY: binaries
binaries: volunteerdb

volunteerdb:
	$(GOBUILD) -ldflags "-X main.QueryAPI=$$(cat VERSION)" -o bin/$@ volunteerdb

.PHONY: test
test:
	$(GOTEST) -v version

.PHONY: test
integration_test:
	PROJECT_ROOT=$$(pwd) PROJECT_BIN=$$(pwd)/bin $(SHELL_BIN) test/integration/test_version.sh
