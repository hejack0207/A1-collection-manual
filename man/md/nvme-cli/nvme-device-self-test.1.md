# nvme\-device\-self\-(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-device-self-test - Perform the necessary tests to observe the performance and the parameters

<a name="synopsis"></a>

# Synopsis

```


```
    nvme device-self-test <device> [--namespace-id=<NUM> | -n <NUM>]
                            [--self-test-code=<NUM> | -s <NUM>]

<a name="description"></a>

# Description


Initiates the required test based on the user input.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the corresponding test is initiated.

<a name="options"></a>

# Options


-n &lt;NUM&gt;, --namespace-id=&lt;NUM&gt;
Indicate the namespace in which the device self-test has to becarried out

-s &lt;NUM&gt;, --self-test-code=&lt;NUM&gt;
This field specifies the action taken by the device self-test command : 1h: Start a short device self-test operation 2h: Start a extended device self-test operation eh: Start a vendor specific device self-test operation fh: abort the device self-test operation

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Start a short device self-test in the namespace-id 1:

.if n \{.RS 4
.\}
    # nvme device-self-test /dev/nvme0 -n 1 -s 1
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Abort the device self-test operation in the namespace-id 1:

.if n \{.RS 4
.\}
    # nvme device-self-test /dev/nvme0 -n 1 -s 0xf
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
