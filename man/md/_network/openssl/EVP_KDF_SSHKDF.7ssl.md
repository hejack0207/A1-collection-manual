# evp_kdf_sshkdf(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

EVP_KDF_SSHKDF - The SSHKDF EVP_KDF implementation

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Support for computing the **\s-1SSHKDF\s0** \s-1KDF\s0 through the **\s-1EVP\_KDF\s0** \s-1API.\s0

The \s-1EVP_KDF_SSHKDF\s0 algorithm implements the \s-1SSHKDF\s0 key derivation function.
It is defined in \s-1RFC 4253,\s0 section 7.2 and is used by \s-1SSH\s0 to derive IVs,
encryption keys and integrity keys.
Five inputs are required to perform key derivation: The hashing function
(for example \s-1SHA256\s0), the Initial Key, the Exchange Hash, the Session \s-1ID,\s0
and the derivation key type.

<a name="numeric-identity"></a>

### Numeric identity

.IX Subsection "Numeric identity"
**\s-1EVP\_KDF\_SSHKDF\s0** is the numeric identity for this implementation; it
can be used with the **EVP\_KDF\_CTX\_new\_id()** function.

<a name="supported-controls"></a>

### Supported controls

.IX Subsection "Supported controls"
The supported controls are:

* **\s-1EVP\_KDF\_CTRL\_SET\_MD\s0**  
  .IX Item "EVP_KDF_CTRL_SET_MD"
