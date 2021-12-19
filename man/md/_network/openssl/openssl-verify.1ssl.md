# verify(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl-verify, verify - Utility to verify certificates

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl verify [-help] [-CAfile file] [-CApath directory] [-no-CAfile] [-no-CApath] [-allow_proxy_certs] [-attime timestamp] [-check_ss_sig] [-CRLfile file] [-crl_download] [-crl_check] [-crl_check_all] [-engine id] [-explicit_policy] [-extended_crl] [-ignore_critical] [-inhibit_any] [-inhibit_map] [-nameopt option] [-no_check_time] [-partial_chain] [-policy arg] [-policy_check] [-policy_print] [-purpose purpose] [-suiteB_128] [-suiteB_128_only] [-suiteB_192] [-trusted_first] [-no_alt_chains] [-untrusted file] [-trusted file] [-use_deltas] [-verbose] [-auth_level level] [-verify_depth num] [-verify_email email] [-verify_hostname hostname] [-verify_ip ip] [-verify_name name] [-x509_strict] [-show_chain] [-] [certificates]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The **verify** command verifies certificate chains.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-help**  
  .IX Item "-help"
  Print out a usage message.
* **-CAfile file**  
  .IX Item "-CAfile file"
  A **file** of trusted certificates.
  The file should contain one or more certificates in \s-1PEM\s0 format.
