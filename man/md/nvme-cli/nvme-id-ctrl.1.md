# nvme\-id\-ctrl(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-id-ctrl - Send NVMe Identify Controller, return result and structure

<a name="synopsis"></a>

# Synopsis

```


```
    nvme id-ctrl <device> [-v | --vendor-specific] [-b | --raw-binary]
                            [-o <fmt> | --output-format=<fmt>]

<a name="description"></a>

# Description


For the NVMe device given, sends an identify controller command and provides the result and returned structure.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1).

On success, the structure may be returned in one of several ways depending on the option flags; the structure may be parsed by the program or the raw buffer may be printed to stdout.

<a name="options"></a>

# Options


-b, --raw-binary
Print the raw buffer to stdout. Structure is not parsed by program. This overrides the vendor specific and human readable options.

-v, --vendor-specific
In addition to parsing known fields, this option will dump the vendor specific region of the structure in hex with ascii interpretation.

-H, --human-readable
This option will parse and format many of the bit fields into human-readable formats.

-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_,
_json_, or
_binary_. Only one output format can be used at a time.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Has the program interpret the returned buffer and display the known fields in a human readable format:

.if n \{.RS 4
.\}
    # nvme id-ctrl /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  In addition to showing the known fields, has the program to display the vendor unique field:

.if n \{.RS 4
.\}
    # nvme id-ctrl /dev/nvme0 --vendor-specific
    # nvme id-ctrl /dev/nvme0 -v
.if n \{.RE
.\}

The above will dump the
_vs_
buffer in hex since it doesn’t know how to interpret it.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Have the program return the raw structure in binary:

.if n \{.RS 4
.\}
    # nvme id-ctrl /dev/nvme0 --raw-binary > id_ctrl.raw
    # nvme id-ctrl /dev/nvme0 -b > id_ctrl.raw
.if n \{.RE
.\}

It is probably a bad idea to not redirect stdout when using this mode.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Alternatively you may want to send the data to another program that can parse the raw buffer.

.if n \{.RS 4
.\}
    # nvme id-ctrl /dev/nvme0 --raw-binary | nvme_parse_id_ctrl
.if n \{.RE
.\}

The parse program in the above example can be a program that shows the structure in a way you like. The following program is such an example that will parse it and can accept the output through a pipe,
|\*(Aq, as shown in the above example, or you can
cat\*(Aq
a saved output buffer to it.

.if n \{.RS 4
.\}
    /* File: nvme_parse_id_ctrl.c */
    
    #include <linux/nvme.h>
    #include <stdio.h>
    #include <unistd.h>
    
    int main(int argc, char **argv)
    {
            unsigned char buf[sizeof(struct nvme_id_ctrl)];
            struct nvme_id_ctrl *ctrl = (struct nvme_id_ctrl *)buf;
    
            if (read(STDIN_FILENO, buf, sizeof(buf)))
                    return 1;
    
            printf("vid   : %#xen", ctrl->vid);
            printf("ssvid : %#xen", ctrl->ssvid);
            return 0;
    }
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
