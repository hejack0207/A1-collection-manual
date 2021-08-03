# vipw(8)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

vipw, vigr - edit the password, group, shadow-password or shadow-group file

<a name="synopsis"></a>

# Synopsis

```
.HP \w'vipw&nbsp;'u vipw [options] .HP \w'vigr&nbsp;'u vigr [options]
```

<a name="description"></a>

# Description


The
**vipw**
and
**vigr**
commands edits the files
/etc/passwd
and
/etc/group, respectively. With the
**-s**
flag, they will edit the shadow versions of those files,
/etc/shadow
and
/etc/gshadow, respectively. The programs will set the appropriate locks to prevent file corruption. When looking for an editor, the programs will first try the environment variable
**$VISUAL**, then the environment variable
**$EDITOR**, and finally the default editor,
**vi**(1).

<a name="options"></a>

# Options


The options which apply to the
**vipw**
and
**vigr**
commands are:

**-g**, **--group**
Edit group database.

**-h**, **--help**
Display help message and exit.

**-p**, **--passwd**
Edit passwd database.

**-q**, **--quiet**
Quiet mode.

**-R**, **--root**&nbsp;_CHROOT\_DIR_
Apply changes in the
_CHROOT\_DIR_
directory and use the configuration files from the
_CHROOT\_DIR_
directory.

**-s**, **--shadow**
Edit shadow or gshadow database.

<a name="environment"></a>

# Environment


**VISUAL**
Editor to be used.

**EDITOR**
Editor to be used if
**VISUAL**
is not set.

<a name="files"></a>

# Files


/etc/group
Group account information.

/etc/gshadow
Secure group account information.

/etc/passwd
User account information.

/etc/shadow
Secure user account information.

<a name="see-also"></a>

# See Also


**vi**(1),
**group**(5),
**gshadow**(5)
,
**passwd**(5), ,
**shadow**(5).
