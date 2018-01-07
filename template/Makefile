PKG = "{{PackageName}}"
GOPATH ?= $(shell go env GOPATH)
GO_PACKAGES := $(shell go list ./... | grep -v /vendor/)
BINARIES = {{PackageName}}
API_FILES = api/{{PackageName}}.pb.go api/{{PackageName}}.pb.gw.go api/{{PackageName}}.swagger.json

.PHONY: build dep test race msan

build: dep api ## Build {{PackageName}}
	@go build .

dep: ## Fetch dependencies
	# @go get -u ./...

api: $(API_FILES) ## Auto-generate gRPC/REST Go sources

api/{{PackageName}}.pb.go: api/{{PackageName}}.proto
	@protoc -I. \
		-I${GOPATH}/src \
		-I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		--go_out=plugins=grpc:. \
		api/{{PackageName}}.proto

api/{{PackageName}}.pb.gw.go: api/{{PackageName}}.proto
	@protoc -I. \
		-I${GOPATH}/src \
		-I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		--grpc-gateway_out=logtostderr=true:. \
		api/{{PackageName}}.proto

api/{{PackageName}}.swagger.json: api/{{PackageName}}.proto
	@protoc -I. \
		-I${GOPATH}/src \
		-I${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		--swagger_out=logtostderr=true:. \
		api/{{PackageName}}.proto

clean: ## Clean compiled binaries
	@rm -f ${BINARIES}

realclean: ## Clean compiled binaries and all generated files
	@rm -f {BINARIES}
	@rm -f ${API_FILES}

test: dep ## Run tests
	@go test -short ${GO_PACKAGES}

race: dep ## Run tests with race detector
	@go test -race -short ${GO_PACKAGES}

msan: dep ## Run tests with memory sanitizer
	@go test -msan -short ${GO_PACKAGES}