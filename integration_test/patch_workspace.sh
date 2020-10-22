set -x

# release package with requried bzl files
RELEASE_ARCHIVE_LOCATION_REL=$(find -L bazel-out -name package.tar.gz)
RELEASE_ARCHIVE_LOCATION=$(realpath "$RELEASE_ARCHIVE_LOCATION_REL")
RELEASE_ARCHIVE_CHECKSUM=$(sha256sum "${RELEASE_ARCHIVE_LOCATION}" | cut -d' ' -f1)
sed -i "s:RELEASE_ARCHIVE_LOCATION:${RELEASE_ARCHIVE_LOCATION}:" integration_test/WORKSPACE
sed -i "s:RELEASE_ARCHIVE_CHECKSUM:${RELEASE_ARCHIVE_CHECKSUM}:" integration_test/WORKSPACE

# release update_deb_packages
RELEASE_THE_TOOL_LOCATION_REL=$(find -L bazel-out -name update_deb_packages-linux_amd64)

RELEASE_THE_TOOL_LOCATION=$(realpath "$RELEASE_THE_TOOL_LOCATION_REL")
RELEASE_THE_TOOL_CHECKSUM=$(sha256sum "${RELEASE_THE_TOOL_LOCATION}" | cut -d' ' -f1)
sed -i "s:RELEASE_THE_TOOL_LOCATION:${RELEASE_THE_TOOL_LOCATION}:" integration_test/WORKSPACE
sed -i "s:RELEASE_THE_TOOL_CHECKSUM:${RELEASE_THE_TOOL_CHECKSUM}:" integration_test/WORKSPACE

# update tags so that it would be picked up by update_deb_packages
# if tags are commited it clashes with root project
(
    cd integration_test
    buildozer 'add tags deb_packages_auto' //image:zsh
)
