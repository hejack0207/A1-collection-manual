# nvme\-wdc\-vs\-drive(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-vs-drive-info - Send the NVMe WDC vs-drive-info command, return result

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc vs-drive-info <device>

<a name="description"></a>

# Description


For the NVMe device given, send the unique WDC vs-drive-info command and provide the additional drive information.

The &lt;device&gt; parameter is mandatory and must be the NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

On success it returns 0, error code otherwise.

<a name="output-explanation"></a>

# Output Explanation


There are 2 fields returned from this command:

Drive HW Revision

FTL Unit Size

<a name="example"></a>

# Example


# nvme wdc vs-drive-info /dev/nvme0

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
