# systemd\-boot\-check\-no\-failures\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-boot-check-no-failures.service - verify that the system booted up cleanly

<a name="synopsis"></a>

# Synopsis

```

 systemd-boot-check-no-failures.service 
 /usr/lib/systemd/system-boot-check-no-failures
```

<a name="description"></a>

# Description


systemd-boot-check-no-failures.service
is a system service that checks whether the system booted up successfully. This service implements a very minimal test only: whether there are any failed units on the system. This service is disabled by default. When enabled, it is ordered before
boot-complete.target, thus ensuring the target cannot be reached when the system booted up with failed services.

Note that due the simple nature of this check this service is probably not suitable for deployment in most scenarios. It is primarily useful only as example for developing more fine-grained checks to order before
boot-complete.target.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.special**(1)
