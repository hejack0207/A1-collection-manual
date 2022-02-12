# load_policy(8) - load a new SELinux policy into the kernel

Security Enhanced Linux, May 2003

```
load_policy  [-qi]

```

<a name="description"></a>

# Description


load_policy loads the installed policy file into the kernel.
The existing policy boolean values are automatically preserved
across policy reloads rather than being reset to the default
values in the policy file.


<a name="options"></a>

# Options


* **-q**  
  suppress warning messages.
* **-i**  
  initial policy load. Only use this if this is the first time policy is being loaded since boot (usually called from initramfs).
  

<a name="exit-status"></a>

# Exit Status


* **0**
  Success
* **1**
  Invalid option
* **2**
  Policy load failed
* **3**
  Initial policy load failed and enforcing mode requested

<a name="see-also"></a>

# See Also

**booleans**(8)

<a name="authors"></a>

# Authors

    This manual page was written by Dan Walsh <dwalsh@redhat.com>.
    The program was written by Stephen Smalley <sds@tycho.nsa.gov>.
