# Include configuration files
include conf/docker.mk

# Define the Rust compiler command
RUSTC := rustc

# Define the Cargo command
CARGO := cargo

# Define the Rust source file
SRC := src

# Define the path to the Dockerfile
DOCKER_FILE_PATH := dockerfiles/Dockerfile.alpine

# Define the default target
.PHONY: all
all: build

# Target: build-image
# Description: Builds the Docker image using the specified Dockerfile
.PHONY: build-image
build-image:
	@$(DOCKER_HOST) image build -t $(DOCKER_IMG_NAME) -f $(DOCKER_FILE_PATH) $(DOCKER_BUILD_CONTEXT)

# Target: build
# Description: Builds the Rust code inside a Docker container
build: build-image
	@$(DOCKER_HOST) container run $(DOCKER_ARG) $(DOCKER_IMG_NAME) "$(CARGO) build"

# Target: test
# Description: Tests the Rust code inside a Docker container
test: build-image
	@$(DOCKER_HOST) container run $(DOCKER_ARG) $(DOCKER_IMG_NAME) "$(CARGO) test"

# Target: run
# Description: Runs the Rust code inside a Docker container
run: build-image
	@$(DOCKER_HOST) container run $(DOCKER_ARG) $(DOCKER_IMG_NAME) "$(CARGO) run"

# Target: clean
# Description: Cleans the Rust build artifacts inside a Docker container
clean: build-image
	@$(DOCKER_HOST) container run $(DOCKER_ARG) $(DOCKER_IMG_NAME) "$(CARGO) clean"

.PHONY: clean test
