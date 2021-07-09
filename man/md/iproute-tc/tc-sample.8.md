# packet sample action in tc(8) - packet sampling tc action

iproute2, 31 Jan 2017

```
.in +8 .ti -8
</synopsis>

<synopsis>
tc ... action sample rate RATE group GROUP [ trunc SIZE ]  [ index INDEX ]  .ti -8
</synopsis>

<synopsis>
tc ... action sample index  INDEX .ti -8
```


<a name="description"></a>

# Description

The
**sample**
action allows sampling packets matching classifier.

The packets are chosen randomly according to the
**rate**
parameter, and are sampled using the
**psample**
generic netlink channel. The user can also specify packet truncation to save
user-kernel traffic. Each sample includes some informative metadata about the
original packet, which is sent using netlink attributes, alongside the original
packet data.

The user can either specify the sample action parameters as presented in the
first form above, or use an existing sample action using its index, as presented
in the second form.


<a name="sampled-packets-metadata-fields"></a>

# Sampled Packets Metadata Fields

The metadata are delivered to userspace applications using the
**psample**
generic netlink channel, where each sample includes the following netlink
attributes:

* **PSAMPLE_ATTR_IIFINDEX**  
  The input interface index of the packet, if there is one.
* **PSAMPLE_ATTR_OIFINDEX**  
  The output interface index of the packet. This field is not relevant on ingress
  sampling
* **PSAMPLE_ATTR_ORIGSIZE**  
  The size of the original packet (before truncation)
* **PSAMPLE_ATTR_SAMPLE_GROUP**  
  The
  **psample**
  group the packet was sent to
* **PSAMPLE_ATTR_GROUP_SEQ**  
  A sequence number of the sampled packet. This number is incremented with each
  sampled packet of the current
  **psample**
  group
* **PSAMPLE_ATTR_SAMPLE_RATE**  
  The rate the packet was sampled with
  

<a name="options"></a>

# Options


* **rate**_ RATE_  
  The packet sample rate.
  _RATE_
  is the expected ratio between observed packets and sampled packets. For example,
  _RATE_
  of 100 will lead to an average of one sampled packet out of every 100 observed.
* **trunc**_ SIZE_  
  Upon set, defines the maximum size of the sampled packets, and causes truncation
  if needed
* **group**_ GROUP_  
  The
  **psample**
  group the packet will be sent to. The
  **psample**
  module defines the concept of groups, which allows the user to match specific
  sampled packets in the case of multiple sampling rules, thus identify only the
  packets that came from a specific rule.
* **index**_ INDEX_  
  Is a unique ID for an action. When creating new action instance, this parameter
  allows to set the new action index. When using existing action, this parameter
  allows to specify the existing action index.  The index must 32bit unsigned
  integer greater than zero.

<a name="examples"></a>

# Examples

Sample one of every 100 packets flowing into interface eth0 to psample group 12:

.EX
tc qdisc add dev eth0 handle ffff: ingress
tc filter add dev eth0 parent ffff: matchall &nbsp;    action sample rate 100 group 12 index 19
.EE

Use the same action instance to sample eth1 too:

.EX
tc qdisc add dev eth1 handle ffff: ingress
tc filter add dev eth1 parent ffff: matchall &nbsp;    action sample index 19
.EE


<a name="see-also"></a>

# See Also

**tc**(8),
**tc-matchall**(8)
**psample**(1)
