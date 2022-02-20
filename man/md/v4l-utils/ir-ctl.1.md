# ir\-ctl(1) - a swiss\-knife tool to handle raw IR and to set lirc options

v4l-utils 1.16.7, Tue Jul 5 2016

```
ir-ctl [OPTION]...
ir-ctl [OPTION]... --features
ir-ctl [OPTION]... --send [pulse and space file to send]
ir-ctl [OPTION]... --scancode [protocol and scancode to send]
ir-ctl [OPTION]... --receive [save to file]
```

<a name="description"></a>

# Description

ir-ctl is a tool that allows one to list the features of a lirc device,
set its options, receive raw IR, send raw IR or send complete IR scancodes.

Note: You need to have read or write permissions on the /dev/lirc device
for options to work.

<a name="options"></a>

# Options


* **-d**, **--device**=_DEV_  
  lirc device to control, /dev/lirc0 by default
* **-f**, **--features**  
  List the features of the lirc device.
* **-r**, **--receive**=[_FILE_]  
  Receive IR and print to standard output if no file is specified, else
  save to the filename.
* **-s**, **--send**=_FILE_  
  Send IR in text file. It must be in the format described below. If this
  option is specified multiple times, send all files in-order with a 125ms gap
  between them. The gap length can be modified with **--gap**.
* **-S**, **--scancode**=_PROTOCOL:SCANCODE_  
  Send the IR scancode in the protocol specified. The protocol must one of the
  protocols listed below, followed by a colon and the scancode number. If this
  option is specified multiple times, send all scancodes in-order with a 125ms
  gap between them. The gap length can be modified with **--gap**.
* **-1**, **--oneshot**  
  When receiving, stop receiving after the first message, i.e. after a space or
  timeout of more than 19ms is received.
* **-w**, **--wideband**  
  Use the wideband receiver if available on the hardware. This is also
  known as learning mode. The measurements should be more precise and any
  carrier frequency should be accepted.
* **-n**, **--no-wideband**  
  Switches back to the normal, narrowband receiver if the wideband receiver
  was enabled.
* **-R**, **--carrier-range**=_RANGE_  
  Set the accepted carrier range for the narrowband receiver. It should be
  specified in the form _30000-50000_.
* **-m**, **--measure-carrier**  
  If the hardware supports it, report what the carrier frequency is on
  receiving. You will get the keyword _carrier_ followed by the frequency.
  This might use the wideband receiver although this is hardware specific.
* **-M**, **--no-measure-carrier**  
  Disable reporting of the carrier frequency. This should make it possible
  to use the narrowband receiver. This is the default.
* **-t**, **--timeout**=_TIMEOUT_  
  Set the length of a space at which the receiver goes idle, specified in
  microseconds.
* **-c**, **--carrier**=_CARRIER_  
  Sets the send carrier frequency.
* **-D**, **--duty-cycle**=_DUTY_  
  Set the duty cycle for sending in percent if the hardware support it.
* **-e**, **--emitters**=_EMITTERS_  
  Comma separated list of emitters to use for sending. The first emitter is
  number 1. Some devices only support enabling one emitter (the winbond-cir
  driver).
* **-g**, **--gap**=_GAP_  
  Set the gap between scancodes or the gap between files when multiple files
  are specified on the command line. The default is 125000 microseconds.
* **-?**, **--help**  
  Prints the help message
* **--usage**  
  Give a short usage message
* **-v**, **--verbose**  
  Verbose output; this prints the IR before sending.
* **-V**, **--version**  
  print the v4l2-utils version


<a name="format-of-pulse-and-space-file"></a>

### Format of pulse and space file

When sending IR, the format of the file should be as follows. A comment
start with #. The carrier frequency can be specified as:

	carrier 38000

The file should contain alternating lines with pulse and space, followed
by length in microseconds. The following is a rc-5 encoded message:

	carrier 36000  
	pulse 940  
	space 860  
	pulse 1790  
	space 1750  
	pulse 880  
	space 880  
	pulse 900  
	space 890  
	pulse 870  
	space 900  
	pulse 1750  
	space 900  
	pulse 890  
	space 910  
	pulse 840  
	space 920  
	pulse 870  
	space 920  
	pulse 840  
	space 920  
	pulse 870  
	space 1810  
	pulse 840

Rather than specifying the raw IR, you can also specify the scancode and
protocol you want to send. This will also automatically set the correct
carrier. The above can be written as:

	scancode rc5:0x1e01

If multiple scancodes are specified in a file, a gap is inserted between
scancodes if there is no space between then (see **--gap**). One file
can only have one carrier frequency, so this might cause problems
if different protocols are specified in one file if they use different
carrier frequencies.

Note that there are device-specific limits of how much IR can be sent
at a time. This can be both the length of the IR and the number of
different lengths of space and pulse.


<a name="supported-protocols"></a>

### Supported Protocols

A scancode with protocol can be specified on the command line or in the
pulse and space file. The following protocols are supported:
**rc5**, **rc5x\_20**, **rc5\_sz**, **jvc**, **sony12**,
**sony15**, **sony20**, **nec**, **necx**, **nec32**,
**sanyo**, **rc6\_0**, **rc6\_6a\_20**, **rc6\_6a\_24**, **rc6\_6a\_32**,
**rc6\_mce**, **sharp**.
If the scancode starts with 0x it will be interpreted as a
hexadecimal number, and if it starts with 0 it will be interpreted as an
octal number.


<a name="wideband-and-narrowband-receiver"></a>

### Wideband and narrowband receiver

Most IR receivers have a narrowband and wideband receiver. The narrowband
receiver can receive over longer distances (usually around 10 metres without
interference) and is limited to certain carrier frequencies.

The wideband receiver is for higher precision measurements and when the
carrier frequency is unknown; however it only works over very short
distances (about 5 centimetres). This is also known as **learning mode**.

For most drivers, enabling **carrier reports** using **-m** also enables
the wideband receiver.

<a name="global-state"></a>

### Global state

All the options which can be set for lirc devices are maintained until
the device is powered down or a new option is set.

<a name="exit-status"></a>

# Exit Status

On success, it returns 0. Otherwise, it will return the error code.

<a name="examples"></a>

# Examples

To list all capabilities of /dev/lirc2:  
	**ir-ctl -f -d /dev/lirc2**

To show the IR of the first button press on a remote in learning mode:  
	**ir-ctl -r -m -w**

Note that **ir-ctl -rmw** would receive to a file called **mw**.

To restore the normal (longer distance) receiver:  
	**ir-ctl -n -M**

To send the pulse and space file **play** on emitter 3:  
	**ir-ctl -e 3 --send=play**

To send the rc-5 hauppauge '1' scancode:  
	ir-ctl -S rc5:0x1e01

<a name="bugs"></a>

# Bugs

Report bugs to **Linux Media Mailing List &lt;linux-media@vger.kernel.org&gt;**

<a name="copyright"></a>

# Copyright

Copyright (c) 2016 by Sean Young.

License GPLv2: GNU GPL version 2 &lt;http://gnu.org/licenses/gpl.html&gt;.  
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
