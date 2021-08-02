# systemd\-binfmt\&.service(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-binfmt.service, systemd-binfmt - Configure additional binary formats for executables at boot

<a name="synopsis"></a>

# Synopsis

```

 systemd-binfmt.service 
 /usr/lib/systemd/systemd-binfmt
```

<a name="description"></a>

# Description


systemd-binfmt.service
is an early boot service that registers additional binary formats for executables in the kernel.

See
**binfmt.d**(5)
for information about the configuration of this service.

<a name="options"></a>

# Options


**--cat-config**
Copy the contents of config files to standard output. Before each file, the filename is printed as a comment.

**--no-pager**
Do not pipe output into a pager.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

<a name="see-also"></a>

# See Also


**systemd**(1),
**binfmt.d**(5),
**wine**(8)
