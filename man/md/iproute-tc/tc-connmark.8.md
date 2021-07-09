# connmark retriever action in tc(8) - netfilter connmark retriever action

iproute2, 11 Jan 2016

```
.in +8 .ti -8 tc ... action connmark [ zone u16_zone_index ] [ CONTROL ] [ index u32_index  ]
</synopsis>

<synopsis>
.ti -8 CONTROL := { reclassify | pipe | drop | continue | ok }
```

<a name="description"></a>

# Description

The connmark action is used to restore the connection's mark value into the
packet's fwmark.

<a name="options"></a>

# Options


* **zone**_ u16_zone_index_  
  Specify the conntrack zone when doing conntrack lookups for packets.
  _u16_zone_index_
  is a 16bit unsigned decimal value.
* _CONTROL_  
  How to continue after executing this action.
    * **reclassify**  
      Restarts classification by jumping back to the first filter attached to this
      action's parent.
    * **pipe**  
      Continue with the next action, this is the default.
    * **drop**  
      .TQ
      **shot**
      Packet will be dropped without running further actions.
    * **continue**  
      Continue classification with next filter in line.
    * **pass**  
      Return to calling qdisc for packet processing. This ends the classification
      process.
* **index**_ u32_index _  
  Specify an index for this action in order to being able to identify it in later
  commands.
  _u32_index_
  is a 32bit unsigned decimal value.

<a name="see-also"></a>

# See Also

**tc**(8)
