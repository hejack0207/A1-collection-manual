# speed(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-speed, speed - test library performance

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl speed [-help] [-engine id] [-elapsed] [-evp algo] [-decrypt] [-rand file...] [-writerand file] [-primes num] [-seconds num] [-bytes num] [algorithm...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This command is used to test the performance of cryptographic algorithms.
To see the list of supported algorithms, use the _list --digest-commands_
or _list --cipher-commands_ command. The global \s-1CSPRNG\s0 is denoted by
the _rand_ algorithm name.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **speed**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.
* **-elapsed**  
  .IX Item "-elapsed"
  When calculating operations- or bytes-per-second, use wall-clock time
  instead of \s-1CPU\s0 user time as divisor. It can be useful when testing speed
  of hardware engines.
* **-evp algo**  
  .IX Item "-evp algo"
  Use the specified cipher or message digest algorithm via the \s-1EVP\s0 interface.
  If **algo** is an \s-1AEAD\s0 cipher, then you can pass &lt;-aead&gt; to benchmark a
  TLS-like sequence. And if **algo** is a multi-buffer capable cipher, e.g.
  aes-128-cbc-hmac-sha1, then **-mb** will time multi-buffer operation.
* **-decrypt**  
  .IX Item "-decrypt"
  Time the decryption instead of encryption. Affects only the \s-1EVP\s0 testing.
* **-rand file...**  
  .IX Item "-rand file..."
  A file or files containing random data used to seed the random number
  generator.
  Multiple files can be specified separated by an OS-dependent character.
  The separator is **;** for MS-Windows, **,** for OpenVMS, and **:** for
  all others.
* [**-writerand file**]  
  .IX Item "[-writerand file]"
  Writes random data to the specified _file_ upon exit.
  This can be used with a subsequent **-rand** flag.
* **-primes num**  
  .IX Item "-primes num"
  Generate a **num**-prime \s-1RSA\s0 key and use it to run the benchmarks. This option
  is only effective if \s-1RSA\s0 algorithm is specified to test.
* **-seconds num**  
  .IX Item "-seconds num"
  Run benchmarks for **num** seconds.
* **-bytes num**  
  .IX Item "-bytes num"
  Run benchmarks on **num**-byte buffers. Affects ciphers, digests and the \s-1CSPRNG.\s0
* **[zero or more test algorithms]**  
  .IX Item "[zero or more test algorithms]"
  If any options are given, **speed** tests those algorithms, otherwise a
  pre-compiled grand selection is tested.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
