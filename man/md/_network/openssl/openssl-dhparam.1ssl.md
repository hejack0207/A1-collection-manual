# dhparam(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-dhparam, dhparam - DH parameter manipulation and generation

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl dhparam [-help] [-inform DER|PEM] [-outform DER|PEM] [-in filename] [-out filename] [-dsaparam] [-check] [-noout] [-text] [-C] [-2] [-5] [-rand file...] [-writerand file] [-engine id] [numbits]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This command is used to manipulate \s-1DH\s0 parameter files.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format. The **\s-1DER\s0** option uses an \s-1ASN1 DER\s0 encoded
  form compatible with the PKCS#3 DHparameter structure. The \s-1PEM\s0 form is the
  default format: it consists of the **\s-1DER\s0** format base64 encoded with
  additional header and footer lines.
* **-outform DER|PEM**  
  .IX Item "-outform DER|PEM"
  This specifies the output format, the options have the same meaning and default
  as the **-inform** option.
* **-in** _filename_  
  .IX Item "-in filename"
  This specifies the input filename to read parameters from or standard input if
  this option is not specified.
* **-out** _filename_  
  .IX Item "-out filename"
  This specifies the output filename parameters to. Standard output is used
  if this option is not present. The output filename should **not** be the same
  as the input filename.
* **-dsaparam**  
  .IX Item "-dsaparam"
  If this option is used, \s-1DSA\s0 rather than \s-1DH\s0 parameters are read or created;
  they are converted to \s-1DH\s0 format.  Otherwise, strong\*(R" primes (such
  that (p-1)/2 is also prime) will be used for \s-1DH\s0 parameter generation.
  .Sp
  \s-1DH\s0 parameter generation with the **-dsaparam** option is much faster,
  and the recommended exponent length is shorter, which makes \s-1DH\s0 key
  exchange more efficient.  Beware that with such DSA-style \s-1DH\s0
  parameters, a fresh \s-1DH\s0 key should be created for each use to
  avoid small-subgroup attacks that may be possible otherwise.
* **-check**  
  .IX Item "-check"
  Performs numerous checks to see if the supplied parameters are valid and
  displays a warning if not.
* **-2**, **-5**  
  .IX Item "-2, -5"
  The generator to use, either 2 or 5. If present then the
  input file is ignored and parameters are generated instead. If not
  present but **numbits** is present, parameters are generated with the
  default generator 2.
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
* _numbits_  
  .IX Item "numbits"
  This option specifies that a parameter set should be generated of size
  _numbits_. It must be the last option. If this option is present then
  the input file is ignored and parameters are generated instead. If
  this option is not present but a generator (**-2** or **-5**) is
  present, parameters are generated with a default length of 2048 bits.
* **-noout**  
  .IX Item "-noout"
  This option inhibits the output of the encoded version of the parameters.
* **-text**  
  .IX Item "-text"
  This option prints out the \s-1DH\s0 parameters in human readable form.
* **-C**  
  .IX Item "-C"
  This option converts the parameters into C code. The parameters can then
  be loaded by calling the **get\_dhNNNN()** function.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **dhparam**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.

<a name="warnings"></a>

# Warnings

.IX Header "WARNINGS"
The program **dhparam** combines the functionality of the programs **dh** and
**gendh** in previous versions of OpenSSL. The **dh** and **gendh**
programs are retained for now but may have different purposes in future
versions of OpenSSL.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
\s-1PEM\s0 format \s-1DH\s0 parameters use the header and footer lines:

.Vb 2
 -----BEGIN DH PARAMETERS-----
 -----END DH PARAMETERS-----
.Ve

OpenSSL currently only supports the older PKCS#3 \s-1DH,\s0 not the newer X9.42
\s-1DH.\s0

This program manipulates \s-1DH\s0 parameters not keys.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
There should be a way to generate and manipulate \s-1DH\s0 keys.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**dsaparam**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
