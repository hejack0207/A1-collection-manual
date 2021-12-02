# nvme\-disconnect(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-disconnect - Disconnect one or more Fabrics controller(s).

<a name="synopsis"></a>

# Synopsis

```


```
    nvme disconnect
                    [--nqn=<subnqn>           | -n <subnqn>]
                    [--device=<device>        | -d <device>]

<a name="description"></a>

# Description


Disconnects and removes one or more existing NVMe over Fabrics controllers. If the --nqn option is specified all controllers connecting to the Subsystem identified by subnqn will be removed. If the --device option is specified the controller specified by the --device option will be removed.

<a name="options"></a>

# Options


-n &lt;subnqn&gt;, --nqn &lt;subnqn&gt;
Indicates that all controllers for the NVMe subsystems specified should be removed.

-d &lt;device&gt;, --device &lt;device&gt;
Indicates that the controller with the specified name should be removed.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Disconnect all controllers for a subsystem named nqn.2014-08.com.example:nvme:nvm-subsystem-sn-d78432:

.if n \{.RS 4
.\}
    # nvme disconnect --nqn=nqn.2014-08.com.example:nvme:nvm-subsystem-sn-d78432
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Disconnect the controller nvme4

.if n \{.RS 4
.\}
    # nvme disconnect --device=nvme4
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


nvme-connect(1)

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
