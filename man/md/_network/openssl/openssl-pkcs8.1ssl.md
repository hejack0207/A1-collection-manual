# pkcs8(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-pkcs8, pkcs8 - PKCS#8 format private key conversion tool

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl pkcs8 [-help] [-topk8] [-inform PEM|DER] [-outform PEM|DER] [-in filename] [-passin arg] [-out filename] [-passout arg] [-iter count] [-noiter] [-rand file...] [-writerand file] [-nocrypt] [-traditional] [-v2 alg] [-v2prf alg] [-v1 alg] [-engine id] [-scrypt] [-scrypt_N N] [-scrypt_r r] [-scrypt_p p]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **pkcs8** command processes private keys in PKCS#8 format. It can handle
both unencrypted PKCS#8 PrivateKeyInfo format and EncryptedPrivateKeyInfo
format with a variety of PKCS#5 (v1.5 and v2.0) and PKCS#12 algorithms.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-topk8**  
  .IX Item "-topk8"
  Normally a PKCS#8 private key is expected on input and a private key will be
  written to the output file. With the **-topk8** option the situation is
  reversed: it reads a private key and writes a PKCS#8 format key.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format: see \s-1KEY FORMATS\*(R"\s0 for more details. The default
  format is \s-1PEM.\s0
* **-outform DER|PEM**  
  .IX Item "-outform DER|PEM"
  This specifies the output format: see \s-1KEY FORMATS\*(R"\s0 for more details. The default
  format is \s-1PEM.\s0
* **-traditional**  
  .IX Item "-traditional"
  When this option is present and **-topk8** is not a traditional format private
  key is written.
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
  default. If any encryption options are set then a pass phrase will be
  prompted for. The output filename should **not** be the same as the input
  filename.
* **-passout arg**  
  .IX Item "-passout arg"
  The output file password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-iter count**  
  .IX Item "-iter count"
  When creating new PKCS#8 containers, use a given number of iterations on
  the password in deriving the encryption key for the PKCS#8 output.
  High values increase the time required to brute-force a PKCS#8 container.
* **-nocrypt**  
  .IX Item "-nocrypt"
  PKCS#8 keys generated or input are normally PKCS#8 EncryptedPrivateKeyInfo
  structures using an appropriate password based encryption algorithm. With
  this option an unencrypted PrivateKeyInfo structure is expected or output.
  This option does not encrypt private keys at all and should only be used
  when absolutely necessary. Certain software such as some versions of Java
  code signing software used unencrypted private keys.
* **-rand file...**  
  .IX Item "-rand file..."
  A file or files containing random data used to seed the random number
  generator.
  Multiple files can be specified separated by an OS-dependent character.
  The separator is **;** for MS-Windows, **,** for OpenVMS, and **:** for
  all others.
* [**-writerand file**]  
  .IX Item "[-writerand file]"
  Writes random data to the specified _file_ upon exit.
  This can be used with a subsequent **-rand** flag.
* **-v2 alg**  
  .IX Item "-v2 alg"
  This option sets the PKCS#5 v2.0 algorithm.
  .Sp
  The **alg** argument is the encryption algorithm to use, valid values include
  **aes128**, **aes256** and **des3**. If this option isn't specified then **aes256**
  is used.
* **-v2prf alg**  
  .IX Item "-v2prf alg"
  This option sets the \s-1PRF\s0 algorithm to use with PKCS#5 v2.0. A typical value
  value would be **hmacWithSHA256**. If this option isn't set then the default
  for the cipher is used or **hmacWithSHA256** if there is no default.
  .Sp
  Some implementations may not support custom \s-1PRF\s0 algorithms and may require
  the **hmacWithSHA1** option to work.
* **-v1 alg**  
  .IX Item "-v1 alg"
  This option indicates a PKCS#5 v1.5 or PKCS#12 algorithm should be used.  Some
  older implementations may not support PKCS#5 v2.0 and may require this option.
  If not specified PKCS#5 v2.0 form is used.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **pkcs8**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.
* **-scrypt**  
  .IX Item "-scrypt"
  Uses the **scrypt** algorithm for private key encryption using default
  parameters: currently N=16384, r=8 and p=1 and \s-1AES\s0 in \s-1CBC\s0 mode with a 256 bit
  key. These parameters can be modified using the **-scrypt\_N**, **-scrypt\_r**,
  **-scrypt\_p** and **-v2** options.
* **-scrypt_N N** **-scrypt_r r** **-scrypt_p p**  
  .IX Item "-scrypt_N N -scrypt_r r -scrypt_p p"
  Sets the scrypt **N**, **r** or **p** parameters.

<a name="key-formats"></a>

# Key Formats

.IX Header "KEY FORMATS"
Various different formats are used by the pkcs8 utility. These are detailed
below.

If a key is being converted from PKCS#8 form (i.e. the **-topk8** option is
not used) then the input file must be in PKCS#8 format. An encrypted
key is expected unless **-nocrypt** is included.

