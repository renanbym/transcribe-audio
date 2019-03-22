PROJECTNAME=$(shell basename "$(PWD)")

# Go related variables.
# GOBASE=$(shell pwd)
# GOPATH=$(GOBASE) # You can remove or change the path after last colon.
# GOBIN=$(GOBASE)/bin
GOFUNCTIONS=$(shell find src/services -name \*main.go | awk -F '/' '{print $$3"/"$$4}')

# Make is verbose in Linux. Make it silent.
MAKEFLAGS += --silent

GOBUILD=env GOOS=linux go build -ldflags="-s -w" -o


## go-build: Build files. Runs `make go-build` internally.
go-build: 
	@echo "  >  Building binary..."
	dep ensure -v
	@for function in $(GOFUNCTIONS) ; do \
		echo "	  > function: "$$function; \
		$(GOBUILD) bin/$$function src/services/$$function/main.go ; \
	done

## go-clean: Clean build files. Runs `make go-clean` internally.
go-clean:
	@echo "  >  Cleaning build cache..."
	rm -rf ./bin ./vendor Gopkg.lock
	
## go-deploy: Deploy build files with Serverless. Runs `make go-deploy` internally.
go-deploy: 
	@echo "  >  Deploy Serverless..."
	@-$(MAKE) go-clean go-build
	@echo "  	>  Service: test"
	cd src/services/test; SLS_DEBUG=* sls deploy -v


.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo
