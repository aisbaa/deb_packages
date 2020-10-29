# Changelog

## v0.3

  - Ability to pass pgp key from local file using "file://" syntax (this is
    relative to workspace folder).

  - Ability to skip release file validation if pgp key is not available.

## v0.2

  - Handles packages with versions patter 0~YYYYMMDD-semver (for example
    libargon2-1 at the time of writing is 0~20171227-0.2)

  - Only include container_image and container_layer rules that are tagged
    with deb_packages_auto.

## v0.1

  - Tools buildozer and buildifier are downloaded as part of deps.
