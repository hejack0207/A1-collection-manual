# bccmd(1) - Utility for the CSR BCCMD interface

BlueZ, Jun 20 2006

```
bccmd
bccmd [-t <transport>] [-d <device>] <command> [<args>]
bccmd [-h --help]

```

<a name="description"></a>

# Description

.B
bccmd
issues BlueCore commands to
.B
Cambridge Silicon Radio
devices. If run without the &lt;command&gt; argument, a short help page will be displayed.

<a name="options"></a>

# Options


* **-t&nbsp;&lt;transport&gt;**  
  Specify the communication transport. Valid options are:
    * **HCI**  
      Local device with Host Controller Interface (default).
    * **USB**  
      Direct USB connection.
    * **BCSP**  
      Blue Core Serial Protocol.
    * **H4**  
      H4 serial protocol.
    * **3WIRE**  
      3WIRE protocol (not implemented).
      .SH
    * **-d&nbsp;&lt;dev&gt;**  
      Specify a particular device to operate on. If not specified, default is the first available HCI device
      or /dev/ttyS0 for serial transports.

<a name="commands"></a>

# Commands


* **builddef**  
  Get build definitions
* **keylen&nbsp;&lt;handle&gt;**  
  Get current crypt key length
* **clock**  
  Get local Bluetooth clock
* **rand**  
  Get random number
* **chiprev**  
  Get chip revision
* **buildname**  
  Get the full build name
* **panicarg**  
  Get panic code argument
* **faultarg**  
  Get fault code argument
* **coldreset**  
  Perform cold reset
* **warmreset**  
  Perform warm reset
* **disabletx**  
  Disable TX on the device
* **enabletx**  
  Enable TX on the device
* **singlechan&nbsp;&lt;channel&gt;**  
  Lock radio on specific channel
* **hoppingon**  
  Revert to channel hopping
* **rttxdata1&nbsp;&lt;decimal&nbsp;freq&nbsp;MHz&gt;&nbsp;&lt;level&gt;**  
  TXData1 radio test
* **radiotest&nbsp;&lt;decimal&nbsp;freq&nbsp;MHz&gt;&nbsp;&lt;level&gt;&nbsp;&lt;id&gt;**  
  Run radio tests, tests 4, 6 and 7 are transmit tests
* **memtypes**  
  Get memory types
* **psget&nbsp;[-r]&nbsp;[-s&nbsp;&lt;stores&gt;]&nbsp;&lt;key&gt;**  
  Get value for PS key.
  -r sends a warm reset afterwards
* **psset&nbsp;[-r]&nbsp;[-s&nbsp;&lt;stores&gt;]&nbsp;&lt;key&gt;&nbsp;&lt;value&gt;**  
  Set value for PS key.
  -r sends a warm reset afterwards
* **psclr&nbsp;[-r]&nbsp;[-s&nbsp;&lt;stores&gt;]&nbsp;&lt;key&gt;**  
  Clear value for PS key.
  -r sends a warm reset afterwards
* **pslist&nbsp;[-r]&nbsp;[-s&nbsp;&lt;stores&gt;]**  
  List all PS keys.
  -r sends a warm reset afterwards
* **psread&nbsp;[-r]&nbsp;[-s&nbsp;&lt;stores&gt;]**  
  Read all PS keys.
  -r sends a warm reset afterwards
* **psload&nbsp;[-r]&nbsp;[-s&nbsp;&lt;stores&gt;]&nbsp;&lt;file&gt;**  
  Load all PS keys from PSR file.
  -r sends a warm reset afterwards
* **pscheck&nbsp;[-r]&nbsp;[-s&nbsp;&lt;stores&gt;]&nbsp;&lt;file&gt;**  
  Check syntax of PSR file.
  -r sends a warm reset afterwards

<a name="keys"></a>

# Keys

bdaddr country devclass keymin keymax features commands version
remver hciextn mapsco baudrate hostintf anafreq anaftrim usbvid
usbpid dfupid bootmode

<a name="authors"></a>

# Authors

Written by Marcel Holtmann &lt;[marcel@holtmann.org](mailto:marcel@holtmann.org)&gt;,
man page by Adam Laurie &lt;[adam@algroup.co](mailto:adam@algroup.co).uk&gt;

