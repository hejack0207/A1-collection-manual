# chacl(1) - change the access control list of a file or directory

September 2001, ACL File Utilities

```
chacl acl pathname...
chacl -b acl dacl pathname...
chacl -d dacl pathname...
chacl -R pathname...
chacl -D pathname...
chacl -B pathname...
chacl -l pathname...
chacl -r pathname...

```

<a name="description"></a>

# Description

_chacl_
is an IRIX-compatibility command, and is maintained for those
users who are familiar with its use from either XFS or IRIX.
Refer to the
**SEE ALSO**
section below for a description of tools
which conform more closely to the (withdrawn draft) POSIX 1003.1e
standard which describes Access Control Lists (ACLs).

_chacl_
changes the ACL(s) for a file or directory.
The ACL(s) specified are applied to each file in the **_pathname_** arguments.

Each ACL is a string which is interpreted using the
_acl_from_text_(3)
routine.
These strings are made up of comma separated clauses each of which
is of the form, tag:name:perm.  Where **_tag_** can be:

* "user" (or "u")  
  indicating that the entry is a user ACL entry.
* "group" (or "g")  
  indicating that the entry is a group ACL entry.
* "other" (or "o")  
  indicating that the entry is an other ACL entry.
* "mask" (or "m")  
  indicating that the entry is a mask ACL entry.

**_name_** is a string which is the user or group name for the ACL entry.
A null **_name_** in a user or group ACL entry indicates the file's
owner or file's group.
**_perm_** is the string "rwx" where each of the entries may be replaced
by a "-" indicating no access of that type, e.g. "r-x", "--x", "---".

<a name="options"></a>

# Options


* **-b**  
  Indicates that there are two ACLs to change, the first is the
  file access ACL and the second the directory default ACL.
* **-d**  
  Used to set only the default ACL of a directory.  
* **-R**  
  Removes the file access ACL only.
* **-D**  
  Removes directory default ACL only.
* **-B**  
  Remove all ACLs. 
* **-l**  
  Lists the access ACL and possibly the default ACL associated
  with the specified files or directories.  This option was added
  during the Linux port of XFS, and is not IRIX compatible.
* **-r**  
  Set the access ACL recursively for each subtree rooted at **_pathname_**(s).
  This option was also added during the Linux port of XFS, and is not
  compatible with IRIX.

<a name="examples"></a>

# Examples

A minimum ACL:

      chacl u::rwx,g::r-x,o::r-- file

The file ACL is set so that the file's owner has "rwx", the file's
group has read and execute, and others have read only access to the file.

An ACL that is not a minimum ACL, that is, one that specifies
a user or group other than the file's owner or owner's group,
must contain a mask entry:

      chacl u::rwx,g::r-x,o::r--,u:bob:r--,m::r-x file1 file2

To set the default and access ACLs on **_newdir_** to be the 
same as on **_olddir_**, you could type:

      chacl -b `chacl -l olddir | &nbsp;     sed -e 's/.*\[//' -e 's#/# #' -e 's/]$//'` newdir
    

<a name="cautions"></a>

# Cautions

_chacl_
can replace the existing ACL.  To add or delete entries, you
must first do **_chacl -l_** to get the existing ACL, and use the output
to form the arguments to
_chacl_.

Changing the permission bits of a file will change the file access
ACL settings (see
_chmod_(1)).
However, file creation mode masks (see
_umask_(1))
will not affect the access ACL settings of files created using directory 
default ACLs. 

ACLs are filesystem extended attributes and hence are not typically
archived or restored using the conventional archiving utilities.
See
_attr_(5)
for more information about extended attributes and see
_xfsdump_(8)
for a method of backing them up under XFS.

<a name="see-also"></a>

# See Also

**getfacl**(1), **setfacl**(1), **chmod**(1), **umask**(1), **acl_from_text**(3), **acl**(5), **xfsdump**(8)
