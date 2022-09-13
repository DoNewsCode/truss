# Tutorial: Getting Started with Truss

We will build a simple service based on [echo.proto](./_example/echo.proto)

# Installation tips

1. Follow instructions in the [README](./README.md)
  - Can use `brew install` to get protobuf, golang, but not other packages (`go get` the rest).
2. Go to truss installation folder and run `make test`
  If everything passes you’re good to go.
  If you see any complaints about packages not installed, `go get` those packages
  If you encounter any other issues - ask the developers
3. To update to newer version of truss, do `git pull`, or `go get -u github.com/DoNewsCode/truss/...` truss again.

# Additional features

## File placement

You can control the location of the output folders for your service by specifying the following flags when running truss
```
  --svcout {go-style-package-path to where you want the contents of {Name}-service folder to be}
  --pgvout {where you want the *.pb.validate.go interface definitions to be}
```

Note: “go-style-package-path” means exactly the style you use in your golang import statements, relative to your $GOPATH. This is not your system file path, nor it is relative to location of the *.proto file; the start of the path must be accessible from your $GOPATH.
For example:
```
truss --pbout truss-demo/pb --svcout truss-demo/service hello.proto
```
Executing this command will place the *.pb.go files into `$GOPATH/truss-demo/pb/`, and the entire echo-service contents (excepting the *.pb.go files) to `$GOPATH/truss-demo/service/`.