If **-topk8** is not used and **\s-1PEM\s0** mode is set the output file will be an
unencrypted private key in PKCS#8 format. If the **-traditional** option is
used then a traditional format private key is written instead.

If **-topk8** is not used and **\s-1DER\s0** mode is set the output file will be an
unencrypted private key in traditional \s-1DER\s0 format.

If **-topk8** is used then any supported private key can be used for the input
file in a format specified by **-inform**. The output file will be encrypted
PKCS#8 format using the specified encryption parameters unless **-nocrypt**
is included.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
By default, when converting a key to PKCS#8 format, PKCS#5 v2.0 using 256 bit
\s-1AES\s0 with \s-1HMAC\s0 and \s-1SHA256\s0 is used.

Some older implementations do not support PKCS#5 v2.0 format and require
the older PKCS#5 v1.5 form instead, possibly also requiring insecure weak
encryption algorithms such as 56 bit \s-1DES.\s0

The encrypted form of a \s-1PEM\s0 encode PKCS#8 files uses the following
headers and footers:

.Vb 2
 -----BEGIN ENCRYPTED PRIVATE KEY-----
 -----END ENCRYPTED PRIVATE KEY-----
.Ve

The unencrypted form uses:

.Vb 2
 -----BEGIN PRIVATE KEY-----
 -----END PRIVATE KEY-----
.Ve

Private keys encrypted using PKCS#5 v2.0 algorithms and high iteration
counts are more secure that those encrypted using the traditional
SSLeay compatible formats. So if additional security is considered
important the keys should be converted.

It is possible to write out \s-1DER\s0 encoded encrypted private keys in
PKCS#8 format because the encryption details are included at an \s-1ASN1\s0
level whereas the traditional format includes them at a \s-1PEM\s0 level.

<a name="pkcs5-v15-and-pkcs12-algorithms"></a>

# Pkcs#5 V1.5 and Pkcs#12 Algorithms.

.IX Header "PKCS#5 v1.5 and PKCS#12 algorithms."
Various algorithms can be used with the **-v1** command line option,
including PKCS#5 v1.5 and PKCS#12. These are described in more detail
below.

* **\s-1PBE-MD2-DES PBE-MD5-DES\s0**  
  .IX Item "PBE-MD2-DES PBE-MD5-DES"
  These algorithms were included in the original PKCS#5 v1.5 specification.
  They only offer 56 bits of protection since they both use \s-1DES.\s0
* **\s-1PBE-SHA1-RC2-64\s0**, **\s-1PBE-MD2-RC2-64\s0**, **\s-1PBE-MD5-RC2-64\s0**, **\s-1PBE-SHA1-DES\s0**  
  .IX Item "PBE-SHA1-RC2-64, PBE-MD2-RC2-64, PBE-MD5-RC2-64, PBE-SHA1-DES"
  These algorithms are not mentioned in the original PKCS#5 v1.5 specification
  but they use the same key derivation algorithm and are supported by some
  software. They are mentioned in PKCS#5 v2.0. They use either 64 bit \s-1RC2\s0 or
  56 bit \s-1DES.\s0
