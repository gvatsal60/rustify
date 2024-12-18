include Makefiles/docker.mk
include Makefiles/rules.mk

# Define the path to the Dockerfile
DOCKER_FILE_PATH := dockerfiles/Dockerfile.debug

DOCKER_BUILD_CMD := $(DOCKER_HOST) image build -t $(DOCKER_IMG_NAME) -f $(DOCKER_FILE_PATH) $(DOCKER_BUILD_CONTEXT)
DOCKER_RUN_CMD := $(DOCKER_HOST) container run $(DOCKER_ARG) $(DOCKER_IMG_NAME)

# Define the default target
.PHONY: all test clean

# Targets
all: clean build

# Target: build_img
# Description: Builds the Docker image using the specified Dockerfile
.PHONY: build_img
build_img:
	@$(DOCKER_BUILD_CMD)

# Code Build
build: build_img
	@$(DOCKER_RUN_CMD) $(BUILD_CMD)

# Test code
test: build
	@$(DOCKER_RUN_CMD) $(TEST_CMD)

# Run code
run: build
	@$(DOCKER_RUN_CMD) $(RUN_CMD)

# Clean
clean: build_img
	@$(DOCKER_RUN_CMD) $(CLEAN_CMD)

# Sonar
sonar: clean build
	@$(DOCKER_RUN_CMD) $(SONAR_CMD)
