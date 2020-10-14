exports_files(
    glob(["*.bzl"]),
    # visibility = ["//visibility:public"],
)

filegroup(
    name = "std_package",
    srcs = glob([
        "*.bzl",
        "BUILD",
    ]),
    visibility = ["//:__subpackages__"],
)
