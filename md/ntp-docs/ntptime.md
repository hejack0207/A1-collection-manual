### ntptime \- read and set kernel time variables

![gif](pic/pogo5.gif) [from _Pogo_, Walt Kelly](http://www.eecis.udel.edu/~mills/pictures.html)

The turtle has been swimming in the kernel.

Last update:
11-Sep-2010 05:55
UTC

* * *

#### Synopsis

ntptime [ -chr ] [ -e _est\_error_ ] [ -f _frequency_ ] [ -m _max\_error_ ] [ -o _offset_ ] [ -s _status_ ] [ -t _time\_constant_]

#### Description

This program is useful only with special kernels described in the [A Kernel Model for Precision Timekeeping](kern.html) page. It reads and displays time-related kernel variables using the ntp\_gettime() system call. A similar display can be obtained using the ntpdc program and kerninfo command.

#### Options

-cDisplay the execution time of ntptime itself.-e _est\_error_Specify estimated error, in microseconds.-f _frequency_Specify frequency offset, in parts per million.-hDisplay help information.-m _max\_error_Specify max possible errors, in microseconds.-o _offset_Specify clock offset, in microseconds.-rDisplay Unix and NTP times in raw format.-s _status_Specify clock status. Better know what you are doing.-t _time\_constant_Specify time constant, an integer in the range 0-10.

* * *

