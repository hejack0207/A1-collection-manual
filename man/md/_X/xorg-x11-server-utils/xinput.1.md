# xinput(1) - utility to configure and test X input devices

X Version 11, xinput 1.6.2

```
xinput [OPTIONS] [DEVICE]
```


<a name="description"></a>

# Description

xinput is a utility to list available input devices, query information about
a device and change input device settings.

<a name="options"></a>

# Options


* **--version**  
  Test if the X Input extension is available and return the version number
  of the program and the version supported by the server. This option does not
  require a device name.


* **--list [--short || --long || --name-only || --id-only] [_device_]**  
  If no argument is given list all the input devices. If an argument is given,
  show all the features of _device_.
  If --long is provided, the output includes detailed information about the
  capabilities of each devices. Otherwise, or if --short is provided, only the
  device names and some minimal information is listed.
  If --name-only is provided, the output is limited to the device names. One
  device name is listed per line. Note that the order the devices are listed
  is undefined.
  If --id-only is provided, the output is limited to the device IDs. One
  device ID is listed per line. Note that the order the devices are listed is
  undefined.


* **--get-feedbacks _device_**  
  Display the feedbacks of _device_.


* **--set-pointer _device_**  
  Switch _device_ in core pointer.
  This option does nothing on X servers 1.5 and later.


* **--set-mode _device_ _ABSOLUTE|RELATIVE_**  
  Change the mode of _device_.


* **--set-ptr-feedback _device_ _threshold_ _num_ _denom_**  
  Change the pointer acceleration (or feedback) parameters of _device_.
  The xset(1) man page has more details. For X.Org Server 1.7
  and above, there are additional device properties pertaining to pointer
  acceleration. These do not replace, but complement the pointer feedback
  setting.


* **--set-integer-feedback _device_ _index_ _value_**  
  Change the value of an integer feedback of _device_.


* **--set-button-map _device_ _map\_button\_1_ [_map\_button\_2_ [_..._]]**  
  Change the button mapping of _device_. The buttons are specified in
  physical order (starting with button 1) and are mapped to the logical button
  provided. 0 disables a button. The default button mapping for a device is 1
  2 3 4 5 6 etc.


* **--query-state _device_**  
  Query the device state.


* **--list-props _device_ [_device_ [_..._]]**  
  Lists properties that can be set for the given device(s).


* **--set-int-prop _device_ _property_ _format_ _value_**  
  Sets an integer property for the device.  Appropriate values for _format_
  are 8, 16, or 32, depending on the property. Deprecated, use
  **--set-prop**
  instead.


* **--set-float-prop _device_ _property_ _value_**  
  Sets a float property for the device. Deprecated, use
  **--set-prop**
  instead.


* **--set-prop [--type=_atom|float|int_] [--format=_8|16|32_] _device_ _property_ _value_ [...]**  
  Set the property to the given value(s).  If not specified, the format and type
  of the property are left as-is.  The arguments are interpreted according to the
  property type.


* **--watch-props _device_**  
  Prints to standard out when property changes occur.


* **--delete-prop _device_ _property_**  
  Delete the property from the device.


* **--test [-proximity] _device_**  
  Register all extended events from _device_ and enter an endless
  loop displaying events received. If the -proximity is given, ProximityIn
  and ProximityOut are registered.


* **--test-xi2 [--root] [_device_]**  
  Register for a number of XI2 events and display them. If a device is given,
  only events on this device are displayed. If --root is given, events are
  selected on the root window only. Otherwise, a new client window is created
  (similar to xev).


* **--create-master _prefix_ [sendCore] [enable]**  
  Create a new pair of master devices on an XI2-enabled server with the given
  _prefix_. The server will create one master pointer named "_prefix_
  pointer" and one master keyboard named "_prefix_ keyboard".  If
  _sendCore_ is 1, this pair of master devices is set to send core events
  (default).  If _enable_ is 1, this master device pair will be enabled
  immediately (default).


* **--remove-master _master_ [Floating|AttachToMaster] [returnPointer] [returnKeyboard]**  
  Remove _master_  and its paired master device. Attached slave devices
  are set floating if _Floating_ is specified or the argument is omitted.
  If the second argument is _AttachToMaster_, _returnPointer_
  specifies the master pointer to attach all slave pointers to and
  _returnKeyboard_ specifies the master keyboard to attach all slave
  keyboards to.


* **--reattach _slave_ _master_**  
  Reattach _slave_ to _master_.


* **--float _slave_**  
  Remove _slave_ from its current master device.


* **--set-cp _window_ _master_**  
  Set the ClientPointer for the client owning _window_ to _master_.
  _master_ must specify a master pointer.


* **--map-to-output _device_ _crtc_**  
  Restricts the movements of the absolute _device_ to the RandR
  _crtc_. The output name must match a currently connected output (see
  _xrandr(1)_). If the NVIDIA binary driver is
  detected or RandR 1.2 or later is not available, a Xinerama output may be
  specified as "HEAD-N", with N being the Xinerama screen number. This option
  has no effect on relative devices.


* **--enable _device_**  
  Enable the _device_. This call is equivalent to
  **xinput --set-prop device _"Device Enabled"_ 1**


* **--disable _device_**  
  Disable the _device_. This call is equivalent to
  **xinput --set-prop device _"Device Enabled"_ 0**

_device_ can be the device name as a string or the XID of the
device.

_slave_ can be the device name as a string or the XID of a slave
device.

_master_ can be the device name as a string or the XID of a master
device.

_property_ can be the property as a string or the Atom value.


<a name="see-also"></a>

# See Also

X(7), xset(1), xrandr(1)

<a name="copyright"></a>

# Copyright

Copyright 1996,1997, Frederic Lepied.

Copyright 2007, Peter Hutterer.

Copyright 2008, Philip Langdale.

Copyright 2009-2011, Red Hat, Inc.


<a name="authors"></a>

# Authors


    Peter Hutterer <peter.hutterer@who-t.net>
    Philip Langdale, <philipl@alumni.utexas.net>
    Frederic Lepied, France <Frederic.Lepied@sugix.frmug.org>
    Julien Cristau <jcristau@debian.org>
    Thomas Jaeger <ThJaeger@gmail.com>
    and more.
