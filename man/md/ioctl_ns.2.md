# ioctl_ns(2) - ioctl() operations for Linux namespaces

Linux, 2019-03-06


<a name="description"></a>

# Description




<a name="discovering-namespace-relationships"></a>

### Discovering namespace relationships

The following
**ioctl**(2)
operations are provided to allow discovery of namespace relationships (see
**user_namespaces**(7)
and
**pid_namespaces**(7)).
The form of the calls is:

.in +4n
.EX
new_fd = ioctl(fd, request);
.EE
.in

In each case,
_fd_
refers to a
_/proc/[pid]/ns/*_
file.
Both operations return a new file descriptor on success.

* **NS_GET_USERNS** (since Linux 4.9)  
  
  
  Returns a file descriptor that refers to the owning user namespace
  for the namespace referred to by
  _fd_.
* **NS_GET_PARENT** (since Linux 4.9)  
  
  Returns a file descriptor that refers to the parent namespace of
  the namespace referred to by
  _fd_.
  This operation is valid only for hierarchical namespaces
  (i.e., PID and user namespaces).
  For user namespaces,
  **NS_GET_PARENT**
  is synonymous with
  **NS_GET_USERNS**.

The new file descriptor returned by these operations is opened with the
**O_RDONLY**
and
**O_CLOEXEC**
(close-on-exec; see
**fcntl**(2))
flags.

By applying
**fstat**(2)
to the returned file descriptor, one obtains a
_stat_
structure whose
_st_dev_
(resident device) and
_st_ino_
(inode number) fields together identify the owning/parent namespace.
This inode number can be matched with the inode number of another
_/proc/[pid]/ns/{pid,user}_
file to determine whether that is the owning/parent namespace.

Either of these
**ioctl**(2)
operations can fail with the following errors:

* **EPERM**  
  The requested namespace is outside of the caller's namespace scope.
  This error can occur if, for example, the owning user namespace is an
  ancestor of the caller's current user namespace.
  It can also occur on attempts to obtain the parent of the initial
  user or PID namespace.
* **ENOTTY**  
  The operation is not supported by this kernel version.

Additionally, the
**NS_GET_PARENT**
operation can fail with the following error:

* **EINVAL**  
  _fd_
  refers to a nonhierarchical namespace.

See the EXAMPLE section for an example of the use of these operations.



<a name="discovering-the-namespace-type"></a>

### Discovering the namespace type

The
**NS_GET_NSTYPE**

operation (available since Linux 4.11) can be used to discover
the type of namespace referred to by the file descriptor
_fd_:

.in +4n
.EX
nstype = ioctl(fd, NS_GET_NSTYPE);
.EE
.in

_fd_
refers to a
_/proc/[pid]/ns/*_
file.

The return value is one of the
**CLONE_NEW***
values that can be specified to
**clone**(2)
or
**unshare**(2)
in order to create a namespace.



<a name="discovering-the-owner-of-a-user-namespace"></a>

### Discovering the owner of a user namespace

The
**NS_GET_OWNER_UID**

operation (available since Linux 4.11) can be used to discover
the owner user ID of a user namespace (i.e., the effective user ID
of the process that created the user namespace).
The form of the call is:

.in +4n
.EX
uid_t uid;
ioctl(fd, NS_GET_OWNER_UID, &uid);
.EE
.in

_fd_
refers to a
_/proc/[pid]/ns/user_
file.

The owner user ID is returned in the
_uid_t_
pointed to by the third argument.

This operation can fail with the following error:

* **EINVAL**  
  _fd_
  does not refer to a user namespace.

<a name="errors"></a>

# Errors

Any of the above
**ioctl**()
operations can return the following errors:

* **ENOTTY**  
  _fd_
  does not refer to a
  _/proc/[pid]/ns/*_
  file.

<a name="conforming-to"></a>

# Conforming to

Namespaces and the operations described on this page are a Linux-specific.

<a name="example"></a>

# Example

The example shown below uses the
**ioctl**(2)
operations described above to perform simple
discovery of namespace relationships.
The following shell sessions show various examples of the use
of this program.

Trying to get the parent of the initial user namespace fails,
since it has no parent:

.in +4n
.EX
$ **./ns_show /proc/self/ns/user p**
The parent namespace is outside your namespace scope
.EE
.in

Create a process running
**sleep**(1)
that resides in new user and UTS namespaces,
and show that the new UTS namespace is associated with the new user namespace:

.in +4n
.EX
$ **unshare -Uu sleep 1000 &**
[1] 23235
$ **./ns_show /proc/23235/ns/uts u**
Device/Inode of owning user namespace is: [0,3] / 4026532448
$ **readlink /proc/23235/ns/user **
user:[4026532448]
.EE
.in

Then show that the parent of the new user namespace in the preceding
example is the initial user namespace:

.in +4n
.EX
$ **readlink /proc/self/ns/user**
user:[4026531837]
$ **./ns_show /proc/23235/ns/user p**
Device/Inode of parent namespace is: [0,3] / 4026531837
.EE
.in

Start a shell in a new user namespace, and show that from within
this shell, the parent user namespace can't be discovered.
Similarly, the UTS namespace
(which is associated with the initial user namespace)
can't be discovered.

.in +4n
.EX
$ **PS1="sh2$ " unshare -U bash**
sh2$ **./ns_show /proc/self/ns/user p**
The parent namespace is outside your namespace scope
sh2$ **./ns_show /proc/self/ns/uts u**
The owning user namespace is outside your namespace scope
.EE
.in

<a name="program-source"></a>

### Program source


.EX
/* ns_show.c

   Licensed under the GNU General Public License v2 or later.
*/
#include &lt;stdlib.h&gt;
#include &lt;unistd.h&gt;
#include &lt;stdio.h&gt;
#include &lt;fcntl.h&gt;
#include &lt;string.h&gt;
#include &lt;sys/stat.h&gt;
#include &lt;sys/ioctl.h&gt;
#include &lt;errno.h&gt;
#include &lt;sys/sysmacros.h&gt;

