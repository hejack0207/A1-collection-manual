# openssl(1)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

openssl - OpenSSL command line tool

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" openssl command [ command_opts ] [ command_args ] 
 openssl list [ standard-commands | digest-commands | cipher-commands | cipher-algorithms | digest-algorithms | public-key-algorithms] 
 openssl no-\s-1XXX\s0 [ arbitrary options ]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
OpenSSL is a cryptography toolkit implementing the Secure Sockets Layer (\s-1SSL\s0
v2/v3) and Transport Layer Security (\s-1TLS\s0 v1) network protocols and related
cryptography standards required by them.

The **openssl** program is a command line tool for using the various
cryptography functions of OpenSSL's **crypto** library from the shell.
It can be used for

.Vb 8
 o  Creation and management of private keys, public keys and parameters
 o  Public key cryptographic operations
 o  Creation of X.509 certificates, CSRs and CRLs
 o  Calculation of Message Digests
 o  Encryption and Decryption with Ciphers
 o  SSL/TLS Client and Server Tests
 o  Handling of S/MIME signed or encrypted mail
 o  Time Stamp requests, generation and verification
.Ve

<a name="command-summary"></a>

# Command Summary

.IX Header "COMMAND SUMMARY"
The **openssl** program provides a rich variety of commands (_command_ in the
\s-1SYNOPSIS\s0 above), each of which often has a wealth of options and arguments
(_command\_opts_ and _command\_args_ in the \s-1SYNOPSIS\s0).

Detailed documentation and use cases for most standard subcommands are available
(e.g., **x509**\|(1) or **openssl-x509**\|(1)).

Many commands use an external configuration file for some or all of their
arguments and have a **-config** option to specify that file.
The environment variable **\s-1OPENSSL\_CONF\s0** can be used to specify
the location of the file.
If the environment variable is not specified, then the file is named
**openssl.cnf** in the default certificate storage area, whose value
depends on the configuration flags specified when the OpenSSL
was built.

The list parameters **standard-commands**, **digest-commands**,
and **cipher-commands** output a list (one entry per line) of the names
of all standard commands, message digest commands, or cipher commands,
respectively, that are available in the present **openssl** utility.

The list parameters **cipher-algorithms** and
**digest-algorithms** list all cipher and message digest names, one entry per line. Aliases are listed as:

.Vb 1
 from =&gt; to
.Ve

The list parameter **public-key-algorithms** lists all supported public
key algorithms.

The command **no-**_\s-1XXX\s0_ tests whether a command of the
specified name is available.  If no command named _\s-1XXX\s0_ exists, it
returns 0 (success) and prints **no-**_\s-1XXX\s0_; otherwise it returns 1
and prints _\s-1XXX\s0_.  In both cases, the output goes to **stdout** and
nothing is printed to **stderr**.  Additional command line arguments
are always ignored.  Since for each cipher there is a command of the
same name, this provides an easy way for shell scripts to test for the
availability of ciphers in the **openssl** program.  (**no-**_\s-1XXX\s0_ is
not able to detect pseudo-commands such as **quit**,
**list**, or **no-**_\s-1XXX\s0_ itself.)

<a name="standard-commands"></a>

### Standard Commands

.IX Subsection "Standard Commands"

* **asn1parse**  
  .IX Item "asn1parse"
  Parse an \s-1ASN.1\s0 sequence.
* **ca**  
  .IX Item "ca"
  Certificate Authority (\s-1CA\s0) Management.
* **ciphers**  
  .IX Item "ciphers"
  Cipher Suite Description Determination.
* **cms**  
  .IX Item "cms"
  \s-1CMS\s0 (Cryptographic Message Syntax) utility.
* **crl**  
  .IX Item "crl"
  Certificate Revocation List (\s-1CRL\s0) Management.
* **crl2pkcs7**  
  .IX Item "crl2pkcs7"
  \s-1CRL\s0 to PKCS#7 Conversion.
* **dgst**  
  .IX Item "dgst"
  Message Digest Calculation.
* **dh**  
  .IX Item "dh"
  Diffie-Hellman Parameter Management.
  Obsoleted by **dhparam**\|(1).
