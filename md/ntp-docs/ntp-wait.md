### ntp-wait \- waits until ntpd is in synchronized state

Last update:
12-Jul-2011 22:03
UTC

* * *

#### Synopsis

ntp-wait [ -v ] [ -n _tries_ ] [ -s _seconds_ ]

#### Description

The ntp-wait program blocks until ntpd is in synchronized state.
This can be useful at boot time, to delay the boot sequence
until after "ntpd -g" has set the time.


#### Command Line Options

-n _tries_Number of tries before giving up. The default is 1000.
 -s _seconds_Seconds to sleep between tries. The default is 6 seconds.
 -vBe verbose.

