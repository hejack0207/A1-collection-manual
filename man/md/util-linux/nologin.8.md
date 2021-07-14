# nologin(8) - politely refuse a login

util-linux, September 2013

```
nologin [-V] [-h]
```

<a name="description"></a>

# Description

**nologin**
displays a message that an account is not available and exits non-zero.  It is
intended as a replacement shell field to deny login access to an account.

If the file /etc/nologin.txt exists, nologin displays its contents to the
user instead of the default message.

The exit code returned by
**nologin**
is always 1.


<a name="options"></a>

# Options


* **-h, --help**  
  Display help text and exit.
* -V, --version  
  Display version information and exit.

<a name="notes"></a>

# Notes

**nologin**
is a per-account way to disable login (usually used for system accounts like http or ftp).
**nologin**(8)
uses /etc/nologin.txt as an optional source for a non-default message, the login
access is always refused independently of the file.

**pam_nologin**(8)
PAM module usually prevents all non-root users from logging into the system.
**pam_nologin**(8)
functionality is controlled by /var/run/nologin or the /etc/nologin file.

<a name="authors"></a>

# Authors

.UR [kzak@redhat.com](mailto:kzak@redhat.com)
Karel Zak
.UE

<a name="see-also"></a>

# See Also

**login**(1),
**passwd**(5),
**pam_nologin**(8)

<a name="history"></a>

# History

The
**nologin**
command appeared in 4.4BSD.

<a name="availability"></a>

# Availability

The nologin command is part of the util-linux package and is available from
[Linux Kernel Archive](https://​www.kernel.org​/pub​/linux​/utils​/util-linux/).