* **dhparam**  
  .IX Item "dhparam"
  Generation and Management of Diffie-Hellman Parameters. Superseded by
  **genpkey**\|(1) and **pkeyparam**\|(1).
* **dsa**  
  .IX Item "dsa"
  \s-1DSA\s0 Data Management.
* **dsaparam**  
  .IX Item "dsaparam"
  \s-1DSA\s0 Parameter Generation and Management. Superseded by
  **genpkey**\|(1) and **pkeyparam**\|(1).
* **ec**  
  .IX Item "ec"
  \s-1EC\s0 (Elliptic curve) key processing.
* **ecparam**  
  .IX Item "ecparam"
  \s-1EC\s0 parameter manipulation and generation.
* **enc**  
  .IX Item "enc"
  Encoding with Ciphers.
* **engine**  
  .IX Item "engine"
  Engine (loadable module) information and manipulation.
* **errstr**  
  .IX Item "errstr"
  Error Number to Error String Conversion.
* **gendh**  
  .IX Item "gendh"
  Generation of Diffie-Hellman Parameters.
  Obsoleted by **dhparam**\|(1).
* **gendsa**  
  .IX Item "gendsa"
  Generation of \s-1DSA\s0 Private Key from Parameters. Superseded by
  **genpkey**\|(1) and **pkey**\|(1).
* **genpkey**  
  .IX Item "genpkey"
  Generation of Private Key or Parameters.
* **genrsa**  
  .IX Item "genrsa"
  Generation of \s-1RSA\s0 Private Key. Superseded by **genpkey**\|(1).
* **nseq**  
  .IX Item "nseq"
  Create or examine a Netscape certificate sequence.
* **ocsp**  
  .IX Item "ocsp"
  Online Certificate Status Protocol utility.
* **passwd**  
  .IX Item "passwd"
  Generation of hashed passwords.
* **pkcs12**  
  .IX Item "pkcs12"
  PKCS#12 Data Management.
* **pkcs7**  
  .IX Item "pkcs7"
  PKCS#7 Data Management.
* **pkcs8**  
  .IX Item "pkcs8"
  PKCS#8 format private key conversion tool.
* **pkey**  
  .IX Item "pkey"
  Public and private key management.
* **pkeyparam**  
  .IX Item "pkeyparam"
  Public key algorithm parameter management.
* **pkeyutl**  
  .IX Item "pkeyutl"
  Public key algorithm cryptographic operation utility.
* **prime**  
  .IX Item "prime"
  Compute prime numbers.
* **rand**  
  .IX Item "rand"
  Generate pseudo-random bytes.
* **rehash**  
  .IX Item "rehash"
  Create symbolic links to certificate and \s-1CRL\s0 files named by the hash values.
* **req**  
  .IX Item "req"
  PKCS#10 X.509 Certificate Signing Request (\s-1CSR\s0) Management.
* **rsa**  
  .IX Item "rsa"
  \s-1RSA\s0 key management.
* **rsautl**  
  .IX Item "rsautl"
  \s-1RSA\s0 utility for signing, verification, encryption, and decryption. Superseded
  by  **pkeyutl**\|(1).
* **s\_client**  
  .IX Item "s_client"
  This implements a generic \s-1SSL/TLS\s0 client which can establish a transparent
  connection to a remote server speaking \s-1SSL/TLS.\s0 It's intended for testing
  purposes only and provides only rudimentary interface functionality but
  internally uses mostly all functionality of the OpenSSL **ssl** library.
* **s\_server**  
  .IX Item "s_server"
  This implements a generic \s-1SSL/TLS\s0 server which accepts connections from remote
  clients speaking \s-1SSL/TLS.\s0 It's intended for testing purposes only and provides
  only rudimentary interface functionality but internally uses mostly all
  functionality of the OpenSSL **ssl** library.  It provides both an own command
  line oriented protocol for testing \s-1SSL\s0 functions and a simple \s-1HTTP\s0 response
  facility to emulate an SSL/TLS-aware webserver.
* **s\_time**  
  .IX Item "s_time"
  \s-1SSL\s0 Connection Timer.
* **sess\_id**  
  .IX Item "sess_id"
  \s-1SSL\s0 Session Data Management.
