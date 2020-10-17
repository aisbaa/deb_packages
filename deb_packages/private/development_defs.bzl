def get_update_deb_packages():
    return Label(
        "@aisbaa_rules_deb_packages//deb_packages/tools/update_deb_packages/src:update_deb_packages"
    )
