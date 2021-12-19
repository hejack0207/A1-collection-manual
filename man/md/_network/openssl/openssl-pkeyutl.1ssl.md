# pkeyutl(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-pkeyutl, pkeyutl - public key algorithm utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl pkeyutl [-help] [-in file] [-out file] [-sigfile file] [-inkey file] [-keyform PEM|DER|ENGINE] [-passin arg] [-peerkey file] [-peerform PEM|DER|ENGINE] [-pubin] [-certin] [-rev] [-sign] [-verify] [-verifyrecover] [-encrypt] [-decrypt] [-derive] [-kdf algorithm] [-kdflen length] [-pkeyopt opt:value] [-hexdump] [-asn1parse] [-rand file...] [-writerand file] [-engine id] [-engine_impl]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **pkeyutl** command can be used to perform low-level public key operations
using any supported algorithm.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read data from or standard input
  if this option is not specified.
* **-out filename**  
  .IX Item "-out filename"
  Specifies the output filename to write to or standard output by
  default.
* **-sigfile file**  
  .IX Item "-sigfile file"
  Signature file, required for **verify** operations only
* **-inkey file**  
  .IX Item "-inkey file"
  The input key file, by default it should be a private key.
* **-keyform PEM|DER|ENGINE**  
  .IX Item "-keyform PEM|DER|ENGINE"
  The key format \s-1PEM, DER\s0 or \s-1ENGINE.\s0 Default is \s-1PEM.\s0
* **-passin arg**  
  .IX Item "-passin arg"
  The input key password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-peerkey file**  
  .IX Item "-peerkey file"
  The peer key file, used by key derivation (agreement) operations.
* **-peerform PEM|DER|ENGINE**  
  .IX Item "-peerform PEM|DER|ENGINE"
  The peer key format \s-1PEM, DER\s0 or \s-1ENGINE.\s0 Default is \s-1PEM.\s0
* **-pubin**  
  .IX Item "-pubin"
  The input file is a public key.
* **-certin**  
  .IX Item "-certin"
  The input is a certificate containing a public key.
* **-rev**  
  .IX Item "-rev"
  Reverse the order of the input buffer. This is useful for some libraries
  (such as CryptoAPI) which represent the buffer in little endian format.
* **-sign**  
  .IX Item "-sign"
  Sign the input data (which must be a hash) and output the signed result. This
  requires a private key.
* **-verify**  
  .IX Item "-verify"
  Verify the input data (which must be a hash) against the signature file and
  indicate if the verification succeeded or failed.
* **-verifyrecover**  
  .IX Item "-verifyrecover"
  Verify the input data (which must be a hash) and output the recovered data.
* **-encrypt**  
  .IX Item "-encrypt"
  Encrypt the input data using a public key.
* **-decrypt**  
  .IX Item "-decrypt"
  Decrypt the input data using a private key.
* **-derive**  
  .IX Item "-derive"
  Derive a shared secret using the peer key.
* **-kdf algorithm**  
  .IX Item "-kdf algorithm"
  Use key derivation function **algorithm**.  The supported algorithms are
  at present **\s-1TLS1-PRF\s0** and **\s-1HKDF\s0**.
  Note: additional parameters and the \s-1KDF\s0 output length will normally have to be
  set for this to work.
  See **EVP\_PKEY\_CTX\_set\_hkdf\_md**\|(3) and **EVP\_PKEY\_CTX\_set\_tls1\_prf\_md**\|(3)
  for the supported string parameters of each algorithm.
* **-kdflen length**  
  .IX Item "-kdflen length"
  Set the output length for \s-1KDF.\s0
* **-pkeyopt opt:value**  
  .IX Item "-pkeyopt opt:value"
  Public key options specified as opt:value. See \s-1NOTES\s0 below for more details.
* **-hexdump**  
  .IX Item "-hexdump"
  hex dump the output data.
* **-asn1parse**  
  .IX Item "-asn1parse"
  Parse the \s-1ASN.1\s0 output data, this is useful when combined with the
  **-verifyrecover** option when an \s-1ASN1\s0 structure is signed.
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
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **pkeyutl**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.
* **-engine\_impl**  
  .IX Item "-engine_impl"
  When used with the **-engine** option, it specifies to also use
  engine **id** for crypto operations.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The operations and options supported vary according to the key algorithm
and its implementation. The OpenSSL operations and options are indicated below.

