# pkey(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-pkey, pkey - public or private key processing tool

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl pkey [-help] [-inform PEM|DER] [-outform PEM|DER] [-in filename] [-passin arg] [-out filename] [-passout arg] [-traditional] [-\f(BIcipher] [-text] [-text_pub] [-noout] [-pubin] [-pubout] [-engine id] [-check] [-pubcheck]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **pkey** command processes public or private keys. They can be converted
between various forms and their components printed out.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format \s-1DER\s0 or \s-1PEM.\s0 The default format is \s-1PEM.\s0
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
* **-traditional**  
  .IX Item "-traditional"
  Normally a private key is written using standard format: this is PKCS#8 form
  with the appropriate encryption algorithm (if any). If the **-traditional**
  option is specified then the older traditional\*(R" format is used instead.
* **-\f(BIcipher**  
  .IX Item "-cipher"
  These options encrypt the private key with the supplied cipher. Any algorithm
  name accepted by **EVP\_get\_cipherbyname()** is acceptable such as **des3**.
* **-text**  
  .IX Item "-text"
  Prints out the various public or private key components in
  plain text in addition to the encoded version.
* **-text\_pub**  
  .IX Item "-text_pub"
  Print out only public key components even if a private key is being processed.
* **-noout**  
  .IX Item "-noout"
  Do not output the encoded version of the key.
* **-pubin**  
  .IX Item "-pubin"
  By default a private key is read from the input file: with this
  option a public key is read instead.
* **-pubout**  
  .IX Item "-pubout"
  By default a private key is output: with this option a public
  key will be output instead. This option is automatically set if
  the input is a public key.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **pkey**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.
* **-check**  
  .IX Item "-check"
  This option checks the consistency of a key pair for both public and private
  components.
* **-pubcheck**  
  .IX Item "-pubcheck"
  This option checks the correctness of either a public key or the public component
  of a key pair.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To remove the pass phrase on an \s-1RSA\s0 private key:

.Vb 1
 openssl pkey -in key.pem -out keyout.pem
.Ve

To encrypt a private key using triple \s-1DES:\s0

.Vb 1
 openssl pkey -in key.pem -des3 -out keyout.pem
.Ve

To convert a private key from \s-1PEM\s0 to \s-1DER\s0 format:

.Vb 1
 openssl pkey -in key.pem -outform DER -out keyout.der
.Ve

To print out the components of a private key to standard output:

.Vb 1
 openssl pkey -in key.pem -text -noout
.Ve

To print out the public components of a private key to standard output:

.Vb 1
 openssl pkey -in key.pem -text_pub -noout
.Ve

To just output the public part of a private key:

.Vb 1
 openssl pkey -in key.pem -pubout -out pubkey.pem
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**genpkey**\|(1), **rsa**\|(1), **pkcs8**\|(1),
**dsa**\|(1), **genrsa**\|(1), **gendsa**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2006-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
