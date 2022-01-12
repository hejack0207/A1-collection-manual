# virt-builder-repository(1)

libguestfs-1.40.2, 2019-02-07

.if n .ad l
.nh

<a name="name"></a>

# Name

virt-builder-repository - Build virt-builder source repository easily

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 2  virt-builder-repository /path/to/repository     [-i|--interactive] [--gpg-key KEYID] .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Virt-builder is a tool for quickly building new virtual machines. It can
be configured to use template repositories. However creating and
maintaining a repository involves many tasks which can be automated.
virt-builder-repository is a tool helping to manage these repositories.

Virt-builder-repository loops over the files in the directory specified
as argument, compresses the files with a name ending by \f(CW`qcow2\*(C', \f(CW\*(C\`raw\*(C',
\f(CW`img\*(C' or without extension, extracts data from them and creates or
updates the \f(CW`index\*(C' file.

Some of the image-related data needed for the index file can’t be
computed from the image file. virt-builder-repository first tries to
find them in the existing index file. If data are still missing after
this, they are prompted in interactive mode, otherwise an error will
be triggered.

If a \f(CW`KEYID\*(C' is provided, the generated index file will be signed
with this \s-1GPG\s0 key.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"

<a name="create-the-initial-repository"></a>

### Create the initial repository

.IX Subsection "Create the initial repository"
Create a folder and copy the disk image template files in it. Then
run a command like the following one:

.Vb 1
 virt-builder-repository --gpg-key "joe@hacker.org" -i /path/to/folder
.Ve

Note that this example command runs in interactive mode. To run in
automated mode, a minimal index file needs to be created before running
the command containing sections like this one:

.Vb 2
 [template_id]
 file=template_filename.qcow.xz
.Ve

The file value needs to match the image name extended with the \f(CW`.xz\*(C'
suffix if the _--no-compression_ parameter is not provided or the
image name if no compression is involved. Other optional data can be
prefilled. Default values are computed by inspecting the disk image.
For more informations, see
Creating and signing the index file\*(R" in **virt-builder**\|(1).

<a name="update-images-in-an-existing-repository"></a>

### Update images in an existing repository

.IX Subsection "Update images in an existing repository"
In this use case, a new image or a new revision of an existing image
needs to be added to the repository. Place the corresponding image
template files in the repository folder.

To update the revision of an image, the file needs to have the same
name than the existing one (without the \f(CW`xz\*(C' extension).

As in the repository creation use case, a minimal fragment can be
added to the index file for the automated mode. This can be done
on the signed index even if it may sound a strange idea: the index
will be signed again by the tool.

To remove an image from the repository, just remove the corresponding
image file before running virt-builder-repository.

Then running the following command will complete and update the index
file:

.Vb 1
 virt-builder-repository --gpg-key "joe@hacker.org" -i /path/to/folder
.Ve

virt-builder-repository works in a temporary folder inside the repository
one. If anything wrong happens when running the tool, the repository is
left untouched.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **--help**  
  .IX Item "--help"
  Display help.
* **--gpg** \s-1GPG\s0  
  .IX Item "--gpg GPG"
  Specify an alternate **gpg**\|(1) (\s-1GNU\s0 Privacy Guard) binary.  You can
  also use this to add gpg parameters, for example to specify an
  alternate home directory:
  .Sp
  .Vb 1
   virt-builder-repository --gpg "gpg --homedir /tmp" [...]
  .Ve
  .Sp
  This can also be used to avoid gpg asking for the key passphrase:
  .Sp
  .Vb 1
   virt-builder-repository --gpg "gpg --passphrase-file /tmp/pass --batch" [...]
  .Ve
* **-K** \s-1KEYID\s0  
  .IX Item "-K KEYID"
* **--gpg-key** \s-1KEYID\s0  
  .IX Item "--gpg-key KEYID"
  Specify the \s-1GPG\s0 key to be used to sign the repository index file.
  If not provided, the index will left unsigned. \f(CW`KEYID\*(C' is used to
  identify the \s-1GPG\s0 key to use. This value is passed to gpg’s
  _--default-key_ option and can thus be an email address or a
  fingerprint.
  .Sp
  **\s-1NOTE\s0**: by default, virt-builder-repository searches for the key
  in the user’s \s-1GPG\s0 keyring.
* **-i**  
  .IX Item "-i"
* **--interactive**  
  .IX Item "--interactive"
  Prompt for missing data. Default values are computed from the disk
  image.
  .Sp
  When prompted for data, inputting \f(CW`-\*(C' corresponds to leaving the
  value empty. This can be used to avoid setting the default computed value.
* **--no-compression**  
  .IX Item "--no-compression"
  Don’t compress the template images.
* **--machine-readable**  
  .IX Item "--machine-readable"
* **--machine-readable**=format  
  .IX Item "--machine-readable=format"
  This option is used to make the output more machine friendly
  when being parsed by other programs.  See
  \s-1MACHINE READABLE OUTPUT\*(R"\s0 below.
* **--colors**  
  .IX Item "--colors"
* **--colours**  
  .IX Item "--colours"
  Use \s-1ANSI\s0 colour sequences to colourize messages.  This is the default
  when the output is a tty.  If the output of the program is redirected
  to a file, \s-1ANSI\s0 colour sequences are disabled unless you use this
  option.
* **-q**  
  .IX Item "-q"
* **--quiet**  
  .IX Item "--quiet"
  Don’t print ordinary progress messages.
* **-v**  
  .IX Item "-v"
* **--verbose**  
  .IX Item "--verbose"
  Enable debug messages and/or produce verbose output.
  .Sp
  When reporting bugs, use this option and attach the complete output to
  your bug report.
* **-V**  
  .IX Item "-V"
* **--version**  
  .IX Item "--version"
  Display version number and exit.
* **-x**  
  .IX Item "-x"
  Enable tracing of libguestfs \s-1API\s0 calls.

<a name="machine-readable-output"></a>

# Machine Readable Output

.IX Header "MACHINE READABLE OUTPUT"
The _--machine-readable_ option can be used to make the output more
machine friendly, which is useful when calling virt-builder-repository from
other programs, GUIs etc.

Use the option on its own to query the capabilities of the
virt-builder-repository binary.  Typical output looks like this:

.Vb 2
 $ virt-builder-repository --machine-readable
 virt-builder-repository
.Ve

A list of features is printed, one per line, and the program exits
with status 0.

It is possible to specify a format string for controlling the output;
see \s-1ADVANCED MACHINE READABLE OUTPUT\*(R"\s0 in **guestfs**\|(3).

<a name="exit-status"></a>

# Exit Status

.IX Header "EXIT STATUS"
This program returns 0 if successful, or non-zero if there was an
error.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**virt-builder**\|(1)
http://libguestfs.org/.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Cédric Bosdonnat mailto:[cbosdonnat@suse.com](mailto:cbosdonnat@suse.com)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (C) 2016-2019 \s-1SUSE\s0 Inc.

<a name="license"></a>

# License

.IX Header "LICENSE"
This program is free software; you can redistribute it and/or modify it
under the terms of the \s-1GNU\s0 General Public License as published by the
Free Software Foundation; either version 2 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
\s-1WITHOUT ANY WARRANTY\s0; without even the implied warranty of
\s-1MERCHANTABILITY\s0 or \s-1FITNESS FOR A PARTICULAR PURPOSE.\s0  See the \s-1GNU\s0
General Public License for more details.

You should have received a copy of the \s-1GNU\s0 General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, \s-1MA 02110-1301 USA.\s0

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
To get a list of bugs against libguestfs, use this link:
https://bugzilla.redhat.com/buglist.cgi?component=libguestfs&product=Virtualization+Tools

To report a new bug against libguestfs, use this link:
https://bugzilla.redhat.com/enter_bug.cgi?component=libguestfs&product=Virtualization+Tools

When reporting a bug, please supply:

* ·  
  The version of libguestfs.
* ·  
  Where you got libguestfs (eg. which Linux distro, compiled from source, etc)
* ·  
  Describe the bug accurately and give a way to reproduce it.
* ·  
  Run **libguestfs-test-tool**\|(1) and paste the **complete, unedited**
  output into the bug report.
