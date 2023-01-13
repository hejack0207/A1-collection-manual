# ip\-mptcp(8) - MPTCP path manager configuration

iproute2, 4 Apr 2020

```
.in +8 .ti -8 ip [ OPTIONS ] mptcp {  endpoint  |  limits  |  help  } 

</synopsis>

<synopsis>
.ti -8 ip mptcp endpoint add  IFADDR [ dev IFNAME ] [ id ID ] [  FLAG-LIST ] 
</synopsis>

<synopsis>
.ti -8 ip mptcp endpoint del id  ID
</synopsis>

<synopsis>
.ti -8 ip mptcp endpoint show  [ id ID ]
</synopsis>

<synopsis>
.ti -8 ip mptcp endpoint flush
</synopsis>

<synopsis>
.ti -8 FLAG-LIST := [ FLAG-LIST ] FLAG
</synopsis>

<synopsis>
.ti -8 FLAG := [ signal | subflow | backup ]
</synopsis>

<synopsis>
.ti -8 ip mptcp limits set  [  subflow SUBFLOW_NR ] [  add_addr_accepted ADD_ADDR_ACCEPTED_NR ]
</synopsis>

<synopsis>
.ti -8 ip mptcp limits show
```


<a name="description"></a>

# Description


MPTCP is a transport protocol built on top of TCP that allows TCP
connections to use multiple paths to maximize resource usage and increase
redundancy. The ip-mptcp sub-commands allow configuring several aspects of the
MPTCP path manager, which is in charge of subflows creation:


The
**endpoint**
object specifies the IP addresses that will be used and/or announced for
additional subflows:

.TS
l l.
ip mptcp endpoint add	add new MPTCP endpoint
ip mptcp endpoint delete	delete existing MPTCP endpoint
ip mptcp endpoint show	get existing MPTCP endpoint
ip mptcp endpoint flush	flush all existing MPTCP endpoints
.TE


* _ID_  
  is a unique numeric identifier for the given endpoint
  
* **signal**  
  the endpoint will be announced/signalled to each peer via an ADD_ADDR MPTCP
  sub-option
  
* **subflow**  
  if additional subflow creation is allowed by MPTCP limits, the endpoint will
  be used as the source address to create an additional subflow after that
  the MPTCP connection is established.
  
* **backup**  
  the endpoint will be announced as a backup address, if this is a
  **signal**
  endpoint, or the subflow will be created as a backup one if this is a
  **subflow**
  endpoint
  


The
**limits**
object specifies the constraints for subflow creations:

.TS
l l.
ip mptcp limits show	get current MPTCP subflow creation limits
ip mptcp limits set	change the MPTCP subflow creation limits
.TE


* _SUBFLOW_NR_  
  specifies the maximum number of additional subflows allowed for each MPTCP
  connection. Additional subflows can be created due to: incoming accepted
  ADD_ADDR option, local
  **subflow**
  endpoints, additional subflows started by the peer.
  
* _ADD_ADDR_ACCEPTED_NR_  
  specifies the maximum number of ADD_ADDR suboptions accepted for each MPTCP
  connection. The MPTCP path manager will try to create a new subflow for
  each accepted ADD_ADDR option, respecting the
  _SUBFLOW_NR_
  limit.
  

<a name="author"></a>

# Author

Original Manpage by Paolo Abeni &lt;[pabeni@redhat.com](mailto:pabeni@redhat.com)&gt;
