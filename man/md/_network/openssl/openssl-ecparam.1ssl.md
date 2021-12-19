# ecparam(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-ecparam, ecparam - EC parameter manipulation and generation

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl ecparam [-help] [-inform DER|PEM] [-outform DER|PEM] [-in filename] [-out filename] [-noout] [-text] [-C] [-check] [-name arg] [-list_curves] [-conv_form arg] [-param_enc arg] [-no_seed] [-rand file...] [-writerand file] [-genkey] [-engine id]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This command is used to manipulate or generate \s-1EC\s0 parameter files.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format. The **\s-1DER\s0** option uses an \s-1ASN.1 DER\s0 encoded
  form compatible with \s-1RFC 3279\s0 EcpkParameters. The \s-1PEM\s0 form is the default
  format: it consists of the **\s-1DER\s0** format base64 encoded with additional
  header and footer lines.
* **-outform DER|PEM**  
  .IX Item "-outform DER|PEM"
  This specifies the output format, the options have the same meaning and default
  as the **-inform** option.
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read parameters from or standard input if
  this option is not specified.
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
  This option prints out the \s-1EC\s0 parameters in human readable form.
* **-C**  
  .IX Item "-C"
  This option converts the \s-1EC\s0 parameters into C code. The parameters can then
  be loaded by calling the **get\_ec\_group\_XXX()** function.
* **-check**  
  .IX Item "-check"
  Validate the elliptic curve parameters.
* **-name arg**  
  .IX Item "-name arg"
  Use the \s-1EC\s0 parameters with the specified 'short' name. Use **-list\_curves**
  to get a list of all currently implemented \s-1EC\s0 parameters.
* **-list\_curves**  
  .IX Item "-list_curves"
  If this options is specified **ecparam** will print out a list of all
  currently implemented \s-1EC\s0 parameters names and exit.
* **-conv\_form**  
  .IX Item "-conv_form"
  This specifies how the points on the elliptic curve are converted
  into octet strings. Possible values are: **compressed**, **uncompressed** (the
  default value) and **hybrid**. For more information regarding
  the point conversion forms please read the X9.62 standard.
  **Note** Due to patent issues the **compressed** option is disabled
  by default for binary curves and can be enabled by defining
  the preprocessor macro **\s-1OPENSSL\_EC\_BIN\_PT\_COMP\s0** at compile time.
* **-param_enc arg**  
  .IX Item "-param_enc arg"
  This specifies how the elliptic curve parameters are encoded.
  Possible value are: **named\_curve**, i.e. the ec parameters are
  specified by an \s-1OID,\s0 or **explicit** where the ec parameters are
  explicitly given (see \s-1RFC 3279\s0 for the definition of the
  \s-1EC\s0 parameters structures). The default value is **named\_curve**.
  **Note** the **implicitlyCA** alternative, as specified in \s-1RFC 3279,\s0
  is currently not implemented in OpenSSL.
* **-no\_seed**  
  .IX Item "-no_seed"
  This option inhibits that the 'seed' for the parameter generation
  is included in the ECParameters structure (see \s-1RFC 3279\s0).
* **-genkey**  
  .IX Item "-genkey"
  This option will generate an \s-1EC\s0 private key using the specified parameters.
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
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **ecparam**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
\s-1PEM\s0 format \s-1EC\s0 parameters use the header and footer lines:

.Vb 2
 -----BEGIN EC PARAMETERS-----
 -----END EC PARAMETERS-----
.Ve

OpenSSL is currently not able to generate new groups and therefore
**ecparam** can only create \s-1EC\s0 parameters from known (named) curves.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
To create \s-1EC\s0 parameters with the group 'prime192v1':

.Vb 1
  openssl ecparam -out ec_param.pem -name prime192v1
.Ve

To create \s-1EC\s0 parameters with explicit parameters:

.Vb 1
  openssl ecparam -out ec_param.pem -name prime192v1 -param_enc explicit
.Ve

To validate given \s-1EC\s0 parameters:

.Vb 1
  openssl ecparam -in ec_param.pem -check
.Ve

To create \s-1EC\s0 parameters and a private key:

.Vb 1
  openssl ecparam -out ec_key.pem -name prime192v1 -genkey
.Ve

To change the point encoding to 'compressed':

.Vb 1
  openssl ecparam -in ec_in.pem -out ec_out.pem -conv_form compressed
.Ve

To print out the \s-1EC\s0 parameters to standard output:

.Vb 1
  openssl ecparam -in ec_param.pem -noout -text
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ec**\|(1), **dsaparam**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2003-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
