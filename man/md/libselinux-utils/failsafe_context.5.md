# failsafe_context(5) - The SELinux fail safe context configuration file

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

The
_failsafe_context_
file allows SELinux-aware applications such as
**PAM**(8) 
to obtain a known valid login context for an administrator if no valid default entries can be found elsewhere.

**selinux_failsafe_context_path**(3) 
will return the active policy path to this file. The default failsafe context file is:
_/etc/selinux/{SELINUXTYPE}/contexts/failsafe_context_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

The following functions read this file from the active policy path if they cannot obtain a default context:  
**get_default_context**(3)   
**get_ordered_context_list**(3)   
**get_ordered_context_list_with_level**(3)   
**get_default_context_with_level**(3)   
**get_default_context_with_role**(3)   
**get_default_context_with_rolelevel**(3)   
**query_user_context**(3)   
**manual_user_enter_context**(3) 

<a name="file-format"></a>

# File Format

The file consists of a single line entry as follows:
role**:type**[**:range**]

Where:
_role_
_type_
_range_
A role, type and optional range (for MCS/MLS), separated by colons (:) to form a valid login process context for an administrator to access the system.

<a name="example"></a>

# Example

# ./contexts/failsafe_context  
unconfined_r:unconfined_t:s0

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **selinux_failsafe_context_path**(3), **PAM**(8), **selinux_default_type_path**(3), **get_default_context**(3), **get_ordered_context_list**(3), **get_ordered_context_list_with_level**(3), **get_default_context_with_level**(3), **get_default_context_with_role**(3), **get_default_context_with_rolelevel**(3), **query_user_context**(3), **manual_user_enter_context**(3), **selinux_config**(5) 
