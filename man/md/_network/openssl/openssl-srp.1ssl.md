# srp(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-srp, srp - maintain SRP password file

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl srp [-help] [-verbose] [-add] [-modify] [-delete] [-list] [-name section] [-config file] [-srpvfile file] [-gn identifier] [-userinfo text...] [-passin arg] [-passout arg] [user...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **srp** command is user to maintain an \s-1SRP\s0 (secure remote password)
file.
At most one of the **-add**, **-modify**, **-delete**, and **-list** options
can be specified.
These options take zero or more usernames as parameters and perform the
appropriate operation on the \s-1SRP\s0 file.
For **-list**, if no **user** is given then all users are displayed.

The configuration file to use, and the section within the file, can be
specified with the **-config** and **-name** flags, respectively.
If the config file is not specified, the **-srpvfile** can be used to
just specify the file to operate on.

The **-userinfo** option specifies additional information to add when
adding or modifying a user.

The **-gn** flag specifies the **g** and **N** values, using one of
the strengths defined in \s-1IETF RFC 5054.\s0

The **-passin** and **-passout** arguments are parsed as described in
the **openssl**\|(1) command.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* [**-help**]  
  .IX Item "[-help]"
  Display an option summary.
* [**-verbose**]  
  .IX Item "[-verbose]"
  Generate verbose output while processing.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
