# ip\-monitor(8) - state monitoring

iproute2, 13 Dec 2012

```

 .in +8 .ti -8 ip monitor [ all | OBJECT-LIST ] [ file FILENAME  ] [ label ] [ all-nsid ] [ dev DEVICE  ] 

```


<a name="options"></a>

# Options



* **-t**,** -timestamp**  
  Prints timestamp before the event message on the separated line in format:
      Timestamp: &lt;Day&gt; &lt;Month&gt; &lt;DD&gt; &lt;hh:mm:ss&gt; &lt;YYYY&gt; &lt;usecs&gt; usec
      &lt;EVENT&gt;
  
* **-ts**,** -tshort**  
  Prints short timestamp before the event message on the same line in format:
      [&lt;YYYY&gt;-&lt;MM&gt;-&lt;DD&gt;T&lt;hh:mm:ss&gt;.&lt;ms&gt;] &lt;EVENT&gt;
  

<a name="description"></a>

# Description

The
**ip**
utility can monitor the state of devices, addresses
and routes continuously. This option has a slightly different format.
Namely, the
**monitor**
command is the first in the command line and then the object list follows:

**ip monitor** [ **all** |
_OBJECT-LIST_ ] [
**file**_ FILENAME _
] [
**label**
] [
**all-nsid**
] [
**dev**_ DEVICE _
]

_OBJECT-LIST_
is the list of object types that we want to monitor.
It may contain
**link**, **address**, **route**, **mroute**, **prefix**, 
**neigh**, **netconf**, **rule** and **nsid**.
If no
**file**
argument is given,
**ip**
opens RTNETLINK, listens on it and dumps state changes in the format
described in previous sections.


If the
**label**
option is set, a prefix is displayed before each message to
show the family of the message. For example:

.in +2
[NEIGH]10.16.0.112 dev eth0 lladdr 00:04:23:df:2f:d0 REACHABLE
[LINK]3: eth1: &lt;BROADCAST,MULTICAST&gt; mtu 1500 qdisc pfifo_fast state DOWN group default
    link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
.in -2



If the
**all-nsid**
option is set, the program listens to all network namespaces that have a
nsid assigned into the network namespace were the program is running.
A prefix is displayed to show the network namespace where the message
originates. Example:

.in +2
[nsid 0]10.16.0.112 dev eth0 lladdr 00:04:23:df:2f:d0 REACHABLE
.in -2



If the
**file**
option is given, the program does not listen on RTNETLINK,
but opens the given file, and dumps its contents. The file
should contain RTNETLINK messages saved in binary format.
Such a file can be generated with the
**rtmon**
utility. This utility has a command line syntax similar to
**ip monitor**.
Ideally,
**rtmon**
should be started before the first network configuration command
is issued. F.e. if you insert:

.in +8
rtmon file /var/log/rtmon.log
.in -8

in a startup script, you will be able to view the full history
later.


Nevertheless, it is possible to start
**rtmon**
at any time.
It prepends the history with the state snapshot dumped at the moment
of starting.


If the
**dev**
option is given, the program prints only events related to this device.


<a name="see-also"></a>

# See Also
  
**ip**(8)


<a name="author"></a>

# Author

Original Manpage by Michail Litvak &lt;[mci@owl.openwall](mailto:mci@owl.openwall).com&gt;  
Manpage revised by Nicolas Dichtel &lt;[nicolas.dichtel@6wind.com](mailto:nicolas.dichtel@6wind.com)&gt;
