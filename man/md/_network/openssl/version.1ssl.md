# version(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-version, version - print OpenSSL version information

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl version [-help] [-a] [-v] [-b] [-o] [-f] [-p] [-d] [-e]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This command is used to print out version information about OpenSSL.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-a**  
  .IX Item "-a"
  All information, this is the same as setting all the other flags.
* **-v**  
  .IX Item "-v"
  The current OpenSSL version.
* **-b**  
  .IX Item "-b"
  The date the current version of OpenSSL was built.
* **-o**  
  .IX Item "-o"
  Option information: various options set when the library was built.
* **-f**  
  .IX Item "-f"
  Compilation flags.
* **-p**  
  .IX Item "-p"
  Platform setting.
* **-d**  
  .IX Item "-d"
  \s-1OPENSSLDIR\s0 setting.
* **-e**  
  .IX Item "-e"
  \s-1ENGINESDIR\s0 setting.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The output of **openssl version -a** would typically be used when sending
in a bug report.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
