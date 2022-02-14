# booleans(5) - The SELinux booleans configuration files

Security Enhanced Linux, 28-Nov-2011


<a name="description"></a>

# Description

The _booleans_ file, if present contains booleans to support a specific distribution.

The _booleans.local_ file, if present contains locally generated booleans.

Both files contain a list of boolean names and their associated values.

Generally the _booleans_ and/or _booleans.local_ files are not present (they have been deprecated). However if there is an SELinux-aware application that uses the libselinux functions listed below, then these files may be present:

**security_set_boolean_list**(3) 
Writes a _booleans.local_ file if flag _permanent_ = _1_.

**security_load_booleans**(3) 
Looks for a _booleans_ and/or _booleans.local_ file at **selinux\_booleans\_path**(3) unless a specific path is specified as a parameter.

**booleans**(8) has details on booleans and **setsebool**(8) describes how booleans can now be set persistent across reboots.

**selinux\_booleans\_path**(3) will return the active policy path to these files. The default boolean files are:
_/etc/selinux/{SELINUXTYPE}/booleans_  
_/etc/selinux/{SELINUXTYPE}/booleans.local_

Where _{SELINUXTYPE}_ is the entry from the selinux configuration file _config_ (see **selinux\_config**(5)).

<a name="file-format"></a>

# File Format

Both boolean files have the same format and contain one or more boolean names and their value.

The format is:
_boolean_name_
_value_

Where:
_boolean_name_
The name of the boolean.
_value_
The default setting for the boolean. This can be one of the following:
_true_ | _false_ | _1_ | _0_

Note that if
**SETLOCALDEFS**
is set in the SELinux
_config_
file (see
**selinux_config**(5)), then **selinux_mkload_policy**(3) will check for a 
_booleans.local_
file in the
**selinux_booleans_path**(3)
and also a
_local.users_
file (see
**local.users**(5)) in the **selinux_users_path**(3). 

<a name="see-also"></a>

# See Also

.nh
**selinux**(8), **booleans**(8), **setsebool**(8), **semanage**(8), **selinux_booleans_path**(3), **security_set_boolean_list**(3), **security_load_booleans**(3), **selinux_mkload_policy**(3), **selinux_users_path**(3), **selinux_config**(5), **local.users**(5) 
