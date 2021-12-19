# iw(8) - show / manipulate wireless devices and their configuration

iw, 7 June 2012

```
.in +8 .ti -8 iw [ OPTIONS ] { help [  ""command ] | ""OBJECT COMMAND } 

</synopsis>

<synopsis>
.ti -8 OBJECT := {  dev | phy | reg } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := { --version | --debug }
```


<a name="options"></a>

# Options



* ** --version**  
  print version information and exit.
  
* ** --debug**  
  enable netlink message debugging.
  

<a name="iw-command-syntax"></a>

# Iw - Command Syntax


.SS
_OBJECT_


* **dev &lt;interface name&gt;**  
  - network interface.
  
* **phy &lt;phy name&gt;**  
  - wireless hardware device (by name).
* **phy#&lt;phy index&gt;**  
  - wireless hardware device (by index).
  
* **reg**  
  - regulatory agent.
  
  .SS
  _COMMAND_
  
  Specifies the action to perform on the object.
  The set of possible actions depends on the object type.
  **iw help**
  will print all supported commands, while
  **iw help command**
  will print the help for all matching commands.
  

<a name="see-also"></a>

# See Also

**ip**(8),
**crda**(8),
**regdbdump**(8),
**regulatory.bin**(5)

**http://wireless.kernel.org/en/users/Documentation/iw**
