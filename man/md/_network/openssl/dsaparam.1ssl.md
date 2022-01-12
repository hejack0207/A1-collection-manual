# dsaparam(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-dsaparam, dsaparam - DSA parameter manipulation and generation

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl dsaparam [-help] [-inform DER|PEM] [-outform DER|PEM] [-in filename] [-out filename] [-noout] [-text] [-C] [-rand file...] [-writerand file] [-genkey] [-engine id] [numbits]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This command is used to manipulate or generate \s-1DSA\s0 parameter files.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format. The **\s-1DER\s0** option uses an \s-1ASN1 DER\s0 encoded
  form compatible with \s-1RFC2459\s0 (\s-1PKIX\s0) DSS-Parms that is a \s-1SEQUENCE\s0 consisting
  of p, q and g respectively. The \s-1PEM\s0 form is the default format: it consists
  of the **\s-1DER\s0** format base64 encoded with additional header and footer lines.
* **-outform DER|PEM**  
  .IX Item "-outform DER|PEM"
  This specifies the output format, the options have the same meaning and default
  as the **-inform** option.
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read parameters from or standard input if
  this option is not specified. If the **numbits** parameter is included then
  this option will be ignored.
* **-out filename**  
  .IX Item "-out filename"
  This specifies the output filename parameters to. Standard output is used
  if this option is not present. The output filename should **not** be the same
  as the input filename.
* **-noout**  
  .IX Item "-noout"
  This option inhibits the output of the encoded version of the parameters.
* **-text**  
  .IX Item "-text"
  This option prints out the \s-1DSA\s0 parameters in human readable form.
* **-C**  
  .IX Item "-C"
  This option converts the parameters into C code. The parameters can then
  be loaded by calling the **get\_dsaXXX()** function.
* **-genkey**  
  .IX Item "-genkey"
  This option will generate a \s-1DSA\s0 either using the specified or generated
  parameters.
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
* **numbits**  
  .IX Item "numbits"
  This option specifies that a parameter set should be generated of size
  **numbits**. It must be the last option. If this option is included then
  the input file (if any) is ignored.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **dsaparam**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
\s-1PEM\s0 format \s-1DSA\s0 parameters use the header and footer lines:

.Vb 2
 -----BEGIN DSA PARAMETERS-----
 -----END DSA PARAMETERS-----
.Ve

\s-1DSA\s0 parameter generation is a slow process and as a result the same set of
\s-1DSA\s0 parameters is often used to generate several distinct keys.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**gendsa**\|(1), **dsa**\|(1), **genrsa**\|(1),
**rsa**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2017 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
