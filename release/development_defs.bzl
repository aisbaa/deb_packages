# this file overwrites function that returns update_deb_packages target for release
def get_update_deb_packages():
    return Label("@aisbaa_rules_deb_packages//bin/update_deb_packages")
