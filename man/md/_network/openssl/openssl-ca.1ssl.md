# ca(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-ca, ca - sample minimal CA application

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl ca [-help] [-verbose] [-config filename] [-name section] [-gencrl] [-revoke file] [-valid file] [-status serial] [-updatedb] [-crl_reason reason] [-crl_hold instruction] [-crl_compromise time] [-crl_CA_compromise time] [-crldays days] [-crlhours hours] [-crlexts section] [-startdate date] [-enddate date] [-days arg] [-md arg] [-policy arg] [-keyfile arg] [-keyform PEM|DER] [-key arg] [-passin arg] [-cert file] [-selfsign] [-in file] [-out file] [-notext] [-outdir dir] [-infiles] [-spkac file] [-ss_cert file] [-preserveDN] [-noemailDN] [-batch] [-msie_hack] [-extensions section] [-extfile section] [-engine id] [-subj arg] [-utf8] [-sigopt nm:v] [-create_serial] [-rand_serial] [-multivalue-rdn] [-rand file...] [-writerand file]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **ca** command is a minimal \s-1CA\s0 application. It can be used
to sign certificate requests in a variety of forms and generate
CRLs it also maintains a text database of issued certificates
and their status.

The options descriptions will be divided into each purpose.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-verbose**  
  .IX Item "-verbose"
  This prints extra details about the operations being performed.
