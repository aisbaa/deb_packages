workspace(name = "aisbaa_rules_deb_packages")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

#
# go_rules --------------------------------------------------------------------
#

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "ac03931e56c3b229c145f1a8b2a2ad3e8d8f1af57e43ef28a26123362a1e3c7e",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.24.4/rules_go-v0.24.4.tar.gz",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.24.4/rules_go-v0.24.4.tar.gz",
    ],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "b85f48fa105c4403326e9525ad2b2cc437babaa6e15a3fc0b1dbab0ab064bc7c",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.22.2/bazel-gazelle-v0.22.2.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.22.2/bazel-gazelle-v0.22.2.tar.gz",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

go_rules_dependencies()

go_register_toolchains()

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

#
# docker rules ---------------------------------------------------------------
#

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "4521794f0fba2e20f3bf15846ab5e01d5332e587e9ce81629c7f96c793bb7036",
    strip_prefix = "rules_docker-0.14.4",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.14.4/rules_docker-v0.14.4.tar.gz"],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("@io_bazel_rules_docker//repositories:pip_repositories.bzl", "pip_deps")

pip_deps()

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
)

container_pull(
    name = "debian10",
    registry = "index.docker.io",
    repository = "debian",
    # digest = "sha256-b838471e0d4a19fd67dd6adb5961315d9b3e8a205e8f3970d7a75cd746001c5b",
    tag = "buster-20200908",
)

#
# deb_packages rules ----------------------------------------------------------
#

load("@aisbaa_rules_deb_packages//deb_packages:deps.bzl", "deb_packages_setup")
load("@aisbaa_rules_deb_packages//deb_packages:defs.bzl", "deb_repository")

deb_packages_setup()

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
