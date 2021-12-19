# storeutl(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-storeutl, storeutl - STORE utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl storeutl [-help] [-out file] [-noout] [-passin arg] [-text arg] [-engine id] [-r] [-certs] [-keys] [-crls] [-subject arg] [-issuer arg] [-serial arg] [-alias arg] [-fingerprint arg] [-\f(BIdigest] uri ...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **storeutl** command can be used to display the contents (after decryption
as the case may be) fetched from the given URIs.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-out filename**  
  .IX Item "-out filename"
  specifies the output filename to write to or standard output by
  default.
* **-noout**  
  .IX Item "-noout"
  this option prevents output of the \s-1PEM\s0 data.
* **-passin arg**  
  .IX Item "-passin arg"
  the key password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-text**  
  .IX Item "-text"
  Prints out the objects in text form, similarly to the **-text** output from
  **openssl x509**, **openssl pkey**, etc.
* **-engine id**  
  .IX Item "-engine id"
  specifying an engine (by its unique **id** string) will cause **storeutl**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed.
  The engine will then be set as the default for all available algorithms.
* **-r**  
  .IX Item "-r"
  Fetch objects recursively when possible.
* **-certs**  
  .IX Item "-certs"
* **-keys**  
  .IX Item "-keys"
* **-crls**  
  .IX Item "-crls"
  Only select the certificates, keys or CRLs from the given \s-1URI.\s0
  However, if this \s-1URI\s0 would return a set of names (URIs), those are always
  returned.
* **-subject arg**  
  .IX Item "-subject arg"
  Search for an object having the subject name **arg**.
  The arg must be formatted as _/type0=value0/type1=value1/type2=..._.
  Keyword characters may be escaped by \e (backslash), and whitespace is retained.
  Empty values are permitted but are ignored for the search.  That is,
  a search with an empty value will have the same effect as not specifying
  the type at all.
* **-issuer arg**  
  .IX Item "-issuer arg"
* **-serial arg**  
  .IX Item "-serial arg"
  Search for an object having the given issuer name and serial number.
  These two options _must_ be used together.
  The issuer arg must be formatted as _/type0=value0/type1=value1/type2=..._,
  characters may be escaped by \e (backslash), no spaces are skipped.
  The serial arg may be specified as a decimal value or a hex value if preceded
  by **0x**.
* **-alias arg**  
  .IX Item "-alias arg"
  Search for an object having the given alias.
* **-fingerprint arg**  
  .IX Item "-fingerprint arg"
  Search for an object having the given fingerprint.
* **-\f(BIdigest**  
  .IX Item "-digest"
  The digest that was used to compute the fingerprint given with **-fingerprint**.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**openssl**\|(1)

<a name="history"></a>

# History

.IX Header "HISTORY"
The **openssl** **storeutl** app was added in OpenSSL 1.1.1.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2016-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
