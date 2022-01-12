# evp_kdf_kb(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

EVP_KDF_KB - The Key-Based EVP_KDF implementation

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The \s-1EVP_KDF_KB\s0 algorithm implements the Key-Based key derivation function
(\s-1KBKDF\s0).  \s-1KBKDF\s0 derives a key from repeated application of a keyed \s-1MAC\s0 to an
input secret (and other optional values).

<a name="numeric-identity"></a>

### Numeric identity

.IX Subsection "Numeric identity"
**\s-1EVP\_KDF\_KB\s0** is the numeric identity for this implementation; it can be used with the
**EVP\_KDF\_CTX\_new\_id()** function.

<a name="supported-controls"></a>

### Supported controls

.IX Subsection "Supported controls"
The supported controls are:

* **\s-1EVP\_KDF\_CTRL\_SET\_KB\_MODE\s0**  
  .IX Item "EVP_KDF_CTRL_SET_KB_MODE"
  This control expects one argument: \f(CW`int mode\*(C'
  .Sp
  Sets the mode for the \s-1KBKDF\s0 operation. There are two supported modes:
    * **\s-1EVP\_KDF\_KB\_MODE\_COUNTER\s0**  
      .IX Item "EVP_KDF_KB_MODE_COUNTER"
      The counter mode of \s-1KBKDF\s0 should be used. This is the default.
    * **\s-1EVP\_KDF\_KB\_MODE\_FEEDBACK\s0**  
      .IX Item "EVP_KDF_KB_MODE_FEEDBACK"
      The feedback mode of \s-1KBKDF\s0 should be used.
* **\s-1EVP\_KDF\_CTRL\_SET\_KB\_MAC\_TYPE\s0**  
  .IX Item "EVP_KDF_CTRL_SET_KB_MAC_TYPE"
  This control expects one argument: \f(CW`int mac\_type\*(C'
  .Sp
  Sets the mac type for the \s-1KBKDF\s0 operation. There are two supported mac types:
    * **\s-1EVP\_KDF\_KB\_MAC\_TYPE\_HMAC\s0**  
      .IX Item "EVP_KDF_KB_MAC_TYPE_HMAC"
      The \s-1HMAC\s0 with the digest set by **\s-1EVP\_KDF\_CTRL\_SET\_MD\s0** should be used as the mac.
    * **\s-1EVP\_KDF\_KB\_MAC\_TYPE\_CMAC\s0**  
      .IX Item "EVP_KDF_KB_MAC_TYPE_CMAC"
      The \s-1CMAC\s0 with the cipher set by **\s-1EVP\_KDF\_CTRL\_SET\_CIPHER\s0** should be used as the mac.
* **\s-1EVP\_KDF\_CTRL\_SET\_MD\s0**  
  .IX Item "EVP_KDF_CTRL_SET_MD"
* **\s-1EVP\_KDF\_CTRL\_SET\_CIPHER\s0**  
  .IX Item "EVP_KDF_CTRL_SET_CIPHER"
* **\s-1EVP\_KDF\_CTRL\_SET\_KEY\s0**  
  .IX Item "EVP_KDF_CTRL_SET_KEY"
* **\s-1EVP\_KDF\_CTRL\_SET\_SALT\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SALT"
  These controls work as described in \s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3).
* **\s-1EVP\_KDF\_CTRL\_SET\_KB\_INFO\s0**  
  .IX Item "EVP_KDF_CTRL_SET_KB_INFO"
  This control expects two arguments: \f(CW`unsigned char *info\*(C', \f(CW\*(C\`size_t infolen\*(C'
* **\s-1EVP\_KDF\_CTRL\_SET\_KB\_SEED\s0**  
  .IX Item "EVP_KDF_CTRL_SET_KB_SEED"
  This control expects two arguments: \f(CW`unsigned char *seed\*(C', \f(CW\*(C\`size_t seedlen\*(C'
  .Sp
  It is used only in the feedback mode and the length must be the same
  as the block length of the cipher in \s-1CMAC\s0 or the size of the digest in \s-1HMAC.\s0

The controls **\s-1EVP\_KDF\_CTRL\_SET\_KEY\s0**, **\s-1EVP\_KDF\_CTRL\_SET\_SALT\s0**,
**\s-1EVP\_KDF\_CTRL\_SET\_KB\_INFO\s0**, and **\s-1EVP\_KDF\_CTRL\_SET\_KB\_SEED\s0** 
correspond to \s-1KI,\s0 Label, Context, and \s-1IV\s0 (respectively) in \s-1SP800-108.\s0
As in that document, salt, info, and seed are optional and may be
omitted.

Depending on whether mac is \s-1CMAC\s0 or \s-1HMAC,\s0 either digest or cipher is
required (respectively) and the other is unused.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
A context for \s-1KBKDF\s0 can be obtained by calling:

.Vb 1
 EVP_KDF_CTX *kctx = EVP_KDF_CTX_new_id(EVP_KDF_KB);
.Ve

The output length of an \s-1KBKDF\s0 is specified via the \f(CW`keylen\*(C'
parameter to the **EVP\_KDF\_derive**\|(3) function.

Note that currently OpenSSL only implements counter and feedback modes.  Other
variants may be supported in the future.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
This example derives 10 bytes using \s-1COUNTER-HMAC-SHA256,\s0 with \s-1KI\s0 secret\*(R",
Label label\*(R", and Context \*(L"context\*(R".

.Vb 2
 EVP_KDF_CTX *kctx;
 unsigned char out[10];

 kctx = EVP_KDF_CTX_new_id(EVP_KDF_KB);

 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_MD, EVP_sha256());
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KB_MAC_TYPE, EVP_KDF_KB_MAC_TYPE_HMAC);
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KEY, "secret", strlen("secret"));
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_SALT, "label", strlen("label"));
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KB_INFO, "context", strlen("context"));
 if (EVP_KDF_derive(kctx, out, sizeof(out)) &lt;= 0)
     error("EVP_KDF_derive");

 EVP_KDF_CTX_free(kctx);
.Ve

This example derives 10 bytes using \s-1FEEDBACK-CMAC-AES256,\s0 with \s-1KI\s0 secret\*(R",
Label label\*(R", Context \*(L"context\*(R", and \s-1IV\s0 \*(L"sixteen bytes iv\*(R".

.Vb 3
 EVP_KDF_CTX *kctx;
 unsigned char out[10];
 unsigned char *iv = "sixteen bytes iv";

 kctx = EVP_KDF_CTX_new_id(EVP_KDF_KB);

 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_CIPHER, EVP_aes_256_cbc());
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KB_MAC_TYPE, EVP_KDF_KB_MAC_TYPE_CMAC);
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KB_MODE, EVP_KDF_KB_MODE_FEEDBACK);
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KEY, "secret", strlen("secret"));
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_SALT, "label", strlen("label"));
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KB_INFO, "context", strlen("context"));
 EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KB_SEED, iv, strlen(iv));
 if (EVP_KDF_derive(kctx, out, sizeof(out)) &lt;= 0)
     error("EVP_KDF_derive");

 EVP_KDF_CTX_free(kctx);
.Ve

<a name="conforming-to"></a>

# Conforming to

.IX Header "CONFORMING TO"
\s-1NIST SP800-108, IETF RFC 6803, IETF RFC 8009.\s0

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
Copyright 2019 The OpenSSL Project Authors. All Rights Reserved.
Copyright 2019 Red Hat, Inc.

Licensed under the Apache License 2.0 (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
