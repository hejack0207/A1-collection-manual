# systemd\-hibernate\-resume@\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-hibernate-resume@.service, systemd-hibernate-resume - Resume from hibernation

<a name="synopsis"></a>

# Synopsis

```

 systemd-hibernate-resume@.service 
 /usr/lib/systemd/systemd-hibernate-resume
```

<a name="description"></a>

# Description


systemd-hibernate-resume@.service
initiates the resume from hibernation. It is instantiated with the device to resume from as the template argument.

systemd-hibernate-resume
only supports the in-kernel hibernation implementation, known as
\m[blue]**swsusp**\m[]\s-2\u[1]\d\s+2. Internally, it works by writing the major:minor of specified device node to
/sys/power/resume.

Failing to initiate a resume is not an error condition. It may mean that there was no resume image (e. g. if the system has been simply powered off and not hibernated). In such case, the boot is ordinarily continued.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd-hibernate-resume-generator**(8)

<a name="notes"></a>

# Notes


*  1.  
  swsusp
      https://www.kernel.org/doc/Documentation/power/swsusp.txt
