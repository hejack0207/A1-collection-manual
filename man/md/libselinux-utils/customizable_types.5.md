# customizable_types(5) - The SELinux customizable types configuration file

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

The _customizable\_types_ file contains a list of types that can be customised in some way by SELinux-aware applications.

Generally this is a file context type that is usually set on files that need to be shared among certain domains and where the administrator wants to manually manage the type.

The  use  of customizable types is deprecated as the preferred approach is to use
**semanage**(8)
**fcontext**(8)
**...**(8).
However, SELinux-aware applications such as
**setfiles**(8)
will use this information to obtain a list of types relating to files that should not be relabeled.

**selinux_customizable_types_path**(3)
will return the active policy path to this file. The default customizable types file is:
_/etc/selinux/{SELINUXTYPE}/contexts/customizable_types_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

**is_context_customizable**(3)
reads this file to determine if a context is customisable or not for the active policy.

<a name="file-format"></a>

# File Format

Each line in the file consists of the following:
_type_

Where:
_type_
The type defined in the policy that can be customised.

<a name="example"></a>

# Example

# ./contexts/customizable_types  
mount_loopback_t  
public_content_rw_t  
public_content_t  
swapfile_t  
sysadm_untrusted_content_t

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **selinux_customizable_types_path**(3), **is_context_customizable**(3), **semanage**(8), **setfiles**(8), **selinux_config**(5) 
