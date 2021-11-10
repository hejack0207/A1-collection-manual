# evp_kdf_krb5kdf(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

EVP_KDF_KRB5KDF - The RFC3961 Krb5 KDF EVP_KDF implementation

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Support for computing the **\s-1KRB5KDF\s0** \s-1KDF\s0 through the **\s-1EVP\_KDF\s0** \s-1API.\s0

The **\s-1EVP\_KDF\_KRB5KDF\s0** algorithm implements the key derivation function defined
in \s-1RFC 3961,\s0 section 5.1 and is used by Krb5 to derive session keys.
Three inputs are required to perform key derivation: a cipher, (for example
\s-1AES-128-CBC\s0), the initial key, and a constant.

<a name="numeric-identity"></a>

### Numeric identity

.IX Subsection "Numeric identity"
**\s-1EVP\_KDF\_KRB5KDF\s0** is the numeric identity for this implementation; it can be used with the
**EVP\_KDF\_CTX\_new\_id()** function.

<a name="supported-controls"></a>

### Supported controls

.IX Subsection "Supported controls"
The supported controls are:

* **\s-1EVP\_KDF\_CTRL\_SET\_CIPHER\s0**  
  .IX Item "EVP_KDF_CTRL_SET_CIPHER"
* **\s-1EVP\_KDF\_CTRL\_SET\_KEY\s0**  
  .IX Item "EVP_KDF_CTRL_SET_KEY"
  These controls work as described in \s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3).
* **\s-1EVP\_KDF\_CTRL\_SET\_KRB5KDF\_CONSTANT\s0**  
  .IX Item "EVP_KDF_CTRL_SET_KRB5KDF_CONSTANT"
  This control expects two arguments: \f(CW`unsigned char *constant\*(C', \f(CW\*(C\`size_t constantlen\*(C'
  .Sp
  This control sets the _constant_ value for the \s-1KDF.\s0
  If a value is already set, the contents are replaced.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
A context for \s-1KRB5KDF\s0 can be obtained by calling:

.Vb 1
 EVP_KDF_CTX *kctx = EVP_KDF_CTX_new_id(EVP_KDF_KRB5KDF);
.Ve

The output length of the \s-1KRB5KDF\s0 derivation is specified via the _keylen_
parameter to the **EVP\_KDF\_derive**\|(3) function, and \s-1MUST\s0 match the key
length for the chosen cipher or an error is returned. Moreover the
_constant_'s length must not exceed the block size of the cipher.
Since the \s-1KRB5KDF\s0 output length depends on the chosen cipher, calling
**EVP\_KDF\_size()** to obtain the requisite length returns the correct length
only after the cipher is set. Prior to that **\s-1EVP\_MAX\_KEY\_LENGTH\s0** is returned.
The caller must allocate a buffer of the correct length for the chosen
cipher, and pass that buffer to the **EVP\_KDF\_derive**\|(3) function along
with that length.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
This example derives a key using the \s-1AES-128-CBC\s0 cipher:

.Vb 5
 EVP_KDF_CTX *kctx;
 unsigned char key[16] = "01234...";
 unsigned char constant[] = "Im a constant";
 unsigned char out[16];
 size_t outlen = sizeof(out);

 kctx = EVP_KDF_CTX_new_id(EVP_KDF_KRB5KDF);

 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_CIPHER, EVP_aes_128_cbc());
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KEY, key, (size_t)16);
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KRB5KDF_CONSTANT, constant, strlen(constant));
 if (EVP_KDF_derive(kctx, out, outlen) &lt;= 0)
     /* Error */
 EVP_KDF_CTX_free(kctx);
.Ve

<a name="conforming-to"></a>

# Conforming to

.IX Header "CONFORMING TO"
\s-1RFC 3961\s0

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
\s-1**EVP\_KDF\_CTX\s0**\|(3),
**EVP\_KDF\_CTX\_new\_id**\|(3),
**EVP\_KDF\_CTX\_free**\|(3),
**EVP\_KDF\_ctrl**\|(3),
**EVP\_KDF\_size**\|(3),
**EVP\_KDF\_derive**\|(3),
\s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3)

<a name="history"></a>

# History

.IX Header "HISTORY"
This functionality was added to OpenSSL 3.0.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2016-2019 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
