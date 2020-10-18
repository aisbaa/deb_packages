# deb_packages

This repo aims to provide tools to manage debian packages for container_image
and container_layer from
[bazelbuild/rules_docker](https://github.com/bazelbuild/rules_docker) repo.

[![Build Status](https://travis-ci.org/aisbaa/deb_packages.svg?branch=main)](https://travis-ci.org/aisbaa/deb_packages)

## Setup

1. Add this to WORKSPACE:

   ```bzl
   # check https://github.com/bazelbuild/rules_docker#setup for docker rule setup

   load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

   http_archive(
       name = "aisbaa_rules_deb_packages",
       sha256 = "63ba3f0e0467b178ef42147017de0fce64532b308bdc72246fe2b0e543de6cdf",
       urls = [
           "https://github.com/aisbaa/deb_packages/releases/dowload/v0.1.3-beta.1/deb_packages-v0.1.3.tar.gz",
       ],
   )

   load("@aisbaa_rules_deb_packages//deb_packages:defs.bzl", "deb_repository")
   load("@aisbaa_rules_deb_packages//deb_packages:deps.bzl", "deb_packages_setup")
   deb_packages_setup()

   # example for debian buster

   # dowload gpg key for repo and
   http_file(
       name = "buster_archive_key",
       sha256 = "9c854992fc6c423efe8622c3c326a66e73268995ecbe8f685129063206a18043",
       urls = ["https://ftp-master.debian.org/keys/archive-key-10.asc"],
   )

   deb_repository(
       name = "debian_buster_amd64_pkgs",
       arch = "amd64",
       distro = "buster",
       distro_type = "debian",
       mirrors = [
           "http://deb.debian.org/debian",
       ],
       packages = {
           # this will be populated by uodate_deb_packages rule
       },
       packages_sha256 = {
           # this will be populated by uodate_deb_packages rule
       },
       pgp_key = "buster_archive_key",
   )
   ```

2. Add docker rules and include packages you want to install:

   ```bzl
   load("@debian_buster_amd64_pkgs//debs:deb_packages.bzl", "debian_buster_amd64_pkgs")

   container_image(
       name = "zsh",
       base = "//base:base",
       debs = [
           debian_buster_amd64_pkgs["zsh-common"],
           debian_buster_amd64_pkgs["zsh"],
       ],
   )
   ```

3. Add `update_deb_packages` rule to a BUILD file, it is responsible for
   populating deb_repository rule in WORKSPACE file:

   ```
   load("@aisbaa_rules_deb_packages//deb_packages:defs.bzl", "update_deb_packages")

   update_deb_packages(
       name = "update_deb_packages",
       pgp_keys = [
           "@buster_archive_key//file",
       ],
   )
   ```

4. Run `bazel run :update_deb_packages` to get `@debian_buster_amd64_pkgs`
   pre-populated in WORKSPACE file.

5. Run `bazel run //:zsh` to build and push new docker image to local docker
   instance.


## Recognition

Most if not all code comes from this repo:
[https://github.com/bazelbuild/rules_pkg](https://github.com/bazelbuild/rules_pkg/tree/main/deb_packages).
