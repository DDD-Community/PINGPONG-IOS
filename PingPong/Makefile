GENERATE = tuist generate
FETCH = tuist fetch
BUILD = tuist build
CLEAN = tuist clean

# Define your targets and dependencies

.PHONY: generate
generate:
	 TUIST_ROOT_DIR=${PWD} $(GENERATE)

.PHONY: build
build: $(CLEAN) $(FETCH) $(FETCH) TUIST_ROOT_DIR=${PWD} $(GENERATE)

.PHONY: clean
clean:
	$(CLEAN)

.PHONY: fetch
fetch:
	$(FETCH)

# Additional targets can be added as needed
