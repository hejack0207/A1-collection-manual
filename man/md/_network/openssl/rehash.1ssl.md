# rehash(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-c_rehash, openssl-rehash, c_rehash, rehash - Create symbolic links to files named by the hash values

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl rehash [-h] [-help] [-old] [-n] [-v] [ directory...] 
 c_rehash flags...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
On some platforms, the OpenSSL **rehash** command is available as
an external script called **c\_rehash**.  They are functionally equivalent,
except for minor differences noted below.

**rehash** scans directories and calculates a hash value of each
\f(CW`.pem\*(C', \f(CW\*(C\`.crt\*(C', \f(CW\*(C\`.cer\*(C', or \f(CW\*(C\`.crl\*(C'
file in the specified directory list and creates symbolic links
for each file, where the name of the link is the hash value.
(If the platform does not support symbolic links, a copy is made.)
This utility is useful as many programs that use OpenSSL require
directories to be set up like this in order to find certificates.

If any directories are named on the command line, then those are
processed in turn. If not, then the **\s-1SSL\_CERT\_DIR\s0** environment variable
is consulted; this should be a colon-separated list of directories,
like the Unix **\s-1PATH\s0** variable.
If that is not set then the default directory (installation-specific
but often **/usr/local/ssl/certs**) is processed.

In order for a directory to be processed, the user must have write
permissions on that directory, otherwise an error will be generated.

The links created are of the form \f(CW`HHHHHHHH.D\*(C', where each **H**
is a hexadecimal character and **D** is a single decimal digit.
When processing a directory, **rehash** will first remove all links
that have a name in that syntax, even if they are being used for some
other purpose.
To skip the removal step, use the **-n** flag.
Hashes for \s-1CRL\s0's look similar except the letter **r** appears after
the period, like this: \f(CW`HHHHHHHH.rD\*(C'.

Multiple objects may have the same hash; they will be indicated by
incrementing the **D** value. Duplicates are found by comparing the
full \s-1SHA-1\s0 fingerprint. A warning will be displayed if a duplicate
is found.

A warning will also be displayed if there are files that
cannot be parsed as either a certificate or a \s-1CRL\s0 or if
more than one such object appears in the file.

<a name="script-configuration"></a>

### Script Configuration

.IX Subsection "Script Configuration"
The **c\_rehash** script
uses the **openssl** program to compute the hashes and
fingerprints. If not found in the user's **\s-1PATH\s0**, then set the
**\s-1OPENSSL\s0** environment variable to the full pathname.
Any program can be used, it will be invoked as follows for either
a certificate or \s-1CRL:\s0

.Vb 2
  $OPENSSL x509 -hash -fingerprint -noout -in FILENAME
  $OPENSSL crl -hash -fingerprint -noout -in FILENAME
.Ve

where **\s-1FILENAME\s0** is the filename. It must output the hash of the
file on the first line, and the fingerprint on the second,
optionally prefixed with some text and an equals sign.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help** **-h**  
  .IX Item "-help -h"
  Display a brief usage message.
* **-old**  
  .IX Item "-old"
  Use old-style hashing (\s-1MD5,\s0 as opposed to \s-1SHA-1\s0) for generating
  links to be used for releases before 1.0.0.
  Note that current versions will not use the old style.
* **-n**  
  .IX Item "-n"
  Do not remove existing links.
  This is needed when keeping new and old-style links in the same directory.
* **-compat**  
  .IX Item "-compat"
  Generate links for both old-style (\s-1MD5\s0) and new-style (\s-1SHA1\s0) hashing.
  This allows releases before 1.0.0 to use these links along-side newer
  releases.
* **-v**  
  .IX Item "-v"
  Print messages about old links removed and new links created.
  By default, **rehash** only lists each directory as it is processed.

<a name="environment"></a>

# Environment

.IX Header "ENVIRONMENT"

* **\s-1OPENSSL\s0**  
  .IX Item "OPENSSL"
  The path to an executable to use to generate hashes and
  fingerprints (see above).
* **\s-1SSL\_CERT\_DIR\s0**  
  .IX Item "SSL_CERT_DIR"
  Colon separated list of directories to operate on.
  Ignored if directories are listed on the command line.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**openssl**\|(1),
**crl**\|(1).
**x509**\|(1).

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2015-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
