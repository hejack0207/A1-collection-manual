# fixfiles(8) - fix file SELinux security contexts.

"", 2002031409

```
.na
</synopsis>

<synopsis>
fixfiles [-v] [-F] [-f] relabel
</synopsis>

<synopsis>
fixfiles [-v] [-F] { check | restore | verify } dir/file ...
</synopsis>

<synopsis>
fixfiles [-v] [-F] [-B | -N time ] { check | restore | verify }
</synopsis>

<synopsis>
fixfiles  [-v] [-F] -R rpmpackagename[,rpmpackagename...] { check | restore | verify }
</synopsis>

<synopsis>
fixfiles [-v] [-F] -C PREVIOUS_FILECONTEXT  { check | restore | verify }
</synopsis>

<synopsis>
fixfiles [-F] [-B] onboot
```



<a name="description"></a>

# Description

This manual page describes the
**fixfiles**
script.

This script is primarily used to correct the security context
database (extended attributes) on filesystems.  

It can also be run at any time to relabel when adding support for
new policy, or  just check whether the file contexts are all
as you expect.  By default it will relabel all mounted ext2, ext3, xfs and 
jfs file systems as long as they do not have a security context mount 
option.  You can use the -R flag to use rpmpackages as an alternative.
The file /etc/selinux/fixfiles_exclude_dirs can contain a list of directories
excluded from relabeling.

**fixfiles onboot**
will setup the machine to relabel on the next reboot.


<a name="options"></a>

# Options


* **-B**  
  If specified with onboot, this fixfiles will record the current date in the /.autorelabel file, so that it can be used later to speed up labeling. If used with restore, the restore will only affect files that were modified today.
* **-F**  
  Force reset of context to match file_context for customizable files
  
* **-f**  
  Clear /tmp directory with out prompt for removal.
  
* **-R rpmpackagename[,rpmpackagename...]**  
  Use the rpm database to discover all files within the specified packages and restore the file contexts.
* **-C PREVIOUS_FILECONTEXT**  
  Run a diff on  the PREVIOUS_FILECONTEXT file to the currently installed one, and restore the context of all affected files.
  
* **-N time**  
  Only act on files created after the specified date.  Date must be specified in
  "YYYY-MM-DD HH:MM" format.  Date field will be passed to find --newermt command.
  
* **-v**  
  Modify verbosity from progress to verbose. (Run restorecon with -v instead of -p)
  

<a name="arguments"></a>

# Arguments

One of:

* **check**  
  print any incorrect file context labels, showing old and new context, but do not change them.
* **restore**  
  change any incorrect file context labels.
* **relabel**  
  Prompt for removal of contents of /tmp directory and then change any incorrect file context labels to match the install file_contexts file.
* **verify**  
  List out files with incorrect file context labels, but do not change them.
* **[[dir/file] ... ]**  
  List of files or directories trees that you wish to check file context on.
  

<a name="author"></a>

# Author

This man page was written by Richard Hally &lt;[rhally@mindspring.com](mailto:rhally@mindspring.com)&gt;.
The script  was written by Dan Walsh &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;


<a name="see-also"></a>

# See Also

**setfiles**(8),
**restorecon**(8)

