# tipc-media(8) - list or modify media properties

iproute2, 02 Jun 2015

```
.in +8
</synopsis>

<synopsis>
.ti -8
</synopsis>

<synopsis>
.ti -8 tipc media set { priority  PRIORITY | tolerance TOLERANCE | window WINDOW } media MEDIA
</synopsis>

<synopsis>
.ti -8 tipc media get { priority | tolerance | window } media MEDIA
</synopsis>

<synopsis>
.ti -8 tipc media list

```


<a name="options"></a>

# Options

Options (flags) that can be passed anywhere in the command chain.

* **-h**,** --help**  
  Show help about last valid command. For example
  **tipc media --help**
  will show media help and
  **tipc --help**
  will show general help. The position of the option in the string is irrelevant.

<a name="description"></a>

# Description



<a name="media-properties"></a>

### Media properties



* **priority**    
  Default link priority inherited by all bearers subsequently enabled on a
  media. For more info about link priority see
  **tipc-link**(8)
  
* **tolerance**    
  Default link tolerance inherited by all bearers subsequently enabled on a
  media. For more info about link tolerance see
  **tipc-link**(8)
  
* **window**    
  Default link window inherited by all bearers subsequently enabled on a
  media. For more info about link window see
  **tipc-link**(8)
  

<a name="exit-status"></a>

# Exit Status

Exit status is 0 if command was successful or a positive integer upon failure.


<a name="see-also"></a>

# See Also

**tipc**(8),
**tipc-bearer**(8),
**tipc-link**(8),
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
