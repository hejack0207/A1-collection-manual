# restorecon(8) - restore file(s) default SELinux security contexts.

"", 10 June 2016

```
restorecon [-r|-R] [-m] [-n] [-p] [-v] [-i] [-F] [-W] [-I|-D] [-e directory] pathname&nbsp;... 
 restorecon [-f infilename] [-e directory] [-r|-R] [-m] [-n] [-p] [-v] [-i] [-F] [-W] [-I|-D]
```


<a name="description"></a>

# Description

This manual page describes the
**restorecon**
program.

This program is primarily used to set the security context
(extended attributes) on one or more files.

It can also be run at any other time to correct inconsistent labels, to add
support for newly-installed policy or, by using the
**-n**
option, to passively
check whether the file contexts are all set as specified by the active policy
(default behavior).

If a file object does not have a context,
**restorecon**
will write the default
context to the file object's extended attributes. If a file object has a
context,
**restorecon**
will only modify the type portion of the security context.
The
**-F**
option will force a replacement of the entire context.

If a file is labeled with
**customizable**
SELinux type (for list of customizable
types see /etc/selinux/{SELINUXTYPE}/contexts/customizable_types), restorecon
won't reset the label unless the -F option is used.

It is the same executable as
**setfiles**
but operates in a slightly different manner depending on its argv[0].


<a name="options"></a>

# Options


* **-e**_&nbsp;directory_  
  exclude a directory (repeat the option to exclude more than one directory, Requires full path).
* **-f**_&nbsp;infilename_  
  _infilename_
  contains a list of files to be processed. Use
  **-**\*(rq
  for
  **stdin**.
* **-F**  
  Force reset of context to match file_context for customizable files, and the
  default file context, changing the user, role, range portion as well as the type.
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
* **-m**  
  do not read
  **/proc/mounts**
  to obtain a list of non-seclabel mounts to be excluded from relabeling checks.
  Setting this option is useful where there is a non-seclabel fs mounted with a
  seclabel fs mounted on a directory below this.
* **-n**  
  don't change any file labels (passive check).  To display the files whose labels would be changed, add
  **-v**.
* **-o**_&nbsp;outfilename_  
  Deprecated - This option is no longer supported.
* **-p**  
  show progress by printing the number of files in 1k blocks unless relabeling the entire
  OS, that will then show the approximate percentage complete. Note that the
  **-p**
  and
  **-v**
  options are mutually exclusive.
* **-R, -r**  
  change files and directories file labels recursively (descend directories).  
* **-v**  
  show changes in file labels. Multiple -v options increase the verbosity. Note that the
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
* 
<a name="arguments"></a>

# Arguments

_pathname_&nbsp;...
The pathname for the file(s) to be relabeled.

<a name="notes"></a>

# Notes


* 1.  
**restorecon**  
  does not follow symbolic links and by default it does not
  operate recursively on directories.
* 2.  
  If the
  _pathname_
  specifies the root directory and the
  **-vR**
  or
  **-vr**
  options are set and the audit system is running, then an audit event is
  automatically logged stating that a "mass relabel" took place using the
  message label
  **FS_RELABEL**.
* 3.  
  To improve performance when relabeling file systems recursively (i.e. the
  **-R**
  or
  **-r**
  option is set),
  the
  **-D**
  option to
  **restorecon**
  will cause it to store a SHA1 digest of the default specfiles set in an extended
  attribute named
  _security.restorecon_last_
  on the directory specified in each
  _pathname_&nbsp;...
  once the relabeling has been completed successfully. This digest will be
  checked should
  **restorecon**
  **-D**
  be rerun with the same
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
option is NOT set and recursive mode is set, files will be relabeled as
required with the digest then being updated provided there are no errors.


<a name="author"></a>

# Author

This man page was written by Dan Walsh &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;.
Some of the content of this man page was taken from the setfiles
man page written by Russell Coker &lt;[russell@coker.com](mailto:russell@coker.com).au&gt;.
The program was written by Dan Walsh &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;.


<a name="see-also"></a>

# See Also

**setfiles**(8),
**fixfiles**(8),
**load_policy**(8),
**checkpolicy**(8),
**customizable_types**(5)
