bazel ?= bazel

all: clean test test-integration

test:
	$(bazel) run //test:update_deb_packages
	$(bazel) run //test/image:zsh
	docker run -it --rm bazel/test/image:zsh zsh --version
.PHONY: test

test-integration:
	$(bazel) build //release:release_files
	bash ./integration_test/patch_workspace.sh
	cd integration_test && $(bazel) run :update_deb_packages
	cd integration_test && $(bazel) run //image:zsh
	docker run -it --rm bazel/image:zsh zsh --version
.PHONY: test-integration

clean:
	git restore integration_test/WORKSPACE
	git restore integration_test/image/BUILD
.PHONY: clean
