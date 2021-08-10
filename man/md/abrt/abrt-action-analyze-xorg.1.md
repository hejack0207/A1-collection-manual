# abrt\-action\-analyz(1)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

abrt-action-analyze-xorg - Calculate and save UUID and duplicate hash for a problem data directory DIR with Xorg backtrace.

<a name="synopsis"></a>

# Synopsis

```

 abrt-action-analyze-xorg [-v] [-d DIR]
```

<a name="description"></a>

# Description


The tool reads the file named _Xorg.0.log_ and checks if any black listed module was loaded. If so, _not-reportable_ file is created with an appropriate explanation text. If no black listed module was loaded, the tool reads the file named _backtrace_ from a problem data directory record and generates a duplication hash and a universally unique identifier (UUID). Then it saves this data as new elements _duphash_ and _uuid_.

<a name="integration-with-abrt-events"></a>

### Integration with ABRT events


_abrt-action-analyze-xorg_ can be used to generate the duplication hash of a newly discovered Xorg backtraces.

.if n \{.RS 4
.\}
    EVENT=post-create analyzer=Xorg   abrt-action-analyze-xorg
.if n \{.RE
.\}

<a name="options"></a>

# Options


-d DIR
Path to a problem directory. Current working directory is used when this option is not provided.

-v
Be more verbose. Can be given multiple times.

<a name="files"></a>

# Files


/etc/abrt/plugins/xorg.conf
Configuration file for ABRT’s tools which work with Xorg crashes

<a name="see-also"></a>

# See Also


abrt-dump-journal-xorg(1) abrt-xorg.conf(5)

<a name="authors"></a>

# Authors


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ABRT team
