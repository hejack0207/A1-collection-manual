# ossl_store-file(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

ossl_store-file - The store 'file' scheme loader

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" #include <openssl/store.h>
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Support for the 'file' scheme is built into \f(CW`libcrypto\*(C'.
Since files come in all kinds of formats and content types, the 'file'
scheme has its own layer of functionality called file handlers\*(R",
which are used to try to decode diverse types of file contents.

In case a file is formatted as \s-1PEM,\s0 each called file handler receives
the \s-1PEM\s0 name (everything following any '\f(CW`-----BEGIN \*(C'') as well as
possible \s-1PEM\s0 headers, together with the decoded \s-1PEM\s0 body.  Since \s-1PEM\s0
formatted files can contain more than one object, the file handlers
are called upon for each such object.

If the file isn't determined to be formatted as \s-1PEM,\s0 the content is
loaded in raw form in its entirety and passed to the available file
handlers as is, with no \s-1PEM\s0 name or headers.

Each file handler is expected to handle \s-1PEM\s0 and non-PEM content as
appropriate.  Some may refuse non-PEM content for the sake of
determinism (for example, there are keys out in the wild that are
represented as an \s-1ASN.1 OCTET STRING.\s0  In raw form, it's not easily
possible to distinguish those from any other data coming as an \s-1ASN.1
OCTET STRING,\s0 so such keys would naturally be accepted as \s-1PEM\s0 files
only).

<a name="notes"></a>

# Notes

.IX Header "NOTES"
When needed, the 'file' scheme loader will require a pass phrase by
using the \f(CW`UI\_METHOD\*(C' that was passed via **OSSL\_STORE\_open()**.
This pass phrase is expected to be \s-1UTF-8\s0 encoded, anything else will
give an undefined result.
The files made accessible through this loader are expected to be
standard compliant with regards to pass phrase encoding.
Files that aren't should be re-generated with a correctly encoded pass
phrase.
See **passphrase-encoding**\|(7) for more information.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ossl\_store**\|(7), **passphrase-encoding**\|(7)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
