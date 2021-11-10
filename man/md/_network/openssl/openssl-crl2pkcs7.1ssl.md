# crl2pkcs7(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-crl2pkcs7, crl2pkcs7 - Create a PKCS#7 structure from a CRL and certificates

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl crl2pkcs7 [-help] [-inform PEM|DER] [-outform PEM|DER] [-in filename] [-out filename] [-certfile filename] [-nocrl]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **crl2pkcs7** command takes an optional \s-1CRL\s0 and one or more
certificates and converts them into a PKCS#7 degenerate certificates
only structure.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the \s-1CRL\s0 input format. **\s-1DER\s0** format is \s-1DER\s0 encoded \s-1CRL\s0
  structure.**\s-1PEM\s0** (the default) is a base64 encoded version of
  the \s-1DER\s0 form with header and footer lines. The default format is \s-1PEM.\s0
* **-outform DER|PEM**  
  .IX Item "-outform DER|PEM"
  This specifies the PKCS#7 structure output format. **\s-1DER\s0** format is \s-1DER\s0
  encoded PKCS#7 structure.**\s-1PEM\s0** (the default) is a base64 encoded version of
  the \s-1DER\s0 form with header and footer lines. The default format is \s-1PEM.\s0
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read a \s-1CRL\s0 from or standard input if this
  option is not specified.
* **-out filename**  
  .IX Item "-out filename"
  Specifies the output filename to write the PKCS#7 structure to or standard
  output by default.
* **-certfile filename**  
  .IX Item "-certfile filename"
  Specifies a filename containing one or more certificates in **\s-1PEM\s0** format.
  All certificates in the file will be added to the PKCS#7 structure. This
  option can be used more than once to read certificates from multiple
  files.
* **-nocrl**  
  .IX Item "-nocrl"
  Normally a \s-1CRL\s0 is included in the output file. With this option no \s-1CRL\s0 is
  included in the output file and a \s-1CRL\s0 is not read from the input file.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Create a PKCS#7 structure from a certificate and \s-1CRL:\s0

.Vb 1
 openssl crl2pkcs7 -in crl.pem -certfile cert.pem -out p7.pem
.Ve

Creates a PKCS#7 structure in \s-1DER\s0 format with no \s-1CRL\s0 from several
different certificates:

.Vb 2
 openssl crl2pkcs7 -nocrl -certfile newcert.pem
        -certfile demoCA/cacert.pem -outform DER -out p7.der
.Ve

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The output file is a PKCS#7 signed data structure containing no signers and
just certificates and an optional \s-1CRL.\s0

This utility can be used to send certificates and CAs to Netscape as part of
the certificate enrollment process. This involves sending the \s-1DER\s0 encoded output
as \s-1MIME\s0 type application/x-x509-user-cert.

The **\s-1PEM\s0** encoded form with the header and footer lines removed can be used to
install user certificates and CAs in \s-1MSIE\s0 using the Xenroll control.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**pkcs7**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
