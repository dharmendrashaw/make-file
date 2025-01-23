GIT_BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
GIT_COMMIT = $(shell git rev-parse --short HEAD)
GIT_TAG = $(shell git describe --tags --abbrev=0)
VERSION ?= $(GIT_TAG)

ifeq ($(GIT_BRANCH),main)
	# master branch
	override VERSION = $(GIT_TAG)
else
	# non-master branch
	override VERSION = $(GIT_BRANCH)-$(GIT_COMMIT)
endif

.PHONY: print-variables
print-variables:
	@echo "Variables:"
	@echo "  GIT_BRANCH: $(GIT_BRANCH)"
	@echo "  GIT_COMMIT: $(GIT_COMMIT)"
	@echo "  GIT_TAG: $(GIT_TAG)"
	@echo "  VERSION: $(VERSION)"

.PHONY: github_push
github_push:
	git push origin $(GIT_BRANCH)