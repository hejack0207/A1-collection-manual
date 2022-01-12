# stap\-server(8) - systemtap compile server management



<a name="synopsis"></a>

# Synopsis


```

[ service ] stap-server { start | stop | restart | condrestart | try-restart | force-reload | status } [ options ]
```


<a name="description"></a>

# Description


A systemtap compile server listens for connections from stap clients
on a secure SSL network port and accepts requests to run the
_stap_
front end. Each server advertises its presence and configuration on the local
network using mDNS (_avahi_) allowing for automatic detection by clients.


The stap-server script aims to provide:

* ·  
  management of systemtap compile servers as a service.
* ·  
  convenient control over configured servers and individual (ad-hoc) servers.
  

<a name="arguments"></a>

# Arguments

One of the actions below must be specified:

* **start**  
  Start servers. The specified servers are started.
  If no server is specified, the configured servers are started. If no servers
  are configured, a server for the kernel release and architecture of the host
  is started.
  If a specified server is
  already started, this action will
  be ignored for that server. If a server fails to start, this action fails.
  
* **stop**  
  Stop server(s). The specified servers are stopped.
  If no server is specified, all currently running servers are stopped.
  If a specified server is
  not running, this action
  will be successful for that server. If a server fails to stop, this action
  fails.
  
* **restart**  
  Stop and restart servers. The specified servers are stopped and restarted.
  If no server is specified, all currently running servers are stopped and
  restarted. If no servers are running, this action behaves like _start_.
  
* **condrestart**  
  Stop and restart servers. The specified servers are stopped and restarted.
  If a specified server is not running, it is not started. If no server is
  specified, all currently running servers are stopped and restarted.  If no
  servers are running, none will be started.
  
* **try-restart**  
  This action is identical to _condrestart_.
  
* **force-reload**  
  Stop all running servers, reload config files and restart the service as if
  _start_
  was specified.
  
* **status**  
  Print information about running servers. Information about the specified
  server(s) will be printed. If no server is specified, information about all
  running servers will be printed.
  

<a name="options"></a>

# Options

The following options are used to provide additional configuration and
to specify servers to be managed:


* **-c** _configfile_  
  This option specifies a global configuration file in addition to the default
  global configuration file described
  below. This file will be processed after the default global
  configuration file. If the **-c** option is specified more than once, the
  last
  configuration file specified will be used.
  
* **-a** _architecture_  
  This option specifies the target architecture of the server and is
  analogous to the **-a** option of _stap_. See the
  _stap_(1)
  manual page for more details.
  The default architecture is the architecture of the host.
  
* **-r** _kernel-release_  
  This option specifies a target kernel release of the server and is
  analogous to the **-r** option of _stap_.  See the
  _stap_(1)
  manual page for more details.
  The default release is that of the currently running kernel.
  A server can handle multiple releases by specifying multiple **-r** flags.
  
* **-I** _path_  
  This option specifies an additional path to be searched by the server(s) for
  tapsets and is analogous to the **-I** option of _stap_.
  See the
  _stap_(1)
  manual page for more details.
  
* **-R** _path_  
  This option specifies the location of the systemtap runtime to be used by the
  server(s) and is analogous to the **-R** option of _stap_.
  See the
  _stap_(1)
  manual page for more details.
  
* **-B** _options_  
  This option specifies options to be passed to _make_ when building systemtap
  modules and is analogous to the **-B** option of _stap_.
  See the
  _stap_(1)
  manual page for more details.
  
* **-i**  
  This option is a shortcut which specifies a server that handles every
  release installed in _/lib/modules/_.
