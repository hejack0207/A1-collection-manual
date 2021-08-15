# default_contexts(5) - The SELinux default contexts configuration file

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

The default contexts configuration file _default\_contexts_ contains entries that allow SELinux-aware login applications such as
**PAM**(8) 

SELinux-aware login applications generally use one or more of the following libselinux functions that read these files from the active policy path:
**get_default_context**(3)   
**get_ordered_context_list**(3)   
**get_ordered_context_list_with_level**(3)   
**get_default_context_with_level**(3)   
**get_default_context_with_role**(3)   
**get_default_context_with_rolelevel**(3)   
**query_user_context**(3)   
**manual_user_enter_context**(3) 

The default context configuration file path for the active policy is returned by **selinux\_default\_contexts\_path**(3). The default, default contexts file is:
_/etc/selinux/{SELINUXTYPE}/contexts/default_contexts_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

<a name="file-format"></a>

# File Format

Each line in the default configuration file consists of the following:
_login_process user_login_process [user_login_process] ..._

Where:
_login_process_
This consists of a role**:type**[**:range**] entry that represents the login process context that are defined in the policy.
_user_login_process_
This consists of one or more role**:type**[**:range**] entries that represent the user login process context defined in the policy.

<a name="example"></a>

# Example

# ./contexts/default_contexts  
system_r:crond_t:s0			 system_r:system_crond_t:s0  
system_r:local_login_t:s0	 user_r:user_t:s0 staff_r:staff_t:s0  
system_r:remote_login_t:s0	 user_r:user_t:s0  
system_r:sshd_t:s0			 user_r:user_t:s0  
system_r:sulogin_t:s0		 sysadm_r:sysadm_t:s0  
system_r:xdm_t:s0			 user_r:user_t:s0

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **selinux_default_contexts_path**(3), **PAM**(8), **selinux_default_type_path**(3), **get_default_context**(3), **get_ordered_context_list**(3), **get_ordered_context_list_with_level**(3), **get_default_context_with_level**(3), **get_default_context_with_role**(3), **get_default_context_with_rolelevel**(3), **query_user_context**(3), **manual_user_enter_context**(3), **selinux_config**(5) 
