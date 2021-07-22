# postlogin(5) - Common configuration file for PAMified services

Red Hat, 2010 Dec 22

```
/etc/pam.d/postlogin 

```

<a name="description"></a>

# Description


The purpose of this PAM configuration file is to provide a common
place for all PAM modules which should be called after the stack
configured in
**system-auth**
or the other common PAM configuration files.


The
**postlogin**
configuration file is included from all individual service configuration
files that provide login service with shell or file access.


<a name="notes"></a>

# Notes

The modules in the postlogin configuration file are executed regardless
of the success or failure of the modules in the
**system-auth**
configuration file.


<a name="bugs"></a>

# Bugs


Sometimes it would be useful to be able to skip the postlogin modules in
case the substack of the
**system-auth**
modules failed. Unfortunately the current Linux-PAM library does not
provide any way how to achieve this.


<a name="see-also"></a>

# See Also

pam(8), config-util(5), system-auth(5)

The three
**Linux-PAM**
Guides, for
**system administrators**, 
**module developers**, 
and
**application developers**. 
