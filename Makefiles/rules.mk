# Targets
.PHONY: all test clean

BUILD_TOOL_CMD := cargo
CARGO_FLAGS := --manifest-path $(TOP_DIR)/Cargo.toml

BUILD_CMD := $(BUILD_TOOL_CMD) build $(CARGO_FLAGS) --jobs $(shell nproc)
TEST_CMD := $(BUILD_TOOL_CMD) test $(CARGO_FLAGS) --jobs $(shell nproc)
RUN_CMD := $(BUILD_TOOL_CMD) run $(CARGO_FLAGS)
CLEAN_CMD := $(BUILD_TOOL_CMD) clean $(CARGO_FLAGS)
# SONAR_CMD := $(BUILD_TOOL_CMD) sonar
