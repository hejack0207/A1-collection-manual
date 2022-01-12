# probe::scsi\&.iocomp(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scsi.iocompleted - SCSI mid-layer running the completion processing for block device I/O requests

<a name="synopsis"></a>

# Synopsis

```


```
    scsi.iocompleted 

<a name="values"></a>

# Values


_goodbytes_
The bytes completed

_device\_state\_str_
The current state of the device, as a string

_lun_
The lun number

_channel_
The channel number

_device\_state_
The current state of the device

_data\_direction_
The data_direction specifies whether this command is from/to the device

_req\_addr_
The current struct request pointer, as a number

_data\_direction\_str_
Data direction, as a string

_dev\_id_
The scsi device id

_host\_no_
The host number

<a name="see-alson-"></a>

# See Also\N 

_tapset::scsi_(3stap)
