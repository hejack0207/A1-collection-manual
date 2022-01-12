# s_time(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-s_time, s_time - SSL/TLS performance timing program

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl s_time [-help] [-connect host:port] [-www page] [-cert filename] [-key filename] [-CApath directory] [-CAfile filename] [-no-CAfile] [-no-CApath] [-reuse] [-new] [-verify depth] [-nameopt option] [-time seconds] [-ssl3] [-bugs] [-cipher cipherlist] [-ciphersuites val]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **s\_time** command implements a generic \s-1SSL/TLS\s0 client which connects to a
remote host using \s-1SSL/TLS.\s0 It can request a page from the server and includes
the time to transfer the payload data in its timing measurements. It measures
the number of connections within a given timeframe, the amount of data
transferred (if any), and calculates the average time spent for one connection.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-connect host:port**  
  .IX Item "-connect host:port"
  This specifies the host and optional port to connect to.
* **-www page**  
  .IX Item "-www page"
  This specifies the page to \s-1GET\s0 from the server. A value of '/' gets the
  index.htm[l] page. If this parameter is not specified, then **s\_time** will only
  perform the handshake to establish \s-1SSL\s0 connections but not transfer any
  payload data.
* **-cert certname**  
  .IX Item "-cert certname"
  The certificate to use, if one is requested by the server. The default is
  not to use a certificate. The file is in \s-1PEM\s0 format.
* **-key keyfile**  
  .IX Item "-key keyfile"
  The private key to use. If not specified then the certificate file will
  be used. The file is in \s-1PEM\s0 format.
* **-verify depth**  
  .IX Item "-verify depth"
  The verify depth to use. This specifies the maximum length of the
  server certificate chain and turns on server certificate verification.
  Currently the verify operation continues after errors so all the problems
  with a certificate chain can be seen. As a side effect the connection
  will never fail due to a server certificate verify failure.
* **-nameopt option**  
  .IX Item "-nameopt option"
  Option which determines how the subject or issuer names are displayed. The
  **option** argument can be a single option or multiple options separated by
  commas.  Alternatively the **-nameopt** switch may be used more than once to
  set multiple options. See the **x509**\|(1) manual page for details.
* **-CApath directory**  
  .IX Item "-CApath directory"
  The directory to use for server certificate verification. This directory
  must be in hash format\*(R", see **verify** for more information. These are
  also used when building the client certificate chain.
* **-CAfile file**  
  .IX Item "-CAfile file"
  A file containing trusted certificates to use during server authentication
  and to use when attempting to build the client certificate chain.
* **-no-CAfile**  
  .IX Item "-no-CAfile"
  Do not load the trusted \s-1CA\s0 certificates from the default file location
* **-no-CApath**  
  .IX Item "-no-CApath"
  Do not load the trusted \s-1CA\s0 certificates from the default directory location
* **-new**  
  .IX Item "-new"
  Performs the timing test using a new session \s-1ID\s0 for each connection.
  If neither **-new** nor **-reuse** are specified, they are both on by default
  and executed in sequence.
* **-reuse**  
  .IX Item "-reuse"
  Performs the timing test using the same session \s-1ID\s0; this can be used as a test
  that session caching is working. If neither **-new** nor **-reuse** are
  specified, they are both on by default and executed in sequence.
* **-ssl3**  
  .IX Item "-ssl3"
  This option disables the use of \s-1SSL\s0 version 3. By default
  the initial handshake uses a method which should be compatible with all
  servers and permit them to use \s-1SSL\s0 v3 or \s-1TLS\s0 as appropriate.
  .Sp
  The timing program is not as rich in options to turn protocols on and off as
  the **s\_client**\|(1) program and may not connect to all servers.
  Unfortunately there are a lot of ancient and broken servers in use which
  cannot handle this technique and will fail to connect. Some servers only
  work if \s-1TLS\s0 is turned off with the **-ssl3** option.
  .Sp
  Note that this option may not be available, depending on how
  OpenSSL was built.
* **-bugs**  
  .IX Item "-bugs"
  There are several known bugs in \s-1SSL\s0 and \s-1TLS\s0 implementations. Adding this
  option enables various workarounds.
* **-cipher cipherlist**  
  .IX Item "-cipher cipherlist"
  This allows the TLSv1.2 and below cipher list sent by the client to be modified.
  This list will be combined with any TLSv1.3 ciphersuites that have been
  configured. Although the server determines which cipher suite is used it should
  take the first supported cipher in the list sent by the client. See
  **ciphers**\|(1) for more information.
* **-ciphersuites val**  
  .IX Item "-ciphersuites val"
  This allows the TLSv1.3 ciphersuites sent by the client to be modified. This
  list will be combined with any TLSv1.2 and below ciphersuites that have been
  configured. Although the server determines which cipher suite is used it should
  take the first supported cipher in the list sent by the client. See
  **ciphers**\|(1) for more information. The format for this list is a simple
  colon (:\*(R") separated list of TLSv1.3 ciphersuite names.
* **-time length**  
  .IX Item "-time length"
  Specifies how long (in seconds) **s\_time** should establish connections and
  optionally transfer payload data from a server. Server and client performance
  and the link speed determine how many connections **s\_time** can establish.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**s\_time** can be used to measure the performance of an \s-1SSL\s0 connection.
To connect to an \s-1SSL HTTP\s0 server and get the default page the command

.Vb 1
 openssl s_time -connect servername:443 -www / -CApath yourdir -CAfile yourfile.pem -cipher commoncipher [-ssl3]
.Ve

would typically be used (https uses port 443). 'commoncipher' is a cipher to
which both client and server can agree, see the **ciphers**\|(1) command
for details.

If the handshake fails then there are several possible causes, if it is
nothing obvious like no client certificate then the **-bugs** and
**-ssl3** options can be tried
in case it is a buggy server. In particular you should play with these
options **before** submitting a bug report to an OpenSSL mailing list.

A frequent problem when attempting to get client certificates working
is that a web client complains it has no certificates or gives an empty
list to choose from. This is normally because the server is not sending
the clients certificate authority in its acceptable \s-1CA\s0 list\*(R" when it
requests a certificate. By using **s\_client**\|(1) the \s-1CA\s0 list can be
viewed and checked. However, some servers only request client authentication
after a specific \s-1URL\s0 is requested. To obtain the list in this case it
is necessary to use the **-prexit** option of **s\_client**\|(1) and
send an \s-1HTTP\s0 request for an appropriate page.

If a certificate is specified on the command line using the **-cert**
option it will not be used unless the server specifically requests
a client certificate. Therefore, merely including a client certificate
on the command line is no guarantee that the certificate works.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
Because this program does not have all the options of the
**s\_client**\|(1) program to turn protocols on and off, you may not be
able to measure the performance of all protocols with all servers.

The **-verify** option should really exit if the server verification
fails.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**s\_client**\|(1), **s\_server**\|(1), **ciphers**\|(1)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2004-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
