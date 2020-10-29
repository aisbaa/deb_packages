package(default_visibility = ["//visibility:public"])

# rules_go boilerplate
load("@bazel_gazelle//:def.bzl", "gazelle")

gazelle(
    name = "gazelle",
    prefix = "github.com/aisbaa/deb_package",
)

# update_deb_packages boilerplate
load("@aisbaa_rules_deb_packages//deb_packages:defs.bzl", "update_deb_packages")

update_deb_packages(
    name = "update_deb_packages",
    pgp_keys = [
        "@jessie_archive_key//file",
        "@stretch_archive_key//file",
    ],
)
