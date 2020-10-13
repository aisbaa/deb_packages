# update_deb_packages

A tool to update the path and SHA256 hash of packages referred to by
`deb_packages` rules in WORKSPACE files.  (Essentially `apt-get update &&
apt-get upgrade` for `deb_packages` rules in the current WORKSPACE.)

[(Documentation here)](https://github.com/bazelbuild/rules_pkg/tree/master/deb_packages/tools/update_deb_packages)

## The algorithm

1. Chosse a Debian mirror that you want to use, for example
   http://deb.debian.org/debian.

2. Visit the `/dists/` directory on that mirror and choose the distro you want
   to use, for example `jessie`.

3. Download the `Release` and `Release.gpg` files in the distro's folder (in
   our example: http://deb.debian.org/debian/dists/jessie/Release and
   http://deb.debian.org/debian/dists/jessie/Release.gpg).

4. Verify the file's signature: `gpg --verify Release.gpg Release` It **must**
   be signed with a vald signature by one of the keys on this site:
   https://ftp-master.debian.org/keys.html

5. Also create a `http_file` rule that references this key and make sure to
   include a SHA256 hash, so it won't change later:

   ```bzl
   http_file(
       name = "jessie_archive_key",
       sha256 = "e42141a829b9fde8392ea2c0e329321bb29e5c0453b0b48e33c9f88bdc4873c5",
       urls = ["https://ftp-master.debian.org/keys/archive-key-8.asc"],
   )
   ```

7. Acquire Packages.xz file, it contains the paths to various other files and
   their hashes.  Scroll down to the SHA256 section and choose the path to the
   `Packages` file that you want to use (for example
   `main/binary-amd64/Packages.xz`) and also note down its hash.

8. Append the `Packages` file path to your mirror URL + `/dists/yourdistro`
   (for example
   http://deb.debian.org/debian/dists/jessie/main/binary-amd64/Packages.xz)
   and download the resulting file.

9. Verify the hash of the file you received (with the exception of the GPG
   keys site, all these downloads happen on insecure channels by design) with
   `sha256sum`: `sha256sum Packages.xz`

10. Unpack the archive (if you downloaded the `Packages.gz` or `Packages.xz`
    file) and now you'll have a huge text file that contains hashes and paths
    to all Debian packages in that repository.

11. Open this file and start looking for the package names you want to use in
    your `BUILD` files.  You can do this for example in a text editor or using
    `grep` (the -A switch prints that many lines after each match): `grep -A
    25 "Package: python2.7-minimal" Packages`

12. Now you finally have the info that you must enter in the `deb_packages`
    rule: The value at `Filename` is the path to the exact package to be used
    and the value at `SHA256` is the verified hash that this file will have.

13. Now enter this information in the `WORKSPACE` file in a `deb_packages`
    rule:

    ```bzl
    deb_packages(
        name = "my_new_manual_source",
        arch = "amd64",
        distro = "jessie",
        distro_type = "debian",
        mirrors = [
            "http://deb.debian.org/debian",
            "http://my.private.mirror/debian",
        ],
        packages = {
            "libpython2.7-minimal": "pool/main/p/python2.7/libpython2.7-minimal_2.7.9-2+deb8u1_amd64.deb",
        },
        packages_sha256 = {
            "libpython2.7-minimal": "916e2c541aa954239cb8da45d1d7e4ecec232b24d3af8982e76bf43d3e1758f3",
        },
        pgp_key = "jessie_archive_key",
    )
    ```
