# iwpriv(8) - configure optionals (private) parameters of a wireless

net-tools, 31 October 1996

network interface




<a name="synopsis"></a>

# Synopsis

```
iwpriv [interface]
iwpriv interface private-command [private-parameters]
iwpriv interface private-command [I] [private-parameters]
iwpriv interface --all
```




<a name="description"></a>

# Description

**Iwpriv**
is the companion tool to
_iwconfig_(8).
**Iwpriv**
deals with parameters and setting specific to each driver (as opposed to
_iwconfig_
which deals with generic ones).

Without any argument,
**iwpriv**
list the available private commands available on each interface, and
the parameters that they require. Using this information, the user may
apply those interface specific commands on the specified interface.

In theory, the documentation of each device driver should indicate how
to use those interface specific commands and their effect.




<a name="parameters"></a>

# Parameters


* _private-command_ [_private-parameters_]  
  Execute the specified
  _private-command_
  on the interface.  
  The command may optionally take or require arguments, and may display
  information. Therefore, the command line parameters may or may not be
  needed and should match the command expectations. The list of commands
  that
  **iwpriv**
  displays (when called without argument) should give you some hints
  about those parameters.  
  However you should refer to the device driver documentation for
  information on how to properly use the command and the effect.
* _private-command _[_I_] [_private-parameters_]  
  Idem, except that
  _I_
  (an integer) is passed to the command as a
  _Token Index_.
  Only some command will use the Token Index (most will ignore it), and
  the driver documentation should tell you when it's needed.
* **-a**/**--all**  
  Execute and display all the private commands that don't take any
  arguments (i.e.  read only).
  
  
  

<a name="display"></a>

# Display

For each device which support private commands,
_iwpriv_
will display the list of private commands available.

This include the name of the private command, the number or arguments
that may be set and their type, and the number or arguments that may
be display and their type.

For example, you may have the following display :  
**eth0      Available private ioctl :**  
**          setqualthr (89F0) : set   1 byte & get   0**  
**          gethisto (89F7) : set   0      & get  16 int**

This indicate that you may set the quality threshold and display an
histogram of up to 16 values with the following commands :  
_  iwpriv eth0 setqualthr 20_  
_  iwpriv eth0 gethisto_




<a name="author"></a>

# Author

Jean Tourrilhes - [jt@hpl.hp](mailto:jt@hpl.hp).com




<a name="files"></a>

# Files

_/proc/net/wireless_




<a name="see-also"></a>

# See Also

**iwconfig**(8),
**iwlist**(8),
**iwevent**(8),
**iwspy**(8),
**wireless**(7).
