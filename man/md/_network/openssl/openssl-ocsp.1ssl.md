# ocsp(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-ocsp, ocsp - Online Certificate Status Protocol utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl ocsp [-help] [-out file] [-issuer file] [-cert file] [-serial n] [-signer file] [-signkey file] [-sign_other file] [-no_certs] [-req_text] [-resp_text] [-text] [-reqout file] [-respout file] [-reqin file] [-respin file] [-nonce] [-no_nonce] [-url \s-1URL\s0] [-host host:port] [-multi process-count] [-header] [-path] [-CApath dir] [-CAfile file] [-no-CAfile] [-no-CApath] [-attime timestamp] [-check_ss_sig] [-crl_check] [-crl_check_all] [-explicit_policy] [-extended_crl] [-ignore_critical] [-inhibit_any] [-inhibit_map] [-no_check_time] [-partial_chain] [-policy arg] [-policy_check] [-policy_print] [-purpose purpose] [-suiteB_128] [-suiteB_128_only] [-suiteB_192] [-trusted_first] [-no_alt_chains] [-use_deltas] [-auth_level num] [-verify_depth num] [-verify_email email] [-verify_hostname hostname] [-verify_ip ip] [-verify_name name] [-x509_strict] [-VAfile file] [-validity_period n] [-status_age n] [-noverify] [-verify_other file] [-trust_other] [-no_intern] [-no_signature_verify] [-no_cert_verify] [-no_chain] [-no_cert_checks] [-no_explicit] [-port num] [-ignore_err] [-index file] [-CA file] [-rsigner file] [-rkey file] [-rother file] [-rsigopt nm:v] [-resp_no_certs] [-nmin n] [-ndays n] [-resp_key_id] [-nrequest n] [-\f(BIdigest]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The Online Certificate Status Protocol (\s-1OCSP\s0) enables applications to
determine the (revocation) state of an identified certificate (\s-1RFC 2560\s0).

The **ocsp** command performs many common \s-1OCSP\s0 tasks. It can be used
to print out requests and responses, create requests and send queries
to an \s-1OCSP\s0 responder and behave like a mini \s-1OCSP\s0 server itself.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
This command operates as either a client or a server.
The options are described below, divided into those two modes.

<a name="s-1ocsps0-client-options"></a>

### \s-1OCSP\s0 Client Options

.IX Subsection "OCSP Client Options"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-out filename**  
  .IX Item "-out filename"
  specify output filename, default is standard output.
* **-issuer filename**  
  .IX Item "-issuer filename"
  This specifies the current issuer certificate. This option can be used
  multiple times. The certificate specified in **filename** must be in
  \s-1PEM\s0 format. This option **\s-1MUST\s0** come before any **-cert** options.
* **-cert filename**  
  .IX Item "-cert filename"
  Add the certificate **filename** to the request. The issuer certificate
  is taken from the previous **issuer** option, or an error occurs if no
  issuer certificate is specified.
* **-serial num**  
  .IX Item "-serial num"
  Same as the **cert** option except the certificate with serial number
  **num** is added to the request. The serial number is interpreted as a
  decimal integer unless preceded by **0x**. Negative integers can also
  be specified by preceding the value by a **-** sign.
* **-signer filename**, **-signkey filename**  
  .IX Item "-signer filename, -signkey filename"
  Sign the \s-1OCSP\s0 request using the certificate specified in the **signer**
  option and the private key specified by the **signkey** option. If
  the **signkey** option is not present then the private key is read
  from the same file as the certificate. If neither option is specified then
  the \s-1OCSP\s0 request is not signed.
* **-sign_other filename**  
  .IX Item "-sign_other filename"
  Additional certificates to include in the signed request.
