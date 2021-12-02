# nvme\-wdc\-drive\-es(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-drive-essentials - Retrieve WDC devices drive essentials bin files and save to a tar file.

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc drive-essentials <device> [--dir-name=<DIRECTORY>, -d <DIRECTORY>]

<a name="description"></a>

# Description


For the NVMe device given, captures the drive essential bin files and saves them into a tar file. The tar file will be in the following format: DRIVE_ESSENTIALS_&lt;Serial Num&gt;_&lt;FW Revision&gt;_&lt;Date&gt;_&lt;Time&gt;.tar.gz e.g. DRIVE_ESSENTIALS_A00FD8CA_1048_20170713_091731.tar.gz

The &lt;device&gt; parameter is mandatory; NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

<a name="options"></a>

# Options


-d &lt;DIRECTORY&gt;, --dir-name=&lt;DIRECTORY&gt;
Output directory; defaults to current working directory.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the drive essentials data files from the device and saves the tar file in current directory (e.g. DRIVE_ESSENTIALS_A00FD8CA_1048_20170713_091731.tar.gz):

.if n \{.RS 4
.\}
    # nvme wdc drive-essentials /dev/nvme0
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Gets the drive essentials data files from the device and saves the tar file to specified directory (e.g. /tmp/DRIVE_ESSENTIALS_A00FD8CA_1048_20170713_091731):

.if n \{.RS 4
.\}
    # nvme wdc drive-essentials /dev/nvme0 -d /tmp/
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
