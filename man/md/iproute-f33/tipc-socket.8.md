# tipc-socket(8) - show TIPC socket (port) information

iproute2, 02 Jun 2015

```
.in +8
</synopsis>

<synopsis>
.ti -8 tipc socket list
```


<a name="options"></a>

# Options

Options (flags) that can be passed anywhere in the command chain.

* **-h**,** --help**  
  Show help about last valid command. For example
  **tipc socket --help**
  will show socket help and
  **tipc --help**
  will show general help. The position of the option in the string is irrelevant.
  

<a name="description"></a>

# Description

A TIPC socket is represented by an unsigned integer.


* 
<a name="bound-state"></a>

### Bound state

A bound socket has a logical TIPC port name associated with it.


* 
<a name="connected-state"></a>

### Connected state

A connected socket is directly connected to another socket creating a point
to point connection between TIPC sockets. If the connection to X was made using
a logical port name Y that name will show up as
**connected to **X **via **Y


<a name="exit-status"></a>

# Exit Status

Exit status is 0 if command was successful or a positive integer upon failure.


<a name="see-also"></a>

# See Also

**tipc**(8),
**tipc-bearer**(8)
**tipc-link**(8),
**tipc-media**(8),
**tipc-nametable**(8),
**tipc-node**(8),  

<a name="reporting-bugs"></a>

# Reporting Bugs

Report any bugs to the Network Developers mailing list
**&lt;netdev@vger.kernel.org&gt;**
where the development and maintenance is primarily done.
You do not have to be subscribed to the list to send a message there.


<a name="author"></a>

# Author

Richard Alpe &lt;[richard.alpe@ericsson.com](mailto:richard.alpe@ericsson.com)&gt;
