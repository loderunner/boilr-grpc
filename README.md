# boilr-grpc

A [boilr](https://github.com/tmrts/boilr) template for a gRPC Go project with [REST Gateway](https://github.com/grpc-ecosystem/grpc-gateway).

## Installation

### Prerequisites

* [boilr](https://github.com/tmrts/boilr)

### Download the template

To download the template from GitHub and save it to the local registry, type the following command:

```shell
boilr template download loderunner/boilr-grpc grpc
```

Replace `grpc` at the end of the command line by any name you want to give the template in your local registry.

## Usage

### Prerequisites

* [Protocol Buffers](https://developers.google.com/protocol-buffers/)
* [`protoc` plugin for Go](https://github.com/golang/protobuf)
* [gRPC for Go](https://grpc.io/docs/quickstart/go.html)
* [gRPC gateway](https://github.com/grpc-ecosystem/grpc-gateway)

### Generate a gRPC project from template

To use the template from your registry, type the following command:

```shell
boilr template use grpc project-name
```

Replace `project-name` by any name you want to give to your project. If you set the template name to something other than `grpc` when downloading, remember to change that also.

`boilr` will create a directory with the name you entered and generate a project using the template. You will be prompted to set some variables. You can set them yourself or use the default values.

* `ImportPath`: The full Go import path of your project. Default: `"github.com/loderunner/echo"`
* `PackageName`: The name of the package, usually the same as your project directory and the last component of the import path. Default: `"echo"`
* `ServiceName` : This will be the name of the template gRPC service. This name is only used in the Protobuf file and in the generated code. Default: `"Echo"`
* `GrpcPort` : The port on which the server expose a gRPC endpoint. Default: `8080`
* `RestPort` : The port on which the server expose a REST endpoint. Default: `8081`

> _Note:_ Because of Go's import system, the best practice would be to generate your project directly inside your Go path at the correct location, and give it corresponding directory name, import path and package name.
>
> For example, assuming your project's import path is `"github.com/yourname/echo"`, first `cd` to `$GOPATH/src/github.com/yourname` and generate the project from template: `boilr template use grpc echo`. Use the following variables:
>
> * `ImportPath`: `"github.com/yourname/echo"`
> * `PackageName`: `"echo"`

### Build the project

To build the project, `cd` to the project directory and type:

```shell
make
```

### Run

Run the server by typing:

```shell
./echo
```

This should expose a HTTP/2 gRPC endpoint on port 8080, and a HTTP/1.1 REST endpoint on port 8081. The template RPC `echo` should be available. Test it with:

```shell
curl -sv http://localhost:8081/echo -H "Content-Type: application/json" -d '{"message": "Hello World"}'
```

##### HTTP Request

```
POST /echo HTTP/1.1
Host: localhost:8081
User-Agent: curl/7.54.0
Accept: */*
Content-Type: application/json
Content-Length: 26

{"message":"Hello World"}
```

##### HTTP Response

```
HTTP/1.1 200 OK
Content-Type: application/json
Date: Thu, 11 Jan 2018 11:31:24 GMT
Content-Length: 25

{"message":"Hello World"}
```

## Template details

### Files

This is the directory structure after generating a project named `echo` from the template.

```
├── Makefile        # The make build system (see below)
├── api
│   └── echo.proto  # The Protobuf definition of the service RPCs and messages
├── echo.go         # The main server executable code
└── server
    ├── handlers.go # The handlers for the gRPC calls
    └── server.go   # The code relating to starting the gRPC/REST server
```

### Makefile targets

* `build`: build the main server executable
* `api`: generate all API sources from the protobuf definition
* `dep`: fetch Go dependencies
* `test`: run the package tests
* `race`: run the package tests with the [race detector](https://golang.org/doc/articles/race_detector.html)
* `msan`: run the package tests with the [memory sanitizer](https://golang.org/cmd/go/#hdr-Compile_packages_and_dependencies). Supported only on linux/amd64, and only with Clang/LLVM as the host C compiler.

### Generated files

#### Protobuf

The following files are generated from the protobuf definition (`api/echo.proto`) using `make api`.

* `api/echo.pb.go`: Go source file for gRPC
* `api/echo.pb.gw.go`: Go source file for the gRPC REST gateway
* `api/echo.swagger.json`: [OpenAPI](https://github.com/OAI/OpenAPI-Specification) specification of the HTTP/1.1 REST API

#### Executables

* `echo`: The server's main executable file

----

An example of the generated repository can be found at [loderunner/echo](https://github.com/loderunner/echo). It should be up-to-date.

## Contributing

Have an issue? Want to request a feature? Feel free to report any problems you encounter or features you think are missing.

Want to contribute some code? Just fork this repository and submit a pull request. Don't forget to add your name to the list of contributors below!

## Contributors

* [Charles Francoise](https://github.com/loderunner)

## MIT License

Copyright © 2018 Charles Francoise

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
