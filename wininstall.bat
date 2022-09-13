@ECHO OFF

SET SHA_CMD="git rev-parse --short=10 HEAD"
FOR /F "tokens=* USEBACKQ" %%F IN (`%SHA_CMD%`) DO (
	SET SHA=%%F
)

SET HEAD_CMD="git rev-parse HEAD"
FOR /F "tokens=* USEBACKQ" %%F IN (`%HEAD_CMD%`) DO (
	SET HEAD_COMMIT=%%F
)

SET HEAD_DATE_CMD="git show -s --format=%%ct %HEAD_COMMIT%"
FOR /F "tokens=* USEBACKQ" %%F IN (`%HEAD_DATE_CMD%`) DO (
	SET GIT_COMMIT_EPOC=%%F
)

@ECHO ON
go get -u google.golang.org/genproto
go get -u github.com/gogo/protobuf/protoc-gen-gogo
go get -u github.com/gogo/protobuf/protoc-gen-gogofaster
go get -u github.com/gogo/protobuf/protoc-gen-gofast
go get -u github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway
go get -u github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc
go get -u google.golang.org/protobuf/cmd/protoc-gen-go
go get -u github.com/envoyproxy/protoc-gen-validate

go install -ldflags "-X 'main.version=%SHA%'" github.com/DoNewsCode/truss/cmd/truss
@ECHO OFF