* **smime**  
  .IX Item "smime"
  S/MIME mail processing.
* **speed**  
  .IX Item "speed"
  Algorithm Speed Measurement.
* **spkac**  
  .IX Item "spkac"
  \s-1SPKAC\s0 printing and generating utility.
* **srp**  
  .IX Item "srp"
  Maintain \s-1SRP\s0 password file.
* **storeutl**  
  .IX Item "storeutl"
  Utility to list and display certificates, keys, CRLs, etc.
* **ts**  
  .IX Item "ts"
  Time Stamping Authority tool (client/server).
* **verify**  
  .IX Item "verify"
  X.509 Certificate Verification.
* **version**  
  .IX Item "version"
  OpenSSL Version Information.
* **x509**  
  .IX Item "x509"
  X.509 Certificate Data Management.

<a name="message-digest-commands"></a>

### Message Digest Commands

.IX Subsection "Message Digest Commands"

* **blake2b512**  
  .IX Item "blake2b512"
  BLAKE2b-512 Digest
* **blake2s256**  
  .IX Item "blake2s256"
  BLAKE2s-256 Digest
* **md2**  
  .IX Item "md2"
  \s-1MD2\s0 Digest
* **md4**  
  .IX Item "md4"
  \s-1MD4\s0 Digest
* **md5**  
  .IX Item "md5"
  \s-1MD5\s0 Digest
* **mdc2**  
  .IX Item "mdc2"
  \s-1MDC2\s0 Digest
* **rmd160**  
  .IX Item "rmd160"
  \s-1RMD-160\s0 Digest
* **sha1**  
  .IX Item "sha1"
  \s-1SHA-1\s0 Digest
* **sha224**  
  .IX Item "sha224"
  \s-1SHA-2 224\s0 Digest
* **sha256**  
  .IX Item "sha256"
  \s-1SHA-2 256\s0 Digest
* **sha384**  
  .IX Item "sha384"
  \s-1SHA-2 384\s0 Digest
* **sha512**  
  .IX Item "sha512"
  \s-1SHA-2 512\s0 Digest
* **sha3-224**  
  .IX Item "sha3-224"
  \s-1SHA-3 224\s0 Digest
* **sha3-256**  
  .IX Item "sha3-256"
  \s-1SHA-3 256\s0 Digest
* **sha3-384**  
  .IX Item "sha3-384"
  \s-1SHA-3 384\s0 Digest
* **sha3-512**  
  .IX Item "sha3-512"
  \s-1SHA-3 512\s0 Digest
* **shake128**  
  .IX Item "shake128"
  \s-1SHA-3 SHAKE128\s0 Digest
* **shake256**  
  .IX Item "shake256"
  \s-1SHA-3 SHAKE256\s0 Digest
* **sm3**  
  .IX Item "sm3"
  \s-1SM3\s0 Digest

<a name="encoding-and-cipher-commands"></a>

### Encoding and Cipher Commands

.IX Subsection "Encoding and Cipher Commands"
The following aliases provide convenient access to the most used encodings
and ciphers.

Depending on how OpenSSL was configured and built, not all ciphers listed
here may be present. See **enc**\|(1) for more information and command usage.

* **aes128**, **aes-128-cbc**, **aes-128-cfb**, **aes-128-ctr**, **aes-128-ecb**, **aes-128-ofb**  
  .IX Item "aes128, aes-128-cbc, aes-128-cfb, aes-128-ctr, aes-128-ecb, aes-128-ofb"
  \s-1AES-128\s0 Cipher
* **aes192**, **aes-192-cbc**, **aes-192-cfb**, **aes-192-ctr**, **aes-192-ecb**, **aes-192-ofb**  
  .IX Item "aes192, aes-192-cbc, aes-192-cfb, aes-192-ctr, aes-192-ecb, aes-192-ofb"
  \s-1AES-192\s0 Cipher
* **aes256**, **aes-256-cbc**, **aes-256-cfb**, **aes-256-ctr**, **aes-256-ecb**, **aes-256-ofb**  
  .IX Item "aes256, aes-256-cbc, aes-256-cfb, aes-256-ctr, aes-256-ecb, aes-256-ofb"
  \s-1AES-256\s0 Cipher
