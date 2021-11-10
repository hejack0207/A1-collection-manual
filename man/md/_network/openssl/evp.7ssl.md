# evp(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

evp - high-level cryptographic functions

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  #include <openssl/evp.h> .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The \s-1EVP\s0 library provides a high-level interface to cryptographic
functions.

The **EVP\_Seal**_\s-1XXX\s0_ and **EVP\_Open**_\s-1XXX\s0_
functions provide public key encryption and decryption to implement digital envelopes\*(R".

The **EVP\_DigestSign**_\s-1XXX\s0_ and
**EVP\_DigestVerify**_\s-1XXX\s0_ functions implement
digital signatures and Message Authentication Codes (MACs). Also see the older
**EVP\_Sign**_\s-1XXX\s0_ and **EVP\_Verify**_\s-1XXX\s0_
functions.

Symmetric encryption is available with the **EVP\_Encrypt**_\s-1XXX\s0_
functions.  The **EVP\_Digest**_\s-1XXX\s0_ functions provide message digests.

The **\s-1EVP\_PKEY\s0**_\s-1XXX\s0_ functions provide a high-level interface to
asymmetric algorithms. To create a new \s-1EVP_PKEY\s0 see
**EVP\_PKEY\_new**\|(3). EVP_PKEYs can be associated
with a private key of a particular algorithm by using the functions
described on the **EVP\_PKEY\_set1\_RSA**\|(3) page, or
new keys can be generated using **EVP\_PKEY\_keygen**\|(3).
EVP_PKEYs can be compared using **EVP\_PKEY\_cmp**\|(3), or printed using
**EVP\_PKEY\_print\_private**\|(3).

The \s-1EVP_PKEY\s0 functions support the full range of asymmetric algorithm operations:

* For key agreement see **EVP\_PKEY\_derive**\|(3)  
  .IX Item "For key agreement see EVP_PKEY_derive"
* For signing and verifying see **EVP\_PKEY\_sign**\|(3), **EVP\_PKEY\_verify**\|(3) and **EVP\_PKEY\_verify\_recover**\|(3). However, note that these functions do not perform a digest of the data to be signed. Therefore, normally you would use the **EVP\_DigestSignInit**\|(3) functions for this purpose.  
  .IX Item "For signing and verifying see EVP_PKEY_sign, EVP_PKEY_verify and EVP_PKEY_verify_recover. However, note that these functions do not perform a digest of the data to be signed. Therefore, normally you would use the EVP_DigestSignInit functions for this purpose."
  .ie n .IP "For encryption and decryption see **EVP\_PKEY\_encrypt**\|(3) and **EVP\_PKEY\_decrypt**\|(3) respectively. However, note that these functions perform encryption and decryption only. As public key encryption is an expensive operation, normally you would wrap an encrypted message in a ""digital envelope"" using the **EVP\_SealInit**\|(3) and **EVP\_OpenInit**\|(3) functions." 4
  .el .IP "For encryption and decryption see **EVP\_PKEY\_encrypt**\|(3) and **EVP\_PKEY\_decrypt**\|(3) respectively. However, note that these functions perform encryption and decryption only. As public key encryption is an expensive operation, normally you would wrap an encrypted message in a \`\`digital envelope'' using the **EVP\_SealInit**\|(3) and **EVP\_OpenInit**\|(3) functions." 4
  .IX Item "For encryption and decryption see EVP_PKEY_encrypt and EVP_PKEY_decrypt respectively. However, note that these functions perform encryption and decryption only. As public key encryption is an expensive operation, normally you would wrap an encrypted message in a digital envelope using the EVP_SealInit and EVP_OpenInit functions."

The **EVP\_BytesToKey**\|(3) function provides some limited support for password
based encryption. Careful selection of the parameters will provide a PKCS#5 \s-1PBKDF1\s0 compatible
implementation. However, new applications should not typically use this (preferring, for example,
\s-1PBKDF2\s0 from PCKS#5).

The **EVP\_Encode**_\s-1XXX\s0_ and
**EVP\_Decode**_\s-1XXX\s0_ functions implement base 64 encoding
and decoding.

All the symmetric algorithms (ciphers), digests and asymmetric algorithms
(public key algorithms) can be replaced by \s-1ENGINE\s0 modules providing alternative
implementations. If \s-1ENGINE\s0 implementations of ciphers or digests are registered
as defaults, then the various \s-1EVP\s0 functions will automatically use those
implementations automatically in preference to built in software
implementations. For more information, consult the **engine**\|(3) man page.

Although low-level algorithm specific functions exist for many algorithms
their use is discouraged. They cannot be used with an \s-1ENGINE\s0 and \s-1ENGINE\s0
versions of new algorithms cannot be accessed using the low-level functions.
Also makes code harder to adapt to new algorithms and some options are not
cleanly supported at the low-level and some operations are more efficient
using the high-level interface.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**EVP\_DigestInit**\|(3),
**EVP\_EncryptInit**\|(3),
**EVP\_OpenInit**\|(3),
**EVP\_SealInit**\|(3),
**EVP\_DigestSignInit**\|(3),
**EVP\_SignInit**\|(3),
**EVP\_VerifyInit**\|(3),
**EVP\_EncodeInit**\|(3),
**EVP\_PKEY\_new**\|(3),
**EVP\_PKEY\_set1\_RSA**\|(3),
**EVP\_PKEY\_keygen**\|(3),
**EVP\_PKEY\_print\_private**\|(3),
**EVP\_PKEY\_decrypt**\|(3),
**EVP\_PKEY\_encrypt**\|(3),
**EVP\_PKEY\_sign**\|(3),
**EVP\_PKEY\_verify**\|(3),
**EVP\_PKEY\_verify\_recover**\|(3),
**EVP\_PKEY\_derive**\|(3),
**EVP\_BytesToKey**\|(3),
**ENGINE\_by\_id**\|(3)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
