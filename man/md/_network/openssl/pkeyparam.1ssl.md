# pkeyparam(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-pkeyparam, pkeyparam - public key algorithm parameter processing tool

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl pkeyparam [-help] [-in filename] [-out filename] [-text] [-noout] [-engine id] [-check]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **pkeyparam** command processes public key algorithm parameters.
They can be checked for correctness and their components printed out.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read parameters from or standard input if
  this option is not specified.
* **-out filename**  
  .IX Item "-out filename"
  This specifies the output filename to write parameters to or standard output if
  this option is not specified.
* **-text**  
  .IX Item "-text"
  Prints out the parameters in plain text in addition to the encoded version.
* **-noout**  
  .IX Item "-noout"
  Do not output the encoded version of the parameters.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **pkeyparam**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.
* **-check**  
  .IX Item "-check"
  This option checks the correctness of parameters.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Print out text version of parameters:

.Vb 1
 openssl pkeyparam -in param.pem -text
.Ve

<a name="notes"></a>

# Notes

.IX Header "NOTES"
There are no **-inform** or **-outform** options for this command because only
\s-1PEM\s0 format is supported because the key type is determined by the \s-1PEM\s0 headers.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**genpkey**\|(1), **rsa**\|(1), **pkcs8**\|(1),
**dsa**\|(1), **genrsa**\|(1), **gendsa**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2006-2019 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
