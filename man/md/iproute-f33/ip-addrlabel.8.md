# ip\-addrlabel(8) - protocol address label management

iproute2, 20 Dec 2011

```

 .in +8 .ti -8 ip addrlabel  { COMMAND |  help }
</synopsis>

<synopsis>
.ti -8 ip addrlabel { add | del } prefix PREFIX [  dev DEV ] [  label NUMBER ]
</synopsis>

<synopsis>
.ti -8 ip addrlabel { list | flush }
```


<a name="description"></a>

# Description

IPv6 address labels are used for address selection;
they are described in RFC 3484. Precedence is managed by userspace,
and only the label itself is stored in the kernel.


<a name="ip-addrlabel-add-add-an-address-label"></a>

### ip addrlabel add - add an address label

add an address label entry to the kernel.

* **prefix**_ PREFIX_  
* **dev**_ DEV_  
  the outgoing interface.
* **label**_ NUMBER_  
  the label for the prefix.
  0xffffffff is reserved.

<a name="ip-addrlabel-del-delete-an-address-label"></a>

### ip addrlabel del - delete an address label

delete an address label entry from the kernel.
**Arguments:**
coincide with the arguments of
**ip addrlabel add**
but the label is not required.

<a name="ip-addrlabel-list-list-address-labels"></a>

### ip addrlabel list - list address labels

list the current address label entries in the kernel.

<a name="ip-addrlabel-flush-flush-address-labels"></a>

### ip addrlabel flush - flush address labels

flush all address labels in the kernel. This does not restore any default settings.


<a name="see-also"></a>

# See Also
  
**ip**(8)


<a name="author"></a>

# Author

Manpage by Yoshifuji Hideaki / 吉藤英明
