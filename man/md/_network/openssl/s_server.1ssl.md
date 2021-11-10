# s_server(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-s_server, s_server - SSL/TLS server program

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl s_server [-help] [-port +int] [-accept val] [-unix val] [-4] [-6] [-unlink] [-context val] [-verify int] [-Verify int] [-cert infile] [-nameopt val] [-naccept +int] [-serverinfo val] [-certform PEM|DER] [-key infile] [-keyform format] [-pass val] [-dcert infile] [-dcertform PEM|DER] [-dkey infile] [-dkeyform PEM|DER] [-dpass val] [-nbio_test] [-crlf] [-debug] [-msg] [-msgfile outfile] [-state] [-CAfile infile] [-CApath dir] [-no-CAfile] [-no-CApath] [-nocert] [-quiet] [-no_resume_ephemeral] [-www] [-WWW] [-servername] [-servername_fatal] [-cert2 infile] [-key2 infile] [-tlsextdebug] [-HTTP] [-id_prefix val] [-rand file...] [-writerand file] [-keymatexport val] [-keymatexportlen +int] [-CRL infile] [-crl_download] [-cert_chain infile] [-dcert_chain infile] [-chainCApath dir] [-verifyCApath dir] [-no_cache] [-ext_cache] [-CRLform PEM|DER] [-verify_return_error] [-verify_quiet] [-build_chain] [-chainCAfile infile] [-verifyCAfile infile] [-ign_eof] [-no_ign_eof] [-status] [-status_verbose] [-status_timeout int] [-status_url val] [-status_file infile] [-trace] [-security_debug] [-security_debug_verbose] [-brief] [-rev] [-async] [-ssl_config val] [-max_send_frag +int] [-split_send_frag +int] [-max_pipelines +int] [-read_buf +int] [-no_ssl3] [-no_tls1] [-no_tls1_1] [-no_tls1_2] [-no_tls1_3] [-bugs] [-no_comp] [-comp] [-no_ticket] [-num_tickets] [-serverpref] [-legacy_renegotiation] [-no_renegotiation] [-legacy_server_connect] [-no_resumption_on_reneg] [-no_legacy_server_connect] [-allow_no_dhe_kex] [-prioritize_chacha] [-strict] [-sigalgs val] [-client_sigalgs val] [-groups val] [-curves val] [-named_curve val] [-cipher val] [-ciphersuites val] [-dhparam infile] [-record_padding val] [-debug_broken_protocol] [-policy val] [-purpose val] [-verify_name val] [-verify_depth int] [-auth_level int] [-attime intmax] [-verify_hostname val] [-verify_email val] [-verify_ip] [-ignore_critical] [-issuer_checks] [-crl_check] [-crl_check_all] [-policy_check] [-explicit_policy] [-inhibit_any] [-inhibit_map] [-x509_strict] [-extended_crl] [-use_deltas] [-policy_print] [-check_ss_sig] [-trusted_first] [-suiteB_128_only] [-suiteB_128] [-suiteB_192] [-partial_chain] [-no_alt_chains] [-no_check_time] [-allow_proxy_certs] [-xkey] [-xcert] [-xchain] [-xchain_build] [-xcertform PEM|DER] [-xkeyform PEM|DER] [-nbio] [-psk_identity val] [-psk_hint val] [-psk val] [-psk_session file] [-srpvfile infile] [-srpuserseed val] [-ssl3] [-tls1] [-tls1_1] [-tls1_2] [-tls1_3] [-dtls] [-timeout] [-mtu +int] [-listen] [-dtls1] [-dtls1_2] [-sctp] [-sctp_label_bug] [-no_dhe] [-nextprotoneg val] [-use_srtp val] [-alpn val] [-engine val] [-keylogfile outfile] [-max_early_data int] [-early_data] [-anti_replay] [-no_anti_replay]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **s\_server** command implements a generic \s-1SSL/TLS\s0 server which listens
for connections on a given port using \s-1SSL/TLS.\s0

<a name="options"></a>

# Options

