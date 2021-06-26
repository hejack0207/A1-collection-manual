# routel(8)

iproute2, 3 Jan, 2008


routel - list routes with pretty output format  
routef - flush routes

<a name="syntax"></a>

# Syntax

```

 routel [tablenr [raw ip args...]]
routef
```

<a name="description"></a>

# Description


These programs are a set of helper scripts you can use instead of raw iproute2 commands.  
The routel script will list routes in a format that some might consider easier to interpret then the ip route list equivalent.  
The routef script does not take any arguments and will simply flush the routing table down the drain. Beware! This means deleting all routes which will make your network unusable!


<a name="authors"></a>

# Authors


The routel script was written by Stephen R. van den Berg &lt;[srb@cuci.nl](mailto:srb@cuci.nl)&gt;, 1999/04/18 and donated to the public domain.  
This manual page was written by Andreas Henriksson  &lt;[andreas@fatal.se](mailto:andreas@fatal.se)&gt;, for the Debian GNU/Linux system.

<a name="see-also"></a>

# See Also


ip(8)
