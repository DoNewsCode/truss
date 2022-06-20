# Makefile for Truss.
#
SHA := $(shell git rev-parse --short=10 HEAD)

MAKEFILE_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
VERSION_DATE := $(shell $(MAKEFILE_PATH)/commit_date.sh)

# Build native Truss by default.
default: truss

dependencies:
	go get -u google.golang.org/protobuf
	go get -u google.golang.org/genproto
	go get -u github.com/gogo/protobuf/proto
	go install github.com/gogo/protobuf/protoc-gen-gogo
	go install github.com/gogo/protobuf/protoc-gen-gogofaster
	go install github.com/gogo/protobuf/protoc-gen-gofast
	go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway
	go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
	go install google.golang.org/protobuf/cmd/protoc-gen-go
	go install github.com/envoyproxy/protoc-gen-validate

# Install truss
truss:
	go install -ldflags '-X "main.version=$(SHA)" -X "main.date=$(VERSION_DATE)"' github.com/DoNewsCode/truss/cmd/truss

# Run the go tests and the truss integration tests
test: test-go

test-go:
	#GO111MODULE=on go test -v ./... -covermode=atomic -coverprofile=./coverage.out --coverpkg=./...
	GO111MODULE=on go test -v ./...


.PHONY: test-go test truss dependencies