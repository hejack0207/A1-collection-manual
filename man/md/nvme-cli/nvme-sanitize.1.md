# nvme\-sanitize(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-sanitize - Send NVMe Sanitize Command, return result

<a name="synopsis"></a>

# Synopsis

```


```
    nvme sanitize <device> [--no-dealloc | -d]
                  [--oipbp | -i]
                  [--owpass=<overwrite-pass-count> | -n <overwrite-pass-count>]
                  [--ause | -u]
                  [--sanact=<action> | -a <action>]
                  [--ovrpat=<overwrite-pattern> | -p <overwrite-pattern>]

<a name="description"></a>

# Description


For the NVMe device given, sends a Sanitize command and provides the result.

The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).

On success it returns 0, error code otherwise.

<a name="options"></a>

# Options


-d, --no-delloc
No Deallocate After Sanitize: If set, then the controller shall not deallocate any logical blocks as a result of successfully completing the sanitize operation. If cleared, then the controller should deallocate logical blocks as a result of successfully completing the sanitize operation. This bit shall be ignored if the Sanitize Action field is set to 001b (i.e., Exit Failure Mode).

-i, --oipbp
Overwrite Invert Pattern Between Passes: If set, then the Overwrite Pattern shall be inverted between passes. If cleared, then the overwrite pattern shall not be inverted between passes. This bit shall be ignored unless the Sanitize Action field is set to 011b (i.e., Overwrite).

-n &lt;overwrite-pass-count&gt;, --owpass=&lt;overwrite-pass-count&gt;
Overwrite Pass Count: This field specifies the number of overwrite passes (i.e., how many times the media is to be overwritten) using the data from the Overwrite Pattern field of this command. A value of 0 specifies 16 overwrite passes. This field shall be ignored unless the Sanitize Action field is set to 011b (i.e., Overwrite).

-u, --ause
Allow Unrestricted Sanitize Exit: If set, then the sanitize operation is performed in unrestricted completion mode. If cleared then the sanitize operation is performed in restricted completion mode. This bit shall be ignored if the Sanitize Action field is set to 001b (i.e., Exit Failure Mode).

-a &lt;action&gt;, --sanact=&lt;action&gt;
Sanitize Action: 000b - Reserved 001b - Exit Failure Mode 010b - Start a Block Erase sanitize operation 011b - Start an Overwrite sanitize operation 100b - Start a Crypto Erase sanitize operation

-p &lt;overwrite-pattern&gt;, --ovrpat=&lt;overwrite-pattern&gt;
Overwrite Pattern: This field is ignored unless the Sanitize Action field in Command Dword 10 is set to 011b (i.e., Overwrite). This field specifies a 32-bit pattern that is used for the Overwrite sanitize operation.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Has the program issue Sanitize Command :

.if n \{.RS 4
.\}
    # nvme sanitize /dev/nvme0n1 -a 0x02
    # nvme sanitize /dev/nvme0n1 --sanact=0x01
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