* **-CApath directory**  
  .IX Item "-CApath directory"
  A directory of trusted certificates. The certificates should have names
  of the form: hash.0 or have symbolic links to them of this
  form (hash\*(R" is the hashed certificate subject name: see the **-hash** option
  of the **x509** utility). Under Unix the **c\_rehash** script will automatically
  create symbolic links to a directory of certificates.
* **-no-CAfile**  
  .IX Item "-no-CAfile"
  Do not load the trusted \s-1CA\s0 certificates from the default file location.
* **-no-CApath**  
  .IX Item "-no-CApath"
  Do not load the trusted \s-1CA\s0 certificates from the default directory location.
* **-allow\_proxy\_certs**  
  .IX Item "-allow_proxy_certs"
  Allow the verification of proxy certificates.
* **-attime timestamp**  
  .IX Item "-attime timestamp"
  Perform validation checks using time specified by **timestamp** and not
  current system time. **timestamp** is the number of seconds since
  01.01.1970 (\s-1UNIX\s0 time).
* **-check\_ss\_sig**  
  .IX Item "-check_ss_sig"
  Verify the signature of
  the last certificate in a chain if the certificate is supposedly self-signed.
  This is prohibited and will result in an error if it is a non-conforming \s-1CA\s0
  certificate with key usage restrictions not including the keyCertSign bit.
  This verification is disabled by default because it doesn't add any security.
* **-CRLfile file**  
  .IX Item "-CRLfile file"
  The **file** should contain one or more CRLs in \s-1PEM\s0 format.
  This option can be specified more than once to include CRLs from multiple
  **files**.
* **-crl\_download**  
  .IX Item "-crl_download"
  Attempt to download \s-1CRL\s0 information for this certificate.
* **-crl\_check**  
  .IX Item "-crl_check"
  Checks end entity certificate validity by attempting to look up a valid \s-1CRL.\s0
  If a valid \s-1CRL\s0 cannot be found an error occurs.
* **-crl\_check\_all**  
  .IX Item "-crl_check_all"
  Checks the validity of **all** certificates in the chain by attempting
  to look up valid CRLs.
* **-engine id**  
  .IX Item "-engine id"
  Specifying an engine **id** will cause **verify**\|(1) to attempt to load the
  specified engine.
  The engine will then be set as the default for all its supported algorithms.
  If you want to load certificates or CRLs that require engine support via any of
  the **-trusted**, **-untrusted** or **-CRLfile** options, the **-engine** option
  must be specified before those options.
* **-explicit\_policy**  
  .IX Item "-explicit_policy"
  Set policy variable require-explicit-policy (see \s-1RFC5280\s0).
* **-extended\_crl**  
  .IX Item "-extended_crl"
  Enable extended \s-1CRL\s0 features such as indirect CRLs and alternate \s-1CRL\s0
  signing keys.
* **-ignore\_critical**  
  .IX Item "-ignore_critical"
  Normally if an unhandled critical extension is present which is not
  supported by OpenSSL the certificate is rejected (as required by \s-1RFC5280\s0).
  If this option is set critical extensions are ignored.
* **-inhibit\_any**  
  .IX Item "-inhibit_any"
  Set policy variable inhibit-any-policy (see \s-1RFC5280\s0).
* **-inhibit\_map**  
  .IX Item "-inhibit_map"
  Set policy variable inhibit-policy-mapping (see \s-1RFC5280\s0).
* **-nameopt option**  
  .IX Item "-nameopt option"
  Option which determines how the subject or issuer names are displayed. The
  **option** argument can be a single option or multiple options separated by
  commas.  Alternatively the **-nameopt** switch may be used more than once to
  set multiple options. See the **x509**\|(1) manual page for details.
* **-no\_check\_time**  
  .IX Item "-no_check_time"
  This option suppresses checking the validity period of certificates and CRLs
  against the current time. If option **-attime timestamp** is used to specify
  a verification time, the check is not suppressed.
* **-partial\_chain**  
  .IX Item "-partial_chain"
  Allow verification to succeed even if a _complete_ chain cannot be built to a
  self-signed trust-anchor, provided it is possible to construct a chain to a
  trusted certificate that might not be self-signed.
* **-policy arg**  
  .IX Item "-policy arg"
  Enable policy processing and add **arg** to the user-initial-policy-set (see
  \s-1RFC5280\s0). The policy **arg** can be an object name an \s-1OID\s0 in numeric form.
  This argument can appear more than once.
* **-policy\_check**  
  .IX Item "-policy_check"
  Enables certificate policy processing.
* **-policy\_print**  
  .IX Item "-policy_print"
  Print out diagnostics related to policy processing.
* **-purpose purpose**  
  .IX Item "-purpose purpose"
  The intended use for the certificate. If this option is not specified,
  **verify** will not consider certificate purpose during chain verification.
  Currently accepted uses are **sslclient**, **sslserver**, **nssslserver**,
  **smimesign**, **smimeencrypt**. See the **\s-1VERIFY OPERATION\s0** section for more
  information.
* **-suiteB\_128\_only**, **-suiteB\_128**, **-suiteB\_192**  
  .IX Item "-suiteB_128_only, -suiteB_128, -suiteB_192"
  Enable the Suite B mode operation at 128 bit Level of Security, 128 bit or
  192 bit, or only 192 bit Level of Security respectively.
  See \s-1RFC6460\s0 for details. In particular the supported signature algorithms are
  reduced to support only \s-1ECDSA\s0 and \s-1SHA256\s0 or \s-1SHA384\s0 and only the elliptic curves
  P-256 and P-384.
* **-trusted\_first**  
  .IX Item "-trusted_first"
  When constructing the certificate chain, use the trusted certificates specified
  via **-CAfile**, **-CApath** or **-trusted** before any certificates specified via
  **-untrusted**.
  This can be useful in environments with Bridge or Cross-Certified CAs.
  As of OpenSSL 1.1.0 this option is on by default and cannot be disabled.
* **-no\_alt\_chains**  
  .IX Item "-no_alt_chains"
  By default, unless **-trusted\_first** is specified, when building a certificate
  chain, if the first certificate chain found is not trusted, then OpenSSL will
  attempt to replace untrusted issuer certificates with certificates from the
  trust store to see if an alternative chain can be found that is trusted.
  As of OpenSSL 1.1.0, with **-trusted\_first** always on, this option has no
  effect.
* **-untrusted file**  
  .IX Item "-untrusted file"
  A **file** of additional untrusted certificates (intermediate issuer CAs) used
  to construct a certificate chain from the subject certificate to a trust-anchor.
  The **file** should contain one or more certificates in \s-1PEM\s0 format.
  This option can be specified more than once to include untrusted certificates
  from multiple **files**.
* **-trusted file**  
  .IX Item "-trusted file"
  A **file** of trusted certificates, which must be self-signed, unless the
  **-partial\_chain** option is specified.
  The **file** contains one or more certificates in \s-1PEM\s0 format.
  With this option, no additional (e.g., default) certificate lists are
  consulted.
  That is, the only trust-anchors are those listed in **file**.
  This option can be specified more than once to include trusted certificates
  from multiple **files**.
  This option implies the **-no-CAfile** and **-no-CApath** options.
  This option cannot be used in combination with either of the **-CAfile** or
  **-CApath** options.
* **-use\_deltas**  
  .IX Item "-use_deltas"
  Enable support for delta CRLs.
* **-verbose**  
  .IX Item "-verbose"
  Print extra information about the operations being performed.
* **-auth_level level**  
  .IX Item "-auth_level level"
  Set the certificate chain authentication security level to **level**.
  The authentication security level determines the acceptable signature and
  public key strength when verifying certificate chains.
  For a certificate chain to validate, the public keys of all the certificates
  must meet the specified security **level**.
  The signature algorithm security level is enforced for all the certificates in
  the chain except for the chain's _trust anchor_, which is either directly
  trusted or validated by means other than its signature.
  See **SSL\_CTX\_set\_security\_level**\|(3) for the definitions of the available
  levels.
  The default security level is -1, or not set\*(R".
  At security level 0 or lower all algorithms are acceptable.
  Security level 1 requires at least 80-bit-equivalent security and is broadly
  interoperable, though it will, for example, reject \s-1MD5\s0 signatures or \s-1RSA\s0 keys
  shorter than 1024 bits.
* **-verify_depth num**  
  .IX Item "-verify_depth num"
  Limit the certificate chain to **num** intermediate \s-1CA\s0 certificates.
  A maximal depth chain can have up to **num+2** certificates, since neither the
  end-entity certificate nor the trust-anchor certificate count against the
  **-verify\_depth** limit.
* **-verify_email email**  
  .IX Item "-verify_email email"
  Verify if the **email** matches the email address in Subject Alternative Name or
  the email in the subject Distinguished Name.
* **-verify_hostname hostname**  
  .IX Item "-verify_hostname hostname"
  Verify if the **hostname** matches \s-1DNS\s0 name in Subject Alternative Name or
  Common Name in the subject certificate.
* **-verify_ip ip**  
  .IX Item "-verify_ip ip"
  Verify if the **ip** matches the \s-1IP\s0 address in Subject Alternative Name of
  the subject certificate.
* **-verify_name name**  
  .IX Item "-verify_name name"
  Use default verification policies like trust model and required certificate
  policies identified by **name**.
  The trust model determines which auxiliary trust or reject OIDs are applicable
  to verifying the given certificate chain.
  See the **-addtrust** and **-addreject** options of the **x509**\|(1) command-line
  utility.
  Supported policy names include: **default**, **pkcs7**, **smime\_sign**,
  **ssl\_client**, **ssl\_server**.
  These mimics the combinations of purpose and trust settings used in \s-1SSL, CMS\s0
  and S/MIME.
  As of OpenSSL 1.1.0, the trust model is inferred from the purpose when not
  specified, so the **-verify\_name** options are functionally equivalent to the
  corresponding **-purpose** settings.
* **-x509\_strict**  
  .IX Item "-x509_strict"
  For strict X.509 compliance, disable non-compliant workarounds for broken
  certificates.
* **-show\_chain**  
  .IX Item "-show_chain"
  Display information about the certificate chain that has been built (if
  successful). Certificates in the chain that came from the untrusted list will be
  flagged as untrusted\*(R".
* **-**  
  .IX Item "-"
  Indicates the last option. All arguments following this are assumed to be
  certificate files. This is useful if the first certificate filename begins
  with a **-**.
* **certificates**  
  .IX Item "certificates"
  One or more certificates to verify. If no certificates are given, **verify**
  will attempt to read a certificate from standard input. Certificates must be
  in \s-1PEM\s0 format.

<a name="verify-operation"></a>

# Verify Operation

.IX Header "VERIFY OPERATION"
The **verify** program uses the same functions as the internal \s-1SSL\s0 and S/MIME
verification, therefore, this description applies to these verify operations
too.

There is one crucial difference between the verify operations performed
by the **verify** program: wherever possible an attempt is made to continue
after an error whereas normally the verify operation would halt on the
first error. This allows all the problems with a certificate chain to be
determined.

The verify operation consists of a number of separate steps.

Firstly a certificate chain is built up starting from the supplied certificate
and ending in the root \s-1CA.\s0
It is an error if the whole chain cannot be built up.
The chain is built up by looking up the issuers certificate of the current
certificate.
If a certificate is found which is its own issuer it is assumed to be the root
\s-1CA.\s0

The process of 'looking up the issuers certificate' itself involves a number of
steps.
After all certificates whose subject name matches the issuer name of the current
certificate are subject to further tests.
The relevant authority key identifier components of the current certificate (if
present) must match the subject key identifier (if present) and issuer and
serial number of the candidate issuer, in addition the keyUsage extension of
the candidate issuer (if present) must permit certificate signing.

The lookup first looks in the list of untrusted certificates and if no match
is found the remaining lookups are from the trusted certificates. The root \s-1CA\s0
is always looked up in the trusted certificate list: if the certificate to
verify is a root certificate then an exact match must be found in the trusted
list.

The second operation is to check every untrusted certificate's extensions for
consistency with the supplied purpose. If the **-purpose** option is not included
then no checks are done. The supplied or leaf\*(R" certificate must have extensions
compatible with the supplied purpose and all other certificates must also be valid
\s-1CA\s0 certificates. The precise extensions required are described in more detail in
the **\s-1CERTIFICATE EXTENSIONS\s0** section of the **x509** utility.

The third operation is to check the trust settings on the root \s-1CA.\s0 The root \s-1CA\s0
should be trusted for the supplied purpose.
For compatibility with previous versions of OpenSSL, a certificate with no
trust settings is considered to be valid for all purposes.

The final operation is to check the validity of the certificate chain.
For each element in the chain, including the root \s-1CA\s0 certificate,
the validity period as specified by the \f(CW`notBefore\*(C' and \f(CW\*(C\`notAfter\*(C' fields
is checked against the current system time.
The **-attime** flag may be used to use a reference time other than now.\*(R"
The certificate signature is checked as well
(except for the signature of the typically self-signed root \s-1CA\s0 certificate,
which is verified only if the **-check\_ss\_sig** option is given).

If all operations complete successfully then certificate is considered valid. If
any operation fails then the certificate is not valid.

<a name="diagnostics"></a>

# Diagnostics

.IX Header "DIAGNOSTICS"
When a verify operation fails the output messages can be somewhat cryptic. The
general form of the error message is:

.Vb 2
 server.pem: /C=AU/ST=Queensland/O=CryptSoft Pty Ltd/CN=Test CA (1024 bit)
 error 24 at 1 depth lookup:invalid CA certificate
.Ve

The first line contains the name of the certificate being verified followed by
the subject name of the certificate. The second line contains the error number
and the depth. The depth is number of the certificate being verified when a
problem was detected starting with zero for the certificate being verified itself
then 1 for the \s-1CA\s0 that signed the certificate and so on. Finally a text version
of the error number is presented.

A partial list of the error codes and messages is shown below, this also
includes the name of the error code as defined in the header file x509_vfy.h
Some of the error codes are defined but never returned: these are described
as unused\*(R".

* **X509\_V\_OK**  
  .IX Item "X509_V_OK"
  The operation was successful.
* **X509\_V\_ERR\_UNSPECIFIED**  
  .IX Item "X509_V_ERR_UNSPECIFIED"
  Unspecified error; should not happen.
* **X509\_V\_ERR\_UNABLE\_TO\_GET\_ISSUER\_CERT**  
  .IX Item "X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT"
  The issuer certificate of a looked up certificate could not be found. This
  normally means the list of trusted certificates is not complete.
* **X509\_V\_ERR\_UNABLE\_TO\_GET\_CRL**  
  .IX Item "X509_V_ERR_UNABLE_TO_GET_CRL"
  The \s-1CRL\s0 of a certificate could not be found.
* **X509\_V\_ERR\_UNABLE\_TO\_DECRYPT\_CERT\_SIGNATURE**  
  .IX Item "X509_V_ERR_UNABLE_TO_DECRYPT_CERT_SIGNATURE"
  The certificate signature could not be decrypted. This means that the
  actual signature value could not be determined rather than it not matching
  the expected value, this is only meaningful for \s-1RSA\s0 keys.
* **X509\_V\_ERR\_UNABLE\_TO\_DECRYPT\_CRL\_SIGNATURE**  
  .IX Item "X509_V_ERR_UNABLE_TO_DECRYPT_CRL_SIGNATURE"
  The \s-1CRL\s0 signature could not be decrypted: this means that the actual
  signature value could not be determined rather than it not matching the
  expected value. Unused.
* **X509\_V\_ERR\_UNABLE\_TO\_DECODE\_ISSUER\_PUBLIC\_KEY**  
  .IX Item "X509_V_ERR_UNABLE_TO_DECODE_ISSUER_PUBLIC_KEY"
  The public key in the certificate SubjectPublicKeyInfo could not be read.
* **X509\_V\_ERR\_CERT\_SIGNATURE\_FAILURE**  
  .IX Item "X509_V_ERR_CERT_SIGNATURE_FAILURE"
  The signature of the certificate is invalid.
* **X509\_V\_ERR\_CRL\_SIGNATURE\_FAILURE**  
  .IX Item "X509_V_ERR_CRL_SIGNATURE_FAILURE"
  The signature of the certificate is invalid.
* **X509\_V\_ERR\_CERT\_NOT\_YET\_VALID**  
  .IX Item "X509_V_ERR_CERT_NOT_YET_VALID"
  The certificate is not yet valid: the notBefore date is after the
  current time.
* **X509\_V\_ERR\_CERT\_HAS\_EXPIRED**  
  .IX Item "X509_V_ERR_CERT_HAS_EXPIRED"
  The certificate has expired: that is the notAfter date is before the
  current time.
* **X509\_V\_ERR\_CRL\_NOT\_YET\_VALID**  
  .IX Item "X509_V_ERR_CRL_NOT_YET_VALID"
  The \s-1CRL\s0 is not yet valid.
* **X509\_V\_ERR\_CRL\_HAS\_EXPIRED**  
  .IX Item "X509_V_ERR_CRL_HAS_EXPIRED"
  The \s-1CRL\s0 has expired.
* **X509\_V\_ERR\_ERROR\_IN\_CERT\_NOT\_BEFORE\_FIELD**  
  .IX Item "X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD"
  The certificate notBefore field contains an invalid time.
* **X509\_V\_ERR\_ERROR\_IN\_CERT\_NOT\_AFTER\_FIELD**  
  .IX Item "X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD"
  The certificate notAfter field contains an invalid time.
* **X509\_V\_ERR\_ERROR\_IN\_CRL\_LAST\_UPDATE\_FIELD**  
  .IX Item "X509_V_ERR_ERROR_IN_CRL_LAST_UPDATE_FIELD"
  The \s-1CRL\s0 lastUpdate field contains an invalid time.
* **X509\_V\_ERR\_ERROR\_IN\_CRL\_NEXT\_UPDATE\_FIELD**  
  .IX Item "X509_V_ERR_ERROR_IN_CRL_NEXT_UPDATE_FIELD"
  The \s-1CRL\s0 nextUpdate field contains an invalid time.
* **X509\_V\_ERR\_OUT\_OF\_MEM**  
  .IX Item "X509_V_ERR_OUT_OF_MEM"
  An error occurred trying to allocate memory. This should never happen.
* **X509\_V\_ERR\_DEPTH\_ZERO\_SELF\_SIGNED\_CERT**  
  .IX Item "X509_V_ERR_DEPTH_ZERO_SELF_SIGNED_CERT"
  The passed certificate is self-signed and the same certificate cannot
  be found in the list of trusted certificates.
* **X509\_V\_ERR\_SELF\_SIGNED\_CERT\_IN\_CHAIN**  
  .IX Item "X509_V_ERR_SELF_SIGNED_CERT_IN_CHAIN"
  The certificate chain could be built up using the untrusted certificates
  but the root could not be found locally.
* **X509\_V\_ERR\_UNABLE\_TO\_GET\_ISSUER\_CERT\_LOCALLY**  
  .IX Item "X509_V_ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY"
  The issuer certificate could not be found: this occurs if the issuer
  certificate of an untrusted certificate cannot be found.
* **X509\_V\_ERR\_UNABLE\_TO\_VERIFY\_LEAF\_SIGNATURE**  
  .IX Item "X509_V_ERR_UNABLE_TO_VERIFY_LEAF_SIGNATURE"
  No signatures could be verified because the chain contains only one
  certificate and it is not self signed.
* **X509\_V\_ERR\_CERT\_CHAIN\_TOO\_LONG**  
  .IX Item "X509_V_ERR_CERT_CHAIN_TOO_LONG"
  The certificate chain length is greater than the supplied maximum
  depth. Unused.
* **X509\_V\_ERR\_CERT\_REVOKED**  
  .IX Item "X509_V_ERR_CERT_REVOKED"
  The certificate has been revoked.
* **X509\_V\_ERR\_INVALID\_CA**  
  .IX Item "X509_V_ERR_INVALID_CA"
  A \s-1CA\s0 certificate is invalid. Either it is not a \s-1CA\s0 or its extensions
  are not consistent with the supplied purpose.
* **X509\_V\_ERR\_PATH\_LENGTH\_EXCEEDED**  
  .IX Item "X509_V_ERR_PATH_LENGTH_EXCEEDED"
  The basicConstraints pathlength parameter has been exceeded.
* **X509\_V\_ERR\_INVALID\_PURPOSE**  
  .IX Item "X509_V_ERR_INVALID_PURPOSE"
  The supplied certificate cannot be used for the specified purpose.
* **X509\_V\_ERR\_CERT\_UNTRUSTED**  
  .IX Item "X509_V_ERR_CERT_UNTRUSTED"
  The root \s-1CA\s0 is not marked as trusted for the specified purpose.
* **X509\_V\_ERR\_CERT\_REJECTED**  
  .IX Item "X509_V_ERR_CERT_REJECTED"
  The root \s-1CA\s0 is marked to reject the specified purpose.
* **X509\_V\_ERR\_SUBJECT\_ISSUER\_MISMATCH**  
  .IX Item "X509_V_ERR_SUBJECT_ISSUER_MISMATCH"
  Not used as of OpenSSL 1.1.0 as a result of the deprecation of the
  **-issuer\_checks** option.
* **X509\_V\_ERR\_AKID\_SKID\_MISMATCH**  
  .IX Item "X509_V_ERR_AKID_SKID_MISMATCH"
  Not used as of OpenSSL 1.1.0 as a result of the deprecation of the
  **-issuer\_checks** option.
* **X509\_V\_ERR\_AKID\_ISSUER\_SERIAL\_MISMATCH**  
  .IX Item "X509_V_ERR_AKID_ISSUER_SERIAL_MISMATCH"
  Not used as of OpenSSL 1.1.0 as a result of the deprecation of the
  **-issuer\_checks** option.
* **X509\_V\_ERR\_KEYUSAGE\_NO\_CERTSIGN**  
  .IX Item "X509_V_ERR_KEYUSAGE_NO_CERTSIGN"
  Not used as of OpenSSL 1.1.0 as a result of the deprecation of the
  **-issuer\_checks** option.
* **X509\_V\_ERR\_UNABLE\_TO\_GET\_CRL\_ISSUER**  
  .IX Item "X509_V_ERR_UNABLE_TO_GET_CRL_ISSUER"
  Unable to get \s-1CRL\s0 issuer certificate.
* **X509\_V\_ERR\_UNHANDLED\_CRITICAL\_EXTENSION**  
  .IX Item "X509_V_ERR_UNHANDLED_CRITICAL_EXTENSION"
  Unhandled critical extension.
* **X509\_V\_ERR\_KEYUSAGE\_NO\_CRL\_SIGN**  
  .IX Item "X509_V_ERR_KEYUSAGE_NO_CRL_SIGN"
  Key usage does not include \s-1CRL\s0 signing.
* **X509\_V\_ERR\_UNHANDLED\_CRITICAL\_CRL\_EXTENSION**  
  .IX Item "X509_V_ERR_UNHANDLED_CRITICAL_CRL_EXTENSION"
  Unhandled critical \s-1CRL\s0 extension.
* **X509\_V\_ERR\_INVALID\_NON\_CA**  
  .IX Item "X509_V_ERR_INVALID_NON_CA"
  Invalid non-CA certificate has \s-1CA\s0 markings.
* **X509\_V\_ERR\_PROXY\_PATH\_LENGTH\_EXCEEDED**  
  .IX Item "X509_V_ERR_PROXY_PATH_LENGTH_EXCEEDED"
  Proxy path length constraint exceeded.
* **X509\_V\_ERR\_PROXY\_SUBJECT\_INVALID**  
  .IX Item "X509_V_ERR_PROXY_SUBJECT_INVALID"
  Proxy certificate subject is invalid.  It \s-1MUST\s0 be the same as the issuer
  with a single \s-1CN\s0 component added.
* **X509\_V\_ERR\_KEYUSAGE\_NO\_DIGITAL\_SIGNATURE**  
  .IX Item "X509_V_ERR_KEYUSAGE_NO_DIGITAL_SIGNATURE"
  Key usage does not include digital signature.
* **X509\_V\_ERR\_PROXY\_CERTIFICATES\_NOT\_ALLOWED**  
  .IX Item "X509_V_ERR_PROXY_CERTIFICATES_NOT_ALLOWED"
  Proxy certificates not allowed, please use **-allow\_proxy\_certs**.
* **X509\_V\_ERR\_INVALID\_EXTENSION**  
  .IX Item "X509_V_ERR_INVALID_EXTENSION"
  Invalid or inconsistent certificate extension.
* **X509\_V\_ERR\_INVALID\_POLICY\_EXTENSION**  
  .IX Item "X509_V_ERR_INVALID_POLICY_EXTENSION"
  Invalid or inconsistent certificate policy extension.
* **X509\_V\_ERR\_NO\_EXPLICIT\_POLICY**  
  .IX Item "X509_V_ERR_NO_EXPLICIT_POLICY"
  No explicit policy.
* **X509\_V\_ERR\_DIFFERENT\_CRL\_SCOPE**  
  .IX Item "X509_V_ERR_DIFFERENT_CRL_SCOPE"
  Different \s-1CRL\s0 scope.
* **X509\_V\_ERR\_UNSUPPORTED\_EXTENSION\_FEATURE**  
  .IX Item "X509_V_ERR_UNSUPPORTED_EXTENSION_FEATURE"
  Unsupported extension feature.
* **X509\_V\_ERR\_UNNESTED\_RESOURCE**  
  .IX Item "X509_V_ERR_UNNESTED_RESOURCE"
  \s-1RFC 3779\s0 resource not subset of parent's resources.
* **X509\_V\_ERR\_PERMITTED\_VIOLATION**  
  .IX Item "X509_V_ERR_PERMITTED_VIOLATION"
  Permitted subtree violation.
* **X509\_V\_ERR\_EXCLUDED\_VIOLATION**  
  .IX Item "X509_V_ERR_EXCLUDED_VIOLATION"
  Excluded subtree violation.
* **X509\_V\_ERR\_SUBTREE\_MINMAX**  
  .IX Item "X509_V_ERR_SUBTREE_MINMAX"
  Name constraints minimum and maximum not supported.
* **X509\_V\_ERR\_APPLICATION\_VERIFICATION**  
  .IX Item "X509_V_ERR_APPLICATION_VERIFICATION"
  Application verification failure. Unused.
* **X509\_V\_ERR\_UNSUPPORTED\_CONSTRAINT\_TYPE**  
  .IX Item "X509_V_ERR_UNSUPPORTED_CONSTRAINT_TYPE"
  Unsupported name constraint type.
* **X509\_V\_ERR\_UNSUPPORTED\_CONSTRAINT\_SYNTAX**  
  .IX Item "X509_V_ERR_UNSUPPORTED_CONSTRAINT_SYNTAX"
  Unsupported or invalid name constraint syntax.
* **X509\_V\_ERR\_UNSUPPORTED\_NAME\_SYNTAX**  
  .IX Item "X509_V_ERR_UNSUPPORTED_NAME_SYNTAX"
  Unsupported or invalid name syntax.
* **X509\_V\_ERR\_CRL\_PATH\_VALIDATION\_ERROR**  
  .IX Item "X509_V_ERR_CRL_PATH_VALIDATION_ERROR"
  \s-1CRL\s0 path validation error.
* **X509\_V\_ERR\_PATH\_LOOP**  
  .IX Item "X509_V_ERR_PATH_LOOP"
  Path loop.
* **X509\_V\_ERR\_SUITE\_B\_INVALID\_VERSION**  
  .IX Item "X509_V_ERR_SUITE_B_INVALID_VERSION"
  Suite B: certificate version invalid.
* **X509\_V\_ERR\_SUITE\_B\_INVALID\_ALGORITHM**  
  .IX Item "X509_V_ERR_SUITE_B_INVALID_ALGORITHM"
  Suite B: invalid public key algorithm.
* **X509\_V\_ERR\_SUITE\_B\_INVALID\_CURVE**  
  .IX Item "X509_V_ERR_SUITE_B_INVALID_CURVE"
  Suite B: invalid \s-1ECC\s0 curve.
* **X509\_V\_ERR\_SUITE\_B\_INVALID\_SIGNATURE\_ALGORITHM**  
  .IX Item "X509_V_ERR_SUITE_B_INVALID_SIGNATURE_ALGORITHM"
  Suite B: invalid signature algorithm.
* **X509\_V\_ERR\_SUITE\_B\_LOS\_NOT\_ALLOWED**  
  .IX Item "X509_V_ERR_SUITE_B_LOS_NOT_ALLOWED"
  Suite B: curve not allowed for this \s-1LOS.\s0
* **X509\_V\_ERR\_SUITE\_B\_CANNOT\_SIGN\_P\_384\_WITH\_P\_256**  
  .IX Item "X509_V_ERR_SUITE_B_CANNOT_SIGN_P_384_WITH_P_256"
  Suite B: cannot sign P-384 with P-256.
* **X509\_V\_ERR\_HOSTNAME\_MISMATCH**  
  .IX Item "X509_V_ERR_HOSTNAME_MISMATCH"
  Hostname mismatch.
* **X509\_V\_ERR\_EMAIL\_MISMATCH**  
  .IX Item "X509_V_ERR_EMAIL_MISMATCH"
  Email address mismatch.
* **X509\_V\_ERR\_IP\_ADDRESS\_MISMATCH**  
  .IX Item "X509_V_ERR_IP_ADDRESS_MISMATCH"
  \s-1IP\s0 address mismatch.
* **X509\_V\_ERR\_DANE\_NO\_MATCH**  
  .IX Item "X509_V_ERR_DANE_NO_MATCH"
  \s-1DANE TLSA\s0 authentication is enabled, but no \s-1TLSA\s0 records matched the
  certificate chain.
  This error is only possible in **s\_client**\|(1).
* **X509\_V\_ERR\_EE\_KEY\_TOO\_SMALL**  
  .IX Item "X509_V_ERR_EE_KEY_TOO_SMALL"
  \s-1EE\s0 certificate key too weak.
* **X509\_ERR\_CA\_KEY\_TOO\_SMALL**  
  .IX Item "X509_ERR_CA_KEY_TOO_SMALL"
  \s-1CA\s0 certificate key too weak.
* **X509\_ERR\_CA\_MD\_TOO\_WEAK**  
  .IX Item "X509_ERR_CA_MD_TOO_WEAK"
  \s-1CA\s0 signature digest algorithm too weak.
* **X509\_V\_ERR\_INVALID\_CALL**  
  .IX Item "X509_V_ERR_INVALID_CALL"
  nvalid certificate verification context.
* **X509\_V\_ERR\_STORE\_LOOKUP**  
  .IX Item "X509_V_ERR_STORE_LOOKUP"
  Issuer certificate lookup error.
* **X509\_V\_ERR\_NO\_VALID\_SCTS**  
  .IX Item "X509_V_ERR_NO_VALID_SCTS"
  Certificate Transparency required, but no valid SCTs found.
* **X509\_V\_ERR\_PROXY\_SUBJECT\_NAME\_VIOLATION**  
  .IX Item "X509_V_ERR_PROXY_SUBJECT_NAME_VIOLATION"
  Proxy subject name violation.
* **X509\_V\_ERR\_OCSP\_VERIFY\_NEEDED**  
  .IX Item "X509_V_ERR_OCSP_VERIFY_NEEDED"
  Returned by the verify callback to indicate an \s-1OCSP\s0 verification is needed.
* **X509\_V\_ERR\_OCSP\_VERIFY\_FAILED**  
  .IX Item "X509_V_ERR_OCSP_VERIFY_FAILED"
  Returned by the verify callback to indicate \s-1OCSP\s0 verification failed.
* **X509\_V\_ERR\_OCSP\_CERT\_UNKNOWN**  
  .IX Item "X509_V_ERR_OCSP_CERT_UNKNOWN"
  Returned by the verify callback to indicate that the certificate is not recognized
  by the \s-1OCSP\s0 responder.

<a name="bugs"></a>

# Bugs

.IX Header "BUGS"
Although the issuer checks are a considerable improvement over the old
technique they still suffer from limitations in the underlying X509_LOOKUP
\s-1API.\s0 One consequence of this is that trusted certificates with matching
subject name must either appear in a file (as specified by the **-CAfile**
option) or a directory (as specified by **-CApath**). If they occur in
both then only the certificates in the file will be recognised.

Previous versions of OpenSSL assume certificates with matching subject
name are identical and mishandled them.

Previous versions of this documentation swapped the meaning of the
**X509\_V\_ERR\_UNABLE\_TO\_GET\_ISSUER\_CERT** and
**X509\_V\_ERR\_UNABLE\_TO\_GET\_ISSUER\_CERT\_LOCALLY** error codes.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**x509**\|(1)

<a name="history"></a>

# History

.IX Header "HISTORY"
The **-show\_chain** option was added in OpenSSL 1.1.0.

The **-issuer\_checks** option is deprecated as of OpenSSL 1.1.0 and
is silently ignored.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2020 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
