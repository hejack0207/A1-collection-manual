# seusers(5) - The SELinux GNU/Linux user to SELinux user mapping configuration file

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

The
_seusers_
file contains a list GNU/Linux user to SELinux user mapping for use by SELinux-aware login applications such as **PAM**(8).

**selinux_usersconf_path**(3) 
will return the active policy path to this file. The default SELinux users mapping file is located at:
_/etc/selinux/{SELINUXTYPE}/seusers_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

**getseuserbyname**(3) reads this file to map a GNU/Linux user or group to an SELinux user. 

<a name="file-format"></a>

# File Format

Each line of the
_seusers_
configuration file consists of the following:

[**%_group\_id**]|[user\_id_]**:seuser\_id**[**:range**]

Where:
_group\_id_|user_id
The  GNU/Linux user id, or if preceded by the percentage (**%**) symbol, then a GNU/Linux group id.  
An optional entry set to **\_\_default\_\_** can be provided as a fall back if required.
_seuser_id_
The SELinux  user identity.
_range_
The optional level or range for an MLS/MCS policy.

<a name="example"></a>

# Example

# ./seusers  
system_u:system_u:s0-s15:c0.c255  
root:root:s0-s15:c0.c255  
fred:user_u:s0  
__default__:user_u:s0  
%user_group:user_u:s0

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **PAM**(8), **selinux_usersconf_path**(3), **getseuserbyname**(3), **selinux_config**(5) 
