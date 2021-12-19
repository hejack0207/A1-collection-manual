# evp_kdf_tls1_prf(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

EVP_KDF_TLS1_PRF - The TLS1 PRF EVP_KDF implementation

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Support for computing the **\s-1TLS1\s0** \s-1PRF\s0 through the **\s-1EVP\_KDF\s0** \s-1API.\s0

The \s-1EVP_KDF_TLS1_PRF\s0 algorithm implements the \s-1PRF\s0 used by \s-1TLS\s0 versions up to
and including \s-1TLS 1.2.\s0

<a name="numeric-identity"></a>

### Numeric identity

.IX Subsection "Numeric identity"
**\s-1EVP\_KDF\_TLS1\_PRF\s0** is the numeric identity for this implementation; it
can be used with the **EVP\_KDF\_CTX\_new\_id()** function.

<a name="supported-controls"></a>

### Supported controls

.IX Subsection "Supported controls"
The supported controls are:

* **\s-1EVP\_KDF\_CTRL\_SET\_MD\s0**  
  .IX Item "EVP_KDF_CTRL_SET_MD"
  This control works as described in \s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3).
  .Sp
  The \f(CW`EVP\_KDF\_CTRL\_SET\_MD\*(C' control is used to set the message digest associated
  with the \s-1TLS PRF.\s0  **EVP\_md5\_sha1()** is treated as a special case which uses the
  \s-1PRF\s0 algorithm using both **\s-1MD5\s0** and **\s-1SHA1\s0** as used in \s-1TLS 1.0\s0 and 1.1.
* **\s-1EVP\_KDF\_CTRL\_SET\_TLS\_SECRET\s0**  
  .IX Item "EVP_KDF_CTRL_SET_TLS_SECRET"
  This control expects two arguments: \f(CW`unsigned char *sec\*(C', \f(CW\*(C\`size_t seclen\*(C'
  .Sp
  Sets the secret value of the \s-1TLS PRF\s0 to **seclen** bytes of the buffer **sec**.
  Any existing secret value is replaced.
  .Sp
  **EVP\_KDF\_ctrl\_str()** takes two type strings for this control:
      .ie n .IP """secret""" 4
      .el .IP "\`\`secret''" 4
      .IX Item "secret"
      The value string is used as is.
      .ie n .IP """hexsecret""" 4
      .el .IP "\`\`hexsecret''" 4
      .IX Item "hexsecret"
      The value string is expected to be a hexadecimal number, which will be
      decoded before being passed on as the control value.
* **\s-1EVP\_KDF\_CTRL\_RESET\_TLS\_SEED\s0**  
  .IX Item "EVP_KDF_CTRL_RESET_TLS_SEED"
  This control does not expect any arguments.
  .Sp
  Resets the context seed buffer to zero length.
* **\s-1EVP\_KDF\_CTRL\_ADD\_TLS\_SEED\s0**  
  .IX Item "EVP_KDF_CTRL_ADD_TLS_SEED"
  This control expects two arguments: \f(CW`unsigned char *seed\*(C', \f(CW\*(C\`size_t seedlen\*(C'
  .Sp
  Sets the seed to **seedlen** bytes of **seed**.  If a seed is already set it is
  appended to the existing value.
  .Sp
  The total length of the context seed buffer cannot exceed 1024 bytes;
  this should be more than enough for any normal use of the \s-1TLS PRF.\s0
  .Sp
  **EVP\_KDF\_ctrl\_str()** takes two type strings for this control:
      .ie n .IP """seed""" 4
      .el .IP "\`\`seed''" 4
      .IX Item "seed"
      The value string is used as is.
      .ie n .IP """hexseed""" 4
      .el .IP "\`\`hexseed''" 4
      .IX Item "hexseed"
      The value string is expected to be a hexadecimal number, which will be
      decoded before being passed on as the control value.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
A context for the \s-1TLS PRF\s0 can be obtained by calling:

.Vb 1
 EVP_KDF_CTX *kctx = EVP_KDF_CTX_new_id(EVP_KDF_TLS1_PRF, NULL);
.Ve

The digest, secret value and seed must be set before a key is derived otherwise
an error will occur.

The output length of the \s-1PRF\s0 is specified by the \f(CW`keylen\*(C' parameter to the
**EVP\_KDF\_derive()** function.

<a name="example"></a>

# Example

.IX Header "EXAMPLE"
This example derives 10 bytes using \s-1SHA-256\s0 with the secret key secret\*(R"
and seed value seed\*(R":

.Vb 2
 EVP_KDF_CTX *kctx;
 unsigned char out[10];

 kctx = EVP_KDF_CTX_new_id(EVP_KDF_TLS1_PRF);
 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_MD, EVP_sha256()) &lt;= 0) {
     error("EVP_KDF_CTRL_SET_MD");
 }
 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_TLS_SECRET,
                  "secret", (size_t)6) &lt;= 0) {
     error("EVP_KDF_CTRL_SET_TLS_SECRET");
 }
 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_ADD_TLS_SEED, "seed", (size_t)4) &lt;= 0) {
     error("EVP_KDF_CTRL_ADD_TLS_SEED");
 }
 if (EVP_KDF_derive(kctx, out, sizeof(out)) &lt;= 0) {
     error("EVP_KDF_derive");
 }
 EVP_KDF_CTX_free(kctx);
.Ve

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
