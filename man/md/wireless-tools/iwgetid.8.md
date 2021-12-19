# iwgetid(8) - Report ESSID, NWID or AP/Cell Address of wireless network

wireless-tools, 02 December 2003

```
iwgetid [interface] [--raw] [--scheme] [--ap] [--freq]
[--mode][--protocol][--channel]

```




<a name="description"></a>

# Description

**iwgetid**
is used to find out the NWID, ESSID or AP/Cell Address of the wireless
network that is currently used. The information reported is the same
as the one shown by
**iwconfig**, but **iwgetid**
is easier to integrate in various scripts.  
By default,
**iwgetid**
will print the
_ESSID_
of the device, and if the device doesn't have any ESSID it will print
its
_NWID_.  
The default formatting output is pretty-print.




<a name="options"></a>

# Options


* **--raw**  
  This option disables pretty-printing of the information. This option
  is orthogonal to the other options (except
  **--scheme**),
  so with the appropriate combination of options you can print the raw
  ESSID, AP Address or Mode.  
  This format is ideal when storing the result of iwgetid as a
  variable in
  _Shell_
  or
  _Perl_
  scripts or to pass the result as an argument on the command line of
  **iwconfig**.
* **--scheme**  
  This option is similar to the previous one, it disables
  pretty-printing of the information and removes all characters that are
  not alphanumerics (like space, punctuation and control characters).  
  The resulting output is a valid Pcmcia scheme identifier (that may be
  used as an argument of the command
  **cardctl scheme**).
  This format is also ideal when using the result of iwgetid as a
  selector in
  _Shell_
  or
  _Perl_
  scripts, or as a file name.
* **--ap**  
  Display the MAC address of the Wireless
  _Access Point_
  or the
  _Cell_.
* **--freq**  
  Display the current
  _frequency_
  or
  _channel_
  used by the interface.
* **--channel**  
  Display the current
  _channel_
  used by the interface. The channel is determined using the current
  frequency and the frequency list provided by the interface.
* **--mode**  
  Display the current
  _mode_
  of the interface.
* **--protocol**  
  Display the
  _protocol name_
  of the interface. This allows to identify all the cards that are
  compatible with each other and accept the same type of configuration.  
  This can also be used to
  _check Wireless Extension support_
  on the interface, as this is the only attribute that all drivers
  supporting Wireless Extension are mandated to support.
  
  
  

<a name="see-also"></a>

# See Also

**iwconfig**(8),
**ifconfig**(8),
**iwspy**(8),
**iwpriv**(8).
