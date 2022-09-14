# Makefile for Truss.
#
SHA := $(shell git rev-parse --short=10 HEAD)

MAKEFILE_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# Build native Truss by default.
default: truss

dependencies:
	go get -u google.golang.org/genproto
	go get -u github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway
	go get -u github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
	go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc
	go get -u google.golang.org/protobuf/cmd/protoc-gen-go
	go get -u github.com/envoyproxy/protoc-gen-validate

# Install truss
truss:
	go install -ldflags '-X "main.version=$(SHA)"' github.com/DoNewsCode/truss/cmd/truss

# Run the go tests and the truss integration tests
test: test-go

test-go:
	#GO111MODULE=on go test -v ./... -covermode=atomic -coverprofile=./coverage.out --coverpkg=./...
	GO111MODULE=on go test -v ./...


.PHONY: test-go test truss dependencies