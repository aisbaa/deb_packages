load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

pkg_tar(
    name="deb_packages_tar",
    srcs=[
        ":all_rules",
    ],
)

filegroup(
    name = "all_rules",
    srcs = glob(["*.bzl"]),
    visibility = ["//visibility:public"],
)
