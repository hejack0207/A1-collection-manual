# systemd\-cgls(1)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-cgls - Recursively show control group contents

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-cgls&nbsp;'u systemd-cgls [OPTIONS...] [CGROUP...] .HP \w'systemd-cgls&nbsp;'u systemd-cgls [OPTIONS...] --unit|--user-unit [UNIT...]
```

<a name="description"></a>

# Description


**systemd-cgls**
recursively shows the contents of the selected Linux control group hierarchy in a tree. If arguments are specified, shows all member processes of the specified control groups plus all their subgroups and their members. The control groups may either be specified by their full file paths or are assumed in the systemd control group hierarchy. If no argument is specified and the current working directory is beneath the control group mount point
/sys/fs/cgroup, shows the contents of the control group the working directory refers to. Otherwise, the full systemd control group hierarchy is shown.

By default, empty control groups are not shown.

<a name="options"></a>

# Options


The following options are understood:

**--all**
Do not hide empty control groups in the output.

**-l**, **--full**
Do not ellipsize process tree members.

**-u**, **--unit**
Show cgroup subtrees for the specified units.

**--user-unit**
Show cgroup subtrees for the specified user units.

**-k**
Include kernel threads in output.

**-M ****MACHINE**, **--machine=****MACHINE**
Limit control groups shown to the part corresponding to the container
_MACHINE_.

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

**--no-pager**
Do not pipe output into a pager.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemctl**(1),
**systemd-cgtop**(1),
**systemd-nspawn**(1),
**ps**(1)
