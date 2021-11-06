# systemd\-hwdb(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-hwdb - hardware database management tool

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-hwdb&nbsp;[options]&nbsp;update&nbsp;'u systemd-hwdb [options] update .HP \w'systemd-hwdb&nbsp;[options]&nbsp;query&nbsp;modalias&nbsp;'u systemd-hwdb [options] query modalias
```

<a name="description"></a>

# Description


**systemd-hwdb**
expects a command and command specific arguments. It manages the binary hardware database.

<a name="options"></a>

# Options


**--usr**
Generate in /usr/lib/udev instead of /etc/udev.

**-r**, **--root=****PATH**
Alternate root path in the filesystem.

**-s**, **--strict**
When updating, return non-zero exit value on any parsing error.

**-h**, **--help**
Print a short help text and exit.

<a name="systemd-hwdb-fioptionsfr-update"></a>

### systemd\-hwdb [\fIoptions\fR] update


Update the binary database.

<a name="systemd-hwdb-fioptionsfr-query-fimodaliasfr"></a>

### systemd\-hwdb [\fIoptions\fR] query [\fIMODALIAS\fR]


Query database and print result.

<a name="see-also"></a>

# See Also


**hwdb**(7)
