# selinuxexeccon(8) - report SELinux context used for this executable

dwalsh@redhat.com, 14 May 2011


<a name="synopsis"></a>

# Synopsis

```
selinuxexeccon command [fromcon]
```

<a name="description"></a>

# Description

**selinuxexeccon**
reports the SELinux process context for the specified command from the specified context or the current context.

<a name="example"></a>

# Example

    # selinuxexeccon /usr/bin/passwd 
    staff_u:staff_r:passwd_t:s0-s0:c0.c1023
    
    # selinuxexeccon /usr/sbin/sendmail system_u:system_r:httpd_t:s0
    system_u:system_r:system_mail_t:s0

<a name="author"></a>

# Author

This manual page was written by Dan Walsh &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;.

<a name="see-also"></a>

# See Also

**secon**(8)