* **-nonce**, **-no\_nonce**  
  .IX Item "-nonce, -no_nonce"
  Add an \s-1OCSP\s0 nonce extension to a request or disable \s-1OCSP\s0 nonce addition.
  Normally if an \s-1OCSP\s0 request is input using the **reqin** option no
  nonce is added: using the **nonce** option will force addition of a nonce.
  If an \s-1OCSP\s0 request is being created (using **cert** and **serial** options)
  a nonce is automatically added specifying **no\_nonce** overrides this.
* **-req\_text**, **-resp\_text**, **-text**  
  .IX Item "-req_text, -resp_text, -text"
  Print out the text form of the \s-1OCSP\s0 request, response or both respectively.
* **-reqout file**, **-respout file**  
  .IX Item "-reqout file, -respout file"
  Write out the \s-1DER\s0 encoded certificate request or response to **file**.
* **-reqin file**, **-respin file**  
  .IX Item "-reqin file, -respin file"
  Read \s-1OCSP\s0 request or response file from **file**. These option are ignored
  if \s-1OCSP\s0 request or response creation is implied by other options (for example
  with **serial**, **cert** and **host** options).
* **-url responder\_url**  
  .IX Item "-url responder_url"
  Specify the responder \s-1URL.\s0 Both \s-1HTTP\s0 and \s-1HTTPS\s0 (\s-1SSL/TLS\s0) URLs can be specified.
