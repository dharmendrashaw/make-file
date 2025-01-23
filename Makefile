GIT_BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
GIT_COMMIT = $(shell git rev-parse --short HEAD)
GIT_TAG = $(shell git describe --tags --abbrev=0)

.PHONY: print-variables
print-variables:
	@echo "Variables:"
	@echo "  GIT_BRANCH: $(GIT_BRANCH)"
	@echo "  GIT_COMMIT: $(GIT_COMMIT)"
	@echo "  GIT_TAG: $(GIT_TAG)"

