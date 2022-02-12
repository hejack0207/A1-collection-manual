# local.users(5) - The SELinux local users configuration file

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

The file contains local user definitions in the form of policy language user statements and is only found on older SELinux systems as it has been deprecated and replaced by the **semange**(8) services.

This file is only read by **selinux\_mkload\_policy**(3) when **SETLOCALDEFS** in the SELinux _config_ file (see **selinux\_config**(5)) is set to _1_.

**selinux_users_path**(3) 
will return the active policy path to the directory where this file is located. The default local users file is:
_/etc/selinux/{SELINUXTYPE}/contexts/users/local.users_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

<a name="file-format"></a>

# File Format

The file consists of one or more entries terminated with '**;**', each on a separate line as follows:
**user seuser_id roles role\_id** [[**level level**] [**range range**]]**;**

Where:
**user**
The user keyword.
_seuser_id_
The SELinux user identifier.
**roles**
The roles keyword.
_role_id_
One or more previously declared role identifiers. Multiple role identifiers consist of a space separated list enclosed in braces '{}'.
**level**
If MLS/MCS is configured, the level keyword.
_level_
The users default security level. Note that only the sensitivity component of the level (e.g. s0) is required.
**range**
If MLS/MCS is configured, the range keyword.
_range_
The current and clearance levels that the user can run. These are separated by a hyphen '**-**' as shown in the **EXAMPLE** section.

<a name="example"></a>

# Example

# ./users/local.users  
user test_u roles staff_r level s0 range s0 - s15:c0.c1023;

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **semanage**(8), **selinux_users_path**(3), **selinux_config**(5), **selinux_mkload_policy**(3) 
