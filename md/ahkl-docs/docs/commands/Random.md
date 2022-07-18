# Random

Generates a pseudo-random number.

```
<span class="func">Random</span>, OutputVar <span class="optional">, Min, Max</span>
<span class="func">Random</span>, , NewSeed

```

## Parameters

OutputVar

The name of the variable in which to store the result. The format of stored floating point numbers is determined by [SetFormat](SetFormat.htm) if its [slow mode](SetFormat.htm#Fast) is used; otherwise SetFormat only affects formatting when the number is converted to a string.

MinThe smallest number that can be generated, which can be negative, floating point, or an [expression](../Variables.htm#Expressions). If omitted, the
 smallest number will be 0. The lowest allowed value is -2147483648 for integers, but floating point numbers have no restrictions.Max

The largest number that can be generated, which can be negative, floating point, or an [expression](../Variables.htm#Expressions). If omitted, the largest number will be 2147483647 (which is also the largest allowed integer value -- but floating point numbers have no restrictions).

NewSeed

This mode reseeds the random number generator with _NewSeed_ (which can be an [expression](../Variables.htm#Expressions)). This affects all subsequently generated random numbers. _NewSeed_ should be an integer between 0 and 4294967295 (0xFFFFFFFF). Reseeding can improve the quality/security of generated random numbers, especially when _NewSeed_ is a genuine random number rather than one of lesser quality such as a pseudo-random number. Generally, reseeding does not need to be done more than once.

If reseeding is never done by the script, the seed starts off as the low-order 32-bits of the 64-bit value that is the number of 100-nanosecond intervals since January 1, 1601. This value travels from 0 to 4294967295 every ~7.2 minutes.

## Remarks

This command yields a pseudo-randomly generated number, which is a number
that simulates a true random number but is really a number based on a complicated
formula to make determination/guessing of the next number extremely difficult.

All numbers within the specified range have approximately the same probability of being generated (however, see "known limitations" below).

If either _Min_ or _Max_ contains a decimal point, the end result will be a floating point number in the format set by [SetFormat](SetFormat.htm). Otherwise, the result will be an integer.

Known limitations for floating point: 1) only about 4,294,967,296 distinct numbers can be generated for any particular range, so all other numbers in the range will never be generated; 2) occasionally a result can be slightly greater than the specified _Max_ (this is caused in part by the imprecision inherent in floating point numbers).

## Related

[Format()](Format.htm), [SetFormat](SetFormat.htm)

## Examples

Generates a random integer in the range 1 to 10 and stores it in rand.

```
Random, rand, 1, 10
```

Generates a random floating point number in the range 0.0 to 1.0 and stores it in rand.

```
Random, rand, 0.0, 1.0
```

## Comments based on the original source

This function uses the Mersenne Twister random number generator, MT19937, written
by Takuji Nishimura and Makoto Matsumoto, Shawn Cokus, Matthe Bellew and Isaku
Wada.

The Mersenne Twister is an algorithm for generating random numbers. It was
designed with consideration of the flaws in various other generators. The period,
219937-1, and the order of equidistribution, 623 dimensions, are
far greater. The generator is also fast; it avoids multiplication and division,
and it benefits from caches and pipelines. For more information see the inventors'
web page at [www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html](http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html)

Copyright (C) 1997 - 2002, Makoto Matsumoto and Takuji Nishimura, All rights
reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
3. The names of its contributors may not be used to endorse or promote products
    derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Do NOT use for CRYPTOGRAPHY without securely hashing several returned values
together, otherwise the generator state can be learned after reading 624 consecutive
values.

When you use this, send an email to: m-mat@math.sci.hiroshima-u.ac.jp with an appropriate
reference to your work.

_This above has been already been done for AutoHotkey, but if you use the Random command in a publicly distributed application,
consider sending an e-mail to the above person to thank him._

