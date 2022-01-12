# evp_kdf_scrypt(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

EVP_KDF_SCRYPT - The scrypt EVP_KDF implementation

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Support for computing the **scrypt** password-based \s-1KDF\s0 through the **\s-1EVP\_KDF\s0**
\s-1API.\s0

The \s-1EVP_KDF_SCRYPT\s0 algorithm implements the scrypt password-based key
derivation function, as described in \s-1RFC 7914.\s0  It is memory-hard in the sense
that it deliberately requires a significant amount of \s-1RAM\s0 for efficient
computation. The intention of this is to render brute forcing of passwords on
systems that lack large amounts of main memory (such as GPUs or ASICs)
computationally infeasible.

scrypt provides three work factors that can be customized: N, r and p. N, which
has to be a positive power of two, is the general work factor and scales \s-1CPU\s0
time in an approximately linear fashion. r is the block size of the internally
used hash function and p is the parallelization factor. Both r and p need to be
greater than zero. The amount of \s-1RAM\s0 that scrypt requires for its computation
is roughly (128 * N * r * p) bytes.

In the original paper of Colin Percival (Stronger Key Derivation via
Sequential Memory-Hard Functions, 2009), the suggested values that give a
computation time of less than 5 seconds on a 2.5 GHz Intel Core 2 Duo are N =
2^20 = 1048576, r = 8, p = 1. Consequently, the required amount of memory for
this computation is roughly 1 GiB. On a more recent \s-1CPU\s0 (Intel i7-5930K at 3.5
GHz), this computation takes about 3 seconds. When N, r or p are not specified,
they default to 1048576, 8, and 1, respectively. The maximum amount of \s-1RAM\s0 that
may be used by scrypt defaults to 1025 MiB.

<a name="numeric-identity"></a>

### Numeric identity

.IX Subsection "Numeric identity"
**\s-1EVP\_KDF\_SCRYPT\s0** is the numeric identity for this implementation; it
can be used with the **EVP\_KDF\_CTX\_new\_id()** function.

<a name="supported-controls"></a>

### Supported controls

.IX Subsection "Supported controls"
The supported controls are:

* **\s-1EVP\_KDF\_CTRL\_SET\_PASS\s0**  
  .IX Item "EVP_KDF_CTRL_SET_PASS"
* **\s-1EVP\_KDF\_CTRL\_SET\_SALT\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SALT"
  These controls work as described in \s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3).
* **\s-1EVP\_KDF\_CTRL\_SET\_SCRYPT\_N\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SCRYPT_N"
* **\s-1EVP\_KDF\_CTRL\_SET\_SCRYPT\_R\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SCRYPT_R"
* **\s-1EVP\_KDF\_CTRL\_SET\_SCRYPT\_P\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SCRYPT_P"
  **\s-1EVP\_KDF\_CTRL\_SET\_SCRYPT\_N\s0** expects one argument: \f(CW`uint64_t N\*(C'
  .Sp
  **\s-1EVP\_KDF\_CTRL\_SET\_SCRYPT\_R\s0** expects one argument: \f(CW`uint32_t r\*(C'
  .Sp
  **\s-1EVP\_KDF\_CTRL\_SET\_SCRYPT\_P\s0** expects one argument: \f(CW`uint32_t p\*(C'
  .Sp
  These controls configure the scrypt work factors N, r and p.
  .Sp
  **EVP\_KDF\_ctrl\_str()** type strings: N\*(R", \*(L"r\*(R" and \*(L"p\*(R", respectively.
  .Sp
  The corresponding value strings are expected to be decimal numbers.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
A context for scrypt can be obtained by calling:

.Vb 1
 EVP_KDF_CTX *kctx = EVP_KDF_CTX_new_id(EVP_KDF_SCRYPT);
.Ve

The output length of an scrypt key derivation is specified via the
**keylen** parameter to the **EVP\_KDF\_derive**\|(3) function.

<a name="example"></a>

# Example

.IX Header "EXAMPLE"
This example derives a 64-byte long test vector using scrypt with the password
password\*(R", salt \*(L"NaCl\*(R" and N = 1024, r = 8, p = 16.

.Vb 2
 EVP_KDF_CTX *kctx;
 unsigned char out[64];

 kctx = EVP_KDF_CTX_new_id(EVP_KDF_SCRYPT);

 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_PASS, "password", (size_t)8) &lt;= 0) {
     error("EVP_KDF_CTRL_SET_PASS");
 }
 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_SALT, "NaCl", (size_t)4) &lt;= 0) {
     error("EVP_KDF_CTRL_SET_SALT");
 }
 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_SCRYPT_N, (uint64_t)1024) &lt;= 0) {
     error("EVP_KDF_CTRL_SET_SCRYPT_N");
 }
 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_SCRYPT_R, (uint32_t)8) &lt;= 0) {
     error("EVP_KDF_CTRL_SET_SCRYPT_R");
 }
 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_SCRYPT_P, (uint32_t)16) &lt;= 0) {
     error("EVP_KDF_CTRL_SET_SCRYPT_P");
 }
 if (EVP_KDF_derive(kctx, out, sizeof(out)) &lt;= 0) {
     error("EVP_KDF_derive");
 }

 {
     const unsigned char expected[sizeof(out)] = {
         0xfd, 0xba, 0xbe, 0x1c, 0x9d, 0x34, 0x72, 0x00,
         0x78, 0x56, 0xe7, 0x19, 0x0d, 0x01, 0xe9, 0xfe,
         0x7c, 0x6a, 0xd7, 0xcb, 0xc8, 0x23, 0x78, 0x30,
         0xe7, 0x73, 0x76, 0x63, 0x4b, 0x37, 0x31, 0x62,
         0x2e, 0xaf, 0x30, 0xd9, 0x2e, 0x22, 0xa3, 0x88,
         0x6f, 0xf1, 0x09, 0x27, 0x9d, 0x98, 0x30, 0xda,
         0xc7, 0x27, 0xaf, 0xb9, 0x4a, 0x83, 0xee, 0x6d,
         0x83, 0x60, 0xcb, 0xdf, 0xa2, 0xcc, 0x06, 0x40
     };

     assert(!memcmp(out, expected, sizeof(out)));
 }

 EVP_KDF_CTX_free(kctx);
.Ve

<a name="conforming-to"></a>

# Conforming to

.IX Header "CONFORMING TO"
\s-1RFC 7914\s0

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
Copyright 2017-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
