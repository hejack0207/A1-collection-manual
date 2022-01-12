# ct(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

ct - Certificate Transparency

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  #include <openssl/ct.h> .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This library implements Certificate Transparency (\s-1CT\s0) verification for \s-1TLS\s0
clients, as defined in \s-1RFC 6962.\s0 This verification can provide some confidence
that a certificate has been publicly logged in a set of \s-1CT\s0 logs.

By default, these checks are disabled. They can be enabled using
**SSL\_CTX\_enable\_ct**\|(3) or **SSL\_enable\_ct**\|(3).

This library can also be used to parse and examine \s-1CT\s0 data structures, such as
Signed Certificate Timestamps (SCTs), or to read a list of \s-1CT\s0 logs. There are
functions for:
- decoding and encoding SCTs in \s-1DER\s0 and \s-1TLS\s0 wire format.
- printing SCTs.
- verifying the authenticity of SCTs.
- loading a \s-1CT\s0 log list from a \s-1CONF\s0 file.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**d2i\_SCT\_LIST**\|(3),
**CTLOG\_STORE\_new**\|(3),
**CTLOG\_STORE\_get0\_log\_by\_id**\|(3),
**SCT\_new**\|(3),
**SCT\_print**\|(3),
**SCT\_validate**\|(3),
**SCT\_validate**\|(3),
**CT\_POLICY\_EVAL\_CTX\_new**\|(3),
**SSL\_CTX\_set\_ct\_validation\_callback**\|(3)

<a name="history"></a>

# History

.IX Header "HISTORY"
The ct library was added in OpenSSL 1.1.0.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2016-2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
