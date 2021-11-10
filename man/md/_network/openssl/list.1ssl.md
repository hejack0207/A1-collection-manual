# list(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-list, list - list algorithms and features

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl list [-help] [-1] [-commands] [-digest-commands] [-digest-algorithms] [-cipher-commands] [-cipher-algorithms] [-public-key-algorithms] [-public-key-methods] [-disabled]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This command is used to generate list of algorithms or disabled
features.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Display a usage message.
* **-1**  
  .IX Item "-1"
  List the commands, digest-commands, or cipher-commands in a single column.
  If used, this option must be given first.
* **-commands**  
  .IX Item "-commands"
  Display a list of standard commands.
* **-digest-commands**  
  .IX Item "-digest-commands"
  Display a list of message digest commands, which are typically used
  as input to the **dgst**\|(1) or **speed**\|(1) commands.
* **-digest-algorithms**  
  .IX Item "-digest-algorithms"
  Display a list of message digest algorithms.
  If a line is of the form
    foo =&gt; bar
  then **foo** is an alias for the official algorithm name, **bar**.
* **-cipher-commands**  
  .IX Item "-cipher-commands"
  Display a list of cipher commands, which are typically used as input
  to the **dgst**\|(1) or **speed**\|(1) commands.
* **-cipher-algorithms**  
  .IX Item "-cipher-algorithms"
  Display a list of cipher algorithms.
  If a line is of the form
    foo =&gt; bar
  then **foo** is an alias for the official algorithm name, **bar**.
* **-public-key-algorithms**  
  .IX Item "-public-key-algorithms"
  Display a list of public key algorithms, with each algorithm as
  a block of multiple lines, all but the first are indented.
* **-public-key-methods**  
  .IX Item "-public-key-methods"
  Display a list of public key method OIDs: this also includes public key methods
  without an associated \s-1ASN.1\s0 method, for example, \s-1KDF\s0 algorithms.
* **-disabled**  
  .IX Item "-disabled"
  Display a list of disabled features, those that were compiled out
  of the installation.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2016-2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
