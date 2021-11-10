# s_client(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-s_client, s_client - SSL/TLS client program

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl s_client [-help] [-connect host:port] [-bind host:port] [-proxy host:port] [-unix path] [-4] [-6] [-servername name] [-noservername] [-verify depth] [-verify_return_error] [-cert filename] [-certform DER|PEM] [-key filename] [-keyform DER|PEM] [-cert_chain filename] [-build_chain] [-xkey] [-xcert] [-xchain] [-xchain_build] [-xcertform PEM|DER] [-xkeyform PEM|DER] [-pass arg] [-CApath directory] [-CAfile filename] [-chainCApath directory] [-chainCAfile filename] [-no-CAfile] [-no-CApath] [-requestCAfile filename] [-dane_tlsa_domain domain] [-dane_tlsa_rrdata rrdata] [-dane_ee_no_namechecks] [-attime timestamp] [-check_ss_sig] [-crl_check] [-crl_check_all] [-explicit_policy] [-extended_crl] [-ignore_critical] [-inhibit_any] [-inhibit_map] [-no_check_time] [-partial_chain] [-policy arg] [-policy_check] [-policy_print] [-purpose purpose] [-suiteB_128] [-suiteB_128_only] [-suiteB_192] [-trusted_first] [-no_alt_chains] [-use_deltas] [-auth_level num] [-nameopt option] [-verify_depth num] [-verify_email email] [-verify_hostname hostname] [-verify_ip ip] [-verify_name name] [-build_chain] [-x509_strict] [-reconnect] [-showcerts] [-debug] [-msg] [-nbio_test] [-state] [-nbio] [-crlf] [-ign_eof] [-no_ign_eof] [-psk_identity identity] [-psk key] [-psk_session file] [-quiet] [-ssl3] [-tls1] [-tls1_1] [-tls1_2] [-tls1_3] [-no_ssl3] [-no_tls1] [-no_tls1_1] [-no_tls1_2] [-no_tls1_3] [-dtls] [-dtls1] [-dtls1_2] [-sctp] [-sctp_label_bug] [-fallback_scsv] [-async] [-max_send_frag] [-split_send_frag] [-max_pipelines] [-read_buf] [-bugs] [-comp] [-no_comp] [-allow_no_dhe_kex] [-sigalgs sigalglist] [-curves curvelist] [-cipher cipherlist] [-ciphersuites val] [-serverpref] [-starttls protocol] [-xmpphost hostname] [-name hostname] [-engine id] [-tlsextdebug] [-no_ticket] [-sess_out filename] [-sess_in filename] [-rand file...] [-writerand file] [-serverinfo types] [-status] [-alpn protocols] [-nextprotoneg protocols] [-ct] [-noct] [-ctlogfile] [-keylogfile file] [-early_data file] [-enable_pha] [target]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **s\_client** command implements a generic \s-1SSL/TLS\s0 client which connects
to a remote host using \s-1SSL/TLS.\s0 It is a _very_ useful diagnostic tool for
\s-1SSL\s0 servers.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
In addition to the options below the **s\_client** utility also supports the
common and client only options documented
in the Supported Command Line Commands\*(R" section of the **SSL\_CONF\_cmd**\|(3)
manual page.

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-connect host:port**  
  .IX Item "-connect host:port"
  This specifies the host and optional port to connect to. It is possible to
  select the host and port using the optional target positional argument instead.
  If neither this nor the target positional argument are specified then an attempt
  is made to connect to the local host on port 4433.
* **-bind host:port**]  
  .IX Item "-bind host:port]"
  This specifies the host address and or port to bind as the source for the
  connection.  For Unix-domain sockets the port is ignored and the host is
  used as the source socket address.
* **-proxy host:port**  
  .IX Item "-proxy host:port"
  When used with the **-connect** flag, the program uses the host and port
  specified with this flag and issues an \s-1HTTP CONNECT\s0 command to connect
  to the desired server.
* **-unix path**  
  .IX Item "-unix path"
  Connect over the specified Unix-domain socket.
* **-4**  
  .IX Item "-4"
  Use IPv4 only.
