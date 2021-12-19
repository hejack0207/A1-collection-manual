# bio(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

bio - Basic I/O abstraction

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  #include <openssl/bio.h> .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
A \s-1BIO\s0 is an I/O abstraction, it hides many of the underlying I/O
details from an application. If an application uses a \s-1BIO\s0 for its
I/O it can transparently handle \s-1SSL\s0 connections, unencrypted network
connections and file I/O.

There are two type of \s-1BIO,\s0 a source/sink \s-1BIO\s0 and a filter \s-1BIO.\s0

As its name implies a source/sink \s-1BIO\s0 is a source and/or sink of data,
examples include a socket \s-1BIO\s0 and a file \s-1BIO.\s0

A filter \s-1BIO\s0 takes data from one \s-1BIO\s0 and passes it through to
another, or the application. The data may be left unmodified (for
example a message digest \s-1BIO\s0) or translated (for example an
encryption \s-1BIO\s0). The effect of a filter \s-1BIO\s0 may change according
to the I/O operation it is performing: for example an encryption
\s-1BIO\s0 will encrypt data if it is being written to and decrypt data
if it is being read from.

BIOs can be joined together to form a chain (a single \s-1BIO\s0 is a chain
with one component). A chain normally consist of one source/sink
\s-1BIO\s0 and one or more filter BIOs. Data read from or written to the
first \s-1BIO\s0 then traverses the chain to the end (normally a source/sink
\s-1BIO\s0).

Some BIOs (such as memory BIOs) can be used immediately after calling
**BIO\_new()**. Others (such as file BIOs) need some additional initialization,
and frequently a utility function exists to create and initialize such BIOs.

If **BIO\_free()** is called on a \s-1BIO\s0 chain it will only free one \s-1BIO\s0 resulting
in a memory leak.

Calling **BIO\_free\_all()** on a single \s-1BIO\s0 has the same effect as calling
**BIO\_free()** on it other than the discarded return value.

Normally the **type** argument is supplied by a function which returns a
pointer to a \s-1BIO_METHOD.\s0 There is a naming convention for such functions:
a source/sink \s-1BIO\s0 is normally called BIO_s_*() and a filter \s-1BIO\s0
BIO_f_*();

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Create a memory \s-1BIO:\s0

.Vb 1
 BIO *mem = BIO_new(BIO_s_mem());
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**BIO\_ctrl**\|(3),
**BIO\_f\_base64**\|(3), **BIO\_f\_buffer**\|(3),
**BIO\_f\_cipher**\|(3), **BIO\_f\_md**\|(3),
**BIO\_f\_null**\|(3), **BIO\_f\_ssl**\|(3),
**BIO\_find\_type**\|(3), **BIO\_new**\|(3),
**BIO\_new\_bio\_pair**\|(3),
**BIO\_push**\|(3), **BIO\_read\_ex**\|(3),
**BIO\_s\_accept**\|(3), **BIO\_s\_bio**\|(3),
**BIO\_s\_connect**\|(3), **BIO\_s\_fd**\|(3),
**BIO\_s\_file**\|(3), **BIO\_s\_mem**\|(3),
**BIO\_s\_null**\|(3), **BIO\_s\_socket**\|(3),
**BIO\_set\_callback**\|(3),
**BIO\_should\_retry**\|(3)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2019 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
