# traffic control index filter(8) - traffic control index filter

iproute2, 21 Oct 2015

```
.in +8 .ti -8 tc filter ... tcindex [ hash SIZE ] [  mask MASK ] [  shift SHIFT ] [  pass_on | fall_through ] [ classid CLASSID ] [  action ACTION_SPEC ]
```

<a name="description"></a>

# Description

This filter allows to match packets based on their
**tcindex**
field value, i.e. the combination of the DSCP and ECN fields as present in IPv4
and IPv6 headers.

<a name="options"></a>

# Options


* **action**_ ACTION_SPEC_  
  Apply an action from the generic actions framework on matching packets.
* **classid**_ CLASSID_  
  Push matching packets into the class identified by
  _CLASSID_.
* **hash**_ SIZE_  
  Hash table size in entries to use. Defaults to 64.
* **mask**_ MASK_  
  An optional bitmask to binary
  **AND** to the packet's **tcindex**
  field before use.
* **shift**_ SHIFT_  
  The number of bits to right-shift a packet's
  **tcindex**
  value before use. If a
  **mask**
  has been set, masking is done before shifting.
* **pass_on**  
  If this flag is set, failure to find a class for the resulting ID will make the
  filter fail and lead to the next filter being consulted.
* **fall_through**  
  This is the opposite of
  **pass_on**
  and the default. The filter will classify the packet even if there is no class
  present for the resulting class ID.
  

<a name="see-also"></a>

# See Also

**tc**(8)
