### The Network Time Protocol (NTP) Distribution

![gif](pic/barnstable.gif) [_P.T. Bridgeport Bear_; from _Pogo_, Walt Kelly](http://www.eecis.udel.edu/%7emills/pictures.html)

Pleased to meet you.

Last update:
31-Mar-2014 05:41

#### Related Links

- A list of all links is on the[Site Map](sitemap.html) page.

#### Table of Contents

- [Introduction](#intro)
- [The Handbook](#hand)
- [Building and Installing NTP](#build)
- [Resolving Problems](#prob)
- [Further Information](#info)

* * *

#### Introduction

Note: The NTP Version 4 software contained in this distribution is available without charge under the conditions set forth in the [Copyright Notice](copyright.html).

It is very important that readers understand that the NTP document collection began 25 years ago and remains today a work in progress. It has evolved as new features were invented and old features retired. It has been widely copied, cached and morphed to other formats, including man pages, with varying loss of fidelity. However, these HTML pages are the ONLY authoritative and definitive reference. Readers should always use the collection that comes with the distribution they use. A copy of the online collection at [www.ntp.org](http://www.ntp.org) is normally included in the most recent snapshot, but might not agree with an earlier snapshot or release version.

This distribution is an implementation of RFC-5905 "Network Time Protocol Version 4: Protocol and Algorithms Specification".

NTP is widely used to synchronize a computer to Internet time servers or other sources, such as a radio or satellite receiver or telephone modem service. It can also be used as a server for dependent clients. It provides accuracies typically less than a millisecond on LANs and up to a few milliseconds on WANs. Typical NTP configurations utilize multiple redundant servers and diverse network paths in order to achieve high accuracy and reliability.

This distribution includes a simulation framework in which substantially all the runtime NTP operations and most features can be tested and evaluated. This has been very useful in exploring in vitro response to unusual circumstances or over time periods impractical in vivo. Details are on the [Network Time Protocol (NTP) Simulator](ntpdsim.html) page.

#### The Handbook

A good deal of tutorial and directive information is available on the handbook pages. These should be read in conjunction with the command and option information available on the pages listed on the sitemap page.

[NTP Version 4 Release Notes](release.html)Lists recent changes and new features in the current distribution.[Association Management](assoc.html)Describes how to configure servers and peers and manage the various options. Includes automatic server discovery schemes.[Automatic Server Discovery Schemes](discover.html)Describes automatic server discovery using broadcast, multicast, manycast and server pool scheme.[Access Control Support](access.html)Describes the access control mechanisms that can be used to limit client access to various time and management functions.[Authentication Support](authentic.html)Describes the authentication mechanisms for symmetric-key and public-key cryptography.[Rate Management](rate.html)Describes the principles of rate management to minimize network load and defend against DoS attacks.[Reference Clock Support](refclock.html)Describes the collection of radio clocks used to synchronize primary servers.[How NTP Works](warp.html)Gives an overview of the NTP daemon architecture and how it works.

#### Building and Installing NTP

NTP supports Unix, VMS and Windows (2000 and later) systems. The [Building and Installing the Distribution](build.html) page details the procedures for building and installing on a typical system. This distribution includes drivers for many radio and satellite receivers and telephone modem services in the US, Canada and Europe. A list of supported drivers is on the [Reference Clock Drivers](refclock.html) page. The default build includes the debugging options and all drivers that run on the target machine; however, options and drivers can be included or excluded using options on the [Configuration Options](config.html) page.

#### Resolving Problems

Like other things in modern Internet life, NTP problems can be devilishly intricate. This distribution includes a number of utilities designed to identify and repair problems using an integrated management protocol supported by the [ntpq](ntpq.html) utility program.

The [NTP Debugging Techniques](debug.html) and [Hints and Kinks](hints.html) pages contain useful information for identifying problems and devising solutions. Additional information on reference clock driver construction and debugging is in the [Debugging Hints for Reference Clock Drivers](rdebug.html) page.

Users are invited to report bugs and offer suggestions via the [NTP Bug Reporting Procedures](bugs.html) page.

#### Further Information

The [Site Map](sitemap.html) page contains a list of document collections arranged by topic. The Program Manual Pages collection may be the best place to start. The [Command Index](comdex.html) collection contains a list of all configuration file commands together with a short function description. A great wealth of additional information is available via the External Links collection, including a book and numerous background papers and briefing presentations.

Background information on computer network time synchronization is on the [Executive Summary - Computer Network Time Synchronization](http://www.eecis.udel.edu/%7emills/exec.html) page. Discussion on new features and interoperability with previous NTP versions is on the [NTP Version 4 Release Notes](release.html) page. Background information, bibliography and briefing slides suitable for presentations are on the [Network Time Synchronization Research Project](http://www.eecis.udel.edu/%7emills/ntp.html) page. Additional information is at the NTP web site [www.ntp.org](http://www.ntp.org).

* * *

![gif](pic/pogo1a.gif)