* **\s-1EVP\_KDF\_CTRL\_SET\_KEY\s0**  
  .IX Item "EVP_KDF_CTRL_SET_KEY"
  These controls work as described in \s-1CONTROLS\*(R"\s0 in \s-1**EVP\_KDF\_CTX\s0**\|(3).
* **\s-1EVP\_KDF\_CTRL\_SET\_SSHKDF\_XCGHASH\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SSHKDF_XCGHASH"
* **\s-1EVP\_KDF\_CTRL\_SET\_SSHKDF\_SESSION\_ID\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SSHKDF_SESSION_ID"
  These controls expect two arguments: \f(CW`unsigned char *buffer\*(C', \f(CW\*(C\`size_t length\*(C'
  .Sp
  They set the respective values to the first **length** bytes of the buffer
  **buffer**. If a value is already set, the contents are replaced.
  .Sp
  **EVP\_KDF\_ctrl\_str()** takes two type strings for these controls:
      .ie n .IP """xcghash""" 4
      .el .IP "\`\`xcghash''" 4
      .IX Item "xcghash"
      .ie n .IP """session_id""" 4
      .el .IP "\`\`session_id''" 4
      .IX Item "session_id"
      The value string is used as is.
      .ie n .IP """hexxcghash""" 4
      .el .IP "\`\`hexxcghash''" 4
      .IX Item "hexxcghash"
      .ie n .IP """hexsession_id""" 4
      .el .IP "\`\`hexsession_id''" 4
      .IX Item "hexsession_id"
      The value string is expected to be a hexadecimal number, which will be
      decoded before being passed on as the control value.
* **\s-1EVP\_KDF\_CTRL\_SET\_SSHKDF\_TYPE\s0**  
  .IX Item "EVP_KDF_CTRL_SET_SSHKDF_TYPE"
  This control expects one argument: \f(CW`int mode\*(C'
  .Sp
  Sets the type for the \s-1SSHHKDF\s0 operation. There are six supported types:
    * \s-1EVP_KDF_SSHKDF_TYPE_ININITAL_IV_CLI_TO_SRV\s0  
      .IX Item "EVP_KDF_SSHKDF_TYPE_ININITAL_IV_CLI_TO_SRV"
      The Initial \s-1IV\s0 from client to server.
      A single char of value 65 (\s-1ASCII\s0 char 'A').
    * \s-1EVP_KDF_SSHKDF_TYPE_ININITAL_IV_SRV_TO_CLI\s0  
      .IX Item "EVP_KDF_SSHKDF_TYPE_ININITAL_IV_SRV_TO_CLI"
      The Initial \s-1IV\s0 from server to client
      A single char of value 66 (\s-1ASCII\s0 char 'B').
    * \s-1EVP_KDF_SSHKDF_TYPE_ENCRYPTION_KEY_CLI_TO_SRV\s0  
      .IX Item "EVP_KDF_SSHKDF_TYPE_ENCRYPTION_KEY_CLI_TO_SRV"
      The Encryption Key from client to server
      A single char of value 67 (\s-1ASCII\s0 char 'C').
    * \s-1EVP_KDF_SSHKDF_TYPE_ENCRYPTION_KEY_SRV_TO_CLI\s0  
      .IX Item "EVP_KDF_SSHKDF_TYPE_ENCRYPTION_KEY_SRV_TO_CLI"
      The Encryption Key from server to client
      A single char of value 68 (\s-1ASCII\s0 char 'D').
    * \s-1EVP_KDF_SSHKDF_TYPE_INTEGRITY_KEY_CLI_TO_SRV\s0  
      .IX Item "EVP_KDF_SSHKDF_TYPE_INTEGRITY_KEY_CLI_TO_SRV"
      The Integrity Key from client to server
      A single char of value 69 (\s-1ASCII\s0 char 'E').
    * \s-1EVP_KDF_SSHKDF_TYPE_INTEGRITY_KEY_SRV_TO_CLI\s0  
      .IX Item "EVP_KDF_SSHKDF_TYPE_INTEGRITY_KEY_SRV_TO_CLI"
      The Integrity Key from client to server
      A single char of value 70 (\s-1ASCII\s0 char 'F').
      .Sp
      **EVP\_KDF\_ctrl\_str()** type string: type\*(R"
      .Sp
      The value is a string of length one character. The only valid values
      are the numerical values of the \s-1ASCII\s0 caracters: A\*(R" (65) to \*(L"F\*(R" (70).

<a name="notes"></a>

# Notes

.IX Header "NOTES"
A context for \s-1SSHKDF\s0 can be obtained by calling:

.Vb 1
 EVP_KDF_CTX *kctx = EVP_KDF_CTX_new_id(EVP_KDF_SSHKDF);
.Ve

The output length of the \s-1SSHKDF\s0 derivation is specified via the \f(CW`keylen\*(C'
parameter to the **EVP\_KDF\_derive**\|(3) function.
Since the \s-1SSHKDF\s0 output length is variable, calling **EVP\_KDF\_size()**
to obtain the requisite length is not meaningful. The caller must
allocate a buffer of the desired length, and pass that buffer to the
**EVP\_KDF\_derive**\|(3) function along with the desired length.

<a name="example"></a>

# Example

.IX Header "EXAMPLE"
This example derives an 8 byte \s-1IV\s0 using \s-1SHA-256\s0 with a 1K key\*(R" and appropriate
xcghash\*(R" and \*(L"session_id\*(R" values:

.Vb 7
 EVP_KDF_CTX *kctx;
 unsigned char key[1024] = "01234...";
 unsigned char xcghash[32] = "012345...";
 unsigned char session_id[32] = "012345...";
 unsigned char out[8];
 size_t outlen = sizeof(out);
 kctx = EVP_KDF_CTX_new_id(EVP_KDF_SSHKDF);

 if (EVP_KDF_CTX_set_md(kctx, EVP_sha256()) &lt;= 0)
     /* Error */
 if (EVP_KDF_CTX_set1_key(kctx, key, 1024) &lt;= 0)
     /* Error */
 if (EVP_KDF_CTX_set1_sshkdf_xcghash(kctx, xcghash, 32) &lt;= 0)
     /* Error */
 if (EVP_KDF_CTX_set1_sshkdf_session_id(kctx, session_id, 32) &lt;= 0)
     /* Error */
 if (EVP_KDF_CTX_set_sshkdf_type(kctx,
                    EVP_KDF_SSHKDF_TYPE_ININITAL_IV_CLI_TO_SRV) &lt;= 0)
     /* Error */
 if (EVP_KDF_derive(kctx, out, &outlen) &lt;= 0)
     /* Error */
.Ve

<a name="conforming-to"></a>

# Conforming to

.IX Header "CONFORMING TO"
\s-1RFC 4253\s0

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

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
