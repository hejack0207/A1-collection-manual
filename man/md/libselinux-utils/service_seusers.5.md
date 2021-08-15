# service_seusers(5) - The SELinux GNU/Linux user and service to SELinux user mapping configuration files

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

These are optional files that allow services to define an SELinux user when authenticating via SELinux-aware login applications such as
**PAM**(8). 

There is one file for each GNU/Linux user name that will be required to run a service with a specific SELinux user name.

The path for each configuration file is formed by the path returned by
**selinux_policy_root**(3) with  
_/logins/username_
appended (where _username_ is a file representing the GNU/Linux user name). The default services directory is located at:
_/etc/selinux/{SELINUXTYPE}/logins_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

**getseuser**(3) reads this file to map services to an SELinux user. 

<a name="file-format"></a>

# File Format

Each line within the _username_ file is formatted as follows with each component separated by a colon:
_service_**:**_seuser_**[**:range**]**

Where:
_service_
The service name used by the application.
_seuser_
The SELinux user name.
_range_
The range for MCS/MLS policies.

<a name="examples"></a>

# Examples

Example 1 - for the 'root' user:
# ./logins/root  
ipa:user_u:s0  
this_service:unconfined_u:s0

Example 2 - for GNU/Linux user 'rch':
# ./logins/rch  
ipa:unconfined_u:s0  
that_service:unconfined_u:s0

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **PAM**(8), **selinux_policy_root**(3), **getseuser**(3), **selinux_config**(5) 
