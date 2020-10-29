# Copyright 2017 mgIT GmbH All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@aisbaa_rules_deb_packages//deb_packages/private:development_defs.bzl", "get_update_deb_package")

SCRIPT_CONTENT = """
set -x

# setup path additional required tools
EXTRA_PATH=\"$(pwd)/$(dirname {the_tool_path})\"
export PATH="$EXTRA_PATH:$PATH"

# move to workspace directory to modify files
WORKSPACE=$(dirname $(readlink WORKSPACE))
cd "$WORKSPACE"
the_tool {args} $@
"""

def _update_deb_packages_create_script_impl(ctx):
    # symlink required tools to work directory
    bin_buildifier = ctx.actions.declare_file('buildifier')
    ctx.actions.symlink(
        output = bin_buildifier,
        target_file=ctx.attr._buildifier.files.to_list()[0],
        is_executable=True,
    )

    bin_buildozer = ctx.actions.declare_file('buildozer')
    ctx.actions.symlink(
        output = bin_buildozer,
        target_file=ctx.attr._buildozer.files.to_list()[0],
        is_executable=True,
    )

    bin_the_tool = ctx.actions.declare_file('the_tool')
    ctx.actions.symlink(
        output = bin_the_tool,
        target_file=ctx.attr._update_deb_packages.files.to_list()[0],
        is_executable=True,
    )

    # create entrypoint script
    script_content = SCRIPT_CONTENT.format(
        the_tool_path=bin_the_tool.short_path,
        args=" ".join(ctx.attr.args)
    )
    script_file = ctx.actions.declare_file(
        ctx.label.name + ".bash"
    )
    ctx.actions.write(
        script_file,
        script_content,
        is_executable=True
    )

    return struct(
        files = depset([script_file]),
        runfiles = ctx.runfiles([
            bin_the_tool,
            bin_buildozer,
            bin_buildifier,
        ])
    )

_update_deb_packages_create_script = rule(
    implementation = _update_deb_packages_create_script_impl,
    attrs = {
        "args": attr.string_list(),
        "pgp_keys": attr.label_list(),
        "_update_deb_packages": attr.label(
            default = get_update_deb_package(),
            allow_single_file = True,
            executable = True,
            cfg = "host",
        ),
        "_buildozer": attr.label(
            default = Label("@buildozer_linux_bin//file"),
            allow_single_file = True,
            executable = True,
            cfg = "host",
        ),
        "_buildifier": attr.label(
            default = Label("@buildifier_linux_bin//file"),
            allow_single_file = True,
            executable = True,
            cfg = "host",
        ),
    },
)


def update_deb_packages(name, pgp_keys, **kwargs):
    """
    Updates deb_repository rules with deb packages from container_layer and
    container_image
    """

    script_name = name + "_create_script"
    out = _update_deb_packages_create_script(
        name = script_name,
        tags = ["manual"],
        **kwargs
    )
    native.sh_binary(
        name = name,
        srcs = [script_name],
        data = ["//:WORKSPACE"] + pgp_keys,
        tags = ["manual"],
    )
