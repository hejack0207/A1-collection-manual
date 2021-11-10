# evp_kdf_pbkdf2(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

EVP_KDF_PBKDF2 - The PBKDF2 EVP_KDF implementation

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Support for computing the **\s-1PBKDF2\s0** password-based \s-1KDF\s0 through the **\s-1EVP\_KDF\s0**
\s-1API.\s0

The \s-1EVP_KDF_PBKDF2\s0 algorithm implements the \s-1PBKDF2\s0 password-based key
derivation function, as described in \s-1RFC 2898\s0; it derives a key from a password
using a salt and iteration count.

<a name="numeric-identity"></a>

### Numeric identity

.IX Subsection "Numeric identity"
**\s-1EVP\_KDF\_PBKDF2\s0** is the numeric identity for this implementation; it
can be used with the **EVP\_KDF\_CTX\_new\_id()** function.

<a name="supported-controls"></a>

### Supported controls

.IX Subsection "Supported controls"
The supported controls are:

* **\s-1EVP\_KDF\_CTRL\_SET\_PASS\s0**  
  .IX Item "EVP_KDF_CTRL_SET_PASS"
* **\s-1EVP\_KDF\_CTRL\_SET\_SALT\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SALT"
* **\s-1EVP\_KDF\_CTRL\_SET\_ITER\s0**  
  .IX Item "EVP_KDF_CTRL_SET_ITER"
* **\s-1EVP\_KDF\_CTRL\_SET\_MD\s0**  
  .IX Item "EVP_KDF_CTRL_SET_MD"
  These controls work as described in \s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3).
  .Sp
  **iter** is the iteration count and its value should be greater than or equal to
  1. \s-1RFC 2898\s0 suggests an iteration count of at least 1000.  The default value is
  2048.  Any **iter** less than 1 is treated as a single iteration.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
A typical application of this algorithm is to derive keying material for an
encryption algorithm from a password in the **pass**, a salt in **salt**,
and an iteration count.

Increasing the **iter** parameter slows down the algorithm which makes it
harder for an attacker to perform a brute force attack using a large number
of candidate passwords.

No assumption is made regarding the given password; it is simply treated as a
byte sequence.

<a name="conforming-to"></a>

# Conforming to

.IX Header "CONFORMING TO"
\s-1RFC 2898\s0

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
\s-1EVP_KDF_CTX\s0,
**EVP\_KDF\_CTX\_new\_id**\|(3),
**EVP\_KDF\_CTX\_free**\|(3),
**EVP\_KDF\_ctrl**\|(3),
**EVP\_KDF\_derive**\|(3),
\s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the Apache License 2.0 (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
