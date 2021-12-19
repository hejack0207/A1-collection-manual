# x509v3_config(5)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

x509v3_config - X509 V3 certificate extension configuration format

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
Several of the OpenSSL utilities can add extensions to a certificate or
certificate request based on the contents of a configuration file.

Typically the application will contain an option to point to an extension
section. Each line of the extension section takes the form:

.Vb 1
 extension_name=[critical,] extension_options
.Ve

If **critical** is present then the extension will be critical.

The format of **extension\_options** depends on the value of **extension\_name**.

There are four main types of extension: _string_ extensions, _multi-valued_
extensions, _raw_ and _arbitrary_ extensions.

String extensions simply have a string which contains either the value itself
or how it is obtained.

For example:

.Vb 1
 nsComment="This is a Comment"
.Ve

Multi-valued extensions have a short form and a long form. The short form
is a list of names and values:

.Vb 1
 basicConstraints=critical,CA:true,pathlen:1
.Ve

The long form allows the values to be placed in a separate section:

.Vb 1
 basicConstraints=critical,@bs_section

 [bs_section]

 CA=true
 pathlen=1
.Ve

Both forms are equivalent.

The syntax of raw extensions is governed by the extension code: it can
for example contain data in multiple sections. The correct syntax to
use is defined by the extension code itself: check out the certificate
policies extension for an example.

If an extension type is unsupported then the _arbitrary_ extension syntax
must be used, see the \s-1ARBITRARY EXTENSIONS\s0 section for more details.

<a name="standard-extensions"></a>

# Standard Extensions

.IX Header "STANDARD EXTENSIONS"
The following sections describe each supported extension in detail.

<a name="basic-constraints"></a>

### Basic Constraints.

.IX Subsection "Basic Constraints."
This is a multi valued extension which indicates whether a certificate is
a \s-1CA\s0 certificate. The first (mandatory) name is **\s-1CA\s0** followed by **\s-1TRUE\s0** or
**\s-1FALSE\s0**. If **\s-1CA\s0** is **\s-1TRUE\s0** then an optional **pathlen** name followed by a
nonnegative value can be included.

For example:

.Vb 1
 basicConstraints=CA:TRUE

 basicConstraints=CA:FALSE

 basicConstraints=critical,CA:TRUE, pathlen:0
.Ve

A \s-1CA\s0 certificate **must** include the basicConstraints value with the \s-1CA\s0 field
set to \s-1TRUE.\s0 An end user certificate must either set \s-1CA\s0 to \s-1FALSE\s0 or exclude the
extension entirely. Some software may require the inclusion of basicConstraints
with \s-1CA\s0 set to \s-1FALSE\s0 for end entity certificates.

The pathlen parameter indicates the maximum number of CAs that can appear
below this one in a chain. So if you have a \s-1CA\s0 with a pathlen of zero it can
only be used to sign end user certificates and not further CAs.

<a name="key-usage"></a>

### Key Usage.

.IX Subsection "Key Usage."
Key usage is a multi valued extension consisting of a list of names of the
permitted key usages.

The supported names are: digitalSignature, nonRepudiation, keyEncipherment,
dataEncipherment, keyAgreement, keyCertSign, cRLSign, encipherOnly
and decipherOnly.

Examples:

.Vb 1
 keyUsage=digitalSignature, nonRepudiation

 keyUsage=critical, keyCertSign
.Ve

<a name="extended-key-usage"></a>

### Extended Key Usage.

.IX Subsection "Extended Key Usage."
This extensions consists of a list of usages indicating purposes for which
the certificate public key can be used for,

These can either be object short names or the dotted numerical form of OIDs.
While any \s-1OID\s0 can be used only certain values make sense. In particular the
following \s-1PKIX, NS\s0 and \s-1MS\s0 values are meaningful:

