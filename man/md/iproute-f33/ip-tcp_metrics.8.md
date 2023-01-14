# ip\-tcp_metrics(8) - management for TCP Metrics

iproute2, 23 Aug 2012

```

 .in +8 .ti -8 ip [ OPTIONS ] tcp_metrics { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 ip tcp_metrics { show | flush} SELECTOR
</synopsis>

<synopsis>
.ti -8 ip tcp_metrics delete [ address ] ADDRESS
</synopsis>

<synopsis>
.ti -8 SELECTOR :=  [ [ address ]  PREFIX ]
```


<a name="description"></a>

# Description

**ip tcp_metrics**
is used to manipulate entries in the kernel that keep TCP information
for IPv4 and IPv6 destinations. The entries are created when
TCP sockets want to share information for destinations and are
stored in a cache keyed by the destination address. The saved
information may include values for metrics (initially obtained from
routes), recent TSVAL for TIME-WAIT recycling purposes, state for the
Fast Open feature, etc.
For performance reasons the cache can not grow above configured limit
and the older entries are replaced with fresh information, sometimes
reclaimed and used for new destinations. The kernel never removes
entries, they can be flushed only with this tool.


<a name="ip-tcp_metrics-show-show-cached-entries"></a>

### ip tcp_metrics show - show cached entries



* **address**_ PREFIX _**(default)**  
  IPv4/IPv6 prefix or address. If no prefix is provided all entries are shown.
  

The output may contain the following information:

**age**_ &lt;S.MMM&gt;_**sec**
- time after the entry was created, reset or updated with metrics
from sockets. The entry is reset and refreshed on use with metrics from
route if the metrics are not updated in last hour. Not all cached values
reset the age on update.

**cwnd**_ &lt;N&gt;_
- CWND metric value

**fo_cookie**_ &lt;HEX-STRING&gt;_
- Cookie value received in SYN-ACK to be used by Fast Open for next SYNs

**fo_mss**_ &lt;N&gt;_
- MSS value received in SYN-ACK to be used by Fast Open for next SYNs

**fo_syn_drops**_ &lt;N&gt;/&lt;S.MMM&gt;_**sec ago**
- Number of drops of initial outgoing Fast Open SYNs with data
detected by monitoring the received SYN-ACK after SYN retransmission.
The seconds show the time after last SYN drop and together with
the drop count can be used to disable Fast Open for some time.

**reordering**_ &lt;N&gt;_
- Reordering metric value

**rtt**_ &lt;N&gt;_**us**
- RTT metric value

**rttvar**_ &lt;N&gt;_**us**
- RTTVAR metric value

**ssthresh**_ &lt;SSTHRESH&gt;_
- SSTHRESH metric value

**tw_ts**_ &lt;TSVAL&gt;/&lt;SEC&gt;_**sec ago**
- recent TSVAL and the seconds after saving it into TIME-WAIT socket


<a name="ip-tcp_metrics-delete-delete-single-entry"></a>

### ip tcp_metrics delete - delete single entry



* **address**_ ADDRESS _**(default)**  
  IPv4/IPv6 address. The address is a required argument.
  

<a name="ip-tcp_metrics-flush-flush-entries"></a>

### ip tcp_metrics flush - flush entries

This command flushes the entries selected by some criteria.


This command has the same arguments as
**show.**


<a name="examples"></a>

# Examples


ip tcp_metrics show address 192.168.0.0/24
Shows the entries for destinations from subnet

ip tcp_metrics show 192.168.0.0/24
The same but address keyword is optional

ip tcp_metrics
Show all is the default action

ip tcp_metrics delete 192.168.0.1
Removes the entry for 192.168.0.1 from cache.

ip tcp_metrics flush 192.168.0.0/24
Removes entries for destinations from subnet

ip tcp_metrics flush all
Removes all entries from cache

ip -6 tcp_metrics flush all
Removes all IPv6 entries from cache keeping the IPv4 entries.


<a name="see-also"></a>

# See Also
  
**ip**(8)


<a name="author"></a>

# Author

Original Manpage by Julian Anastasov &lt;[ja@ssi.bg](mailto:ja@ssi.bg)&gt;
