load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")

go_library(
    name = "go_default_library",
    srcs = [
        "update_deb_packages.go",
    ],
    importpath = "github.com/bazelbuild/rules_pkg/deb_packages/tools/update_deb_packages/src",
    deps = [
        #"@com_github_bazelbuild_buildtools//:go_default_library",
        "@com_github_knqyf263_go_deb_version//:go_default_library",
        "@com_github_stapelberg_godebiancontrol//:go_default_library",
        "@org_golang_x_crypto//openpgp:go_default_library",
    ],
)

go_binary(
    name = "update_deb_packages",
    srcs = ["update_deb_packages.go"],
    importpath = "github.com/bazelbuild/rules_pkg/deb_packages/tools/update_deb_packages/src",
    visibility = ["//visibility:public"],
    deps = [
        ":go_default_library",
        #"@com_github_bazelbuild_buildtools//:go_default_library",
        "@com_github_knqyf263_go_deb_version//:go_default_library",
        "@com_github_stapelberg_godebiancontrol//:go_default_library",
        "@org_golang_x_crypto//openpgp:go_default_library",
    ],
)

load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
pkg_tar(
    name = "update_deb_packages_bin_tar",
    srcs = [
        ":update_deb_packages"
    ],
    visibility = ["//visibility:public"],
)
