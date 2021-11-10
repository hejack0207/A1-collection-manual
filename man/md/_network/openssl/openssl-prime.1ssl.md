# prime(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-prime, prime - compute prime numbers

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl prime [-help] [-hex] [-generate] [-bits] [-safe] [-checks] [number...]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **prime** command checks if the specified numbers are prime.

If no numbers are given on the command line, the **-generate** flag should
be used to generate primes according to the requirements specified by the
rest of the flags.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* [**-help**]  
  .IX Item "[-help]"
  Display an option summary.
* [**-hex**]  
  .IX Item "[-hex]"
  Generate hex output.
* [**-generate**]  
  .IX Item "[-generate]"
  Generate a prime number.
* [**-bits num**]  
  .IX Item "[-bits num]"
  Generate a prime with **num** bits.
* [**-safe**]  
  .IX Item "[-safe]"
  When used with **-generate**, generates a safe\*(R" prime. If the number
  generated is **n**, then check that **(n-1)/2** is also prime.
* [**-checks num**]  
  .IX Item "[-checks num]"
  Perform the checks **num** times to see that the generated number
  is prime.  The default is 20.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
