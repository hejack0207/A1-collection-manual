# sess_id(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-sess_id, sess_id - SSL/TLS session handling utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl sess_id [-help] [-inform PEM|DER] [-outform PEM|DER|NSS] [-in filename] [-out filename] [-text] [-noout] [-context \s-1ID\s0]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **sess\_id** process the encoded version of the \s-1SSL\s0 session structure
and optionally prints out \s-1SSL\s0 session details (for example the \s-1SSL\s0 session
master key) in human readable format. Since this is a diagnostic tool that
needs some knowledge of the \s-1SSL\s0 protocol to use properly, most users will
not need to use it.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format. The **\s-1DER\s0** option uses an \s-1ASN1 DER\s0 encoded
  format containing session details. The precise format can vary from one version
  to the next.  The **\s-1PEM\s0** form is the default format: it consists of the **\s-1DER\s0**
  format base64 encoded with additional header and footer lines.
* **-outform DER|PEM|NSS**  
  .IX Item "-outform DER|PEM|NSS"
  This specifies the output format. The **\s-1PEM\s0** and **\s-1DER\s0** options have the same meaning
  and default as the **-inform** option. The **\s-1NSS\s0** option outputs the session id and
  the master key in \s-1NSS\s0 keylog format.
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read session information from or standard
  input by default.
* **-out filename**  
  .IX Item "-out filename"
  This specifies the output filename to write session information to or standard
  output if this option is not specified.
* **-text**  
  .IX Item "-text"
  Prints out the various public or private key components in
  plain text in addition to the encoded version.
* **-cert**  
  .IX Item "-cert"
  If a certificate is present in the session it will be output using this option,
  if the **-text** option is also present then it will be printed out in text form.
* **-noout**  
  .IX Item "-noout"
  This option prevents output of the encoded version of the session.
* **-context \s-1ID\s0**  
  .IX Item "-context ID"
  This option can set the session id so the output session information uses the
  supplied \s-1ID.\s0 The \s-1ID\s0 can be any string of characters. This option won't normally
  be used.

<a name="output"></a>

# Output

.IX Header "OUTPUT"
Typical output:

.Vb 10
 SSL-Session:
     Protocol  : TLSv1
     Cipher    : 0016
     Session-ID: 871E62626C554CE95488823752CBD5F3673A3EF3DCE9C67BD916C809914B40ED
     Session-ID-ctx: 01000000
     Master-Key: A7CEFC571974BE02CAC305269DC59F76EA9F0B180CB6642697A68251F2D2BB57E51DBBB4C7885573192AE9AEE220FACD
     Key-Arg   : None
     Start Time: 948459261
     Timeout   : 300 (sec)
     Verify return code 0 (ok)
.Ve

These are described below in more detail.

* **Protocol**  
  .IX Item "Protocol"
  This is the protocol in use TLSv1.3, TLSv1.2, TLSv1.1, TLSv1 or SSLv3.
* **Cipher**  
  .IX Item "Cipher"
  The cipher used this is the actual raw \s-1SSL\s0 or \s-1TLS\s0 cipher code, see the \s-1SSL\s0
  or \s-1TLS\s0 specifications for more information.
* **Session-ID**  
  .IX Item "Session-ID"
  The \s-1SSL\s0 session \s-1ID\s0 in hex format.
* **Session-ID-ctx**  
  .IX Item "Session-ID-ctx"
  The session \s-1ID\s0 context in hex format.
* **Master-Key**  
  .IX Item "Master-Key"
  This is the \s-1SSL\s0 session master key.
* **Start Time**  
  .IX Item "Start Time"
  This is the session start time represented as an integer in standard
  Unix format.
* **Timeout**  
  .IX Item "Timeout"
  The timeout in seconds.
* **Verify return code**  
  .IX Item "Verify return code"
  This is the return code when an \s-1SSL\s0 client certificate is verified.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The \s-1PEM\s0 encoded session format uses the header and footer lines:

.Vb 2
 -----BEGIN SSL SESSION PARAMETERS-----
 -----END SSL SESSION PARAMETERS-----
.Ve

Since the \s-1SSL\s0 session output contains the master key it is
possible to read the contents of an encrypted session using this
information. Therefore, appropriate security precautions should be taken if
the information is being output by a real\*(R" application. This is however
strongly discouraged and should only be used for debugging purposes.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
The cipher and start time should be printed out in human readable form.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ciphers**\|(1), **s\_server**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
