# abrt\-action\-save\-(1)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

abrt-action-save-package-data - Query package database and save package and component name.

<a name="synopsis"></a>

# Synopsis

```

 abrt-action-save-package-data [-v] [-c CONFFILE] -d DIR
```

<a name="description"></a>

# Description


The tool reads problem directory DIR. It analyzes contents of _analyzer_, _executable_, _cmdline_ and _remote_ elements, checks database of installed packages, and creates new elements _package_ and _component_.

This data is usually necessary if the problem will be reported to a bug tracking database.

<a name="integration-with-abrt-events"></a>

### Integration with ABRT events


This tool can be used as an ABRT reporter. Example fragment for _/etc/libreport/report\_event.conf_:

.if n \{.RS 4
.\}
    # Determine in which package/component the crash happened (if not yet done):
    EVENT=post-create component=
            abrt-action-save-package-data
.if n \{.RE
.\}

<a name="options"></a>

# Options


-v, --verbose
Be verbose

-c CONFFILE
Path to configuration file.

-r CHROOT
Force RPM to use CHROOT for root directory

-d DIR
Path to problem directory.

<a name="see-also"></a>

# See Also


abrt-action-save-package-data.conf(5), abrt_event.conf(5)

<a name="authors"></a>

# Authors


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ABRT team
