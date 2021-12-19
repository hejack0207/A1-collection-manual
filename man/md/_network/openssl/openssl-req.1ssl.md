# req(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-req, req - PKCS#10 certificate request and certificate generating utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl req [-help] [-inform PEM|DER] [-outform PEM|DER] [-in filename] [-passin arg] [-out filename] [-passout arg] [-text] [-pubkey] [-noout] [-verify] [-modulus] [-new] [-rand file...] [-writerand file] [-newkey rsa:bits] [-newkey alg:file] [-nodes] [-key filename] [-keyform PEM|DER] [-keyout filename] [-keygen_engine id] [-\f(BIdigest] [-config filename] [-multivalue-rdn] [-x509] [-days n] [-set_serial n] [-newhdr] [-addext ext] [-extensions section] [-reqexts section] [-precert] [-utf8] [-nameopt] [-reqopt] [-subject] [-subj arg] [-sigopt nm:v] [-batch] [-verbose] [-engine id]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **req** command primarily creates and processes certificate requests
in PKCS#10 format. It can additionally create self signed certificates
for use as root CAs for example.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-inform DER|PEM**  
  .IX Item "-inform DER|PEM"
  This specifies the input format. The **\s-1DER\s0** option uses an \s-1ASN1 DER\s0 encoded
  form compatible with the PKCS#10. The **\s-1PEM\s0** form is the default format: it
  consists of the **\s-1DER\s0** format base64 encoded with additional header and
  footer lines.
* **-outform DER|PEM**  
  .IX Item "-outform DER|PEM"
  This specifies the output format, the options have the same meaning and default
  as the **-inform** option.
* **-in filename**  
  .IX Item "-in filename"
  This specifies the input filename to read a request from or standard input
  if this option is not specified. A request is only read if the creation
  options (**-new** and **-newkey**) are not specified.
* **-sigopt nm:v**  
  .IX Item "-sigopt nm:v"
  Pass options to the signature algorithm during sign or verify operations.
  Names and values of these options are algorithm-specific.
* **-passin arg**  
  .IX Item "-passin arg"
  The input file password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-out filename**  
  .IX Item "-out filename"
  This specifies the output filename to write to or standard output by
  default.
* **-passout arg**  
  .IX Item "-passout arg"
  The output file password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-text**  
  .IX Item "-text"
  Prints out the certificate request in text form.
* **-subject**  
  .IX Item "-subject"
  Prints out the request subject (or certificate subject if **-x509** is
  specified)
* **-pubkey**  
  .IX Item "-pubkey"
  Outputs the public key.
* **-noout**  
  .IX Item "-noout"
  This option prevents output of the encoded version of the request.
* **-modulus**  
  .IX Item "-modulus"
  This option prints out the value of the modulus of the public key
  contained in the request.
* **-verify**  
  .IX Item "-verify"
  Verifies the signature on the request.
* **-new**  
  .IX Item "-new"
  This option generates a new certificate request. It will prompt
  the user for the relevant field values. The actual fields
  prompted for and their maximum and minimum sizes are specified
  in the configuration file and any requested extensions.
  .Sp
  If the **-key** option is not used it will generate a new \s-1RSA\s0 private
  key using information specified in the configuration file.
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
* **-newkey arg**  
  .IX Item "-newkey arg"
  This option creates a new certificate request and a new private
  key. The argument takes one of several forms. **rsa:nbits**, where
  **nbits** is the number of bits, generates an \s-1RSA\s0 key **nbits**
  in size. If **nbits** is omitted, i.e. **-newkey rsa** specified,
  the default key size, specified in the configuration file is used.
  .Sp
  All other algorithms support the **-newkey alg:file** form, where file may be
  an algorithm parameter file, created by the **genpkey -genparam** command
  or and X.509 certificate for a key with appropriate algorithm.
  .Sp
  **param:file** generates a key using the parameter file or certificate **file**,
  the algorithm is determined by the parameters. **algname:file** use algorithm
  **algname** and parameter file **file**: the two algorithms must match or an
  error occurs. **algname** just uses algorithm **algname**, and parameters,
  if necessary should be specified via **-pkeyopt** parameter.
  .Sp
  **dsa:filename** generates a \s-1DSA\s0 key using the parameters
  in the file **filename**. **ec:filename** generates \s-1EC\s0 key (usable both with
  \s-1ECDSA\s0 or \s-1ECDH\s0 algorithms), **gost2001:filename** generates \s-1GOST R
  34.10-2001\s0 key (requires **ccgost** engine configured in the configuration
  file). If just **gost2001** is specified a parameter set should be
  specified by **-pkeyopt paramset:X**
