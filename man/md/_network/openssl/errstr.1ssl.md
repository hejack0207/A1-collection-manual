# errstr(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-errstr, errstr - lookup error codes

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl errstr error_code
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Sometimes an application will not load error message and only
numerical forms will be available. The **errstr** utility can be used to
display the meaning of the hex code. The hex code is the hex digits after the
second colon.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
None.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
The error code:

.Vb 1
 27594:error:2006D080:lib(32):func(109):reason(128):bss_file.c:107:
.Ve

can be displayed with:

.Vb 1
 openssl errstr 2006D080
.Ve

to produce the error message:

.Vb 1
 error:2006D080:BIO routines:BIO_new_file:no such file
.Ve

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2004-2019 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
