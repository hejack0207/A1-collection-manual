# nscd.conf(5) - name service cache daemon configuration file

GNU, 2014-02-07


<a name="description"></a>

# Description

The file
_/etc/nscd.conf_
is read from
**nscd**(8)
at startup.
Each line specifies either an attribute and a value, or an
attribute, service, and a value.
Fields are separated either by SPACE
or TAB characters.
A '#' (number sign) indicates the beginning of a
comment; following characters, up to the end of the line,
are not interpreted by nscd.

Valid services are _passwd_, _group_, _hosts_, _services_,
or _netgroup_.

**logfile**
_debug-file-name_
Specifies name of the file to which debug info should be written.

**debug-level**
_value_
Sets the desired debug level.
The default is 0.

**threads**
_number_
This is the number of threads that are started to wait for
requests.
At least five threads will always be created.

**max-threads**
_number_
Specifies the maximum number of threads.
The default is 32.

**server-user**
_user_
If this option is set, nscd will run as this user and not as root.
If a separate cache for every user is used (-S parameter), this
option is ignored.

**stat-user**
_user_
Specifies the user who is allowed to request statistics.

**reload-count**
unlimited |
_number_
Limit on the number of times a cached entry gets reloaded without being used
before it gets removed.
The default is 5.

**paranoia**
_&lt;yes|no&gt;_
Enabling paranoia mode causes nscd to restart itself periodically.
The default is no.

**restart-interval**
_time_
Sets the restart interval to
_time_
seconds
if periodic restart is enabled by enabling
**paranoia**
mode.
The default is 3600.

**enable-cache**
_service_
_&lt;yes|no&gt;_
Enables or disables the specified
_service_
cache.
The default is no.

**positive-time-to-live**
_service_
_value_
Sets the TTL (time-to-live) for positive entries (successful queries)
in the specified cache for
_service_.
_Value_
is in seconds.
Larger values increase cache hit rates and reduce mean
response times, but increase problems with cache coherence.

**negative-time-to-live**
_service_
_value_
Sets the TTL (time-to-live) for negative entries (unsuccessful queries)
in the specified cache for
_service_.
_Value_
is in seconds.
Can result in significant performance improvements if there
are several files owned by UIDs (user IDs) not in system databases (for
example untarring the Linux kernel sources as root); should be kept small
to reduce cache coherency problems.

**suggested-size**
_service_
_value_
This is the internal hash table size,
_value_
should remain a prime number for optimum efficiency.
The default is 211.

**check-files**
_service_
_&lt;yes|no&gt;_
Enables or disables checking the file belonging to the specified
_service_
for changes.
The files are
_/etc/passwd_,
_/etc/group_,
_/etc/hosts_,
_/etc/services_
and
_/etc/netgroup_.
The default is yes.

**persistent**
_service_
_&lt;yes|no&gt;_
Keep the content of the cache for
_service_
over server restarts; useful when
**paranoia**
mode is set.
The default is no.

**shared**
_service_
_&lt;yes|no&gt;_
The memory mapping of the nscd databases for
_service_
is shared with the clients so
that they can directly search in them instead of having to ask the
daemon over the socket each time a lookup is performed.
The default is no.

**max-db-size**
_service_
_bytes_
The maximum allowable size, in bytes, of the database files for the
_service_.
The default is 33554432.

**auto-propagate**
_service_
_&lt;yes|no&gt;_
When set to
_no_
for
_passwd_
or
_group_
service, then the
_.byname_
requests are not added to
_passwd.byuid_
or
_group.bygid_
cache.
This can help with tables containing multiple records for the same ID.
The default is yes.
This option is valid only for services
_passwd_
and
_group_.

<a name="notes"></a>

# Notes

The default values stated in this manual page originate
from the source code of
**nscd**(8)
and are used if not overridden in the configuration file.
The default values used in the configuration file of
your distribution might differ.

<a name="see-also"></a>

# See Also

**nscd**(8)




<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
