# console.perms(5) - permissions control file for users at the system console

Red Hat Software, 2005/5/2


<a name="description"></a>

# Description

/etc/security/console.perms and .perms files in the 
/etc/security/console.perms.d directory determine the permissions that will be
given to priviledged users of the console at login time, and the
permissions to which to revert when the users log out.  They are
read by the pam_console_apply helper executable.

The format is:

\f(CR&lt;**class**\f(CR&gt;=**space-separated list of words**

**login-regexp**_|_\f(CR&lt;**login-class**\f(CR&gt; **perm dev-glob**_|_\f(CR&lt;**dev-class**\f(CR&gt; \e  
\f(CR        **revert-mode revert-owner**_[_.revert-group_]_

The **revert-mode**, **revert-owner**, and revert-group fields are optional,
and default to **0600**, **root**, and **root**, respectively.

The words in a class definition are evaluated as globs if they
refer to files, but as regular expressions if they apply to a
console definition.  Do not mix them.

Any line can be broken and continued on the next line by using a
\e character as the last character on the line.

The **login-class** class and the **login-regexp** word are evaluated as
regular expressions.
The **dev-class** and the **dev-glob** word are evaluated as
shell-style globs.  If a name given corresponds to a directory, and
if it is a mount point listed in _/etc/fstab_, the device node
associated with the filesystem mounted at that point will be
substituted in its place.

Classes are denoted by being contained in \f(CR&lt; angle bracket \f(CR&gt;
characters; a lack of \f(CR&lt; angle brackets \f(CR&gt; indicates that
the string is to be taken literally as a **login-regexp** or a
**dev-glob**, depending on its input position.

<a name="see-also"></a>

# See Also

**pam_console**(8)  
**pam_console_apply**(8)  
**console.apps**(5)

<a name="author"></a>

# Author

Michael K. Johnson &lt;[johnsonm@redhat.com](mailto:johnsonm@redhat.com)&gt;
