# tipc(8) - a TIPC configuration and management tool

iproute2, 02 Jun 2015

```
.in +8 .ti -8 tipc [ OPTIONS ] COMMAND ARGUMENTS 

</synopsis>

<synopsis>
.ti -8 COMMAND := {  bearer | link | media | nametable | node | socket} 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -h[help] }
```


<a name="description"></a>

# Description

The Transparent Inter-Process Communication (TIPC) protocol offers total address
transparency between processes which allows applications in a clustered computer
environment to communicate quickly and reliably with each other, regardless of
their location within the cluster.

TIPC originated at the telecommunications manufacturer Ericsson. The first open
source version of TIPC was created in 2000 when Ericsson released its first
Linux version of TIPC. TIPC was introduced in the mainline Linux kernel in 2006
and is now widely used both within and outside of Ericsson.


<a name="options"></a>

# Options



* **-h**,** --help**  
  Show help about last given command. For example
  **tipc bearer --help**
  will show bearer help and
  **tipc --help**
  will show general help. The position of the option in the string is irrelevant.
  
* **-j**,** -json**  
  Output results in JavaScript Object Notation (JSON).
  
* **-p**,** -pretty**  
  The default JSON format is compact and more efficient to parse but hard for most users to read.
  This flag adds indentation for readability.
  

<a name="commands"></a>

# Commands



* **BEARER**  
  - Show or modify TIPC bearers
  
* **LINK**  
  - Show or modify TIPC links
  
* **MEDIA**  
  - Show or modify TIPC media
  
* **NAMETABLE**  
  - Show TIPC nametable
  
* **NODE**  
  - Show or modify TIPC node parameters
  
* **SOCKET**  
  - Show TIPC sockets
  

<a name="arguments"></a>

# Arguments


Command arguments are described in a command specific man page and typically
consists of nested commands along with key value pairs.
If no arguments are given a command typically shows its help text. The explicit
help option
**-h**
or
**--help**
can occur anywhere among the arguments and will show help for the last valid
command given.


<a name="exit-status"></a>

# Exit Status

Exit status is 0 if command was successful or a positive integer upon failure.


<a name="see-also"></a>

# See Also

**tipc-bearer**(8),
**tipc-link**(8),
**tipc-media**(8),
**tipc-nametable**(8),
**tipc-node**(8),
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
