# systemd\-sysv\-generator(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-sysv-generator - Unit generator for SysV init scripts

<a name="synopsis"></a>

# Synopsis

```

 /usr/lib/systemd/system-generators/systemd-sysv-generator
```

<a name="description"></a>

# Description


systemd-sysv-generator
is a generator that creates wrapper .service units for
\m[blue]**SysV init**\m[]\s-2\u[1]\d\s+2
scripts in
/etc/init.d/*
at boot and when configuration of the system manager is reloaded. This will allow
**systemd**(1)
to support them similarly to native units.

\m[blue]**LSB headers**\m[]\s-2\u[2]\d\s+2
in SysV init scripts are interpreted, and the ordering specified in the header is turned into dependencies between the generated unit and other units. The LSB facilities
"$remote_fs",
"$network",
"$named",
"$portmap",
"$time"
are supported and will be turned into dependencies on specific native systemd targets. See
**systemd.special**(5)
for more details.

SysV runlevels have corresponding systemd targets (runlevel_X_.target). The wrapper unit that is generated will be wanted by those targets which correspond to runlevels for which the script is enabled.

**systemd**
does not support SysV scripts as part of early boot, so all wrapper units are ordered after
basic.target.

systemd-sysv-generator
implements
**systemd.generator**(7).

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.service**(5),
**systemd.target**(5)

<a name="notes"></a>

# Notes


*  1.  
  SysV init
      https://savannah.nongnu.org/projects/sysvinit
*  2.  
  LSB headers
      http://refspecs.linuxbase.org/LSB_3.1.1/LSB-Core-generic/LSB-Core-generic/iniscrptact.html
