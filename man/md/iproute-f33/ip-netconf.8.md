# ip\-netconf(8) - network configuration monitoring

iproute2, 13 Dec 2012

```

 .in +8 .ti -8 ip  [ ip-OPTIONS ] netconf show [  dev NAME ]
```


<a name="description"></a>

# Description

The
**ip netconf**
utility can monitor IPv4 and IPv6 parameters (see
**/proc/sys/net/ipv[4|6]/conf/[all|DEV]/**)
like forwarding, rp_filter, proxy_neigh, ignore_routes_with_linkdown
or mc_forwarding status.

If no interface is specified, the entry
**all**
is displayed.


<a name="ip-netconf-show-display-network-parameters"></a>

### ip netconf show - display network parameters



* **dev**_ NAME_  
  the name of the device to display network parameters for.
  

<a name="see-also"></a>

# See Also
  
**ip**(8)


<a name="author"></a>

# Author

Original Manpage by Nicolas Dichtel &lt;[nicolas.dichtel@6wind.com](mailto:nicolas.dichtel@6wind.com)&gt;
