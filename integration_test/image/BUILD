load("@debian_buster_amd64_pkgs//debs:deb_packages.bzl", "debian_buster_amd64_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")

container_image(
    name = "zsh",
    base = "@debian10//image",
    debs = [
        debian_buster_amd64_pkgs["zsh-common"],
        debian_buster_amd64_pkgs["zsh"],

        # add package with digits, dots and dashes to the test
        debian_buster_amd64_pkgs["php7.3-cli"],                     # pulled in by install.yaml
    ],
)
