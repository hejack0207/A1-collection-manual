# semodule_package(8) - Extract policy module and file context file from an SELinux policy module package.

Security Enhanced Linux, Nov 2005

```
semodule_unpackage ppfile modfile [fcfile]

```

<a name="description"></a>

# Description


semodule_unpackage is a tool used to extract SELinux policy module
file and file context file from an SELinux Policy Package.


<a name="example"></a>

# Example

    # Extract the httpd module file from httpd policy package.
    $ semodule_unpackage httpd.pp httpd.mod httpd.fc


<a name="see-also"></a>

# See Also

**semodule_package(8)**

<a name="authors"></a>

# Authors

    This manual page was written by Dan Walsh <dwalsh@redhat.com>.
    The program was written by Stephen Smalley <sds@tycho.nsa.gov>
