# cec-follower(1) - An application to emulate CEC followers

v4l-utils 1.16.7, August 2016

```
cec-follower [-h] [-d <dev>] [other options]
```

<a name="description"></a>

# Description

The **cec-follower** tool is used to emulate CEC followers. Based on the configured
logical address(es) of the CEC device it will emulate the CEC behavior
accordingly.

Configuring the CEC device is done using **cec-ctl**. Certain CEC functionalities
are only emulated if the corresponding Device Features flag is set (these are set
when configuring with **cec-ctl**). These are:

    - Audio Return Channel (RX and TX)
    - Audio Rate Control
    - Deck Control
    - Record TV screen

**cec-follower** is basically a message loop, waiting for messages to arrive
and taking the appropriate action for each message (incoming messages can be
shown with the _--show-msgs_ option). The follower maintains an internal
state with appropriate parameters such as volume, current active source, power
state and so on (state changes can be shown with the _--show-state_ option).

It also aims to be a reference implementation on how a follower should behave.

**cec-follower** will keep track of incoming messages and look for violations
of the CEC specification with regards to timings. For example, it will warn if
it receives the same message again within 200ms after it replied &lt;Feature Abort&gt;
["Unrecognized Opcode"] to that message, and it will check that press and hold
behavior is done properly.

**cec-follower** will periodically send out polling messages to discover when
a remote device is removed or a new one has appeared. When a device is removed,
the recorded information about it is cleared. Each logical address is polled
about once every 15 seconds. In between polls, removing a remote device or
replacing it with a new one is not detected.

When running compliance tests with **cec-compliance**, **cec-follower**
should be run on the same device to act on incoming messages that are not replies
to messages sent by the compliance tool. Before each test-run **cec-follower**
should be restarted if it is running, to initialize the emulated device with a
clean and known initial state.

<a name="options"></a>

# Options


* **-d**, **--device** _&lt;dev&gt;_  
  Use device &lt;dev&gt; as the CEC device. If &lt;dev&gt; is a number, then /dev/cec&lt;dev&gt; is used.
* **-v**, **--verbose**  
  Turn on verbose reporting.
* **-w**, **--wall-clock**  
  Show timestamps as wall-clock time. This also turns on verbose reporting. 
* **-T**, **--trace**  
  Trace all called ioctls. Useful for debugging.
* **-h**, **--help**  
  Prints the help message.
* **-n**, **--no-warnings**  
  Turn off warning messages.
* **-m**, **--show-msgs**  
  Show received messages.
* **-s**, **--show-state**  
  Show state changes from the emulated device.

<a name="exit-status"></a>

# Exit Status

On success, it returns 0. Otherwise, it will return the error code.

<a name="bugs"></a>

# Bugs

This manual page is a work in progress.

Bug reports or questions about this utility should be sent to the linux-media@vger.kernel.org
mailinglist.

<a name="see-also"></a>

# See Also

**cec-compliance**(1), **cec-ctl**(1)
