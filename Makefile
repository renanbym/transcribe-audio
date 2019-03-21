.PHONY: go-clean go-build  go-deploy

GOBUILD=env GOOS=linux go build -ldflags="-s -w" -o

functions := $(shell find src/services -name \*main.go | awk -F '/' '{print $$3"/"$$4}')

go-build: 
	dep ensure -v
	@for function in $(functions) ; do \
		$(GOBUILD) bin/$$function src/services/$$function/main.go ; \
	done

go-clean:
	rm -rf ./bin ./vendor Gopkg.lock

go-deploy: go-clean go-build
	cd src/services/test; SLS_DEBUG=* sls deploy -v




# PROJECTNAME=$(shell basename "$(PWD)")

# # Go related variables.
# GOBASE=$(shell pwd)
# GOPATH=$(GOBASE) # You can remove or change the path after last colon.
# GOBIN=$(GOBASE)/bin
# GOFILES=$(wildcard *.go)

# # Redirect error output to a file, so we can show it in development mode.
# STDERR=/tmp/.$(PROJECTNAME)-stderr.txt

# # PID file will store the server process id when it's running on development mode
# PID=/tmp/.$(PROJECTNAME)-api-server.pid

# # Make is verbose in Linux. Make it silent.
# MAKEFLAGS += --silent

# ## install: Install missing dependencies. Runs `go get` internally. e.g; make install get=github.com/foo/bar
# install: go-get

# ## start: Start in development mode. Auto-starts when code changes.
# start:
#     bash -c "trap 'make stop' EXIT; $(MAKE) compile start-server watch run='make compile start-server'"

# ## stop: Stop development mode.
# stop: stop-server

# start-server: stop-server
# 	@echo "  >  $(PROJECTNAME) is available at $(ADDR)"
# 	@-$(GOBIN)/$(PROJECTNAME) 2>&1 & echo $$! > $(PID)
# 	@cat $(PID) | sed "/^/s/^/  \>  PID: /"

# stop-server:
# 	@-touch $(PID)
# 	@-kill `cat $(PID)` 2> /dev/null || true
# 	@-rm $(PID)

# ## watch: Run given command when code changes. e.g; make watch run="echo 'hey'"
# watch:
# 	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) yolo -i . -e vendor -e bin -c "$(run)"

# restart-server: stop-server start-server

# ## compile: Compile the binary.
# compile:
# 	@-touch $(STDERR)
# 	@-rm $(STDERR)
# 	@-$(MAKE) -s go-compile 2> $(STDERR)
# 	@cat $(STDERR) | sed -e '1s/.*/\nError:\n/'  | sed 's/make\[.*/ /' | sed "/^/s/^/     /" 1>&2

# ## exec: Run given command, wrapped with custom GOPATH. e.g; make exec run="go test ./..."
# exec:
# 	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) $(run)

# ## clean: Clean build files. Runs `go clean` internally.
# clean:
# 	@(MAKEFILE) go-clean

# ## deploy: Deploy build files with Serverless. Runs `go deploy` internally.
# deploy:
# 	@(MAKEFILE) go-deploy

# go-compile: go-clean go-get go-build go-compile

# go-build:
# 	@echo "  >  Building binary..."
# 	@echo $(GOBIN)
# 	@echo $(GOFILES)
# 	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) env GOOS=linux go build -v -ldflags="-s -w"  -o $(GOBIN)/ $(GOFILES)

# go-generate:
# 	@echo "  >  Generating dependency files..."
# 	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go generate $(generate)

# go-get:
# 	@echo "  >  Checking if there is any missing dependencies..."
# 	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go get $(get)

# go-install:
# 	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go install $(GOFILES)

# go-clean:
# 	@echo "  >  Cleaning build cache"
# 	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go clean

# go-deploy: 
# 	@echo "  >  Deploy Serverless..."
# 	go-clean go-get go-build
# 	@echo "  >  Deploy test..."
# 	cd src/services/test; SLS_DEBUG=* sls deploy -v


# .PHONY: help
# all: help
# help: Makefile
# 	@echo
# 	@echo " Choose a command run in "$(PROJECTNAME)":"
# 	@echo
# 	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
# 	@echo

