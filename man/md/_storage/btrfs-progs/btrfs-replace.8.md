# btrfs\-replace(8)

Btrfs v5\&.7, 07/02/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

btrfs-replace - replace devices managed by btrfs with other device.

<a name="synopsis"></a>

# Synopsis

```

 btrfs replace <subcommand> <args>
```

<a name="description"></a>

# Description


**btrfs replace** is used to replace btrfs managed devices with other device.

<a name="subcommand"></a>

# Subcommand


**cancel** _&lt;mount\_point&gt;_
Cancel a running device replace operation.

**start** [-Bfr] _&lt;srcdev&gt;_|_&lt;devid&gt;_ _&lt;targetdev&gt;_ _&lt;path&gt;_
Replace device of a btrfs filesystem.

On a live filesystem, duplicate the data to the target device which is currently stored on the source device. If the source device is not available anymore, or if the -r option is set, the data is built only using the RAID redundancy mechanisms. After completion of the operation, the source device is removed from the filesystem. If the
_&lt;srcdev&gt;_
is a numerical value, it is assumed to be the device id of the filesystem which is mounted at
_&lt;path&gt;_, otherwise it is the path to the source device. If the source device is disconnected, from the system, you have to use the devid parameter format. The
_&lt;targetdev&gt;_
needs to be same size or larger than the
_&lt;srcdev&gt;_.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Note**
.ps -1  
the filesystem has to be resized to fully take advantage of a larger target device; this can be achieved with
**btrfs filesystem resize &lt;devid&gt;:max /path**

**Options**

-r
only read from
_&lt;srcdev&gt;_
if no other zero-defect mirror exists. (enable this if your drive has lots of read errors, the access would be very slow)

-f
force using and overwriting
_&lt;targetdev&gt;_
even if it looks like it contains a valid btrfs filesystem.

A valid filesystem is assumed if a btrfs superblock is found which contains a correct checksum. Devices that are currently mounted are never allowed to be used as the
_&lt;targetdev&gt;_.

-B
no background replace.

**status** [-1] _&lt;mount\_point&gt;_
Print status and progress information of a running device replace operation.

**Options**

-1
print once instead of print continuously until the replace operation finishes (or is cancelled)

<a name="examples"></a>

# Examples


**Example&nbsp;1.&nbsp;Replacing an online drive with a bigger one**

Given the following filesystem mounted at **/mnt/my-vault**

.if n \{.RS 4
.\}
    Label: MyVault*(Aq  uuid: ae20903e-b72d-49ba-b944-901fc6d888a1
            Total devices 2 FS bytes used 1TiB
            devid    1 size 1TiB used 500.00GiB path /dev/sda
            devid    2 size 1TiB used 500.00GiB path /dev/sdb
.if n \{.RE
.\}

In order to replace _/dev/sda_ (_devid 1_) with a bigger drive located at _/dev/sdc_ you would run the following:

.if n \{.RS 4
.\}
    btrfs replace start 1 /dev/sdc /mnt/my-vault/
.if n \{.RE
.\}

You can monitor progress via:

.if n \{.RS 4
.\}
    btrfs replace status /mnt/my-vault/
.if n \{.RE
.\}

After the replacement is complete, as per the docs at **btrfs-filesystem**(8) in order to use the entire storage space of the new drive you need to run:

.if n \{.RS 4
.\}
    btrfs filesystem resize 1:max /mnt/my-vault/
.if n \{.RE
.\}

<a name="exit-status"></a>

# Exit Status


**btrfs replace** returns a zero exit status if it succeeds. Non zero is returned in case of failure.

<a name="availability"></a>

# Availability


**btrfs** is part of btrfs-progs. Please refer to the btrfs wiki \m[blue]**http://btrfs.wiki.kernel.org**\m[] for further details.

<a name="see-also"></a>

# See Also


**mkfs.btrfs**(8), **btrfs-device**(8), **btrfs-filesystem**(8),
