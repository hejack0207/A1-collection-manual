# abrt\-action\-save\-(5)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

abrt-action-save-package-data.conf - Configuration file for abrt-action-save-package-data

<a name="synopsis"></a>

# Synopsis

```

 /etc/abrt/abrt-action-save-package-data.conf
```

<a name="description"></a>

# Description


The _abrt-action-save-package-data_ tool queries RPM database and saves package and component name to problem data.

The configuration file consists of items in the format "Option = Value". A description of each item follows:

**OpenGPGCheck = ****yes/no**
If enabled, only crashes in signed packages will be analyzed. The list of trusted public keys used to verify the signature is in /etc/gpg_keys.conf.

Default is
_yes_.

**BlackList = ****list**
Crashes in packages listed here will be ignored by ABRT.

Default is
bash, mono-core, nspluginwrapper, strace, valgrind.

**BlackListedPaths = ****list**
Crashes in paths matching the glob patterns in this list will be ignored by ABRT.

Default is
/usr/share/doc/*, */example*, /usr/bin/nspluginviewer, /usr/lib*/firefox/plugin-container

**ProcessUnpackaged = ****yes/no**
If enabled, ABRT will process crashes from unpackaged executables.

Default is
_no_.

**Interpreters = ****list**
Comma-separated list of names of language interpreters. If a crash occurs in a program whose basename is equal to one of these, ABRT assigns the crash to the executed script instead.

Default is
python, python2, python2.7, python3, python3.8, perl, perl5.30.1 php, php-cgi, R, tclsh, tclsh8.6.

<a name="files"></a>

# Files


/etc/abrt/abrt-action-save-package-data.conf

<a name="see-also"></a>

# See Also


abrt.conf(5), gpg_keys.conf(5)

<a name="authors"></a>

# Authors


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ABRT team
