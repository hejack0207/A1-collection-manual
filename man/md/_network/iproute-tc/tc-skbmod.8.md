# skbmod action in tc(8) - user-friendly packet editor action

iproute2, 21 Sep 2016

```
.in +8 .ti -8 tc ... action skbmod { [ set  SETTABLE ] [  swap SWAPPABLE  ] [ CONTROL ] [  index INDEX  ] }
</synopsis>

<synopsis>
.ti -8 SETTABLE :=   [ dmac DMAC ]   [ smac SMAC ]   [ etype ETYPE ] 
</synopsis>

<synopsis>
.ti -8 SWAPPABLE :=  mac .ti -8 CONTROL := { reclassify | pipe | drop | shot | continue | pass }
```

<a name="description"></a>

# Description

The
**skbmod**
action is intended as a usability upgrade to the existing
**pedit**
action. Instead of having to manually edit 8-, 16-, or 32-bit chunks of an
ethernet header,
**skbmod**
allows complete substitution of supported elements.

<a name="options"></a>

# Options


* **dmac**_ DMAC_  
  Change the destination mac to the specified address.
* **smac**_ SMAC_  
  Change the source mac to the specified address.
* **etype**_ ETYPE_  
  Change the ethertype to the specified value.
* **mac**  
  Used to swap mac addresses. The
  **swap mac**
  directive is performed
  after any outstanding D/SMAC changes.
* _CONTROL_  
  The following keywords allow to control how the tree of qdisc, classes,
  filters and actions is further traversed after this action.
    * **reclassify**  
      Restart with the first filter in the current list.
    * **pipe**  
      Continue with the next action attached to the same filter.
    * **drop**  
      .TQ
      **shot**
      Drop the packet.
    * **continue**  
      Continue classification with the next filter in line.
    * **pass**  
      Finish classification process and return to calling qdisc for further packet
      processing. This is the default.

<a name="examples"></a>

# Examples

To start, observe the following filter with a pedit action:

.EX
tc filter add dev eth1 parent 1: protocol ip prio 10 \	u32 match ip protocol 1 0xff flowid 1:2 \	action pedit munge offset -14 u8 set 0x02 \	munge offset -13 u8 set 0x15 \	munge offset -12 u8 set 0x15 \	munge offset -11 u8 set 0x15 \	munge offset -10 u16 set 0x1515 \	pipe
.EE

Using the skbmod action, this command can be simplified to:

.EX
tc filter add dev eth1 parent 1: protocol ip prio 10 \	u32 match ip protocol 1 0xff flowid 1:2 \	action skbmod set dmac 02:15:15:15:15:15 \	pipe
.EE

Complexity will increase if source mac and ethertype are also being edited
as part of the action. If all three fields are to be changed with skbmod:

.EX
tc filter add dev eth5 parent 1: protocol ip prio 10 \	u32 match ip protocol 1 0xff flowid 1:2 \	action skbmod \	set etype 0xBEEF \	set dmac 02:12:13:14:15:16 \	set smac 02:22:23:24:25:26
.EE

Finally, swap the destination and source mac addresses in the header:

.EX
tc filter add dev eth3 parent 1: protocol ip prio 10 \	u32 match ip protocol 1 0xff flowid 1:2 \	action skbmod \	swap mac
.EE

As mentioned above, the swap action will occur after any
** smac/dmac **
substitutions are executed, if they are present.


<a name="see-also"></a>

# See Also

**tc**(8),
**tc-u32**(8),
**tc-pedit**(8)
