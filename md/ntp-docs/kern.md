### Kernel Model for Precision Timekeeping

![gif](pic/alice61.gif)[from _Pogo_, Walt Kelly](http://www.eecis.udel.edu/~mills/pictures.html)

Alice finds the kernel a house of cards.

Last update:
10-Mar-2014 05:10
UTC

#### Related Links

* * *

The technical report [2], which is a revision and update of an earlier report [3], describes an engineering model for a precision clock discipline function for a generic operating system. The model is the same hybrid phase/frequecy-lock feedback loop used by ntpd, but implemented in the kernel. The code described in [2] is included in Solaris and Digital/Compaq/HP Tru64. It provides two system calls ntp\_gettime() and ntp\_adjtime() and can discipline the system clock with microsecond resolution. However, newer hardware and kernels with the same system calls can discipline the clock with nanosecond resolution. The new code described in [1] is in FreeBSD, Linux and Tru64. The software and documentation, including a simulator used to verify correct behavior, but not involving licensed code, is available in the [nanokernel.tar.gz](ftp://ftp.udel.edu/pub/ntp/software/nanokernel.tar.gz) distribution

Ordinarily, the kernel clock discipline function is used with the NTP daemon, but could be used for other purposes. The [ntptime](ntptime.html) utility program can be used to control it manually.

The kernel model also provides support for an external precision timing source, such as described in the [Pulse-per-second (PPS) Signal Interfacing](pps.html) page. The new system calls are used by the [PPSAPI interface](kernpps.html) and in turn by the [PPS Clock Discipline](drivers/driver22.html) driver (type 22) to provide synchronization limited in principle only by the accuracy and stability of the external timing source. Typical results with the PPS signal from a GPS receiver and a modern computer are in the 3 μs range.

#### References

1. Mills, D.L., and P.-H. Kamp. The nanokernel._Proc. Precision Time and Time Interval (PTTI) Applications and Planning Meeting_ (Reston VA, November 2000). Paper: [PostScript](http://www.eecis.udel.edu/%7emills/database/papers/nano/nano2.ps) \| [PDF](http://www.eecis.udel.edu/%7emills/database/papers/nano/nano2.pdf), Slides: [HTML](http://www.eecis.udel.edu/%7emills/database/brief/nano/nano.html) \| [PostScript](http://www.eecis.udel.edu/%7emills/database/brief/nano/nano.ps) \| [PDF](http://www.eecis.udel.edu/%7emills/database/brief/nano/nano.pdf) \| [PowerPoint](http://www.eecis.udel.edu/%7emills/database/brief/nano/nano.ppt)
2. Mills, D.L. Unix kernel modifications for precision time synchronization. Electrical Engineering Department Report 94-10-1, University of Delaware, October 1994, 24 pp. Abstract:[PostScript](http://www.eecis.udel.edu/%7emills/database/reports/kern/kerna.ps) \| [PDF](http://www.eecis.udel.edu/%7emills/database/reports/kern/kerna.pdf), Body: [PostScript](http://www.eecis.udel.edu/%7emills/database/reports/kern/kernb.ps) \| [PDF](http://www.eecis.udel.edu/%7emills/database/reports/kern/kernb.pdf)
3. Mills, D.L. A kernel model for precision timekeeping. Network Working Group Report RFC-1589, University of Delaware, March 1994. 31 pp.[ASCII](http://www.eecis.udel.edu/%7emills/database/rfc/rfc1589.txt)

* * *

