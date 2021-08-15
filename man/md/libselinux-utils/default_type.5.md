# default_type(5) - The SELinux default type configuration file

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

The _default\_type_ file contains entries that allow SELinux-aware applications such as **newrole**(1) to select a default type for a role if one is not supplied.

**selinux\_default\_type\_path**(3) will return the active policy path to this file. The default, default type file is:
_/etc/selinux/{SELINUXTYPE}/contexts/default_type_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

**get\_default\_type**(3) reads this file to determine a type for the active policy.

<a name="file-format"></a>

# File Format

Each line within the _default\_type_ file is formatted with role**:type** entries where:
_role_
The SELinux role.
_type_
The domain type that is returned for this role.

<a name="example"></a>

# Example

# ./contexts/default_type  
auditadm_r:auditadm_t  
user_r:user_t

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **get_default_type**(3), **newrole**(1), **selinux_default_type_path**(3), **selinux_config**(5) 
