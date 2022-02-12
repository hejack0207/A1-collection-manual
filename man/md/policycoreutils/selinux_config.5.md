# selinux_config(5) - The SELinux sub-system configuration file.

Security Enhanced Linux, 18 Nov 2011


<a name="description"></a>

# Description

The SELinux _config_ file controls the state of SELinux regarding:

* 1.  
  The policy enforcement status - _enforcing_, _permissive_ or _disabled_.
* 2.  
  The policy name or type that forms a path to the policy to be loaded and its supporting configuration files.
* 3.  
  How local users and booleans will be managed when the policy is loaded (note that this function was used by older releases of SELinux and is now deprecated).
* 4.  
  How SELinux-aware login applications should behave if no valid SELinux users are configured.
* 5.  
  Whether the system is to be relabeled or not.

The entries controlling these functions are described in the **FILE FORMAT** section.

The fully qualified path name of the SELinux configuration file is _/etc/selinux/config_.

If the _config_ file is missing or corrupt, then no SELinux policy is loaded (i.e. SELinux is disabled).

The **sestatus** (8) command and the libselinux function **selinux\_path** (3) will return the location of the _config_ file.


<a name="file-format"></a>

# File Format

The _config_ file supports the following parameters:

**SELINUX = _enforcing** | permissive_ | _disabled_  
**SELINUXTYPE = policy\_name**  
**SETLOCALDEFS = _0** | 1_  
**REQUIREUSERS = _0** | 1_  
**AUTORELABEL = _0** | 1_

Where:  
**SELINUX**
This entry can contain one of three values:

* _enforcing_  
  SELinux security policy is enforced.
* _permissive_  
  SELinux security policy is not enforced but logs the warnings (i.e. the action is allowed to proceed).
* _disabled_  
  SELinux is disabled and no policy is loaded.

The entry can be determined using the **sestatus**(8) command or **selinux\_getenforcemode**(3).

**SELINUXTYPE**
The _policy\_name_ entry is used to identify the policy type, and becomes the directory name of where the policy and its configuration files are located.

The entry can be determined using the **sestatus**(8) command or **selinux\_getpolicytype**(3).

The _policy\_name_ is relative to a path that is defined within the SELinux subsystem that can be retrieved by using **selinux\_path**(3). An example entry retrieved by **selinux\_path**(3) is:  
_/etc/selinux/_

The _policy\_name_ is then appended to this and becomes the 'policy root' location that can be retrieved by **selinux\_policy\_root\_path**(3). An example entry retrieved is:
_/etc/selinux/targeted_

The actual binary policy is located relative to this directory and also has a policy name pre-allocated. This information can be retrieved using **selinux\_binary\_policy\_path**(3). An example entry retrieved by **selinux\_binary\_policy\_path**(3) is:  
_/etc/selinux/targeted/policy/policy_

The binary policy name has by convention the SELinux policy version that it supports appended to it. The maximum policy version supported by the kernel can be determined using the **sestatus**(8) command or **security\_policyvers**(3). An example binary policy file with the version is:  
_/etc/selinux/targeted/policy/policy.24_

**SETLOCALDEFS**
This entry is deprecated and should be removed or set to _0_.

If set to _1_, then **selinux\_mkload\_policy**(3) will read the local customization for booleans (see **booleans**(5)) and users (see **local.users**(5)).

**REQUIRESEUSERS**
This optional entry can be used to fail a login if there is no matching or default entry in the
**seusers**(5) file or if the **seusers** file is missing. 

It is checked by **getseuserbyname**(3) that is called by SELinux-aware login applications such as **PAM**(8).

If set to _0_ or the entry missing:
**getseuserbyname**(3) will return the GNU / Linux user name as the SELinux user.

If set to _1_:
**getseuserbyname**(3) will fail.

The **getseuserbyname**(3) man page should be consulted for its use. The format of the _seusers_ file is shown in **seusers**(5).


**AUTORELABEL**
This is an optional entry that allows the file system to be relabeled.

If set to _0_ and there is a file called _.autorelabel_ in the root directory, then on a reboot, the loader will drop to a shell where a root login is required. An administrator can then manually relabel the file system.

If set to _1_ or no entry present (the default) and there is a _.autorelabel_ file in the root directory, then the file system will be automatically relabeled using **fixfiles -F restore**

In both cases the _/.autorelabel_ file will be removed so that relabeling is not done again.



<a name="example"></a>

# Example

This example _config_ file shows the minimum contents for a system to run SELinux in enforcing mode, with a _policy\_name_ of 'targeted':

SELINUX = enforcing  
SELINUXTYPE = targeted


<a name="see-also"></a>

# See Also

**selinux**(8), **sestatus**(8), **selinux_path**(3), **selinux_policy_root_path**(3), **selinux_binary_policy_path**(3), **getseuserbyname**(3), **PAM**(8), **fixfiles**(8), **selinux_mkload_policy**(3), **selinux_getpolicytype**(3), **security_policyvers**(3), **selinux_getenforcemode**(3), **seusers**(5), **booleans**(5), **local.users**(5) 
