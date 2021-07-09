# nfnl_osf(8) - OS fingerprint loader utility

iptables 1.8.0, ""

```
.in +8 .ti -8 nfnl_osf -f fingerprints [ -d ]
```


<a name="description"></a>

# Description

The
**nfnl_osf**
utility allows to load a set of operating system signatures into the kernel for
later matching against using iptables'
**osf**
match.


<a name="options"></a>

# Options



* **-f**_ fingerprints_  
  Read signatures from file
  _fingerprints_.
  
* **-d**  
  Instead of adding the signatures from
  _fingerprints_
  into the kernel, remove them.
  

<a name="exit-status"></a>

# Exit Status

Exit status is 0 if command succeeded, otherwise a negative return code
indicates the type of error which happened:


* **-1**
  Illegal arguments passed, fingerprints file not readable or failure in netlink
  communication.
  
* **-ENOENT**
  Fingerprints file not specified.
  
* **-EINVAL**
  Netlink handle initialization failed or fingerprints file format invalid.
  

<a name="files"></a>

# Files


An up to date set of operating system signatures can be downloaded from
http://www.openbsd.org/cgi-bin/cvsweb/src/etc/pf.os .


<a name="see-also"></a>

# See Also


The description of
**osf**
match in
**iptables-extensions**(8)
contains further information about the topic as well as example
**nfnl_osf**
invocations.
