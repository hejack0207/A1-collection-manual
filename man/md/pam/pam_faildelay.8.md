# pam_faildelay(8)

Linux-PAM Manual, 06/08/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pam_faildelay - Change the delay on failure per-application

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pam_faildelay.so&nbsp;'u pam_faildelay.so [debug] [delay=microseconds]
```

<a name="description"></a>

# Description


pam_faildelay is a PAM module that can be used to set the delay on failure per-application.

If no
**delay**
is given, pam_faildelay will use the value of FAIL_DELAY from
/etc/login.defs.

<a name="options"></a>

# Options


**debug**
Turns on debugging messages sent to syslog.

**delay=****N**
Set the delay on failure to N microseconds.

<a name="module-types-provided"></a>

# Module Types Provided


Only the
**auth**
module type is provided.

<a name="return-values"></a>

# Return Values


PAM_IGNORE
Delay was successful adjusted.

PAM_SYSTEM_ERR
The specified delay was not valid.

<a name="examples"></a>

# Examples


The following example will set the delay on failure to 10 seconds:

.if n \{.RS 4
.\}
    auth  optional  pam_faildelay.so  delay=10000000
          
.if n \{.RE
.\}


<a name="see-also"></a>

# See Also


**pam\_fail\_delay**(3),
**pam.conf**(5),
**pam.d**(5),
**pam**(8)

<a name="author"></a>

# Author


pam_faildelay was written by Darren Tucker &lt;[dtucker@zip.com](mailto:dtucker@zip.com).au&gt;.
