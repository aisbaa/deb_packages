load("@aisbaa_rules_deb_packages//:deb_packages.bzl",
     _deb_packages = "deb_packages"
)
load("@aisbaa_rules_deb_packages//deb_packages/tools/update_deb_packages:update_deb_packages.bzl",
    _update_deb_packages = "update_deb_packages"
)

deb_repository = _deb_packages
update_deb_packages = _update_deb_packages
