# passphrase-encoding(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

passphrase-encoding - How diverse parts of OpenSSL treat pass phrases character encoding

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
In a modern world with all sorts of character encodings, the treatment of pass
phrases has become increasingly complex.
This manual page attempts to give an overview over how this problem is
currently addressed in different parts of the OpenSSL library.

<a name="the-general-case"></a>

### The general case

.IX Subsection "The general case"
The OpenSSL library doesn't treat pass phrases in any special way as a general
rule, and trusts the application or user to choose a suitable character set
and stick to that throughout the lifetime of affected objects.
This means that for an object that was encrypted using a pass phrase encoded in
\s-1ISO-8859-1,\s0 that object needs to be decrypted using a pass phrase encoded in
\s-1ISO-8859-1.\s0
Using the wrong encoding is expected to cause a decryption failure.

<a name="pkcs12"></a>

### PKCS#12

.IX Subsection "PKCS#12"
PKCS#12 is a bit different regarding pass phrase encoding.
The standard stipulates that the pass phrase shall be encoded as an \s-1ASN.1\s0
BMPString, which consists of the code points of the basic multilingual plane,
encoded in big endian (\s-1UCS-2 BE\s0).

OpenSSL tries to adapt to this requirements in one of the following manners:

* 1.  
  Treats the received pass phrase as \s-1UTF-8\s0 encoded and tries to re-encode it to
  \s-1UTF-16\s0 (which is the same as \s-1UCS-2\s0 for characters U+0000 to U+D7FF and U+E000
  to U+FFFF, but becomes an expansion for any other character), or failing that,
  proceeds with step 2.
