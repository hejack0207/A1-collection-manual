# rsa(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-rsa, rsa - RSA key processing tool

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl rsa [-help] [-inform PEM|DER] [-outform PEM|DER] [-in filename] [-passin arg] [-out filename] [-passout arg] [-aes128] [-aes192] [-aes256] [-aria128] [-aria192] [-aria256] [-camellia128] [-camellia192] [-camellia256] [-des] [-des3] [-idea] [-text] [-noout] [-modulus] [-check] [-pubin] [-pubout] [-RSAPublicKey_in] [-RSAPublicKey_out] [-engine id]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **rsa** command processes \s-1RSA\s0 keys. They can be converted between various
forms and their components printed out. **Note** this command uses the
traditional SSLeay compatible format for private key encryption: newer
applications should use the more secure PKCS#8 format using the **pkcs8**
utility.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format. The **\s-1DER\s0** option uses an \s-1ASN1 DER\s0 encoded
  form compatible with the PKCS#1 RSAPrivateKey or SubjectPublicKeyInfo format.
  The **\s-1PEM\s0** form is the default format: it consists of the **\s-1DER\s0** format base64
  encoded with additional header and footer lines. On input PKCS#8 format private
  keys are also accepted.
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
  This specifies the output filename to write a key to or standard output if this
  option is not specified. If any encryption options are set then a pass phrase
  will be prompted for. The output filename should **not** be the same as the input
  filename.
* **-passout password**  
  .IX Item "-passout password"
  The output file password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-aes128**, **-aes192**, **-aes256**, **-aria128**, **-aria192**, **-aria256**, **-camellia128**, **-camellia192**, **-camellia256**, **-des**, **-des3**, **-idea**  
  .IX Item "-aes128, -aes192, -aes256, -aria128, -aria192, -aria256, -camellia128, -camellia192, -camellia256, -des, -des3, -idea"
  These options encrypt the private key with the specified
  cipher before outputting it. A pass phrase is prompted for.
  If none of these options is specified the key is written in plain text. This
  means that using the **rsa** utility to read in an encrypted key with no
  encryption option can be used to remove the pass phrase from a key, or by
  setting the encryption options it can be use to add or change the pass phrase.
  These options can only be used with \s-1PEM\s0 format output files.
* **-text**  
  .IX Item "-text"
  Prints out the various public or private key components in
  plain text in addition to the encoded version.
* **-noout**  
  .IX Item "-noout"
  This option prevents output of the encoded version of the key.
* **-modulus**  
  .IX Item "-modulus"
  This option prints out the value of the modulus of the key.
* **-check**  
  .IX Item "-check"
  This option checks the consistency of an \s-1RSA\s0 private key.
* **-pubin**  
  .IX Item "-pubin"
  By default a private key is read from the input file: with this
  option a public key is read instead.
* **-pubout**  
  .IX Item "-pubout"
  By default a private key is output: with this option a public
  key will be output instead. This option is automatically set if
  the input is a public key.
* **-RSAPublicKey\_in**, **-RSAPublicKey\_out**  
  .IX Item "-RSAPublicKey_in, -RSAPublicKey_out"
  Like **-pubin** and **-pubout** except **RSAPublicKey** format is used instead.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **rsa**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The \s-1PEM\s0 private key format uses the header and footer lines:

.Vb 2
 -----BEGIN RSA PRIVATE KEY-----
 -----END RSA PRIVATE KEY-----
.Ve

The \s-1PEM\s0 public key format uses the header and footer lines:

.Vb 2
 -----BEGIN PUBLIC KEY-----
 -----END PUBLIC KEY-----
.Ve

The \s-1PEM\s0 **RSAPublicKey** format uses the header and footer lines:

.Vb 2
 -----BEGIN RSA PUBLIC KEY-----
 -----END RSA PUBLIC KEY-----
.Ve

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To remove the pass phrase on an \s-1RSA\s0 private key:

.Vb 1
 openssl rsa -in key.pem -out keyout.pem
.Ve

To encrypt a private key using triple \s-1DES:\s0

.Vb 1
 openssl rsa -in key.pem -des3 -out keyout.pem
.Ve

To convert a private key from \s-1PEM\s0 to \s-1DER\s0 format:

.Vb 1
 openssl rsa -in key.pem -outform DER -out keyout.der
.Ve

To print out the components of a private key to standard output:

.Vb 1
 openssl rsa -in key.pem -text -noout
.Ve

To just output the public part of a private key:

.Vb 1
 openssl rsa -in key.pem -pubout -out pubkey.pem
.Ve

Output the public part of a private key in **RSAPublicKey** format:

.Vb 1
 openssl rsa -in key.pem -RSAPublicKey_out -out pubkey.pem
.Ve

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
There should be an option that automatically handles .key files,
without having to manually edit them.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**pkcs8**\|(1), **dsa**\|(1), **genrsa**\|(1),
**gendsa**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
