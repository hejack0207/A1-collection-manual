# policing action in tc(8) - policing action

iproute2, 20 Jan 2015

```
.in +8 .ti -8 tc ... action police rate RATE burst BYTES[/BYTES] [ mtu BYTES[/BYTES] ] [ peakrate RATE ] [ overhead BYTES ] [ linklayer TYPE ] [ CONTROL ]
</synopsis>

<synopsis>
.ti -8 tc ... filter ... [ estimator SAMPLE AVERAGE ] action police avrate RATE [ CONTROL ]
</synopsis>

<synopsis>
.ti -8 CONTROL := conform-exceed EXCEEDACT[/NOTEXCEEDACT
</synopsis>

<synopsis>
.ti -8 EXCEEDACT/NOTEXCEEDACT := {  pipe | ok | reclassify | drop | continue | goto chain CHAIN_INDEX }
```

<a name="description"></a>

# Description

The
**police**
action allows to limit bandwidth of traffic matched by the filter it is
attached to. Basically there are two different algorithms available to measure
the packet rate: The first one uses an internal dual token bucket and is
configured using the
**rate**, **burst**, **mtu**, **peakrate**, **overhead** and **linklayer**
parameters. The second one uses an in-kernel sampling mechanism. It can be
fine-tuned using the
**estimator**
filter parameter.

<a name="options"></a>

# Options


* **rate**_ RATE_  
  The maximum traffic rate of packets passing this action. Those exceeding it will
  be treated as defined by the
  **conform-exceed**
  option.
* **burst**_ BYTES[**/BYTES**]_  
  Set the maximum allowed burst in bytes, optionally followed by a slash ('/')
  sign and cell size which must be a power of 2.
* **mtu**_ BYTES[**/BYTES**]_  
  This is the maximum packet size handled by the policer (larger ones will be
  handled like they exceeded the configured rate). Setting this value correctly
  will improve the scheduler's precision.
  Value formatting is identical to
  **burst**
  above. Defaults to unlimited.
* **peakrate**_ RATE_  
  Set the maximum bucket depletion rate, exceeding
  **rate**.
* **avrate**_ RATE_  
  Make use of an in-kernel bandwidth rate estimator and match the given
  _RATE_
  against it.
* **overhead**_ BYTES_  
  Account for protocol overhead of encapsulating output devices when computing
  **rate** and **peakrate**.
* **linklayer**_ TYPE_  
  Specify the link layer type.
  _TYPE_
  may be one of
  **ethernet**
  (the default),
  **atm** or **adsl**
  (which are synonyms). It is used to align the precomputed rate tables to ATM
  cell sizes, for
  **ethernet**
  no action is taken.
* **estimator**_ SAMPLE AVERAGE_  
  Fine-tune the in-kernel packet rate estimator.
  _SAMPLE_ and _AVERAGE_
  are time values and control the frequency in which samples are taken and over
  what timespan an average is built.
* **conform-exceed**_ EXCEEDACT[**/NOTEXCEEDACT**]_  
  Define how to handle packets which exceed or conform the
  configured bandwidth limit. Possible values are:
    * continue  
      Don't do anything, just continue with the next action in line.
    * drop  
      Drop the packet immediately.
    * shot  
      This is a synonym to
      **drop**.
    * ok  
      Accept the packet. This is the default for conforming packets.
    * pass  
      This is a synonym to
      **ok**.
    * reclassify  
      Treat the packet as non-matching to the filter this action is attached to and
      continue with the next filter in line (if any). This is the default for
      exceeding packets.
    * pipe  
      Pass the packet to the next action in line.

<a name="examples"></a>

# Examples

A typical application of the police action is to enforce ingress traffic rate
by dropping exceeding packets. Although better done on the sender's side,
especially in scenarios with lack of peer control (e.g. with dial-up providers)
this is often the best one can do in order to keep latencies low under high
load. The following establishes input bandwidth policing to 1mbit/s using the
**ingress**
qdisc and
**u32**
filter:

.EX
# tc qdisc add dev eth0 handle ffff: ingress
# tc filter add dev eth0 parent ffff: u32 \	match u32 0 0 \	police rate 1mbit burst 100k
.EE

As an action can not live on it's own, there always has to be a filter involved as link between qdisc and action. The example above uses
**u32**
for that, which is configured to effectively match any packet (passing it to the
**police**
action thereby).


<a name="see-also"></a>

# See Also

**tc**(8)
