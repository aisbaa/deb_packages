# generate release tarball
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

pkg_tar(
    name = "package_private",
    extension = "tar.gz",
    package_dir = "deb_packages/private",
    srcs = [
        "//deb_packages/private:std_package",
    ]
)

pkg_tar(
    name = "package_public",
    extension = "tar.gz",
    package_dir = "deb_packages",
    srcs = [
        "//deb_packages:std_package",
    ]
)

genrule(
    name = "workspace_for_package",
    outs = [
        "WORKSPACE",
    ],
    cmd = "echo 'workspace( name \"aisbaa_rules_deb_packages\")' >$@",
)

pkg_tar(
    name = "package",
    extension = "tar.gz",
    srcs = [
        ":workspace_for_package",
    ],
    deps = [
        ":package_private",
        ":package_public",
    ],
)
