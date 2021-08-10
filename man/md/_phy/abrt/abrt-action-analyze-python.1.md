# abrt\-action\-analyz(1)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

abrt-action-analyze-python - Calculate and save UUID and duplicate hash for a problem data directory DIR with Python crash data.

<a name="synopsis"></a>

# Synopsis

```

 abrt-action-analyze-python [-v] [-d DIR]
```

<a name="description"></a>

# Description


The tool reads the file named _backtrace_ from a problem data directory, parses it as a Python exception and generates a duplication hash and a universally unique identifier (UUID). Then it saves this data as new elements _duphash_ and _uuid_.

<a name="integration-with-abrt-events"></a>

### Integration with ABRT events


_abrt-action-analyze-python_ can be used to generate the duplication hash of a newly discovered Python crash.

.if n \{.RS 4
.\}
    EVENT=post-create analyzer=Python   abrt-action-analyze-python
.if n \{.RE
.\}

<a name="options"></a>

# Options


-d DIR
Path to a problem directory. Current working directory is used when this option is not provided.

-v
Be more verbose. Can be given multiple times.

<a name="authors"></a>

# Authors


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ABRT team
