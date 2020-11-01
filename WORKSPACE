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
    commit = "9e8e0b390897c84cad53ebe9ed2d1d331a5394d9",
    importpath = "golang.org/x/crypto",
)

# "github.com/knqyf263/go-deb-version"
go_repository(
    name = "com_github_knqyf263_go_deb_version",
    commit = "09fca494f03d83586ddc06a1cb3fa992626e4f79",
    importpath = "github.com/knqyf263/go-deb-version",
)

# "github.com/stapelberg/godebiancontrol"
go_repository(
    name = "com_github_stapelberg_godebiancontrol",
    commit = "8c93e189186a10b222a6c6f55d9a89e36d346f42",
    importpath = "github.com/stapelberg/godebiancontrol",
)

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
        "php7.3-cli": "pool/main/p/php7.3/php7.3-cli_7.3.19-1~deb10u1_amd64.deb",
        "zsh": "pool/main/z/zsh/zsh_5.7.1-1_amd64.deb",
        "zsh-common": "pool/main/z/zsh/zsh-common_5.7.1-1_all.deb",
    },
    packages_sha256 = {
        "php7.3-cli": "30263f918793264ca38e707058baf328372388d4572747588d1781ea1cb64fc3",
        "zsh": "e400e604e452b9d4709889ceec035c3ab26c2e14592fa11f2954a613f911977a",
        "zsh-common": "e6f57ba10d4776cc8895f08ea800a3622c61126f89e92b2a3f2998d4b1e16b9e",
    },
    pgp_key = "buster_archive_key",
)

deb_repository(
    name = "debian_buster_amd64_pkgs_local_key",
    arch = "amd64",
    distro = "buster",
    distro_type = "debian",
    mirrors = [
        "http://deb.debian.org/debian",
    ],
    packages = {"libargon2-1": "pool/main/a/argon2/libargon2-1_0~20171227-0.2_amd64.deb"},
    packages_sha256 = {"libargon2-1": "0d2be32c122d26bbd9b604fbe0072265e4978e07b0e1b7149ba364ba3cc5a302"},
    pgp_key = "file://third-party/deb-keys/archive-key-10.asc",
)