.IX Header "OPTIONS"
In addition to the options below the **s\_server** utility also supports the
common and server only options documented
in the Supported Command Line Commands\*(R" section of the **SSL\_CONF\_cmd**\|(3)
manual page.

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-port +int**  
  .IX Item "-port +int"
  The \s-1TCP\s0 port to listen on for connections. If not specified 4433 is used.
* **-accept val**  
  .IX Item "-accept val"
  The optional \s-1TCP\s0 host and port to listen on for connections. If not specified, *:4433 is used.
* **-unix val**  
  .IX Item "-unix val"
  Unix domain socket to accept on.
* **-4**  
  .IX Item "-4"
  Use IPv4 only.
* **-6**  
  .IX Item "-6"
  Use IPv6 only.
* **-unlink**  
  .IX Item "-unlink"
  For -unix, unlink any existing socket first.
* **-context val**  
  .IX Item "-context val"
  Sets the \s-1SSL\s0 context id. It can be given any string value. If this option
  is not present a default value will be used.
* **-verify int**, **-Verify int**  
  .IX Item "-verify int, -Verify int"
  The verify depth to use. This specifies the maximum length of the
  client certificate chain and makes the server request a certificate from
  the client. With the **-verify** option a certificate is requested but the
  client does not have to send one, with the **-Verify** option the client
  must supply a certificate or an error occurs.
  .Sp
  If the cipher suite cannot request a client certificate (for example an
  anonymous cipher suite or \s-1PSK\s0) this option has no effect.
* **-cert infile**  
  .IX Item "-cert infile"
  The certificate to use, most servers cipher suites require the use of a
  certificate and some require a certificate with a certain public key type:
  for example the \s-1DSS\s0 cipher suites require a certificate containing a \s-1DSS\s0
  (\s-1DSA\s0) key. If not specified then the filename server.pem\*(R" will be used.
* **-cert\_chain**  
  .IX Item "-cert_chain"
  A file containing trusted certificates to use when attempting to build the
  client/server certificate chain related to the certificate specified via the
  **-cert** option.
* **-build\_chain**  
  .IX Item "-build_chain"
  Specify whether the application should build the certificate chain to be
  provided to the client.
* **-nameopt val**  
  .IX Item "-nameopt val"
  Option which determines how the subject or issuer names are displayed. The
  **val** argument can be a single option or multiple options separated by
  commas.  Alternatively the **-nameopt** switch may be used more than once to
  set multiple options. See the **x509**\|(1) manual page for details.
* **-naccept +int**  
  .IX Item "-naccept +int"
  The server will exit after receiving the specified number of connections,
  default unlimited.
* **-serverinfo val**  
  .IX Item "-serverinfo val"
  A file containing one or more blocks of \s-1PEM\s0 data.  Each \s-1PEM\s0 block
  must encode a \s-1TLS\s0 ServerHello extension (2 bytes type, 2 bytes length,
  followed by length\*(R" bytes of extension data).  If the client sends
  an empty \s-1TLS\s0 ClientHello extension matching the type, the corresponding
  ServerHello extension will be returned.
* **-certform PEM|DER**  
  .IX Item "-certform PEM|DER"
  The certificate format to use: \s-1DER\s0 or \s-1PEM. PEM\s0 is the default.
* **-key infile**  
  .IX Item "-key infile"
  The private key to use. If not specified then the certificate file will
  be used.
* **-keyform format**  
  .IX Item "-keyform format"
  The private format to use: \s-1DER\s0 or \s-1PEM. PEM\s0 is the default.
* **-pass val**  
  .IX Item "-pass val"
  The private key password source. For more information about the format of **val**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-dcert infile**, **-dkey infile**  
  .IX Item "-dcert infile, -dkey infile"
  Specify an additional certificate and private key, these behave in the
  same manner as the **-cert** and **-key** options except there is no default
  if they are not specified (no additional certificate and key is used). As
  noted above some cipher suites require a certificate containing a key of
  a certain type. Some cipher suites need a certificate carrying an \s-1RSA\s0 key
  and some a \s-1DSS\s0 (\s-1DSA\s0) key. By using \s-1RSA\s0 and \s-1DSS\s0 certificates and keys
  a server can support clients which only support \s-1RSA\s0 or \s-1DSS\s0 cipher suites
  by using an appropriate certificate.
* **-dcert\_chain**  
  .IX Item "-dcert_chain"
  A file containing trusted certificates to use when attempting to build the
  server certificate chain when a certificate specified via the **-dcert** option
  is in use.
* **-dcertform PEM|DER**, **-dkeyform PEM|DER**, **-dpass val**  
  .IX Item "-dcertform PEM|DER, -dkeyform PEM|DER, -dpass val"
  Additional certificate and private key format and passphrase respectively.
* **-xkey infile**, **-xcert infile**, **-xchain**  
  .IX Item "-xkey infile, -xcert infile, -xchain"
  Specify an extra certificate, private key and certificate chain. These behave
  in the same manner as the **-cert**, **-key** and **-cert\_chain** options.  When
  specified, the callback returning the first valid chain will be in use by
  the server.
* **-xchain\_build**  
  .IX Item "-xchain_build"
  Specify whether the application should build the certificate chain to be
  provided to the client for the extra certificates provided via **-xkey infile**,
  **-xcert infile**, **-xchain** options.
* **-xcertform PEM|DER**, **-xkeyform PEM|DER**  
  .IX Item "-xcertform PEM|DER, -xkeyform PEM|DER"
  Extra certificate and private key format respectively.
* **-nbio\_test**  
  .IX Item "-nbio_test"
  Tests non blocking I/O.
* **-crlf**  
  .IX Item "-crlf"
  This option translated a line feed from the terminal into \s-1CR+LF.\s0
* **-debug**  
  .IX Item "-debug"
  Print extensive debugging information including a hex dump of all traffic.
* **-msg**  
  .IX Item "-msg"
  Show all protocol messages with hex dump.
* **-msgfile outfile**  
  .IX Item "-msgfile outfile"
  File to send output of **-msg** or **-trace** to, default standard output.
* **-state**  
  .IX Item "-state"
  Prints the \s-1SSL\s0 session states.
* **-CAfile infile**  
  .IX Item "-CAfile infile"
  A file containing trusted certificates to use during client authentication
  and to use when attempting to build the server certificate chain. The list
  is also used in the list of acceptable client CAs passed to the client when
  a certificate is requested.
* **-CApath dir**  
  .IX Item "-CApath dir"
  The directory to use for client certificate verification. This directory
  must be in hash format\*(R", see **verify**\|(1) for more information. These are
  also used when building the server certificate chain.
* **-chainCApath dir**  
  .IX Item "-chainCApath dir"
  The directory to use for building the chain provided to the client. This
  directory must be in hash format\*(R", see **verify**\|(1) for more information.
* **-chainCAfile file**  
  .IX Item "-chainCAfile file"
  A file containing trusted certificates to use when attempting to build the
  server certificate chain.
* **-no-CAfile**  
  .IX Item "-no-CAfile"
  Do not load the trusted \s-1CA\s0 certificates from the default file location.
* **-no-CApath**  
  .IX Item "-no-CApath"
  Do not load the trusted \s-1CA\s0 certificates from the default directory location.
* **-nocert**  
  .IX Item "-nocert"
  If this option is set then no certificate is used. This restricts the
  cipher suites available to the anonymous ones (currently just anonymous
  \s-1DH\s0).
* **-quiet**  
  .IX Item "-quiet"
  Inhibit printing of session and certificate information.
* **-www**  
  .IX Item "-www"
  Sends a status message back to the client when it connects. This includes
  information about the ciphers used and various session parameters.
  The output is in \s-1HTML\s0 format so this option will normally be used with a
  web browser. Cannot be used in conjunction with **-early\_data**.
* **-WWW**  
  .IX Item "-WWW"
  Emulates a simple web server. Pages will be resolved relative to the
  current directory, for example if the \s-1URL\s0 https://myhost/page.html is
  requested the file ./page.html will be loaded. Cannot be used in conjunction
  with **-early\_data**.
* **-tlsextdebug**  
  .IX Item "-tlsextdebug"
  Print a hex dump of any \s-1TLS\s0 extensions received from the server.
* **-HTTP**  
  .IX Item "-HTTP"
  Emulates a simple web server. Pages will be resolved relative to the
  current directory, for example if the \s-1URL\s0 https://myhost/page.html is
  requested the file ./page.html will be loaded. The files loaded are
  assumed to contain a complete and correct \s-1HTTP\s0 response (lines that
  are part of the \s-1HTTP\s0 response line and headers must end with \s-1CRLF\s0). Cannot be
  used in conjunction with **-early\_data**.
* **-id_prefix val**  
  .IX Item "-id_prefix val"
  Generate \s-1SSL/TLS\s0 session IDs prefixed by **val**. This is mostly useful
  for testing any \s-1SSL/TLS\s0 code (e.g. proxies) that wish to deal with multiple
  servers, when each of which might be generating a unique range of session
  IDs (e.g. with a certain prefix).
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
* **-verify\_return\_error**  
  .IX Item "-verify_return_error"
  Verification errors normally just print a message but allow the
  connection to continue, for debugging purposes.
  If this option is used, then verification errors close the connection.
* **-status**  
  .IX Item "-status"
  Enables certificate status request support (aka \s-1OCSP\s0 stapling).
* **-status\_verbose**  
  .IX Item "-status_verbose"
  Enables certificate status request support (aka \s-1OCSP\s0 stapling) and gives
  a verbose printout of the \s-1OCSP\s0 response.
* **-status_timeout int**  
  .IX Item "-status_timeout int"
  Sets the timeout for \s-1OCSP\s0 response to **int** seconds.
* **-status_url val**  
  .IX Item "-status_url val"
  Sets a fallback responder \s-1URL\s0 to use if no responder \s-1URL\s0 is present in the
  server certificate. Without this option an error is returned if the server
  certificate does not contain a responder address.
* **-status_file infile**  
  .IX Item "-status_file infile"
  Overrides any \s-1OCSP\s0 responder URLs from the certificate and always provides the
  \s-1OCSP\s0 Response stored in the file. The file must be in \s-1DER\s0 format.
* **-trace**  
  .IX Item "-trace"
  Show verbose trace output of protocol messages. OpenSSL needs to be compiled
  with **enable-ssl-trace** for this option to work.
* **-brief**  
  .IX Item "-brief"
  Provide a brief summary of connection parameters instead of the normal verbose
  output.
* **-rev**  
  .IX Item "-rev"
  Simple test server which just reverses the text received from the client
  and sends it back to the server. Also sets **-brief**. Cannot be used in
  conjunction with **-early\_data**.
* **-async**  
  .IX Item "-async"
  Switch on asynchronous mode. Cryptographic operations will be performed
  asynchronously. This will only have an effect if an asynchronous capable engine
  is also used via the **-engine** option. For test purposes the dummy async engine
  (dasync) can be used (if available).
* **-max_send_frag +int**  
  .IX Item "-max_send_frag +int"
  The maximum size of data fragment to send.
  See **SSL\_CTX\_set\_max\_send\_fragment**\|(3) for further information.
* **-split_send_frag +int**  
  .IX Item "-split_send_frag +int"
  The size used to split data for encrypt pipelines. If more data is written in
  one go than this value then it will be split into multiple pipelines, up to the
  maximum number of pipelines defined by max_pipelines. This only has an effect if
  a suitable cipher suite has been negotiated, an engine that supports pipelining
  has been loaded, and max_pipelines is greater than 1. See
  **SSL\_CTX\_set\_split\_send\_fragment**\|(3) for further information.
* **-max_pipelines +int**  
  .IX Item "-max_pipelines +int"
  The maximum number of encrypt/decrypt pipelines to be used. This will only have
  an effect if an engine has been loaded that supports pipelining (e.g. the dasync
  engine) and a suitable cipher suite has been negotiated. The default value is 1.
  See **SSL\_CTX\_set\_max\_pipelines**\|(3) for further information.
* **-read_buf +int**  
  .IX Item "-read_buf +int"
  The default read buffer size to be used for connections. This will only have an
  effect if the buffer size is larger than the size that would otherwise be used
  and pipelining is in use (see **SSL\_CTX\_set\_default\_read\_buffer\_len**\|(3) for
  further information).
* **-ssl2**, **-ssl3**, **-tls1**, **-tls1\_1**, **-tls1\_2**, **-tls1\_3**, **-no\_ssl2**, **-no\_ssl3**, **-no\_tls1**, **-no\_tls1\_1**, **-no\_tls1\_2**, **-no\_tls1\_3**  
  .IX Item "-ssl2, -ssl3, -tls1, -tls1_1, -tls1_2, -tls1_3, -no_ssl2, -no_ssl3, -no_tls1, -no_tls1_1, -no_tls1_2, -no_tls1_3"
  These options require or disable the use of the specified \s-1SSL\s0 or \s-1TLS\s0 protocols.
  By default **s\_server** will negotiate the highest mutually supported protocol
  version.
  When a specific \s-1TLS\s0 version is required, only that version will be accepted
  from the client.
  Note that not all protocols and flags may be available, depending on how
  OpenSSL was built.
* **-bugs**  
  .IX Item "-bugs"
  There are several known bugs in \s-1SSL\s0 and \s-1TLS\s0 implementations. Adding this
  option enables various workarounds.
* **-no\_comp**  
  .IX Item "-no_comp"
  Disable negotiation of \s-1TLS\s0 compression.
  \s-1TLS\s0 compression is not recommended and is off by default as of
  OpenSSL 1.1.0.
* **-comp**  
  .IX Item "-comp"
  Enable negotiation of \s-1TLS\s0 compression.
  This option was introduced in OpenSSL 1.1.0.
  \s-1TLS\s0 compression is not recommended and is off by default as of
  OpenSSL 1.1.0.
* **-no\_ticket**  
  .IX Item "-no_ticket"
  Disable RFC4507bis session ticket support. This option has no effect if TLSv1.3
  is negotiated. See **-num\_tickets**.
* **-num\_tickets**  
  .IX Item "-num_tickets"
  Control the number of tickets that will be sent to the client after a full
  handshake in TLSv1.3. The default number of tickets is 2. This option does not
  affect the number of tickets sent after a resumption handshake.
* **-serverpref**  
  .IX Item "-serverpref"
  Use the server's cipher preferences, rather than the client's preferences.
* **-prioritize\_chacha**  
  .IX Item "-prioritize_chacha"
  Prioritize ChaCha ciphers when preferred by clients. Requires **-serverpref**.
* **-no\_resumption\_on\_reneg**  
  .IX Item "-no_resumption_on_reneg"
  Set the **\s-1SSL\_OP\_NO\_SESSION\_RESUMPTION\_ON\_RENEGOTIATION\s0** option.
* **-client_sigalgs val**  
  .IX Item "-client_sigalgs val"
  Signature algorithms to support for client certificate authentication
  (colon-separated list).
* **-named_curve val**  
  .IX Item "-named_curve val"
  Specifies the elliptic curve to use. \s-1NOTE:\s0 this is single curve, not a list.
  For a list of all possible curves, use:
  .Sp
  .Vb 1
      $ openssl ecparam -list_curves
  .Ve
* **-cipher val**  
  .IX Item "-cipher val"
  This allows the list of TLSv1.2 and below ciphersuites used by the server to be
  modified. This list is combined with any TLSv1.3 ciphersuites that have been
  configured. When the client sends a list of supported ciphers the first client
  cipher also included in the server list is used. Because the client specifies
  the preference order, the order of the server cipherlist is irrelevant. See
  the **ciphers** command for more information.
* **-ciphersuites val**  
  .IX Item "-ciphersuites val"
  This allows the list of TLSv1.3 ciphersuites used by the server to be modified.
  This list is combined with any TLSv1.2 and below ciphersuites that have been
  configured. When the client sends a list of supported ciphers the first client
  cipher also included in the server list is used. Because the client specifies
  the preference order, the order of the server cipherlist is irrelevant. See
  the **ciphers** command for more information. The format for this list is a
  simple colon (:\*(R") separated list of TLSv1.3 ciphersuite names.
* **-dhparam infile**  
  .IX Item "-dhparam infile"
  The \s-1DH\s0 parameter file to use. The ephemeral \s-1DH\s0 cipher suites generate keys
  using a set of \s-1DH\s0 parameters. If not specified then an attempt is made to
  load the parameters from the server certificate file.
  If this fails then a static set of parameters hard coded into the **s\_server**
  program will be used.
* **-attime**, **-check\_ss\_sig**, **-crl\_check**, **-crl\_check\_all**, **-explicit\_policy**, **-extended\_crl**, **-ignore\_critical**, **-inhibit\_any**, **-inhibit\_map**, **-no\_alt\_chains**, **-no\_check\_time**, **-partial\_chain**, **-policy**, **-policy\_check**, **-policy\_print**, **-purpose**, **-suiteB\_128**, **-suiteB\_128\_only**, **-suiteB\_192**, **-trusted\_first**, **-use\_deltas**, **-auth\_level**, **-verify\_depth**, **-verify\_email**, **-verify\_hostname**, **-verify\_ip**, **-verify\_name**, **-x509\_strict**  
  .IX Item "-attime, -check_ss_sig, -crl_check, -crl_check_all, -explicit_policy, -extended_crl, -ignore_critical, -inhibit_any, -inhibit_map, -no_alt_chains, -no_check_time, -partial_chain, -policy, -policy_check, -policy_print, -purpose, -suiteB_128, -suiteB_128_only, -suiteB_192, -trusted_first, -use_deltas, -auth_level, -verify_depth, -verify_email, -verify_hostname, -verify_ip, -verify_name, -x509_strict"
  Set different peer certificate verification options.
  See the **verify**\|(1) manual page for details.
* **-crl\_check**, **-crl\_check\_all**  
  .IX Item "-crl_check, -crl_check_all"
  Check the peer certificate has not been revoked by its \s-1CA.\s0
  The \s-1CRL\s0(s) are appended to the certificate file. With the **-crl\_check\_all**
  option all CRLs of all CAs in the chain are checked.
* **-nbio**  
  .IX Item "-nbio"
  Turns on non blocking I/O.
* **-psk_identity val**  
  .IX Item "-psk_identity val"
  Expect the client to send \s-1PSK\s0 identity **val** when using a \s-1PSK\s0
  cipher suite, and warn if they do not.  By default, the expected \s-1PSK\s0
  identity is the string Client_identity\*(R".
* **-psk_hint val**  
  .IX Item "-psk_hint val"
  Use the \s-1PSK\s0 identity hint **val** when using a \s-1PSK\s0 cipher suite.
* **-psk val**  
  .IX Item "-psk val"
  Use the \s-1PSK\s0 key **val** when using a \s-1PSK\s0 cipher suite. The key is
  given as a hexadecimal number without leading 0x, for example -psk
  1a2b3c4d.
  This option must be provided in order to use a \s-1PSK\s0 cipher.
* **-psk_session file**  
  .IX Item "-psk_session file"
  Use the pem encoded \s-1SSL_SESSION\s0 data stored in **file** as the basis of a \s-1PSK.\s0
  Note that this will only work if TLSv1.3 is negotiated.
* **-listen**  
  .IX Item "-listen"
  This option can only be used in conjunction with one of the \s-1DTLS\s0 options above.
  With this option **s\_server** will listen on a \s-1UDP\s0 port for incoming connections.
  Any ClientHellos that arrive will be checked to see if they have a cookie in
  them or not.
  Any without a cookie will be responded to with a HelloVerifyRequest.
  If a ClientHello with a cookie is received then **s\_server** will connect to
  that peer and complete the handshake.
* **-dtls**, **-dtls1**, **-dtls1\_2**  
  .IX Item "-dtls, -dtls1, -dtls1_2"
  These options make **s\_server** use \s-1DTLS\s0 protocols instead of \s-1TLS.\s0
  With **-dtls**, **s\_server** will negotiate any supported \s-1DTLS\s0 protocol version,
  whilst **-dtls1** and **-dtls1\_2** will only support DTLSv1.0 and DTLSv1.2
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
* **-no\_dhe**  
  .IX Item "-no_dhe"
  If this option is set then no \s-1DH\s0 parameters will be loaded effectively
  disabling the ephemeral \s-1DH\s0 cipher suites.
* **-alpn val**, **-nextprotoneg val**  
  .IX Item "-alpn val, -nextprotoneg val"
  These flags enable the Application-Layer Protocol Negotiation
  or Next Protocol Negotiation (\s-1NPN\s0) extension, respectively. \s-1ALPN\s0 is the
  \s-1IETF\s0 standard and replaces \s-1NPN.\s0
  The **val** list is a comma-separated list of supported protocol
  names.  The list should contain the most desirable protocols first.
  Protocol names are printable \s-1ASCII\s0 strings, for example http/1.1\*(R" or
  spdy/3\*(R".
  The flag **-nextprotoneg** cannot be specified if **-tls1\_3** is used.
* **-engine val**  
  .IX Item "-engine val"
  Specifying an engine (by its unique id string in **val**) will cause **s\_server**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.
* **-keylogfile outfile**  
  .IX Item "-keylogfile outfile"
  Appends \s-1TLS\s0 secrets to the specified keylog file such that external programs
  (like Wireshark) can decrypt \s-1TLS\s0 connections.
* **-max_early_data int**  
  .IX Item "-max_early_data int"
  Change the default maximum early data bytes that are specified for new sessions
  and any incoming early data (when used in conjunction with the **-early\_data**
  flag). The default value is approximately 16k. The argument must be an integer
  greater than or equal to 0.
* **-early\_data**  
  .IX Item "-early_data"
  Accept early data where possible. Cannot be used in conjunction with **-www**,
  **-WWW**, **-HTTP** or **-rev**.
* **-anti\_replay**, **-no\_anti\_replay**  
  .IX Item "-anti_replay, -no_anti_replay"
  Switches replay protection on or off, respectively. Replay protection is on by
  default unless overridden by a configuration file. When it is on, OpenSSL will
  automatically detect if a session ticket has been used more than once, TLSv1.3
  has been negotiated, and early data is enabled on the server. A full handshake
  is forced if a session ticket is used a second or subsequent time. Any early
  data that was sent will be rejected.

<a name="connected-commands"></a>

# Connected Commands

.IX Header "CONNECTED COMMANDS"
If a connection request is established with an \s-1SSL\s0 client and neither the
**-www** nor the **-WWW** option has been used then normally any data received
from the client is displayed and any key presses will be sent to the client.

Certain commands are also recognized which perform special operations. These
commands are a letter which must appear at the start of a line. They are listed
below.

* **q**  
  .IX Item "q"
  End the current \s-1SSL\s0 connection but still accept new connections.
* **Q**  
  .IX Item "Q"
  End the current \s-1SSL\s0 connection and exit.
* **r**  
  .IX Item "r"
  Renegotiate the \s-1SSL\s0 session (TLSv1.2 and below only).
* **R**  
  .IX Item "R"
  Renegotiate the \s-1SSL\s0 session and request a client certificate (TLSv1.2 and below
  only).
* **P**  
  .IX Item "P"
  Send some plain text down the underlying \s-1TCP\s0 connection: this should
  cause the client to disconnect due to a protocol violation.
* **S**  
  .IX Item "S"
  Print out some session cache status information.
* **B**  
  .IX Item "B"
  Send a heartbeat message to the client (\s-1DTLS\s0 only)
* **k**  
  .IX Item "k"
  Send a key update message to the client (TLSv1.3 only)
* **K**  
  .IX Item "K"
  Send a key update message to the client and request one back (TLSv1.3 only)
* **c**  
  .IX Item "c"
  Send a certificate request to the client (TLSv1.3 only)

<a name="notes"></a>

# Notes

.IX Header "NOTES"
**s\_server** can be used to debug \s-1SSL\s0 clients. To accept connections from
a web browser the command:

.Vb 1
 openssl s_server -accept 443 -www
.Ve

can be used for example.

Although specifying an empty list of CAs when requesting a client certificate
is strictly speaking a protocol violation, some \s-1SSL\s0 clients interpret this to
mean any \s-1CA\s0 is acceptable. This is useful for debugging purposes.

The session parameters can printed out using the **sess\_id** program.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
Because this program has a lot of options and also because some of the
techniques used are rather old, the C source of **s\_server** is rather hard to
read and not a model of how things should be done.
A typical \s-1SSL\s0 server program would be much simpler.

The output of common ciphers is wrong: it just gives the list of ciphers that
OpenSSL recognizes and the client supports.

There should be a way for the **s\_server** program to print out details of any
unknown cipher suites a client says it supports.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**SSL\_CONF\_cmd**\|(3), **sess\_id**\|(1), **s\_client**\|(1), **ciphers**\|(1)
**SSL\_CTX\_set\_max\_send\_fragment**\|(3),
**SSL\_CTX\_set\_split\_send\_fragment**\|(3),
**SSL\_CTX\_set\_max\_pipelines**\|(3)

<a name="history"></a>

# History

.IX Header "HISTORY"
The -no_alt_chains option was added in OpenSSL 1.1.0.

The
-allow-no-dhe-kex and -prioritize_chacha options were added in OpenSSL 1.1.1.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
