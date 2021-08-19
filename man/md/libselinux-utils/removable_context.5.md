# removable_context(5) - The SELinux removable devices context configuration file

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

This file contains the default label that should be used for removable devices.

**selinux_removable_context_path**(3) 
will return the active policy path to this file. The default removable context file is:
_/etc/selinux/{SELINUXTYPE}/contexts/removable_context_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

<a name="file-format"></a>

# File Format

The file consists of a single line entry as follows:
_user_**:**_role_**:**_type_**[**:range**]**

Where:
_user role type range_
A user, role, type and optional range (for MCS/MLS) separated by colons (:) that will be applied to removable devices.

<a name="example"></a>

# Example

# ./contexts/removable_contexts  
system_u:object_r:removable_t:s0

<a name="see-also"></a>

# See Also

**selinux**(8), **selinux_removable_context_path**(3), **selinux_config**(5) 
