# probe::scsi\&.iodisp(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scsi.iodispatching - SCSI mid-layer dispatched low-level SCSI command

<a name="synopsis"></a>

# Synopsis

```


```
    scsi.iodispatching 

<a name="values"></a>

# Values


_device\_state\_str_
The current state of the device, as a string

_request\_bufflen_
The request buffer length

_lun_
The lun number

_channel_
The channel number

_device\_state_
The current state of the device

_req\_addr_
The current struct request pointer, as a number

_data\_direction_
The data_direction specifies whether this command is from/to the device 0 (DMA_BIDIRECTIONAL), 1 (DMA_TO_DEVICE), 2 (DMA_FROM_DEVICE), 3 (DMA_NONE)

_data\_direction\_str_
Data direction, as a string

_dev\_id_
The scsi device id

_host\_no_
The host number

_request\_buffer_
The request buffer address

<a name="see-alson-"></a>

# See Also\N 

_tapset::scsi_(3stap)
