# rsautl(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-rsautl, rsautl - RSA utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl rsautl [-help] [-in file] [-out file] [-inkey file] [-keyform PEM|DER|ENGINE] [-pubin] [-certin] [-sign] [-verify] [-encrypt] [-decrypt] [-rand file...] [-writerand file] [-pkcs] [-ssl] [-raw] [-hexdump] [-asn1parse]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **rsautl** command can be used to sign, verify, encrypt and decrypt
data using the \s-1RSA\s0 algorithm.

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
* **-inkey file**  
  .IX Item "-inkey file"
  The input key file, by default it should be an \s-1RSA\s0 private key.
* **-keyform PEM|DER|ENGINE**  
  .IX Item "-keyform PEM|DER|ENGINE"
  The key format \s-1PEM, DER\s0 or \s-1ENGINE.\s0
* **-pubin**  
  .IX Item "-pubin"
  The input file is an \s-1RSA\s0 public key.
* **-certin**  
  .IX Item "-certin"
  The input is a certificate containing an \s-1RSA\s0 public key.
* **-sign**  
  .IX Item "-sign"
  Sign the input data and output the signed result. This requires
  an \s-1RSA\s0 private key.
* **-verify**  
  .IX Item "-verify"
  Verify the input data and output the recovered data.
* **-encrypt**  
  .IX Item "-encrypt"
  Encrypt the input data using an \s-1RSA\s0 public key.
* **-decrypt**  
  .IX Item "-decrypt"
  Decrypt the input data using an \s-1RSA\s0 private key.
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
* **-pkcs, -oaep, -ssl, -raw**  
  .IX Item "-pkcs, -oaep, -ssl, -raw"
  The padding to use: PKCS#1 v1.5 (the default), PKCS#1 \s-1OAEP,\s0
  special padding used in \s-1SSL\s0 v2 backwards compatible handshakes,
  or no padding, respectively.
  For signatures, only **-pkcs** and **-raw** can be used.
* **-hexdump**  
  .IX Item "-hexdump"
  Hex dump the output data.
* **-asn1parse**  
  .IX Item "-asn1parse"
  Parse the \s-1ASN.1\s0 output data, this is useful when combined with the
  **-verify** option.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**rsautl** because it uses the \s-1RSA\s0 algorithm directly can only be
used to sign or verify small pieces of data.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Sign some data using a private key:

.Vb 1
 openssl rsautl -sign -in file -inkey key.pem -out sig
.Ve

Recover the signed data

.Vb 1
 openssl rsautl -verify -in sig -inkey key.pem
.Ve

Examine the raw signed data:

.Vb 1
 openssl rsautl -verify -in sig -inkey key.pem -raw -hexdump

 0000 - 00 01 ff ff ff ff ff ff-ff ff ff ff ff ff ff ff   ................
 0010 - ff ff ff ff ff ff ff ff-ff ff ff ff ff ff ff ff   ................
 0020 - ff ff ff ff ff ff ff ff-ff ff ff ff ff ff ff ff   ................
 0030 - ff ff ff ff ff ff ff ff-ff ff ff ff ff ff ff ff   ................
 0040 - ff ff ff ff ff ff ff ff-ff ff ff ff ff ff ff ff   ................
 0050 - ff ff ff ff ff ff ff ff-ff ff ff ff ff ff ff ff   ................
 0060 - ff ff ff ff ff ff ff ff-ff ff ff ff ff ff ff ff   ................
 0070 - ff ff ff ff 00 68 65 6c-6c 6f 20 77 6f 72 6c 64   .....hello world
.Ve

The PKCS#1 block formatting is evident from this. If this was done using
encrypt and decrypt the block would have been of type 2 (the second byte)
and random padding data visible instead of the 0xff bytes.

It is possible to analyse the signature of certificates using this
utility in conjunction with **asn1parse**. Consider the self signed
example in certs/pca-cert.pem . Running **asn1parse** as follows yields:

.Vb 1
 openssl asn1parse -in pca-cert.pem

    0:d=0  hl=4 l= 742 cons: SEQUENCE
    4:d=1  hl=4 l= 591 cons:  SEQUENCE
    8:d=2  hl=2 l=   3 cons:   cont [ 0 ]
   10:d=3  hl=2 l=   1 prim:    INTEGER           :02
   13:d=2  hl=2 l=   1 prim:   INTEGER           :00
   16:d=2  hl=2 l=  13 cons:   SEQUENCE
   18:d=3  hl=2 l=   9 prim:    OBJECT            :md5WithRSAEncryption
   29:d=3  hl=2 l=   0 prim:    NULL
   31:d=2  hl=2 l=  92 cons:   SEQUENCE
   33:d=3  hl=2 l=  11 cons:    SET
   35:d=4  hl=2 l=   9 cons:     SEQUENCE
   37:d=5  hl=2 l=   3 prim:      OBJECT            :countryName
   42:d=5  hl=2 l=   2 prim:      PRINTABLESTRING   :AU
  ....
  599:d=1  hl=2 l=  13 cons:  SEQUENCE
  601:d=2  hl=2 l=   9 prim:   OBJECT            :md5WithRSAEncryption
  612:d=2  hl=2 l=   0 prim:   NULL
  614:d=1  hl=3 l= 129 prim:  BIT STRING
.Ve

The final \s-1BIT STRING\s0 contains the actual signature. It can be extracted with:

.Vb 1
 openssl asn1parse -in pca-cert.pem -out sig -noout -strparse 614
.Ve

The certificate public key can be extracted with:

.Vb 1
 openssl x509 -in test/testx509.pem -pubkey -noout &gt;pubkey.pem
.Ve

The signature can be analysed with:

.Vb 1
 openssl rsautl -in sig -verify -asn1parse -inkey pubkey.pem -pubin

    0:d=0  hl=2 l=  32 cons: SEQUENCE
    2:d=1  hl=2 l=  12 cons:  SEQUENCE
    4:d=2  hl=2 l=   8 prim:   OBJECT            :md5
   14:d=2  hl=2 l=   0 prim:   NULL
   16:d=1  hl=2 l=  16 prim:  OCTET STRING
      0000 - f3 46 9e aa 1a 4a 73 c9-37 ea 93 00 48 25 08 b5   .F...Js.7...H%..
.Ve

This is the parsed version of an \s-1ASN1\s0 DigestInfo structure. It can be seen that
the digest used was md5. The actual part of the certificate that was signed can
be extracted with:

.Vb 1
 openssl asn1parse -in pca-cert.pem -out tbs -noout -strparse 4
.Ve

and its digest computed with:

.Vb 2
 openssl md5 -c tbs
 MD5(tbs)= f3:46:9e:aa:1a:4a:73:c9:37:ea:93:00:48:25:08:b5
.Ve

which it can be seen agrees with the recovered value above.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**dgst**\|(1), **rsa**\|(1), **genrsa**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
