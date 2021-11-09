# probe::scsi\&.set_st(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::scsi.set_state - Order SCSI device state change

<a name="synopsis"></a>

# Synopsis

```


```
    scsi.set_state 

<a name="values"></a>

# Values


_state_
The new state of the device

_host\_no_
The host number

_dev\_id_
The scsi device id

_old\_state\_str_
The current state of the device, as a string

_state\_str_
The new state of the device, as a string

_lun_
The lun number

_old\_state_
The current state of the device

_channel_
The channel number

<a name="see-alson-"></a>

# See Also\N 

_tapset::scsi_(3stap)
