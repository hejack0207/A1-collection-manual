# probe::scsi\&.ioexec(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scsi.ioexecute - Create mid-layer SCSI request and wait for the result

<a name="synopsis"></a>

# Synopsis

```


```
    scsi.ioexecute 

<a name="values"></a>

# Values


_lun_
The lun number

_channel_
The channel number

_request\_bufflen_
The data buffer buffer length

_device\_state\_str_
The current state of the device, as a string

_request\_buffer_
The data buffer address

_host\_no_
The host number

_dev\_id_
The scsi device id

_timeout_
Request timeout in seconds

_data\_direction\_str_
Data direction, as a string

_data\_direction_
The data_direction specifies whether this command is from/to the device.

_retries_
Number of times to retry request

_device\_state_
The current state of the device

<a name="see-alson-"></a>

# See Also\N 

_tapset::scsi_(3stap)
