# taprio(8) - Time Aware Priority Shaper

iproute2, 25 Sept 2018

```
tc qdisc ... dev dev parent classid [ handle major: ] taprio num_tc tcs .ti +8 map P0 P1 P2 ... queues count1@offset1 count2@offset2 ... .ti +8 base-time base-time clockid clockid .ti +8 sched-entry <command 1> <gate mask 1> <interval 1> .ti +8 sched-entry <command 2> <gate mask 2> <interval 2> .ti +8 sched-entry <command 3> <gate mask 3> <interval 3> .ti +8 sched-entry <command N> <gate mask N> <interval N>
```


<a name="description"></a>

# Description

The TAPRIO qdisc implements a simplified version of the scheduling
state machine defined by IEEE 802.1Q-2018 Section 8.6.9, which allows
configuration of a sequence of gate states, where each gate state
allows outgoing traffic for a subset (potentially empty) of traffic
classes.

How traffic is mapped to different hardware queues is similar to
**mqprio(8)**
and so the
**map**
and
**queues**
parameters have the same meaning.

The other parameters specify the schedule, and at what point in time
it should start (it can behave as the schedule started in the past).


<a name="parameters"></a>

# Parameters


* num_tc    
  Number of traffic classes to use. Up to 16 classes supported.
  
* map    
  The priority to traffic class map. Maps priorities 0..15 to a specified
  traffic class. See
  **mqprio(8)**
  for more details.
  
* queues    
  Provide count and offset of queue range for each traffic class. In the
  format,
  **count@offset.**
  Queue ranges for each traffic classes cannot overlap and must be a
  contiguous range of queues.
  
* base-time    
  Specifies the instant in nanoseconds, using the reference of
  **clockid,**
  defining the time when the schedule starts. If 'base-time' is a time
  in the past, the schedule will start at
  
  base-time + (N * cycle-time)
  
  where N is the smallest integer so the resulting time is greater than
  "now", and "cycle-time" is the sum of all the intervals of the entries
  in the schedule;
  
* clockid    
  Specifies the clock to be used by qdisc's internal timer for measuring
  time and scheduling events.
  
* sched-entry    
  There may multiple
  **sched-entry**
  parameters in a single schedule. Each one has the
  
  sched-entry &lt;command&gt; &lt;gatemask&gt; &lt;interval&gt;
  
  format. The only supported &lt;command&gt; is "S", which
  means "SetGateStates", following the IEEE 802.1Q-2018 definition
  (Table 8-7). &lt;gate mask&gt; is a bitmask where each bit is a associated
  with a traffic class, so bit 0 (the least significant bit) being "on"
  means that traffic class 0 is "active" for that schedule entry.
  &lt;interval&gt; is a time duration, in nanoseconds, that specifies for how
  long that state defined by &lt;command&gt; and &lt;gate mask&gt; should be held
  before moving to the next entry.
  
* flags    
  Specifies different modes for taprio. Currently, only txtime-assist is
  supported which can be enabled by setting it to 0x1. In this mode, taprio will
  set the transmit timestamp depending on the interval in which the packet needs
  to be transmitted. It will then utililize the
  **etf(8)**
  qdisc to sort and transmit the packets at the right time. The second example
  can be used as a reference to configure this mode.
  
* txtime-delay    
  This parameter is specific to the txtime offload mode. It specifies the maximum
  time a packet might take to reach the network card from the taprio qdisc. The
  value should always be greater than the delta specified in the
  **etf(8)**
  qdisc.
  

<a name="examples"></a>

# Examples


The following example shows how an traffic schedule with three traffic
classes ("num_tc 3"), which are separated different traffic classes,
we are going to call these TC 0, TC 1 and TC 2. We could read the
"map" parameter below as: traffic with priority 3 is classified as TC
0, priority 2 is classified as TC 1 and the rest is classified as TC
2.

The schedule will start at instant 1528743495910289987 using the
reference CLOCK_TAI. The schedule is composed of three entries each of
300us duration.

.EX
# tc qdisc replace dev eth0 parent root handle 100 taprio &nbsp;             num_tc 3 &nbsp;             map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 &nbsp;             queues 1@0 1@1 2@2 &nbsp;             base-time 1528743495910289987 &nbsp;             sched-entry S 01 300000 &nbsp;             sched-entry S 02 300000 &nbsp;             sched-entry S 04 300000 &nbsp;             clockid CLOCK_TAI
.EE

Following is an example to enable the txtime offload mode in taprio. See
**etf(8)**
for more information about configuring the ETF qdisc.

.EX
# tc qdisc replace dev eth0 parent root handle 100 taprio &nbsp;             num_tc 3 &nbsp;             map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 &nbsp;             queues 1@0 1@0 1@0 &nbsp;             base-time 1528743495910289987 &nbsp;             sched-entry S 01 300000 &nbsp;             sched-entry S 02 300000 &nbsp;             sched-entry S 04 400000 &nbsp;             flags 0x1 &nbsp;             txtime-delay 200000 &nbsp;             clockid CLOCK_TAI

# tc qdisc replace dev $IFACE parent 100:1 etf skip_skb_check &nbsp;             offload delta 200000 clockid CLOCK_TAI
.EE


<a name="authors"></a>

# Authors

Vinicius Costa Gomes &lt;[vinicius.gomes@intel.com](mailto:vinicius.gomes@intel.com)&gt;
