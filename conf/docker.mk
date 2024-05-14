## Docker Settings
DOCKER_HOST = docker

# Specifies the context directory used for building the Docker image.
DOCKER_BUILD_CONTEXT = .

# UID (User ID) for the Docker container. Defaults to current user's UID.
DOCKER_UID ?= $(shell id -u)

# GID (Group ID) for the Docker container. Defaults to current user's GID.
DOCKER_GID ?= $(shell id -g)

# Arguments to pass to the Docker command for setting user and mounting volumes.
DOCKER_USER_ARG ?= --user $(DOCKER_UID):$(DOCKER_GID)

# Define the Docker container name // TODO
# CONTAINER_NAME := myrustapp_container

# Project Settings // TODO
PROJECT_NAME := project

# Name of the Docker image based on the repository root directory name.
DOCKER_BASE_IMG_NAME := $(PROJECT_NAME)

# Version of the Docker image, derived from Git tags.
DOCKER_IMG_TAG := $(shell git rev-parse --short HEAD)

# Full name of the Docker image including name and version.
DOCKER_IMG_NAME := $(DOCKER_BASE_IMG_NAME):$(DOCKER_IMG_TAG)

# Flags to pass to `docker build` for building the dependencies image.
DOCKER_DEPS_IMAGE_BUILD_FLAGS ?= --no-cache=true

# Volume mount configuration for Docker container.
DOCKER_VOL ?= --volume $(shell pwd)/$(PROJECT_NAME):/$(PROJECT_NAME)

# Directory to work within the Docker container.
DOCKER_WORK_DIR ?= -w /$(PROJECT_NAME)

# Arguments to pass to the Docker command for building the image.
# DOCKER_ARG ?= --init --rm --interactive $(DOCKER_USER_ARG) / FIXME
DOCKER_ARG ?= --init --rm --interactive $(DOCKER_VOL) $(DOCKER_WORK_DIR)

# Check if the Docker container with dependencies is running.
IF_CONTAINER_RUNS := $(shell docker container inspect -f '{{.State.Running}}' ${DOCKER_DEPS_CONTAINER} 2>/dev/null)

# Define default values for Docker container variables
DOCKER_DEPS_CONTAINER ?=

# Ensure clarity in conditional logic
ifeq ($(strip $(IF_CONTAINER_RUNS)),)
    CONTAINER_STATUS := "Not Running"
else
    CONTAINER_STATUS := "Running"
endif

# Ensure parameter validation // FIXME
# ifeq ($(strip $(DOCKER_UID)),)
#     $(error DOCKER_UID is not set)
# endif

# ifeq ($(strip $(DOCKER_GID)),)
#     $(error DOCKER_GID is not set)
# endif
