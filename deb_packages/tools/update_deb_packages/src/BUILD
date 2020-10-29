load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")

go_library(
    name = "go_default_library",
    srcs = [
        "update_deb_packages.go",
    ],
    importpath = "github.com/aisbaa/deb_packages/deb_packages/tools/update_deb_packages/src",
    deps = [
        "@com_github_knqyf263_go_deb_version//:go_default_library",
        "@com_github_stapelberg_godebiancontrol//:go_default_library",
        "@org_golang_x_crypto//openpgp:go_default_library",
    ],
)

go_binary(
    name = "update_deb_packages",
    embed = [":go_default_library"],
    visibility = ["//visibility:public"],
)

go_binary(
    name = "update_deb_packages-darwin",
    out = "update_deb_packages-darwin_amd64",
    embed = [":go_default_library"],
    goarch = "amd64",
    goos = "darwin",
    pure = "on",
    visibility = ["//visibility:public"],
)

go_binary(
    name = "update_deb_packages-linux",
    out = "update_deb_packages-linux_amd64",
    embed = [":go_default_library"],
    goarch = "amd64",
    goos = "linux",
    pure = "on",
    visibility = ["//visibility:public"],
)
