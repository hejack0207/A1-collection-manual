# genpkey(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-genpkey, genpkey - generate a private key

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl genpkey [-help] [-out filename] [-outform PEM|DER] [-pass arg] [-\f(BIcipher] [-engine id] [-paramfile file] [-algorithm alg] [-pkeyopt opt:value] [-genparam] [-text]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **genpkey** command generates a private key.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-out filename**  
  .IX Item "-out filename"
  Output the key to the specified file. If this argument is not specified then
  standard output is used.
* **-outform DER|PEM**  
  .IX Item "-outform DER|PEM"
  This specifies the output format \s-1DER\s0 or \s-1PEM.\s0 The default format is \s-1PEM.\s0
* **-pass arg**  
  .IX Item "-pass arg"
  The output file password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-\f(BIcipher**  
  .IX Item "-cipher"
  This option encrypts the private key with the supplied cipher. Any algorithm
  name accepted by **EVP\_get\_cipherbyname()** is acceptable such as **des3**.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **genpkey**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms. If used this option should precede all other
  options.
* **-algorithm alg**  
  .IX Item "-algorithm alg"
  Public key algorithm to use such as \s-1RSA, DSA\s0 or \s-1DH.\s0 If used this option must
  precede any **-pkeyopt** options. The options **-paramfile** and **-algorithm**
  are mutually exclusive. Engines may add algorithms in addition to the standard
  built-in ones.
  .Sp
  Valid built-in algorithm names for private key generation are \s-1RSA,\s0 RSA-PSS, \s-1EC,
  X25519, X448, ED25519\s0 and \s-1ED448.\s0
  .Sp
  Valid built-in algorithm names for parameter generation (see the **-genparam**
  option) are \s-1DH, DSA\s0 and \s-1EC.\s0
  .Sp
  Note that the algorithm name X9.42 \s-1DH\s0 may be used as a synonym for the \s-1DH\s0
  algorithm. These are identical and do not indicate the type of parameters that
  will be generated. Use the **dh\_paramgen\_type** option to indicate whether PKCS#3
  or X9.42 \s-1DH\s0 parameters are required. See \s-1DH\s0 Parameter Generation Options\*(R"
  below for more details.
* **-pkeyopt opt:value**  
  .IX Item "-pkeyopt opt:value"
  Set the public key algorithm option **opt** to **value**. The precise set of
  options supported depends on the public key algorithm used and its
  implementation. See \s-1KEY GENERATION OPTIONS\*(R"\s0 and
  \s-1PARAMETER GENERATION OPTIONS\*(R"\s0 below for more details.
* **-genparam**  
  .IX Item "-genparam"
  Generate a set of parameters instead of a private key. If used this option must
  precede any **-algorithm**, **-paramfile** or **-pkeyopt** options.
* **-paramfile filename**  
  .IX Item "-paramfile filename"
  Some public key algorithms generate a private key based on a set of parameters.
  They can be supplied using this option. If this option is used the public key
  algorithm used is determined by the parameters. If used this option must
  precede any **-pkeyopt** options. The options **-paramfile** and **-algorithm**
  are mutually exclusive.
* **-text**  
  .IX Item "-text"
  Print an (unencrypted) text representation of private and public keys and
  parameters along with the \s-1PEM\s0 or \s-1DER\s0 structure.

<a name="key-generation-options"></a>

# Key Generation Options

.IX Header "KEY GENERATION OPTIONS"
The options supported by each algorithm and indeed each implementation of an
algorithm can vary. The options for the OpenSSL implementations are detailed
below. There are no key generation options defined for the X25519, X448, \s-1ED25519\s0
or \s-1ED448\s0 algorithms.

<a name="s-1rsas0-key-generation-options"></a>

### \s-1RSA\s0 Key Generation Options

.IX Subsection "RSA Key Generation Options"

* **rsa\_keygen\_bits:numbits**  
  .IX Item "rsa_keygen_bits:numbits"
  The number of bits in the generated key. If not specified 2048 is used.
* **rsa\_keygen\_primes:numprimes**  
  .IX Item "rsa_keygen_primes:numprimes"
  The number of primes in the generated key. If not specified 2 is used.
* **rsa\_keygen\_pubexp:value**  
  .IX Item "rsa_keygen_pubexp:value"
  The \s-1RSA\s0 public exponent value. This can be a large decimal or
  hexadecimal value if preceded by **0x**. Default value is 65537.

<a name="rsa-pss-key-generation-options"></a>

### RSA-PSS Key Generation Options

.IX Subsection "RSA-PSS Key Generation Options"
Note: by default an **RSA-PSS** key has no parameter restrictions.

* **rsa\_keygen\_bits:numbits**, **rsa\_keygen\_primes:numprimes**,  **rsa\_keygen\_pubexp:value**  
  .IX Item "rsa_keygen_bits:numbits, rsa_keygen_primes:numprimes, rsa_keygen_pubexp:value"
  These options have the same meaning as the **\s-1RSA\s0** algorithm.
* **rsa\_pss\_keygen\_md:digest**  
  .IX Item "rsa_pss_keygen_md:digest"
  If set the key is restricted and can only use **digest** for signing.
* **rsa\_pss\_keygen\_mgf1\_md:digest**  
  .IX Item "rsa_pss_keygen_mgf1_md:digest"
  If set the key is restricted and can only use **digest** as it's \s-1MGF1\s0
  parameter.
* **rsa\_pss\_keygen\_saltlen:len**  
  .IX Item "rsa_pss_keygen_saltlen:len"
  If set the key is restricted and **len** specifies the minimum salt length.

<a name="s-1ecs0-key-generation-options"></a>

### \s-1EC\s0 Key Generation Options

.IX Subsection "EC Key Generation Options"
The \s-1EC\s0 key generation options can also be used for parameter generation.

* **ec\_paramgen\_curve:curve**  
  .IX Item "ec_paramgen_curve:curve"
  The \s-1EC\s0 curve to use. OpenSSL supports \s-1NIST\s0 curve names such as P-256\*(R".
* **ec\_param\_enc:encoding**  
  .IX Item "ec_param_enc:encoding"
  The encoding to use for parameters. The encoding\*(R" parameter must be either
  named_curve\*(R" or \*(L"explicit\*(R". The default value is \*(L"named_curve\*(R".

<a name="parameter-generation-options"></a>

# Parameter Generation Options

.IX Header "PARAMETER GENERATION OPTIONS"
The options supported by each algorithm and indeed each implementation of an
algorithm can vary. The options for the OpenSSL implementations are detailed
below.

<a name="s-1dsas0-parameter-generation-options"></a>

### \s-1DSA\s0 Parameter Generation Options

.IX Subsection "DSA Parameter Generation Options"

* **dsa\_paramgen\_bits:numbits**  
  .IX Item "dsa_paramgen_bits:numbits"
  The number of bits in the generated prime. If not specified 2048 is used.
* **dsa\_paramgen\_q\_bits:numbits**  
  .IX Item "dsa_paramgen_q_bits:numbits"
  The number of bits in the q parameter. Must be one of 160, 224 or 256. If not
  specified 224 is used.
* **dsa\_paramgen\_md:digest**  
  .IX Item "dsa_paramgen_md:digest"
  The digest to use during parameter generation. Must be one of **sha1**, **sha224**
  or **sha256**. If set, then the number of bits in **q** will match the output size
  of the specified digest and the **dsa\_paramgen\_q\_bits** parameter will be
  ignored. If not set, then a digest will be used that gives an output matching
  the number of bits in **q**, i.e. **sha1** if q length is 160, **sha224** if it 224
  or **sha256** if it is 256.

<a name="s-1dhs0-parameter-generation-options"></a>

### \s-1DH\s0 Parameter Generation Options

.IX Subsection "DH Parameter Generation Options"

* **dh\_paramgen\_prime\_len:numbits**  
  .IX Item "dh_paramgen_prime_len:numbits"
  The number of bits in the prime parameter **p**. The default is 2048.
* **dh\_paramgen\_subprime\_len:numbits**  
  .IX Item "dh_paramgen_subprime_len:numbits"
  The number of bits in the sub prime parameter **q**. The default is 256 if the
  prime is at least 2048 bits long or 160 otherwise. Only relevant if used in
  conjunction with the **dh\_paramgen\_type** option to generate X9.42 \s-1DH\s0 parameters.
* **dh\_paramgen\_generator:value**  
  .IX Item "dh_paramgen_generator:value"
  The value to use for the generator **g**. The default is 2.
* **dh\_paramgen\_type:value**  
  .IX Item "dh_paramgen_type:value"
  The type of \s-1DH\s0 parameters to generate. Use 0 for PKCS#3 \s-1DH\s0 and 1 for X9.42 \s-1DH.\s0
  The default is 0.
* **dh\_rfc5114:num**  
  .IX Item "dh_rfc5114:num"
  If this option is set, then the appropriate \s-1RFC5114\s0 parameters are used
  instead of generating new parameters. The value **num** can take the
  values 1, 2 or 3 corresponding to \s-1RFC5114 DH\s0 parameters consisting of
  1024 bit group with 160 bit subgroup, 2048 bit group with 224 bit subgroup
  and 2048 bit group with 256 bit subgroup as mentioned in \s-1RFC5114\s0 sections
  2.1, 2.2 and 2.3 respectively. If present this overrides all other \s-1DH\s0 parameter
  options.

<a name="s-1ecs0-parameter-generation-options"></a>

### \s-1EC\s0 Parameter Generation Options

.IX Subsection "EC Parameter Generation Options"
The \s-1EC\s0 parameter generation options are the same as for key generation. See
\s-1EC\s0 Key Generation Options\*(R" above.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The use of the genpkey program is encouraged over the algorithm specific
utilities because additional algorithm options and \s-1ENGINE\s0 provided algorithms
can be used.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Generate an \s-1RSA\s0 private key using default parameters:

.Vb 1
 openssl genpkey -algorithm RSA -out key.pem
.Ve

Encrypt output private key using 128 bit \s-1AES\s0 and the passphrase hello\*(R":

.Vb 1
 openssl genpkey -algorithm RSA -out key.pem -aes-128-cbc -pass pass:hello
.Ve

Generate a 2048 bit \s-1RSA\s0 key using 3 as the public exponent:

.Vb 2
 openssl genpkey -algorithm RSA -out key.pem \e
     -pkeyopt rsa_keygen_bits:2048 -pkeyopt rsa_keygen_pubexp:3
.Ve

Generate 2048 bit \s-1DSA\s0 parameters:

.Vb 2
 openssl genpkey -genparam -algorithm DSA -out dsap.pem \e
     -pkeyopt dsa_paramgen_bits:2048
.Ve

Generate \s-1DSA\s0 key from parameters:

.Vb 1
 openssl genpkey -paramfile dsap.pem -out dsakey.pem
.Ve

Generate 2048 bit \s-1DH\s0 parameters:

.Vb 2
 openssl genpkey -genparam -algorithm DH -out dhp.pem \e
     -pkeyopt dh_paramgen_prime_len:2048
.Ve

Generate 2048 bit X9.42 \s-1DH\s0 parameters:

.Vb 3
 openssl genpkey -genparam -algorithm DH -out dhpx.pem \e
     -pkeyopt dh_paramgen_prime_len:2048 \e
     -pkeyopt dh_paramgen_type:1
.Ve

Output \s-1RFC5114 2048\s0 bit \s-1DH\s0 parameters with 224 bit subgroup:

.Vb 1
 openssl genpkey -genparam -algorithm DH -out dhp.pem -pkeyopt dh_rfc5114:2
.Ve

Generate \s-1DH\s0 key from parameters:

.Vb 1
 openssl genpkey -paramfile dhp.pem -out dhkey.pem
.Ve

Generate \s-1EC\s0 parameters:

.Vb 3
 openssl genpkey -genparam -algorithm EC -out ecp.pem \e
        -pkeyopt ec_paramgen_curve:secp384r1 \e
        -pkeyopt ec_param_enc:named_curve
.Ve

Generate \s-1EC\s0 key from parameters:

.Vb 1
 openssl genpkey -paramfile ecp.pem -out eckey.pem
.Ve

Generate \s-1EC\s0 key directly:

.Vb 3
 openssl genpkey -algorithm EC -out eckey.pem \e
        -pkeyopt ec_paramgen_curve:P-384 \e
        -pkeyopt ec_param_enc:named_curve
.Ve

Generate an X25519 private key:

.Vb 1
 openssl genpkey -algorithm X25519 -out xkey.pem
.Ve

Generate an \s-1ED448\s0 private key:

.Vb 1
 openssl genpkey -algorithm ED448 -out xkey.pem
.Ve

<a name="history"></a>

# History

.IX Header "HISTORY"
The ability to use \s-1NIST\s0 curve names, and to generate an \s-1EC\s0 key directly,
were added in OpenSSL 1.0.2.
The ability to generate X25519 keys was added in OpenSSL 1.1.0.
The ability to generate X448, \s-1ED25519\s0 and \s-1ED448\s0 keys was added in OpenSSL 1.1.1.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2006-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
