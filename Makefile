# Include configuration files
include conf/docker.mk

# Define the Cargo command
CARGO := cargo

# Define the path to the Dockerfile
DOCKER_FILE_PATH := dockerfiles/Dockerfile.alpine

# Define the default target
.PHONY: rename_dir

# Targets
all: rename_dir build run

# Rule to rename the top-level directory to match PROJECT_NAME
rename_dir:
	@if [ ! -d $(PROJECT_NAME) ]; then \
		mv -v rustify $(PROJECT_NAME); fi

# Target: build-image
# Description: Builds the Docker image using the specified Dockerfile
.PHONY: build-image
build-image: rename_dir
	@$(DOCKER_HOST) image build -t $(DOCKER_IMG_NAME) -f $(DOCKER_FILE_PATH) $(DOCKER_BUILD_CONTEXT)

# Target: build
# Description: Builds the Rust code inside a Docker container
docker-build: build-image
	@$(DOCKER_HOST) container run $(DOCKER_ARG) $(DOCKER_IMG_NAME) "$(CARGO) build"

# Target: test
# Description: Tests the Rust code inside a Docker container
docker-test: build-image
	@$(DOCKER_HOST) container run $(DOCKER_ARG) $(DOCKER_IMG_NAME) "$(CARGO) test"

# Target: run
# Description: Runs the Rust code inside a Docker container
docker-run: build-image
	@$(DOCKER_HOST) container run $(DOCKER_ARG) $(DOCKER_IMG_NAME) "$(CARGO) run"

# Target: clean
# Description: Cleans the Rust build artifacts inside a Docker container
docker-clean: build-image
	@$(DOCKER_HOST) container run $(DOCKER_ARG) $(DOCKER_IMG_NAME) "$(CARGO) clean"

.PHONY: clean test
