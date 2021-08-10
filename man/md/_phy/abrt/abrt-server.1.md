# abrt\-server(1)

abrt 2\&.14\&.4, 09/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

abrt-server - Unix socket for ABRT.

<a name="synopsis"></a>

# Synopsis

```

 abrt-server [-u UID] [-spv[v]...]
```

<a name="description"></a>

# Description


_abrt-server_ is executed by abrtd daemon to handle socket connections. Every application in system is able to invoke creation of a new problem directory by following the communication protocol (described below in section _PROTOCOL_).

<a name="options"></a>

# Options


-u UID
Use UID as client uid

-s
Log to system log.

-p
Add program names to log.

-v
Log more detailed debugging information.

<a name="protocol"></a>

# Protocol


Initializing new dump: connect to UNIX domain socket /var/run/abrt.socket

Providing data (writing data to the socket):

.if n \{.RS 4
.\}
    -> "POST / HTTP/1.1eren"
    -> "eren"
    -> "type=stringe0"
       string, maximum length 100 bytes
    -> "reason=stringe0"
       string, maximum length 512 bytes
    -> "pid=numbere0"
       number, 0 - PID_MAX (/proc/sys/kernel/pid_max)
    -> "executable=stringe0"
       string, maximum length ~MAX_PATH
    -> "backtrace=stringe0"
       string, maximum length 1 MB
    -> (close writing half of the socket)
    <- "HTTP/1.1 201 eren"
    <- "eren"
.if n \{.RE
.\}

Deleting problem directory:

.if n \{.RS 4
.\}
    -> "DELETE <directory_name> HTTP/1.1eren"
    -> "eren"
    -> (close writing half of the socket)
    <- "HTTP/1.1 200 eren"
    <- "eren"
.if n \{.RE
.\}

<a name="authors"></a>

# Authors


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  ABRT team
