# probe::scsi\&.iodone(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scsi.iodone - SCSI command completed by low level driver and enqueued into the done queue.

<a name="synopsis"></a>

# Synopsis

```


```
    scsi.iodone 

<a name="values"></a>

# Values


_lun_
The lun number

_channel_
The channel number

_device\_state\_str_
The current state of the device, as a string

_scsi\_timer\_pending_
1 if a timer is pending on this request

_dev\_id_
The scsi device id

_host\_no_
The host number

_device\_state_
The current state of the device

_req\_addr_
The current struct request pointer, as a number

_data\_direction_
The data_direction specifies whether this command is from/to the device.

_data\_direction\_str_
Data direction, as a string

<a name="see-alson-"></a>

# See Also\N 

_tapset::scsi_(3stap)
