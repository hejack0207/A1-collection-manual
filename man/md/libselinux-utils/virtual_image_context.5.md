# virtual_image_context(5) - The SELinux virtual machine image context configuration file

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

The
_virtual_image_context_
file contains a list of image contexts for use by the SELinux-aware virtualization API libvirt (see **libvirtd**(8)).

**selinux_virtual_image_context_path**(3) 
will return the active policy path to this file. The default virtual image context file is:
_/etc/selinux/{SELINUXTYPE}/contexts/virtual_image_context_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

<a name="file-format"></a>

# File Format

Each line in the file consists of an entry as follows:
_user_**:**_role_**:**_type_**[**:range**]**

Where:
_user role type range_
A user, role, type and optional range (for MCS/MLS) separated by colons (:) that can be used as a virtual image context.

<a name="example"></a>

# Example

# ./contexts/virtual_image_context  
system_u:object_r:svirt_image_t:s0  
system_u:object_r:svirt_content_t:s0

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **libvirtd**(8), **selinux_virtual_image_context_path**(3), **selinux_config**(5) 
