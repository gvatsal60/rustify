# Default target
.DEFAULT_GOAL := help

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'


# Check if running inside a Docker container
ifeq ($(shell test -f /.dockerenv && echo -n yes),yes)
    include Makefiles/vsc.mk
else
    include Makefiles/debug.mk
endif

.PHONY: all test clean
