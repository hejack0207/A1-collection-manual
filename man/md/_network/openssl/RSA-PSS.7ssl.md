# rsa-pss(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

RSA-PSS - EVP_PKEY RSA-PSS algorithm support

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **RSA-PSS** \s-1EVP_PKEY\s0 implementation is a restricted version of the \s-1RSA\s0
algorithm which only supports signing, verification and key generation
using \s-1PSS\s0 padding modes with optional parameter restrictions.

It has associated private key and public key formats.

This algorithm shares several control operations with the **\s-1RSA\s0** algorithm
but with some restrictions described below.

<a name="signing-and-verification"></a>

### Signing and Verification

.IX Subsection "Signing and Verification"
Signing and verification is similar to the **\s-1RSA\s0** algorithm except the
padding mode is always \s-1PSS.\s0 If the key in use has parameter restrictions then
the corresponding signature parameters are set to the restrictions:
for example, if the key can only be used with digest \s-1SHA256, MGF1 SHA256\s0
and minimum salt length 32 then the digest, \s-1MGF1\s0 digest and salt length
will be set to \s-1SHA256, SHA256\s0 and 32 respectively.

<a name="key-generation"></a>

### Key Generation

.IX Subsection "Key Generation"
By default no parameter restrictions are placed on the generated key.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The public key format is documented in \s-1RFC4055.\s0

The PKCS#8 private key format used for RSA-PSS keys is similar to the \s-1RSA\s0
format except it uses the **id-RSASSA-PSS** \s-1OID\s0 and the parameters field, if
present, restricts the key parameters in the same way as the public key.

<a name="conforming-to"></a>

# Conforming to

.IX Header "CONFORMING TO"
\s-1RFC 4055\s0

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**EVP\_PKEY\_CTX\_set\_rsa\_pss\_keygen\_md**\|(3),
**EVP\_PKEY\_CTX\_set\_rsa\_pss\_keygen\_mgf1\_md**\|(3),
**EVP\_PKEY\_CTX\_set\_rsa\_pss\_keygen\_saltlen**\|(3),
**EVP\_PKEY\_CTX\_new**\|(3),
**EVP\_PKEY\_CTX\_ctrl\_str**\|(3),
**EVP\_PKEY\_derive**\|(3)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2017-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
