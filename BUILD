package(default_visibility = ["//visibility:public"])

# rules_go boilerplate
load("@bazel_gazelle//:def.bzl", "gazelle")

gazelle(
    name = "gazelle",
    prefix = "github.com/bazelbuild/rules_pkg",
)

# update_deb_packages boilerplate
load("//deb_packages/tools/update_deb_packages:update_deb_packages.bzl",
     "update_deb_packages")

update_deb_packages(
    name = "update_deb_packages",
    pgp_keys = [
        "@jessie_archive_key//file",
        "@stretch_archive_key//file",
    ],
)

# generate release tarball
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

genrule(
    name = "buildfile_for_release",
    outs = ["BUILD.bazel"],
    cmd = "echo 'exports_files([\"update_deb_packages\"])' >$@",
)

pkg_tar(
    name = "release",
    extension = "tar.gz",
    deps = [
        "//deb_packages:deb_packages_bzl_tar",
        "//deb_packages/tools/update_deb_packages:update_deb_packages_bzl_tar",
        "//deb_packages/tools/update_deb_packages/src:update_deb_packages_bin_tar"
    ],
)