* **aria128**, **aria-128-cbc**, **aria-128-cfb**, **aria-128-ctr**, **aria-128-ecb**, **aria-128-ofb**  
  .IX Item "aria128, aria-128-cbc, aria-128-cfb, aria-128-ctr, aria-128-ecb, aria-128-ofb"
  Aria-128 Cipher
* **aria192**, **aria-192-cbc**, **aria-192-cfb**, **aria-192-ctr**, **aria-192-ecb**, **aria-192-ofb**  
  .IX Item "aria192, aria-192-cbc, aria-192-cfb, aria-192-ctr, aria-192-ecb, aria-192-ofb"
  Aria-192 Cipher
* **aria256**, **aria-256-cbc**, **aria-256-cfb**, **aria-256-ctr**, **aria-256-ecb**, **aria-256-ofb**  
  .IX Item "aria256, aria-256-cbc, aria-256-cfb, aria-256-ctr, aria-256-ecb, aria-256-ofb"
  Aria-256 Cipher
* **base64**  
  .IX Item "base64"
  Base64 Encoding
* **bf**, **bf-cbc**, **bf-cfb**, **bf-ecb**, **bf-ofb**  
  .IX Item "bf, bf-cbc, bf-cfb, bf-ecb, bf-ofb"
  Blowfish Cipher
* **camellia128**, **camellia-128-cbc**, **camellia-128-cfb**, **camellia-128-ctr**, **camellia-128-ecb**, **camellia-128-ofb**  
  .IX Item "camellia128, camellia-128-cbc, camellia-128-cfb, camellia-128-ctr, camellia-128-ecb, camellia-128-ofb"
  Camellia-128 Cipher
* **camellia192**, **camellia-192-cbc**, **camellia-192-cfb**, **camellia-192-ctr**, **camellia-192-ecb**, **camellia-192-ofb**  
  .IX Item "camellia192, camellia-192-cbc, camellia-192-cfb, camellia-192-ctr, camellia-192-ecb, camellia-192-ofb"
  Camellia-192 Cipher
* **camellia256**, **camellia-256-cbc**, **camellia-256-cfb**, **camellia-256-ctr**, **camellia-256-ecb**, **camellia-256-ofb**  
  .IX Item "camellia256, camellia-256-cbc, camellia-256-cfb, camellia-256-ctr, camellia-256-ecb, camellia-256-ofb"
  Camellia-256 Cipher
* **cast**, **cast-cbc**  
  .IX Item "cast, cast-cbc"
  \s-1CAST\s0 Cipher
* **cast5-cbc**, **cast5-cfb**, **cast5-ecb**, **cast5-ofb**  
  .IX Item "cast5-cbc, cast5-cfb, cast5-ecb, cast5-ofb"
  \s-1CAST5\s0 Cipher
* **chacha20**  
  .IX Item "chacha20"
  Chacha20 Cipher
* **des**, **des-cbc**, **des-cfb**, **des-ecb**, **des-ede**, **des-ede-cbc**, **des-ede-cfb**, **des-ede-ofb**, **des-ofb**  
  .IX Item "des, des-cbc, des-cfb, des-ecb, des-ede, des-ede-cbc, des-ede-cfb, des-ede-ofb, des-ofb"
  \s-1DES\s0 Cipher
* **des3**, **desx**, **des-ede3**, **des-ede3-cbc**, **des-ede3-cfb**, **des-ede3-ofb**  
  .IX Item "des3, desx, des-ede3, des-ede3-cbc, des-ede3-cfb, des-ede3-ofb"
  Triple-DES Cipher
* **idea**, **idea-cbc**, **idea-cfb**, **idea-ecb**, **idea-ofb**  
  .IX Item "idea, idea-cbc, idea-cfb, idea-ecb, idea-ofb"
  \s-1IDEA\s0 Cipher
* **rc2**, **rc2-cbc**, **rc2-cfb**, **rc2-ecb**, **rc2-ofb**  
  .IX Item "rc2, rc2-cbc, rc2-cfb, rc2-ecb, rc2-ofb"
  \s-1RC2\s0 Cipher
* **rc4**  
  .IX Item "rc4"
  \s-1RC4\s0 Cipher
