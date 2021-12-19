# crl(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-crl, crl - CRL utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl crl [-help] [-inform PEM|DER] [-outform PEM|DER] [-text] [-in filename] [-out filename] [-nameopt option] [-noout] [-hash] [-issuer] [-lastupdate] [-nextupdate] [-CAfile file] [-CApath dir]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **crl** command processes \s-1CRL\s0 files in \s-1DER\s0 or \s-1PEM\s0 format.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format. **\s-1DER\s0** format is \s-1DER\s0 encoded \s-1CRL\s0
  structure. **\s-1PEM\s0** (the default) is a base64 encoded version of
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
* **-text**  
  .IX Item "-text"
  Print out the \s-1CRL\s0 in text form.
* **-nameopt option**  
  .IX Item "-nameopt option"
  Option which determines how the subject or issuer names are displayed. See
  the description of **-nameopt** in **x509**\|(1).
* **-noout**  
  .IX Item "-noout"
  Don't output the encoded version of the \s-1CRL.\s0
* **-hash**  
  .IX Item "-hash"
  Output a hash of the issuer name. This can be use to lookup CRLs in
  a directory by issuer name.
* **-hash\_old**  
  .IX Item "-hash_old"
  Outputs the hash\*(R" of the \s-1CRL\s0 issuer name using the older algorithm
  as used by OpenSSL before version 1.0.0.
* **-issuer**  
  .IX Item "-issuer"
  Output the issuer name.
* **-lastupdate**  
  .IX Item "-lastupdate"
  Output the lastUpdate field.
* **-nextupdate**  
  .IX Item "-nextupdate"
  Output the nextUpdate field.
* **-CAfile file**  
  .IX Item "-CAfile file"
  Verify the signature on a \s-1CRL\s0 by looking up the issuing certificate in
  **file**.
* **-CApath dir**  
  .IX Item "-CApath dir"
  Verify the signature on a \s-1CRL\s0 by looking up the issuing certificate in
  **dir**. This directory must be a standard certificate directory: that
  is a hash of each subject name (using **x509 -hash**) should be linked
  to each certificate.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The \s-1PEM CRL\s0 format uses the header and footer lines:

.Vb 2
 -----BEGIN X509 CRL-----
 -----END X509 CRL-----
.Ve

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Convert a \s-1CRL\s0 file from \s-1PEM\s0 to \s-1DER:\s0

.Vb 1
 openssl crl -in crl.pem -outform DER -out crl.der
.Ve

Output the text form of a \s-1DER\s0 encoded certificate:

.Vb 1
 openssl crl -in crl.der -inform DER -text -noout
.Ve

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
Ideally it should be possible to create a \s-1CRL\s0 using appropriate options
and files too.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**crl2pkcs7**\|(1), **ca**\|(1), **x509**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
