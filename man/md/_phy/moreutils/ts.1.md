# ts(1)

moreutils, 2015-07-13

.if n .ad l
.nh

<a name="name"></a>

# Name

ts - timestamp input

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" ts [-r] [-i | -s] [format]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
ts adds a timestamp to the beginning of each line of input.

The optional format parameter controls how the timestamp is formatted,
as used by **strftime**\|(3). The default format is %b \f(CW%d \f(CW%H:%M:%S\*(R". In
addition to the regular strftime conversion specifications, %.S\*(R" and \*(L"%.s\*(R"
are like %S\*(R" and \*(L"%s\*(R", but provide subsecond resolution
(ie, 30.00001\*(R" and \*(L"1301682593.00001\*(R").

If the -r switch is passed, it instead converts existing timestamps in
the input to relative times, such as 15m5s ago\*(R". Many common timestamp
formats are supported. Note that the Time::Duration and Date::Parse perl
modules are required for this mode to work. Currently, converting localized
dates is not supported.

If both -r and a format is passed, the existing timestamps are
converted to the specified format.

If the -i or -s switch is passed, ts timestamps incrementally instead. In case
of -i, every timestamp will be the time elapsed since the last timestamp. In
case of -s, the time elapsed since start of the program is used.
The default format changes to %H:%M:%S\*(R", and \*(L"%.S\*(R" and \*(L"%.s\*(R" can be used
as well.

<a name="environment"></a>

# Environment

.IX Header "ENVIRONMENT"
The standard \s-1TZ\s0 environment variable controls what time zone dates
are assumed to be in, if a timezone is not specified as part of the date.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Copyright 2006 by Joey Hess &lt;[id@joeyh.name](mailto:id@joeyh.name)&gt;

Licensed under the \s-1GNU GPL.\s0
