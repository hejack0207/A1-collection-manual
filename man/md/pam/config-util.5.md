# system-auth(5) - Common PAM configuration file for configuration utilities

Red Hat, 2006 Feb 3

```
/etc/pam.d/config-util 

```

<a name="description"></a>

# Description


The purpose of this configuration file is to provide common 
configuration file for all configuration utilities which must be run
from the supervisor account and use the userhelper wrapper application.


The
**config-util**
configuration file is included from all individual configuration
files of such utilities with the help of the
**include**
directive.
There are not usually any other modules in the individual configuration
files of these utilities.


It is possible for example to modify duration of the validity of the 
authentication timestamp there. See
**pam_timestamp(8)**
for details.


<a name="bugs"></a>

# Bugs


None known.


<a name="see-also"></a>

# See Also

pam(8), config-util(5), pam_timestamp(8)
