workspace(name = "aisbaa_rules_deb_packages")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "a82a352bffae6bee4e95f68a8d80a70e87f42c4741e6a448bec11998fcc82329",
    urls = ["https://github.com/bazelbuild/rules_go/releases/download/0.18.5/rules_go-0.18.5.tar.gz"],
)
http_archive(
    name = "bazel_gazelle",
    sha256 = "3c681998538231a2d24d0c07ed5a7658cb72bfb5fd4bf9911157c0e9ac6a2687",
    urls = ["https://github.com/bazelbuild/bazel-gazelle/releases/download/0.17.0/bazel-gazelle-0.17.0.tar.gz"],
)
load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies", "go_register_toolchains")
go_rules_dependencies()
go_register_toolchains()
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
gazelle_dependencies()

# Go dependencies of the update_deb_packages helper tool
load("@bazel_gazelle//:deps.bzl", "go_repository")

# "golang.org/x/crypto/openpgp"
go_repository(
    name = "org_golang_x_crypto",
    commit = "d585fd2cc9195196078f516b69daff6744ef5e84",
    importpath = "golang.org/x/crypto",
)

# "github.com/knqyf263/go-deb-version"
go_repository(
    name = "com_github_knqyf263_go_deb_version",
    commit = "9865fe14d09b1c729188ac810466dde90f897ee3",
    importpath = "github.com/knqyf263/go-deb-version",
)

# "github.com/stapelberg/godebiancontrol"
go_repository(
    name = "com_github_stapelberg_godebiancontrol",
    commit = "4376b22fb2c4dfda546c972f686310af907819b2",
    importpath = "github.com/stapelberg/godebiancontrol",
)

# "github.com/bazelbuild/buildtools"
#go_repository(
#    name = "com_github_bazelbuild_buildtools",
#    commit = "9c928655df93b94eeb3dc7f6bd040cee71c7dc59",
#    importpath = "github.com/bazelbuild/buildtools",
#)

load("@aisbaa_rules_deb_packages//deb_packages:deps.bzl", "deb_packages_setup")

deb_packages_setup()

# for tests
load("@aisbaa_rules_deb_packages//deb_packages:defs.bzl", "deb_repository")

http_archive(
    name = "bazel_skylib",
    sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
    urls = [
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

# dowload gpg key for repo and
http_file(
    name = "buster_archive_key",
    sha256 = "9c854992fc6c423efe8622c3c326a66e73268995ecbe8f685129063206a18043",
    urls = ["https://ftp-master.debian.org/keys/archive-key-10.asc"],
)

deb_repository(
    name = "debian_buster_amd64_pkgs",
    arch = "amd64",
    distro = "buster",
    distro_type = "debian",
    mirrors = [
        "http://deb.debian.org/debian",
    ],
    packages = {
        "zsh": "pool/main/z/zsh/zsh_5.7.1-1_amd64.deb",
        "zsh-common": "pool/main/z/zsh/zsh-common_5.7.1-1_all.deb",
    },
    packages_sha256 = {
        "zsh": "e400e604e452b9d4709889ceec035c3ab26c2e14592fa11f2954a613f911977a",
        "zsh-common": "e6f57ba10d4776cc8895f08ea800a3622c61126f89e92b2a3f2998d4b1e16b9e",
    },
    pgp_key = "buster_archive_key",
)
