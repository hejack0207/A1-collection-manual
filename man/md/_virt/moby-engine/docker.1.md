# docker(1)

William Henry,  Docker User Manuals

.nh



<a name="name"></a>

# Name


docker - Docker image and container command line interface



<a name="synopsis"></a>

# Synopsis

```

 docker [OPTIONS] COMMAND [ARG...]
</synopsis>

<synopsis>

 docker [--help|-v|--version]
```



<a name="description"></a>

# Description


**docker** is a client for interacting with the daemon (see **dockerd(8)**) through the CLI.


The Docker CLI has over 30 commands. The commands are listed below and each has
its own man page which explain usage and arguments.


To see the man page for a command run **man docker &lt;command&gt;**.



<a name="options"></a>

# Options


**--help**
  Print usage statement


**--config**=""
  Specifies the location of the Docker client configuration files. The default is '&nbsp;/.docker'.


**-D**, **--debug**=_true_|_false_
  Enable debug mode. Default is false.


**-H**, **--host**=[_unix:///var/run/docker.sock_]: tcp://[host]:[port][path] to bind or
unix://[/path/to/socket] to use.
  The socket(s) to bind to in daemon mode specified using one or more
  tcp://host:port/path, unix:///path/to/socket, fd://* or fd://socketfd.
  If the tcp port is not specified, then it will default to either **\fC2375** when
  **\fC--tls** is off, or **\fC2376** when **\fC--tls** is on, or **\fC--tlsverify** is specified.


**-l**, **--log-level**="_debug_|_info_|_warn_|_error_|_fatal_"
  Set the logging level. Default is **\fCinfo**.


**--tls**=_true_|_false_
  Use TLS; implied by --tlsverify. Default is false.


**--tlscacert**=_&nbsp;/.docker/ca.pem_
  Trust certs signed only by this CA.


**--tlscert**=_&nbsp;/.docker/cert.pem_
  Path to TLS certificate file.


**--tlskey**=_&nbsp;/.docker/key.pem_
  Path to TLS key file.


**--tlsverify**=_true_|_false_
  Use TLS and verify the remote (daemon: verify client, client: verify daemon).
  Default is false.


**-v**, **--version**=_true_|_false_
  Print version information and quit. Default is false.



<a name="commands"></a>

# Commands


Use "docker help" or "docker --help" to get an overview of available commands.



<a name="examples"></a>

# Examples


For specific client examples please see the man page for the specific Docker
command. For example:



    man docker-run
    



<a name="history"></a>

# History


April 2014, Originally compiled by William Henry (whenry at redhat dot com) based on docker.com source material and internal work.
