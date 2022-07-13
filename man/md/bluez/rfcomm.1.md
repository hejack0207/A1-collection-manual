# rfcomm(1) - RFCOMM configuration utility

"", APRIL 28, 2002

```
rfcomm [ options ] < command > < dev >
```

<a name="description"></a>

# Description

**rfcomm**
is used to set up, maintain, and inspect the RFCOMM configuration
of the Bluetooth subsystem in the Linux kernel. If no
**command**
is given, or if the option
**-a**
is used,
**rfcomm**
prints information about the configured RFCOMM devices.

<a name="options"></a>

# Options


* **-h**  
  Gives a list of possible commands.
* **-a**  
  Prints information about all configured RFCOMM devices.
* **-r**  
  Switch TTY into raw mode (doesn't work with "bind").
* **-i**_ &lt;hciX&gt; | &lt;bdaddr&gt;_  
  The command is applied to device hciX, which must be the name or the address of
  an installed Bluetooth device. If not specified, the command will be use the
  first available Bluetooth device.
* **-A**  
  Enable authentification
* **-E**  
  Enable encryption
* **-S**  
  Secure connection
* **-M**  
  Become the master of a piconet
* **-L**_ &lt;seconds&gt;_  
  Set linger timeout

<a name="commands"></a>

# Commands


* **show**_ &lt;dev&gt;_  
  Display the information about the specified device.
* **connect**_ &lt;dev&gt; [bdaddr] [channel]_  
  Connect the RFCOMM device to the remote Bluetooth device on the
  specified channel. If no channel is specified, it will use the
  channel number 1. This command can be terminated with the key
  sequence CTRL-C.
* **listen**_ &lt;dev&gt; [channel] [cmd]_  
  Listen on a specified RFCOMM channel for incoming connections.
  If no channel is specified, it will use the channel number 1, but
  a channel must be specified before cmd. If cmd is given, it will be
  executed as soon as a client connects. When the child process
  terminates or the client disconnect, the command will terminate.
  Occurrences of {} in cmd will be replaced by the name of the device
  used by the connection. This command can be terminated with the key
  sequence CTRL-C.
* **watch**_ &lt;dev&gt; [channel] [cmd]_  
  Watch is identical to
  **listen**
  except that when the child process terminates or the client
  disconnect, the command will restart listening with the same
  parameters.
* **bind**_ &lt;dev&gt; [bdaddr] [channel]_  
  This binds the RFCOMM device to a remote Bluetooth device. The
  command does not establish a connection to the remote device, it
  only creates the binding. The connection will be established right
  after an application tries to open the RFCOMM device. If no channel
  number is specified, it uses the channel number 1.
* **release**_ &lt;dev&gt;_  
  This command releases a defined RFCOMM binding.
  
  If
  **all**
  is specified for the RFCOMM device, then all bindings will be removed.

<a name="author"></a>

# Author

Written by Marcel Holtmann &lt;[marcel@holtmann.org](mailto:marcel@holtmann.org)&gt;.  
