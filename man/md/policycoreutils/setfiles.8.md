# setfiles(8) - set SELinux file security contexts.

"", 10 June 2016

```
setfiles [-c policy] [-d] [-l] [-m] [-n] [-e directory] [-p] [-s] [-v] [-W] [-F] [-I|-D] spec_file pathname&nbsp;...
```


<a name="description"></a>

# Description

This manual page describes the
**setfiles**
program.

This program is primarily used to initialize the security context
fields (extended attributes) on one or more filesystems (or parts of
them).  Usually it is initially run as part of the SELinux installation
process (a step commonly known as labeling).

It can also be run at any other time to correct inconsistent labels, to add
support for newly-installed policy or, by using the
**-n**
option, to passively
check whether the file contexts are all set as specified by the active policy
(default behavior) or by some other policy (see the
**-c**
option).

If a file object does not have a context,
**setfiles**
will write the default
context to the file object's extended attributes. If a file object has a
context,
**setfiles**
will only modify the type portion of the security context.
The
**-F**
option will force a replacement of the entire context.

<a name="options"></a>

# Options


* **-c**  
  check the validity of the contexts against the specified binary policy.
* **-d**  
  show what specification matched each file (do not abort validation
  after 10 errors). Not affected by "-q"
* **-e**_&nbsp;directory_  
  directory to exclude (repeat option for more than one directory).
* **-f**_&nbsp;infilename_  
  _infilename_
  contains a list of files to be processed. Use
  **-**\*(rq
  for
  **stdin**.
* **-F**  
  Force reset of context to match file_context for customizable files, and the
  default file context, changing the user, role, range portion as well as the
  type.
* **-h, -?**  
  display usage information and exit.
* **-i**  
  ignore files that do not exist.
* **-I**  
  ignore digest to force checking of labels even if the stored SHA1 digest
  matches the specfiles SHA1 digest. The digest will then be updated provided
  there are no errors. See the
  **NOTES**
  section for further details.
* **-D**  
  Set or update any directory SHA1 digests. Use this option to
  enable usage of the
  _security.restorecon_last_
  extended attribute.
* **-l**  
  log changes in file labels to syslog.
* **-m**  
  do not read
  **/proc/mounts**
  to obtain a list of non-seclabel mounts to be excluded from relabeling checks.
  Setting this option is useful where there is a non-seclabel fs mounted with a
  seclabel fs mounted on a directory below this.
* **-n**  
  don't change any file labels (passive check).
* **-o**_&nbsp;outfilename_  
  Deprecated - This option is no longer supported.
* **-p**  
  show progress by printing the number of files in 1k blocks unless relabeling the entire
  OS, that will then show the approximate percentage complete. Note that the
  **-p**
  and
  **-v**
  options are mutually exclusive.
* **-q**  
  Deprecated, was only used to stop printing inode association parameters.
* **-r**_&nbsp;rootpath_  
  use an alternate root path. Used in meta-selinux for OpenEmbedded/Yocto builds
  to label files under
  _rootpath_
  as if they were at
  **/**
* **-s**  
  take a list of files from standard input instead of using a pathname from the
  command line (equivalent to
  **-f -**\*(rq
  ).
* **-v**  
  show changes in file labels and output any inode association parameters.
  Note that the
  **-v**
  and
  **-p**
  options are mutually exclusive.
* **-W**  
  display warnings about entries that had no matching files by outputting the
  **selabel_stats**(3)
  results.
* **-0**  
  the separator for the input items is assumed to be the null character
  (instead of the white space).  The quotes and the backslash characters are
  also treated as normal characters that can form valid input.
  This option finally also disables the end of file string, which is treated
  like any other argument.  Useful when input items might contain white space,
  quote marks or backslashes.  The
  **-print0**
  option of GNU
  **find**
  produces input suitable for this mode.
  

<a name="arguments"></a>

# Arguments


* _spec_file_  
  The specification file which contains lines of the following form:

_regexp_
[_type_]
_context_&nbsp;|
**&lt;&lt;none&gt;&gt;**
The regular expression is anchored at both ends.  The optional
_type_
field specifies the file type as shown in the mode field by the
**ls**(1)
program, e.g.
**--**
to match only regular files or
**-d**
to match only
directories.  The
_context_
can be an ordinary security context or the
string
**&lt;&lt;none&gt;&gt;**
to specify that the file is not to have its context
changed.  
The last matching specification is used. If there are multiple hard
links to a file that match different specifications and those
specifications indicate different security contexts, then a warning is
displayed but the file is still labeled based on the last matching
specification other than
**&lt;&lt;none&gt;&gt;**\|.

* _pathname_&nbsp;...  
  The pathname for the root directory of each file system to be relabeled
  or a specific directory within a filesystem that should be recursively
  descended and relabeled or the pathname of a file that should be
  relabeled.
  Not used if the
  **-f**
  or the
  **-s**
  option is used.
  

<a name="notes"></a>

# Notes


* 1.  
  **setfiles**
  follows symbolic links and operates recursively on directories.
* 2.  
  If the
  _pathname_
  specifies the root directory and the
  **-v**
  option is set and the audit system is running, then an audit event is
  automatically logged stating that a "mass relabel" took place using the
  message label
  **FS_RELABEL**.
* 3.  
  To improve performance when relabeling file systems recursively
  the
  **-D**
  option to
  **setfiles**
  will cause it to store a SHA1 digest of the
  **spec_file**
  set in an extended attribute named
  _security.restorecon_last_
  on the directory specified in each
  _pathname_&nbsp;...
  once the relabeling has been completed successfully. This digest will be
  checked should
  **setfiles**
  **-D**
  be rerun
  with the same
  _spec_file_
  and
  _pathname_
  parameters. See
  **selinux_restorecon**(3)
  for further details.

The
**-I**
option will ignore the SHA1 digest from each directory specified in
_pathname_&nbsp;...
and provided the
**-n**
option is NOT set, files will be relabeled as required with the digest then
being updated provided there are no errors.


<a name="author"></a>

# Author

This man page was written by Russell Coker &lt;[russell@coker.com](mailto:russell@coker.com).au&gt;.
The program was written by Stephen Smalley &lt;[sds@tycho.nsa](mailto:sds@tycho.nsa).gov&gt;


<a name="see-also"></a>

# See Also

**restorecon**(8),
**load_policy**(8),
**checkpolicy**(8)
