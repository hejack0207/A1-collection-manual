# rand(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-rand, rand - generate pseudo-random bytes

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl rand [-help] [-out file] [-rand file...] [-writerand file] [-base64] [-hex] num
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This command generates _num_ random bytes using a cryptographically
secure pseudo random number generator (\s-1CSPRNG\s0).

The random bytes are generated using the **RAND\_bytes**\|(3) function,
which provides a security level of 256 bits, provided it managed to
seed itself successfully from a trusted operating system entropy source.
Otherwise, the command will fail with a nonzero error code.
For more details, see **RAND\_bytes**\|(3), \s-1**RAND\s0**\|(7), and \s-1**RAND\_DRBG\s0**\|(7).

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-out file**  
  .IX Item "-out file"
  Write to _file_ instead of standard output.
* **-rand file...**  
  .IX Item "-rand file..."
  A file or files containing random data used to seed the random number
  generator.
  Multiple files can be specified separated by an OS-dependent character.
  The separator is **;** for MS-Windows, **,** for OpenVMS, and **:** for
  all others.
  Explicitly specifying a seed file is in general not necessary, see the
  \s-1NOTES\*(R"\s0 section for more information.
* [**-writerand file**]  
  .IX Item "[-writerand file]"
  Writes random data to the specified _file_ upon exit.
  This can be used with a subsequent **-rand** flag.
* **-base64**  
  .IX Item "-base64"
  Perform base64 encoding on the output.
* **-hex**  
  .IX Item "-hex"
  Show the output as a hex string.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
Prior to OpenSSL 1.1.1, it was common for applications to store information
about the state of the random-number generator in a file that was loaded
at startup and rewritten upon exit. On modern operating systems, this is
generally no longer necessary as OpenSSL will seed itself from a trusted
entropy source provided by the operating system. The **-rand**  and
**-writerand**  flags are still supported for special platforms or
circumstances that might require them.

It is generally an error to use the same seed file more than once and
every use of **-rand** should be paired with **-writerand**.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**RAND\_bytes**\|(3),
\s-1**RAND\s0**\|(7),
\s-1**RAND\_DRBG\s0**\|(7)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
