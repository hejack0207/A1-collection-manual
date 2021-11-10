# evp_kdf_hkdf(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

EVP_KDF_HKDF - The HKDF EVP_KDF implementation

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Support for computing the **\s-1HKDF\s0** \s-1KDF\s0 through the **\s-1EVP\_KDF\s0** \s-1API.\s0

The \s-1EVP_KDF_HKDF\s0 algorithm implements the \s-1HKDF\s0 key derivation function.
\s-1HKDF\s0 follows the extract-then-expand\*(R" paradigm, where the \s-1KDF\s0 logically
consists of two modules. The first stage takes the input keying material
and extracts\*(R" from it a fixed-length pseudorandom key K. The second stage
expands\*(R" the key K into several additional pseudorandom keys (the output
of the \s-1KDF\s0).

<a name="numeric-identity"></a>

### Numeric identity

.IX Subsection "Numeric identity"
**\s-1EVP\_KDF\_HKDF\s0** is the numeric identity for this implementation; it
can be used with the **EVP\_KDF\_CTX\_new\_id()** function.

<a name="supported-controls"></a>

### Supported controls

.IX Subsection "Supported controls"
The supported controls are:

* **\s-1EVP\_KDF\_CTRL\_SET\_SALT\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SALT"
* **\s-1EVP\_KDF\_CTRL\_SET\_MD\s0**  
  .IX Item "EVP_KDF_CTRL_SET_MD"
* **\s-1EVP\_KDF\_CTRL\_SET\_KEY\s0**  
  .IX Item "EVP_KDF_CTRL_SET_KEY"
  These controls work as described in \s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3).
* **\s-1EVP\_KDF\_CTRL\_RESET\_HKDF\_INFO\s0**  
  .IX Item "EVP_KDF_CTRL_RESET_HKDF_INFO"
  This control does not expect any arguments.
  .Sp
  Resets the context info buffer to zero length.
* **\s-1EVP\_KDF\_CTRL\_ADD\_HKDF\_INFO\s0**  
  .IX Item "EVP_KDF_CTRL_ADD_HKDF_INFO"
  This control expects two arguments: \f(CW`unsigned char *info\*(C', \f(CW\*(C\`size_t infolen\*(C'
  .Sp
  Sets the info value to the first **infolen** bytes of the buffer **info**.  If a
  value is already set, the contents of the buffer are appended to the existing
  value.
  .Sp
  The total length of the context info buffer cannot exceed 1024 bytes;
  this should be more than enough for any normal use of \s-1HKDF.\s0
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
* **\s-1EVP\_KDF\_CTRL\_SET\_HKDF\_MODE\s0**  
  .IX Item "EVP_KDF_CTRL_SET_HKDF_MODE"
  This control expects one argument: \f(CW`int mode\*(C'
  .Sp
  Sets the mode for the \s-1HKDF\s0 operation. There are three modes that are currently
  defined:
    * \s-1EVP_KDF_HKDF_MODE_EXTRACT_AND_EXPAND\s0  
      .IX Item "EVP_KDF_HKDF_MODE_EXTRACT_AND_EXPAND"
      This is the default mode.  Calling **EVP\_KDF\_derive**\|(3) on an \s-1EVP_KDF_CTX\s0 set
      up for \s-1HKDF\s0 will perform an extract followed by an expand operation in one go.
      The derived key returned will be the result after the expand operation. The
      intermediate fixed-length pseudorandom key K is not returned.
      .Sp
      In this mode the digest, key, salt and info values must be set before a key is
      derived otherwise an error will occur.
    * \s-1EVP_KDF_HKDF_MODE_EXTRACT_ONLY\s0  
      .IX Item "EVP_KDF_HKDF_MODE_EXTRACT_ONLY"
      In this mode calling **EVP\_KDF\_derive**\|(3) will just perform the extract
      operation. The value returned will be the intermediate fixed-length pseudorandom
      key K.  The \f(CW`keylen\*(C' parameter must match the size of K, which can be looked
      up by calling **EVP\_KDF\_size()** after setting the mode and digest.
      .Sp
      The digest, key and salt values must be set before a key is derived otherwise
      an error will occur.
    * \s-1EVP_KDF_HKDF_MODE_EXPAND_ONLY\s0  
      .IX Item "EVP_KDF_HKDF_MODE_EXPAND_ONLY"
      In this mode calling **EVP\_KDF\_derive**\|(3) will just perform the expand
      operation. The input key should be set to the intermediate fixed-length
      pseudorandom key K returned from a previous extract operation.
      .Sp
      The digest, key and info values must be set before a key is derived otherwise
      an error will occur.
      .Sp
      **EVP\_KDF\_ctrl\_str()** type string: mode\*(R"
      .Sp
      The value string is expected to be one of: \s-1EXTRACT_AND_EXPAND\*(R", \*(L"EXTRACT_ONLY\*(R"\s0
      or \s-1EXPAND_ONLY\*(R".\s0

<a name="notes"></a>

# Notes

.IX Header "NOTES"
A context for \s-1HKDF\s0 can be obtained by calling:

.Vb 1
 EVP_KDF_CTX *kctx = EVP_KDF_CTX_new_id(EVP_KDF_HKDF);
.Ve

The output length of an \s-1HKDF\s0 expand operation is specified via the \f(CW`keylen\*(C'
parameter to the **EVP\_KDF\_derive**\|(3) function.  When using
\s-1EVP_KDF_HKDF_MODE_EXTRACT_ONLY\s0 the \f(CW`keylen\*(C' parameter must equal the size of
the intermediate fixed-length pseudorandom key otherwise an error will occur.
For that mode, the fixed output size can be looked up by calling **EVP\_KDF\_size()**
after setting the mode and digest on the \f(CW`EVP\_KDF\_CTX\*(C'.

<a name="example"></a>

# Example

.IX Header "EXAMPLE"
This example derives 10 bytes using \s-1SHA-256\s0 with the secret key secret\*(R",
salt value salt\*(R" and info value \*(L"label\*(R":

.Vb 2
 EVP_KDF_CTX *kctx;
 unsigned char out[10];

 kctx = EVP_KDF_CTX_new_id(EVP_KDF_HKDF);

 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_MD, EVP_sha256()) &lt;= 0) {
     error("EVP_KDF_CTRL_SET_MD");
 }
 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_SALT, "salt", (size_t)4) &lt;= 0) {
     error("EVP_KDF_CTRL_SET_SALT");
 }
 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_SET_KEY, "secret", (size_t)6) &lt;= 0) {
     error("EVP_KDF_CTRL_SET_KEY");
 }
 if (EVP_KDF_ctrl(kctx, EVP_KDF_CTRL_ADD_HKDF_INFO, "label", (size_t)5) &lt;= 0) {
     error("EVP_KDF_CTRL_ADD_HKDF_INFO");
 }
 if (EVP_KDF_derive(kctx, out, sizeof(out)) &lt;= 0) {
     error("EVP_KDF_derive");
 }

 EVP_KDF_CTX_free(kctx);
.Ve

<a name="conforming-to"></a>

# Conforming to

.IX Header "CONFORMING TO"
\s-1RFC 5869\s0

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

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2016-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the Apache License 2.0 (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
