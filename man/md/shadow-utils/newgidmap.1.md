# newgidmap(1)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

newgidmap - set the gid mapping of a user namespace

<a name="synopsis"></a>

# Synopsis

```
.HP \w'newgidmap&nbsp;'u newgidmap pid gid lowergid count [gid&nbsp;lowergid&nbsp;count&nbsp;[&nbsp;...&nbsp;]]
```

<a name="description"></a>

# Description


The
**newgidmap**
sets
/proc/[pid]/gid_map
based on its command line arguments and the gids allowed in
/etc/subgid. Note that the root user is not exempted from the requirement for a valid
/etc/subgid
entry.

After the pid argument,
**newgidmap**
expects sets of 3 integers:

gid
Beginning of the range of GIDs inside the user namespace.

lowergid
Beginning of the range of GIDs outside the user namespace.

count
Length of the ranges (both inside and outside the user namespace).

**newgidmap**
verifies that the caller is the owner of the process indicated by
**pid**
and that for each of the above sets, each of the GIDs in the range [lowergid, lowergid+count] is allowed to the caller according to
/etc/subgid
before setting
/proc/[pid]/gid_map.

Note that newgidmap may be used only once for a given process.

<a name="options"></a>

# Options


There currently are no options to the
**newgidmap**
command.

<a name="files"></a>

# Files


/etc/subgid
List of users subordinate group IDs.

/proc/[pid]/gid_map
Mapping of gids from one between user namespaces.

<a name="see-also"></a>

# See Also


**login.defs**(5),
**newusers**(8),
**subgid**(5),
**useradd**(8),
**userdel**(8),
**usermod**(8).
