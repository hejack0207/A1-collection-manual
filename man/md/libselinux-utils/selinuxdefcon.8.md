# selinuxdefcon(1) - report default SELinux context for user 

dwalsh@redhat.com, 7 May 2008

```
selinuxdefcon [-l level] user fromcon
```


<a name="description"></a>

# Description

**selinuxdefcon**
reports the default context for the specified user from the specified context

**-l level**
mcs/mls level


<a name="example"></a>

# Example

# selinuxdefcon jsmith system_u:system_r:sshd_t:s0  
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023


<a name="author"></a>

# Author	

This manual page was written by Dan Walsh &lt;dwalsh@redhat.com&gt;.


<a name="see-also"></a>

# See Also

secon(8), selinuxconlist(8)
