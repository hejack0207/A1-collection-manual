# pkcs7(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-pkcs7, pkcs7 - PKCS#7 utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl pkcs7 [-help] [-inform PEM|DER] [-outform PEM|DER] [-in filename] [-out filename] [-print_certs] [-text] [-noout] [-engine id]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **pkcs7** command processes PKCS#7 files in \s-1DER\s0 or \s-1PEM\s0 format.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format. **\s-1DER\s0** format is \s-1DER\s0 encoded PKCS#7
  v1.5 structure.**\s-1PEM\s0** (the default) is a base64 encoded version of
  the \s-1DER\s0 form with header and footer lines.
* **-outform DER|PEM**  
  .IX Item "-outform DER|PEM"
  This specifies the output format, the options have the same meaning and default
  as the **-inform** option.
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read from or standard input if this
  option is not specified.
* **-out filename**  
  .IX Item "-out filename"
  Specifies the output filename to write to or standard output by
  default.
* **-print\_certs**  
  .IX Item "-print_certs"
  Prints out any certificates or CRLs contained in the file. They are
  preceded by their subject and issuer names in one line format.
* **-text**  
  .IX Item "-text"
  Prints out certificates details in full rather than just subject and
  issuer names.
* **-noout**  
  .IX Item "-noout"
  Don't output the encoded version of the PKCS#7 structure (or certificates
  is **-print\_certs** is set).
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **pkcs7**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Convert a PKCS#7 file from \s-1PEM\s0 to \s-1DER:\s0

.Vb 1
 openssl pkcs7 -in file.pem -outform DER -out file.der
.Ve

Output all certificates in a file:

.Vb 1
 openssl pkcs7 -in file.pem -print_certs -out certs.pem
.Ve

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The \s-1PEM\s0 PKCS#7 format uses the header and footer lines:

.Vb 2
 -----BEGIN PKCS7-----
 -----END PKCS7-----
.Ve

For compatibility with some CAs it will also accept:

.Vb 2
 -----BEGIN CERTIFICATE-----
 -----END CERTIFICATE-----
.Ve

<a name="restrictions"></a>

# Restrictions

.IX Header "RESTRICTIONS"
There is no option to print out all the fields of a PKCS#7 file.

This PKCS#7 routines only understand PKCS#7 v 1.5 as specified in \s-1RFC2315\s0 they
cannot currently parse, for example, the new \s-1CMS\s0 as described in \s-1RFC2630.\s0

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**crl2pkcs7**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