.Vb 10
 Value                  Meaning
 -----                  -------
 serverAuth             SSL/TLS Web Server Authentication.
 clientAuth             SSL/TLS Web Client Authentication.
 codeSigning            Code signing.
 emailProtection        E-mail Protection (S/MIME).
 timeStamping           Trusted Timestamping
 OCSPSigning            OCSP Signing
 ipsecIKE               ipsec Internet Key Exchange
 msCodeInd              Microsoft Individual Code Signing (authenticode)
 msCodeCom              Microsoft Commercial Code Signing (authenticode)
 msCTLSign              Microsoft Trust List Signing
 msEFS                  Microsoft Encrypted File System
.Ve

Examples:

.Vb 2
 extendedKeyUsage=critical,codeSigning,1.2.3.4
 extendedKeyUsage=serverAuth,clientAuth
.Ve

<a name="subject-key-identifier"></a>

### Subject Key Identifier.

.IX Subsection "Subject Key Identifier."
This is really a string extension and can take two possible values. Either
the word **hash** which will automatically follow the guidelines in \s-1RFC3280\s0
or a hex string giving the extension value to include. The use of the hex
string is strongly discouraged.

Example:

.Vb 1
 subjectKeyIdentifier=hash
.Ve

<a name="authority-key-identifier"></a>

### Authority Key Identifier.

