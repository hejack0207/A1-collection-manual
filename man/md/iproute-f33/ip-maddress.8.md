# ip\-maddress(8) - multicast addresses management

iproute2, 20 Dec 2011

```

 .in +8 .ti -8 ip [ OPTIONS ]  maddress  { COMMAND |  help } 
 .ti -8
</synopsis>

<synopsis>
ip maddress [ add | del ] MULTIADDR dev NAME
</synopsis>

<synopsis>
.ti -8 ip maddress show [ dev NAME ]
```


<a name="description"></a>

# Description

**maddress**
objects are multicast addresses.


<a name="ip-maddress-show-list-multicast-addresses"></a>

### ip maddress show - list multicast addresses



* **dev**_ NAME _**(default)**  
  the device name.
  
* **ip maddress add - add a multicast address**  
* **ip maddress delete - delete a multicast address**  

These commands attach/detach a static link-layer multicast address
to listen on the interface.
Note that it is impossible to join protocol multicast groups
statically. This command only manages link-layer addresses.


* **address**_ LLADDRESS _**(default)**  
  the link-layer multicast address.
  
* **dev**_ NAME_  
  the device to join/leave this multicast address.


<a name="see-also"></a>

# See Also
  
**ip**(8)


<a name="author"></a>

# Author

Original Manpage by Michail Litvak &lt;[mci@owl.openwall](mailto:mci@owl.openwall).com&gt;
