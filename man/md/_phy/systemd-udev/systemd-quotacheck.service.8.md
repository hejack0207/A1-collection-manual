# systemd\-quotacheck\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-quotacheck.service, systemd-quotacheck - File system quota checker logic

<a name="synopsis"></a>

# Synopsis

```

 systemd-quotacheck.service 
 /usr/lib/systemd/systemd-quotacheck
```

<a name="description"></a>

# Description


systemd-quotacheck.service
is a service responsible for file system quota checks. It is run once at boot after all necessary file systems are mounted. It is pulled in only if at least one file system has quotas enabled.

<a name="kernel-command-line"></a>

# Kernel Command Line


systemd-quotacheck
understands one kernel command line parameter:

_quotacheck.mode=_
One of
"auto",
"force",
"skip". Controls the mode of operation. The default is
"auto", and ensures that file system quota checks are done when the file system quota checker deems them necessary.
"force"
unconditionally results in full file system quota checks.
"skip"
skips any file system quota checks.

<a name="see-also"></a>

# See Also


**systemd**(1),
**quotacheck**(8),
**systemd-fsck@.service**(8)
