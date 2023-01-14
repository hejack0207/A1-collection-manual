# tipc-node(8) - modify and show local node parameters or list peer nodes

iproute2, 02 Jun 2015

```
.in +8
</synopsis>

<synopsis>
.ti -8 tipc node set { address  ADDRESS | netid NETID } 
</synopsis>

<synopsis>
.ti -8 tipc node get { address | netid } 
</synopsis>

<synopsis>
.ti -8 tipc node list

```


<a name="options"></a>

# Options

Options (flags) that can be passed anywhere in the command chain.

* **-h**,** --help**  
  Show help about last valid command. For example
  **tipc node --help**
  will show node help and
  **tipc --help**
  will show general help. The position of the option in the string is irrelevant.

<a name="description"></a>

# Description



<a name="node-parameters"></a>

### Node parameters


* **address**    
  The TIPC logical address. On the form x.y.z where x, y and z are unsigned
  integers.
  
* **netid**    
  Network identity. Can by used to create individual TIPC clusters on the same
  media.
  

<a name="exit-status"></a>

# Exit Status

Exit status is 0 if command was successful or a positive integer upon failure.


<a name="see-also"></a>

# See Also

**tipc**(8),
**tipc-bearer**(8),
**tipc-link**(8),
**tipc-media**(8),
**tipc-nametable**(8),
**tipc-peer**(8),
**tipc-socket**(8)  

<a name="reporting-bugs"></a>

# Reporting Bugs

Report any bugs to the Network Developers mailing list
**&lt;netdev@vger.kernel.org&gt;**
where the development and maintenance is primarily done.
You do not have to be subscribed to the list to send a message there.


<a name="author"></a>

# Author

Richard Alpe &lt;[richard.alpe@ericsson.com](mailto:richard.alpe@ericsson.com)&gt;
