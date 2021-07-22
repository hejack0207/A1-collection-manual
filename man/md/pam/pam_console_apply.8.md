# pam_console_apply(8) - set or revoke permissions for users at the system console

Red Hat, 2005/5/2

```
pam_console_apply  [-f <fstab file>] [-c <console.perms file>] [-r] [-t <tty>] [-s] [-d] [<device file> ...]
```

<a name="description"></a>

# Description

**pam\_console\_apply** is a helper executable which sets or resets permissions
on device nodes.  
If _/var/run/console.lock_ exists, **pam\_console\_apply** will grant
permissions to the user listed therein.  If the lock file does not exist,
permissions are reset according to defaults set in _console.perms_ files,
normally configured to set permissions on devices so that **root**
owns them.

When initializing its configuration it first parses
the _/etc/security/console.perms_ file and then it searches for files
ending with the _.perms_ suffix in the _/etc/security/console.perms.d_
directory. These files are parsed in the lexical order in "C" locale.
Permission rules are appended to a global list, console and device class
definitions override previous definitions of the same class.

<a name="arguments"></a>

# Arguments


* -c  
  Load other console.perms file than the default one.
* -f  
  Load other fstab file than the default one (_/etc/fstab_).
* -r  
  Signals **pam\_console\_apply** to reset permissions.  The default is to set
  permissions so that the user listed in _/var/run/console.lock_ has access
  to the devices, and to reset permissions if no such file exists.
* -t  
  Use &lt;tty&gt; to match console class in console.perms file. The default is tty0.
* -s  
  Write error messages to the system log instead of stderr.
* -d  
  Log/display messages useful for debugging.

The optional &lt;device file&gt; arguments constrain what files should be affected
by **pam\_console\_apply**. If they aren't specified permissions are
changed on all files specified in the _console.perms_ file.

<a name="files"></a>

# Files

_/var/run/console.lock_  
_/etc/security/console.perms_  
_/etc/security/console.perms.d/50-default.perms_

<a name="see-also"></a>

# See Also

**pam_console(8)**  
**console.perms(5)**  

<a name="bugs"></a>

# Bugs

Let's hope not, but if you find any, please report them via the "Bug Track"
link at http://bugzilla.redhat.com/bugzilla/

<a name="authors"></a>

# Authors

Nalin Dahyabhai &lt;[nalin@redhat.com](mailto:nalin@redhat.com)&gt;, using code shamelessly stolen from parts of
pam_console.  
Support of console.perms.d and other improvements by
Tomas Mraz &lt;[tmraz@redhat.com](mailto:tmraz@redhat.com)&gt;.
