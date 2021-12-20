# pg_ctl(1)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pg_ctl - initialize, start, stop, or control a PostgreSQL server

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pg_ctl&nbsp;'u pg_ctl init[db] [-D&nbsp;datadir] [-s] [-o&nbsp;initdb-options] .HP \w'pg_ctl&nbsp;'u pg_ctl start [-D&nbsp;datadir] [-l&nbsp;filename] [-W] [-t&nbsp;seconds] [-s] [-o&nbsp;options] [-p&nbsp;path] [-c] .HP \w'pg_ctl&nbsp;'u pg_ctl stop [-D&nbsp;datadir] [-m&nbsp;s[mart]&nbsp;|&nbsp;f[ast]&nbsp;|&nbsp;i[mmediate]] [-W] [-t&nbsp;seconds] [-s] .HP \w'pg_ctl&nbsp;'u pg_ctl restart [-D&nbsp;datadir] [-m&nbsp;s[mart]&nbsp;|&nbsp;f[ast]&nbsp;|&nbsp;i[mmediate]] [-W] [-t&nbsp;seconds] [-s] [-o&nbsp;options] [-c] .HP \w'pg_ctl&nbsp;'u pg_ctl reload [-D&nbsp;datadir] [-s] .HP \w'pg_ctl&nbsp;'u pg_ctl status [-D&nbsp;datadir] .HP \w'pg_ctl&nbsp;'u pg_ctl promote [-D&nbsp;datadir] [-W] [-t&nbsp;seconds] [-s] .HP \w'pg_ctl&nbsp;'u pg_ctl logrotate [-D&nbsp;datadir] [-s] .HP \w'pg_ctl&nbsp;'u pg_ctl kill signal_name process_id 
 On Microsoft Windows, also: .HP \w'pg_ctl&nbsp;'u pg_ctl register [-D&nbsp;datadir] [-N&nbsp;servicename] [-U&nbsp;username] [-P&nbsp;password] [-S&nbsp;a[uto]&nbsp;|&nbsp;d[emand]] [-e&nbsp;source] [-W] [-t&nbsp;seconds] [-s] [-o&nbsp;options] .HP \w'pg_ctl&nbsp;'u pg_ctl unregister [-N&nbsp;servicename]
