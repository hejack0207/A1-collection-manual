# devlink\-health(8) - devlink health reporting and recovery

iproute2, 20 Feb 2019

```

 .in +8 .ti -8 devlink [ OPTIONS ] health  { COMMAND |  help } 

</synopsis>

<synopsis>
.ti -8 OPTIONS := {  -V[ersion] }
</synopsis>

<synopsis>
.ti -8 devlink health show [ DEV"" reporter ""REPORTER ] 
</synopsis>

<synopsis>
.ti -8 devlink health recover ""DEV"" reporter ""REPORTER""
</synopsis>

<synopsis>
.ti -8 devlink health diagnose ""DEV"" reporter ""REPORTER""
</synopsis>

<synopsis>
.ti -8 devlink health dump show ""DEV""  reporter ""REPORTER""
</synopsis>

<synopsis>
.ti -8 devlink health dump clear ""DEV"" reporter ""REPORTER""
</synopsis>

<synopsis>
.ti -8 devlink health set ""DEV"" reporter ""REPORTER"" [ grace_period MSEC ] [ auto_recover { true | false }  ] [ auto_dump { true | false }  ]
</synopsis>

<synopsis>
.ti -8 devlink health help
```


<a name="description"></a>

# Description


<a name="devlink-health-show-show-status-and-configuration-on-all-supported-reporters-on-all-devlink-devices"></a>

### devlink health show - Show status and configuration on all supported reporters on all devlink devices.



_DEV_
- specifies the devlink device.


_REPORTER_
- specifies the reporter's name registered on the devlink device.


<a name="devlink-health-recover-initiate-a-recovery-operation-on-a-reporter"></a>

### devlink health recover - Initiate a recovery operation on a reporter.

This action performs a recovery and increases the recoveries counter on success.


_DEV_
- specifies the devlink device.


_REPORTER_
- specifies the reporter's name registered on the devlink device.


<a name="devlink-health-diagnose-retrieve-diagnostics-data-on-a-reporter"></a>

### devlink health diagnose - Retrieve diagnostics data on a reporter.



_DEV_
- specifies the devlink device.


_REPORTER_
- specifies the reporter's name registered on the devlink device.


<a name="devlink-health-dump-show-display-the-last-saved-dump"></a>

### devlink health dump show - Display the last saved dump.



devlink health saves a single dump per reporter. If an dump is

not already stored by the Devlink, this command will generate a new

dump. The dump can be generated either automatically when a

reporter reports on an error or manually at the user's request.


_DEV_
- specifies the devlink device.


_REPORTER_
- specifies the reporter's name registered on the devlink device.


<a name="devlink-health-dump-clear-delete-the-saved-dump"></a>

### devlink health dump clear - Delete the saved dump.

Deleting the saved dump enables a generation of a new dump on

the next "devlink health dump show" command.


_DEV_
- specifies the devlink device.


_REPORTER_
- specifies the reporter's name registered on the devlink device.


<a name="devlink-health-set-configure-health-reporter"></a>

### devlink health set - Configure health reporter.

Please note that some params are not supported on a reporter which
doesn't support a recovery or dump method.


_DEV_
- specifies the devlink device.


_REPORTER_
- specifies the reporter's name registered on the devlink device.


* **grace_period**_ MSEC _  
  Time interval between consecutive auto recoveries.
  
* **auto_recover** { **true** | **false** }   
  Indicates whether the devlink should execute automatic recover on error.
  
* **auto_dump** { **true** | **false** }   
  Indicates whether the devlink should execute automatic dump on error.
  

<a name="examples"></a>

# Examples


devlink health show
List status and configuration of available reporters on devices.

devlink health recover pci/0000:00:09.0 reporter tx
Initiate recovery on tx reporter registered on pci/0000:00:09.0.

devlink health diagnose pci/0000:00:09.0 reporter tx
List diagnostics data on the specified device and reporter.

devlink health dump show pci/0000:00:09.0 reporter tx
Display the last saved dump on the specified device and reporter.

devlink health dump clear pci/0000:00:09.0 reporter tx
Delete saved dump on the specified device and reporter.

devlink health set pci/0000:00:09.0 reporter tx grace_period 3500
Set time interval between auto recoveries to minimum of 3500 msec on
the specified device and reporter.

devlink health set pci/0000:00:09.0 reporter tx auto_recover false
Turn off auto recovery on the specified device and reporter.

<a name="see-also"></a>

# See Also

**devlink**(8),
**devlink-dev**(8),
**devlink-port**(8),
**devlink-param**(8),
**devlink-region**(8),  


<a name="author"></a>

# Author

Aya Levin &lt;[ayal@mellanox.com](mailto:ayal@mellanox.com)&gt;
