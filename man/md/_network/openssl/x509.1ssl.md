# x509(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-x509, x509 - Certificate display and signing utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl x509 [-help] [-inform DER|PEM] [-outform DER|PEM] [-keyform DER|PEM|ENGINE] [-CAform DER|PEM] [-CAkeyform DER|PEM] [-in filename] [-out filename] [-serial] [-hash] [-subject_hash] [-issuer_hash] [-ocspid] [-subject] [-issuer] [-nameopt option] [-email] [-ocsp_uri] [-startdate] [-enddate] [-purpose] [-dates] [-checkend num] [-modulus] [-pubkey] [-fingerprint] [-alias] [-noout] [-trustout] [-clrtrust] [-clrreject] [-addtrust arg] [-addreject arg] [-setalias arg] [-days arg] [-set_serial n] [-signkey arg] [-passin arg] [-x509toreq] [-req] [-CA filename] [-CAkey filename] [-CAcreateserial] [-CAserial filename] [-force_pubkey key] [-text] [-ext extensions] [-certopt option] [-C] [-\f(BIdigest] [-clrext] [-extfile filename] [-extensions section] [-sigopt nm:v] [-rand file...] [-writerand file] [-engine id] [-preserve_dates]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **x509** command is a multi purpose certificate utility. It can be
used to display certificate information, convert certificates to
various forms, sign certificate requests like a mini \s-1CA\*(R"\s0 or edit
certificate trust settings.

Since there are a large number of options they will split up into
various sections.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

<a name="input-output-and-general-purpose-options"></a>

### Input, Output, and General Purpose Options

.IX Subsection "Input, Output, and General Purpose Options"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format normally the command will expect an X509
  certificate but this can change if other options such as **-req** are
  present. The \s-1DER\s0 format is the \s-1DER\s0 encoding of the certificate and \s-1PEM\s0
  is the base64 encoding of the \s-1DER\s0 encoding with header and footer lines
  added. The default format is \s-1PEM.\s0
* **-outform DER|PEM**  
  .IX Item "-outform DER|PEM"
  This specifies the output format, the options have the same meaning and default
  as the **-inform** option.
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read a certificate from or standard input
  if this option is not specified.
* **-out filename**  
  .IX Item "-out filename"
  This specifies the output filename to write to or standard output by
  default.
* **-\f(BIdigest**  
  .IX Item "-digest"
  The digest to use.
  This affects any signing or display option that uses a message
  digest, such as the **-fingerprint**, **-signkey** and **-CA** options.
  Any digest supported by the OpenSSL **dgst** command can be used.
  If not specified then \s-1SHA1\s0 is used with **-fingerprint** or
  the default digest for the signing algorithm is used, typically \s-1SHA256.\s0
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
  Specifying an engine (by its unique **id** string) will cause **x509**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.
* **-preserve\_dates**  
  .IX Item "-preserve_dates"
  When signing a certificate, preserve the notBefore\*(R" and \*(L"notAfter\*(R" dates instead
  of adjusting them to current time and duration. Cannot be used with the **-days** option.

<a name="display-options"></a>

### Display Options

.IX Subsection "Display Options"
Note: the **-alias** and **-purpose** options are also display options
but are described in the **\s-1TRUST SETTINGS\s0** section.

* **-text**  
  .IX Item "-text"
  Prints out the certificate in text form. Full details are output including the
  public key, signature algorithms, issuer and subject names, serial number
  any extensions present and any trust settings.
* **-ext extensions**  
  .IX Item "-ext extensions"
  Prints out the certificate extensions in text form. Extensions are specified
  with a comma separated string, e.g., subjectAltName,subjectKeyIdentifier\*(R".
  See the **x509v3\_config**\|(5) manual page for the extension names.
* **-certopt option**  
  .IX Item "-certopt option"
  Customise the output format used with **-text**. The **option** argument
  can be a single option or multiple options separated by commas. The
  **-certopt** switch may be also be used more than once to set multiple
  options. See the **\s-1TEXT OPTIONS\s0** section for more information.
* **-noout**  
  .IX Item "-noout"
  This option prevents output of the encoded version of the certificate.
* **-pubkey**  
  .IX Item "-pubkey"
  Outputs the certificate's SubjectPublicKeyInfo block in \s-1PEM\s0 format.
* **-modulus**  
  .IX Item "-modulus"
  This option prints out the value of the modulus of the public key
  contained in the certificate.
* **-serial**  
  .IX Item "-serial"
  Outputs the certificate serial number.
* **-subject\_hash**  
  .IX Item "-subject_hash"
  Outputs the hash\*(R" of the certificate subject name. This is used in OpenSSL to
  form an index to allow certificates in a directory to be looked up by subject
  name.
* **-issuer\_hash**  
  .IX Item "-issuer_hash"
  Outputs the hash\*(R" of the certificate issuer name.
* **-ocspid**  
  .IX Item "-ocspid"
  Outputs the \s-1OCSP\s0 hash values for the subject name and public key.
* **-hash**  
  .IX Item "-hash"
  Synonym for -subject_hash\*(R" for backward compatibility reasons.
* **-subject\_hash\_old**  
  .IX Item "-subject_hash_old"
  Outputs the hash\*(R" of the certificate subject name using the older algorithm
  as used by OpenSSL before version 1.0.0.
* **-issuer\_hash\_old**  
  .IX Item "-issuer_hash_old"
  Outputs the hash\*(R" of the certificate issuer name using the older algorithm
  as used by OpenSSL before version 1.0.0.
* **-subject**  
  .IX Item "-subject"
  Outputs the subject name.
* **-issuer**  
  .IX Item "-issuer"
  Outputs the issuer name.
* **-nameopt option**  
  .IX Item "-nameopt option"
  Option which determines how the subject or issuer names are displayed. The
  **option** argument can be a single option or multiple options separated by
  commas.  Alternatively the **-nameopt** switch may be used more than once to
  set multiple options. See the **\s-1NAME OPTIONS\s0** section for more information.
* **-email**  
  .IX Item "-email"
  Outputs the email address(es) if any.
* **-ocsp\_uri**  
  .IX Item "-ocsp_uri"
  Outputs the \s-1OCSP\s0 responder address(es) if any.
* **-startdate**  
  .IX Item "-startdate"
  Prints out the start date of the certificate, that is the notBefore date.
* **-enddate**  
  .IX Item "-enddate"
  Prints out the expiry date of the certificate, that is the notAfter date.
* **-dates**  
  .IX Item "-dates"
  Prints out the start and expiry dates of a certificate.
* **-checkend arg**  
  .IX Item "-checkend arg"
  Checks if the certificate expires within the next **arg** seconds and exits
  nonzero if yes it will expire or zero if not.
* **-fingerprint**  
  .IX Item "-fingerprint"
  Calculates and outputs the digest of the \s-1DER\s0 encoded version of the entire
  certificate (see digest options).
  This is commonly called a fingerprint\*(R". Because of the nature of message
  digests, the fingerprint of a certificate is unique to that certificate and
  two certificates with the same fingerprint can be considered to be the same.
* **-C**  
  .IX Item "-C"
  This outputs the certificate in the form of a C source file.

<a name="trust-settings"></a>

### Trust Settings

.IX Subsection "Trust Settings"
A **trusted certificate** is an ordinary certificate which has several
additional pieces of information attached to it such as the permitted
and prohibited uses of the certificate and an alias\*(R".

Normally when a certificate is being verified at least one certificate
must be trusted\*(R". By default a trusted certificate must be stored
locally and must be a root \s-1CA:\s0 any certificate chain ending in this \s-1CA\s0
is then usable for any purpose.

Trust settings currently are only used with a root \s-1CA.\s0 They allow a finer
control over the purposes the root \s-1CA\s0 can be used for. For example a \s-1CA\s0
may be trusted for \s-1SSL\s0 client but not \s-1SSL\s0 server use.

See the description of the **verify** utility for more information on the
meaning of trust settings.

Future versions of OpenSSL will recognize trust settings on any
certificate: not just root CAs.

* **-trustout**  
  .IX Item "-trustout"
  This causes **x509** to output a **trusted** certificate. An ordinary
  or trusted certificate can be input but by default an ordinary
  certificate is output and any trust settings are discarded. With the
  **-trustout** option a trusted certificate is output. A trusted
  certificate is automatically output if any trust settings are modified.
* **-setalias arg**  
  .IX Item "-setalias arg"
  Sets the alias of the certificate. This will allow the certificate
  to be referred to using a nickname for example Steve's Certificate\*(R".
* **-alias**  
  .IX Item "-alias"
  Outputs the certificate alias, if any.
* **-clrtrust**  
  .IX Item "-clrtrust"
  Clears all the permitted or trusted uses of the certificate.
* **-clrreject**  
  .IX Item "-clrreject"
  Clears all the prohibited or rejected uses of the certificate.
* **-addtrust arg**  
  .IX Item "-addtrust arg"
  Adds a trusted certificate use.
  Any object name can be used here but currently only **clientAuth** (\s-1SSL\s0 client
  use), **serverAuth** (\s-1SSL\s0 server use), **emailProtection** (S/MIME email) and
  **anyExtendedKeyUsage** are used.
  As of OpenSSL 1.1.0, the last of these blocks all purposes when rejected or
  enables all purposes when trusted.
  Other OpenSSL applications may define additional uses.
* **-addreject arg**  
  .IX Item "-addreject arg"
  Adds a prohibited use. It accepts the same values as the **-addtrust**
  option.
* **-purpose**  
  .IX Item "-purpose"
  This option performs tests on the certificate extensions and outputs
  the results. For a more complete description see the \s-1CERTIFICATE
  EXTENSIONS\s0 section.

<a name="signing-options"></a>

### Signing Options

.IX Subsection "Signing Options"
The **x509** utility can be used to sign certificates and requests: it
can thus behave like a mini \s-1CA\*(R".\s0

* **-signkey arg**  
  .IX Item "-signkey arg"
  This option causes the input file to be self signed using the supplied
  private key or engine. The private key's format is specified with the
  **-keyform** option.
  .Sp
  If the input file is a certificate it sets the issuer name to the
  subject name (i.e.  makes it self signed) changes the public key to the
  supplied value and changes the start and end dates. The start date is
  set to the current time and the end date is set to a value determined
  by the **-days** option. Any certificate extensions are retained unless
  the **-clrext** option is supplied; this includes, for example, any existing
  key identifier extensions.
  .Sp
  If the input is a certificate request then a self signed certificate
  is created using the supplied private key using the subject name in
  the request.
* **-sigopt nm:v**  
  .IX Item "-sigopt nm:v"
  Pass options to the signature algorithm during sign or verify operations.
  Names and values of these options are algorithm-specific.
* **-passin arg**  
  .IX Item "-passin arg"
  The key password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-clrext**  
  .IX Item "-clrext"
  Delete any extensions from a certificate. This option is used when a
  certificate is being created from another certificate (for example with
  the **-signkey** or the **-CA** options). Normally all extensions are
  retained.
* **-keyform PEM|DER|ENGINE**  
  .IX Item "-keyform PEM|DER|ENGINE"
  Specifies the format (\s-1DER\s0 or \s-1PEM\s0) of the private key file used in the
  **-signkey** option.
* **-days arg**  
  .IX Item "-days arg"
  Specifies the number of days to make a certificate valid for. The default
  is 30 days. Cannot be used with the **-preserve\_dates** option.
* **-x509toreq**  
  .IX Item "-x509toreq"
  Converts a certificate into a certificate request. The **-signkey** option
  is used to pass the required private key.
* **-req**  
  .IX Item "-req"
  By default a certificate is expected on input. With this option a
  certificate request is expected instead.
* **-set_serial n**  
  .IX Item "-set_serial n"
  Specifies the serial number to use. This option can be used with either
  the **-signkey** or **-CA** options. If used in conjunction with the **-CA**
  option the serial number file (as specified by the **-CAserial** or
  **-CAcreateserial** options) is not used.
  .Sp
  The serial number can be decimal or hex (if preceded by **0x**).
* **-CA filename**  
  .IX Item "-CA filename"
  Specifies the \s-1CA\s0 certificate to be used for signing. When this option is
  present **x509** behaves like a mini \s-1CA\*(R".\s0 The input file is signed by this
  \s-1CA\s0 using this option: that is its issuer name is set to the subject name
  of the \s-1CA\s0 and it is digitally signed using the CAs private key.
  .Sp
  This option is normally combined with the **-req** option. Without the
  **-req** option the input is a certificate which must be self signed.
* **-CAkey filename**  
  .IX Item "-CAkey filename"
  Sets the \s-1CA\s0 private key to sign a certificate with. If this option is
  not specified then it is assumed that the \s-1CA\s0 private key is present in
  the \s-1CA\s0 certificate file.
* **-CAserial filename**  
  .IX Item "-CAserial filename"
  Sets the \s-1CA\s0 serial number file to use.
  .Sp
  When the **-CA** option is used to sign a certificate it uses a serial
  number specified in a file. This file consists of one line containing
  an even number of hex digits with the serial number to use. After each
  use the serial number is incremented and written out to the file again.
  .Sp
  The default filename consists of the \s-1CA\s0 certificate file base name with
  .srl\*(R" appended. For example if the \s-1CA\s0 certificate file is called
  mycacert.pem\*(R" it expects to find a serial number file called \*(L"mycacert.srl\*(R".
* **-CAcreateserial**  
  .IX Item "-CAcreateserial"
  With this option the \s-1CA\s0 serial number file is created if it does not exist:
  it will contain the serial number 02\*(R" and the certificate being signed will
  have the 1 as its serial number. If the **-CA** option is specified
  and the serial number file does not exist a random number is generated;
  this is the recommended practice.
* **-extfile filename**  
  .IX Item "-extfile filename"
  File containing certificate extensions to use. If not specified then
  no extensions are added to the certificate.
* **-extensions section**  
  .IX Item "-extensions section"
  The section to add certificate extensions from. If this option is not
  specified then the extensions should either be contained in the unnamed
  (default) section or the default section should contain a variable called
  extensions\*(R" which contains the section to use. See the
  **x509v3\_config**\|(5) manual page for details of the
  extension section format.
* **-force_pubkey key**  
  .IX Item "-force_pubkey key"
  When a certificate is created set its public key to **key** instead of the
  key in the certificate or certificate request. This option is useful for
  creating certificates where the algorithm can't normally sign requests, for
  example \s-1DH.\s0
  .Sp
  The format or **key** can be specified using the **-keyform** option.

<a name="name-options"></a>

### Name Options

.IX Subsection "Name Options"
The **nameopt** command line switch determines how the subject and issuer
names are displayed. If no **nameopt** switch is present the default oneline\*(R"
format is used which is compatible with previous versions of OpenSSL.
Each option is described in detail below, all options can be preceded by
a **-** to turn the option off. Only the first four will normally be used.

* **compat**  
  .IX Item "compat"
  Use the old format.
* **\s-1RFC2253\s0**  
  .IX Item "RFC2253"
  Displays names compatible with \s-1RFC2253\s0 equivalent to **esc\_2253**, **esc\_ctrl**,
  **esc\_msb**, **utf8**, **dump\_nostr**, **dump\_unknown**, **dump\_der**,
  **sep\_comma\_plus**, **dn\_rev** and **sname**.
* **oneline**  
  .IX Item "oneline"
  A oneline format which is more readable than \s-1RFC2253.\s0 It is equivalent to
  specifying the  **esc\_2253**, **esc\_ctrl**, **esc\_msb**, **utf8**, **dump\_nostr**,
  **dump\_der**, **use\_quote**, **sep\_comma\_plus\_space**, **space\_eq** and **sname**
  options.  This is the _default_ of no name options are given explicitly.
* **multiline**  
  .IX Item "multiline"
  A multiline format. It is equivalent **esc\_ctrl**, **esc\_msb**, **sep\_multiline**,
  **space\_eq**, **lname** and **align**.
* **esc\_2253**  
  .IX Item "esc_2253"
  Escape the special\*(R" characters required by \s-1RFC2253\s0 in a field. That is
  **,+"&lt;&gt;;**. Additionally **#** is escaped at the beginning of a string
  and a space character at the beginning or end of a string.
* **esc\_2254**  
  .IX Item "esc_2254"
  Escape the special\*(R" characters required by \s-1RFC2254\s0 in a field. That is
  the **\s-1NUL\s0** character as well as and **()***.
* **esc\_ctrl**  
  .IX Item "esc_ctrl"
  Escape control characters. That is those with \s-1ASCII\s0 values less than
  0x20 (space) and the delete (0x7f) character. They are escaped using the
  \s-1RFC2253\s0 \eXX notation (where \s-1XX\s0 are two hex digits representing the
  character value).
* **esc\_msb**  
  .IX Item "esc_msb"
  Escape characters with the \s-1MSB\s0 set, that is with \s-1ASCII\s0 values larger than
  127.
* **use\_quote**  
  .IX Item "use_quote"
  Escapes some characters by surrounding the whole string with **"** characters,
  without the option all escaping is done with the **\e** character.
* **utf8**  
  .IX Item "utf8"
  Convert all strings to \s-1UTF8\s0 format first. This is required by \s-1RFC2253.\s0 If
  you are lucky enough to have a \s-1UTF8\s0 compatible terminal then the use
  of this option (and **not** setting **esc\_msb**) may result in the correct
  display of multibyte (international) characters. Is this option is not
  present then multibyte characters larger than 0xff will be represented
  using the format \eUXXXX for 16 bits and \eWXXXXXXXX for 32 bits.
  Also if this option is off any UTF8Strings will be converted to their
  character form first.
* **ignore\_type**  
  .IX Item "ignore_type"
  This option does not attempt to interpret multibyte characters in any
  way. That is their content octets are merely dumped as though one octet
  represents each character. This is useful for diagnostic purposes but
  will result in rather odd looking output.
* **show\_type**  
  .IX Item "show_type"
  Show the type of the \s-1ASN1\s0 character string. The type precedes the
  field contents. For example \s-1BMPSTRING:\s0 Hello World\*(R".
* **dump\_der**  
  .IX Item "dump_der"
  When this option is set any fields that need to be hexdumped will
  be dumped using the \s-1DER\s0 encoding of the field. Otherwise just the
  content octets will be displayed. Both options use the \s-1RFC2253\s0
  **#XXXX...** format.
* **dump\_nostr**  
  .IX Item "dump_nostr"
  Dump non character string types (for example \s-1OCTET STRING\s0) if this
  option is not set then non character string types will be displayed
  as though each content octet represents a single character.
* **dump\_all**  
  .IX Item "dump_all"
  Dump all fields. This option when used with **dump\_der** allows the
  \s-1DER\s0 encoding of the structure to be unambiguously determined.
* **dump\_unknown**  
  .IX Item "dump_unknown"
  Dump any field whose \s-1OID\s0 is not recognised by OpenSSL.
* **sep\_comma\_plus**, **sep\_comma\_plus\_space**, **sep\_semi\_plus\_space**, **sep\_multiline**  
  .IX Item "sep_comma_plus, sep_comma_plus_space, sep_semi_plus_space, sep_multiline"
  These options determine the field separators. The first character is
  between RDNs and the second between multiple AVAs (multiple AVAs are
  very rare and their use is discouraged). The options ending in
  space\*(R" additionally place a space after the separator to make it
  more readable. The **sep\_multiline** uses a linefeed character for
  the \s-1RDN\s0 separator and a spaced **+** for the \s-1AVA\s0 separator. It also
  indents the fields by four characters. If no field separator is specified
  then **sep\_comma\_plus\_space** is used by default.
* **dn\_rev**  
  .IX Item "dn_rev"
  Reverse the fields of the \s-1DN.\s0 This is required by \s-1RFC2253.\s0 As a side
  effect this also reverses the order of multiple AVAs but this is
  permissible.
* **nofname**, **sname**, **lname**, **oid**  
  .IX Item "nofname, sname, lname, oid"
  These options alter how the field name is displayed. **nofname** does
  not display the field at all. **sname** uses the short name\*(R" form
  (\s-1CN\s0 for commonName for example). **lname** uses the long form.
  **oid** represents the \s-1OID\s0 in numerical form and is useful for
  diagnostic purpose.
* **align**  
  .IX Item "align"
  Align field values for a more readable output. Only usable with
  **sep\_multiline**.
* **space\_eq**  
  .IX Item "space_eq"
  Places spaces round the **=** character which follows the field
  name.

<a name="text-options"></a>

### Text Options

.IX Subsection "Text Options"
As well as customising the name output format, it is also possible to
customise the actual fields printed using the **certopt** options when
the **text** option is present. The default behaviour is to print all fields.

* **compatible**  
  .IX Item "compatible"
  Use the old format. This is equivalent to specifying no output options at all.
* **no\_header**  
  .IX Item "no_header"
  Don't print header information: that is the lines saying Certificate\*(R"
  and Data\*(R".
* **no\_version**  
  .IX Item "no_version"
  Don't print out the version number.
* **no\_serial**  
  .IX Item "no_serial"
  Don't print out the serial number.
* **no\_signame**  
  .IX Item "no_signame"
  Don't print out the signature algorithm used.
* **no\_validity**  
  .IX Item "no_validity"
  Don't print the validity, that is the **notBefore** and **notAfter** fields.
* **no\_subject**  
  .IX Item "no_subject"
  Don't print out the subject name.
* **no\_issuer**  
  .IX Item "no_issuer"
  Don't print out the issuer name.
* **no\_pubkey**  
  .IX Item "no_pubkey"
  Don't print out the public key.
* **no\_sigdump**  
  .IX Item "no_sigdump"
  Don't give a hexadecimal dump of the certificate signature.
* **no\_aux**  
  .IX Item "no_aux"
  Don't print out certificate trust information.
* **no\_extensions**  
  .IX Item "no_extensions"
  Don't print out any X509V3 extensions.
* **ext\_default**  
  .IX Item "ext_default"
  Retain default extension behaviour: attempt to print out unsupported
  certificate extensions.
* **ext\_error**  
  .IX Item "ext_error"
  Print an error message for unsupported certificate extensions.
* **ext\_parse**  
  .IX Item "ext_parse"
  \s-1ASN1\s0 parse unsupported extensions.
* **ext\_dump**  
  .IX Item "ext_dump"
  Hex dump unsupported extensions.
* **ca\_default**  
  .IX Item "ca_default"
  The value used by the **ca** utility, equivalent to **no\_issuer**, **no\_pubkey**,
  **no\_header**, and **no\_version**.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Note: in these examples the '\e' means the example should be all on one
line.

Display the contents of a certificate:

.Vb 1
 openssl x509 -in cert.pem -noout -text
.Ve

Display the Subject Alternative Name\*(R" extension of a certificate:

.Vb 1
 openssl x509 -in cert.pem -noout -ext subjectAltName
.Ve

Display more extensions of a certificate:

.Vb 1
 openssl x509 -in cert.pem -noout -ext subjectAltName,nsCertType
.Ve

Display the certificate serial number:

.Vb 1
 openssl x509 -in cert.pem -noout -serial
.Ve

Display the certificate subject name:

.Vb 1
 openssl x509 -in cert.pem -noout -subject
.Ve

Display the certificate subject name in \s-1RFC2253\s0 form:

.Vb 1
 openssl x509 -in cert.pem -noout -subject -nameopt RFC2253
.Ve

Display the certificate subject name in oneline form on a terminal
supporting \s-1UTF8:\s0

.Vb 1
 openssl x509 -in cert.pem -noout -subject -nameopt oneline,-esc_msb
.Ve

Display the certificate \s-1SHA1\s0 fingerprint:

.Vb 1
 openssl x509 -sha1 -in cert.pem -noout -fingerprint
.Ve

Convert a certificate from \s-1PEM\s0 to \s-1DER\s0 format:

.Vb 1
 openssl x509 -in cert.pem -inform PEM -out cert.der -outform DER
.Ve

Convert a certificate to a certificate request:

.Vb 1
 openssl x509 -x509toreq -in cert.pem -out req.pem -signkey key.pem
.Ve

Convert a certificate request into a self signed certificate using
extensions for a \s-1CA:\s0

.Vb 2
 openssl x509 -req -in careq.pem -extfile openssl.cnf -extensions v3_ca \e
        -signkey key.pem -out cacert.pem
.Ve

Sign a certificate request using the \s-1CA\s0 certificate above and add user
certificate extensions:

.Vb 2
 openssl x509 -req -in req.pem -extfile openssl.cnf -extensions v3_usr \e
        -CA cacert.pem -CAkey key.pem -CAcreateserial
.Ve

Set a certificate to be trusted for \s-1SSL\s0 client use and change set its alias to
Steve's Class 1 \s-1CA\*(R"\s0

.Vb 2
 openssl x509 -in cert.pem -addtrust clientAuth \e
        -setalias "Steves Class 1 CA" -out trust.pem
.Ve

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The \s-1PEM\s0 format uses the header and footer lines:

.Vb 2
 -----BEGIN CERTIFICATE-----
 -----END CERTIFICATE-----
.Ve

it will also handle files containing:

.Vb 2
 -----BEGIN X509 CERTIFICATE-----
 -----END X509 CERTIFICATE-----
.Ve

Trusted certificates have the lines

.Vb 2
 -----BEGIN TRUSTED CERTIFICATE-----
 -----END TRUSTED CERTIFICATE-----
.Ve

The conversion to \s-1UTF8\s0 format used with the name options assumes that
T61Strings use the \s-1ISO8859-1\s0 character set. This is wrong but Netscape
and \s-1MSIE\s0 do this as do many certificates. So although this is incorrect
it is more likely to display the majority of certificates correctly.

The **-email** option searches the subject name and the subject alternative
name extension. Only unique email addresses will be printed out: it will
not print the same address more than once.

<a name="certificate-extensions"></a>

# Certificate Extensions

.IX Header "CERTIFICATE EXTENSIONS"
The **-purpose** option checks the certificate extensions and determines
what the certificate can be used for. The actual checks done are rather
complex and include various hacks and workarounds to handle broken
certificates and software.

The same code is used when verifying untrusted certificates in chains
so this section is useful if a chain is rejected by the verify code.

The basicConstraints extension \s-1CA\s0 flag is used to determine whether the
certificate can be used as a \s-1CA.\s0 If the \s-1CA\s0 flag is true then it is a \s-1CA,\s0
if the \s-1CA\s0 flag is false then it is not a \s-1CA.\s0 **All** CAs should have the
\s-1CA\s0 flag set to true.

If the basicConstraints extension is absent then the certificate is
considered to be a possible \s-1CA\*(R"\s0 other extensions are checked according
to the intended use of the certificate. A warning is given in this case
because the certificate should really not be regarded as a \s-1CA:\s0 however
it is allowed to be a \s-1CA\s0 to work around some broken software.

If the certificate is a V1 certificate (and thus has no extensions) and
it is self signed it is also assumed to be a \s-1CA\s0 but a warning is again
given: this is to work around the problem of Verisign roots which are V1
self signed certificates.

If the keyUsage extension is present then additional restraints are
made on the uses of the certificate. A \s-1CA\s0 certificate **must** have the
keyCertSign bit set if the keyUsage extension is present.

The extended key usage extension places additional restrictions on the
certificate uses. If this extension is present (whether critical or not)
the key can only be used for the purposes specified.

A complete description of each test is given below. The comments about
basicConstraints and keyUsage and V1 certificates above apply to **all**
\s-1CA\s0 certificates.

* **\s-1SSL\s0 Client**  
  .IX Item "SSL Client"
  The extended key usage extension must be absent or include the web client
  authentication \s-1OID.\s0  keyUsage must be absent or it must have the
  digitalSignature bit set. Netscape certificate type must be absent or it must
  have the \s-1SSL\s0 client bit set.
* **\s-1SSL\s0 Client \s-1CA\s0**  
  .IX Item "SSL Client CA"
  The extended key usage extension must be absent or include the web client
  authentication \s-1OID.\s0 Netscape certificate type must be absent or it must have
  the \s-1SSL CA\s0 bit set: this is used as a work around if the basicConstraints
  extension is absent.
* **\s-1SSL\s0 Server**  
  .IX Item "SSL Server"
  The extended key usage extension must be absent or include the web server
  authentication and/or one of the \s-1SGC\s0 OIDs.  keyUsage must be absent or it
  must have the digitalSignature, the keyEncipherment set or both bits set.
  Netscape certificate type must be absent or have the \s-1SSL\s0 server bit set.
* **\s-1SSL\s0 Server \s-1CA\s0**  
  .IX Item "SSL Server CA"
  The extended key usage extension must be absent or include the web server
  authentication and/or one of the \s-1SGC\s0 OIDs.  Netscape certificate type must
  be absent or the \s-1SSL CA\s0 bit must be set: this is used as a work around if the
  basicConstraints extension is absent.
* **Netscape \s-1SSL\s0 Server**  
  .IX Item "Netscape SSL Server"
  For Netscape \s-1SSL\s0 clients to connect to an \s-1SSL\s0 server it must have the
  keyEncipherment bit set if the keyUsage extension is present. This isn't
  always valid because some cipher suites use the key for digital signing.
  Otherwise it is the same as a normal \s-1SSL\s0 server.
* **Common S/MIME Client Tests**  
  .IX Item "Common S/MIME Client Tests"
  The extended key usage extension must be absent or include the email
  protection \s-1OID.\s0 Netscape certificate type must be absent or should have the
  S/MIME bit set. If the S/MIME bit is not set in Netscape certificate type
  then the \s-1SSL\s0 client bit is tolerated as an alternative but a warning is shown:
  this is because some Verisign certificates don't set the S/MIME bit.
* **S/MIME Signing**  
  .IX Item "S/MIME Signing"
  In addition to the common S/MIME client tests the digitalSignature bit or
  the nonRepudiation bit must be set if the keyUsage extension is present.
* **S/MIME Encryption**  
  .IX Item "S/MIME Encryption"
  In addition to the common S/MIME tests the keyEncipherment bit must be set
  if the keyUsage extension is present.
* **S/MIME \s-1CA\s0**  
  .IX Item "S/MIME CA"
  The extended key usage extension must be absent or include the email
  protection \s-1OID.\s0 Netscape certificate type must be absent or must have the
  S/MIME \s-1CA\s0 bit set: this is used as a work around if the basicConstraints
  extension is absent.
* **\s-1CRL\s0 Signing**  
  .IX Item "CRL Signing"
  The keyUsage extension must be absent or it must have the \s-1CRL\s0 signing bit
  set.
* **\s-1CRL\s0 Signing \s-1CA\s0**  
  .IX Item "CRL Signing CA"
  The normal \s-1CA\s0 tests apply. Except in this case the basicConstraints extension
  must be present.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
Extensions in certificates are not transferred to certificate requests and
vice versa.

It is possible to produce invalid certificates or requests by specifying the
wrong private key or using inconsistent options in some cases: these should
be checked.

There should be options to explicitly set such things as start and end
dates rather than an offset from the current time.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**req**\|(1), **ca**\|(1), **genrsa**\|(1),
**gendsa**\|(1), **verify**\|(1),
**x509v3\_config**\|(5)

<a name="history"></a>

# History

.IX Header "HISTORY"
The hash algorithm used in the **-subject\_hash** and **-issuer\_hash** options
before OpenSSL 1.0.0 was based on the deprecated \s-1MD5\s0 algorithm and the encoding
of the distinguished name. In OpenSSL 1.0.0 and later it is based on a
canonical version of the \s-1DN\s0 using \s-1SHA1.\s0 This means that any directories using
the old form must have their links rebuilt using **c\_rehash** or similar.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
