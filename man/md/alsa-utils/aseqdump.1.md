# aseqdump(1) - show the events received at an ALSA sequencer port

19 Feb 2005

```
aseqdump [-p client:port,...]
```


<a name="description"></a>

# Description

**aseqdump**
is a command-line utility that prints the sequencer events it receives as text.

To stop receiving, press Ctrl+C.


<a name="options"></a>

# Options



* _-h,--help_  
  Prints a list of options.
  
* _-V,--version_  
  Prints the current version.
  
* _-l,--list_  
  Prints a list of possible input ports.
  
* _-p,--port=client:port,..._  
  Sets the sequencer port(s) from which events are received.
  
  A client can be specified by its number, its name, or a prefix of its
  name.  A port is specified by its number; for port 0 of a client, the
  ":0" part of the port specification can be omitted.
  

<a name="author"></a>

# Author

Clemens Ladisch &lt;[clemens@ladisch.de](mailto:clemens@ladisch.de)&gt;