* **\s-1PBE-SHA1-RC4-128\s0**, **\s-1PBE-SHA1-RC4-40\s0**, **\s-1PBE-SHA1-3DES\s0**, **\s-1PBE-SHA1-2DES\s0**, **\s-1PBE-SHA1-RC2-128\s0**, **\s-1PBE-SHA1-RC2-40\s0**  
  .IX Item "PBE-SHA1-RC4-128, PBE-SHA1-RC4-40, PBE-SHA1-3DES, PBE-SHA1-2DES, PBE-SHA1-RC2-128, PBE-SHA1-RC2-40"
  These algorithms use the PKCS#12 password based encryption algorithm and
  allow strong encryption algorithms like triple \s-1DES\s0 or 128 bit \s-1RC2\s0 to be used.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Convert a private key to PKCS#8 format using default parameters (\s-1AES\s0 with
256 bit key and **hmacWithSHA256**):

.Vb 1
 openssl pkcs8 -in key.pem -topk8 -out enckey.pem
.Ve

Convert a private key to PKCS#8 unencrypted format:

.Vb 1
 openssl pkcs8 -in key.pem -topk8 -nocrypt -out enckey.pem
.Ve

Convert a private key to PKCS#5 v2.0 format using triple \s-1DES:\s0

.Vb 1
 openssl pkcs8 -in key.pem -topk8 -v2 des3 -out enckey.pem
.Ve

Convert a private key to PKCS#5 v2.0 format using \s-1AES\s0 with 256 bits in \s-1CBC\s0
mode and **hmacWithSHA512** \s-1PRF:\s0

.Vb 1
 openssl pkcs8 -in key.pem -topk8 -v2 aes-256-cbc -v2prf hmacWithSHA512 -out enckey.pem
.Ve

Convert a private key to PKCS#8 using a PKCS#5 1.5 compatible algorithm
(\s-1DES\s0):

.Vb 1
 openssl pkcs8 -in key.pem -topk8 -v1 PBE-MD5-DES -out enckey.pem
.Ve

Convert a private key to PKCS#8 using a PKCS#12 compatible algorithm
(3DES):

.Vb 1
 openssl pkcs8 -in key.pem -topk8 -out enckey.pem -v1 PBE-SHA1-3DES
.Ve

Read a \s-1DER\s0 unencrypted PKCS#8 format private key:

.Vb 1
 openssl pkcs8 -inform DER -nocrypt -in key.der -out key.pem
.Ve

Convert a private key from any PKCS#8 encrypted format to traditional format:

.Vb 1
 openssl pkcs8 -in pk8.pem -traditional -out key.pem
.Ve

Convert a private key to PKCS#8 format, encrypting with \s-1AES-256\s0 and with
one million iterations of the password:

.Vb 1
 openssl pkcs8 -in key.pem -topk8 -v2 aes-256-cbc -iter 1000000 -out pk8.pem
.Ve

<a name="standards"></a>

# Standards

.IX Header "STANDARDS"
Test vectors from this PKCS#5 v2.0 implementation were posted to the
pkcs-tng mailing list using triple \s-1DES, DES\s0 and \s-1RC2\s0 with high iteration
counts, several people confirmed that they could decrypt the private
keys produced and therefore, it can be assumed that the PKCS#5 v2.0
implementation is reasonably accurate at least as far as these
algorithms are concerned.

The format of PKCS#8 \s-1DSA\s0 (and other) private keys is not well documented:
it is hidden away in PKCS#11 v2.01, section 11.9. OpenSSL's default \s-1DSA\s0
PKCS#8 private key format complies with this standard.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
There should be an option that prints out the encryption algorithm
in use and other details such as the iteration count.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**dsa**\|(1), **rsa**\|(1), **genrsa**\|(1),
**gendsa**\|(1)

<a name="history"></a>

# History

.IX Header "HISTORY"
The **-iter** option was added in OpenSSL 1.1.0.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
