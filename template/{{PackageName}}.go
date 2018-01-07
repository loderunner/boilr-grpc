package main

import (
	"{{ImportPath}}/server"
)

func main() {
	grpcAddress := ":7575"
	restAddress := ":7576"
	go server.ListenAndServeREST(restAddress, grpcAddress)
	server.ListenAndServeGRPC(grpcAddress)
}
