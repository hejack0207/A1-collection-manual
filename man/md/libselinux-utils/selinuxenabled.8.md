# selinuxenabled(8) - tool to be used within shell scripts to determine if selinux is enabled

dwalsh@redhat.com, 7 April 2004


<a name="synopsis"></a>

# Synopsis

```
selinuxenabled
```

<a name="description"></a>

# Description

Indicates whether SELinux is enabled or disabled.

<a name="exit-status"></a>

# Exit Status

It exits with status 0 if SELinux is enabled and 1 if it is not enabled.

<a name="author"></a>

# Author

Dan Walsh, &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;

<a name="see-also"></a>

# See Also

**selinux**(8),
**setenforce**(8),
**getenforce**(8)
