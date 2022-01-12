# ts(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-ts, ts - Time Stamping Authority tool (client/server)

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl ts -query [-rand file...] [-writerand file] [-config configfile] [-data file_to_hash] [-digest digest_bytes] [-\f(BIdigest] [-tspolicy object_id] [-no_nonce] [-cert] [-in request.tsq] [-out request.tsq] [-text] 
 openssl ts -reply [-config configfile] [-section tsa_section] [-queryfile request.tsq] [-passin password_src] [-signer tsa_cert.pem] [-inkey file_or_id] [-\f(BIdigest] [-chain certs_file.pem] [-tspolicy object_id] [-in response.tsr] [-token_in] [-out response.tsr] [-token_out] [-text] [-engine id] 
 openssl ts -verify [-data file_to_hash] [-digest digest_bytes] [-queryfile request.tsq] [-in response.tsr] [-token_in] [-CApath trusted_cert_path] [-CAfile trusted_certs.pem] [-untrusted cert_file.pem] [verify options] 
 verify options: [-attime timestamp] [-check_ss_sig] [-crl_check] [-crl_check_all] [-explicit_policy] [-extended_crl] [-ignore_critical] [-inhibit_any] [-inhibit_map] [-issuer_checks] [-no_alt_chains] [-no_check_time] [-partial_chain] [-policy arg] [-policy_check] [-policy_print] [-purpose purpose] [-suiteB_128] [-suiteB_128_only] [-suiteB_192] [-trusted_first] [-use_deltas] [-auth_level num] [-verify_depth num] [-verify_email email] [-verify_hostname hostname] [-verify_ip ip] [-verify_name name] [-x509_strict]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **ts** command is a basic Time Stamping Authority (\s-1TSA\s0) client and server
application as specified in \s-1RFC 3161\s0 (Time-Stamp Protocol, \s-1TSP\s0). A
\s-1TSA\s0 can be part of a \s-1PKI\s0 deployment and its role is to provide long
term proof of the existence of a certain datum before a particular
time. Here is a brief description of the protocol:

* 1.  
  The \s-1TSA\s0 client computes a one-way hash value for a data file and sends
  the hash to the \s-1TSA.\s0
* 2.  
  The \s-1TSA\s0 attaches the current date and time to the received hash value,
  signs them and sends the timestamp token back to the client. By
  creating this token the \s-1TSA\s0 certifies the existence of the original
  data file at the time of response generation.
* 3.  
  The \s-1TSA\s0 client receives the timestamp token and verifies the
  signature on it. It also checks if the token contains the same hash
  value that it had sent to the \s-1TSA.\s0

There is one \s-1DER\s0 encoded protocol data unit defined for transporting 
a timestamp request to the \s-1TSA\s0 and one for sending the timestamp response
back to the client. The **ts** command has three main functions:
creating a timestamp request based on a data file,
creating a timestamp response based on a request, verifying if a
response corresponds to a particular request or a data file.

There is no support for sending the requests/responses automatically
over \s-1HTTP\s0 or \s-1TCP\s0 yet as suggested in \s-1RFC 3161.\s0 The users must send the
requests either by ftp or e-mail.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

<a name="time-stamp-request-generation"></a>

### Time Stamp Request generation

.IX Subsection "Time Stamp Request generation"
The **-query** switch can be used for creating and printing a timestamp
request with the following options:

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
* **-config** configfile  
  .IX Item "-config configfile"
  The configuration file to use.
  Optional; for a description of the default value,
  see \s-1COMMAND SUMMARY\*(R"\s0 in **openssl**\|(1).
* **-data** file_to_hash  
  .IX Item "-data file_to_hash"
  The data file for which the timestamp request needs to be
  created. stdin is the default if neither the **-data** nor the **-digest**
  parameter is specified. (Optional)
* **-digest** digest_bytes  
  .IX Item "-digest digest_bytes"
  It is possible to specify the message imprint explicitly without the data
  file. The imprint must be specified in a hexadecimal format, two characters
  per byte, the bytes optionally separated by colons (e.g. 1A:F6:01:... or
  1AF601...). The number of bytes must match the message digest algorithm
  in use. (Optional)
* **-\f(BIdigest**  
  .IX Item "-digest"
  The message digest to apply to the data file.
  Any digest supported by the OpenSSL **dgst** command can be used.
  The default is \s-1SHA-1.\s0 (Optional)
* **-tspolicy** object_id  
  .IX Item "-tspolicy object_id"
  The policy that the client expects the \s-1TSA\s0 to use for creating the
  timestamp token. Either the dotted \s-1OID\s0 notation or \s-1OID\s0 names defined
  in the config file can be used. If no policy is requested the \s-1TSA\s0 will
  use its own default policy. (Optional)
* **-no\_nonce**  
  .IX Item "-no_nonce"
  No nonce is specified in the request if this option is
  given. Otherwise a 64 bit long pseudo-random none is
  included in the request. It is recommended to use nonce to
  protect against replay-attacks. (Optional)
* **-cert**  
  .IX Item "-cert"
  The \s-1TSA\s0 is expected to include its signing certificate in the
  response. (Optional)
* **-in** request.tsq  
  .IX Item "-in request.tsq"
  This option specifies a previously created timestamp request in \s-1DER\s0
  format that will be printed into the output file. Useful when you need
  to examine the content of a request in human-readable
  format. (Optional)
* **-out** request.tsq  
  .IX Item "-out request.tsq"
  Name of the output file to which the request will be written. Default
  is stdout. (Optional)
* **-text**  
  .IX Item "-text"
  If this option is specified the output is human-readable text format
  instead of \s-1DER.\s0 (Optional)

<a name="time-stamp-response-generation"></a>

### Time Stamp Response generation

.IX Subsection "Time Stamp Response generation"
A timestamp response (TimeStampResp) consists of a response status
and the timestamp token itself (ContentInfo), if the token generation was
successful. The **-reply** command is for creating a timestamp
response or timestamp token based on a request and printing the
response/token in human-readable format. If **-token\_out** is not
specified the output is always a timestamp response (TimeStampResp),
otherwise it is a timestamp token (ContentInfo).

* **-config** configfile  
  .IX Item "-config configfile"
  The configuration file to use.
  Optional; for a description of the default value,
  see \s-1COMMAND SUMMARY\*(R"\s0 in **openssl**\|(1).
  See **\s-1CONFIGURATION FILE OPTIONS\s0** for configurable variables.
* **-section** tsa_section  
  .IX Item "-section tsa_section"
  The name of the config file section containing the settings for the
  response generation. If not specified the default \s-1TSA\s0 section is
  used, see **\s-1CONFIGURATION FILE OPTIONS\s0** for details. (Optional)
* **-queryfile** request.tsq  
  .IX Item "-queryfile request.tsq"
  The name of the file containing a \s-1DER\s0 encoded timestamp request. (Optional)
* **-passin** password_src  
  .IX Item "-passin password_src"
  Specifies the password source for the private key of the \s-1TSA.\s0 See
  Pass Phrase Options\*(R" in **openssl**\|(1). (Optional)
* **-signer** tsa_cert.pem  
  .IX Item "-signer tsa_cert.pem"
  The signer certificate of the \s-1TSA\s0 in \s-1PEM\s0 format. The \s-1TSA\s0 signing
  certificate must have exactly one extended key usage assigned to it:
  timeStamping. The extended key usage must also be critical, otherwise
  the certificate is going to be refused. Overrides the **signer\_cert**
  variable of the config file. (Optional)
* **-inkey** file_or_id  
  .IX Item "-inkey file_or_id"
  The signer private key of the \s-1TSA\s0 in \s-1PEM\s0 format. Overrides the
  **signer\_key** config file option. (Optional)
  If no engine is used, the argument is taken as a file; if an engine is
  specified, the argument is given to the engine as a key identifier.
* **-\f(BIdigest**  
  .IX Item "-digest"
  Signing digest to use. Overrides the **signer\_digest** config file
  option. (Mandatory unless specified in the config file)
* **-chain** certs_file.pem  
  .IX Item "-chain certs_file.pem"
  The collection of certificates in \s-1PEM\s0 format that will all
  be included in the response in addition to the signer certificate if
  the **-cert** option was used for the request. This file is supposed to
  contain the certificate chain for the signer certificate from its
  issuer upwards. The **-reply** command does not build a certificate
  chain automatically. (Optional)
* **-tspolicy** object_id  
  .IX Item "-tspolicy object_id"
  The default policy to use for the response unless the client
  explicitly requires a particular \s-1TSA\s0 policy. The \s-1OID\s0 can be specified
  either in dotted notation or with its name. Overrides the
  **default\_policy** config file option. (Optional)
* **-in** response.tsr  
  .IX Item "-in response.tsr"
  Specifies a previously created timestamp response or timestamp token
  (if **-token\_in** is also specified) in \s-1DER\s0 format that will be written
  to the output file. This option does not require a request, it is
  useful e.g. when you need to examine the content of a response or
  token or you want to extract the timestamp token from a response. If
  the input is a token and the output is a timestamp response a default
  'granted' status info is added to the token. (Optional)
* **-token\_in**  
  .IX Item "-token_in"
  This flag can be used together with the **-in** option and indicates
  that the input is a \s-1DER\s0 encoded timestamp token (ContentInfo) instead
  of a timestamp response (TimeStampResp). (Optional)
* **-out** response.tsr  
  .IX Item "-out response.tsr"
  The response is written to this file. The format and content of the
  file depends on other options (see **-text**, **-token\_out**). The default is
  stdout. (Optional)
* **-token\_out**  
  .IX Item "-token_out"
  The output is a timestamp token (ContentInfo) instead of timestamp
  response (TimeStampResp). (Optional)
* **-text**  
  .IX Item "-text"
  If this option is specified the output is human-readable text format
  instead of \s-1DER.\s0 (Optional)
* **-engine** id  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **ts**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms. Default is builtin. (Optional)

<a name="time-stamp-response-verification"></a>

### Time Stamp Response verification

.IX Subsection "Time Stamp Response verification"
The **-verify** command is for verifying if a timestamp response or 
timestamp token is valid and matches a particular timestamp request or
data file. The **-verify** command does not use the configuration file.

* **-data** file_to_hash  
  .IX Item "-data file_to_hash"
  The response or token must be verified against file_to_hash. The file
  is hashed with the message digest algorithm specified in the token.
  The **-digest** and **-queryfile** options must not be specified with this one.
  (Optional)
* **-digest** digest_bytes  
  .IX Item "-digest digest_bytes"
  The response or token must be verified against the message digest specified
  with this option. The number of bytes must match the message digest algorithm
  specified in the token. The **-data** and **-queryfile** options must not be
  specified with this one. (Optional)
* **-queryfile** request.tsq  
  .IX Item "-queryfile request.tsq"
  The original timestamp request in \s-1DER\s0 format. The **-data** and **-digest**
  options must not be specified with this one. (Optional)
* **-in** response.tsr  
  .IX Item "-in response.tsr"
  The timestamp response that needs to be verified in \s-1DER\s0 format. (Mandatory)
* **-token\_in**  
  .IX Item "-token_in"
  This flag can be used together with the **-in** option and indicates
  that the input is a \s-1DER\s0 encoded timestamp token (ContentInfo) instead
  of a timestamp response (TimeStampResp). (Optional)
* **-CApath** trusted_cert_path  
  .IX Item "-CApath trusted_cert_path"
  The name of the directory containing the trusted \s-1CA\s0 certificates of the
  client. See the similar option of **verify**\|(1) for additional
  details. Either this option or **-CAfile** must be specified. (Optional)
* **-CAfile** trusted_certs.pem  
  .IX Item "-CAfile trusted_certs.pem"
  The name of the file containing a set of trusted self-signed \s-1CA\s0
  certificates in \s-1PEM\s0 format. See the similar option of
  **verify**\|(1) for additional details. Either this option
  or **-CApath** must be specified.
  (Optional)
* **-untrusted** cert_file.pem  
  .IX Item "-untrusted cert_file.pem"
  Set of additional untrusted certificates in \s-1PEM\s0 format which may be
  needed when building the certificate chain for the \s-1TSA\s0's signing
  certificate. This file must contain the \s-1TSA\s0 signing certificate and
  all intermediate \s-1CA\s0 certificates unless the response includes them.
  (Optional)
* _verify options_  
  .IX Item "verify options"
  The options **-attime timestamp**, **-check\_ss\_sig**, **-crl\_check**,
  **-crl\_check\_all**, **-explicit\_policy**, **-extended\_crl**, **-ignore\_critical**,
  **-inhibit\_any**, **-inhibit\_map**, **-issuer\_checks**, **-no\_alt\_chains**,
  **-no\_check\_time**, **-partial\_chain**, **-policy**, **-policy\_check**,
  **-policy\_print**, **-purpose**, **-suiteB\_128**, **-suiteB\_128\_only**,
  **-suiteB\_192**, **-trusted\_first**, **-use\_deltas**, **-auth\_level**,
  **-verify\_depth**, **-verify\_email**, **-verify\_hostname**, **-verify\_ip**,
  **-verify\_name**, and **-x509\_strict** can be used to control timestamp
  verification.  See **verify**\|(1).

<a name="configuration-file-options"></a>

# Configuration File Options

.IX Header "CONFIGURATION FILE OPTIONS"
The **-query** and **-reply** commands make use of a configuration file.
See **config**\|(5)
for a general description of the syntax of the config file. The
**-query** command uses only the symbolic \s-1OID\s0 names section
and it can work without it. However, the **-reply** command needs the
config file for its operation.

When there is a command line switch equivalent of a variable the
switch always overrides the settings in the config file.

* **tsa** section, **default\_tsa**  
  .IX Item "tsa section, default_tsa"
  This is the main section and it specifies the name of another section
  that contains all the options for the **-reply** command. This default
  section can be overridden with the **-section** command line switch. (Optional)
* **oid\_file**  
  .IX Item "oid_file"
  See **ca**\|(1) for description. (Optional)
* **oid\_section**  
  .IX Item "oid_section"
  See **ca**\|(1) for description. (Optional)
* **\s-1RANDFILE\s0**  
  .IX Item "RANDFILE"
  See **ca**\|(1) for description. (Optional)
* **serial**  
  .IX Item "serial"
  The name of the file containing the hexadecimal serial number of the
  last timestamp response created. This number is incremented by 1 for
  each response. If the file does not exist at the time of response
  generation a new file is created with serial number 1. (Mandatory)
* **crypto\_device**  
  .IX Item "crypto_device"
  Specifies the OpenSSL engine that will be set as the default for
  all available algorithms. The default value is builtin, you can specify
  any other engines supported by OpenSSL (e.g. use chil for the NCipher \s-1HSM\s0).
  (Optional)
* **signer\_cert**  
  .IX Item "signer_cert"
  \s-1TSA\s0 signing certificate in \s-1PEM\s0 format. The same as the **-signer**
  command line option. (Optional)
* **certs**  
  .IX Item "certs"
  A file containing a set of \s-1PEM\s0 encoded certificates that need to be
  included in the response. The same as the **-chain** command line
  option. (Optional)
* **signer\_key**  
  .IX Item "signer_key"
  The private key of the \s-1TSA\s0 in \s-1PEM\s0 format. The same as the **-inkey**
  command line option. (Optional)
* **signer\_digest**  
  .IX Item "signer_digest"
  Signing digest to use. The same as the
  **-\f(BIdigest** command line option. (Mandatory unless specified on the command
  line)
* **default\_policy**  
  .IX Item "default_policy"
  The default policy to use when the request does not mandate any
  policy. The same as the **-tspolicy** command line option. (Optional)
* **other\_policies**  
  .IX Item "other_policies"
  Comma separated list of policies that are also acceptable by the \s-1TSA\s0
  and used only if the request explicitly specifies one of them. (Optional)
* **digests**  
  .IX Item "digests"
  The list of message digest algorithms that the \s-1TSA\s0 accepts. At least
  one algorithm must be specified. (Mandatory)
* **accuracy**  
  .IX Item "accuracy"
  The accuracy of the time source of the \s-1TSA\s0 in seconds, milliseconds
  and microseconds. E.g. secs:1, millisecs:500, microsecs:100. If any of
  the components is missing zero is assumed for that field. (Optional)
* **clock\_precision\_digits**  
  .IX Item "clock_precision_digits"
  Specifies the maximum number of digits, which represent the fraction of
  seconds, that  need to be included in the time field. The trailing zeros
  must be removed from the time, so there might actually be fewer digits,
  or no fraction of seconds at all. Supported only on \s-1UNIX\s0 platforms.
  The maximum value is 6, default is 0.
  (Optional)
* **ordering**  
  .IX Item "ordering"
  If this option is yes the responses generated by this \s-1TSA\s0 can always
  be ordered, even if the time difference between two responses is less
  than the sum of their accuracies. Default is no. (Optional)
* **tsa\_name**  
  .IX Item "tsa_name"
  Set this option to yes if the subject name of the \s-1TSA\s0 must be included in
  the \s-1TSA\s0 name field of the response. Default is no. (Optional)
* **ess\_cert\_id\_chain**  
  .IX Item "ess_cert_id_chain"
  The SignedData objects created by the \s-1TSA\s0 always contain the
  certificate identifier of the signing certificate in a signed
  attribute (see \s-1RFC 2634,\s0 Enhanced Security Services). If this option
  is set to yes and either the **certs** variable or the **-chain** option
  is specified then the certificate identifiers of the chain will also
  be included in the SigningCertificate signed attribute. If this
  variable is set to no, only the signing certificate identifier is
  included. Default is no. (Optional)
* **ess\_cert\_id\_alg**  
  .IX Item "ess_cert_id_alg"
  This option specifies the hash function to be used to calculate the \s-1TSA\s0's
  public key certificate identifier. Default is sha256. (Optional)

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
All the examples below presume that **\s-1OPENSSL\_CONF\s0** is set to a proper
configuration file, e.g. the example configuration file
openssl/apps/openssl.cnf will do.

<a name="time-stamp-request"></a>

### Time Stamp Request

.IX Subsection "Time Stamp Request"
To create a timestamp request for design1.txt with \s-1SHA-256\s0
without nonce and policy and no certificate is required in the response:

.Vb 2
  openssl ts -query -data design1.txt -no_nonce \e
        -out design1.tsq
.Ve

To create a similar timestamp request with specifying the message imprint
explicitly:

.Vb 2
  openssl ts -query -digest b7e5d3f93198b38379852f2c04e78d73abdd0f4b \e
         -no_nonce -out design1.tsq
.Ve

To print the content of the previous request in human readable format:

.Vb 1
  openssl ts -query -in design1.tsq -text
.Ve

To create a timestamp request which includes the \s-1SHA-512\s0 digest
of design2.txt, requests the signer certificate and nonce,
specifies a policy id (assuming the tsa_policy1 name is defined in the
\s-1OID\s0 section of the config file):

.Vb 2
  openssl ts -query -data design2.txt -sha512 \e
        -tspolicy tsa_policy1 -cert -out design2.tsq
.Ve

<a name="time-stamp-response"></a>

### Time Stamp Response

.IX Subsection "Time Stamp Response"
Before generating a response a signing certificate must be created for
the \s-1TSA\s0 that contains the **timeStamping** critical extended key usage extension
without any other key usage extensions. You can add this line to the
user certificate section of the config file to generate a proper certificate;

.Vb 1
   extendedKeyUsage = critical,timeStamping
.Ve

See **req**\|(1), **ca**\|(1), and **x509**\|(1) for instructions. The examples
below assume that cacert.pem contains the certificate of the \s-1CA,\s0
tsacert.pem is the signing certificate issued by cacert.pem and
tsakey.pem is the private key of the \s-1TSA.\s0

To create a timestamp response for a request:

.Vb 2
  openssl ts -reply -queryfile design1.tsq -inkey tsakey.pem \e
        -signer tsacert.pem -out design1.tsr
.Ve

If you want to use the settings in the config file you could just write:

.Vb 1
  openssl ts -reply -queryfile design1.tsq -out design1.tsr
.Ve

To print a timestamp reply to stdout in human readable format:

.Vb 1
  openssl ts -reply -in design1.tsr -text
.Ve

To create a timestamp token instead of timestamp response:

.Vb 1
  openssl ts -reply -queryfile design1.tsq -out design1_token.der -token_out
.Ve

To print a timestamp token to stdout in human readable format:

.Vb 1
  openssl ts -reply -in design1_token.der -token_in -text -token_out
.Ve

To extract the timestamp token from a response:

.Vb 1
  openssl ts -reply -in design1.tsr -out design1_token.der -token_out
.Ve

To add 'granted' status info to a timestamp token thereby creating a
valid response:

.Vb 1
  openssl ts -reply -in design1_token.der -token_in -out design1.tsr
.Ve

<a name="time-stamp-verification"></a>

### Time Stamp Verification

.IX Subsection "Time Stamp Verification"
To verify a timestamp reply against a request:

.Vb 2
  openssl ts -verify -queryfile design1.tsq -in design1.tsr \e
        -CAfile cacert.pem -untrusted tsacert.pem
.Ve

To verify a timestamp reply that includes the certificate chain:

.Vb 2
  openssl ts -verify -queryfile design2.tsq -in design2.tsr \e
        -CAfile cacert.pem
.Ve

To verify a timestamp token against the original data file:
  openssl ts -verify -data design2.txt -in design2.tsr \e
        -CAfile cacert.pem

To verify a timestamp token against a message imprint:
  openssl ts -verify -digest b7e5d3f93198b38379852f2c04e78d73abdd0f4b \e
         -in design2.tsr -CAfile cacert.pem

You could also look at the 'test' directory for more examples.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"

* ·  
  No support for timestamps over \s-1SMTP,\s0 though it is quite easy
  to implement an automatic e-mail based \s-1TSA\s0 with **procmail**\|(1)
  and **perl**\|(1). \s-1HTTP\s0 server support is provided in the form of
  a separate apache module. \s-1HTTP\s0 client support is provided by
  **tsget**\|(1). Pure \s-1TCP/IP\s0 protocol is not supported.
* ·  
  The file containing the last serial number of the \s-1TSA\s0 is not
  locked when being read or written. This is a problem if more than one
  instance of **openssl**\|(1) is trying to create a timestamp
  response at the same time. This is not an issue when using the apache
  server module, it does proper locking.
* ·  
  Look for the \s-1FIXME\s0 word in the source files.
* ·  
  The source code should really be reviewed by somebody else, too.
* ·  
  More testing is needed, I have done only some basic tests (see
  test/testtsa).

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**tsget**\|(1), **openssl**\|(1), **req**\|(1),
**x509**\|(1), **ca**\|(1), **genrsa**\|(1),
**config**\|(5)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2006-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
