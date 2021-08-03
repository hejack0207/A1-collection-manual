# subgid(5)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

subgid - the subordinate gid file

<a name="description"></a>

# Description


Each line in
/etc/subgid
contains a user name and a range of subordinate group ids that user is allowed to use. This is specified with three fields delimited by colons (“:”). These fields are:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  login name or UID

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  numerical subordinate group ID

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  numerical subordinate group ID count

This file specifies the group IDs that ordinary users can use, with the
**newgidmap**
command, to configure gid mapping in a user namespace.

Multiple ranges may be specified per user.

When large number of entries (10000-100000 or more) are defined in
/etc/subgid, parsing performance penalty will become noticeable. In this case it is recommended to use UIDs instead of login names. Benchmarks have shown speed-ups up to 20x.

<a name="files"></a>

# Files


/etc/subgid
Per user subordinate group IDs.

/etc/subgid-
Backup file for /etc/subgid.

<a name="see-also"></a>

# See Also


**login.defs**(5),
**newgidmap**(1),
**newuidmap**(1),
**newusers**(8),
**subuid**(5),
**useradd**(8),
**userdel**(8),
**usermod**(8),
**user\_namespaces**(7).