* 2.  
  Assumes that the pass phrase is encoded in \s-1ASCII\s0 or \s-1ISO-8859-1\s0 and
  opportunistically prepends each byte with a zero byte to obtain the \s-1UCS-2\s0
  encoding of the characters, which it stores as a BMPString.
  .Sp
  Note that since there is no check of your locale, this may produce \s-1UCS-2 /
  UTF-16\s0 characters that do not correspond to the original pass phrase characters
  for other character sets, such as any \s-1ISO-8859-X\s0 encoding other than
  \s-1ISO-8859-1\s0 (or for Windows, \s-1CP 1252\s0 with exception for the extra graphical\*(R"
  characters in the 0x80-0x9F range).

OpenSSL versions older than 1.1.0 do variant 2 only, and that is the reason why
OpenSSL still does this, to be able to read files produced with older versions.

It should be noted that this approach isn't entirely fault free.

A pass phrase encoded in \s-1ISO-8859-2\s0 could very well have a sequence such as
0xC3 0xAF (which is the two characters \s-1LATIN CAPITAL LETTER A WITH BREVE\*(R"\s0
and \s-1LATIN CAPITAL LETTER Z WITH DOT ABOVE\*(R"\s0 in \s-1ISO-8859-2\s0 encoding), but would
be misinterpreted as the perfectly valid \s-1UTF-8\s0 encoded code point U+00EF (\s-1LATIN
SMALL LETTER I WITH DIAERESIS\s0) if the pass phrase doesn't contain anything that
would be invalid \s-1UTF-8\s0.
A pass phrase that contains this kind of byte sequence will give a different
outcome in OpenSSL 1.1.0 and newer than in OpenSSL older than 1.1.0.

.Vb 2
 0x00 0xC3 0x00 0xAF                    # OpenSSL older than 1.1.0
 0x00 0xEF                              # OpenSSL 1.1.0 and newer
.Ve

On the same accord, anything encoded in \s-1UTF-8\s0 that was given to OpenSSL older
than 1.1.0 was misinterpreted as \s-1ISO-8859-1\s0 sequences.

<a name="s-1ossl_stores0"></a>

### \s-1OSSL_STORE\s0

.IX Subsection "OSSL_STORE"
**ossl\_store**\|(7) acts as a general interface to access all kinds of objects,
potentially protected with a pass phrase, a \s-1PIN\s0 or something else.
This \s-1API\s0 stipulates that pass phrases should be \s-1UTF-8\s0 encoded, and that any
other pass phrase encoding may give undefined results.
This \s-1API\s0 relies on the application to ensure \s-1UTF-8\s0 encoding, and doesn't check
that this is the case, so what it gets, it will also pass to the underlying
loader.

<a name="recommendations"></a>

# Recommendations

.IX Header "RECOMMENDATIONS"
This section assumes that you know what pass phrase was used for encryption,
but that it may have been encoded in a different character encoding than the
one used by your current input method.
For example, the pass phrase may have been used at a time when your default
encoding was \s-1ISO-8859-1\s0 (i.e. nai\*:ve\*(R" resulting in the byte sequence 0x6E 0x61
0xEF 0x76 0x65), and you're now in an environment where your default encoding
is \s-1UTF-8\s0 (i.e. nai\*:ve\*(R" resulting in the byte sequence 0x6E 0x61 0xC3 0xAF 0x76
0x65).
Whenever it's mentioned that you should use a certain character encoding, it
should be understood that you either change the input method to use the
mentioned encoding when you type in your pass phrase, or use some suitable tool
to convert your pass phrase from your default encoding to the target encoding.

Also note that the sub-sections below discuss human readable pass phrases.
This is particularly relevant for PKCS#12 objects, where human readable pass
phrases are assumed.
For other objects, it's as legitimate to use any byte sequence (such as a
sequence of bytes from \`/dev/urandom\` that's been saved away), which makes any
character encoding discussion irrelevant; in such cases, simply use the same
byte sequence as it is.

<a name="creating-new-objects"></a>

### Creating new objects

.IX Subsection "Creating new objects"
For creating new pass phrase protected objects, make sure the pass phrase is
encoded using \s-1UTF-8.\s0
This is default on most modern Unixes, but may involve an effort on other
platforms.
Specifically for Windows, setting the environment variable
\f(CW`OPENSSL\_WIN32\_UTF8\*(C' will have anything entered on [Windows] console prompt
converted to \s-1UTF-8\s0 (command line and separately prompted pass phrases alike).

<a name="opening-existing-objects"></a>

### Opening existing objects

.IX Subsection "Opening existing objects"
For opening pass phrase protected objects where you know what character
encoding was used for the encryption pass phrase, make sure to use the same
encoding again.

For opening pass phrase protected objects where the character encoding that was
used is unknown, or where the producing application is unknown, try one of the
following:

* 1.  
  Try the pass phrase that you have as it is in the character encoding of your
  environment.
  It's possible that its byte sequence is exactly right.
* 2.  
  Convert the pass phrase to \s-1UTF-8\s0 and try with the result.
  Specifically with PKCS#12, this should open up any object that was created
  according to the specification.
* 3.  
  Do a naive (i.e. purely mathematical) \s-1ISO-8859-1\s0 to \s-1UTF-8\s0 conversion and try
  with the result.
  This differs from the previous attempt because \s-1ISO-8859-1\s0 maps directly to
  U+0000 to U+00FF, which other non-UTF-8 character sets do not.
  .Sp
  This also takes care of the case when a \s-1UTF-8\s0 encoded string was used with
  OpenSSL older than 1.1.0.
  (for example, \f(CW`i\*:\*(C', which is 0xC3 0xAF when encoded in \s-1UTF-8,\s0 would become 0xC3
  0x83 0xC2 0xAF when re-encoded in the naive manner.
  The conversion to BMPString would then yield 0x00 0xC3 0x00 0xA4 0x00 0x00, the
  erroneous/non-compliant encoding used by OpenSSL older than 1.1.0)

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**evp**\|(7),
**ossl\_store**\|(7),
**EVP\_BytesToKey**\|(3), **EVP\_DecryptInit**\|(3),
**PEM\_do\_header**\|(3),
**PKCS12\_parse**\|(3), **PKCS12\_newpass**\|(3),
**d2i\_PKCS8PrivateKey\_bio**\|(3)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2018-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
