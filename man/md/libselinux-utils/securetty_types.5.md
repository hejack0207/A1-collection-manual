# securetty_types(5) - The SELinux secure tty type configuration file

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

The
_securetty_types_
file contains a list of types associated to secure tty type that are defined in the policy for use by SELinux-aware applications.

**selinux_securetty_types_path**(3) 
will return the active policy path to this file. The default securetty types file is:
_/etc/selinux/{SELINUXTYPE}/contexts/securetty_types_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

**selinux_check_securetty_context**(3) reads this file to determine if a context is for a secure tty defined in the active policy. 

SELinux-aware applications such as
**newrole**(1) use this information to check the status of a tty. 

<a name="file-format"></a>

# File Format

Each line in the file consists of the following entry:

_type_
One or more type entries that are defined in the policy for secure tty devices.

<a name="example"></a>

# Example

# ./contexts/securetty_types  
sysadm_tty_device_t  
user_tty_device_t  
staff_tty_device_t

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **selinux_securetty_types_path**(3), **newrole**(1), **selinux_check_securetty_context**(3), **selinux_config**(5) 
