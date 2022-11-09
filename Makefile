ifndef VERBOSE
.SILENT: # no need for @
endif

.DEFAULT_GOAL:=help

##@ Run

.PHONY: repl

repl: ## Start the monkey REPL
	go run .

##@ Test

.PHONY: test coverage

test: ## Run go tests
	go test -v -race ./...

coverage: ## Run go tests and create coverage report
	go test -cover -covermode=count -coverprofile=coverage.out ./...
	go tool cover -func coverage.out

##@ Helpers

.PHONY: help

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <command> \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
