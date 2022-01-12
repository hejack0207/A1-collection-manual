# ossl_store(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

ossl_store - Store retrieval functions

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" #include <openssl/store.h>
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"

<a name="general"></a>

### General

.IX Subsection "General"
A \s-1STORE\s0 is a layer of functionality to retrieve a number of supported
objects from a repository of any kind, addressable as a filename or
as a \s-1URI.\s0

The functionality supports the pattern open a channel to the
repository, \*(L"loop and retrieve one object at a time\*(R", and \*(L"finish up
by closing the channel.

The retrieved objects are returned as a wrapper type **\s-1OSSL\_STORE\_INFO\s0**,
from which an OpenSSL type can be retrieved.

<a name="s-1uris0-schemes-and-loaders"></a>

### \s-1URI\s0 schemes and loaders

.IX Subsection "URI schemes and loaders"
Support for a \s-1URI\s0 scheme is called a \s-1STORE\s0 loader\*(R", and can be added
dynamically from the calling application or from a loadable engine.

Support for the 'file' scheme is built into \f(CW`libcrypto\*(C'.
See **ossl\_store-file**\|(7) for more information.

<a name="s-1ui_methods0-and-pass-phrases"></a>

### \s-1UI_METHOD\s0 and pass phrases

.IX Subsection "UI_METHOD and pass phrases"
The **\s-1OSS\_STORE\s0** \s-1API\s0 does nothing to enforce any specific format or
encoding on the pass phrase that the **\s-1UI\_METHOD\s0** provides.  However,
the pass phrase is expected to be \s-1UTF-8\s0 encoded.  The result of any
other encoding is undefined.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"

<a name="a-generic-call"></a>

### A generic call

.IX Subsection "A generic call"
.Vb 1
 OSSL_STORE_CTX *ctx = OSSL_STORE_open("file:/foo/bar/data.pem");

 /*
  * OSSL_STORE_eof() simulates file semantics for any repository to signal
  * that no more data can be expected
  */
 while (!OSSL_STORE_eof(ctx)) {
     OSSL_STORE_INFO *info = OSSL_STORE_load(ctx);

     /*
      * Do whatever is necessary with the OSSL_STORE_INFO,
      * here just one example
      */
     switch (OSSL_STORE_INFO_get_type(info)) {
     case OSSL_STORE_INFO_X509:
         /* Print the X.509 certificate text */
         X509_print_fp(stdout, OSSL_STORE_INFO_get0_CERT(info));
         /* Print the X.509 certificate PEM output */
         PEM_write_X509(stdout, OSSL_STORE_INFO_get0_CERT(info));
         break;
     }
 }

 OSSL_STORE_close(ctx);
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
\s-1**OSSL\_STORE\_INFO\s0**\|(3), \s-1**OSSL\_STORE\_LOADER\s0**\|(3),
**OSSL\_STORE\_open**\|(3), **OSSL\_STORE\_expect**\|(3),
\s-1**OSSL\_STORE\_SEARCH\s0**\|(3)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2016-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
