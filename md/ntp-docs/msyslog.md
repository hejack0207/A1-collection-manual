### ntpd System Log Messages

![gif](pic/flatheads.gif) [from _Alice's Adventures in Wonderland_, Lewis Carroll](http://www.eecis.udel.edu/~mills/pictures.html)

The log can be shrill at times.

Last update:
10-Mar-2014 05:12
UTC

#### Related Links

* * *

You have come here because you found a cryptic message in the system log. This page by no means lists all messages that might be found, since new ones come and old ones go. Generally, however, the most common ones will be found here. They are listed by program module and log severity code in bold: **LOG\_ERR**, **LOG\_NOTICE** and **LOG\_INFO**.

Most of the time **LOG\_ERR** messages are fatal, but often ntpd limps onward in the hopes of discovering more errors. The **LOG\_NOTICE** messages usually mean the time has changed or some other condition that probably should be noticed. The **LOG\_INFO** messages usually say something about the system operations, but do not affect the time.

In the following a '?' character stands for text in the message. The meaning should be clear from context.

#### Protocol Module

**LOG\_ERR**

buffer overflow ? Fatal error. An input packet is too long for processing.

**LOG\_NOTICE**

no reply; clock not setIn ntpdate mode no servers have been found. The server(s) and/or network may be down. Standard debugging procedures apply.

**LOG\_INFO**

proto\_config: illegal item ?, value ?Program error. Bugs can be reported [here](bugs.html).receive: autokey requires two-way communicationConfiguration error on the broadcastclient command.receive: server _server_ maaximum rate exceededA kiss-o'death packet has been received. The transmit rate is automatically reduced.pps sync enabledThe PPS signal has been detected and enabled.transmit: encryption key ? not foundThe encryption key is not defined or not trusted.precision = ? usec This reports the precision measured for this machine.using 10ms tick adjustmentsGotcha for some machines with dirty rotten clock hardware.no servers reachableThe system clock is running on internal batteries. The server(s) and/or network may be down.

#### Clock Discipline Module

**LOG\_ERR**

time correction of ? seconds exceeds sanity limit (?); set clock manually to the correct UTC time.Fatal error. Better do what it says, then restart the daemon. Be advised NTP and Unix know nothing about local time zones. The clock must be set to Coordinated Universal Time (UTC). Believe it; by international agreement abbreviations are in French and descriptions are in English.sigaction() fails to save SIGSYS trap: ?

sigaction() fails to restore SIGSYS trap: ?Program error. Bugs can be reported [here](bugs.html).

**LOG\_NOTICE**

frequency error ? exceeds tolerance 500 PPMThe hardware clock frequency error exceeds the rate the kernel can correct. This could be a hardware or a kernel problem.time slew ? sThe time error exceeds the step threshold and is being slewed to the correct time. You may have to wait a very long time.time reset ? sThe time error exceeds the step threshold and has been reset to the correct time. Computer scientists don't like this, but they can set the ntpd -x option and wait forever.kernel time sync disabled ?The kernel reports an error. See the codes in the timex.h file.pps sync disabledThe PPS signal has died, probably due to a dead radio, broken wire or loose connector.

**LOG\_INFO**

kernel time sync status ? For information only. See the codes in the timex.h file.

#### Cryptographic Module

**LOG\_ERR**

cert\_parse ?

cert\_sign ?

crypto\_cert ?

crypto\_encrypt ?

crypto\_gq ?

crypto\_iff ?

crypto\_key ?

crypto\_mv ?

crypto\_setup ?

make\_keys ?Usually fatal errors. These messages display error codes returned from the OpenSSL library. See the OpenSSL documentation for explanation.crypto\_setup: certificate ? is trusted, but not self signed.

crypto\_setup: certificate ? not for this host

crypto\_setup: certificate file ? not found or corrupt

crypto\_setup: host key file ? not found or corrupt

crypto\_setup: host key is not RSA key type

crypto\_setup: random seed file ? not found

rypto\_setup: random seed file not specifiedFatal errors. These messages show problems during the initialization procedure.

**LOG\_INFO**

cert\_parse: expired ?

cert\_parse: invalid issuer ?

cert\_parse: invalid signature ?

cert\_parse: invalid subject ?There is a problem with a certificate. Operation cannot proceed untill the problem is fixed. If the certificate is local, it can be regenerated using the ntp-keygen program. If it is held somewhere else, it must be fixed by the holder.crypto\_?: defective key

crypto\_?: invalid filestamp

crypto\_?: missing challenge

crypto\_?: scheme unavailableThere is a problem with the identity scheme. Operation cannot proceed untill the problem is fixed. Usually errors are due to misconfiguration or an orphan association. If the latter, ntpd will usually time out and recover by itself.crypto\_cert: wrong PEM type ?The certificate does not have MIME type CERTIFICATE. You are probably using the wrong type from OpenSSL or an external certificate authority.crypto\_ident: no compatible identity scheme foundConfiguration error. The server and client identity schemes are incompatible.crypto\_tai: kernel TAI update failedThe kernel does not support this function. You may need a new kernel or patch.crypto\_tai: leapseconds file ? error ?The leapseconds file is corrupt. Obtain the latest file from time.nist.gov.

* * *

