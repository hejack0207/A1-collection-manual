# nscd(8) - name service cache daemon

GNU, 2015-05-07


<a name="description"></a>

# Description

**nscd**
is a daemon that provides a cache for the most common name service
requests.
The default configuration file,
_/etc/nscd.conf_,
determines the behavior of the cache daemon.
See
**nscd.conf**(5).

**nscd**
provides caching for accesses of the
**passwd**(5),
**group**(5),
**hosts**(5)
**services**(5)
and
_netgroup_
databases through standard libc interfaces, such as
**getpwnam**(3),
**getpwuid**(3),
**getgrnam**(3),
**getgrgid**(3),
**gethostbyname**(3),
and others.

There are two caches for each database:
a positive one for items found, and a negative one
for items not found.
Each cache has a separate TTL (time-to-live)
period for its data.
Note that the shadow file is specifically not cached.
**getspnam**(3)
calls remain uncached as a result.

<a name="options"></a>

# Options


* **--help**  
  will give you a list with all options and what they do.

<a name="notes"></a>

# Notes

The daemon will try to watch for changes in configuration files
appropriate for each database (e.g.,
_/etc/passwd_
for the
_passwd_
database or
_/etc/hosts_
and
_/etc/resolv.conf_
for the
_hosts_
database), and flush the cache when these are changed.
However, this will happen only after a short delay (unless the
**inotify**(7)
mechanism is available and glibc 2.9 or later is available),
and this auto-detection does not cover configuration files
required by nonstandard NSS modules, if any are specified in
_/etc/nsswitch.conf_.
In that case, you need to run the following command
after changing the configuration file of the database so that
**nscd**
invalidates its cache:

.in +4n
.EX
$ **nscd -i** _&lt;database&gt;_
.EE
.in

<a name="see-also"></a>

# See Also

**nscd.conf**(5),
**nsswitch.conf**(5)




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
