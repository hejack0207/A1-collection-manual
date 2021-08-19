# setenforce(8) - modify the mode SELinux is running in

dwalsh@redhat.com, 7 April 2004


<a name="synopsis"></a>

# Synopsis

```
setenforce [Enforcing|Permissive|1|0]
```

<a name="description"></a>

# Description

Use
**Enforcing**
or
**1**
to put SELinux in enforcing mode.  
Use
**Permissive**
or
**0**
to put SELinux in permissive mode.

If SELinux is disabled and you want to enable it, or SELinux is enabled and you want to disable it, please see 
**selinux**(8).

<a name="author"></a>

# Author

Dan Walsh, &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;

<a name="see-also"></a>

# See Also

**selinux**(8),
**getenforce**(8),
**selinuxenabled**(8)
