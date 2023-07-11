SRC := $(shell find . -name '*.go')
BINARY := bk
VERSION := $(shell awk -F\" '/Version = / {print $$2}' version.go)
LD_FLAGS=-X github.com/buildkite/cli/v2.projectUUID=$${RELEVANCE_PROJECT} -X github.com/buildkite/cli/v2.apiEndpoint=$${RELEVANCE_API_URL}

.PHONY: build
build: build/bk-windows-amd64-$(VERSION).exe build/bk-linux-amd64-$(VERSION) build/bk-linux-arm64-$(VERSION) build/bk-darwin-amd64-$(VERSION) build/bk-darwin-arm64-$(VERSION)

build/bk-windows-amd64-$(VERSION).exe: $(SRC)
	mkdir -p build
	GOOS=windows GOARCH=amd64 go build -o build/$(BINARY)-windows-amd64-$(VERSION).exe -ldflags="$(LD_FLAGS)" ./cmd/bk

build/bk-linux-amd64-$(VERSION): $(SRC)
	mkdir -p build
	GOOS=linux GOARCH=amd64 go build -o build/$(BINARY)-linux-amd64-$(VERSION) -ldflags="$(LD_FLAGS)" ./cmd/bk

build/bk-linux-arm64-$(VERSION): $(SRC)
	mkdir -p build
	GOOS=linux GOARCH=arm64 go build -o build/$(BINARY)-linux-arm64-$(VERSION) -ldflags="$(LD_FLAGS)" ./cmd/bk

build/bk-darwin-amd64-$(VERSION): $(SRC)
	mkdir -p build
	GOOS=darwin GOARCH=amd64 go build -o build/$(BINARY)-darwin-amd64-$(VERSION) -ldflags="$(LD_FLAGS)" ./cmd/bk

build/bk-darwin-arm64-$(VERSION): $(SRC)
	mkdir -p build
	GOOS=darwin GOARCH=arm64 go build -o build/$(BINARY)-darwin-arm64-$(VERSION) -ldflags="$(LD_FLAGS)" ./cmd/bk

.PHONY: clean
clean:
	-rm -rf build/
