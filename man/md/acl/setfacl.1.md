# setfacl(1) - set file access control lists

May 2000, ACL File Utilities

```
setfacl [-bkndRLPvh] [{-m|-x} acl_spec] [{-M|-X} acl_file] file ...
</synopsis>

<synopsis>
setfacl --restore=file
```


<a name="description"></a>

# Description

This utility sets Access Control Lists (ACLs) of files and directories.
On the command line, a sequence of commands is followed by a sequence of
files (which in turn can be followed by another sequence of commands, ...).

The
_-m_
and
_-x_
options expect an ACL on the command line. Multiple ACL entries are separated
by comma characters (\`,'). The
_-M_
and
_-X_
options read an ACL from a file or from standard input. The ACL entry format is
described in Section ACL ENTRIES.

The
_--set_ and _--set-file_
options set the ACL of a file or a directory. The previous ACL is
replaced.
ACL entries for this operation must include permissions.

The
_-m (--modify)_ and _-M (--modify-file)_
options modify the ACL of a file or directory.
ACL entries for this operation must include permissions.

The
_-x (--remove)_ and _-X (--remove-file)_
options remove ACL entries. It is not an error to remove an entry which
does not exist.  Only ACL entries without the
_perms_
field are accepted as parameters, unless POSIXLY_CORRECT is defined.

When reading from files using the 
_-M_
and
_-X_
options, setfacl accepts the output getfacl produces.
There is at most one ACL entry per line. After a Pound sign (\`#'),
everything up to the end of the line is treated as a comment.

If setfacl is used on a file system which does not support ACLs, setfacl
operates on the file mode permission bits. If the ACL does not fit completely
in the permission bits, setfacl modifies the file mode permission bits to reflect the ACL as closely as possible, writes an error message to standard error, and returns with an exit status greater than 0.


<a name="permissions"></a>

### PERMISSIONS

The file owner and processes capable of CAP_FOWNER are granted the right
to modify ACLs of a file. This is analogous to the permissions required
for accessing the file mode. (On current Linux systems, root is the only
user with the CAP_FOWNER capability.)


<a name="options"></a>

# Options


* _-b, --remove-all_  
  Remove all extended ACL entries. The base ACL entries of the owner, group and others are retained.
* _-k, --remove-default_  
  Remove the Default ACL. If no Default ACL exists, no warnings are issued.
* _-n, --no-mask_  
  Do not recalculate the effective rights mask. The default behavior of
  setfacl is to recalculate the ACL mask entry, unless a mask entry was explicitly given.
  The mask entry is set to the union of all permissions of the owning group, and all named user and group entries. (These are exactly the entries affected by the mask entry).
* _--mask_  
  Do recalculate the effective rights mask, even if an ACL mask entry was explicitly given. (See the
  _-n _option.)
* _-d, --default_  
  All operations apply to the Default ACL. Regular ACL entries in the
  input set are promoted to Default ACL entries. Default ACL entries in
  the input set are discarded. (A warning is issued if that happens).
* _--restore=file_  
  Restore a permission backup created by \`getfacl -R' or similar. All permissions
  of a complete directory subtree are restored using this mechanism. If the input
  contains owner comments or group comments, setfacl attempts to restore the
  owner and owning group. If the input contains flags comments (which define the setuid,
  setgid, and sticky bits), setfacl sets those three bits accordingly; otherwise,
  it clears them. This option cannot be mixed with other options except \`--test'.
* _--test_  
  Test mode. Instead of changing the ACLs of any files, the resulting ACLs are listed.
* _-R, --recursive_  
  Apply operations to all files and directories recursively. This option cannot be mixed with \`--restore'.
* _-L, --logical_  
  Logical walk, follow symbolic links to directories. The default behavior is to follow
  symbolic link arguments, and skip symbolic links encountered in subdirectories.
  Only effective in combination with -R.
  This option cannot be mixed with \`--restore'.
* _-P, --physical_  
  Physical walk, do not follow symbolic links to directories.
  This also skips symbolic link arguments.
  Only effective in combination with -R.
  This option cannot be mixed with \`--restore'.
* _-v, --version_  
  Print the version of setfacl and exit.
* _-h, --help_  
  Print help explaining the command line options.
* _--_  
  End of command line options. All remaining parameters are interpreted as file names, even if they start with a dash.
* _-_  
  If the file name parameter is a single dash, setfacl reads a list of files from standard input.
  

<a name="acl-entries"></a>

### ACL ENTRIES

The setfacl utility recognizes the following ACL entry formats (blanks
inserted for clarity):

.fam C

* [d[efault]:] [u[ser]:]_uid _[:_perms_]  
  .fam T
  Permissions of a named user. Permissions of the file owner if
  _uid_
  is empty.
  .fam C
* [d[efault]:] g[roup]:_gid _[:_perms_]  
  .fam T
  Permissions of a named group. Permissions of the owning group if
  _gid_
  is empty.
  .fam C
* [d[efault]:] m[ask][:] [:_perms_]  
  .fam T
  Effective rights mask
  .fam C
* [d[efault]:] o[ther][:] [:_perms_]  
  .fam T
  Permissions of others.

Whitespace between delimiter characters and non-delimiter characters is ignored.


Proper ACL entries including permissions are used in modify and set operations. (options
_-m_, _-M_, _--set_ and _--set-file_).
Entries without the
_perms_
field are used for
_deletion_
of entries (options
_-x_ and _-X_).

For
_uid_
and
_gid_
you can specify either a name or a number.  Character literals may be specified
with a backslash followed by the 3-digit octal digits corresponding to the
ASCII code for the character (e.g.,
_\e101_
for 'A').  If the name contains a literal backslash followed by 3 digits, the
backslash must be escaped (i.e.,
_\e\e_).

The
_perms_
field is a combination of characters that indicate the read
_(r)_,
write
_(w)_,
execute
_(x)_
permissions.  Dash characters in the
_perms_
field
_(-)_
are ignored.  The character
_X_
stands for the execute permission if the file is a directory or already has
execute permission for some user.  Alternatively, the
_perms_
field can define the permissions numerically, as a bit-wise combination of read
_(4)_,
write
_(2)_,
and execute
_(1)_.
Zero
_perms_
fields or
_perms_
fields that only consist of dashes indicate no permissions.


<a name="automatically-created-entries"></a>

### AUTOMATICALLY CREATED ENTRIES

Initially, files and directories contain only the three base ACL entries
for the owner, the group, and others. There are some rules that
need to be satisfied in order for an ACL to be valid:

* *  
  The three base entries cannot be removed. There must be exactly one
  entry of each of these base entry types.
* *  
  Whenever an ACL contains named user entries or named group objects,
  it must also contain an effective rights mask.
* *  
  Whenever an ACL contains any Default ACL entries, the three Default ACL
  base entries (default owner, default group, and default others) must also exist.
* *  
  Whenever a Default ACL contains named user entries or named group objects,
  it must also contain a default effective rights mask.

To help the user ensure these rules, setfacl creates entries from existing
entries under the following conditions:

* *  
  If an ACL contains named user or named group entries, and
  no mask entry exists, a mask entry containing the same permissions as
  the group entry is created. Unless the
  _-n_
  option is given, the permissions of the mask entry are further adjusted to include the union of all permissions affected by the mask entry. (See the
  _-n_
  option description).
* *  
  If a Default ACL entry is created, and the Default ACL contains no
  owner, owning group, or others entry, a copy of the ACL owner, owning group, or others entry is added to the Default ACL.
* *  
  If a Default ACL contains named user entries or named group entries, and no mask entry exists, a mask entry containing the same permissions as the default Default ACL's group entry is added. Unless the
  _-n_
  option is given, the permissions of the mask entry are further adjusted to
  include the union of all permissions affected by the mask entry. (See the
  _-n_
  option description).


<a name="examples"></a>

# Examples


Granting an additional user read access
.fam C
setfacl -m u:lisa:r file
.fam T

Revoking write access from all groups and all named users (using the effective rights mask)
.fam C
setfacl -m m::rx file
.fam T

Removing a named group entry from a file's ACL
.fam C
setfacl -x g:staff file
.fam T

Copying the ACL of one file to another
.fam C
getfacl file1 | setfacl --set-file=- file2
.fam T

Copying the access ACL into the Default ACL
.fam C
getfacl --access dir | setfacl -d -M- dir
.fam T

<a name="conformance-to-posix-10031e-draft-standard-17"></a>

# Conformance to Posix 1003.1E Draft Standard 17

If the environment variable POSIXLY_CORRECT is defined, the default behavior of setfacl changes as follows: All non-standard options are disabled.
The \`\`default:'' prefix is disabled.
The
_-x_ and _-X_
options also accept permission fields (and ignore them). 

<a name="author"></a>

# Author

Andreas Gruenbacher,
&lt;[_a.gruenbacher@bestbits.at_](mailto:_a.gruenbacher@bestbits.at_)&gt;.

Please send your bug reports, suggested features and comments to the
above address.

<a name="see-also"></a>

# See Also

**getfacl**(1), **chmod**(1), **umask**(1), **acl**(5)
