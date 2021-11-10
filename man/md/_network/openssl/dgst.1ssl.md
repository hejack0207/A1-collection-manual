# dgst(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-dgst, dgst - perform digest operations

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl dgst [-\f(BIdigest] [-help] [-c] [-d] [-list] [-hex] [-binary] [-r] [-out filename] [-sign filename] [-keyform arg] [-passin arg] [-verify filename] [-prverify filename] [-signature filename] [-sigopt nm:v] [-hmac key] [-fips-fingerprint] [-rand file...] [-engine id] [-engine_impl] [file...] 
 openssl digest [...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The digest functions output the message digest of a supplied file or files
in hexadecimal.  The digest functions also generate and verify digital
signatures using message digests.

The generic name, **dgst**, may be used with an option specifying the
algorithm to be used.
The default digest is _sha256_.
A supported _digest_ name may also be used as the command name.
To see the list of supported algorithms, use the _list --digest-commands_
command.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-\f(BIdigest**  
  .IX Item "-digest"
  Specifies name of a supported digest to be used. To see the list of
  supported digests, use the command _list --digest-commands_.
* **-c**  
  .IX Item "-c"
  Print out the digest in two digit groups separated by colons, only relevant if
  **hex** format output is used.
* **-d**  
  .IX Item "-d"
  Print out \s-1BIO\s0 debugging information.
* **-list**  
  .IX Item "-list"
  Prints out a list of supported message digests.
* **-hex**  
  .IX Item "-hex"
  Digest is to be output as a hex dump. This is the default case for a normal\*(R"
  digest as opposed to a digital signature.  See \s-1NOTES\s0 below for digital
  signatures using **-hex**.
* **-binary**  
  .IX Item "-binary"
  Output the digest or signature in binary form.
* **-r**  
  .IX Item "-r"
  Output the digest in the coreutils\*(R" format, including newlines.
  Used by programs like **sha1sum**.
* **-out filename**  
  .IX Item "-out filename"
  Filename to output to, or standard output by default.
* **-sign filename**  
  .IX Item "-sign filename"
  Digitally sign the digest using the private key in filename\*(R". Note this option
  does not support Ed25519 or Ed448 private keys.
* **-keyform arg**  
  .IX Item "-keyform arg"
  Specifies the key format to sign digest with. The \s-1DER, PEM, P12,\s0
  and \s-1ENGINE\s0 formats are supported.
* **-sigopt nm:v**  
  .IX Item "-sigopt nm:v"
  Pass options to the signature algorithm during sign or verify operations.
  Names and values of these options are algorithm-specific.
* **-passin arg**  
  .IX Item "-passin arg"
  The private key password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-verify filename**  
  .IX Item "-verify filename"
  Verify the signature using the public key in filename\*(R".
  The output is either Verification \s-1OK\*(R"\s0 or \*(L"Verification Failure\*(R".
* **-prverify filename**  
  .IX Item "-prverify filename"
  Verify the signature using the private key in filename\*(R".
* **-signature filename**  
  .IX Item "-signature filename"
  The actual signature to verify.
* **-hmac key**  
  .IX Item "-hmac key"
  Create a hashed \s-1MAC\s0 using key\*(R".
* **-mac alg**  
  .IX Item "-mac alg"
  Create \s-1MAC\s0 (keyed Message Authentication Code). The most popular \s-1MAC\s0
  algorithm is \s-1HMAC\s0 (hash-based \s-1MAC\s0), but there are other \s-1MAC\s0 algorithms
  which are not based on hash, for instance **gost-mac** algorithm,
  supported by **ccgost** engine. \s-1MAC\s0 keys and other options should be set
  via **-macopt** parameter.
* **-macopt nm:v**  
  .IX Item "-macopt nm:v"
  Passes options to \s-1MAC\s0 algorithm, specified by **-mac** key.
  Following options are supported by both by **\s-1HMAC\s0** and **gost-mac**:
    * **key:string**  
      .IX Item "key:string"
      Specifies \s-1MAC\s0 key as alphanumeric string (use if key contain printable
      characters only). String length must conform to any restrictions of
      the \s-1MAC\s0 algorithm for example exactly 32 chars for gost-mac.
    * **hexkey:string**  
      .IX Item "hexkey:string"
      Specifies \s-1MAC\s0 key in hexadecimal form (two hex digits per byte).
      Key length must conform to any restrictions of the \s-1MAC\s0 algorithm
      for example exactly 32 chars for gost-mac.
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
* **-fips-fingerprint**  
  .IX Item "-fips-fingerprint"
  Compute \s-1HMAC\s0 using a specific key for certain OpenSSL-FIPS operations.
* **-engine id**  
  .IX Item "-engine id"
  Use engine **id** for operations (including private key storage).
  This engine is not used as source for digest algorithms, unless it is
  also specified in the configuration file or **-engine\_impl** is also
  specified.
* **-engine\_impl**  
  .IX Item "-engine_impl"
  When used with the **-engine** option, it specifies to also use
  engine **id** for digest operations.
* **file...**  
  .IX Item "file..."
  File or files to digest. If no files are specified then standard input is
  used.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To create a hex-encoded message digest of a file:
 openssl dgst -md5 -hex file.txt

To sign a file using \s-1SHA-256\s0 with binary file output:
 openssl dgst -sha256 -sign privatekey.pem -out signature.sign file.txt

To verify a signature:
 openssl dgst -sha256 -verify publickey.pem \e
 -signature signature.sign \e
 file.txt

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The digest mechanisms that are available will depend on the options
used when building OpenSSL.
The **list digest-commands** command can be used to list them.

New or agile applications should use probably use \s-1SHA-256.\s0 Other digests,
particularly \s-1SHA-1\s0 and \s-1MD5,\s0 are still widely used for interoperating
with existing formats and protocols.

When signing a file, **dgst** will automatically determine the algorithm
(\s-1RSA, ECC,\s0 etc) to use for signing based on the private key's \s-1ASN.1\s0 info.
When verifying signatures, it only handles the \s-1RSA, DSA,\s0 or \s-1ECDSA\s0 signature
itself, not the related data to identify the signer and algorithm used in
formats such as x.509, \s-1CMS,\s0 and S/MIME.

A source of random numbers is required for certain signing algorithms, in
particular \s-1ECDSA\s0 and \s-1DSA.\s0

The signing and verify options should only be used if a single file is
being signed or verified.

Hex signatures cannot be verified using **openssl**.  Instead, use xxd -r\*(R"
or similar program to transform the hex signature into a binary signature
prior to verification.

<a name="history"></a>

# History

.IX Header "HISTORY"
The default digest was changed from \s-1MD5\s0 to \s-1SHA256\s0 in OpenSSL 1.1.0.
The FIPS-related options were removed in OpenSSL 1.1.0.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
