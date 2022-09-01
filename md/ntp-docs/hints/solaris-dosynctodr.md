![Home * Buy * My Sun(sm)](/images/homebuy.gif)![sun.com Global Sections](/images/globalnavbar.gif)[![Sun Microsystems](/images/sunlogo.gif)](http://www.sun.com/)![](/images/titlebar/doc.title.gif)![Search SunSolve](/images/search/contract/search1.gif)

![](/images/cg_clear.gif)

[![Advanced Search](/images/search/contract/search3.gif)](search.pl?mode=advanced)

[![Product Search](/images/search/contract/search4.gif)](search.pl?mode=product)

[![Search Tips](/images/search/contract/search6.gif)](show.pl?target=help/search_tips)![](/images/search/contract/search2.gif)![](/images/home_con/welcom_1.gif)![](/images/home_con/welcom_2.gif)sopko[![Edit](/images/home_con/welcom_3.gif)](edit-user-form.pl?viewmode=contractuser)![Contents Of SunSolve](/images/ssolvecontents.gif)

[![All Public Patches](/images/nav/p1.gif)](show.pl?target=patches/patch-access)

[![Submit a Service Order](/images/nav/p5.gif)](suncourier.pl)

[![Diagnostic Tools](/images/nav/p4.gif)](show.pl?target=resources/tools)

[![Support Docs.](/images/nav/cp2.gif)](show.pl?target=help/collections)

[![Y2K Central](/images/nav/p3.gif)](show.pl?target=resources/y2k)

[![Security Information](/images/nav/p2.gif)](show.pl?target=security/sec)

![------](/images/line.gif)

[Marked Docs.](mark.pl)

[Notifications](notify.pl)

[Low Graphics](/plain-cgi/show.pl?target=home_con)

[SunSolve Servers](show.pl?target=link)

[About SunSolve](show.pl?target=about_sunsolve)

[Contact Us](feedback.pl)

[Site Map](show.pl?target=help/sitemap)

[Articles](show.pl?target=article/article)

[Home](show.pl?target=home_con)

[Help](show.pl?target=help/faq)

[ [Printer Friendly Page](retrieve.pl?type=0&doc=srdb%2F19195&display=plain) ]
[ **Was this document useful? [Yes](retrieve.pl?type=0&doc=srdb/19195&vote=yes) or [No](retrieve.pl?type=0&doc=srdb/19195&vote=no)** ]

[ [Notify if Document Changes](notify.pl?action=add&doc=srdb%2F19195&type=synopsis) ]
[ [Mark Document for Download](mark.pl?action=add&doc=srdb%2F19195&type=0) ]

[ [View/Edit Notifications](notify.pl) ]
[ [View/Edit Marked Documents](mark.pl) ]

Jump to HardwareProductProduct AreaSynopsisProblem DescriptionDocument ContentProblem SolutionSRDB IDOS

**SRDB ID****Synopsis****Date****19195****Upgraded to 2.6, using xntpd, but the system clock is drifting. Worked fine****4 Sep 1999**

**Problem Description****[Top](#top)**

```
Ever since upgrading to Solaris 2.6, the system clock has been drifting and
there are messages like 'synchronisation lost', 'Previous time adjustment
didn''t complete' and 'time reset (step)' a lot in the /var/adm/messages
file. The system either was previously working fine with the freeware
xntpd or the configuration was copied from another system that was
using the freeware version.
-- 23-Apr-99 08:22 US/Eastern --
```

**Problem Solution****[Top](#top)**

```
The common lore for setting up xntpd on Solaris using
the freeware version included the warning to set the
kernel variable <font color="red">dosynctodr</font> to 0 in the /etc/system
file thus: set <font color="red">dosynctodr</font>=0

When using NTP on Solaris 2.6 or later, the kernel
variable MUST be left at the default value of 1. Prior
to 2.6 this variable controlled whether or not to rein
in the softclock using the hardware clock, with the result
that NTP and the hardware clock would fight for control of
the soft clock; thus before 2.6 you had to set <font color="red">dosynctodr</font>
to 0. At 2.6, every system call that adjusts the softclock
also sets the hard clock, thus while NTP controls the soft
clock, the hard clock is also controlled. Setting
<font color="red">dosynctodr</font> to 0 reverts the behavior back to the pre 2.6
defaulkt behavior, having exactly the opposite effect
as that intended.

Do not set <font color="red">dosynctodr</font> to 0.
```

**Product Area**Bundled Network**Product**NTP**OS**Solaris 2.6**Hardware**Ultra 2**Document Content**with freeware xntpd.

[Top](#top)

![](/images/cg_grey_line.gif)

![](/images/cg_clear.gif)
 [ [Edit Account](edit-user-form.pl?viewmode=contractuser) ]
 [ [Patches](show.pl?target=patches/patch-access) ]
 [ [Submit a Service Order](suncourier.pl) ]

 [ [Diagnostic Tools](show.pl?target=resources/tools) ]
 [ [Support Docs.](show.pl?target=help/collections) ]
 [ [Y2K Central](show.pl?target=resources/y2k) ]
 [ [Security Information](show.pl?target=security/sec) ]

 [ [SunSolve Servers](show.pl?target=link) ]
 [ [About SunSolve](show.pl?target=about_sunsolve) ]
 [ [Contact Us](feedback.pl) ]
 [ [Site Map](show.pl?target=help/sitemap) ]
 [ [Articles](show.pl?target=article/article) ]
 [ [Home](show.pl?target=home_con) ]
 [ [Help](show.pl?target=help/faq) ]


Copyright 1994-1999 Sun Microsystems, Inc., 901 San Antonio Road, Palo Alto, CA 94303 USA.

All rights reserved.
[Legal Terms](http://www.sun.com/share/text/SMICopyright.html).
[Privacy Policy](http://www.sun.com/privacy/).

