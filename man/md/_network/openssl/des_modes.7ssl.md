# des_modes(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

des_modes - the variants of DES and other crypto algorithms of OpenSSL

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Several crypto algorithms for OpenSSL can be used in a number of modes.  Those
are used for using block ciphers in a way similar to stream ciphers, among
other things.

<a name="overview"></a>

# Overview

.IX Header "OVERVIEW"

<a name="electronic-codebook-mode-s-1ecbs0"></a>

### Electronic Codebook Mode (\s-1ECB\s0)

.IX Subsection "Electronic Codebook Mode (ECB)"
Normally, this is found as the function _algorithm_**\_ecb\_encrypt()**.

* ·  
  64 bits are enciphered at a time.
* ·  
  The order of the blocks can be rearranged without detection.
* ·  
  The same plaintext block always produces the same ciphertext block
  (for the same key) making it vulnerable to a 'dictionary attack'.
* ·  
  An error will only affect one ciphertext block.

<a name="cipher-block-chaining-mode-s-1cbcs0"></a>

### Cipher Block Chaining Mode (\s-1CBC\s0)

.IX Subsection "Cipher Block Chaining Mode (CBC)"
Normally, this is found as the function _algorithm_**\_cbc\_encrypt()**.
Be aware that **des\_cbc\_encrypt()** is not really \s-1DES CBC\s0 (it does
not update the \s-1IV\s0); use **des\_ncbc\_encrypt()** instead.

* ·  
  a multiple of 64 bits are enciphered at a time.
* ·  
  The \s-1CBC\s0 mode produces the same ciphertext whenever the same
  plaintext is encrypted using the same key and starting variable.
* ·  
  The chaining operation makes the ciphertext blocks dependent on the
  current and all preceding plaintext blocks and therefore blocks can not
  be rearranged.
* ·  
  The use of different starting variables prevents the same plaintext
  enciphering to the same ciphertext.
* ·  
  An error will affect the current and the following ciphertext blocks.

<a name="cipher-feedback-mode-s-1cfbs0"></a>

### Cipher Feedback Mode (\s-1CFB\s0)

.IX Subsection "Cipher Feedback Mode (CFB)"
Normally, this is found as the function _algorithm_**\_cfb\_encrypt()**.

* ·  
  a number of bits (j) &lt;= 64 are enciphered at a time.
* ·  
  The \s-1CFB\s0 mode produces the same ciphertext whenever the same
  plaintext is encrypted using the same key and starting variable.
* ·  
  The chaining operation makes the ciphertext variables dependent on the
  current and all preceding variables and therefore j-bit variables are
  chained together and can not be rearranged.
* ·  
  The use of different starting variables prevents the same plaintext
  enciphering to the same ciphertext.
* ·  
  The strength of the \s-1CFB\s0 mode depends on the size of k (maximal if
  j == k).  In my implementation this is always the case.
* ·  
  Selection of a small value for j will require more cycles through
  the encipherment algorithm per unit of plaintext and thus cause
  greater processing overheads.
* ·  
  Only multiples of j bits can be enciphered.
* ·  
  An error will affect the current and the following ciphertext variables.

<a name="output-feedback-mode-s-1ofbs0"></a>

### Output Feedback Mode (\s-1OFB\s0)

.IX Subsection "Output Feedback Mode (OFB)"
Normally, this is found as the function _algorithm_**\_ofb\_encrypt()**.

* ·  
  a number of bits (j) &lt;= 64 are enciphered at a time.
* ·  
  The \s-1OFB\s0 mode produces the same ciphertext whenever the same
  plaintext enciphered using the same key and starting variable.  More
  over, in the \s-1OFB\s0 mode the same key stream is produced when the same
  key and start variable are used.  Consequently, for security reasons
  a specific start variable should be used only once for a given key.
* ·  
  The absence of chaining makes the \s-1OFB\s0 more vulnerable to specific attacks.
* ·  
  The use of different start variables values prevents the same
  plaintext enciphering to the same ciphertext, by producing different
  key streams.
* ·  
  Selection of a small value for j will require more cycles through
  the encipherment algorithm per unit of plaintext and thus cause
  greater processing overheads.
* ·  
  Only multiples of j bits can be enciphered.
* ·  
  \s-1OFB\s0 mode of operation does not extend ciphertext errors in the
  resultant plaintext output.  Every bit error in the ciphertext causes
  only one bit to be in error in the deciphered plaintext.
* ·  
  \s-1OFB\s0 mode is not self-synchronizing.  If the two operation of
  encipherment and decipherment get out of synchronism, the system needs
  to be re-initialized.
* ·  
  Each re-initialization should use a value of the start variable
  different from the start variable values used before with the same
  key.  The reason for this is that an identical bit stream would be
  produced each time from the same parameters.  This would be
  susceptible to a 'known plaintext' attack.

<a name="triple-s-1ecbs0-mode"></a>

### Triple \s-1ECB\s0 Mode

.IX Subsection "Triple ECB Mode"
Normally, this is found as the function _algorithm_**\_ecb3\_encrypt()**.

* ·  
  Encrypt with key1, decrypt with key2 and encrypt with key3 again.
* ·  
  As for \s-1ECB\s0 encryption but increases the key length to 168 bits.
  There are theoretic attacks that can be used that make the effective
  key length 112 bits, but this attack also requires 2^56 blocks of
  memory, not very likely, even for the \s-1NSA.\s0
* ·  
  If both keys are the same it is equivalent to encrypting once with
  just one key.
* ·  
  If the first and last key are the same, the key length is 112 bits.
  There are attacks that could reduce the effective key strength
  to only slightly more than 56 bits, but these require a lot of memory.
* ·  
  If all 3 keys are the same, this is effectively the same as normal
  ecb mode.

<a name="triple-s-1cbcs0-mode"></a>

### Triple \s-1CBC\s0 Mode

.IX Subsection "Triple CBC Mode"
Normally, this is found as the function _algorithm_**\_ede3\_cbc\_encrypt()**.

* ·  
  Encrypt with key1, decrypt with key2 and then encrypt with key3.
* ·  
  As for \s-1CBC\s0 encryption but increases the key length to 168 bits with
  the same restrictions as for triple ecb mode.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
This text was been written in large parts by Eric Young in his original
documentation for SSLeay, the predecessor of OpenSSL.  In turn, he attributed
it to:

.Vb 5
        AS 2805.5.2
        Australian Standard
        Electronic funds transfer - Requirements for interfaces,
        Part 5.2: Modes of operation for an n-bit block cipher algorithm
        Appendix A
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**BF\_encrypt**\|(3), **DES\_crypt**\|(3)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