* **-n** _nickname_  
  This option allows the specification of a server configuration by nickname.
  When **-n** is specified, a currently running server with the given nickname
  will be searched for. If no currently running server with the given nickname is
  found, a server configuration with the given nickname will be searched for in
  the configuration files for default servers,
  or the path configured in the global configuration file or
  the configuration file specified by the
  **-c** option. If a server configuration for the given
  nickname is found, the
  **-a**, **-r**, **-I**, **-R**, **-B** and **-u** options for
  that server will be used as if they were specified on the command line. If no
  configuration with the given nickname is found, and the action is
  _start_
  (or an action behaving like _start_
  (see **ARGUMENTS**), the server will be started with the given nickname.
  If no configuration with the given nickname is found, and the action is not
  _start_
  (or an action behaving like _start_), it is an error. If a nickname is
  not specified for a server which is being started, its nickname will be its
  process id.
  
* **-p** _pid_  
  This option allows the specification of a server configuration by process id.
  When **-p** is specified, a currently running server with the given process
  id will be searched for. If no such server is found, it is an error. If a server
  with the given process id is found, the
  **-a**, **-r**, **-I**, **-R**, **-B** and **-u** options for
  that server will be used as if they were specified on the command line.
  
* **-u** _user-name_  
  Each systemtap compile server is normally run by the user name
  _stap-server_ (for the initscript) or as the user invoking
  _stap-server_,
  unless otherwise configured (see **FILES**). This option
  specifies the user name used to run the server(s). The user name specified
  must be a member of the group _stap-server_.
  
* **--log** _logfile_  
  This option allows the specification of a separate log file for each server. 
  Each --log option is added to a list which will be applied, in turn, to each
  server specified. If more servers are specified than --log options, the default
  log file (see **FILES**) will be used for subsequent servers.
  
* **--port** _port-number_  
  This option allows the specification of a specific network port for each
  server. Each --port option is added to a list which will be applied, in turn,
  to each server specified. If more servers are specified than
  --port options, a randomly selected port is used for subsequent servers.
  
* **--ssl** _certificate-db-path_  
  This option allows the specification of a separate NSS certificate database
  for each server. Each --ssl option is added to a list which will be applied,
  in turn, to each server specified. If more servers are specified than --ssl
  options, the default certificate database
  (see **FILES**) for subsequent servers.
  
* **--max-threads** _threads_  
  This option allows the specification of the maximum number of worker threads
  to handle concurrent requests. If _threads_ == 0, each request will be
  handled on the main thread, serially.  The default is the number of available
  processor cores.
  
* **--max-request-size** _size_  
  This options allows the specification of the maximum size of an uncompressed
  client request. The arguement _size_ is specified in bytes. The
  default is the 50000 bytes.
  
* **--max-compressed-request** _size_  
  This options allows the specification of the maximum size of a compressed
  client request. The arguement _size_ is specified in bytes. The
  default is the 5000 bytes.
  

<a name="configuration"></a>

# Configuration


Configuration files allow us to:

* ·  
  specify global configuration of logging, server configuration files, status
  files and other global parameters.
* ·  
  specify which servers are to be started by default.
  

<a name="global-configuration"></a>

# Global Configuration


The Global Configuration file contains
variable assignments used to configure the overall operation of the service.
Each line beginning with a '#' character is ignored. All other lines must be
of the form _VARIABLE=VALUE_. This is not a shell script. The entire
contents of the line after the = will be assigned as-is to the variable.

The following variables may be assigned:


* **CONFIG_PATH**  
  Specifies the absolute path of the directory containing the default server
  configurations.
  
* **STAT_PATH**  
  Specifies the absolute path of the running server status directory.
  
* **LOG_FILE**  
  Specifies the absolute path of the log file.
  
* **STAP_USER**  
  Specifies the userid which will be used to run the server(s)
  (default: for the initscript _stap-server_, otherwise the user running
  _stap-server_).
  

Here is an example of a Global Configuration file:
.SAMPLE
CONFIG_PATH=~&lt;user&gt;/my-stap-server-configs
LOG_FILE=/tmp/stap-server/log
.ESAMPLE


<a name="individual-server-configuration"></a>

# Individual Server Configuration


Each server configuration file configures a server to be started when no
server is specified for the _start_ action, or an action behaving like the
_start_ action (see _ARGUMENTS_). Each configuration file contains
variable assignments used to configure an individual server.

Each line beginning with a '#' character is ignored. All other lines must be
of the form _VARIABLE=VALUE_. This is not a shell script. The entire
contents of the line after the = will be assigned as-is to the variable.

Each configuration file must have a filename suffix of _.conf_. See
_stappaths_(7) for the default location of these files.  This default
location can be overridden in the global configuration file using the **-c**
option (see _OPTIONS_).

The following variables may be assigned:

* **ARCH**  
  Specifies the target architecture for this server and corresponds to the
  **-a** option (see _OPTIONS_). If **ARCH** is not set, the
  architecture of the host will be used.
  
* **RELEASE**  
  Specifies a kernel release for this server
  and corresponds to the
  **-r** option (see _OPTIONS_). If **RELEASE** is not set, the
  release
  of the kernel running on the host will be used.
   
* **BUILD**  
  Specifies options to be passed to the _make_ process used by
  _systemtap_ to build kernel modules.
  This an array variable with each element corresponding to a
  **-B** option (see _OPTIONS_). Using the form **BUILD=STRING** clears
  the array and sets the first element to **STRING**. Using the form
  **BUILD+=STRING** adds **STRING** as an additional element to the array.
   
* **INCLUDE**  
  Specifies a list of directories to be searched by the server for tapsets.
  This is an array variable with each element corresponding to a
  **-I** option (see _OPTIONS_). Using the form **INCLUDE=PATH** clears
  the array and sets the first element to **PATH**. Using the form
  **INCLUDE+=PATH** adds **PATH** as an additional element to the array.
  
* **RUNTIME**  
  Specifies the directory which contains the systemtap runtime code to be used
  by this server
  and corresponds to the
  **-R** option (see _OPTIONS_).
  
* **USER**  
  Specifies the user name to be used to run this server
  and corresponds to the
  **-u** option (see _OPTIONS_).
  
* **NICKNAME**  
  Specifies the nickname to be used to refer to this server
  and corresponds to the
  **-n** option (see _OPTIONS_).
  
* **LOG**  
  Specifies the location of the log file to be used by this server and corresponds to the
  **--log** option (see _OPTIONS_).
  
* **PORT**  
  Specifies the network port to be used by this server and corresponds to the
  **--port** option (see _OPTIONS_).
  
* **SSL**  
  Specifies the location of the NSS certificate database to be used by this server and corresponds
  to the
  **--ssl** option (see _OPTIONS_).
  
* **MAXTHREADS**  
  Specifies the maximum number of worker threads to handle concurrent requests to be used by this server
  and corresponds to the **--max-threads** option (see _OPTIONS_).
  
* **MAXREQSIZE**  
  Specifies the maximum size of an uncompressed client request, to be used by
  this server and correspnds to the  **--max-request-size** option (see _OPTIONS_).
  
* **MAXCOMPRESSEDREQ**  
  Specifies the maximum size of an compressed client request, to be used by
  this server and correspnds to the  **--max-compressed-request** option (see _OPTIONS_).
  

Here is an example of a server configuration file:
.SAMPLE
ARCH=
USER=
RELEASE=
NICKNAME=native
.ESAMPLE
By keeping the ARCH, USER, and RELEASE fields blank, they will default to the
current arch and release and use the default user.

A more specific example:
.SAMPLE
ARCH=i386
RELEASE=2.6.18-128.el5
PORT=5001
LOG=/path/to/log/file
.ESAMPLE

And here is a more complicated example:
.SAMPLE
USER=serveruser
RELEASE=/kernels/2.6.18-92.1.18.el5/build
INCLUDE=/mytapsets
INCLUDE+=/yourtapsets
BUILD='VARIABLE1=VALUE1 VARIABLE2=VALUE2'
DEFINE=STP_MAXMEMORY=1024
DEFINE+=DEBUG_TRANS
RUNTIME=/myruntime
NICKNAME=my-server
SSL=/path/to/NSS/certificate/database
.ESAMPLE


<a name="server-authentication"></a>

# Server Authentication

The security of the SSL network connection between the client and server
depends on the proper
management of server certificates.


The trustworthiness of a given systemtap compile server can not be determined
automatically without a trusted certificate authority issuing systemtap compile server
certificates. This is
not practical in everyday use and so, clients must authenticate servers
against their own database of trusted server certificates. In this context,
establishing a given server as trusted by a given client means adding
that server\[aq]s certificate to the
client\[aq]s database of trusted servers.


For the _stap-server_ initscript, on the local host, this is handled
automatically.
When the _systemtap-server_ package is installed, the server\[aq]s
certificate for the default user (_stap-server_) is automatically
generated and installed. This means that servers started by the
_stap-server_ initscript,
with the default user, are automatically trusted by clients on the local
host, both as an SSL peer and as a systemtap module signer.

Furthermore, when stap is invoked by an unprivileged user
(not root, not a member of the group stapdev, but a member of the group
stapusr and possibly the group stapsys), the options _--use-server_
and _--privilege_
are automatically added to the specified options.
This means that unprivileged users 
on the local host can use a server on the local host
in unprivileged mode with no further setup or options required. Normal users
(those in none of the SystemTap groups) can also use compile-servers through the
_--use-server_ and _--privilege_ options. But they will of course
be unable to load the module (the _-p4_ option can be used to stop short of
loading).


In order to use a server running on another host, that server\[aq]s certificate
must be installed on the client\[aq]s host.
See the _--trust-servers_ option in the
_stap_(1)
manual page for more details and README.unprivileged in the systemtap sources
for more details.


<a name="examples"></a>

# Examples

See the 
_stapex_(3stap)
manual page for a collection of sample _systemtap_ scripts.

To start the configured servers, or the default server, if none are configured:

** $ [ service ] stap-server start**

To start a server that handles all kernel versions installed in /lib/modules:

** $ [ service ] stap-server start -i**

To obtain information about the running server(s):

** $ [ service ] stap-server status**

To start a server like another one, except targeting a different architecture,
by referencing the first server\[aq]s nickname:

** $ [ service ] stap-server start -n NICKNAME** -a ARCH****

To start a server for a kernel release not installed (cross-compiling)

** $ [ service ] stap-server start -a ARCH** -r /BUILDDIR****

To stop one of the servers by referencing its process id (obtained by running
**stap-server status**):

** $ [ service ] stap-server stop -p _PID_**

To run a script using a compile server:

** $ stap SCRIPT --use-server**

To run a script as an unprivileged user using a compile server:

** $ stap SCRIPT**

To stop all running servers:

** $ [ service ] stap-server stop**

To restart servers after a global configuration change and/or when default
servers have been added, changed, or removed:

** $ [ service ] stap-server force-reload**


<a name="safety-and-security"></a>

# Safety and Security

Systemtap is an administrative tool.  It exposes kernel internal data
structures and potentially private user information.  See the 
_stap_(1)
manual page for additional information on safety and security.


As a network server, stap-server should be activated with care in
order to limit the potential effects of bugs or mischevious users.
Consider the following prophylactic measures.

* 1  
  Run stap-server as an unprivileged user, never as root.
  
  When invoked as a
  service (i.e. **service stap-server** ...), each server is run,
  by default, as the user _stap-server_.
  When invoked directly (i.e. **stap-server** ...), each server is run,
  by default, as the invoking user. In each case, another user may be selected by
  using the _-u_ option on invocation, by specifying
  _STAP\_USER=_username in the global configuration file or by specifying
  _USER=_username in an individual server configuration file. The invoking
  user must have authority to run processes as another user.
  See _CONFIGURATION_.
  
  The selected user must have write access to the server log file.
  The location of the server log file may
  be changed by setting _LOG\_FILE=_path in the global configuration file.
  See _CONFIGURATION_.
  
  The selected user must have 
  read/write access to the directory containing the server status files.
  The location of the server
  status files may be changed by setting _STAT\_PATH=_path in the global
  configuration file.
  See _CONFIGURATION_.
  
  The selected user must have 
  read/write access to the uprobes.ko build directory and its files.
  
  Neither form of stap-server will run if the selected user is root.
  
* 2  
  Run stap-server requests with resource limits that impose maximum 
  cpu time, file size, memory consumption, in order to bound
  the effects of processing excessively large or bogus inputs.
  
  When the user running the server is _stap-server_,
  each server request is run with limits specified in _~stap-server/.systemtap/rc_
  otherwise, no limits are imposed.
  
* 3  
  Run stap-server with a TMPDIR environment variable that
  points to a separate and/or quota-enforced directory, in
  order to prevent filling up of important filesystems.
  
  The default TMPDIR is _/tmp/_.
  
* 4  
  Activate network firewalls to limit stap client connections
  to relatively trustworthy networks.
  
  For automatic selection of servers by clients, _avahi_ must be installed
  on both the server and client hosts and _mDNS_ messages must be allowed through the firewall.
  

The systemtap compile server and its related utilities use the Secure Socket Layer
(SSL) as implemented by Network Security Services (NSS)
for network security. NSS is also used
for the generation and management of certificates. The related
certificate databases must be protected in order to maintain the security of
the system.
Use of the utilities provided will help to ensure that the proper protection
is maintained. The systemtap client will check for proper
access permissions before making use of any certificate database.


<a name="files"></a>

# Files


* Important files and their corresponding paths can be located in the   
  stappaths (7) manual page.
  

<a name="see-also"></a>

# See Also

.nh
    stap(1),
    staprun(8),
    stapprobes(3stap),
    stappaths(7),
    stapex(3stap),
    avahi,
    ulimit(1),
    NSS
    

<a name="bugs"></a>

# Bugs

Use the Bugzilla link of the project web page or our mailing list.
.nh
**http://sourceware.org/systemtap/**, **&lt;systemtap@sourceware.org&gt;**.

