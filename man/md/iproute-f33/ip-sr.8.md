# ip\-sr(8) - IPv6 Segment Routing management

iproute2, 14 Apr 2017

```

 .in +8 .ti -8 ip sr  { COMMAND |  help } 
 .ti -8
</synopsis>

<synopsis>
.ti -8 ip sr hmac show
</synopsis>

<synopsis>
.ti -8 ip sr hmac set KEYID ALGO
</synopsis>

<synopsis>
.ti -8 ip sr tunsrc show
</synopsis>

<synopsis>
.ti -8 ip sr tunsrc set ADDRESS
```


<a name="description"></a>

# Description

The **ip sr** command is used to configure IPv6 Segment Routing (SRv6)
internal parameters.

Those parameters include the mapping between an HMAC key ID and its associated
hashing algorithm and secret, and the IPv6 address to use as source for encapsulated
packets.

The **ip sr hmac set** command prompts for a passphrase that will be used as the
HMAC secret for the corresponding key ID. A blank passphrase removes the mapping.
The currently supported algorithms for _ALGO_ are **sha1** and **sha256**.

If the tunnel source is set to the address :: (which is the default), then an address
of the egress interface will be selected. As this operation may hinder performances,
it is recommended to set a non-default address.


<a name="examples"></a>

# Examples



<a name="configure-an-hmac-mapping-for-key-id-42-and-hashing-algorithm-sha-256"></a>

### Configure an HMAC mapping for key ID 42 and hashing algorithm SHA-256

    # ip sr hmac set 42 sha256
    
    .SS Set the tunnel source address to 2001:db8::1
    .nf
    # ip sr tunsrc set 2001:db8::1

<a name="see-also"></a>

# See Also
  
**ip-route**(8)

<a name="author"></a>

# Author

David Lebrun &lt;[david.lebrun@uclouvain.be](mailto:david.lebrun@uclouvain.be)&gt;
