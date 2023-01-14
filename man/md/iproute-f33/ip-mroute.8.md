# ip\-mroute(8) - multicast routing cache management

iproute2, 13 Dec 2012

```

 .in +8 .ti -8 ip mroute show [ [   to  ]  PREFIX ] [   from PREFIX ] [   iif DEVICE ] [  table TABLE_ID ] 
```


<a name="description"></a>

# Description

**mroute**
objects are multicast routing cache entries created by a user-level
mrouting daemon (f.e.
**pimd**
or
**mrouted**
).

Due to the limitations of the current interface to the multicast routing
engine, it is impossible to change
**mroute**
objects administratively, so we can only display them. This limitation
will be removed in the future.


<a name="ip-mroute-show-list-mroute-cache-entries"></a>

### ip mroute show - list mroute cache entries



* **to**_ PREFIX _**(default)**  
  the prefix selecting the destination multicast addresses to list.
  
* **iif**_ NAME_  
  the interface on which multicast packets are received.
  
* **from**_ PREFIX_  
  the prefix selecting the IP source addresses of the multicast route.
  
* **table**_ TABLE_ID_  
  the table id selecting the multicast table. It can be
  **local**, **main**, **default**, **all** or a number.
  

<a name="see-also"></a>

# See Also
  
**ip**(8)


<a name="author"></a>

# Author

Original Manpage by Michail Litvak &lt;[mci@owl.openwall](mailto:mci@owl.openwall).com&gt;