Unless otherwise mentioned all algorithms support the **digest:alg** option
which specifies the digest in use for sign, verify and verifyrecover operations.
The value **alg** should represent a digest name as used in the
**EVP\_get\_digestbyname()** function for example **sha1**. This value is not used to
hash the input data. It is used (by some algorithms) for sanity-checking the
lengths of data passed in to the **pkeyutl** and for creating the structures that
make up the signature (e.g. **DigestInfo** in \s-1RSASSA\s0 PKCS#1 v1.5 signatures).

This utility does not hash the input data but rather it will use the data
directly as input to the signature algorithm. Depending on the key type,
signature type, and mode of padding, the maximum acceptable lengths of input
data differ. The signed data can't be longer than the key modulus with \s-1RSA.\s0 In
case of \s-1ECDSA\s0 and \s-1DSA\s0 the data shouldn't be longer than the field
size, otherwise it will be silently truncated to the field size. In any event
the input size must not be larger than the largest supported digest size.

In other words, if the value of digest is **sha1** the input should be the 20
bytes long binary encoding of the \s-1SHA-1\s0 hash function output.

The Ed25519 and Ed448 signature algorithms are not supported by this utility.
They accept non-hashed input, but this utility can only be used to sign hashed
input.

<a name="rsa-algorithm"></a>

# Rsa Algorithm

.IX Header "RSA ALGORITHM"
The \s-1RSA\s0 algorithm generally supports the encrypt, decrypt, sign,
verify and verifyrecover operations. However, some padding modes
support only a subset of these operations. The following additional
**pkeyopt** values are supported:

* **rsa\_padding\_mode:mode**  
  .IX Item "rsa_padding_mode:mode"
  This sets the \s-1RSA\s0 padding mode. Acceptable values for **mode** are **pkcs1** for
  PKCS#1 padding, **sslv23** for SSLv23 padding, **none** for no padding, **oaep**
  for **\s-1OAEP\s0** mode, **x931** for X9.31 mode and **pss** for \s-1PSS.\s0
  .Sp
  In PKCS#1 padding if the message digest is not set then the supplied data is
  signed or verified directly instead of using a **DigestInfo** structure. If a
  digest is set then the a **DigestInfo** structure is used and its the length
  must correspond to the digest type.
  .Sp
  For **oaep** mode only encryption and decryption is supported.
  .Sp
  For **x931** if the digest type is set it is used to format the block data
  otherwise the first byte is used to specify the X9.31 digest \s-1ID.\s0 Sign,
  verify and verifyrecover are can be performed in this mode.
  .Sp
  For **pss** mode only sign and verify are supported and the digest type must be
  specified.
* **rsa\_pss\_saltlen:len**  
  .IX Item "rsa_pss_saltlen:len"
  For **pss** mode only this option specifies the salt length. Three special
  values are supported: digest\*(R" sets the salt length to the digest length,
  max\*(R" sets the salt length to the maximum permissible value. When verifying
  auto\*(R" causes the salt length to be automatically determined based on the
  **\s-1PSS\s0** block structure.
* **rsa\_mgf1\_md:digest**  
  .IX Item "rsa_mgf1_md:digest"
  For \s-1PSS\s0 and \s-1OAEP\s0 padding sets the \s-1MGF1\s0 digest. If the \s-1MGF1\s0 digest is not
  explicitly set in \s-1PSS\s0 mode then the signing digest is used.

<a name="rsa-pss-algorithm"></a>

# Rsa-Pss Algorithm

.IX Header "RSA-PSS ALGORITHM"
The RSA-PSS algorithm is a restricted version of the \s-1RSA\s0 algorithm which only
supports the sign and verify operations with \s-1PSS\s0 padding. The following
additional **pkeyopt** values are supported:

* **rsa\_padding\_mode:mode**, **rsa\_pss\_saltlen:len**, **rsa\_mgf1\_md:digest**  
  .IX Item "rsa_padding_mode:mode, rsa_pss_saltlen:len, rsa_mgf1_md:digest"
  These have the same meaning as the **\s-1RSA\s0** algorithm with some additional
  restrictions. The padding mode can only be set to **pss** which is the
  default value.
  .Sp
  If the key has parameter restrictions than the digest, \s-1MGF1\s0
  digest and salt length are set to the values specified in the parameters.
  The digest and \s-1MG\s0 cannot be changed and the salt length cannot be set to a
  value less than the minimum restriction.

<a name="dsa-algorithm"></a>

# Dsa Algorithm

.IX Header "DSA ALGORITHM"
The \s-1DSA\s0 algorithm supports signing and verification operations only. Currently
there are no additional **-pkeyopt** options other than **digest**. The \s-1SHA1\s0
digest is assumed by default.

<a name="dh-algorithm"></a>

# Dh Algorithm

.IX Header "DH ALGORITHM"
The \s-1DH\s0 algorithm only supports the derivation operation and no additional
**-pkeyopt** options.

<a name="ec-algorithm"></a>

# Ec Algorithm

.IX Header "EC ALGORITHM"
The \s-1EC\s0 algorithm supports sign, verify and derive operations. The sign and
verify operations use \s-1ECDSA\s0 and derive uses \s-1ECDH. SHA1\s0 is assumed by default for
the **-pkeyopt** **digest** option.

<a name="x25519-and-x448-algorithms"></a>

# X25519 and X448 Algorithms

.IX Header "X25519 and X448 ALGORITHMS"
The X25519 and X448 algorithms support key derivation only. Currently there are
no additional options.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Sign some data using a private key:

.Vb 1
 openssl pkeyutl -sign -in file -inkey key.pem -out sig
.Ve

Recover the signed data (e.g. if an \s-1RSA\s0 key is used):

.Vb 1
 openssl pkeyutl -verifyrecover -in sig -inkey key.pem
.Ve

Verify the signature (e.g. a \s-1DSA\s0 key):

.Vb 1
 openssl pkeyutl -verify -in file -sigfile sig -inkey key.pem
.Ve

Sign data using a message digest value (this is currently only valid for \s-1RSA\s0):

.Vb 1
 openssl pkeyutl -sign -in file -inkey key.pem -out sig -pkeyopt digest:sha256
.Ve

Derive a shared secret value:

.Vb 1
 openssl pkeyutl -derive -inkey key.pem -peerkey pubkey.pem -out secret
.Ve

Hexdump 48 bytes of \s-1TLS1 PRF\s0 using digest **\s-1SHA256\s0** and shared secret and
seed consisting of the single byte 0xFF:

.Vb 2
 openssl pkeyutl -kdf TLS1-PRF -kdflen 48 -pkeyopt md:SHA256 \e
    -pkeyopt hexsecret:ff -pkeyopt hexseed:ff -hexdump
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**genpkey**\|(1), **pkey**\|(1), **rsautl**\|(1)
**dgst**\|(1), **rsa**\|(1), **genrsa**\|(1),
**EVP\_PKEY\_CTX\_set\_hkdf\_md**\|(3), **EVP\_PKEY\_CTX\_set\_tls1\_prf\_md**\|(3)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2006-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