* **-host hostname:port**, **-path pathname**  
  .IX Item "-host hostname:port, -path pathname"
  If the **host** option is present then the \s-1OCSP\s0 request is sent to the host
  **hostname** on port **port**. **path** specifies the \s-1HTTP\s0 pathname to use
  or /\*(R" by default.  This is equivalent to specifying **-url** with scheme
  http:// and the given hostname, port, and pathname.
* **-header name=value**  
  .IX Item "-header name=value"
  Adds the header **name** with the specified **value** to the \s-1OCSP\s0 request
  that is sent to the responder.
  This may be repeated.
* **-timeout seconds**  
  .IX Item "-timeout seconds"
  Connection timeout to the \s-1OCSP\s0 responder in seconds.
  On \s-1POSIX\s0 systems, when running as an \s-1OCSP\s0 responder, this option also limits
  the time that the responder is willing to wait for the client request.
  This time is measured from the time the responder accepts the connection until
  the complete request is received.
* **-multi process-count**  
  .IX Item "-multi process-count"
  Run the specified number of \s-1OCSP\s0 responder child processes, with the parent
  process respawning child processes as needed.
  Child processes will detect changes in the \s-1CA\s0 index file and automatically
  reload it.
  When running as a responder **-timeout** option is recommended to limit the time
  each child is willing to wait for the client's \s-1OCSP\s0 response.
  This option is available on \s-1POSIX\s0 systems (that support the **fork()** and other
  required unix system-calls).
* **-CAfile file**, **-CApath pathname**  
  .IX Item "-CAfile file, -CApath pathname"
  File or pathname containing trusted \s-1CA\s0 certificates. These are used to verify
  the signature on the \s-1OCSP\s0 response.
* **-no-CAfile**  
  .IX Item "-no-CAfile"
  Do not load the trusted \s-1CA\s0 certificates from the default file location
* **-no-CApath**  
  .IX Item "-no-CApath"
  Do not load the trusted \s-1CA\s0 certificates from the default directory location
* **-attime**, **-check\_ss\_sig**, **-crl\_check**, **-crl\_check\_all**, **-explicit\_policy**, **-extended\_crl**, **-ignore\_critical**, **-inhibit\_any**, **-inhibit\_map**, **-no\_alt\_chains**, **-no\_check\_time**, **-partial\_chain**, **-policy**, **-policy\_check**, **-policy\_print**, **-purpose**, **-suiteB\_128**, **-suiteB\_128\_only**, **-suiteB\_192**, **-trusted\_first**, **-use\_deltas**, **-auth\_level**, **-verify\_depth**, **-verify\_email**, **-verify\_hostname**, **-verify\_ip**, **-verify\_name**, **-x509\_strict**  
  .IX Item "-attime, -check_ss_sig, -crl_check, -crl_check_all, -explicit_policy, -extended_crl, -ignore_critical, -inhibit_any, -inhibit_map, -no_alt_chains, -no_check_time, -partial_chain, -policy, -policy_check, -policy_print, -purpose, -suiteB_128, -suiteB_128_only, -suiteB_192, -trusted_first, -use_deltas, -auth_level, -verify_depth, -verify_email, -verify_hostname, -verify_ip, -verify_name, -x509_strict"
  Set different certificate verification options.
  See **verify**\|(1) manual page for details.
* **-verify_other file**  
  .IX Item "-verify_other file"
  File containing additional certificates to search when attempting to locate
  the \s-1OCSP\s0 response signing certificate. Some responders omit the actual signer's
  certificate from the response: this option can be used to supply the necessary
  certificate in such cases.
* **-trust\_other**  
  .IX Item "-trust_other"
  The certificates specified by the **-verify\_other** option should be explicitly
  trusted and no additional checks will be performed on them. This is useful
  when the complete responder certificate chain is not available or trusting a
  root \s-1CA\s0 is not appropriate.
* **-VAfile file**  
  .IX Item "-VAfile file"
  File containing explicitly trusted responder certificates. Equivalent to the
  **-verify\_other** and **-trust\_other** options.
* **-noverify**  
  .IX Item "-noverify"
  Don't attempt to verify the \s-1OCSP\s0 response signature or the nonce
  values. This option will normally only be used for debugging since it
  disables all verification of the responders certificate.
* **-no\_intern**  
  .IX Item "-no_intern"
  Ignore certificates contained in the \s-1OCSP\s0 response when searching for the
  signers certificate. With this option the signers certificate must be specified
  with either the **-verify\_other** or **-VAfile** options.
* **-no\_signature\_verify**  
  .IX Item "-no_signature_verify"
  Don't check the signature on the \s-1OCSP\s0 response. Since this option
  tolerates invalid signatures on \s-1OCSP\s0 responses it will normally only be
  used for testing purposes.
* **-no\_cert\_verify**  
  .IX Item "-no_cert_verify"
  Don't verify the \s-1OCSP\s0 response signers certificate at all. Since this
  option allows the \s-1OCSP\s0 response to be signed by any certificate it should
  only be used for testing purposes.
* **-no\_chain**  
  .IX Item "-no_chain"
  Do not use certificates in the response as additional untrusted \s-1CA\s0
  certificates.
* **-no\_explicit**  
  .IX Item "-no_explicit"
  Do not explicitly trust the root \s-1CA\s0 if it is set to be trusted for \s-1OCSP\s0 signing.
* **-no\_cert\_checks**  
  .IX Item "-no_cert_checks"
  Don't perform any additional checks on the \s-1OCSP\s0 response signers certificate.
  That is do not make any checks to see if the signers certificate is authorised
  to provide the necessary status information: as a result this option should
  only be used for testing purposes.
* **-validity_period nsec**, **-status_age age**  
  .IX Item "-validity_period nsec, -status_age age"
  These options specify the range of times, in seconds, which will be tolerated
  in an \s-1OCSP\s0 response. Each certificate status response includes a **notBefore**
  time and an optional **notAfter** time. The current time should fall between
  these two values, but the interval between the two times may be only a few
  seconds. In practice the \s-1OCSP\s0 responder and clients clocks may not be precisely
  synchronised and so such a check may fail. To avoid this the
  **-validity\_period** option can be used to specify an acceptable error range in
  seconds, the default value is 5 minutes.
  .Sp
  If the **notAfter** time is omitted from a response then this means that new
  status information is immediately available. In this case the age of the
  **notBefore** field is checked to see it is not older than **age** seconds old.
  By default this additional check is not performed.
* **-\f(BIdigest**  
  .IX Item "-digest"
  This option sets digest algorithm to use for certificate identification in the
  \s-1OCSP\s0 request. Any digest supported by the OpenSSL **dgst** command can be used.
  The default is \s-1SHA-1.\s0 This option may be used multiple times to specify the
  digest used by subsequent certificate identifiers.

<a name="s-1ocsps0-server-options"></a>

### \s-1OCSP\s0 Server Options

.IX Subsection "OCSP Server Options"

* **-index indexfile**  
  .IX Item "-index indexfile"
  The **indexfile** parameter is the name of a text index file in **ca**
  format containing certificate revocation information.
  .Sp
  If the **index** option is specified the **ocsp** utility is in responder
  mode, otherwise it is in client mode. The request(s) the responder
  processes can be either specified on the command line (using **issuer**
  and **serial** options), supplied in a file (using the **reqin** option)
  or via external \s-1OCSP\s0 clients (if **port** or **url** is specified).
  .Sp
  If the **index** option is present then the **\s-1CA\s0** and **rsigner** options
  must also be present.
* **-CA file**  
  .IX Item "-CA file"
  \s-1CA\s0 certificate corresponding to the revocation information in **indexfile**.
* **-rsigner file**  
  .IX Item "-rsigner file"
  The certificate to sign \s-1OCSP\s0 responses with.
* **-rother file**  
  .IX Item "-rother file"
  Additional certificates to include in the \s-1OCSP\s0 response.
* **-resp\_no\_certs**  
  .IX Item "-resp_no_certs"
  Don't include any certificates in the \s-1OCSP\s0 response.
* **-resp\_key\_id**  
  .IX Item "-resp_key_id"
  Identify the signer certificate using the key \s-1ID,\s0 default is to use the
  subject name.
* **-rkey file**  
  .IX Item "-rkey file"
  The private key to sign \s-1OCSP\s0 responses with: if not present the file
  specified in the **rsigner** option is used.
* **-rsigopt nm:v**  
  .IX Item "-rsigopt nm:v"
  Pass options to the signature algorithm when signing \s-1OCSP\s0 responses.
  Names and values of these options are algorithm-specific.
* **-port portnum**  
  .IX Item "-port portnum"
  Port to listen for \s-1OCSP\s0 requests on. The port may also be specified
  using the **url** option.
* **-ignore\_err**  
  .IX Item "-ignore_err"
  Ignore malformed requests or responses: When acting as an \s-1OCSP\s0 client, retry if
  a malformed response is received. When acting as an \s-1OCSP\s0 responder, continue
  running instead of terminating upon receiving a malformed request.
* **-nrequest number**  
  .IX Item "-nrequest number"
  The \s-1OCSP\s0 server will exit after receiving **number** requests, default unlimited.
* **-nmin minutes**, **-ndays days**  
  .IX Item "-nmin minutes, -ndays days"
  Number of minutes or days when fresh revocation information is available:
  used in the **nextUpdate** field. If neither option is present then the
  **nextUpdate** field is omitted meaning fresh revocation information is
  immediately available.

<a name="ocsp-response-verification"></a>

# Ocsp Response Verification.

.IX Header "OCSP Response verification."
\s-1OCSP\s0 Response follows the rules specified in \s-1RFC2560.\s0

Initially the \s-1OCSP\s0 responder certificate is located and the signature on
the \s-1OCSP\s0 request checked using the responder certificate's public key.

Then a normal certificate verify is performed on the \s-1OCSP\s0 responder certificate
building up a certificate chain in the process. The locations of the trusted
certificates used to build the chain can be specified by the **CAfile**
and **CApath** options or they will be looked for in the standard OpenSSL
certificates directory.

If the initial verify fails then the \s-1OCSP\s0 verify process halts with an
error.

Otherwise the issuing \s-1CA\s0 certificate in the request is compared to the \s-1OCSP\s0
responder certificate: if there is a match then the \s-1OCSP\s0 verify succeeds.

Otherwise the \s-1OCSP\s0 responder certificate's \s-1CA\s0 is checked against the issuing
\s-1CA\s0 certificate in the request. If there is a match and the OCSPSigning
extended key usage is present in the \s-1OCSP\s0 responder certificate then the
\s-1OCSP\s0 verify succeeds.

Otherwise, if **-no\_explicit** is **not** set the root \s-1CA\s0 of the \s-1OCSP\s0 responders
\s-1CA\s0 is checked to see if it is trusted for \s-1OCSP\s0 signing. If it is the \s-1OCSP\s0
verify succeeds.

If none of these checks is successful then the \s-1OCSP\s0 verify fails.

What this effectively means if that if the \s-1OCSP\s0 responder certificate is
authorised directly by the \s-1CA\s0 it is issuing revocation information about
(and it is correctly configured) then verification will succeed.

If the \s-1OCSP\s0 responder is a global responder\*(R" which can give details about
multiple CAs and has its own separate certificate chain then its root
\s-1CA\s0 can be trusted for \s-1OCSP\s0 signing. For example:

.Vb 1
 openssl x509 -in ocspCA.pem -addtrust OCSPSigning -out trustedCA.pem
.Ve

Alternatively the responder certificate itself can be explicitly trusted
with the **-VAfile** option.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
As noted, most of the verify options are for testing or debugging purposes.
Normally only the **-CApath**, **-CAfile** and (if the responder is a 'global
\s-1VA\s0') **-VAfile** options need to be used.

The \s-1OCSP\s0 server is only useful for test and demonstration purposes: it is
not really usable as a full \s-1OCSP\s0 responder. It contains only a very
simple \s-1HTTP\s0 request handling and can only handle the \s-1POST\s0 form of \s-1OCSP\s0
queries. It also handles requests serially meaning it cannot respond to
new requests until it has processed the current one. The text index file
format of revocation is also inefficient for large quantities of revocation
data.

It is possible to run the **ocsp** application in responder mode via a \s-1CGI\s0
script using the **reqin** and **respout** options.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Create an \s-1OCSP\s0 request and write it to a file:

.Vb 1
 openssl ocsp -issuer issuer.pem -cert c1.pem -cert c2.pem -reqout req.der
.Ve

Send a query to an \s-1OCSP\s0 responder with \s-1URL\s0 http://ocsp.myhost.com/ save the
response to a file, print it out in text form, and verify the response:

.Vb 2
 openssl ocsp -issuer issuer.pem -cert c1.pem -cert c2.pem \e
     -url http://ocsp.myhost.com/ -resp_text -respout resp.der
.Ve

Read in an \s-1OCSP\s0 response and print out text form:

.Vb 1
 openssl ocsp -respin resp.der -text -noverify
.Ve

\s-1OCSP\s0 server on port 8888 using a standard **ca** configuration, and a separate
responder certificate. All requests and responses are printed to a file.

.Vb 2
 openssl ocsp -index demoCA/index.txt -port 8888 -rsigner rcert.pem -CA demoCA/cacert.pem
        -text -out log.txt
.Ve

As above but exit after processing one request:

.Vb 2
 openssl ocsp -index demoCA/index.txt -port 8888 -rsigner rcert.pem -CA demoCA/cacert.pem
     -nrequest 1
.Ve

Query status information using an internally generated request:

.Vb 2
 openssl ocsp -index demoCA/index.txt -rsigner rcert.pem -CA demoCA/cacert.pem
     -issuer demoCA/cacert.pem -serial 1
.Ve

Query status information using request read from a file, and write the response
to a second file.

.Vb 2
 openssl ocsp -index demoCA/index.txt -rsigner rcert.pem -CA demoCA/cacert.pem
     -reqin req.der -respout resp.der
.Ve

<a name="history"></a>

# History

.IX Header "HISTORY"
The -no_alt_chains option was added in OpenSSL 1.1.0.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2001-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
