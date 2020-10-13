load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def deb_packages_setup():
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
