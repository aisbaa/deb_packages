# updates deb_packages rules
load("@aisbaa_rules_deb_packages//deb_packages:defs.bzl", "update_deb_packages")

update_deb_packages(
    name = "update_deb_packages",
    pgp_keys = [
        "@buster_archive_key//file",
    ],
)
