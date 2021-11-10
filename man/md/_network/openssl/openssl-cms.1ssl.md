# cms(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-cms, cms - CMS utility

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl cms [-help] [-encrypt] [-decrypt] [-sign] [-verify] [-cmsout] [-resign] [-data_create] [-data_out] [-digest_create] [-digest_verify] [-compress] [-uncompress] [-EncryptedData_encrypt] [-sign_receipt] [-verify_receipt receipt] [-in filename] [-inform SMIME|PEM|DER] [-rctform SMIME|PEM|DER] [-out filename] [-outform SMIME|PEM|DER] [-stream -indef -noindef] [-noindef] [-content filename] [-text] [-noout] [-print] [-CAfile file] [-CApath dir] [-no-CAfile] [-no-CApath] [-attime timestamp] [-check_ss_sig] [-crl_check] [-crl_check_all] [-explicit_policy] [-extended_crl] [-ignore_critical] [-inhibit_any] [-inhibit_map] [-no_check_time] [-partial_chain] [-policy arg] [-policy_check] [-policy_print] [-purpose purpose] [-suiteB_128] [-suiteB_128_only] [-suiteB_192] [-trusted_first] [-no_alt_chains] [-use_deltas] [-auth_level num] [-verify_depth num] [-verify_email email] [-verify_hostname hostname] [-verify_ip ip] [-verify_name name] [-x509_strict] [-md digest] [-\f(BIcipher] [-nointern] [-noverify] [-nocerts] [-noattr] [-nosmimecap] [-binary] [-crlfeol] [-asciicrlf] [-nodetach] [-certfile file] [-certsout file] [-signer file] [-recip file] [-keyid] [-receipt_request_all] [-receipt_request_first] [-receipt_request_from emailaddress] [-receipt_request_to emailaddress] [-receipt_request_print] [-secretkey key] [-secretkeyid id] [-econtent_type type] [-inkey file] [-keyopt name:parameter] [-passin arg] [-rand file...] [-writerand file] [cert.pem...] [-to addr] [-from addr] [-subject subj] [cert.pem]...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **cms** command handles S/MIME v3.1 mail. It can encrypt, decrypt, sign and
verify, compress and uncompress S/MIME messages.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
There are fourteen operation options that set the type of operation to be
performed. The meaning of the other options varies according to the operation
type.

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-encrypt**  
  .IX Item "-encrypt"
  Encrypt mail for the given recipient certificates. Input file is the message
  to be encrypted. The output file is the encrypted mail in \s-1MIME\s0 format. The
  actual \s-1CMS\s0 type is &lt;B&gt;EnvelopedData&lt;B&gt;.
  .Sp
  Note that no revocation check is done for the recipient cert, so if that
  key has been compromised, others may be able to decrypt the text.
* **-decrypt**  
  .IX Item "-decrypt"
  Decrypt mail using the supplied certificate and private key. Expects an
  encrypted mail message in \s-1MIME\s0 format for the input file. The decrypted mail
  is written to the output file.
* **-debug\_decrypt**  
  .IX Item "-debug_decrypt"
  This option sets the **\s-1CMS\_DEBUG\_DECRYPT\s0** flag. This option should be used
  with caution: see the notes section below.
* **-sign**  
  .IX Item "-sign"
  Sign mail using the supplied certificate and private key. Input file is
  the message to be signed. The signed message in \s-1MIME\s0 format is written
  to the output file.
* **-verify**  
  .IX Item "-verify"
  Verify signed mail. Expects a signed mail message on input and outputs
  the signed data. Both clear text and opaque signing is supported.
* **-cmsout**  
  .IX Item "-cmsout"
  Takes an input message and writes out a \s-1PEM\s0 encoded \s-1CMS\s0 structure.
* **-resign**  
  .IX Item "-resign"
  Resign a message: take an existing message and one or more new signers.
* **-data\_create**  
  .IX Item "-data_create"
  Create a \s-1CMS\s0 **Data** type.
* **-data\_out**  
  .IX Item "-data_out"
  **Data** type and output the content.
* **-digest\_create**  
  .IX Item "-digest_create"
  Create a \s-1CMS\s0 **DigestedData** type.
* **-digest\_verify**  
  .IX Item "-digest_verify"
  Verify a \s-1CMS\s0 **DigestedData** type and output the content.
* **-compress**  
  .IX Item "-compress"
  Create a \s-1CMS\s0 **CompressedData** type. OpenSSL must be compiled with **zlib**
  support for this option to work, otherwise it will output an error.
* **-uncompress**  
  .IX Item "-uncompress"
  Uncompress a \s-1CMS\s0 **CompressedData** type and output the content. OpenSSL must be
  compiled with **zlib** support for this option to work, otherwise it will
  output an error.
* **-EncryptedData\_encrypt**  
  .IX Item "-EncryptedData_encrypt"
  Encrypt content using supplied symmetric key and algorithm using a \s-1CMS\s0
  **EncryptedData** type and output the content.
* **-sign\_receipt**  
  .IX Item "-sign_receipt"
  Generate and output a signed receipt for the supplied message. The input
  message **must** contain a signed receipt request. Functionality is otherwise
  similar to the **-sign** operation.
* **-verify_receipt receipt**  
  .IX Item "-verify_receipt receipt"
  Verify a signed receipt in filename **receipt**. The input message **must**
  contain the original receipt request. Functionality is otherwise similar
  to the **-verify** operation.
* **-in filename**  
  .IX Item "-in filename"
  The input message to be encrypted or signed or the message to be decrypted
  or verified.
* **-inform SMIME|PEM|DER**  
  .IX Item "-inform SMIME|PEM|DER"
  This specifies the input format for the \s-1CMS\s0 structure. The default
  is **\s-1SMIME\s0** which reads an S/MIME format message. **\s-1PEM\s0** and **\s-1DER\s0**
  format change this to expect \s-1PEM\s0 and \s-1DER\s0 format \s-1CMS\s0 structures
  instead. This currently only affects the input format of the \s-1CMS\s0
  structure, if no \s-1CMS\s0 structure is being input (for example with
  **-encrypt** or **-sign**) this option has no effect.
* **-rctform SMIME|PEM|DER**  
  .IX Item "-rctform SMIME|PEM|DER"
  Specify the format for a signed receipt for use with the **-receipt\_verify**
  operation.
* **-out filename**  
  .IX Item "-out filename"
  The message text that has been decrypted or verified or the output \s-1MIME\s0
  format message that has been signed or verified.
* **-outform SMIME|PEM|DER**  
  .IX Item "-outform SMIME|PEM|DER"
  This specifies the output format for the \s-1CMS\s0 structure. The default
  is **\s-1SMIME\s0** which writes an S/MIME format message. **\s-1PEM\s0** and **\s-1DER\s0**
  format change this to write \s-1PEM\s0 and \s-1DER\s0 format \s-1CMS\s0 structures
  instead. This currently only affects the output format of the \s-1CMS\s0
  structure, if no \s-1CMS\s0 structure is being output (for example with
  **-verify** or **-decrypt**) this option has no effect.
* **-stream -indef -noindef**  
  .IX Item "-stream -indef -noindef"
  The **-stream** and **-indef** options are equivalent and enable streaming I/O
  for encoding operations. This permits single pass processing of data without
  the need to hold the entire contents in memory, potentially supporting very
  large files. Streaming is automatically set for S/MIME signing with detached
  data if the output format is **\s-1SMIME\s0** it is currently off by default for all
  other operations.
* **-noindef**  
  .IX Item "-noindef"
  Disable streaming I/O where it would produce and indefinite length constructed
  encoding. This option currently has no effect. In future streaming will be
  enabled by default on all relevant operations and this option will disable it.
* **-content filename**  
  .IX Item "-content filename"
  This specifies a file containing the detached content, this is only
  useful with the **-verify** command. This is only usable if the \s-1CMS\s0
  structure is using the detached signature form where the content is
  not included. This option will override any content if the input format
  is S/MIME and it uses the multipart/signed \s-1MIME\s0 content type.
* **-text**  
  .IX Item "-text"
  This option adds plain text (text/plain) \s-1MIME\s0 headers to the supplied
  message if encrypting or signing. If decrypting or verifying it strips
  off text headers: if the decrypted or verified message is not of \s-1MIME\s0
  type text/plain then an error occurs.
* **-noout**  
  .IX Item "-noout"
  For the **-cmsout** operation do not output the parsed \s-1CMS\s0 structure. This
  is useful when combined with the **-print** option or if the syntax of the \s-1CMS\s0
  structure is being checked.
* **-print**  
  .IX Item "-print"
  For the **-cmsout** operation print out all fields of the \s-1CMS\s0 structure. This
  is mainly useful for testing purposes.
* **-CAfile file**  
  .IX Item "-CAfile file"
  A file containing trusted \s-1CA\s0 certificates, only used with **-verify**.
* **-CApath dir**  
  .IX Item "-CApath dir"
  A directory containing trusted \s-1CA\s0 certificates, only used with
  **-verify**. This directory must be a standard certificate directory: that
  is a hash of each subject name (using **x509 -hash**) should be linked
  to each certificate.
* **-no-CAfile**  
  .IX Item "-no-CAfile"
  Do not load the trusted \s-1CA\s0 certificates from the default file location
* **-no-CApath**  
  .IX Item "-no-CApath"
  Do not load the trusted \s-1CA\s0 certificates from the default directory location
* **-md digest**  
  .IX Item "-md digest"
  Digest algorithm to use when signing or resigning. If not present then the
  default digest algorithm for the signing key will be used (usually \s-1SHA1\s0).
* **-\f(BIcipher**  
  .IX Item "-cipher"
  The encryption algorithm to use. For example triple \s-1DES\s0 (168 bits) - **-des3**
  or 256 bit \s-1AES\s0 - **-aes256**. Any standard algorithm name (as used by the
  **EVP\_get\_cipherbyname()** function) can also be used preceded by a dash, for
  example **-aes-128-cbc**. See **enc**\|(1) for a list of ciphers
  supported by your version of OpenSSL.
  .Sp
  If not specified triple \s-1DES\s0 is used. Only used with **-encrypt** and
  **-EncryptedData\_create** commands.
* **-nointern**  
  .IX Item "-nointern"
  When verifying a message normally certificates (if any) included in
  the message are searched for the signing certificate. With this option
  only the certificates specified in the **-certfile** option are used.
  The supplied certificates can still be used as untrusted CAs however.
* **-noverify**  
  .IX Item "-noverify"
  Do not verify the signers certificate of a signed message.
* **-nocerts**  
  .IX Item "-nocerts"
  When signing a message the signer's certificate is normally included
  with this option it is excluded. This will reduce the size of the
  signed message but the verifier must have a copy of the signers certificate
  available locally (passed using the **-certfile** option for example).
* **-noattr**  
  .IX Item "-noattr"
  Normally when a message is signed a set of attributes are included which
  include the signing time and supported symmetric algorithms. With this
  option they are not included.
* **-nosmimecap**  
  .IX Item "-nosmimecap"
  Exclude the list of supported algorithms from signed attributes, other options
  such as signing time and content type are still included.
* **-binary**  
  .IX Item "-binary"
  Normally the input message is converted to canonical\*(R" format which is
  effectively using \s-1CR\s0 and \s-1LF\s0 as end of line: as required by the S/MIME
  specification. When this option is present no translation occurs. This
  is useful when handling binary data which may not be in \s-1MIME\s0 format.
* **-crlfeol**  
  .IX Item "-crlfeol"
  Normally the output file uses a single **\s-1LF\s0** as end of line. When this
  option is present **\s-1CRLF\s0** is used instead.
* **-asciicrlf**  
  .IX Item "-asciicrlf"
  When signing use \s-1ASCII CRLF\s0 format canonicalisation. This strips trailing
  whitespace from all lines, deletes trailing blank lines at \s-1EOF\s0 and sets
  the encapsulated content type. This option is normally used with detached
  content and an output signature format of \s-1DER.\s0 This option is not normally
  needed when verifying as it is enabled automatically if the encapsulated
  content format is detected.
* **-nodetach**  
  .IX Item "-nodetach"
  When signing a message use opaque signing: this form is more resistant
  to translation by mail relays but it cannot be read by mail agents that
  do not support S/MIME.  Without this option cleartext signing with
  the \s-1MIME\s0 type multipart/signed is used.
* **-certfile file**  
  .IX Item "-certfile file"
  Allows additional certificates to be specified. When signing these will
  be included with the message. When verifying these will be searched for
  the signers certificates. The certificates should be in \s-1PEM\s0 format.
* **-certsout file**  
  .IX Item "-certsout file"
  Any certificates contained in the message are written to **file**.
* **-signer file**  
  .IX Item "-signer file"
  A signing certificate when signing or resigning a message, this option can be
  used multiple times if more than one signer is required. If a message is being
  verified then the signers certificates will be written to this file if the
  verification was successful.
* **-recip file**  
  .IX Item "-recip file"
  When decrypting a message this specifies the recipients certificate. The
  certificate must match one of the recipients of the message or an error
  occurs.
  .Sp
  When encrypting a message this option may be used multiple times to specify
  each recipient. This form **must** be used if customised parameters are
  required (for example to specify RSA-OAEP).
  .Sp
  Only certificates carrying \s-1RSA,\s0 Diffie-Hellman or \s-1EC\s0 keys are supported by this
  option.
* **-keyid**  
  .IX Item "-keyid"
  Use subject key identifier to identify certificates instead of issuer name and
  serial number. The supplied certificate **must** include a subject key
  identifier extension. Supported by **-sign** and **-encrypt** options.
* **-receipt\_request\_all**, **-receipt\_request\_first**  
  .IX Item "-receipt_request_all, -receipt_request_first"
  For **-sign** option include a signed receipt request. Indicate requests should
  be provided by all recipient or first tier recipients (those mailed directly
  and not from a mailing list). Ignored it **-receipt\_request\_from** is included.
* **-receipt_request_from emailaddress**  
  .IX Item "-receipt_request_from emailaddress"
  For **-sign** option include a signed receipt request. Add an explicit email
  address where receipts should be supplied.
* **-receipt_request_to emailaddress**  
  .IX Item "-receipt_request_to emailaddress"
  Add an explicit email address where signed receipts should be sent to. This
  option **must** but supplied if a signed receipt it requested.
* **-receipt\_request\_print**  
  .IX Item "-receipt_request_print"
  For the **-verify** operation print out the contents of any signed receipt
  requests.
* **-secretkey key**  
  .IX Item "-secretkey key"
  Specify symmetric key to use. The key must be supplied in hex format and be
  consistent with the algorithm used. Supported by the **-EncryptedData\_encrypt**
  **-EncryptedData\_decrypt**, **-encrypt** and **-decrypt** options. When used
  with **-encrypt** or **-decrypt** the supplied key is used to wrap or unwrap the
  content encryption key using an \s-1AES\s0 key in the **KEKRecipientInfo** type.
* **-secretkeyid id**  
  .IX Item "-secretkeyid id"
  The key identifier for the supplied symmetric key for **KEKRecipientInfo** type.
  This option **must** be present if the **-secretkey** option is used with
  **-encrypt**. With **-decrypt** operations the **id** is used to locate the
  relevant key if it is not supplied then an attempt is used to decrypt any
  **KEKRecipientInfo** structures.
* **-econtent_type type**  
  .IX Item "-econtent_type type"
  Set the encapsulated content type to **type** if not supplied the **Data** type
  is used. The **type** argument can be any valid \s-1OID\s0 name in either text or
  numerical format.
* **-inkey file**  
  .IX Item "-inkey file"
  The private key to use when signing or decrypting. This must match the
  corresponding certificate. If this option is not specified then the
  private key must be included in the certificate file specified with
  the **-recip** or **-signer** file. When signing this option can be used
  multiple times to specify successive keys.
* **-keyopt name:opt**  
  .IX Item "-keyopt name:opt"
  For signing and encryption this option can be used multiple times to
  set customised parameters for the preceding key or certificate. It can
  currently be used to set RSA-PSS for signing, RSA-OAEP for encryption
  or to modify default parameters for \s-1ECDH.\s0
* **-passin arg**  
  .IX Item "-passin arg"
  The private key password source. For more information about the format of **arg**
  see Pass Phrase Options\*(R" in **openssl**\|(1).
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
* **cert.pem...**  
  .IX Item "cert.pem..."
  One or more certificates of message recipients: used when encrypting
  a message.
* **-to, -from, -subject**  
  .IX Item "-to, -from, -subject"
  The relevant mail headers. These are included outside the signed
  portion of a message so they may be included manually. If signing
  then many S/MIME mail clients check the signers certificate's email
  address matches that specified in the From: address.
* **-attime**, **-check\_ss\_sig**, **-crl\_check**, **-crl\_check\_all**, **-explicit\_policy**, **-extended\_crl**, **-ignore\_critical**, **-inhibit\_any**, **-inhibit\_map**, **-no\_alt\_chains**, **-no\_check\_time**, **-partial\_chain**, **-policy**, **-policy\_check**, **-policy\_print**, **-purpose**, **-suiteB\_128**, **-suiteB\_128\_only**, **-suiteB\_192**, **-trusted\_first**, **-use\_deltas**, **-auth\_level**, **-verify\_depth**, **-verify\_email**, **-verify\_hostname**, **-verify\_ip**, **-verify\_name**, **-x509\_strict**  
  .IX Item "-attime, -check_ss_sig, -crl_check, -crl_check_all, -explicit_policy, -extended_crl, -ignore_critical, -inhibit_any, -inhibit_map, -no_alt_chains, -no_check_time, -partial_chain, -policy, -policy_check, -policy_print, -purpose, -suiteB_128, -suiteB_128_only, -suiteB_192, -trusted_first, -use_deltas, -auth_level, -verify_depth, -verify_email, -verify_hostname, -verify_ip, -verify_name, -x509_strict"
  Set various certificate chain validation options. See the
  **verify**\|(1) manual page for details.

<a name="notes"></a>

# Notes

.IX Header "NOTES"
The \s-1MIME\s0 message must be sent without any blank lines between the
headers and the output. Some mail programs will automatically add
a blank line. Piping the mail directly to sendmail is one way to
achieve the correct format.

The supplied message to be signed or encrypted must include the
necessary \s-1MIME\s0 headers or many S/MIME clients won't display it
properly (if at all). You can use the **-text** option to automatically
add plain text headers.

A signed and encrypted\*(R" message is one where a signed message is
then encrypted. This can be produced by encrypting an already signed
message: see the examples section.

This version of the program only allows one signer per message but it
will verify multiple signers on received messages. Some S/MIME clients
choke if a message contains multiple signers. It is possible to sign
messages in parallel\*(R" by signing an already signed message.

The options **-encrypt** and **-decrypt** reflect common usage in S/MIME
clients. Strictly speaking these process \s-1CMS\s0 enveloped data: \s-1CMS\s0
encrypted data is used for other purposes.

The **-resign** option uses an existing message digest when adding a new
signer. This means that attributes must be present in at least one existing
signer using the same message digest or this operation will fail.

The **-stream** and **-indef** options enable streaming I/O support.
As a result the encoding is \s-1BER\s0 using indefinite length constructed encoding
and no longer \s-1DER.\s0 Streaming is supported for the **-encrypt** operation and the
**-sign** operation if the content is not detached.

Streaming is always used for the **-sign** operation with detached data but
since the content is no longer part of the \s-1CMS\s0 structure the encoding
remains \s-1DER.\s0

If the **-decrypt** option is used without a recipient certificate then an
attempt is made to locate the recipient by trying each potential recipient
in turn using the supplied private key. To thwart the \s-1MMA\s0 attack
(Bleichenbacher's attack on \s-1PKCS\s0 #1 v1.5 \s-1RSA\s0 padding) all recipients are
tried whether they succeed or not and if no recipients match the message
is decrypted\*(R" using a random key which will typically output garbage.
The **-debug\_decrypt** option can be used to disable the \s-1MMA\s0 attack protection
and return an error if no recipient can be found: this option should be used
with caution. For a fuller description see **CMS\_decrypt**\|(3)).

<a name="exit-codes"></a>

# Exit Codes

.IX Header "EXIT CODES"

* 0  
  The operation was completely successfully.
* 1  
  .IX Item "1"
  An error occurred parsing the command options.
* 2  
  .IX Item "2"
  One of the input files could not be read.
* 3  
  .IX Item "3"
  An error occurred creating the \s-1CMS\s0 file or when reading the \s-1MIME\s0
  message.
* 4  
  .IX Item "4"
  An error occurred decrypting or verifying the message.
* 5  
  .IX Item "5"
  The message was verified correctly but an error occurred writing out
  the signers certificates.

<a name="compatibility-with-pkcs7-format"></a>

# Compatibility with Pkcs#7 Format.

.IX Header "COMPATIBILITY WITH PKCS#7 format."
The **smime** utility can only process the older **PKCS#7** format. The **cms**
utility supports Cryptographic Message Syntax format. Use of some features
will result in messages which cannot be processed by applications which only
support the older format. These are detailed below.

The use of the **-keyid** option with **-sign** or **-encrypt**.

The **-outform \s-1PEM\s0** option uses different headers.

The **-compress** option.

The **-secretkey** option when used with **-encrypt**.

The use of \s-1PSS\s0 with **-sign**.

The use of \s-1OAEP\s0 or non-RSA keys with **-encrypt**.

Additionally the **-EncryptedData\_create** and **-data\_create** type cannot
be processed by the older **smime** command.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"
Create a cleartext signed message:

.Vb 2
 openssl cms -sign -in message.txt -text -out mail.msg \e
        -signer mycert.pem
.Ve

Create an opaque signed message

.Vb 2
 openssl cms -sign -in message.txt -text -out mail.msg -nodetach \e
        -signer mycert.pem
.Ve

Create a signed message, include some additional certificates and
read the private key from another file:

.Vb 2
 openssl cms -sign -in in.txt -text -out mail.msg \e
        -signer mycert.pem -inkey mykey.pem -certfile mycerts.pem
.Ve

Create a signed message with two signers, use key identifier:

.Vb 2
 openssl cms -sign -in message.txt -text -out mail.msg \e
        -signer mycert.pem -signer othercert.pem -keyid
.Ve

Send a signed message under Unix directly to sendmail, including headers:

.Vb 3
 openssl cms -sign -in in.txt -text -signer mycert.pem \e
        -from steve@openssl.org -to someone@somewhere \e
        -subject "Signed message" | sendmail someone@somewhere
.Ve

Verify a message and extract the signer's certificate if successful:

.Vb 1
 openssl cms -verify -in mail.msg -signer user.pem -out signedtext.txt
.Ve

Send encrypted mail using triple \s-1DES:\s0

.Vb 3
 openssl cms -encrypt -in in.txt -from steve@openssl.org \e
        -to someone@somewhere -subject "Encrypted message" \e
        -des3 user.pem -out mail.msg
.Ve

Sign and encrypt mail:

.Vb 4
 openssl cms -sign -in ml.txt -signer my.pem -text \e
        | openssl cms -encrypt -out mail.msg \e
        -from steve@openssl.org -to someone@somewhere \e
        -subject "Signed and Encrypted message" -des3 user.pem
.Ve

Note: the encryption command does not include the **-text** option because the
message being encrypted already has \s-1MIME\s0 headers.

Decrypt mail:

.Vb 1
 openssl cms -decrypt -in mail.msg -recip mycert.pem -inkey key.pem
.Ve

The output from Netscape form signing is a PKCS#7 structure with the
detached signature format. You can use this program to verify the
signature by line wrapping the base64 encoded structure and surrounding
it with:

.Vb 2
 -----BEGIN PKCS7-----
 -----END PKCS7-----
.Ve

and using the command,

.Vb 1
 openssl cms -verify -inform PEM -in signature.pem -content content.txt
.Ve

alternatively you can base64 decode the signature and use

.Vb 1
 openssl cms -verify -inform DER -in signature.der -content content.txt
.Ve

Create an encrypted message using 128 bit Camellia:

.Vb 1
 openssl cms -encrypt -in plain.txt -camellia128 -out mail.msg cert.pem
.Ve

Add a signer to an existing message:

.Vb 1
 openssl cms -resign -in mail.msg -signer newsign.pem -out mail2.msg
.Ve

Sign mail using RSA-PSS:

.Vb 2
 openssl cms -sign -in message.txt -text -out mail.msg \e
        -signer mycert.pem -keyopt rsa_padding_mode:pss
.Ve

Create encrypted mail using RSA-OAEP:

.Vb 2
 openssl cms -encrypt -in plain.txt -out mail.msg \e
        -recip cert.pem -keyopt rsa_padding_mode:oaep
.Ve

Use \s-1SHA256 KDF\s0 with an \s-1ECDH\s0 certificate:

.Vb 2
 openssl cms -encrypt -in plain.txt -out mail.msg \e
        -recip ecdhcert.pem -keyopt ecdh_kdf_md:sha256
.Ve

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
The \s-1MIME\s0 parser isn't very clever: it seems to handle most messages that I've
thrown at it but it may choke on others.

The code currently will only write out the signer's certificate to a file: if
the signer has a separate encryption certificate this must be manually
extracted. There should be some heuristic that determines the correct
encryption certificate.

Ideally a database should be maintained of a certificates for each email
address.

The code doesn't currently take note of the permitted symmetric encryption
algorithms as supplied in the SMIMECapabilities signed attribute. this means the
user has to manually include the correct encryption algorithm. It should store
the list of permitted ciphers in a database and only use those.

No revocation checking is done on the signer's certificate.

<a name="history"></a>

# History

.IX Header "HISTORY"
The use of multiple **-signer** options and the **-resign** command were first
added in OpenSSL 1.0.0.

The **keyopt** option was added in OpenSSL 1.0.2.

Support for RSA-OAEP and RSA-PSS was added in OpenSSL 1.0.2.

The use of non-RSA keys with **-encrypt** and **-decrypt**
was added in OpenSSL 1.0.2.

The -no_alt_chains option was added in OpenSSL 1.0.2b.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2008-2021 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
