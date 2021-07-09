# cgroup classifier in tc(8) - control group based traffic control filter

iproute2,  21 Oct 2015

```
.in +8 .ti -8 tc filter ... cgroup [ match EMATCH_TREE ] [  action ACTION_SPEC ]
```

<a name="description"></a>

# Description

This filter serves as a hint to
**tc**
that the assigned class ID of the net_cls control group the process the packet
originates from belongs to should be used for classification. Obviously, it is
useful for locally generated packets only.

<a name="options"></a>

# Options


* **action**_ ACTION_SPEC_  
  Apply an action from the generic actions framework on matching packets.
* **match**_ EMATCH_TREE_  
  Match packets using the extended match infrastructure. See
  **tc-ematch**(8)
  for a detailed description of the allowed syntax in
  _EMATCH_TREE_.

<a name="examples"></a>

# Examples

In order to use this filter, a net_cls control group has to be created first and
class as well as process ID(s) assigned to it. The following creates a net_cls
cgroup named "foobar":

.EX
modprobe cls_cgroup
mkdir /sys/fs/cgroup/net_cls
mount -t cgroup -onet_cls net_cls /sys/fs/cgroup/net_cls
mkdir /sys/fs/cgroup/net_cls/foobar
.EE

To assign a class ID to the created cgroup, a file named
_net_cls.classid_
has to be created which contains the class ID to be assigned as a hexadecimal,
64bit wide number. The upper 32bits are reserved for the major handle, the
remaining hold the minor. So a class ID of e.g.
**ff:be**
has to be written like so:
**0xff00be**
(leading zeroes may be omitted). To continue the above example, the following
assigns class ID 1:2 to foobar cgroup:

.EX
echo 0x10002 &gt; /sys/fs/cgroup/net_cls/foobar/net_cls.classid
.EE

Finally some PIDs can be assigned to the given cgroup:

.EX
echo 1234 &gt; /sys/fs/cgroup/net_cls/foobar/tasks
echo 5678 &gt; /sys/fs/cgroup/net_cls/foobar/tasks
.EE

Now by simply attaching a
**cgroup**
filter to a
**qdisc**
makes packets from PIDs 1234 and 5678 be pushed into class 1:2.


<a name="see-also"></a>

# See Also

**tc**(8),
**tc-ematch**(8),  
the file
_Documentation/cgroups/net_cls.txt_
of the Linux kernel tree
