bazel ?= bazel

all: clean test test-integration

test:
	$(bazel) run //test:update_deb_packages
	$(bazel) run //test/image:zsh
	$(bazel) run //test/image:bash
	docker run -it --rm bazel/test/image:zsh zsh --version
	docker run -it --rm bazel/test/image:bash bash --version
.PHONY: test

test-integration:
	$(bazel) build //release:release_files
	bash ./integration_test/patch_workspace.sh
	cd integration_test && $(bazel) run :update_deb_packages
	grep 'php7.3-cli' integration_test/WORKSPACE
	grep 'libstdc++6' integration_test/WORKSPACE
	cd integration_test && $(bazel) run //image:zsh
	docker run -it --rm bazel/image:zsh zsh --version
.PHONY: test-integration

clean:
	git restore integration_test/WORKSPACE
	git restore integration_test/image/BUILD
.PHONY: clean
