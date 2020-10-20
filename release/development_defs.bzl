# this file overwrites function that returns update_deb_packages target for release
def get_update_deb_package():
    return Label("@update_deb_packages_linux//file"),
