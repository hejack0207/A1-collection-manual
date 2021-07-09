# mpls manipulation action in tc(8) - mpls manipulation module

iproute2, 22 May 2019

```
.in +8 .ti -8 tc ... action mpls {  POP | PUSH | MODIFY |  dec_ttl } [  CONTROL ]
</synopsis>

<synopsis>
.ti -8 POP :=  pop protocol MPLS_PROTO
</synopsis>

<synopsis>
.ti -8 PUSH :=  push [ protocol MPLS_PROTO ]  [ tc MPLS_TC ]   [ ttl MPLS_TTL ]   [ bos MPLS_BOS ]  label MPLS_LABEL
</synopsis>

<synopsis>
.ti -8 MODIFY :=  modify [ label MPLS_LABEL ]  [ tc MPLS_TC ]   [ ttl MPLS_TTL ] 
</synopsis>

<synopsis>
.ti -8 CONTROL := {  reclassify | pipe | drop | continue | pass | goto chain CHAIN_INDEX }
```

<a name="description"></a>

# Description

The
**mpls**
action performs mpls encapsulation or decapsulation on a packet, reflected by the
operation modes
_POP_, _PUSH_, _MODIFY_ and _DEC_TTL_.
The
_POP_
mode requires the ethertype of the header that follows the MPLS header (e.g.
IPv4 or another MPLS). It will remove the outer MPLS header and replace the
ethertype in the MAC header with that passed. The
_PUSH_ and _MODIFY_
modes update the current MPLS header information or add a new header.
_PUSH_
requires at least an
_MPLS_LABEL_. 
_DEC_TTL_
requires no arguments and simply subtracts 1 from the MPLS header TTL field.


<a name="options"></a>

# Options


* **pop**  
  Decapsulation mode. Requires the protocol of the next header.
* **push**  
  Encapsulation mode. Requires at least the
  **label**
  option.
* **modify**  
  Replace mode. Existing MPLS tag is replaced.
  **label**, 
  **tc**, 
  and
  **ttl**
  are all optional.
* **dec_ttl**  
  Decrement the TTL field on the outer most MPLS header.
* **label**_ MPLS_LABEL_  
  Specify the MPLS LABEL for the outer MPLS header.
  _MPLS_LABEL_
  is an unsigned 20bit integer, the format is detected automatically (e.g. prefix
  with
  '**0x**'
  for hexadecimal interpretation, etc.).
* **protocol**_ MPLS_PROTO_  
  Choose the protocol to use. For push actions this must be
  **mpls_uc** or **mpls_mc** (**mpls_uc**
  is the default). For pop actions it should be the protocol of the next header.
  This option cannot be used with modify.
* **tc**_ MPLS_TC_  
  Choose the TC value for the outer MPLS header. Decimal number in range of 0-7.
  Defaults to 0.
* **ttl**_ MPLS_TTL_  
  Choose the TTL value for the outer MPLS header. Number in range of 0-255. A
  non-zero default value will be selected if this is not explicitly set.
* **bos**_ MPLS_BOS_  
  Manually configure the bottom of stack bit for an MPLS header push. The default
  is for TC to automatically set (or unset) the bit based on the next header of
  the packet.
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

The following example encapsulates incoming IP packets on eth0 into MPLS with
a label 123 and sends them out eth1:

.EX
#tc qdisc add dev eth0 handle ffff: ingress
#tc filter add dev eth0 protocol ip parent ffff: flower \	action mpls push protocol mpls_uc label 123  \	action mirred egress redirect dev eth1
.EE

In this example, incoming MPLS unicast packets on eth0 are decapsulated and to
ip packets and output to eth1:

.EX
#tc qdisc add dev eth0 handle ffff: ingress
#tc filter add dev eth0 protocol mpls_uc parent ffff: flower \	action mpls pop protocol ipv4  \	action mirred egress redirect dev eth0
.EE


<a name="see-also"></a>

# See Also

**tc**(8)
