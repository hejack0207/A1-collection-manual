# hcidump(1) - Parse HCI data

BlueZ, Nov 12 2002

```
hcidump [-h]
hcidump [option [option...]] [filter]
```


<a name="description"></a>

# Description


.B
hcidump
reads raw HCI data coming from and going to a Bluetooth device (which can be
specified with the option
**-i**,
default is the first available one) and prints to screen commands, events and
data in a human-readable form. Optionally, the dump can be written to a file
rather than parsed, and the dump file can be parsed in a subsequent moment.

<a name="options"></a>

# Options


* **-h**  
  Prints usage info and exits
* **-i**_ &lt;hciX&gt;_  
  Data is read from
  _hciX_,
  which must be the name of an installed Bluetooth device. If not specified,
  and if
  .B
  -r
  option is not set, data is read from the first available Bluetooth device.
* **-l**_ &lt;len&gt;_**, -\^-snap-len=**_&lt;len&gt;_  
  Sets max length of processed packets to
  _len_.
* **-p**_ &lt;psm&gt;_**, -\^-psm=**_&lt;psm&gt;_  
  Sets default Protocol Service Multiplexer to
  _psm_.
* **-m**_ &lt;compid&gt;_**, -\^-manufacturer=**_&lt;compid&gt;_  
  Sets default company id for manufacturer to
  _compid_.
* **-w**_ &lt;file&gt;_**, -\^-save-dump=**_&lt;file&gt;_  
  Parse output is not printed to screen, instead data read from device is saved in file
  _file_.
  The saved dump file can be subsequently parsed with option
  **-r**.
* **-r**_ &lt;file&gt;_**, -\^-read-dump=**_&lt;file&gt;_  
  Data is not read from a Bluetooth device, but from file
  _file_.
  .I
  file
  is created with option
  **-t**, **-\^-timestamp**
  Prepend a time stamp to every packet.
* **-a**, **-\^-ascii**  
  For every packet, not only is the packet type displayed, but also all data in ASCII.
* **-x**, **-\^-hex**  
  For every packet, not only is the packet type displayed, but also all data in hex.
* **-X**, **-\^-ext**  
  For every packet, not only is the packet type displayed, but also all data in hex and ASCII.
* **-R**, **-\^-raw**  
  For every packet, only the raw data is displayed.
* **-C**, **-\^-cmtp=**&lt;psm&gt;  
  Sets the PSM value for the CAPI Message Transport Protocol.
* **-H**, **-\^-hcrp=**&lt;psm&gt;  
  Sets the PSM value for the Hardcopy Control Channel.
* **-O**, **-\^-obex=**&lt;channel&gt;  
  Sets the RFCOMM channel value for the Object Exchange Protocol.
* **-P**, **-\^-ppp=**&lt;channel&gt;  
  Sets the RFCOMM channel value for the Point-to-Point Protocol.
* **-D**, **-\^-pppdump=**&lt;file&gt;  
  Extract PPP traffic with pppdump format.
* **-A**, **-\^-audio=**&lt;file&gt;  
  Extract SCO audio data.
* **-Y**, **-\^-novendor**  
  Don't display any vendor commands or events and don't show any pin code or link key in plain text.

<a name="filters"></a>

# Filters

.B
filter
is a space-separated list of packet categories: available categories are
_lmp_,
_hci_,
_sco_,
_l2cap_,
_rfcomm_,
_sdp_,
_bnep_,
_cmtp_,
_hidp_,
_hcrp_,
_avdtp_,
_avctp_,
_obex_,
_capi_
and
_ppp_.
If filters are used, only packets belonging to the specified categories are
dumped. By default, all packets are dumped.

<a name="authors"></a>

# Authors

Written by Maxim Krasnyansky &lt;[maxk@qualcomm.com](mailto:maxk@qualcomm.com)&gt;
and Marcel Holtmann &lt;[marcel@holtmann.org](mailto:marcel@holtmann.org)&gt;

man page by Fabrizio Gennari &lt;[fabrizio.gennari@philips.com](mailto:fabrizio.gennari@philips.com)&gt;
