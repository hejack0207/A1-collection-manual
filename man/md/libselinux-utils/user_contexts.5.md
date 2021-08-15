# user_contexts(5) - The SELinux user contexts configuration files

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

These optional user context configuration files contain entries that allow SELinux-aware login applications such as
**PAM**(8)
(running in their own process context), to determine the context that a users login session should run under.

SELinux-aware login applications generally use one or more of the following libselinux functions that read these files from the active policy path:
**get_default_context**(3)  
**get_ordered_context_list**(3)  
**get_ordered_context_list_with_level**(3)  
**get_default_context_with_level**(3)  
**get_default_context_with_role**(3)  
**get_default_context_with_rolelevel**(3)  
**query_user_context**(3)  
**manual_user_enter_context**(3)

There can be one file for each SELinux user configured on the system. The file  path is formed using the path returned by
**selinux_user_contexts_path**(3)
for the active policy, with the SELinux user name appended, for example:
_/etc/selinux/{SELINUXTYPE}/contexts/users/unconfined_u_  
_/etc/selinux/{SELINUXTYPE}/contexts/users/xguest_u_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

These files contain context information as described in the
**FILE FORMAT**
section.

<a name="file-format"></a>

# File Format

Each line in the user context configuration file consists of the following:
_login_process user_login_process_

Where:
_login_process_
This consists of a role**:type**[**:range**] entry that represents the login process context.
_user_login_process_
This consists of a role**:type**[**:range**] entry that represents the user login process context.

<a name="example"></a>

# Example

# Example for xguest_u at /etc/selinux/targeted/contexts/users/xguest_u  
system_r:crond_t:s0			xguest_r:xguest_t:s0  
system_r:initrc_t:s0		xguest_r:xguest_t:s0  
system_r:local_login_t:s0	xguest_r:xguest_t:s0  
system_r:remote_login_t:s0	xguest_r:xguest_t:s0  
system_r:sshd_t:s0			xguest_r:xguest_t:s0  
system_r:xdm_t:s0			xguest_r:xguest_t:s0  
xguest_r:xguest_t:s0		xguest_r:xguest_t:s0

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **selinux_user_contexts_path**(3), **PAM**(8), **get_ordered_context_list**(3), **get_ordered_context_list_with_level**(3), **get_default_context_with_level**(3), **get_default_context_with_role**(3), **get_default_context_with_rolelevel**(3), **query_user_context**(3), **manual_user_enter_context**(3), **selinux_config**(5) 
