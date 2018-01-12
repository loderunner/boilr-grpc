package main

import (
	"{{ImportPath}}/server"
)

func main() {
	grpcAddress := ":{{GrpcPort}}"
	restAddress := ":{{RestPort}}"
	go server.ListenAndServeREST(restAddress, grpcAddress)
	server.ListenAndServeGRPC(grpcAddress)
}
