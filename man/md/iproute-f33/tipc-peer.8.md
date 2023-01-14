# tipc-peer(8) - modify peer information

iproute2, 04 Dec 2015

```
.in +8
</synopsis>

<synopsis>
.ti -8 tipc peer remove address ADDRESS
```


<a name="options"></a>

# Options

Options (flags) that can be passed anywhere in the command chain.

* **-h**,** --help**  
  Show help about last valid command. For example
  **tipc peer --help**
  will show peer help and
  **tipc --help**
  will show general help. The position of the option in the string is irrelevant.

<a name="description"></a>

# Description



<a name="peer-remove"></a>

### Peer remove

Remove an offline peer node from the local data structures. The peer is
identified by its
**address**


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
**tipc-node**(8),
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
