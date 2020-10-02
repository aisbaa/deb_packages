# deb_packages

This repo aims to provide tools to manage debian packages for container_image
and container_layer from
[bazelbuild/rules_docker](https://github.com/bazelbuild/rules_docker) repo.

## Short instructions

1. Put this in your WORKSPACE file:

   ```bzl
   load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

   # deb_packages rules
   http_archive(
       name = "bazel_skylib",
       sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
       urls = [
           "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
           "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
       ],
   )
   load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
   bazel_skylib_workspace()

   http_archive(
       name = "deb_packages",
       sha256 = "d44353c10235abf39cb464ff2972b0d7e81f08dde5b1d70addda6a4944e863af",
       urls = [
           "https://github.com/aisbaa/deb_packages/releases/download/0.1/deb_packages-v0.1.1.tar.gz",
       ],
   )

   # deb_packages rules
   load("@deb_packages//:deb_packages.bzl", "deb_packages")

   # dowload gpg key for repo and
   http_file(
       name = "buster_archive_key",
       sha256 = "9c854992fc6c423efe8622c3c326a66e73268995ecbe8f685129063206a18043",
       urls = ["https://ftp-master.debian.org/keys/archive-key-10.asc"],
   )

   # packages dict will be populated by update_deb_packages rule
   deb_packages(
       name = "debian_buster_amd64_pkgs",
       arch = "amd64",
       distro = "buster",
       distro_type = "debian",
       mirrors = [
           "http://deb.debian.org/debian",
       ],
       packages = {
       },
       packages_sha256 = {
       },
       pgp_key = "buster_archive_key",
   )
   ```

2. Add docker rules:

   ```bzl
   load("@debian_buster_amd64_pkgs//debs:deb_packages.bzl", "debian_buster_amd64")

   container_image(
       name = "zsh",
       base = "//base:base",
       debs = [
           debian_buster_amd64["zsh-common"],
           debian_buster_amd64["zsh"],
       ],
   )
   ```

3. Add `update_deb_packages` rule to root BUILD file

   ```
   load("//tools/update_deb_packages:update_deb_packages.bzl", "update_deb_packages")

   update_deb_packages(
       name = "update_deb_packages",
       pgp_keys = [
           "@buster_archive_key//file",
       ],
   )
   ```

4. Run `bazel run :update_deb_packages` to get `@debian_buster_amd64_pkgs` rule.

5. Run `bazel run //:zsh` to build and push new docker image to local docker.


## Recognition

Most if not all code comes from this repo:
[https://github.com/bazelbuild/rules_pkg](https://github.com/bazelbuild/rules_pkg/tree/main/deb_packages).
