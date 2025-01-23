GIT_BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
GIT_COMMIT = $(shell git rev-parse --short HEAD)
GIT_TAG = $(shell git describe --tags --abbrev=0)
VERSION ?= $(GIT_TAG)

ifeq ($(GIT_BRANCH),main)
	# master branch
	override VERSION = $(GIT_BRANCH)
else
	# non-master branch
	override VERSION = $(GIT_TAG)
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

.PHONY: clone_and_push
clone_and_push:
	git clone git@github.com:your-username/your-repo.git temp-repo
	cp -r * temp-repo/
	cd temp-repo && git checkout -b $(GIT_BRANCH)
	cd temp-repo && git add .
	cd temp-repo && git commit -m "Copy data from current folder"
	cd temp-repo && git push origin $(GIT_BRANCH)
	rm -rf temp-repo

.PHONY: github_release
github_release:
	git clone git@github.com:dharmendrashaw/release-from-makefile.git
	cp * release-from-makefile/
	cd release-from-makefile
	git checkout -b $(VERSION)
	git add .
	git commit -m "Release $(VERSION)"
	git push origin $(VERSION)
