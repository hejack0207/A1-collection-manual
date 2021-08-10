# gpg_keys\&.conf(5)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

gpg_keys.conf - Configuration file for abrt-action-save-package-data.

<a name="synopsis"></a>

# Synopsis

```

 /etc/abrt/gpg_keys.conf
```

<a name="description"></a>

# Description


The configuration file consists of items in the format "Option = Value". Currently, only one item exists:

**GPGKeysDir = ****directory**
The path to the directory which contains files with GPG keys of known RPM repositories. These keys are used to verify package signatures.

Default is
_/etc/pki/rpm-gpg_.

<a name="files"></a>

# Files


/etc/abrt/gpg_keys.conf

<a name="see-also"></a>

# See Also


abrt-action-save-package-data(1), abrt-action-save-package-data.conf(5), abrt.conf(5)

<a name="authors"></a>

# Authors


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ABRT team
