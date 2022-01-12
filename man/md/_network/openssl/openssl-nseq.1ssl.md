# nseq(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-nseq, nseq - create or examine a Netscape certificate sequence

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl nseq [-help] [-in filename] [-out filename] [-toseq]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **nseq** command takes a file containing a Netscape certificate
sequence and prints out the certificates contained in it or takes a
file of certificates and converts it into a Netscape certificate
sequence.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read or standard input if this
  option is not specified.
* **-out filename**  
  .IX Item "-out filename"
  Specifies the output filename or standard output by default.
* **-toseq**  
  .IX Item "-toseq"
  Normally a Netscape certificate sequence will be input and the output
  is the certificates contained in it. With the **-toseq** option the
  situation is reversed: a Netscape certificate sequence is created from
  a file of certificates.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Output the certificates in a Netscape certificate sequence

.Vb 1
 openssl nseq -in nseq.pem -out certs.pem
.Ve

Create a Netscape certificate sequence

.Vb 1
 openssl nseq -in certs.pem -toseq -out nseq.pem
.Ve

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The **\s-1PEM\s0** encoded form uses the same headers and footers as a certificate:

.Vb 2
 -----BEGIN CERTIFICATE-----
 -----END CERTIFICATE-----
.Ve

A Netscape certificate sequence is a Netscape specific format that can be sent
to browsers as an alternative to the standard PKCS#7 format when several
certificates are sent to the browser: for example during certificate enrollment.
It is used by Netscape certificate server for example.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
This program needs a few more options: like allowing \s-1DER\s0 or \s-1PEM\s0 input and
output files and allowing multiple certificate files to be used.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
