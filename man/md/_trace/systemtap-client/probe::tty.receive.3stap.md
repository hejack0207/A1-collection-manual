# probe::tty\&.receive(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::tty.receive - called when a tty receives a message

<a name="synopsis"></a>

# Synopsis

```


```
    tty.receive 

<a name="values"></a>

# Values


_cp_
the buffer that was received

_count_
The amount of characters received

_name_
the name of the module file

_index_
The tty Index

_id_
the tty id

_fp_
The flag buffer

_driver\_name_
the driver name

<a name="see-alson-"></a>

# See Also\N 

_tapset::tty_(3stap)
