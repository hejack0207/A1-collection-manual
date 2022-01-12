# probe::scsi\&.ioentr(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scsi.ioentry - Prepares a SCSI mid-layer request

<a name="synopsis"></a>

# Synopsis

```


```
    scsi.ioentry 

<a name="values"></a>

# Values


_device\_state_
The current state of the device

_device\_state\_str_
The current state of the device, as a string

_req\_addr_
The current struct request pointer, as a number

_disk\_minor_
The minor number of the disk (-1 if no information)

_disk\_major_
The major number of the disk (-1 if no information)

<a name="see-alson-"></a>

# See Also\N 

_tapset::scsi_(3stap)
