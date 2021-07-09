# vlan manipulation action in tc(8) - vlan manipulation module

iproute2, 12 Jan 2015

```
.in +8 .ti -8 tc ... action vlan { pop | PUSH | MODIFY } [ CONTROL ]
</synopsis>

<synopsis>
.ti -8 PUSH :=  push [ protocol VLANPROTO ]  [ priority VLANPRIO ]  id VLANID
</synopsis>

<synopsis>
.ti -8 MODIFY :=  modify [ protocol VLANPROTO ]  [ priority VLANPRIO ]  id VLANID
</synopsis>

<synopsis>
.ti -8 CONTROL := {  reclassify | pipe | drop | continue | pass | goto chain CHAIN_INDEX }
```

<a name="description"></a>

# Description

The
**vlan**
action allows to perform 802.1Q en- or decapsulation on a packet, reflected by
the operation modes
_POP_, _PUSH_ and _MODIFY_.
The
_POP_
mode is simple, as no further information is required to just drop the
outer-most VLAN encapsulation. The
_PUSH_ and _MODIFY_
modes require at least a
_VLANID_
and allow to optionally choose the
_VLANPROTO_
to use.

<a name="options"></a>

# Options


* **pop**  
  Decapsulation mode, no further arguments allowed.
* **push**  
  Encapsulation mode. Requires at least
  **id**
  option.
* **modify**  
  Replace mode. Existing 802.1Q tag is replaced. Requires at least
  **id**
  option.
* **id**_ VLANID_  
  Specify the VLAN ID to encapsulate into.
  _VLANID_
  is an unsigned 16bit integer, the format is detected automatically (e.g. prefix
  with
  '**0x**'
  for hexadecimal interpretation, etc.).
* **protocol**_ VLANPROTO_  
  Choose the VLAN protocol to use. At the time of writing, the kernel accepts only
  **802.1Q** or **802.1ad**.
* **priority**_ VLANPRIO_  
  Choose the VLAN priority to use. Decimal number in range of 0-7.
* _CONTROL_  
  How to continue after executing this action.
    * **reclassify**  
      Restarts classification by jumping back to the first filter attached to this
      action's parent.
    * **pipe**  
      Continue with the next action, this is the default.
    * **drop**  
      Packet will be dropped without running further actions.
    * **continue**  
      Continue classification with next filter in line.
    * **pass**  
      Return to calling qdisc for packet processing. This ends the classification
      process.

<a name="examples"></a>

# Examples

The following example encapsulates incoming ICMP packets on eth0 from 10.0.0.2
into VLAN ID 123:

.EX
#tc qdisc add dev eth0 handle ffff: ingress
#tc filter add dev eth0 parent ffff: pref 11 protocol ip \	u32 match ip protocol 1 0xff flowid 1:1 \	    match ip src 10.0.0.2 flowid 1:1 \	action vlan push id 123
.EE

Here is an example of the
**pop**
function: Incoming VLAN packets on eth0 are decapsulated and the classification
process then restarted for the plain packet:

.EX
#tc qdisc add dev eth0 handle ffff: ingress
#tc filter add dev $ETH parent ffff: pref 1 protocol 802.1Q \	u32 match u32 0 0 flowid 1:1 \	action vlan pop reclassify
.EE


<a name="see-also"></a>

# See Also

**tc**(8)