deb_repository(
    name = "debian_buster_amd64_pkgs_no_key",
    arch = "amd64",
    distro = "buster",
    distro_type = "debian",
    mirrors = [
        "http://deb.debian.org/debian",
    ],
    packages = {
        "base-files": "pool/main/b/base-files/base-files_10.3+deb10u6_amd64.deb",
        "bash": "pool/main/b/bash/bash_5.0-4_amd64.deb",
        "debianutils": "pool/main/d/debianutils/debianutils_4.8.6.1_amd64.deb",
        "dpkg": "pool/main/d/dpkg/dpkg_1.19.7_amd64.deb",
        "gawk": "pool/main/g/gawk/gawk_4.2.1+dfsg-1_amd64.deb",
        "gcc-8-base": "pool/main/g/gcc-8/gcc-8-base_8.3.0-6_amd64.deb",
        "install-info": "pool/main/t/texinfo/install-info_6.5.0.dfsg.1-4+b1_amd64.deb",
        "libacl1": "pool/main/a/acl/libacl1_2.2.53-4_amd64.deb",
        "libattr1": "pool/main/a/attr/libattr1_2.4.48-4_amd64.deb",
        "libbz2-1.0": "pool/main/b/bzip2/libbz2-1.0_1.0.6-9.2~deb10u1_amd64.deb",
        "libc6": "pool/main/g/glibc/libc6_2.28-10_amd64.deb",
        "libgcc1": "pool/main/g/gcc-8/libgcc1_8.3.0-6_amd64.deb",
        "libgmp10": "pool/main/g/gmp/libgmp10_6.1.2+dfsg-4_amd64.deb",
        "liblzma5": "pool/main/x/xz-utils/liblzma5_5.2.4-1_amd64.deb",
        "libmpfr6": "pool/main/m/mpfr4/libmpfr6_4.0.2-1_amd64.deb",
        "libpcre3": "pool/main/p/pcre3/libpcre3_8.39-12_amd64.deb",
        "libreadline7": "pool/main/r/readline/libreadline7_7.0-5_amd64.deb",
        "libselinux1": "pool/main/libs/libselinux/libselinux1_2.8-1+b1_amd64.deb",
        "libsigsegv2": "pool/main/libs/libsigsegv/libsigsegv2_2.12-2_amd64.deb",
        "libtinfo6": "pool/main/n/ncurses/libtinfo6_6.1+20181013-2+deb10u2_amd64.deb",
        "mawk": "pool/main/m/mawk/mawk_1.3.3-17+b3_amd64.deb",
        "original-awk": "pool/main/o/original-awk/original-awk_2012-12-20-6_amd64.deb",
        "readline-common": "pool/main/r/readline/readline-common_7.0-5_all.deb",
        "tar": "pool/main/t/tar/tar_1.30+dfsg-6_amd64.deb",
        "zlib1g": "pool/main/z/zlib/zlib1g_1.2.11.dfsg-1_amd64.deb",
    },
    packages_sha256 = {
        "base-files": "ed640f8e2ab4e44731485ac7658a269012b9318ec8c6fb7b2b78825a624a9939",
        "bash": "d07f3528c615545bb182269362926bc171adab565dade3e8c35cb3bae8ad9e5e",
        "debianutils": "a61f69765e0871d1d9c1f9915d0c7fbd2d5365d02f2fe99039f3dff64fd527e9",
        "dpkg": "4eaa78124b0a5495fd06afefc79f7c96a7f7795c6b6a45349ac4173b0c9b7362",
        "gawk": "619f27785060d2d942b23a897481bb5fc068c8bba7afc710e48dbf1ec410ad08",
        "gcc-8-base": "1b00f7cef567645a7e695caf6c1ad395577e7d2e903820097ebd3496ddcfcc84",
        "install-info": "1b29164d4254cf34084fcd3b8ee2c4782874386e2a1c5099a1f5b55475052815",
        "libacl1": "ca1b512a4a09317018408bbb65ee3f48abdf03dcb8da671554a1f2bd8e5d4de4",
        "libattr1": "4ba903c087f2b9661e067ca210cfd83ef2dc1a162a15b8735997bfa96ac8e760",
        "libbz2-1.0": "238193cbaa71cc5365ef2aa5ad45de8521ac38dd54f4ab53bafa7de15046fa89",
        "libc6": "6f703e27185f594f8633159d00180ea1df12d84f152261b6e88af75667195a79",
        "libgcc1": "b1bb7611f3372732889d502cb1d09fe572b5fbb5288a4a8b1ed0363fecc3555a",
        "libgmp10": "d9c9661c7d4d686a82c29d183124adacbefff797f1ef5723d509dbaa2e92a87c",
        "liblzma5": "292dfe85defad3a08cca62beba85e90b0231d16345160f4a66aba96399c85859",
        "libmpfr6": "d005438229811b09ea9783491c98b145c9bcf6489284ad7870c19d2d09a8f571",
        "libpcre3": "5496ea46b812b1a00104fc97b30e13fc5f8f6e9ec128a8ff4fd2d66a80cc6bee",
        "libreadline7": "01e99d68427722e64c603d45f00063c303b02afb53d85c8d1476deca70db64c6",
        "libselinux1": "05238a8c13c32418511a965e7b756ab031c140ef154ca0b3b2a1bb7a14e2faab",
        "libsigsegv2": "78d1be36433355530c2e55ac8a24c41cbbdd8f5a3c943e614c8761113a72cb8d",
        "libtinfo6": "7f39c7a7b02c3373a427aa276830a6e1e0c4cc003371f34e2e50e9992aa70e1a",
        "mawk": "054b9bf39546852c24355349d1973493733ae6ac3f0f82f61708979af17fc79f",
        "original-awk": "29257e2e680215cf49a1924e187ca23a465b1754e10c427f026f99f6d79efc63",
        "readline-common": "153d8a5ddb04044d10f877a8955d944612ec9035f4c73eec99d85a92c3816712",
        "tar": "8afffcf03195b06b0345a81b307d662fb9419c5795e238ccc5b36eceea3ec22f",
        "zlib1g": "61bc9085aadd3007433ce6f560a08446a3d3ceb0b5e061db3fc62c42fbfe3eff",
    },
)