* **rc5**, **rc5-cbc**, **rc5-cfb**, **rc5-ecb**, **rc5-ofb**  
  .IX Item "rc5, rc5-cbc, rc5-cfb, rc5-ecb, rc5-ofb"
  \s-1RC5\s0 Cipher
* **seed**, **seed-cbc**, **seed-cfb**, **seed-ecb**, **seed-ofb**  
  .IX Item "seed, seed-cbc, seed-cfb, seed-ecb, seed-ofb"
  \s-1SEED\s0 Cipher
* **sm4**, **sm4-cbc**, **sm4-cfb**, **sm4-ctr**, **sm4-ecb**, **sm4-ofb**  
  .IX Item "sm4, sm4-cbc, sm4-cfb, sm4-ctr, sm4-ecb, sm4-ofb"
  \s-1SM4\s0 Cipher

<a name="options"></a>

# Options

.IX Header "OPTIONS"
Details of which options are available depend on the specific command.
This section describes some common options with common behavior.

<a name="common-options"></a>

### Common Options

.IX Subsection "Common Options"

* **-help**  
  .IX Item "-help"
  Provides a terse summary of all options.

<a name="pass-phrase-options"></a>

### Pass Phrase Options

.IX Subsection "Pass Phrase Options"
Several commands accept password arguments, typically using **-passin**
and **-passout** for input and output passwords respectively. These allow
the password to be obtained from a variety of sources. Both of these
options take a single argument whose format is described below. If no
password argument is given and a password is required then the user is
prompted to enter one: this will typically be read from the current
terminal with echoing turned off.

Note that character encoding may be relevant, please see
**passphrase-encoding**\|(7).

* **pass:password**  
  .IX Item "pass:password"
  The actual password is **password**. Since the password is visible
  to utilities (like 'ps' under Unix) this form should only be used
  where security is not important.
* **env:var**  
  .IX Item "env:var"
  Obtain the password from the environment variable **var**. Since
  the environment of other processes is visible on certain platforms
  (e.g. ps under certain Unix OSes) this option should be used with caution.
* **file:pathname**  
  .IX Item "file:pathname"
  The first line of **pathname** is the password. If the same **pathname**
  argument is supplied to **-passin** and **-passout** arguments then the first
  line will be used for the input password and the next line for the output
  password. **pathname** need not refer to a regular file: it could for example
  refer to a device or named pipe.
* **fd:number**  
  .IX Item "fd:number"
  Read the password from the file descriptor **number**. This can be used to
  send the data via a pipe for example.
* **stdin**  
  .IX Item "stdin"
  Read the password from standard input.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**asn1parse**\|(1), **ca**\|(1), **ciphers**\|(1), **cms**\|(1), **config**\|(5),
**crl**\|(1), **crl2pkcs7**\|(1), **dgst**\|(1),
**dhparam**\|(1), **dsa**\|(1), **dsaparam**\|(1),
**ec**\|(1), **ecparam**\|(1),
**enc**\|(1), **engine**\|(1), **errstr**\|(1), **gendsa**\|(1), **genpkey**\|(1),
**genrsa**\|(1), **nseq**\|(1), **ocsp**\|(1),
**pkcs12**\|(1), **pkcs7**\|(1), **pkcs8**\|(1),
**pkey**\|(1), **pkeyparam**\|(1), **pkeyutl**\|(1), **prime**\|(1),
**rehash**\|(1), **req**\|(1), **rsa**\|(1),
**rsautl**\|(1), **s\_client**\|(1),
**s\_server**\|(1), **s\_time**\|(1), **sess\_id**\|(1),
**smime**\|(1), **speed**\|(1), **spkac**\|(1), **srp**\|(1), **storeutl**\|(1),
**sslpasswd**\|(1), **sslrand**\|(1),
**ts**\|(1),
**verify**\|(1), **version**\|(1), **x509**\|(1),
**crypto**\|(7), **ssl**\|(7), **x509v3\_config**\|(5)

<a name="history"></a>

# History

.IX Header "HISTORY"
The **list-**_\s-1XXX\s0_**-algorithms** pseudo-commands were added in OpenSSL 1.0.0;
For notes on the availability of other commands, see their individual
manual pages.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2000-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