#ifndef NS_GET_USERNS
#define NSIO    0xb7
#define NS_GET_USERNS   _IO(NSIO, 0x1)
#define NS_GET_PARENT   _IO(NSIO, 0x2)
#endif

int
main(int argc, char *argv[])
{
    int fd, userns_fd, parent_fd;
    struct stat sb;

    if (argc &lt; 2) {
        fprintf(stderr, "Usage: %s /proc/[pid]/ns/[file] [p|u]\en",
                argv[0]);
        fprintf(stderr, "\enDisplay the result of one or both "
                "of NS_GET_USERNS (u) or NS_GET_PARENT (p)\en"
                "for the specified /proc/[pid]/ns/[file]. If neither "
                "'p' nor 'u' is specified,\en"
                "NS_GET_USERNS is the default.\en");
        exit(EXIT_FAILURE);
    }

    /* Obtain a file descriptor for the 'ns' file specified
       in argv[1] */

    fd = open(argv[1], O_RDONLY);
    if (fd == -1) {
        perror("open");
        exit(EXIT_FAILURE);
    }

    /* Obtain a file descriptor for the owning user namespace and
       then obtain and display the inode number of that namespace */

    if (argc &lt; 3 || strchr(argv[2], 'u')) {
        userns_fd = ioctl(fd, NS_GET_USERNS);

        if (userns_fd == -1) {
            if (errno == EPERM)
                printf("The owning user namespace is outside "
                        "your namespace scope\en");
            else
               perror("ioctl-NS_GET_USERNS");
            exit(EXIT_FAILURE);
         }

        if (fstat(userns_fd, &sb) == -1) {
            perror("fstat-userns");
            exit(EXIT_FAILURE);
        }
        printf("Device/Inode of owning user namespace is: "
                "[%lx,%lx] / %ld\en",
                (long) major(sb.st_dev), (long) minor(sb.st_dev),
                (long) sb.st_ino);

        close(userns_fd);
    }

    /* Obtain a file descriptor for the parent namespace and
       then obtain and display the inode number of that namespace */

    if (argc &gt; 2 && strchr(argv[2], 'p')) {
        parent_fd = ioctl(fd, NS_GET_PARENT);

        if (parent_fd == -1) {
            if (errno == EINVAL)
                printf("Can' get parent namespace of a "
                        "nonhierarchical namespace\en");
            else if (errno == EPERM)
                printf("The parent namespace is outside "
                        "your namespace scope\en");
            else
                perror("ioctl-NS_GET_PARENT");
            exit(EXIT_FAILURE);
        }

        if (fstat(parent_fd, &sb) == -1) {
            perror("fstat-parentns");
            exit(EXIT_FAILURE);
        }
        printf("Device/Inode of parent namespace is: [%lx,%lx] / %ld\en",
                (long) major(sb.st_dev), (long) minor(sb.st_dev),
                (long) sb.st_ino);

        close(parent_fd);
    }

    exit(EXIT_SUCCESS);
}
.EE

<a name="see-also"></a>

# See Also

**fstat**(2),
**ioctl**(2),
**proc**(5),
**namespaces**(7)

<a name="colophon"></a>

# Colophon

This page is part of release 5.04 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