* **-config filename**  
  .IX Item "-config filename"
  Specifies the configuration file to use.
  Optional; for a description of the default value,
  see \s-1COMMAND SUMMARY\*(R"\s0 in **openssl**\|(1).
* **-name section**  
  .IX Item "-name section"
  Specifies the configuration file section to use (overrides
  **default\_ca** in the **ca** section).
* **-in filename**  
  .IX Item "-in filename"
  An input filename containing a single certificate request to be
  signed by the \s-1CA.\s0
* **-ss_cert filename**  
  .IX Item "-ss_cert filename"
  A single self-signed certificate to be signed by the \s-1CA.\s0
* **-spkac filename**  
  .IX Item "-spkac filename"
  A file containing a single Netscape signed public key and challenge
  and additional field values to be signed by the \s-1CA.\s0 See the **\s-1SPKAC FORMAT\s0**
  section for information on the required input and output format.
* **-infiles**  
  .IX Item "-infiles"
  If present this should be the last option, all subsequent arguments
  are taken as the names of files containing certificate requests.
* **-out filename**  
  .IX Item "-out filename"
  The output file to output certificates to. The default is standard
  output. The certificate details will also be printed out to this
  file in \s-1PEM\s0 format (except that **-spkac** outputs \s-1DER\s0 format).
* **-outdir directory**  
  .IX Item "-outdir directory"
  The directory to output certificates to. The certificate will be
  written to a filename consisting of the serial number in hex with
  .pem\*(R" appended.
* **-cert**  
  .IX Item "-cert"
  The \s-1CA\s0 certificate file.
* **-keyfile filename**  
  .IX Item "-keyfile filename"
  The private key to sign requests with.
* **-keyform PEM|DER**  
  .IX Item "-keyform PEM|DER"
  The format of the data in the private key file.
  The default is \s-1PEM.\s0
* **-sigopt nm:v**  
  .IX Item "-sigopt nm:v"
  Pass options to the signature algorithm during sign or verify operations.
  Names and values of these options are algorithm-specific.
* **-key password**  
  .IX Item "-key password"
  The password used to encrypt the private key. Since on some
  systems the command line arguments are visible (e.g. Unix with
  the 'ps' utility) this option should be used with caution.
* **-selfsign**  
  .IX Item "-selfsign"
  Indicates the issued certificates are to be signed with the key
  the certificate requests were signed with (given with **-keyfile**).
  Certificate requests signed with a different key are ignored.  If
  **-spkac**, **-ss\_cert** or **-gencrl** are given, **-selfsign** is
  ignored.
  .Sp
  A consequence of using **-selfsign** is that the self-signed
  certificate appears among the entries in the certificate database
  (see the configuration option **database**), and uses the same
  serial number counter as all other certificates sign with the
  self-signed certificate.
* **-passin arg**  
  .IX Item "-passin arg"
  The key password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
* **-notext**  
  .IX Item "-notext"
  Don't output the text form of a certificate to the output file.
* **-startdate date**  
  .IX Item "-startdate date"
  This allows the start date to be explicitly set. The format of the
  date is \s-1YYMMDDHHMMSSZ\s0 (the same as an \s-1ASN1\s0 UTCTime structure), or
  \s-1YYYYMMDDHHMMSSZ\s0 (the same as an \s-1ASN1\s0 GeneralizedTime structure). In
  both formats, seconds \s-1SS\s0 and timezone Z must be present.
* **-enddate date**  
  .IX Item "-enddate date"
  This allows the expiry date to be explicitly set. The format of the
  date is \s-1YYMMDDHHMMSSZ\s0 (the same as an \s-1ASN1\s0 UTCTime structure), or
  \s-1YYYYMMDDHHMMSSZ\s0 (the same as an \s-1ASN1\s0 GeneralizedTime structure). In
  both formats, seconds \s-1SS\s0 and timezone Z must be present.
* **-days arg**  
  .IX Item "-days arg"
  The number of days to certify the certificate for.
* **-md alg**  
  .IX Item "-md alg"
  The message digest to use.
  Any digest supported by the OpenSSL **dgst** command can be used. For signing
  algorithms that do not support a digest (i.e. Ed25519 and Ed448) any message
  digest that is set is ignored. This option also applies to CRLs.
* **-policy arg**  
  .IX Item "-policy arg"
  This option defines the \s-1CA\s0 policy\*(R" to use. This is a section in
  the configuration file which decides which fields should be mandatory
  or match the \s-1CA\s0 certificate. Check out the **\s-1POLICY FORMAT\s0** section
  for more information.
* **-msie\_hack**  
  .IX Item "-msie_hack"
  This is a deprecated option to make **ca** work with very old versions of
  the \s-1IE\s0 certificate enrollment control certenr3\*(R". It used UniversalStrings
  for almost everything. Since the old control has various security bugs
  its use is strongly discouraged.
* **-preserveDN**  
  .IX Item "-preserveDN"
  Normally the \s-1DN\s0 order of a certificate is the same as the order of the
  fields in the relevant policy section. When this option is set the order
  is the same as the request. This is largely for compatibility with the
  older \s-1IE\s0 enrollment control which would only accept certificates if their
  DNs match the order of the request. This is not needed for Xenroll.
* **-noemailDN**  
  .IX Item "-noemailDN"
  The \s-1DN\s0 of a certificate can contain the \s-1EMAIL\s0 field if present in the
  request \s-1DN,\s0 however, it is good policy just having the e-mail set into
  the altName extension of the certificate. When this option is set the
  \s-1EMAIL\s0 field is removed from the certificate' subject and set only in
  the, eventually present, extensions. The **email\_in\_dn** keyword can be
  used in the configuration file to enable this behaviour.
* **-batch**  
  .IX Item "-batch"
  This sets the batch mode. In this mode no questions will be asked
  and all certificates will be certified automatically.
* **-extensions section**  
  .IX Item "-extensions section"
  The section of the configuration file containing certificate extensions
  to be added when a certificate is issued (defaults to **x509\_extensions**
  unless the **-extfile** option is used). If no extension section is
  present then, a V1 certificate is created. If the extension section
  is present (even if it is empty), then a V3 certificate is created. See the
  **x509v3\_config**\|(5) manual page for details of the
  extension section format.
* **-extfile file**  
  .IX Item "-extfile file"
  An additional configuration file to read certificate extensions from
  (using the default section unless the **-extensions** option is also
  used).
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine (by its unique **id** string) will cause **ca**
  to attempt to obtain a functional reference to the specified engine,
  thus initialising it if needed. The engine will then be set as the default
  for all available algorithms.
* **-subj arg**  
  .IX Item "-subj arg"
  Supersedes subject name given in the request.
  The arg must be formatted as _/type0=value0/type1=value1/type2=..._.
  Keyword characters may be escaped by \e (backslash), and whitespace is retained.
  Empty values are permitted, but the corresponding type will not be included
  in the resulting certificate.
* **-utf8**  
  .IX Item "-utf8"
  This option causes field values to be interpreted as \s-1UTF8\s0 strings, by
  default they are interpreted as \s-1ASCII.\s0 This means that the field
  values, whether prompted from a terminal or obtained from a
  configuration file, must be valid \s-1UTF8\s0 strings.
* **-create\_serial**  
  .IX Item "-create_serial"
  If reading serial from the text file as specified in the configuration
  fails, specifying this option creates a new random serial to be used as next
  serial number.
  To get random serial numbers, use the **-rand\_serial** flag instead; this
  should only be used for simple error-recovery.
* **-rand\_serial**  
  .IX Item "-rand_serial"
  Generate a large random number to use as the serial number.
  This overrides any option or configuration to use a serial number file.
* **-multivalue-rdn**  
  .IX Item "-multivalue-rdn"
  This option causes the -subj argument to be interpreted with full
  support for multivalued RDNs. Example:
  .Sp
  _/DC=org/DC=OpenSSL/DC=users/UID=123456+CN=John Doe_
  .Sp
  If -multi-rdn is not used then the \s-1UID\s0 value is _123456+CN=John Doe_.
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

<a name="crl-options"></a>

# Crl Options

.IX Header "CRL OPTIONS"

* **-gencrl**  
  .IX Item "-gencrl"
  This option generates a \s-1CRL\s0 based on information in the index file.
* **-crldays num**  
  .IX Item "-crldays num"
  The number of days before the next \s-1CRL\s0 is due. That is the days from
  now to place in the \s-1CRL\s0 nextUpdate field.
* **-crlhours num**  
  .IX Item "-crlhours num"
  The number of hours before the next \s-1CRL\s0 is due.
* **-revoke filename**  
  .IX Item "-revoke filename"
  A filename containing a certificate to revoke.
* **-valid filename**  
  .IX Item "-valid filename"
  A filename containing a certificate to add a Valid certificate entry.
* **-status serial**  
  .IX Item "-status serial"
  Displays the revocation status of the certificate with the specified
  serial number and exits.
* **-updatedb**  
  .IX Item "-updatedb"
  Updates the database index to purge expired certificates.
* **-crl_reason reason**  
  .IX Item "-crl_reason reason"
  Revocation reason, where **reason** is one of: **unspecified**, **keyCompromise**,
  **CACompromise**, **affiliationChanged**, **superseded**, **cessationOfOperation**,
  **certificateHold** or **removeFromCRL**. The matching of **reason** is case
  insensitive. Setting any revocation reason will make the \s-1CRL\s0 v2.
  .Sp
  In practice **removeFromCRL** is not particularly useful because it is only used
  in delta CRLs which are not currently implemented.
* **-crl_hold instruction**  
  .IX Item "-crl_hold instruction"
  This sets the \s-1CRL\s0 revocation reason code to **certificateHold** and the hold
  instruction to **instruction** which must be an \s-1OID.\s0 Although any \s-1OID\s0 can be
  used only **holdInstructionNone** (the use of which is discouraged by \s-1RFC2459\s0)
  **holdInstructionCallIssuer** or **holdInstructionReject** will normally be used.
* **-crl_compromise time**  
  .IX Item "-crl_compromise time"
  This sets the revocation reason to **keyCompromise** and the compromise time to
  **time**. **time** should be in GeneralizedTime format that is **\s-1YYYYMMDDHHMMSSZ\s0**.
* **-crl_CA_compromise time**  
  .IX Item "-crl_CA_compromise time"
  This is the same as **crl\_compromise** except the revocation reason is set to
  **CACompromise**.
* **-crlexts section**  
  .IX Item "-crlexts section"
  The section of the configuration file containing \s-1CRL\s0 extensions to
  include. If no \s-1CRL\s0 extension section is present then a V1 \s-1CRL\s0 is
  created, if the \s-1CRL\s0 extension section is present (even if it is
  empty) then a V2 \s-1CRL\s0 is created. The \s-1CRL\s0 extensions specified are
  \s-1CRL\s0 extensions and **not** \s-1CRL\s0 entry extensions.  It should be noted
  that some software (for example Netscape) can't handle V2 CRLs. See
  **x509v3\_config**\|(5) manual page for details of the
  extension section format.

<a name="configuration-file-options"></a>

# Configuration File Options

.IX Header "CONFIGURATION FILE OPTIONS"
The section of the configuration file containing options for **ca**
is found as follows: If the **-name** command line option is used,
then it names the section to be used. Otherwise the section to
be used must be named in the **default\_ca** option of the **ca** section
of the configuration file (or in the default section of the
configuration file). Besides **default\_ca**, the following options are
read directly from the **ca** section:
 \s-1RANDFILE\s0
 preserve
 msie_hack
With the exception of **\s-1RANDFILE\s0**, this is probably a bug and may
change in future releases.

Many of the configuration file options are identical to command line
options. Where the option is present in the configuration file
and the command line the command line value is used. Where an
option is described as mandatory then it must be present in
the configuration file or the command line equivalent (if
any) used.

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
* **new\_certs\_dir**  
  .IX Item "new_certs_dir"
  The same as the **-outdir** command line option. It specifies
  the directory where new certificates will be placed. Mandatory.
* **certificate**  
  .IX Item "certificate"
  The same as **-cert**. It gives the file containing the \s-1CA\s0
  certificate. Mandatory.
* **private\_key**  
  .IX Item "private_key"
  Same as the **-keyfile** option. The file containing the
  \s-1CA\s0 private key. Mandatory.
* **\s-1RANDFILE\s0**  
  .IX Item "RANDFILE"
  At startup the specified file is loaded into the random number generator,
  and at exit 256 bytes will be written to it.
* **default\_days**  
  .IX Item "default_days"
  The same as the **-days** option. The number of days to certify
  a certificate for.
* **default\_startdate**  
  .IX Item "default_startdate"
  The same as the **-startdate** option. The start date to certify
  a certificate for. If not set the current time is used.
* **default\_enddate**  
  .IX Item "default_enddate"
  The same as the **-enddate** option. Either this option or
  **default\_days** (or the command line equivalents) must be
  present.
* **default_crl_hours default\_crl\_days**  
  .IX Item "default_crl_hours default_crl_days"
  The same as the **-crlhours** and the **-crldays** options. These
  will only be used if neither command line option is present. At
  least one of these must be present to generate a \s-1CRL.\s0
* **default\_md**  
  .IX Item "default_md"
  The same as the **-md** option. Mandatory except where the signing algorithm does
  not require a digest (i.e. Ed25519 and Ed448).
* **database**  
  .IX Item "database"
  The text database file to use. Mandatory. This file must be present
  though initially it will be empty.
* **unique\_subject**  
  .IX Item "unique_subject"
  If the value **yes** is given, the valid certificate entries in the
  database must have unique subjects.  if the value **no** is given,
  several valid certificate entries may have the exact same subject.
  The default value is **yes**, to be compatible with older (pre 0.9.8)
  versions of OpenSSL.  However, to make \s-1CA\s0 certificate roll-over easier,
  it's recommended to use the value **no**, especially if combined with
  the **-selfsign** command line option.
  .Sp
  Note that it is valid in some circumstances for certificates to be created
  without any subject. In the case where there are multiple certificates without
  subjects this does not count as a duplicate.
* **serial**  
  .IX Item "serial"
  A text file containing the next serial number to use in hex. Mandatory.
  This file must be present and contain a valid serial number.
* **crlnumber**  
  .IX Item "crlnumber"
  A text file containing the next \s-1CRL\s0 number to use in hex. The crl number
  will be inserted in the CRLs only if this file exists. If this file is
  present, it must contain a valid \s-1CRL\s0 number.
* **x509\_extensions**  
  .IX Item "x509_extensions"
  The same as **-extensions**.
* **crl\_extensions**  
  .IX Item "crl_extensions"
  The same as **-crlexts**.
* **preserve**  
  .IX Item "preserve"
  The same as **-preserveDN**
* **email\_in\_dn**  
  .IX Item "email_in_dn"
  The same as **-noemailDN**. If you want the \s-1EMAIL\s0 field to be removed
  from the \s-1DN\s0 of the certificate simply set this to 'no'. If not present
  the default is to allow for the \s-1EMAIL\s0 filed in the certificate's \s-1DN.\s0
* **msie\_hack**  
  .IX Item "msie_hack"
  The same as **-msie\_hack**
* **policy**  
  .IX Item "policy"
  The same as **-policy**. Mandatory. See the **\s-1POLICY FORMAT\s0** section
  for more information.
* **name\_opt**, **cert\_opt**  
  .IX Item "name_opt, cert_opt"
  These options allow the format used to display the certificate details
  when asking the user to confirm signing. All the options supported by
  the **x509** utilities **-nameopt** and **-certopt** switches can be used
  here, except the **no\_signame** and **no\_sigdump** are permanently set
  and cannot be disabled (this is because the certificate signature cannot
  be displayed because the certificate has not been signed at this point).
  .Sp
  For convenience the values **ca\_default** are accepted by both to produce
  a reasonable output.
  .Sp
  If neither option is present the format used in earlier versions of
  OpenSSL is used. Use of the old format is **strongly** discouraged because
  it only displays fields mentioned in the **policy** section, mishandles
  multicharacter string types and does not display extensions.
* **copy\_extensions**  
  .IX Item "copy_extensions"
  Determines how extensions in certificate requests should be handled.
  If set to **none** or this option is not present then extensions are
  ignored and not copied to the certificate. If set to **copy** then any
  extensions present in the request that are not already present are copied
  to the certificate. If set to **copyall** then all extensions in the
  request are copied to the certificate: if the extension is already present
  in the certificate it is deleted first. See the **\s-1WARNINGS\s0** section before
  using this option.
  .Sp
  The main use of this option is to allow a certificate request to supply
  values for certain extensions such as subjectAltName.

<a name="policy-format"></a>

# Policy Format

.IX Header "POLICY FORMAT"
The policy section consists of a set of variables corresponding to
certificate \s-1DN\s0 fields. If the value is match\*(R" then the field value
must match the same field in the \s-1CA\s0 certificate. If the value is
supplied\*(R" then it must be present. If the value is \*(L"optional\*(R" then
it may be present. Any fields not mentioned in the policy section
are silently deleted, unless the **-preserveDN** option is set but
this can be regarded more of a quirk than intended behaviour.

<a name="spkac-format"></a>

# Spkac Format

.IX Header "SPKAC FORMAT"
The input to the **-spkac** command line option is a Netscape
signed public key and challenge. This will usually come from
the **\s-1KEYGEN\s0** tag in an \s-1HTML\s0 form to create a new private key.
It is however possible to create SPKACs using the **spkac** utility.

The file should contain the variable \s-1SPKAC\s0 set to the value of
the \s-1SPKAC\s0 and also the required \s-1DN\s0 components as name value pairs.
If you need to include the same component twice then it can be
preceded by a number and a '.'.

When processing \s-1SPKAC\s0 format, the output is \s-1DER\s0 if the **-out**
flag is used, but \s-1PEM\s0 format if sending to stdout or the **-outdir**
flag is used.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Note: these examples assume that the **ca** directory structure is
already set up and the relevant files already exist. This usually
involves creating a \s-1CA\s0 certificate and private key with **req**, a
serial number file and an empty index file and placing them in
the relevant directories.

To use the sample configuration file below the directories demoCA,
demoCA/private and demoCA/newcerts would be created. The \s-1CA\s0
certificate would be copied to demoCA/cacert.pem and its private
key to demoCA/private/cakey.pem. A file demoCA/serial would be
created containing for example 01\*(R" and the empty index file
demoCA/index.txt.

Sign a certificate request:

.Vb 1
 openssl ca -in req.pem -out newcert.pem
.Ve

Sign a certificate request, using \s-1CA\s0 extensions:

.Vb 1
 openssl ca -in req.pem -extensions v3_ca -out newcert.pem
.Ve

Generate a \s-1CRL\s0

.Vb 1
 openssl ca -gencrl -out crl.pem
.Ve

Sign several requests:

.Vb 1
 openssl ca -infiles req1.pem req2.pem req3.pem
.Ve

Certify a Netscape \s-1SPKAC:\s0

.Vb 1
 openssl ca -spkac spkac.txt
.Ve

A sample \s-1SPKAC\s0 file (the \s-1SPKAC\s0 line has been truncated for clarity):

.Vb 5
 SPKAC=MIG0MGAwXDANBgkqhkiG9w0BAQEFAANLADBIAkEAn7PDhCeV/xIxUg8V70YRxK2A5
 CN=Steve Test
 emailAddress=steve@openssl.org
 0.OU=OpenSSL Group
 1.OU=Another Group
.Ve

A sample configuration file with the relevant sections for **ca**:

.Vb 2
 [ ca ]
 default_ca      = CA_default            # The default ca section

 [ CA_default ]

 dir            = ./demoCA              # top dir
 database       = $dir/index.txt        # index file.
 new_certs_dir  = $dir/newcerts         # new certs dir

 certificate    = $dir/cacert.pem       # The CA cert
 serial         = $dir/serial           # serial no file
 #rand_serial    = yes                  # for random serial#s
 private_key    = $dir/private/cakey.pem# CA private key
 RANDFILE       = $dir/private/.rand    # random number file

 default_days   = 365                   # how long to certify for
 default_crl_days= 30                   # how long before next CRL
 default_md     = md5                   # md to use

 policy         = policy_any            # default policy
 email_in_dn    = no                    # Dont add the email into cert DN

 name_opt       = ca_default            # Subject name display option
 cert_opt       = ca_default            # Certificate display option
 copy_extensions = none                 # Dont copy extensions from request

 [ policy_any ]
 countryName            = supplied
 stateOrProvinceName    = optional
 organizationName       = optional
 organizationalUnitName = optional
 commonName             = supplied
 emailAddress           = optional
.Ve

<a name="files"></a>

# Files

.IX Header "FILES"
Note: the location of all files can change either by compile time options,
configuration file entries, environment variables or command line options.
The values below reflect the default values.

.Vb 10
 /usr/local/ssl/lib/openssl.cnf - master configuration file
 ./demoCA                       - main CA directory
 ./demoCA/cacert.pem            - CA certificate
 ./demoCA/private/cakey.pem     - CA private key
 ./demoCA/serial                - CA serial number file
 ./demoCA/serial.old            - CA serial number backup file
 ./demoCA/index.txt             - CA text database file
 ./demoCA/index.txt.old         - CA text database backup file
 ./demoCA/certs                 - certificate output file
 ./demoCA/.rnd                  - CA random seed information
.Ve

<a name="restrictions"></a>

# Restrictions

.IX Header "RESTRICTIONS"
The text database index file is a critical part of the process and
if corrupted it can be difficult to fix. It is theoretically possible
to rebuild the index file from all the issued certificates and a current
\s-1CRL:\s0 however there is no option to do this.

V2 \s-1CRL\s0 features like delta CRLs are not currently supported.

Although several requests can be input and handled at once it is only
possible to include one \s-1SPKAC\s0 or self-signed certificate.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
The use of an in-memory text database can cause problems when large
numbers of certificates are present because, as the name implies
the database has to be kept in memory.

The **ca** command really needs rewriting or the required functionality
exposed at either a command or interface level so a more friendly utility
(perl script or \s-1GUI\s0) can handle things properly. The script
**\s-1CA\s0.pl** helps a little but not very much.

Any fields in a request that are not present in a policy are silently
deleted. This does not happen if the **-preserveDN** option is used. To
enforce the absence of the \s-1EMAIL\s0 field within the \s-1DN,\s0 as suggested by
RFCs, regardless the contents of the request' subject the **-noemailDN**
option can be used. The behaviour should be more friendly and
configurable.

Canceling some commands by refusing to certify a certificate can
create an empty file.

<a name="warnings"></a>

# Warnings

.IX Header "WARNINGS"
The **ca** command is quirky and at times downright unfriendly.

The **ca** utility was originally meant as an example of how to do things
in a \s-1CA.\s0 It was not supposed to be used as a full blown \s-1CA\s0 itself:
nevertheless some people are using it for this purpose.

The **ca** command is effectively a single user command: no locking is
done on the various files and attempts to run more than one **ca** command
on the same database can have unpredictable results.

The **copy\_extensions** option should be used with caution. If care is
not taken then it can be a security risk. For example if a certificate
request contains a basicConstraints extension with \s-1CA:TRUE\s0 and the
**copy\_extensions** value is set to **copyall** and the user does not spot
this when the certificate is displayed then this will hand the requester
a valid \s-1CA\s0 certificate.

This situation can be avoided by setting **copy\_extensions** to **copy**
and including basicConstraints with \s-1CA:FALSE\s0 in the configuration file.
Then if the request contains a basicConstraints extension it will be
ignored.

It is advisable to also include values for other extensions such
as **keyUsage** to prevent a request supplying its own values.

Additional restrictions can be placed on the \s-1CA\s0 certificate itself.
For example if the \s-1CA\s0 certificate has:

.Vb 1
 basicConstraints = CA:TRUE, pathlen:0
.Ve

then even if a certificate is issued with \s-1CA:TRUE\s0 it will not be valid.

<a name="history"></a>

# History

.IX Header "HISTORY"
Since OpenSSL 1.1.1, the program follows \s-1RFC5280.\s0 Specifically,
certificate validity period (specified by any of **-startdate**,
**-enddate** and **-days**) will be encoded as UTCTime if the dates are
earlier than year 2049 (included), and as GeneralizedTime if the dates
are in year 2050 or later.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**req**\|(1), **spkac**\|(1), **x509**\|(1), \s-1**CA\s0.pl**\|(1),
**config**\|(5), **x509v3\_config**\|(5)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
