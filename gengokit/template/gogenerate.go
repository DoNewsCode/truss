package template

import (
	"embed"
	"fmt"
	"strings"
)

//go:embed NAME-service
var tempFiles embed.FS

func read(fileName string) func() ([]byte, error) {
	return func() ([]byte, error) {
		return tempFiles.ReadFile(fileName)
	}
}

var _bindata = map[string]func() ([]byte, error){
	"svc/client/grpc/client.gotemplate": read("NAME-service/svc/client/grpc/client.gotemplate"),
	"svc/client/http/client.gotemplate": read("NAME-service/svc/client/http/client.gotemplate"),
	"svc/endpoints.gotemplate":          read("NAME-service/svc/endpoints.gotemplate"),
	"svc/transport_grpc.gotemplate":     read("NAME-service/svc/transport_grpc.gotemplate"),
	"svc/transport_http.gotemplate":     read("NAME-service/svc/transport_http.gotemplate"),
	"service.gotemplate":                read("NAME-service/service.gotemplate"),
}

func AssetNames() []string {
	names := make([]string, 0, len(_bindata))
	for name := range _bindata {
		names = append(names, name)
	}
	return names
}

func Asset(name string) ([]byte, error) {
	canonicalName := strings.Replace(name, "\\", "/", -1)
	if f, ok := _bindata[canonicalName]; ok {
		a, err := f()
		if err != nil {
			return nil, fmt.Errorf("Asset %s can't read by error: %v", name, err)
		}
		return a, nil
	}
	return nil, fmt.Errorf("Asset %s not found", name)
}
