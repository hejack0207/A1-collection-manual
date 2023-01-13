# ip\-fou(8) - Foo-over-UDP receive port configuration

iproute2, 2 Nov 2014


ip-gue - Generic UDP Encapsulation receive port configuration

<a name="synopsis"></a>

# Synopsis

```

 .in +8 .ti -8 ip [ OPTIONS ] fou  { COMMAND |  help } 
 .ti -8 ip fou add port PORT {  gue | ipproto PROTO  } [  local IFADDR  ] [  peer IFADDR  ] [  peer_port PORT  ] [  dev IFNAME  ]
.ti -8 ip fou del port PORT [  local IFADDR  ] [  peer IFADDR  ] [  peer_port PORT  ] [  dev IFNAME  ]
.ti -8 ip fou show
```

<a name="description"></a>

# Description

The
**ip fou**
commands are used to create and delete receive ports for Foo-over-UDP
(FOU) as well as Generic UDP Encapsulation (GUE).

Foo-over-UDP allows encapsulating packets of an IP protocol directly
over UDP. The receiver infers the protocol of a packet received on
a FOU UDP port to be the protocol configured for the port.

Generic UDP Encapsulation (GUE) encapsulates packets of an IP protocol
within UDP and an encapsulation header. The encapsulation header contains the
IP protocol number for the encapsulated packet.

When creating a FOU or GUE receive port, the port number is specified in
_PORT_
argument. If FOU is used, the IP protocol number associated with the port is specified in
_PROTO_
argument. You can bind a port to a local address/interface, by specifying the
address in the local
_IFADDR_
argument or the device in the
_IFNAME_
argument. If you would like to connect the port, you can specify the peer
address in the peer
_IFADDR_
argument and peer port in the peer_port
_PORT_
argument.

A FOU or GUE receive port is deleted by specifying
_PORT_
in the delete command, as well as local address/interface or peer address/port
(if set).

<a name="examples"></a>

# Examples



<a name="configure-a-fou-receive-port-for-gre-bound-to-7777"></a>

### Configure a FOU receive port for GRE bound to 7777

    # ip fou add port 7777 ipproto 47
    
    .SS Configure a FOU receive port for IPIP bound to 8888
    .nf
    # ip fou add port 8888 ipproto 4
    
    .SS Configure a GUE receive port bound to 9999
    .nf
    # ip fou add port 9999 gue
    
    .SS Delete the GUE receive port bound to 9999
    .nf
    # ip fou del port 9999
    .SS Configure a FOU receive port for GRE bound to 1.2.3.4:7777
    .nf
    # ip fou add port 7777 ipproto 47 local 1.2.3.4
    

<a name="see-also"></a>

# See Also
  
**ip**(8)

<a name="author"></a>

# Author

Tom Herbert &lt;[therbert@google.com](mailto:therbert@google.com)&gt;
