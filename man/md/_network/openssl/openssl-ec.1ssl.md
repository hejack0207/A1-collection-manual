# ec(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-ec, ec - EC key processing

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl ec [-help] [-inform PEM|DER] [-outform PEM|DER] [-in filename] [-passin arg] [-out filename] [-passout arg] [-des] [-des3] [-idea] [-text] [-noout] [-param_out] [-pubin] [-pubout] [-conv_form arg] [-param_enc arg] [-no_public] [-check] [-engine id]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **ec** command processes \s-1EC\s0 keys. They can be converted between various
forms and their components printed out. **Note** OpenSSL uses the
private key format specified in '\s-1SEC 1:\s0 Elliptic Curve Cryptography'
(http://www.secg.org/). To convert an OpenSSL \s-1EC\s0 private key into the
PKCS#8 private key format use the **pkcs8** command.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format. The **\s-1DER\s0** option with a private key uses
  an \s-1ASN.1 DER\s0 encoded \s-1SEC1\s0 private key. When used with a public key it
  uses the SubjectPublicKeyInfo structure as specified in \s-1RFC 3280.\s0
  The **\s-1PEM\s0** form is the default format: it consists of the **\s-1DER\s0** format base64
  encoded with additional header and footer lines. In the case of a private key
  PKCS#8 format is also accepted.
* **-outform DER|PEM**  
  .IX Item "-outform DER|PEM"
  This specifies the output format, the options have the same meaning and default
  as the **-inform** option.
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read a key from or standard input if this
  option is not specified. If the key is encrypted a pass phrase will be
  prompted for.
* **-passin arg**  
  .IX Item "-passin arg"
  The input file password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-out filename**  
  .IX Item "-out filename"
  This specifies the output filename to write a key to or standard output by
  is not specified. If any encryption options are set then a pass phrase will be
  prompted for. The output filename should **not** be the same as the input
  filename.
* **-passout arg**  
  .IX Item "-passout arg"
  The output file password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-des|-des3|-idea**  
  .IX Item "-des|-des3|-idea"
  These options encrypt the private key with the \s-1DES,\s0 triple \s-1DES, IDEA\s0 or
  any other cipher supported by OpenSSL before outputting it. A pass phrase is
  prompted for.
  If none of these options is specified the key is written in plain text. This
  means that using the **ec** utility to read in an encrypted key with no
  encryption option can be used to remove the pass phrase from a key, or by
  setting the encryption options it can be use to add or change the pass phrase.
  These options can only be used with \s-1PEM\s0 format output files.
* **-text**  
  .IX Item "-text"
  Prints out the public, private key components and parameters.
* **-noout**  
  .IX Item "-noout"
  This option prevents output of the encoded version of the key.
* **-pubin**  
  .IX Item "-pubin"
  By default, a private key is read from the input file. With this option a
  public key is read instead.
* **-pubout**  
  .IX Item "-pubout"
  By default a private key is output. With this option a public
  key will be output instead. This option is automatically set if the input is
  a public key.
* **-conv\_form**  
  .IX Item "-conv_form"
  This specifies how the points on the elliptic curve are converted
  into octet strings. Possible values are: **compressed** (the default
  value), **uncompressed** and **hybrid**. For more information regarding
  the point conversion forms please read the X9.62 standard.
  **Note** Due to patent issues the **compressed** option is disabled
  by default for binary curves and can be enabled by defining
  the preprocessor macro **\s-1OPENSSL\_EC\_BIN\_PT\_COMP\s0** at compile time.
* **-param_enc arg**  
  .IX Item "-param_enc arg"
  This specifies how the elliptic curve parameters are encoded.
  Possible value are: **named\_curve**, i.e. the ec parameters are
  specified by an \s-1OID,\s0 or **explicit** where the ec parameters are
  explicitly given (see \s-1RFC 3279\s0 for the definition of the
  \s-1EC\s0 parameters structures). The default value is **named\_curve**.
  **Note** the **implicitlyCA** alternative, as specified in \s-1RFC 3279,\s0
  is currently not implemented in OpenSSL.
* **-no\_public**  
  .IX Item "-no_public"
  This option omits the public key components from the private key output.
* **-check**  
  .IX Item "-check"
  This option checks the consistency of an \s-1EC\s0 private or public key.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **ec**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The \s-1PEM\s0 private key format uses the header and footer lines:

.Vb 2
 -----BEGIN EC PRIVATE KEY-----
 -----END EC PRIVATE KEY-----
.Ve

The \s-1PEM\s0 public key format uses the header and footer lines:

.Vb 2
 -----BEGIN PUBLIC KEY-----
 -----END PUBLIC KEY-----
.Ve

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To encrypt a private key using triple \s-1DES:\s0

.Vb 1
 openssl ec -in key.pem -des3 -out keyout.pem
.Ve

To convert a private key from \s-1PEM\s0 to \s-1DER\s0 format:

.Vb 1
 openssl ec -in key.pem -outform DER -out keyout.der
.Ve

To print out the components of a private key to standard output:

.Vb 1
 openssl ec -in key.pem -text -noout
.Ve

To just output the public part of a private key:

.Vb 1
 openssl ec -in key.pem -pubout -out pubkey.pem
.Ve

To change the parameters encoding to **explicit**:

.Vb 1
 openssl ec -in key.pem -param_enc explicit -out keyout.pem
.Ve

To change the point conversion form to **compressed**:

.Vb 1
 openssl ec -in key.pem -conv_form compressed -out keyout.pem
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ecparam**\|(1), **dsa**\|(1), **rsa**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2003-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
