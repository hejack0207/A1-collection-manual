# nvme\-disconnect\-al(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-disconnect-all - Disconnect from all connected Fabrics controllers.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme disconnect-all

<a name="description"></a>

# Description


Disconnects and removes all existing NVMe over Fabrics controllers.

See the documentation for the nvme-disconnect(1) command for further background.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Disconnect all existing nvme controllers:

.if n \{.RS 4
.\}
    # nvme disconnect-all
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


nvme-disconnect(1)

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
