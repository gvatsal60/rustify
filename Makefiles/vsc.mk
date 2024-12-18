include cfg/.env
include Makefiles/rules.mk

# Targets
.PHONY: all test clean

all: clean build

build:
	@$(BUILD_CMD)

test: build
	@$(TEST_CMD)

run: build
	@$(RUN_CMD)

clean:
	@$(CLEAN_CMD)

sonar: clean build
	@$(SONAR_CMD)
