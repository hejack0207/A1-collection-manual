# systemd\-random\-seed\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-random-seed.service, systemd-random-seed - Load and save the system random seed at boot and shutdown

<a name="synopsis"></a>

# Synopsis

```

 systemd-random-seed.service 
 /usr/lib/systemd/random-seed
```

<a name="description"></a>

# Description


systemd-random-seed.service
is a service that restores the random seed of the system at early boot and saves it at shutdown. See
**random**(4)
for details. Saving/restoring the random seed across boots increases the amount of available entropy early at boot. On disk the random seed is stored in
/var/lib/systemd/random-seed.

<a name="see-also"></a>

# See Also


**systemd**(1),
**random**(4)
