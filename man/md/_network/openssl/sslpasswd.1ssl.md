# passwd(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-passwd, passwd - compute password hashes

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl passwd [-help] [-crypt] [-1] [-apr1] [-aixmd5] [-5] [-6] [-salt string] [-in file] [-stdin] [-noverify] [-quiet] [-table] [-rand file...] [-writerand file] {password}
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **passwd** command computes the hash of a password typed at
run-time or the hash of each password in a list.  The password list is
taken from the named file for option **-in file**, from stdin for
option **-stdin**, or from the command line, or from the terminal otherwise.
The Unix standard algorithm **crypt** and the MD5-based \s-1BSD\s0 password
algorithm **1**, its Apache variant **apr1**, and its \s-1AIX\s0 variant are available.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-crypt**  
  .IX Item "-crypt"
  Use the **crypt** algorithm (default).
* **-1**  
  .IX Item "-1"
  Use the \s-1MD5\s0 based \s-1BSD\s0 password algorithm **1**.
* **-apr1**  
  .IX Item "-apr1"
  Use the **apr1** algorithm (Apache variant of the \s-1BSD\s0 algorithm).
* **-aixmd5**  
  .IX Item "-aixmd5"
  Use the **\s-1AIX MD5\s0** algorithm (\s-1AIX\s0 variant of the \s-1BSD\s0 algorithm).
* **-5**  
  .IX Item "-5"
* **-6**  
  .IX Item "-6"
  Use the **\s-1SHA256\s0** / **\s-1SHA512\s0** based algorithms defined by Ulrich Drepper.
  See &lt;https://www.akkadia.org/drepper/SHA-crypt.txt&gt;.
* **-salt** _string_  
  .IX Item "-salt string"
  Use the specified salt.
  When reading a password from the terminal, this implies **-noverify**.
* **-in** _file_  
  .IX Item "-in file"
  Read passwords from _file_.
* **-stdin**  
  .IX Item "-stdin"
  Read passwords from **stdin**.
* **-noverify**  
  .IX Item "-noverify"
  Don't verify when reading a password from the terminal.
* **-quiet**  
  .IX Item "-quiet"
  Don't output warnings when passwords given at the command line are truncated.
* **-table**  
  .IX Item "-table"
  In the output list, prepend the cleartext password and a \s-1TAB\s0 character
  to each password hash.
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

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
.Vb 2
  % openssl passwd -crypt -salt xx password
  xxj31ZMTZzkVA

  % openssl passwd -1 -salt xxxxxxxx password
  $1$xxxxxxxx$UYCIxa628.9qXjpQCjM4a.

  % openssl passwd -apr1 -salt xxxxxxxx password
  $apr1$xxxxxxxx$dxHfLAsjHkDRmG83UXe8K0

  % openssl passwd -aixmd5 -salt xxxxxxxx password
  xxxxxxxx$8Oaipk/GPKhC64w/YVeFD/
.Ve

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