* **-6**  
  .IX Item "-6"
  Use IPv6 only.
* **-servername name**  
  .IX Item "-servername name"
  Set the \s-1TLS SNI\s0 (Server Name Indication) extension in the ClientHello message to
  the given value. 
  If **-servername** is not provided, the \s-1TLS SNI\s0 extension will be populated with 
  the name given to **-connect** if it follows a \s-1DNS\s0 name format. If **-connect** is 
  not provided either, the \s-1SNI\s0 is set to localhost\*(R".
  This is the default since OpenSSL 1.1.1.
  .Sp
  Even though \s-1SNI\s0 should normally be a \s-1DNS\s0 name and not an \s-1IP\s0 address, if 
  **-servername** is provided then that name will be sent, regardless of whether 
  it is a \s-1DNS\s0 name or not.
  .Sp
  This option cannot be used in conjunction with **-noservername**.
* **-noservername**  
  .IX Item "-noservername"
  Suppresses sending of the \s-1SNI\s0 (Server Name Indication) extension in the
  ClientHello message. Cannot be used in conjunction with the **-servername** or
  &lt;-dane_tlsa_domain&gt; options.
* **-cert certname**  
  .IX Item "-cert certname"
  The certificate to use, if one is requested by the server. The default is
  not to use a certificate.
* **-certform format**  
  .IX Item "-certform format"
  The certificate format to use: \s-1DER\s0 or \s-1PEM. PEM\s0 is the default.
* **-key keyfile**  
  .IX Item "-key keyfile"
  The private key to use. If not specified then the certificate file will
  be used.
* **-keyform format**  
  .IX Item "-keyform format"
  The private format to use: \s-1DER\s0 or \s-1PEM. PEM\s0 is the default.
* **-cert\_chain**  
  .IX Item "-cert_chain"
  A file containing trusted certificates to use when attempting to build the
  client/server certificate chain related to the certificate specified via the
  **-cert** option.
* **-build\_chain**  
  .IX Item "-build_chain"
  Specify whether the application should build the certificate chain to be
  provided to the server.
* **-xkey infile**, **-xcert infile**, **-xchain**  
  .IX Item "-xkey infile, -xcert infile, -xchain"
  Specify an extra certificate, private key and certificate chain. These behave
  in the same manner as the **-cert**, **-key** and **-cert\_chain** options.  When
  specified, the callback returning the first valid chain will be in use by the
  client.
* **-xchain\_build**  
  .IX Item "-xchain_build"
  Specify whether the application should build the certificate chain to be
  provided to the server for the extra certificates provided via **-xkey infile**,
  **-xcert infile**, **-xchain** options.
* **-xcertform PEM|DER**, **-xkeyform PEM|DER**  
  .IX Item "-xcertform PEM|DER, -xkeyform PEM|DER"
  Extra certificate and private key format respectively.
* **-pass arg**  
  .IX Item "-pass arg"
  the private key password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-verify depth**  
  .IX Item "-verify depth"
  The verify depth to use. This specifies the maximum length of the
  server certificate chain and turns on server certificate verification.
  Currently the verify operation continues after errors so all the problems
  with a certificate chain can be seen. As a side effect the connection
  will never fail due to a server certificate verify failure.
* **-verify\_return\_error**  
  .IX Item "-verify_return_error"
  Return verification errors instead of continuing. This will typically
  abort the handshake with a fatal error.
* **-nameopt option**  
  .IX Item "-nameopt option"
  Option which determines how the subject or issuer names are displayed. The
  **option** argument can be a single option or multiple options separated by
  commas.  Alternatively the **-nameopt** switch may be used more than once to
  set multiple options. See the **x509**\|(1) manual page for details.
* **-CApath directory**  
  .IX Item "-CApath directory"
  The directory to use for server certificate verification. This directory
  must be in hash format\*(R", see **verify**\|(1) for more information. These are
  also used when building the client certificate chain.
* **-CAfile file**  
  .IX Item "-CAfile file"
  A file containing trusted certificates to use during server authentication
  and to use when attempting to build the client certificate chain.
* **-chainCApath directory**  
  .IX Item "-chainCApath directory"
  The directory to use for building the chain provided to the server. This
  directory must be in hash format\*(R", see **verify**\|(1) for more information.
* **-chainCAfile file**  
  .IX Item "-chainCAfile file"
  A file containing trusted certificates to use when attempting to build the
  client certificate chain.
* **-no-CAfile**  
  .IX Item "-no-CAfile"
  Do not load the trusted \s-1CA\s0 certificates from the default file location
* **-no-CApath**  
  .IX Item "-no-CApath"
  Do not load the trusted \s-1CA\s0 certificates from the default directory location
* **-requestCAfile file**  
  .IX Item "-requestCAfile file"
  A file containing a list of certificates whose subject names will be sent
  to the server in the **certificate\_authorities** extension. Only supported
  for \s-1TLS 1.3\s0
* **-dane_tlsa_domain domain**  
  .IX Item "-dane_tlsa_domain domain"
  Enable \s-1RFC6698/RFC7671 DANE TLSA\s0 authentication and specify the
  \s-1TLSA\s0 base domain which becomes the default \s-1SNI\s0 hint and the primary
  reference identifier for hostname checks.  This must be used in
  combination with at least one instance of the **-dane\_tlsa\_rrdata**
  option below.
  .Sp
  When \s-1DANE\s0 authentication succeeds, the diagnostic output will include
  the lowest (closest to 0) depth at which a \s-1TLSA\s0 record authenticated
  a chain certificate.  When that \s-1TLSA\s0 record is a 2 1 0\*(R" trust
  anchor public key that signed (rather than matched) the top-most
  certificate of the chain, the result is reported as \s-1TA\s0 public key
  verified.  Otherwise, either the \s-1TLSA\s0 record \*(L"matched \s-1TA\s0 certificate\*(R"
  at a positive depth or else matched \s-1EE\s0 certificate\*(R" at depth 0.
* **-dane_tlsa_rrdata rrdata**  
  .IX Item "-dane_tlsa_rrdata rrdata"
  Use one or more times to specify the \s-1RRDATA\s0 fields of the \s-1DANE TLSA\s0
  RRset associated with the target service.  The **rrdata** value is
  specified in presentation form\*(R", that is four whitespace separated
  fields that specify the usage, selector, matching type and associated
  data, with the last of these encoded in hexadecimal.  Optional
  whitespace is ignored in the associated data field.  For example:
  .Sp
  .Vb 12
    $ openssl s_client -brief -starttls smtp \e
      -connect smtp.example.com:25 \e
      -dane_tlsa_domain smtp.example.com \e
      -dane_tlsa_rrdata "2 1 1
        B111DD8A1C2091A89BD4FD60C57F0716CCE50FEEFF8137CDBEE0326E 02CF362B" \e
      -dane_tlsa_rrdata "2 1 1
        60B87575447DCBA2A36B7D11AC09FB24A9DB406FEE12D2CC90180517 616E8A18"
    ...
    Verification: OK
    Verified peername: smtp.example.com
    DANE TLSA 2 1 1 ...ee12d2cc90180517616e8a18 matched TA certificate at depth 1
    ...
  .Ve
* **-dane\_ee\_no\_namechecks**  
  .IX Item "-dane_ee_no_namechecks"
  This disables server name checks when authenticating via \s-1**DANE-EE\s0**\|(3) \s-1TLSA\s0
  records.
  For some applications, primarily web browsers, it is not safe to disable name
  checks due to unknown key share\*(R" attacks, in which a malicious server can
  convince a client that a connection to a victim server is instead a secure
  connection to the malicious server.
  The malicious server may then be able to violate cross-origin scripting
  restrictions.
  Thus, despite the text of \s-1RFC7671,\s0 name checks are by default enabled for
  \s-1**DANE-EE\s0**\|(3) \s-1TLSA\s0 records, and can be disabled in applications where it is safe
  to do so.
  In particular, \s-1SMTP\s0 and \s-1XMPP\s0 clients should set this option as \s-1SRV\s0 and \s-1MX\s0
  records already make it possible for a remote domain to redirect client
  connections to any server of its choice, and in any case \s-1SMTP\s0 and \s-1XMPP\s0 clients
  do not execute scripts downloaded from remote servers.
* **-attime**, **-check\_ss\_sig**, **-crl\_check**, **-crl\_check\_all**, **-explicit\_policy**, **-extended\_crl**, **-ignore\_critical**, **-inhibit\_any**, **-inhibit\_map**, **-no\_alt\_chains**, **-no\_check\_time**, **-partial\_chain**, **-policy**, **-policy\_check**, **-policy\_print**, **-purpose**, **-suiteB\_128**, **-suiteB\_128\_only**, **-suiteB\_192**, **-trusted\_first**, **-use\_deltas**, **-auth\_level**, **-verify\_depth**, **-verify\_email**, **-verify\_hostname**, **-verify\_ip**, **-verify\_name**, **-x509\_strict**  
  .IX Item "-attime, -check_ss_sig, -crl_check, -crl_check_all, -explicit_policy, -extended_crl, -ignore_critical, -inhibit_any, -inhibit_map, -no_alt_chains, -no_check_time, -partial_chain, -policy, -policy_check, -policy_print, -purpose, -suiteB_128, -suiteB_128_only, -suiteB_192, -trusted_first, -use_deltas, -auth_level, -verify_depth, -verify_email, -verify_hostname, -verify_ip, -verify_name, -x509_strict"
  Set various certificate chain validation options. See the
  **verify**\|(1) manual page for details.
* **-reconnect**  
  .IX Item "-reconnect"
  Reconnects to the same server 5 times using the same session \s-1ID,\s0 this can
  be used as a test that session caching is working.
* **-showcerts**  
  .IX Item "-showcerts"
  Displays the server certificate list as sent by the server: it only consists of
  certificates the server has sent (in the order the server has sent them). It is
  **not** a verified chain.
* **-prexit**  
  .IX Item "-prexit"
  Print session information when the program exits. This will always attempt
  to print out information even if the connection fails. Normally information
  will only be printed out once if the connection succeeds. This option is useful
  because the cipher in use may be renegotiated or the connection may fail
  because a client certificate is required or is requested only after an
  attempt is made to access a certain \s-1URL.\s0 Note: the output produced by this
  option is not always accurate because a connection might never have been
  established.
* **-state**  
  .IX Item "-state"
  Prints out the \s-1SSL\s0 session states.
* **-debug**  
  .IX Item "-debug"
  Print extensive debugging information including a hex dump of all traffic.
* **-msg**  
  .IX Item "-msg"
  Show all protocol messages with hex dump.
* **-trace**  
  .IX Item "-trace"
  Show verbose trace output of protocol messages. OpenSSL needs to be compiled
  with **enable-ssl-trace** for this option to work.
* **-msgfile**  
  .IX Item "-msgfile"
  File to send output of **-msg** or **-trace** to, default standard output.
* **-nbio\_test**  
  .IX Item "-nbio_test"
  Tests nonblocking I/O
* **-nbio**  
  .IX Item "-nbio"
  Turns on nonblocking I/O
* **-crlf**  
  .IX Item "-crlf"
  This option translated a line feed from the terminal into \s-1CR+LF\s0 as required
  by some servers.
* **-ign\_eof**  
  .IX Item "-ign_eof"
  Inhibit shutting down the connection when end of file is reached in the
  input.
* **-quiet**  
  .IX Item "-quiet"
  Inhibit printing of session and certificate information.  This implicitly
  turns on **-ign\_eof** as well.
* **-no\_ign\_eof**  
  .IX Item "-no_ign_eof"
  Shut down the connection when end of file is reached in the input.
  Can be used to override the implicit **-ign\_eof** after **-quiet**.
* **-psk_identity identity**  
  .IX Item "-psk_identity identity"
  Use the \s-1PSK\s0 identity **identity** when using a \s-1PSK\s0 cipher suite.
  The default value is Client_identity\*(R" (without the quotes).
* **-psk key**  
  .IX Item "-psk key"
  Use the \s-1PSK\s0 key **key** when using a \s-1PSK\s0 cipher suite. The key is
  given as a hexadecimal number without leading 0x, for example -psk
  1a2b3c4d.
  This option must be provided in order to use a \s-1PSK\s0 cipher.
* **-psk_session file**  
  .IX Item "-psk_session file"
  Use the pem encoded \s-1SSL_SESSION\s0 data stored in **file** as the basis of a \s-1PSK.\s0
  Note that this will only work if TLSv1.3 is negotiated.
* **-ssl3**, **-tls1**, **-tls1\_1**, **-tls1\_2**, **-tls1\_3**, **-no\_ssl3**, **-no\_tls1**, **-no\_tls1\_1**, **-no\_tls1\_2**, **-no\_tls1\_3**  
  .IX Item "-ssl3, -tls1, -tls1_1, -tls1_2, -tls1_3, -no_ssl3, -no_tls1, -no_tls1_1, -no_tls1_2, -no_tls1_3"
  These options require or disable the use of the specified \s-1SSL\s0 or \s-1TLS\s0 protocols.
  By default **s\_client** will negotiate the highest mutually supported protocol
  version.
  When a specific \s-1TLS\s0 version is required, only that version will be offered to
  and accepted from the server.
  Note that not all protocols and flags may be available, depending on how
  OpenSSL was built.
* **-dtls**, **-dtls1**, **-dtls1\_2**  
  .IX Item "-dtls, -dtls1, -dtls1_2"
  These options make **s\_client** use \s-1DTLS\s0 protocols instead of \s-1TLS.\s0
  With **-dtls**, **s\_client** will negotiate any supported \s-1DTLS\s0 protocol version,
  whilst **-dtls1** and **-dtls1\_2** will only support \s-1DTLS1.0\s0 and \s-1DTLS1.2\s0
  respectively.
* **-sctp**  
  .IX Item "-sctp"
  Use \s-1SCTP\s0 for the transport protocol instead of \s-1UDP\s0 in \s-1DTLS.\s0 Must be used in
  conjunction with **-dtls**, **-dtls1** or **-dtls1\_2**. This option is only
  available where OpenSSL has support for \s-1SCTP\s0 enabled.
* **-sctp\_label\_bug**  
  .IX Item "-sctp_label_bug"
  Use the incorrect behaviour of older OpenSSL implementations when computing
  endpoint-pair shared secrets for \s-1DTLS/SCTP.\s0 This allows communication with
  older broken implementations but breaks interoperability with correct
  implementations. Must be used in conjunction with **-sctp**. This option is only
  available where OpenSSL has support for \s-1SCTP\s0 enabled.
* **-fallback\_scsv**  
  .IX Item "-fallback_scsv"
  Send \s-1TLS_FALLBACK_SCSV\s0 in the ClientHello.
* **-async**  
  .IX Item "-async"
  Switch on asynchronous mode. Cryptographic operations will be performed
  asynchronously. This will only have an effect if an asynchronous capable engine
  is also used via the **-engine** option. For test purposes the dummy async engine
  (dasync) can be used (if available).
* **-max_send_frag int**  
  .IX Item "-max_send_frag int"
  The maximum size of data fragment to send.
  See **SSL\_CTX\_set\_max\_send\_fragment**\|(3) for further information.
* **-split_send_frag int**  
  .IX Item "-split_send_frag int"
  The size used to split data for encrypt pipelines. If more data is written in
  one go than this value then it will be split into multiple pipelines, up to the
  maximum number of pipelines defined by max_pipelines. This only has an effect if
  a suitable cipher suite has been negotiated, an engine that supports pipelining
  has been loaded, and max_pipelines is greater than 1. See
  **SSL\_CTX\_set\_split\_send\_fragment**\|(3) for further information.
* **-max_pipelines int**  
  .IX Item "-max_pipelines int"
  The maximum number of encrypt/decrypt pipelines to be used. This will only have
  an effect if an engine has been loaded that supports pipelining (e.g. the dasync
  engine) and a suitable cipher suite has been negotiated. The default value is 1.
  See **SSL\_CTX\_set\_max\_pipelines**\|(3) for further information.
* **-read_buf int**  
  .IX Item "-read_buf int"
  The default read buffer size to be used for connections. This will only have an
  effect if the buffer size is larger than the size that would otherwise be used
  and pipelining is in use (see **SSL\_CTX\_set\_default\_read\_buffer\_len**\|(3) for
  further information).
* **-bugs**  
  .IX Item "-bugs"
  There are several known bugs in \s-1SSL\s0 and \s-1TLS\s0 implementations. Adding this
  option enables various workarounds.
* **-comp**  
  .IX Item "-comp"
  Enables support for \s-1SSL/TLS\s0 compression.
  This option was introduced in OpenSSL 1.1.0.
  \s-1TLS\s0 compression is not recommended and is off by default as of
  OpenSSL 1.1.0.
* **-no\_comp**  
  .IX Item "-no_comp"
  Disables support for \s-1SSL/TLS\s0 compression.
  \s-1TLS\s0 compression is not recommended and is off by default as of
  OpenSSL 1.1.0.
* **-brief**  
  .IX Item "-brief"
  Only provide a brief summary of connection parameters instead of the
  normal verbose output.
* **-sigalgs sigalglist**  
  .IX Item "-sigalgs sigalglist"
  Specifies the list of signature algorithms that are sent by the client.
  The server selects one entry in the list based on its preferences.
  For example strings, see **SSL\_CTX\_set1\_sigalgs**\|(3)
* **-curves curvelist**  
  .IX Item "-curves curvelist"
  Specifies the list of supported curves to be sent by the client. The curve is
  ultimately selected by the server. For a list of all curves, use:
  .Sp
  .Vb 1
      $ openssl ecparam -list_curves
  .Ve
* **-cipher cipherlist**  
  .IX Item "-cipher cipherlist"
  This allows the TLSv1.2 and below cipher list sent by the client to be modified.
  This list will be combined with any TLSv1.3 ciphersuites that have been
  configured. Although the server determines which ciphersuite is used it should
  take the first supported cipher in the list sent by the client. See the
  **ciphers** command for more information.
* **-ciphersuites val**  
  .IX Item "-ciphersuites val"
  This allows the TLSv1.3 ciphersuites sent by the client to be modified. This
  list will be combined with any TLSv1.2 and below ciphersuites that have been
  configured. Although the server determines which cipher suite is used it should
  take the first supported cipher in the list sent by the client. See the
  **ciphers** command for more information. The format for this list is a simple
  colon (:\*(R") separated list of TLSv1.3 ciphersuite names.
* **-starttls protocol**  
  .IX Item "-starttls protocol"
  Send the protocol-specific message(s) to switch to \s-1TLS\s0 for communication.
  **protocol** is a keyword for the intended protocol.  Currently, the only
  supported keywords are smtp\*(R", \*(L"pop3\*(R", \*(L"imap\*(R", \*(L"ftp\*(R", \*(L"xmpp\*(R", \*(L"xmpp-server\*(R",
  irc\*(R", \*(L"postgres\*(R", \*(L"mysql\*(R", \*(L"lmtp\*(R", \*(L"nntp\*(R", \*(L"sieve\*(R" and \*(L"ldap\*(R".
* **-xmpphost hostname**  
  .IX Item "-xmpphost hostname"
  This option, when used with -starttls xmpp\*(R" or \*(L"-starttls xmpp-server\*(R",
  specifies the host for the to\*(R" attribute of the stream element.
  If this option is not specified, then the host specified with -connect\*(R"
  will be used.
  .Sp
  This option is an alias of the **-name** option for xmpp\*(R" and \*(L"xmpp-server\*(R".
* **-name hostname**  
  .IX Item "-name hostname"
  This option is used to specify hostname information for various protocols
  used with **-starttls** option. Currently only xmpp\*(R", \*(L"xmpp-server\*(R",
  smtp\*(R" and \*(L"lmtp\*(R" can utilize this **-name** option.
  .Sp
  If this option is used with -starttls xmpp\*(R" or \*(L"-starttls xmpp-server\*(R",
  if specifies the host for the to\*(R" attribute of the stream element. If this
  option is not specified, then the host specified with -connect\*(R" will be used.
  .Sp
  If this option is used with -starttls lmtp\*(R" or \*(L"-starttls smtp\*(R", it specifies
  the name to use in the \s-1LMTP LHLO\*(R"\s0 or \*(L"\s-1SMTP EHLO\*(R"\s0 message, respectively. If
  this option is not specified, then mail.example.com\*(R" will be used.
* **-tlsextdebug**  
  .IX Item "-tlsextdebug"
  Print out a hex dump of any \s-1TLS\s0 extensions received from the server.
* **-no\_ticket**  
  .IX Item "-no_ticket"
  Disable RFC4507bis session ticket support.
* **-sess_out filename**  
  .IX Item "-sess_out filename"
  Output \s-1SSL\s0 session to **filename**.
* **-sess_in sess.pem**  
  .IX Item "-sess_in sess.pem"
  Load \s-1SSL\s0 session from **filename**. The client will attempt to resume a
  connection from this session.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **s\_client**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.
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
* **-serverinfo types**  
  .IX Item "-serverinfo types"
  A list of comma-separated \s-1TLS\s0 Extension Types (numbers between 0 and
  65535).  Each type will be sent as an empty ClientHello \s-1TLS\s0 Extension.
  The server's response (if any) will be encoded and displayed as a \s-1PEM\s0
  file.
* **-status**  
  .IX Item "-status"
  Sends a certificate status request to the server (\s-1OCSP\s0 stapling). The server
  response (if any) is printed out.
* **-alpn protocols**, **-nextprotoneg protocols**  
  .IX Item "-alpn protocols, -nextprotoneg protocols"
  These flags enable the Enable the Application-Layer Protocol Negotiation
  or Next Protocol Negotiation (\s-1NPN\s0) extension, respectively. \s-1ALPN\s0 is the
  \s-1IETF\s0 standard and replaces \s-1NPN.\s0
  The **protocols** list is a comma-separated list of protocol names that
  the client should advertise support for. The list should contain the most
  desirable protocols first.  Protocol names are printable \s-1ASCII\s0 strings,
  for example http/1.1\*(R" or \*(L"spdy/3\*(R".
  An empty list of protocols is treated specially and will cause the
  client to advertise support for the \s-1TLS\s0 extension but disconnect just
  after receiving ServerHello with a list of server supported protocols.
  The flag **-nextprotoneg** cannot be specified if **-tls1\_3** is used.
* **-ct**, **-noct**  
  .IX Item "-ct, -noct"
  Use one of these two options to control whether Certificate Transparency (\s-1CT\s0)
  is enabled (**-ct**) or disabled (**-noct**).
  If \s-1CT\s0 is enabled, signed certificate timestamps (SCTs) will be requested from
  the server and reported at handshake completion.
  .Sp
  Enabling \s-1CT\s0 also enables \s-1OCSP\s0 stapling, as this is one possible delivery method
  for SCTs.
* **-ctlogfile**  
  .IX Item "-ctlogfile"
  A file containing a list of known Certificate Transparency logs. See
  **SSL\_CTX\_set\_ctlog\_list\_file**\|(3) for the expected file format.
* **-keylogfile file**  
  .IX Item "-keylogfile file"
  Appends \s-1TLS\s0 secrets to the specified keylog file such that external programs
  (like Wireshark) can decrypt \s-1TLS\s0 connections.
* **-early_data file**  
  .IX Item "-early_data file"
  Reads the contents of the specified file and attempts to send it as early data
  to the server. This will only work with resumed sessions that support early
  data and when the server accepts the early data.
* **-enable\_pha**  
  .IX Item "-enable_pha"
  For TLSv1.3 only, send the Post-Handshake Authentication extension. This will
  happen whether or not a certificate has been provided via **-cert**.
* **[target]**  
  .IX Item "[target]"
  Rather than providing **-connect**, the target hostname and optional port may
  be provided as a single positional argument after all options. If neither this
  nor **-connect** are provided, falls back to attempting to connect to localhost
  on port 4433.

<a name="connected-commands"></a>

# Connected Commands

.IX Header "CONNECTED COMMANDS"
If a connection is established with an \s-1SSL\s0 server then any data received
from the server is displayed and any key presses will be sent to the
server. If end of file is reached then the connection will be closed down. When
used interactively (which means neither **-quiet** nor **-ign\_eof** have been
given), then certain commands are also recognized which perform special
operations. These commands are a letter which must appear at the start of a
line. They are listed below.

* **Q**  
  .IX Item "Q"
  End the current \s-1SSL\s0 connection and exit.
* **R**  
  .IX Item "R"
  Renegotiate the \s-1SSL\s0 session (TLSv1.2 and below only).
* **B**  
  .IX Item "B"
  Send a heartbeat message to the server (\s-1DTLS\s0 only)
* **k**  
  .IX Item "k"
  Send a key update message to the server (TLSv1.3 only)
* **K**  
  .IX Item "K"
  Send a key update message to the server and request one back (TLSv1.3 only)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**s\_client** can be used to debug \s-1SSL\s0 servers. To connect to an \s-1SSL HTTP\s0
server the command:

.Vb 1
 openssl s_client -connect servername:443
.Ve

would typically be used (https uses port 443). If the connection succeeds
then an \s-1HTTP\s0 command can be given such as \s-1GET /\*(R"\s0 to retrieve a web page.

If the handshake fails then there are several possible causes, if it is
nothing obvious like no client certificate then the **-bugs**,
**-ssl3**, **-tls1**, **-no\_ssl3**, **-no\_tls1** options can be tried
in case it is a buggy server. In particular you should play with these
options **before** submitting a bug report to an OpenSSL mailing list.

A frequent problem when attempting to get client certificates working
is that a web client complains it has no certificates or gives an empty
list to choose from. This is normally because the server is not sending
the clients certificate authority in its acceptable \s-1CA\s0 list\*(R" when it
requests a certificate. By using **s\_client** the \s-1CA\s0 list can be viewed
and checked. However, some servers only request client authentication
after a specific \s-1URL\s0 is requested. To obtain the list in this case it
is necessary to use the **-prexit** option and send an \s-1HTTP\s0 request
for an appropriate page.

If a certificate is specified on the command line using the **-cert**
option it will not be used unless the server specifically requests
a client certificate. Therefore, merely including a client certificate
on the command line is no guarantee that the certificate works.

If there are problems verifying a server certificate then the
**-showcerts** option can be used to show all the certificates sent by the
server.

The **s\_client** utility is a test tool and is designed to continue the
handshake after any certificate verification errors. As a result it will
accept any certificate chain (trusted or not) sent by the peer. Non-test
applications should **not** do this as it makes them vulnerable to a \s-1MITM\s0
attack. This behaviour can be changed by with the **-verify\_return\_error**
option: any verify errors are then returned aborting the handshake.

The **-bind** option may be useful if the server or a firewall requires
connections to come from some particular address and or port.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
Because this program has a lot of options and also because some of the
techniques used are rather old, the C source of **s\_client** is rather hard to
read and not a model of how things should be done.
A typical \s-1SSL\s0 client program would be much simpler.

The **-prexit** option is a bit of a hack. We should really report
information whenever a session is renegotiated.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**SSL\_CONF\_cmd**\|(3), **sess\_id**\|(1), **s\_server**\|(1), **ciphers**\|(1),
**SSL\_CTX\_set\_max\_send\_fragment**\|(3), **SSL\_CTX\_set\_split\_send\_fragment**\|(3),
**SSL\_CTX\_set\_max\_pipelines**\|(3)

<a name="history"></a>

# History

.IX Header "HISTORY"
The **-no\_alt\_chains** option was added in OpenSSL 1.1.0.
The **-name** option was added in OpenSSL 1.1.1.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
