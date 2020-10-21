load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def deb_packages_setup(the_tool_path=None, the_tool_sha=None):
    http_file(
        name = "buildozer_linux_bin",
        downloaded_file_path = "buildozer",
        executable = True,
        sha256 = "0a5a33891dd467560d00e5d162972ab9e4eca6974f061b1b34225e5bc5e978f4",
        urls = [
            "https://github.com/bazelbuild/buildtools/releases/download/3.5.0/buildozer",
        ],
    )

    http_file(
        name = "buildifier_linux_bin",
        downloaded_file_path = "buildifier",
        executable = True,
        sha256 = "f9a9c082b8190b9260fce2986aeba02a25d41c00178855a1425e1ce6f1169843",
        urls = [
            "https://github.com/bazelbuild/buildtools/releases/download/3.5.0/buildifier",
        ],
    )

    the_tool_path = the_tool_path or "https://github.com/aisbaa/deb_packages/releases/download/v0.2-beta/update_deb_packages-linux_amd64"
    the_tool_sha = the_tool_sha or "b97d19ae33214f6bdc71076d596039be1b6de5f3d5130f4aaa18fa762178dbce"

    http_file(
        name = "update_deb_packages_linux",
        downloaded_file_path = "update_deb_packages",
        executable = True,
        sha256 = the_tool_sha,
        urls = [the_tool_path],
    )
