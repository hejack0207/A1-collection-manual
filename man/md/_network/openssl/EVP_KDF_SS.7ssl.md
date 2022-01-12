# evp_kdf_ss(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

EVP_KDF_SS - The Single Step / One Step EVP_KDF implementation

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The \s-1EVP_KDF_SS\s0 algorithm implements the Single Step key derivation function (\s-1SSKDF\s0).
\s-1SSKDF\s0 derives a key using input such as a shared secret key (that was generated
during the execution of a key establishment scheme) and fixedinfo.
\s-1SSKDF\s0 is also informally referred to as 'Concat \s-1KDF\s0'.

<a name="auxilary-function"></a>

### Auxilary function

.IX Subsection "Auxilary function"
The implementation uses a selectable auxiliary function H, which can be in the
backported version only a:

* **H(x) = hash(x, digest=md)**  
  .IX Item "H(x) = hash(x, digest=md)"

<a name="numeric-identity"></a>

### Numeric identity

.IX Subsection "Numeric identity"
**\s-1EVP\_KDF\_SS\s0** is the numeric identity for this implementation; it
can be used with the **EVP\_KDF\_CTX\_new\_id()** function.

<a name="supported-controls"></a>

### Supported controls

.IX Subsection "Supported controls"
The supported controls are:

* **\s-1EVP\_KDF\_CTRL\_SET\_MD\s0**  
  .IX Item "EVP_KDF_CTRL_SET_MD"
  This control works as described in \s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3).
* **\s-1EVP\_KDF\_CTRL\_SET\_KEY\s0**  
  .IX Item "EVP_KDF_CTRL_SET_KEY"
  This control expects two arguments: \f(CW`unsigned char *secret\*(C', \f(CW\*(C\`size_t secretlen\*(C'
  .Sp
  The shared secret used for key derivation.  This control sets the secret.
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
* **\s-1EVP\_KDF\_CTRL\_SET\_SSKDF\_INFO\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SSKDF_INFO"
  This control expects two arguments: \f(CW`unsigned char *info\*(C', \f(CW\*(C\`size_t infolen\*(C'
  .Sp
  An optional value for fixedinfo, also known as otherinfo. This control sets the fixedinfo.
  .Sp
  **EVP\_KDF\_ctrl\_str()** takes two type strings for this control:
      .ie n .IP """info""" 4
      .el .IP "\`\`info''" 4
      .IX Item "info"
      The value string is used as is.
      .ie n .IP """hexinfo""" 4
      .el .IP "\`\`hexinfo''" 4
      .IX Item "hexinfo"
      The value string is expected to be a hexadecimal number, which will be
      decoded before being passed on as the control value.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
A context for \s-1SSKDF\s0 can be obtained by calling:

\s-1EVP_KDF_CTX\s0 *kctx = EVP_KDF_CTX_new_id(\s-1EVP_KDF_SS\s0);

The output length of an \s-1SSKDF\s0 is specified via the \f(CW`keylen\*(C'
parameter to the **EVP\_KDF\_derive**\|(3) function.

<a name="example"></a>

# Example

.IX Header "EXAMPLE"
This example derives 10 bytes using H(x) = \s-1SHA-256,\s0 with the secret key secret\*(R"
and fixedinfo value label\*(R":

.Vb 2
  EVP_KDF_CTX *kctx;
  unsigned char out[10];

  kctx = EVP_KDF_CTX_new_id(EVP_KDF_SS);

  if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_MD, EVP_sha256()) &lt;= 0) {
      error("EVP_KDF_CTRL_SET_MD");
  }
  if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KEY, "secret", (size_t)6) &lt;= 0) {
      error("EVP_KDF_CTRL_SET_KEY");
  }
  if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_SSKDF_INFO, "label", (size_t)5) &lt;= 0) {
      error("EVP_KDF_CTRL_SET_SSKDF_INFO");
  }
  if (EVP_KDF_derive(kctx, out, sizeof(out)) &lt;= 0) {
      error("EVP_KDF_derive");
  }

  EVP_KDF_CTX_free(kctx);
.Ve

<a name="conforming-to"></a>

# Conforming to

.IX Header "CONFORMING TO"
\s-1NIST\s0 SP800-56Cr1.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
\s-1EVP_KDF_CTX\s0,
**EVP\_KDF\_CTX\_new\_id**\|(3),
**EVP\_KDF\_CTX\_free**\|(3),
**EVP\_KDF\_ctrl**\|(3),
**EVP\_KDF\_size**\|(3),
**EVP\_KDF\_derive**\|(3),
\s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3)

<a name="history"></a>

# History

.IX Header "HISTORY"
This functionality was added to OpenSSL 3.0.0.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2019 The OpenSSL Project Authors. All Rights Reserved.  Copyright
(c) 2019, Oracle and/or its affiliates.  All rights reserved.

Licensed under the Apache License 2.0 (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
