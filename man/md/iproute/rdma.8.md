# rdma(8) - RDMA tool

iproute2, 28 Mar 2017

```

 .in +8 .ti -8 rdma [ OPTIONS ] OBJECT { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 rdma [ -force ]  -batch filename 

</synopsis>

<synopsis>
.ti -8 OBJECT := {  dev | link } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -V[ersion] | -d[etails] } -j[son] } -p[retty] }
```


<a name="options"></a>

# Options



* **-V**,** -Version**  
  Print the version of the
  **rdma**
  tool and exit.
  
* **-b**,** -batch **&lt;FILENAME&gt;  
  Read commands from provided file or standard input and invoke them.
  First failure will cause termination of rdma.
  
* **-force**  
  Don't terminate rdma on errors in batch mode.
  If there were any errors during execution of the commands, the application return code will be non zero.
  
* **-d**,** --details**  
  Output detailed information.  Adding a second -d includes driver-specific details.
  
* **-p**,** --pretty**  
  When combined with -j generate a pretty JSON output.
  
* **-j**,** --json**  
  Generate JSON output.
  
  .SS
  _OBJECT_
  
* **dev**  
  - RDMA device.
  
* **link**  
  - RDMA port related.
  

The names of all objects may be written in full or
abbreviated form, for example
**stats**
can be abbreviated as
**stat**
or just
**s.**

.SS
_COMMAND_

Specifies the action to perform on the object.
The set of possible actions depends on the object type.
As a rule, it is possible to
**show**
(or
**list**
) objects, but some objects do not allow all of these operations
or have some additional commands. The
**help**
command is available for all objects. It prints
out a list of available commands and argument syntax conventions.

If no command is given, some default command is assumed.
Usually it is
**list**
or, if the objects of this class cannot be listed,
**help**.


<a name="exit-status"></a>

# Exit Status

Exit status is 0 if command was successful or a positive integer upon failure.


<a name="see-also"></a>

# See Also

**rdma-dev**(8),
**rdma-link**(8),
**rdma-resource**(8),  


<a name="reporting-bugs"></a>

# Reporting Bugs

Report any bugs to the Linux RDMA mailing list
**&lt;linux-rdma@vger.kernel.org&gt;**
where the development and maintenance is primarily done.
You do not have to be subscribed to the list to send a message there.


<a name="author"></a>

# Author

Leon Romanovsky &lt;[leonro@mellanox.com](mailto:leonro@mellanox.com)&gt;