* **-pkeyopt opt:value**  
  .IX Item "-pkeyopt opt:value"
  Set the public key algorithm option **opt** to **value**. The precise set of
  options supported depends on the public key algorithm used and its
  implementation. See **\s-1KEY GENERATION OPTIONS\s0** in the **genpkey** manual page
  for more details.
* **-key filename**  
  .IX Item "-key filename"
  This specifies the file to read the private key from. It also
  accepts PKCS#8 format private keys for \s-1PEM\s0 format files.
* **-keyform PEM|DER**  
  .IX Item "-keyform PEM|DER"
  The format of the private key file specified in the **-key**
  argument. \s-1PEM\s0 is the default.
* **-keyout filename**  
  .IX Item "-keyout filename"
  This gives the filename to write the newly created private key to.
  If this option is not specified then the filename present in the
  configuration file is used.
* **-nodes**  
  .IX Item "-nodes"
  If this option is specified then if a private key is created it
  will not be encrypted.
* **-\f(BIdigest**  
  .IX Item "-digest"
  This specifies the message digest to sign the request.
  Any digest supported by the OpenSSL **dgst** command can be used.
  This overrides the digest algorithm specified in
  the configuration file.
  .Sp
  Some public key algorithms may override this choice. For instance, \s-1DSA\s0
  signatures always use \s-1SHA1, GOST R 34.10\s0 signatures always use
  \s-1GOST R 34.11-94\s0 (**-md\_gost94**), Ed25519 and Ed448 never use any digest.
* **-config filename**  
  .IX Item "-config filename"
  This allows an alternative configuration file to be specified.
  Optional; for a description of the default value,
  see \s-1COMMAND SUMMARY\*(R"\s0 in **openssl**\|(1).
* **-subj arg**  
  .IX Item "-subj arg"
  Sets subject name for new request or supersedes the subject name
  when processing a request.
  The arg must be formatted as _/type0=value0/type1=value1/type2=..._.
  Keyword characters may be escaped by \e (backslash), and whitespace is retained.
  Empty values are permitted, but the corresponding type will not be included
  in the request.
* **-multivalue-rdn**  
  .IX Item "-multivalue-rdn"
  This option causes the -subj argument to be interpreted with full
  support for multivalued RDNs. Example:
  .Sp
  _/DC=org/DC=OpenSSL/DC=users/UID=123456+CN=John Doe_
  .Sp
  If -multi-rdn is not used then the \s-1UID\s0 value is _123456+CN=John Doe_.
* **-x509**  
  .IX Item "-x509"
  This option outputs a self signed certificate instead of a certificate
  request. This is typically used to generate a test certificate or
  a self signed root \s-1CA.\s0 The extensions added to the certificate
  (if any) are specified in the configuration file. Unless specified
  using the **set\_serial** option, a large random number will be used for
  the serial number.
  .Sp
  If existing request is specified with the **-in** option, it is converted
  to the self signed certificate otherwise new request is created.
* **-days n**  
  .IX Item "-days n"
  When the **-x509** option is being used this specifies the number of
  days to certify the certificate for, otherwise it is ignored. **n** should
  be a positive integer. The default is 30 days.
* **-set_serial n**  
  .IX Item "-set_serial n"
  Serial number to use when outputting a self signed certificate. This
  may be specified as a decimal value or a hex value if preceded by **0x**.
* **-addext ext**  
  .IX Item "-addext ext"
  Add a specific extension to the certificate (if the **-x509** option is
  present) or certificate request.  The argument must have the form of
  a key=value pair as it would appear in a config file.
  .Sp
  This option can be given multiple times.
* **-extensions section**  
  .IX Item "-extensions section"
* **-reqexts section**  
  .IX Item "-reqexts section"
  These options specify alternative sections to include certificate
  extensions (if the **-x509** option is present) or certificate
  request extensions. This allows several different sections to
  be used in the same configuration file to specify requests for
  a variety of purposes.
* **-precert**  
  .IX Item "-precert"
  A poison extension will be added to the certificate, making it a
  pre-certificate\*(R" (see \s-1RFC6962\s0). This can be submitted to Certificate
  Transparency logs in order to obtain signed certificate timestamps (SCTs).
  These SCTs can then be embedded into the pre-certificate as an extension, before
  removing the poison and signing the certificate.
  .Sp
  This implies the **-new** flag.
* **-utf8**  
  .IX Item "-utf8"
  This option causes field values to be interpreted as \s-1UTF8\s0 strings, by
  default they are interpreted as \s-1ASCII.\s0 This means that the field
  values, whether prompted from a terminal or obtained from a
  configuration file, must be valid \s-1UTF8\s0 strings.
* **-nameopt option**  
  .IX Item "-nameopt option"
  Option which determines how the subject or issuer names are displayed. The
  **option** argument can be a single option or multiple options separated by
  commas.  Alternatively the **-nameopt** switch may be used more than once to
  set multiple options. See the **x509**\|(1) manual page for details.
* **-reqopt**  
  .IX Item "-reqopt"
  Customise the output format used with **-text**. The **option** argument can be
  a single option or multiple options separated by commas.
  .Sp
  See discussion of the  **-certopt** parameter in the **x509**\|(1)
  command.
* **-newhdr**  
  .IX Item "-newhdr"
  Adds the word **\s-1NEW\s0** to the \s-1PEM\s0 file header and footer lines on the outputted
  request. Some software (Netscape certificate server) and some CAs need this.
* **-batch**  
  .IX Item "-batch"
  Non-interactive mode.
* **-verbose**  
  .IX Item "-verbose"
  Print extra details about the operations being performed.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **req**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.
* **-keygen_engine id**  
  .IX Item "-keygen_engine id"
  Specifies an engine (by its unique **id** string) which would be used
  for key generation operations.

<a name="configuration-file-format"></a>

# Configuration File Format

.IX Header "CONFIGURATION FILE FORMAT"
The configuration options are specified in the **req** section of
the configuration file. As with all configuration files if no
value is specified in the specific section (i.e. **req**) then
the initial unnamed or **default** section is searched too.

The options available are described in detail below.

* **input_password output\_password**  
  .IX Item "input_password output_password"
  The passwords for the input private key file (if present) and
  the output private key file (if one will be created). The
  command line options **passin** and **passout** override the
  configuration file values.
* **default\_bits**  
  .IX Item "default_bits"
  Specifies the default key size in bits.
  .Sp
  This option is used in conjunction with the **-new** option to generate
  a new key. It can be overridden by specifying an explicit key size in
  the **-newkey** option. The smallest accepted key size is 512 bits. If
  no key size is specified then 2048 bits is used.
* **default\_keyfile**  
  .IX Item "default_keyfile"
  This is the default filename to write a private key to. If not
  specified the key is written to standard output. This can be
  overridden by the **-keyout** option.
* **oid\_file**  
  .IX Item "oid_file"
  This specifies a file containing additional **\s-1OBJECT IDENTIFIERS\s0**.
  Each line of the file should consist of the numerical form of the
  object identifier followed by white space then the short name followed
  by white space and finally the long name.
* **oid\_section**  
  .IX Item "oid_section"
  This specifies a section in the configuration file containing extra
  object identifiers. Each line should consist of the short name of the
  object identifier followed by **=** and the numerical form. The short
  and long names are the same when this option is used.
* **\s-1RANDFILE\s0**  
  .IX Item "RANDFILE"
  At startup the specified file is loaded into the random number generator,
  and at exit 256 bytes will be written to it.
  It is used for private key generation.
* **encrypt\_key**  
  .IX Item "encrypt_key"
  If this is set to **no** then if a private key is generated it is
  **not** encrypted. This is equivalent to the **-nodes** command line
  option. For compatibility **encrypt\_rsa\_key** is an equivalent option.
* **default\_md**  
  .IX Item "default_md"
  This option specifies the digest algorithm to use. Any digest supported by the
  OpenSSL **dgst** command can be used. This option can be overridden on the
  command line. Certain signing algorithms (i.e. Ed25519 and Ed448) will ignore
  any digest that has been set.
* **string\_mask**  
  .IX Item "string_mask"
  This option masks out the use of certain string types in certain
  fields. Most users will not need to change this option.
  .Sp
  It can be set to several values **default** which is also the default
  option uses PrintableStrings, T61Strings and BMPStrings if the
  **pkix** value is used then only PrintableStrings and BMPStrings will
  be used. This follows the \s-1PKIX\s0 recommendation in \s-1RFC2459.\s0 If the
  **utf8only** option is used then only UTF8Strings will be used: this
  is the \s-1PKIX\s0 recommendation in \s-1RFC2459\s0 after 2003. Finally the **nombstr**
  option just uses PrintableStrings and T61Strings: certain software has
  problems with BMPStrings and UTF8Strings: in particular Netscape.
* **req\_extensions**  
  .IX Item "req_extensions"
  This specifies the configuration file section containing a list of
  extensions to add to the certificate request. It can be overridden
  by the **-reqexts** command line switch. See the
  **x509v3\_config**\|(5) manual page for details of the
  extension section format.
* **x509\_extensions**  
  .IX Item "x509_extensions"
  This specifies the configuration file section containing a list of
  extensions to add to certificate generated when the **-x509** switch
  is used. It can be overridden by the **-extensions** command line switch.
* **prompt**  
  .IX Item "prompt"
  If set to the value **no** this disables prompting of certificate fields
  and just takes values from the config file directly. It also changes the
  expected format of the **distinguished\_name** and **attributes** sections.
* **utf8**  
  .IX Item "utf8"
  If set to the value **yes** then field values to be interpreted as \s-1UTF8\s0
  strings, by default they are interpreted as \s-1ASCII.\s0 This means that
  the field values, whether prompted from a terminal or obtained from a
  configuration file, must be valid \s-1UTF8\s0 strings.
* **attributes**  
  .IX Item "attributes"
  This specifies the section containing any request attributes: its format
  is the same as **distinguished\_name**. Typically these may contain the
  challengePassword or unstructuredName types. They are currently ignored
  by OpenSSL's request signing utilities but some CAs might want them.
* **distinguished\_name**  
  .IX Item "distinguished_name"
  This specifies the section containing the distinguished name fields to
  prompt for when generating a certificate or certificate request. The format
  is described in the next section.

<a name="distinguished-name-and-attribute-section-format"></a>

# Distinguished Name and Attribute Section Format

.IX Header "DISTINGUISHED NAME AND ATTRIBUTE SECTION FORMAT"
There are two separate formats for the distinguished name and attribute
sections. If the **prompt** option is set to **no** then these sections
just consist of field names and values: for example,

.Vb 3
 CN=My Name
 OU=My Organization
 emailAddress=someone@somewhere.org
.Ve

This allows external programs (e.g. \s-1GUI\s0 based) to generate a template file
with all the field names and values and just pass it to **req**. An example
of this kind of configuration file is contained in the **\s-1EXAMPLES\s0** section.

Alternatively if the **prompt** option is absent or not set to **no** then the
file contains field prompting information. It consists of lines of the form:

.Vb 4
 fieldName="prompt"
 fieldName_default="default field value"
 fieldName_min= 2
 fieldName_max= 4
.Ve

fieldName\*(R" is the field name being used, for example commonName (or \s-1CN\s0).
The prompt\*(R" string is used to ask the user to enter the relevant
details. If the user enters nothing then the default value is used if no
default value is present then the field is omitted. A field can
still be omitted if a default value is present if the user just
enters the '.' character.

The number of characters entered must be between the fieldName_min and
fieldName_max limits: there may be additional restrictions based
on the field being used (for example countryName can only ever be
two characters long and must fit in a PrintableString).

Some fields (such as organizationName) can be used more than once
in a \s-1DN.\s0 This presents a problem because configuration files will
not recognize the same name occurring twice. To avoid this problem
if the fieldName contains some characters followed by a full stop
they will be ignored. So for example a second organizationName can
be input by calling it 1.organizationName\*(R".

The actual permitted field names are any object identifier short or
long names. These are compiled into OpenSSL and include the usual
values such as commonName, countryName, localityName, organizationName,
organizationalUnitName, stateOrProvinceName. Additionally emailAddress
is included as well as name, surname, givenName, initials, and dnQualifier.

Additional object identifiers can be defined with the **oid\_file** or
**oid\_section** options in the configuration file. Any additional fields
will be treated as though they were a DirectoryString.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Examine and verify certificate request:

.Vb 1
 openssl req -in req.pem -text -verify -noout
.Ve

Create a private key and then generate a certificate request from it:

.Vb 2
 openssl genrsa -out key.pem 2048
 openssl req -new -key key.pem -out req.pem
.Ve

The same but just using req:

.Vb 1
 openssl req -newkey rsa:2048 -keyout key.pem -out req.pem
.Ve

Generate a self signed root certificate:

.Vb 1
 openssl req -x509 -newkey rsa:2048 -keyout key.pem -out req.pem
.Ve

Example of a file pointed to by the **oid\_file** option:

.Vb 2
 1.2.3.4        shortName       A longer Name
 1.2.3.6        otherName       Other longer Name
.Ve

Example of a section pointed to by **oid\_section** making use of variable
expansion:

.Vb 2
 testoid1=1.2.3.5
 testoid2=${testoid1}.6
.Ve

Sample configuration file prompting for field values:

.Vb 6
 [ req ]
 default_bits           = 2048
 default_keyfile        = privkey.pem
 distinguished_name     = req_distinguished_name
 attributes             = req_attributes
 req_extensions         = v3_ca

 dirstring_type = nobmp

 [ req_distinguished_name ]
 countryName                    = Country Name (2 letter code)
 countryName_default            = AU
 countryName_min                = 2
 countryName_max                = 2

 localityName                   = Locality Name (eg, city)

 organizationalUnitName         = Organizational Unit Name (eg, section)

 commonName                     = Common Name (eg, YOUR name)
 commonName_max                 = 64

 emailAddress                   = Email Address
 emailAddress_max               = 40

 [ req_attributes ]
 challengePassword              = A challenge password
 challengePassword_min          = 4
 challengePassword_max          = 20

 [ v3_ca ]

 subjectKeyIdentifier=hash
 authorityKeyIdentifier=keyid:always,issuer:always
 basicConstraints = critical, CA:true
.Ve

Sample configuration containing all field values:

.Vb 1
 RANDFILE               = $ENV::HOME/.rnd

 [ req ]
 default_bits           = 2048
 default_keyfile        = keyfile.pem
 distinguished_name     = req_distinguished_name
 attributes             = req_attributes
 prompt                 = no
 output_password        = mypass

 [ req_distinguished_name ]
 C                      = GB
 ST                     = Test State or Province
 L                      = Test Locality
 O                      = Organization Name
 OU                     = Organizational Unit Name
 CN                     = Common Name
 emailAddress           = test@email.address

 [ req_attributes ]
 challengePassword              = A challenge password
.Ve

Example of giving the most common attributes (subject and extensions)
on the command line:

.Vb 4
 openssl req -new -subj "/C=GB/CN=foo" \e
                  -addext "subjectAltName = DNS:foo.co.uk" \e
                  -addext "certificatePolicies = 1.2.3.4" \e
                  -newkey rsa:2048 -keyout key.pem -out req.pem
.Ve

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The header and footer lines in the **\s-1PEM\s0** format are normally:

.Vb 2
 -----BEGIN CERTIFICATE REQUEST-----
 -----END CERTIFICATE REQUEST-----
.Ve

some software (some versions of Netscape certificate server) instead needs:

.Vb 2
 -----BEGIN NEW CERTIFICATE REQUEST-----
 -----END NEW CERTIFICATE REQUEST-----
.Ve

which is produced with the **-newhdr** option but is otherwise compatible.
Either form is accepted transparently on input.

The certificate requests generated by **Xenroll** with \s-1MSIE\s0 have extensions
added. It includes the **keyUsage** extension which determines the type of
key (signature only or general purpose) and any additional OIDs entered
by the script in an extendedKeyUsage extension.

<a name="diagnostics"></a>

# Diagnostics

.IX Header "DIAGNOSTICS"
The following messages are frequently asked about:

.Vb 2
        Using configuration from /some/path/openssl.cnf
        Unable to load config info
.Ve

This is followed some time later by...

.Vb 2
        unable to find distinguished_name\*(Aq in config
        problems making Certificate Request
.Ve

The first error message is the clue: it can't find the configuration
file! Certain operations (like examining a certificate request) don't
need a configuration file so its use isn't enforced. Generation of
certificates or requests however does need a configuration file. This
could be regarded as a bug.

Another puzzling message is this:

.Vb 2
        Attributes:
            a0:00
.Ve

this is displayed when no attributes are present and the request includes
the correct empty **\s-1SET OF\s0** structure (the \s-1DER\s0 encoding of which is 0xa0
0x00). If you just see:

.Vb 1
        Attributes:
.Ve

then the **\s-1SET OF\s0** is missing and the encoding is technically invalid (but
it is tolerated). See the description of the command line option **-asn1-kludge**
for more information.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
OpenSSL's handling of T61Strings (aka TeletexStrings) is broken: it effectively
treats them as \s-1ISO-8859-1\s0 (Latin 1), Netscape and \s-1MSIE\s0 have similar behaviour.
This can cause problems if you need characters that aren't available in
PrintableStrings and you don't want to or can't use BMPStrings.

As a consequence of the T61String handling the only correct way to represent
accented characters in OpenSSL is to use a BMPString: unfortunately Netscape
currently chokes on these. If you have to use accented characters with Netscape
and \s-1MSIE\s0 then you currently need to use the invalid T61String form.

The current prompting is not very friendly. It doesn't allow you to confirm what
you've just entered. Other things like extensions in certificate requests are
statically defined in the configuration file. Some of these: like an email
address in subjectAltName should be input by the user.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**x509**\|(1), **ca**\|(1), **genrsa**\|(1),
**gendsa**\|(1), **config**\|(5),
**x509v3\_config**\|(5)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
