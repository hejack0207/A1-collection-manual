# system-auth(5) - Common configuration file for PAMified services

Red Hat, 2010 Dec 22

```
/etc/pam.d/system-auth /etc/pam.d/password-auth /etc/pam.d/fingerprint-auth /etc/pam.d/smartcard-auth 

```

<a name="description"></a>

# Description


The purpose of these configuration files are to provide a common
interface for all applications and service daemons calling into
the PAM library.


The
**system-auth**
configuration file is included from nearly all individual service configuration
files with the help of the
**substack**
directive.


The
**password-auth**
**fingerprint-auth**
**smartcard-auth**
configuration files are for applications which handle authentication from
different types of devices via simultaneously running individual conversations
instead of one aggregate conversation.


<a name="notes"></a>

# Notes

Previously these common configuration files were included with the help
of the
**include**
directive. This limited the use of the different action types of modules.
With the use of
**substack**
directive to include these common configuration files this limitation
no longer applies.


<a name="bugs"></a>

# Bugs


None known.


<a name="see-also"></a>

# See Also

pam(8), config-util(5), postlogin(5)

The three
**Linux-PAM**
Guides, for
**system administrators**, 
**module developers**, 
and
**application developers**. 
