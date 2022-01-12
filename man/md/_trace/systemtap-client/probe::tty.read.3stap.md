# probe::tty\&.read(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::tty.read - called when a tty line will be read

<a name="synopsis"></a>

# Synopsis

```


```
    tty.read 

<a name="values"></a>

# Values


_driver\_name_
the driver name

_file\_name_
the file name lreated to the tty

_nr_
The amount of characters to be read

_buffer_
the buffer that will receive the characters

<a name="see-alson-"></a>

# See Also\N 

_tapset::tty_(3stap)
