# console.apps(5) - specify console-accessible privileged applications

Red Hat Software, 1999/2/4


<a name="description"></a>

# Description

The /etc/security/console.apps/ directory should contain one file
per application that wishes to allow access to console users.
The filename should be the same as the servicename, and the
contents are irrelevant; the file may be a zero-length file.
The application that the file is used by is free to specify the
contents in any way that is useful for it.

<a name="see-also"></a>

# See Also

**pam_console**(8)  
**console.perms**(5)

<a name="author"></a>

# Author

Michael K. Johnson &lt;[johnsonm@redhat.com](mailto:johnsonm@redhat.com)&gt;
