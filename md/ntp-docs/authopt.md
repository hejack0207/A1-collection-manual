### Authentication Commands and Options

![gif](pic/alice44.gif) [from _Alice's Adventures in Wonderland_, Lewis Carroll](http://www.eecis.udel.edu/%7emills/pictures.html)

Our resident cryptographer; now you see him, now you don't.

Last update:
24-Jul-2018 07:27
UTC

#### Related Links

* * *

#### Commands and Options

Unless noted otherwise, further information about these commands is on the [Authentication Support](authentic.html) page.

automax [ _logsec_]Specifies the interval between regenerations of the session key list used with the Autokey protocol, as a power of 2 in seconds. Note that the size of the key list for each association depends on this interval and the current poll interval. The default interval is 12 (about 1.1 hr). For poll intervals above the specified interval, a session key list with a single entry will be regenerated for every message sent. See the [Autokey Public Key Authentication](autokey.html) page for further information.controlkey _keyid_Specifies the key ID for the [ntpq](ntpq.html) utility, which uses the
 standard protocol defined in RFC-1305. The _keyid_ argument is the key ID for a [trusted\
 key](#trustedkey), where the value can be in the range 1 to 65535,
 inclusive.crypto [digest _digest_] [host _name_] [ident _name_] [pw _password_] [randfile _file_]This command activates the Autokey public key cryptography
 and loads the required host keys and certificate. If one or more files
 are unspecified, the default names are used. Unless
 the complete path and name of the file are specified, the location of a file
 is relative to the keys directory specified in the keysdir configuration
 command with default /usr/local/etc. See the [Autokey Public Key Authentication](autokey.html) page for further information. Following are the options.digest _digest_Specify the message digest algorithm, with default MD5. If the OpenSSL library
 is installed, _digest_ can be be any message digest algorithm supported
 by the library. The current selections are: MD2, MD4, MD5,MDC2, RIPEMD160, SHA and SHA1. All
 participants in an Autokey subnet must use the same algorithm. The Autokey message digest algorithm is separate and distinct from the symmetric
 key message digest algorithm. Note: If compliance with FIPS 140-2 is required,
 the algorithm must be ether SHA or SHA1.host _name_Specify the cryptographic media names for the host, sign and certificate files. If this option is not specified, the default name is the string returned by the Unix gethostname() routine.Note: In the latest Autokey version, this option has no effect other than to change the cryptographic media file names.ident _group_Specify the cryptographic media names for the identity scheme files. If this option is not specified, the default name is the string returned by the Unix gethostname() routine.Note: In the latest Autokey version, this option has no effect other than to change the cryptographic media file names.pw _password_Specifies the password to decrypt files previously encrypted by the ntp-keygen program with the -p option. If this option is not specified, the default password is the string returned by the Unix gethostname() routine.randfile _file_Specifies the location of the random seed file used by the OpenSSL library. The defaults are described on the [ntp-keygen page](keygen.html).ident _group_Specifies the group name for ephemeral associations mobilized by broadcast and symmetric passive modes. See the [Autokey Public-Key Authentication](autokey.html) page for further information.keys _path_Specifies the complete directory path for the key file containing the key IDs, key types and keys used by ntpd, ntpq and ntpdc when operating with symmetric key cryptography. The format of the keyfile is described on the [ntp-keygen page](keygen.html). This is the same operation as the -k command line option. Note that the directory path for Autokey cryptographic media is specified by the keysdir command.keysdir _path_Specifies the complete directory path for the Autokey cryptographic keys, parameters and certificates. The default is /usr/local/etc/. Note that the path for the symmetric keys file is specified by the keys command.requestkey _keyid_Specifies the key ID for the [ntpdc](ntpdc.html) utility program, which
 uses a proprietary protocol specific to this implementation of ntpd. The _keyid_ argument is a key ID
 for a [trusted key](#trustedkey), in the range 1 to
 65535, inclusive.revoke [ _logsec_]Specifies the interval between re-randomization of certain cryptographic values used by the Autokey scheme, as a power of 2 in seconds, with default 17 (36 hr). See the [Autokey Public-Key Authentication](autokey.html) page for further information.trustedkey [ _keyid_ \| ( _lowid_ ... _highid_)] [...]Specifies the key ID(s) which are trusted for the purposes of
 authenticating peers with symmetric key cryptography. Key IDs
 used to authenticate ntpq and ntpdc operations
 must be listed here and additionally be enabled with [controlkey](#controlkey) and/or [requestkey](#requestkey). The authentication
 procedure for time transfer requires that both the local and
 remote NTP servers employ the same key ID and secret for this
 purpose, although different keys IDs may be used with different
 servers. Ranges of trusted key IDs may be specified: trustedkey (1 ... 19) 1000 (100 ... 199) enables the
 lowest 120 key IDs which start with the digit 1. The spaces
 surrounding the ellipsis are required when specifying a range.

* * *

