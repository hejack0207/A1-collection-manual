# ip\-token(8) - tokenized interface identifier support

iproute2, 28 Mar 2013

```

 .in +8 .ti -8 ip token { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 ip token set TOKEN dev DEV
</synopsis>

<synopsis>
.ti -8 ip token del dev DEV
</synopsis>

<synopsis>
.ti -8 ip token get [ dev DEV ]
</synopsis>

<synopsis>
.ti -8 ip token [ list ]
```


<a name="description"></a>

# Description

IPv6 tokenized interface identifier support is used for assigning well-known
host-part addresses to nodes whilst still obtaining a global network prefix
from Router advertisements. The primary target for tokenized identifiers are
server platforms where addresses are usually manually configured, rather than
using DHCPv6 or SLAAC. By using tokenized identifiers, hosts can still
determine their network prefix by use of SLAAC, but more readily be
automatically renumbered should their network prefix change [1]. Tokenized
IPv6 Identifiers are described in the draft
[1]: &lt;draft-chown-6man-tokenised-ipv6-identifiers-02&gt;.


<a name="ip-token-set-set-an-interface-token"></a>

### ip token set - set an interface token

set the interface token to the kernel.

* _TOKEN_  
  the interface identifier token address.
* **dev**_ DEV_  
  the networking interface.
  

<a name="ip-token-del-delete-an-interface-token"></a>

### ip token del - delete an interface token

delete the interface token from the kernel.

* **dev**_ DEV_  
  the networking interface.
  

<a name="ip-token-get-get-the-interface-token-from-the-kernel"></a>

### ip token get - get the interface token from the kernel

show a tokenized interface identifier of a particular networking device.
**Arguments:**
coincide with the arguments of
**ip token set**
but the
_TOKEN_
must be left out.

<a name="ip-token-list-list-all-interface-tokens"></a>

### ip token list - list all interface tokens

list all tokenized interface identifiers for the networking interfaces from
the kernel.


<a name="see-also"></a>

# See Also
  
**ip**(8)


<a name="author"></a>

# Author

Manpage by Daniel Borkmann