```

<a name="description"></a>

# Description


pg_ctl
is a utility for initializing a
PostgreSQL
database cluster, starting, stopping, or restarting the
PostgreSQL
database server (**postgres**(1)), or displaying the status of a running server. Although the server can be started manually,
pg_ctl
encapsulates tasks such as redirecting log output and properly detaching from the terminal and process group. It also provides convenient options for controlled shutdown.

The
**init**
or
**initdb**
mode creates a new
PostgreSQL
database cluster, that is, a collection of databases that will be managed by a single server instance. This mode invokes the
**initdb**
command. See
**initdb**(1)
for details.

**start**
mode launches a new server. The server is started in the background, and its standard input is attached to
/dev/null
(or
nul
on Windows). On Unix-like systems, by default, the servers standard output and standard error are sent to
pg_ctls standard output (not standard error). The standard output of
pg_ctl
should then be redirected to a file or piped to another process such as a log rotating program like
rotatelogs; otherwise
**postgres**
will write its output to the controlling terminal (from the background) and will not leave the shells process group. On Windows, by default the server\*(Aqs standard output and standard error are sent to the terminal. These default behaviors can be changed by using
**-l**
to append the servers output to a log file. Use of either
**-l**
or output redirection is recommended.

**stop**
mode shuts down the server that is running in the specified data directory. Three different shutdown methods can be selected with the
**-m**
option.
“Smart”
mode disallows new connections, then waits for all existing clients to disconnect and any online backup to finish. If the server is in hot standby, recovery and streaming replication will be terminated once all clients have disconnected.
“Fast”
mode (the default) does not wait for clients to disconnect and will terminate an online backup in progress. All active transactions are rolled back and clients are forcibly disconnected, then the server is shut down.
“Immediate”
mode will abort all server processes immediately, without a clean shutdown. This choice will lead to a crash-recovery cycle during the next server start.

**restart**
mode effectively executes a stop followed by a start. This allows changing the
**postgres**
command-line options, or changing configuration-file options that cannot be changed without restarting the server. If relative paths were used on the command line during server start,
**restart**
might fail unless
pg_ctl
is executed in the same current directory as it was during server start.

**reload**
mode simply sends the
**postgres**
server process a
SIGHUP
signal, causing it to reread its configuration files (postgresql.conf,
pg_hba.conf, etc.). This allows changing configuration-file options that do not require a full server restart to take effect.

**status**
mode checks whether a server is running in the specified data directory. If it is, the servers
PID
and the command line options that were used to invoke it are displayed. If the server is not running,
pg_ctl
returns an exit status of 3. If an accessible data directory is not specified,
pg_ctl
returns an exit status of 4.

**promote**
mode commands the standby server that is running in the specified data directory to end standby mode and begin read-write operations.

**logrotate**
mode rotates the server log file. For details on how to use this mode with external log rotation tools, see
Section&nbsp;24.3.

**kill**
mode sends a signal to a specified process. This is primarily valuable on
Microsoft Windows
which does not have a built-in
kill
command. Use
--help
to see a list of supported signal names.

**register**
mode registers the
PostgreSQL
server as a system service on
Microsoft Windows. The
**-S**
option allows selection of service start type, either
“auto”
(start service automatically on system startup) or
“demand”
(start service on demand).

**unregister**
mode unregisters a system service on
Microsoft Windows. This undoes the effects of the
**register**
command.

<a name="options"></a>

# Options


**-c**  
**--core-files**
Attempt to allow server crashes to produce core files, on platforms where this is possible, by lifting any soft resource limit placed on core files. This is useful in debugging or diagnosing problems by allowing a stack trace to be obtained from a failed server process.

**-D ****datadir**  
**--pgdata=****datadir**
Specifies the file system location of the database configuration files. If this option is omitted, the environment variable
**PGDATA**
is used.

**-l ****filename**  
**--log=****filename**
Append the server log output to
_filename_. If the file does not exist, it is created. The
umask
is set to 077, so access to the log file is disallowed to other users by default.

**-m ****mode**  
**--mode=****mode**
Specifies the shutdown mode.
_mode_
can be
smart,
fast, or
immediate, or the first letter of one of these three. If this option is omitted,
fast
is the default.

**-o ****options**  
**--options=****options**
Specifies options to be passed directly to the
**postgres**
command.
**-o**
can be specified multiple times, with all the given options being passed through.

The
_options_
should usually be surrounded by single or double quotes to ensure that they are passed through as a group.

**-o ****initdb-options**  
**--options=****initdb-options**
Specifies options to be passed directly to the
**initdb**
command.
**-o**
can be specified multiple times, with all the given options being passed through.

The
_initdb-options_
should usually be surrounded by single or double quotes to ensure that they are passed through as a group.

**-p ****path**
Specifies the location of the
postgres
executable. By default the
postgres
executable is taken from the same directory as
**pg\_ctl**, or failing that, the hard-wired installation directory. It is not necessary to use this option unless you are doing something unusual and get errors that the
postgres
executable was not found.

In
init
mode, this option analogously specifies the location of the
initdb
executable.

**-s**  
**--silent**
Print only errors, no informational messages.

**-t ****seconds**  
**--timeout=****seconds**
Specifies the maximum number of seconds to wait when waiting for an operation to complete (see option
**-w**). Defaults to the value of the
**PGCTLTIMEOUT**
environment variable or, if not set, to 60 seconds.

**-V**  
**--version**
Print the
pg_ctl
version and exit.

**-w**  
**--wait**
Wait for the operation to complete. This is supported for the modes
start,
stop,
restart,
promote, and
register, and is the default for those modes.

When waiting,
**pg\_ctl**
repeatedly checks the servers
PID
file, sleeping for a short amount of time between checks. Startup is considered complete when the
PID
file indicates that the server is ready to accept connections. Shutdown is considered complete when the server removes the
PID
file.
**pg\_ctl**
returns an exit code based on the success of the startup or shutdown.

If the operation does not complete within the timeout (see option
**-t**), then
**pg\_ctl**
exits with a nonzero exit status. But note that the operation might continue in the background and eventually succeed.

**-W**  
**--no-wait**
Do not wait for the operation to complete. This is the opposite of the option
**-w**.

If waiting is disabled, the requested action is triggered, but there is no feedback about its success. In that case, the server log file or an external monitoring system would have to be used to check the progress and success of the operation.

In prior releases of PostgreSQL, this was the default except for the
stop
mode.

**-?**  
**--help**
Show help about
pg_ctl
command line arguments, and exit.

If an option is specified that is valid, but not relevant to the selected operating mode,
pg_ctl
ignores it.

<a name="options-for-windows"></a>

### Options for Windows


**-e ****source**
Name of the event source for
pg_ctl
to use for logging to the event log when running as a Windows service. The default is
PostgreSQL. Note that this only controls messages sent from
pg_ctl
itself; once started, the server will use the event source specified by its
event_source
parameter. Should the server fail very early in startup, before that parameter has been set, it might also log using the default event source name
PostgreSQL.

**-N ****servicename**
Name of the system service to register. This name will be used as both the service name and the display name. The default is
PostgreSQL.

**-P ****password**
Password for the user to run the service as.

**-S ****start-type**
Start type of the system service.
_start-type_
can be
auto, or
demand, or the first letter of one of these two. If this option is omitted,
auto
is the default.

**-U ****username**
User name for the user to run the service as. For domain users, use the format
DOMAIN\eusername.

<a name="environment"></a>

# Environment


**PGCTLTIMEOUT**
Default limit on the number of seconds to wait when waiting for startup or shutdown to complete. If not set, the default is 60 seconds.

**PGDATA**
Default data directory location.

Most
**pg\_ctl**
modes require knowing the data directory location; therefore, the
**-D**
option is required unless
**PGDATA**
is set.

**pg\_ctl**, like most other
PostgreSQL
utilities, also uses the environment variables supported by
libpq
(see
Section&nbsp;33.14).

For additional variables that affect the server, see
**postgres**(1).

<a name="files"></a>

# Files


postmaster.pid
pg_ctl
examines this file in the data directory to determine whether the server is currently running.

postmaster.opts
If this file exists in the data directory,
pg_ctl
(in
**restart**
mode) will pass the contents of the file as options to
postgres, unless overridden by the
**-o**
option. The contents of this file are also displayed in
**status**
mode.

<a name="examples"></a>

# Examples


<a name="starting-the-server"></a>

### Starting the Server


To start the server, waiting until the server is accepting connections:

.if n \{.RS 4
.\}
    $ pg_ctl start
.if n \{.RE
.\}

To start the server using port 5433, and running without
**fsync**, use:

.if n \{.RS 4
.\}
    $ pg_ctl -o "-F -p 5433" start
.if n \{.RE
.\}

<a name="stopping-the-server"></a>

### Stopping the Server


To stop the server, use:

.if n \{.RS 4
.\}
    $ pg_ctl stop
.if n \{.RE
.\}

The
**-m**
option allows control over
_how_
the server shuts down:

.if n \{.RS 4
.\}
    $ pg_ctl stop -m smart
.if n \{.RE
.\}

<a name="restarting-the-server"></a>

### Restarting the Server


Restarting the server is almost equivalent to stopping the server and starting it again, except that by default,
**pg\_ctl**
saves and reuses the command line options that were passed to the previously-running instance. To restart the server using the same options as before, use:

.if n \{.RS 4
.\}
    $ pg_ctl restart
.if n \{.RE
.\}

But if
**-o**
is specified, that replaces any previous options. To restart using port 5433, disabling
**fsync**
upon restart:

.if n \{.RS 4
.\}
    $ pg_ctl -o "-F -p 5433" restart
.if n \{.RE
.\}

<a name="showing-the-server-status"></a>

### Showing the Server Status


Here is sample status output from
pg_ctl:

.if n \{.RS 4
.\}
    $ pg_ctl status
    
    pg_ctl: server is running (PID: 13718)
    /usr/local/pgsql/bin/postgres "-D" "/usr/local/pgsql/data" "-p" "5433" "-B" "128"
.if n \{.RE
.\}

The second line is the command that would be invoked in restart mode.

<a name="see-also"></a>

# See Also

**initdb**(1), **postgres**(1)
