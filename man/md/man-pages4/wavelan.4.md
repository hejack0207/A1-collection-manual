# wavelan(4) - AT&T GIS WaveLAN ISA device driver

Linux, 2017-09-15

```
insmod wavelan_cs.o [io=B,B..] [ irq=I,I..] [name=N,N..]
```

<a name="description"></a>

# Description

_This driver is obsolete:_
it was removed from the kernel in version 2.6.35.

_wavelan_
is the low-level device driver for the NCR / AT&T / Lucent
**WaveLAN ISA**
and Digital (DEC)
**RoamAbout DS**
wireless ethernet adapter.
This driver is available as a module or
might be compiled in the kernel.
This driver supports multiple cards
in both forms (up to 4) and allocates the next available ethernet
device (eth0..eth#) for each card found, unless a device name is
explicitly specified (see below).
This device name will be reported
in the kernel log file with the MAC address, NWID and frequency used
by the card.

<a name="parameters"></a>

### Parameters

This section apply to the module form (parameters passed on the
**insmod**(8)
command line).
If the driver is included in the kernel, use the
_ether=IRQ,IO,NAME_
syntax on the kernel command line.

* **io**  
  Specify the list of base address where to search for wavelan cards
  (setting by dip switch on the card).
  If you don't specify any io
  address, the driver will scan 0x390 and 0x3E0 addresses, which might
  conflict with other hardware...
* **irq**  
  Set the list of irq that each wavelan card should use (the value is
  saved in permanent storage for future use).
* **name**  
  Set the list of name to be used for each wavelan cards device (name
  used by
  **ifconfig**(8)).

<a name="wireless-extensions"></a>

### Wireless extensions

Use
**iwconfig**(8)
to manipulate wireless extensions.

<a name="nwid-or-domain"></a>

### NWID (or domain)

Set the network ID
[_0_
to
_FFFF_]
or disable it
[_off_].
As the NWID is stored in the card Permanent Storage Area, it will be
reuse at any further invocation of the driver.

<a name="frequency-channels"></a>

### Frequency & channels

For the 2.4&nbsp;GHz 2.00 Hardware, you are able to set the frequency by
specifying one of the 10 defined channels
(_2.412,_
_2.422, 2.425, 2.4305, 2.432, 2.442, 2.452, 2.460, 2.462_
or
_2.484_)
or directly by its value.
The frequency is changed immediately and
permanently.
Frequency availability depends on the regulations...

<a name="statistics-spy"></a>

### Statistics spy

Set a list of MAC addresses in the driver (up to 8) and get the last
quality of link for each of those (see
**iwspy**(8)).

<a name="procnetwireless"></a>

### /proc/net/wireless

_status_
is the status reported by the modem.
_Link quality_
reports the quality of the modulation on the air (direct sequence
spread spectrum) [max = 16].
_Level_
and
_Noise_
refer to the signal level and noise level [max = 64].
The
_crypt discarded packet_
and
_misc discarded packet_
counters are not implemented.

<a name="private-ioctl"></a>

### Private ioctl

You may use
**iwpriv**(8)
to manipulate private ioctls.

<a name="quality-and-level-threshold"></a>

### Quality and level threshold

Enable you the define the quality and level threshold used by the
modem (packet below that level are discarded).

<a name="histogram"></a>

### Histogram

This functionality makes it possible to set a number of
signal level intervals and
to count the number of packets received in each of those defined
intervals.
This distribution might be used to calculate the mean value
and standard deviation of the signal level.

<a name="specific-notes"></a>

### Specific notes

This driver fails to detect some
**non-NCR/AT&T/Lucent**
Wavelan cards.
If this happens for you, you must look in the source code on
how to add your card to the detection routine.

Some of the mentioned features are optional.
You may enable to disable
them by changing flags in the driver header and recompile.










<a name="see-also"></a>

# See Also

**wavelan_cs**(4),
**ifconfig**(8),
**insmod**(8),
**iwconfig**(8),
**iwpriv**(8),
**iwspy**(8)

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
