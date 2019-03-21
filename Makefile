.PHONY: build clean deploy

functions := $(shell find src -name \*main.go)

build: ## Build golang binaries
	dep ensure -v
	@for function in $(functions) ; do \
		env GOOS=linux go build -v -ldflags="-s -w" -o bin/$$function $$function; \
	done

clean:
	rm -rf ./bin ./vendor Gopkg.lock

deploy: clean build
	cd src/services/test; SLS_DEBUG=* sls deploy -v \


