# crypto(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

crypto - OpenSSL cryptographic library

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" See the individual manual pages for details.
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The OpenSSL **crypto** library implements a wide range of cryptographic
algorithms used in various Internet standards. The services provided
by this library are used by the OpenSSL implementations of \s-1SSL, TLS\s0
and S/MIME, and they have also been used to implement \s-1SSH,\s0 OpenPGP, and
other cryptographic standards.

**libcrypto** consists of a number of sub-libraries that implement the
individual algorithms.

The functionality includes symmetric encryption, public key
cryptography and key agreement, certificate handling, cryptographic
hash functions, cryptographic pseudo-random number generator, and
various utilities.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
Some of the newer functions follow a naming convention using the numbers
**0** and **1**. For example the functions:

.Vb 2
 int X509_CRL_add0_revoked(X509_CRL *crl, X509_REVOKED *rev);
 int X509_add1_trust_object(X509 *x, const ASN1_OBJECT *obj);
.Ve

The **0** version uses the supplied structure pointer directly
in the parent and it will be freed up when the parent is freed.
In the above example **crl** would be freed but **rev** would not.

The **1** function uses a copy of the supplied structure pointer
(or in some cases increases its link count) in the parent and
so both (**x** and **obj** above) should be freed up.

<a name="return-values"></a>

# Return Values

.IX Header "RETURN VALUES"
See the individual manual pages for details.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**openssl**\|(1), **ssl**\|(7)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2016 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
