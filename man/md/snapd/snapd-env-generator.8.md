# snapd-env-generator(7) - internal tool to set /snap/bin to PATH

2.35, 2018-08-31

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

```
.INDENT 0.0 .INDENT 3.5 snapd-env-generator .UNINDENT .UNINDENT
```

<a name="description"></a>

# Description


The _snapd-env-generator_ is run by systemd to ensure that the snap
bin dir (usually /snap/bin) is path of PATH.

<a name="bugs"></a>

# Bugs


Please report all bugs with _https://bugs.launchpad.net/snapd/+filebug_

<a name="author"></a>

# Author

[michael.vogt@ubuntu.com](mailto:michael.vogt@ubuntu.com)

<a name="copyright"></a>

# Copyright

Canonical Ltd.