.IX Subsection "Authority Key Identifier."
The authority key identifier extension permits two options. keyid and issuer:
both can take the optional value always\*(R".

If the keyid option is present an attempt is made to copy the subject key
identifier from the parent certificate. If the value always\*(R" is present
then an error is returned if the option fails.

The issuer option copies the issuer and serial number from the issuer
certificate. This will only be done if the keyid option fails or
is not included unless the always\*(R" flag will always include the value.

Example:

.Vb 1
 authorityKeyIdentifier=keyid,issuer
.Ve

<a name="subject-alternative-name"></a>

### Subject Alternative Name.

.IX Subsection "Subject Alternative Name."
The subject alternative name extension allows various literal values to be
included in the configuration file. These include **email** (an email address)
**\s-1URI\s0** a uniform resource indicator, **\s-1DNS\s0** (a \s-1DNS\s0 domain name), **\s-1RID\s0** (a
registered \s-1ID: OBJECT IDENTIFIER\s0), **\s-1IP\s0** (an \s-1IP\s0 address), **dirName**
(a distinguished name) and otherName.

The email option include a special 'copy' value. This will automatically
include any email addresses contained in the certificate subject name in
the extension.

The \s-1IP\s0 address used in the **\s-1IP\s0** options can be in either IPv4 or IPv6 format.

The value of **dirName** should point to a section containing the distinguished
name to use as a set of name value pairs. Multi values AVAs can be formed by
prefacing the name with a **+** character.

otherName can include arbitrary data associated with an \s-1OID:\s0 the value
should be the \s-1OID\s0 followed by a semicolon and the content in standard
**ASN1\_generate\_nconf**\|(3) format.

Examples:

.Vb 5
 subjectAltName=email:copy,email:my@other.address,URI:http://my.url.here/
 subjectAltName=IP:192.168.7.1
 subjectAltName=IP:13::17
 subjectAltName=email:my@other.address,RID:1.2.3.4
 subjectAltName=otherName:1.2.3.4;UTF8:some other identifier

 subjectAltName=dirName:dir_sect

 [dir_sect]
 C=UK
 O=My Organization
 OU=My Unit
 CN=My Name
.Ve

<a name="issuer-alternative-name"></a>

### Issuer Alternative Name.

.IX Subsection "Issuer Alternative Name."
The issuer alternative name option supports all the literal options of
subject alternative name. It does **not** support the email:copy option because
that would not make sense. It does support an additional issuer:copy option
that will copy all the subject alternative name values from the issuer
certificate (if possible).

Example:

.Vb 1
 issuerAltName = issuer:copy
.Ve

<a name="authority-info-access"></a>

### Authority Info Access.

.IX Subsection "Authority Info Access."
The authority information access extension gives details about how to access
certain information relating to the \s-1CA.\s0 Its syntax is accessOID;location
where _location_ has the same syntax as subject alternative name (except
that email:copy is not supported). accessOID can be any valid \s-1OID\s0 but only
certain values are meaningful, for example \s-1OCSP\s0 and caIssuers.

Example:

.Vb 2
 authorityInfoAccess = OCSP;URI:http://ocsp.my.host/
 authorityInfoAccess = caIssuers;URI:http://my.ca/ca.html
.Ve

<a name="s-1crls0-distribution-points"></a>

### \s-1CRL\s0 distribution points

.IX Subsection "CRL distribution points"
This is a multi-valued extension whose options can be either in name:value pair
using the same form as subject alternative name or a single value representing
a section name containing all the distribution point fields.

For a name:value pair a new DistributionPoint with the fullName field set to
the given value both the cRLissuer and reasons fields are omitted in this case.

In the single option case the section indicated contains values for each
field. In this section:

If the name is fullname\*(R" the value field should contain the full name
of the distribution point in the same format as subject alternative name.

If the name is relativename\*(R" then the value field should contain a section
name whose contents represent a \s-1DN\s0 fragment to be placed in this field.

The name CRLIssuer\*(R" if present should contain a value for this field in
subject alternative name format.

If the name is reasons\*(R" the value field should consist of a comma
separated field containing the reasons. Valid reasons are: keyCompromise\*(R",
CACompromise\*(R", \*(L"affiliationChanged\*(R", \*(L"superseded\*(R", \*(L"cessationOfOperation\*(R",
certificateHold\*(R", \*(L"privilegeWithdrawn\*(R" and \*(L"AACompromise\*(R".

Simple examples:

.Vb 2
 crlDistributionPoints=URI:http://myhost.com/myca.crl
 crlDistributionPoints=URI:http://my.com/my.crl,URI:http://oth.com/my.crl
.Ve

Full distribution point example:

.Vb 1
 crlDistributionPoints=crldp1_section

 [crldp1_section]

 fullname=URI:http://myhost.com/myca.crl
 CRLissuer=dirName:issuer_sect
 reasons=keyCompromise, CACompromise

 [issuer_sect]
 C=UK
 O=Organisation
 CN=Some Name
.Ve

<a name="issuing-distribution-point"></a>

### Issuing Distribution Point

.IX Subsection "Issuing Distribution Point"
This extension should only appear in CRLs. It is a multi valued extension
whose syntax is similar to the section\*(R" pointed to by the \s-1CRL\s0 distribution
points extension with a few differences.

The names reasons\*(R" and \*(L"CRLissuer\*(R" are not recognized.

The name onlysomereasons\*(R" is accepted which sets this field. The value is
in the same format as the \s-1CRL\s0 distribution point reasons\*(R" field.

The names onlyuser\*(R", \*(L"onlyCA\*(R", \*(L"onlyAA\*(R" and \*(L"indirectCRL\*(R" are also accepted
the values should be a boolean value (\s-1TRUE\s0 or \s-1FALSE\s0) to indicate the value of
the corresponding field.

Example:

.Vb 1
 issuingDistributionPoint=critical, @idp_section

 [idp_section]

 fullname=URI:http://myhost.com/myca.crl
 indirectCRL=TRUE
 onlysomereasons=keyCompromise, CACompromise

 [issuer_sect]
 C=UK
 O=Organisation
 CN=Some Name
.Ve

<a name="certificate-policies"></a>

### Certificate Policies.

.IX Subsection "Certificate Policies."
This is a _raw_ extension. All the fields of this extension can be set by
using the appropriate syntax.

If you follow the \s-1PKIX\s0 recommendations and just using one \s-1OID\s0 then you just
include the value of that \s-1OID.\s0 Multiple OIDs can be set separated by commas,
for example:

.Vb 1
 certificatePolicies= 1.2.4.5, 1.1.3.4
.Ve

If you wish to include qualifiers then the policy \s-1OID\s0 and qualifiers need to
be specified in a separate section: this is done by using the \f(CW@section syntax
instead of a literal \s-1OID\s0 value.

The section referred to must include the policy \s-1OID\s0 using the name
policyIdentifier, cPSuri qualifiers can be included using the syntax:

.Vb 1
 CPS.nnn=value
.Ve

userNotice qualifiers can be set using the syntax:

.Vb 1
 userNotice.nnn=@notice
.Ve

The value of the userNotice qualifier is specified in the relevant section.
This section can include explicitText, organization and noticeNumbers
options. explicitText and organization are text strings, noticeNumbers is a
comma separated list of numbers. The organization and noticeNumbers options
(if included) must \s-1BOTH\s0 be present. If you use the userNotice option with \s-1IE5\s0
then you need the 'ia5org' option at the top level to modify the encoding:
otherwise it will not be interpreted properly.

Example:

.Vb 1
 certificatePolicies=ia5org,1.2.3.4,1.5.6.7.8,@polsect

 [polsect]

 policyIdentifier = 1.3.5.8
 CPS.1="http://my.host.name/"
 CPS.2="http://my.your.name/"
 userNotice.1=@notice

 [notice]

 explicitText="Explicit Text Here"
 organization="Organisation Name"
 noticeNumbers=1,2,3,4
.Ve

The **ia5org** option changes the type of the _organization_ field. In \s-1RFC2459\s0
it can only be of type DisplayText. In \s-1RFC3280\s0 IA5String is also permissible.
Some software (for example some versions of \s-1MSIE\s0) may require ia5org.

\s-1ASN1\s0 type of explicitText can be specified by prepending **\s-1UTF8\s0**,
**\s-1BMP\s0** or **\s-1VISIBLE\s0** prefix followed by colon. For example:

.Vb 2
 [notice]
 explicitText="UTF8:Explicit Text Here"
.Ve

<a name="policy-constraints"></a>

### Policy Constraints

.IX Subsection "Policy Constraints"
This is a multi-valued extension which consisting of the names
**requireExplicitPolicy** or **inhibitPolicyMapping** and a non negative integer
value. At least one component must be present.

Example:

.Vb 1
 policyConstraints = requireExplicitPolicy:3
.Ve

<a name="inhibit-any-policy"></a>

### Inhibit Any Policy

.IX Subsection "Inhibit Any Policy"
This is a string extension whose value must be a non negative integer.

Example:

.Vb 1
 inhibitAnyPolicy = 2
.Ve

<a name="name-constraints"></a>

### Name Constraints

.IX Subsection "Name Constraints"
The name constraints extension is a multi-valued extension. The name should
begin with the word **permitted** or **excluded** followed by a **;**. The rest of
the name and the value follows the syntax of subjectAltName except email:copy
is not supported and the **\s-1IP\s0** form should consist of an \s-1IP\s0 addresses and
subnet mask separated by a **/**.

Examples:

.Vb 1
 nameConstraints=permitted;IP:192.168.0.0/255.255.0.0

 nameConstraints=permitted;email:.somedomain.com

 nameConstraints=excluded;email:.com
.Ve

<a name="s-1ocsps0-no-check"></a>

### \s-1OCSP\s0 No Check

.IX Subsection "OCSP No Check"
The \s-1OCSP\s0 No Check extension is a string extension but its value is ignored.

Example:

.Vb 1
 noCheck = ignored
.Ve

<a name="s-1tlss0-feature-aka-must-staple"></a>

### \s-1TLS\s0 Feature (aka Must Staple)

.IX Subsection "TLS Feature (aka Must Staple)"
This is a multi-valued extension consisting of a list of \s-1TLS\s0 extension
identifiers. Each identifier may be a number (0..65535) or a supported name.
When a \s-1TLS\s0 client sends a listed extension, the \s-1TLS\s0 server is expected to
include that extension in its reply.

The supported names are: **status\_request** and **status\_request\_v2**.

Example:

.Vb 1
 tlsfeature = status_request
.Ve

<a name="deprecated-extensions"></a>

# Deprecated Extensions

.IX Header "DEPRECATED EXTENSIONS"
The following extensions are non standard, Netscape specific and largely
obsolete. Their use in new applications is discouraged.

<a name="netscape-string-extensions"></a>

### Netscape String extensions.

.IX Subsection "Netscape String extensions."
Netscape Comment (**nsComment**) is a string extension containing a comment
which will be displayed when the certificate is viewed in some browsers.

Example:

.Vb 1
 nsComment = "Some Random Comment"
.Ve

Other supported extensions in this category are: **nsBaseUrl**,
**nsRevocationUrl**, **nsCaRevocationUrl**, **nsRenewalUrl**, **nsCaPolicyUrl**
and **nsSslServerName**.

<a name="netscape-certificate-type"></a>

### Netscape Certificate Type

.IX Subsection "Netscape Certificate Type"
This is a multi-valued extensions which consists of a list of flags to be
included. It was used to indicate the purposes for which a certificate could
be used. The basicConstraints, keyUsage and extended key usage extensions are
now used instead.

Acceptable values for nsCertType are: **client**, **server**, **email**,
**objsign**, **reserved**, **sslCA**, **emailCA**, **objCA**.

<a name="arbitrary-extensions"></a>

# Arbitrary Extensions

.IX Header "ARBITRARY EXTENSIONS"
If an extension is not supported by the OpenSSL code then it must be encoded
using the arbitrary extension format. It is also possible to use the arbitrary
format for supported extensions. Extreme care should be taken to ensure that
the data is formatted correctly for the given extension type.

There are two ways to encode arbitrary extensions.

The first way is to use the word \s-1ASN1\s0 followed by the extension content
using the same syntax as **ASN1\_generate\_nconf**\|(3).
For example:

.Vb 1
 1.2.3.4=critical,ASN1:UTF8String:Some random data

 1.2.3.4=ASN1:SEQUENCE:seq_sect

 [seq_sect]

 field1 = UTF8:field1
 field2 = UTF8:field2
.Ve

It is also possible to use the word \s-1DER\s0 to include the raw encoded data in any
extension.

.Vb 2
 1.2.3.4=critical,DER:01:02:03:04
 1.2.3.4=DER:01020304
.Ve

The value following \s-1DER\s0 is a hex dump of the \s-1DER\s0 encoding of the extension
Any extension can be placed in this form to override the default behaviour.
For example:

.Vb 1
 basicConstraints=critical,DER:00:01:02:03
.Ve

<a name="warnings"></a>

# Warnings

.IX Header "WARNINGS"
There is no guarantee that a specific implementation will process a given
extension. It may therefore be sometimes possible to use certificates for
purposes prohibited by their extensions because a specific application does
not recognize or honour the values of the relevant extensions.

The \s-1DER\s0 and \s-1ASN1\s0 options should be used with caution. It is possible to create
totally invalid extensions if they are not used carefully.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
If an extension is multi-value and a field value must contain a comma the long
form must be used otherwise the comma would be misinterpreted as a field
separator. For example:

.Vb 1
 subjectAltName=URI:ldap://somehost.com/CN=foo,OU=bar
.Ve

will produce an error but the equivalent form:

.Vb 1
 subjectAltName=@subject_alt_section

 [subject_alt_section]
 subjectAltName=URI:ldap://somehost.com/CN=foo,OU=bar
.Ve

is valid.

Due to the behaviour of the OpenSSL **conf** library the same field name
can only occur once in a section. This means that:

.Vb 1
 subjectAltName=@alt_section

 [alt_section]

 email=steve@here
 email=steve@there
.Ve

will only recognize the last value. This can be worked around by using the form:

.Vb 1
 [alt_section]

 email.1=steve@here
 email.2=steve@there
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**req**\|(1), **ca**\|(1), **x509**\|(1),
**ASN1\_generate\_nconf**\|(3)

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2004-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
