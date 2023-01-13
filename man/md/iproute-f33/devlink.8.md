# devlink(8) - Devlink tool

iproute2, 14 Mar 2016

```

 .in +8 .ti -8 devlink [ OPTIONS ] { dev|port|monitor|sb|resource|region|health|trap } { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 devlink [ -force ]  -batch filename 

```


<a name="options"></a>

# Options



* **-V**,** --Version**  
  Print the version of the
  **devlink**
  utility and exit.
  
* **-b**,** -batch **&lt;FILENAME&gt;  
  Read commands from provided file or standard input and invoke them.
  First failure will cause termination of devlink.
  
* **-force**  
  Don't terminate devlink on errors in batch mode.
  If there were any errors during execution of the commands, the application return code will be non zero.
  
* **-n**,** --no-nice-names**  
  Turn off printing out nice names, for example netdevice ifnames instead of devlink port identification.
  
* **-j**,** --json**  
  Generate JSON output.
  
* **-p**,** --pretty**  
  When combined with -j generate a pretty JSON output.
  
* **-v**,** --verbose**  
  Turn on verbose output.
  
* **-s**,** --statistics**  
  Output statistics.
  
* **-N**,** -Netns **&lt;NETNSNAME&gt;  
  Switches to the specified network namespace.
  
  .SS
  _OBJECT_
  
* **dev**  
  - devlink device.
  
* **port**  
  - devlink port.
  
* **monitor**  
  - watch for netlink messages.
  
* **sb**  
  - devlink shared buffer configuration.
  
* **resource**  
  - devlink device resource configuration.
  
* **region**  
  - devlink address region access
  
* **health**  
  - devlink reporting and recovery
  
* **trap**  
  - devlink trap configuration
  
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

**devlink-dev**(8),
**devlink-port**(8),
**devlink-monitor**(8),
**devlink-sb**(8),
**devlink-resource**(8),
**devlink-region**(8),
**devlink-health**(8),
**devlink-trap**(8),  


<a name="reporting-bugs"></a>

# Reporting Bugs

Report any bugs to the Network Developers mailing list
**&lt;netdev@vger.kernel.org&gt;**
where the development and maintenance is primarily done.
You do not have to be subscribed to the list to send a message there.


<a name="author"></a>

# Author

Jiri Pirko &lt;[jiri@mellanox.com](mailto:jiri@mellanox.com)&gt;
