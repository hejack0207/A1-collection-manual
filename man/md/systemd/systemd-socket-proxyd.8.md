# systemd\-socket\-proxyd(8)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd-socket-proxyd - Bidirectionally proxy local sockets to another (possibly remote) socket.

<a name="synopsis"></a>

# Synopsis

```
.HP \w'systemd-socket-proxyd&nbsp;'u systemd-socket-proxyd [OPTIONS...] HOST:PORT .HP \w'systemd-socket-proxyd&nbsp;'u systemd-socket-proxyd [OPTIONS...] UNIX-DOMAIN-SOCKET-PATH
```

<a name="description"></a>

# Description


**systemd-socket-proxyd**
is a generic socket-activated network socket forwarder proxy daemon for IPv4, IPv6 and UNIX stream sockets. It may be used to bi-directionally forward traffic from a local listening socket to a local or remote destination socket.

One use of this tool is to provide socket activation support for services that do not natively support socket activation. On behalf of the service to activate, the proxy inherits the socket from systemd, accepts each client connection, opens a connection to a configured server for each client, and then bidirectionally forwards data between the two.

This utilitys behavior is similar to
**socat**(1). The main differences for
**systemd-socket-proxyd**
are support for socket activation with
"Accept=no"
and an event-driven design that scales better with the number of connections.

<a name="options"></a>

# Options


The following options are understood:

**-h**, **--help**
Print a short help text and exit.

**--version**
Print a short version string and exit.

**--connections-max=**, **-c**
Sets the maximum number of simultaneous connections, defaults to 256. If the limit of concurrent connections is reached further connections will be refused.

<a name="exit-status"></a>

# Exit Status


On success, 0 is returned, a non-zero failure code otherwise.

<a name="examples"></a>

# Examples


<a name="simple-example"></a>

### Simple Example


Use two services with a dependency and no namespace isolation.

**Example&nbsp;1.&nbsp;proxy-to-nginx.socket**

.if n \{.RS 4
.\}
    [Socket]
    ListenStream=80
    
    [Install]
    WantedBy=sockets.target
.if n \{.RE
.\}

**Example&nbsp;2.&nbsp;proxy-to-nginx.service**

.if n \{.RS 4
.\}
    [Unit]
    Requires=nginx.service
    After=nginx.service
    Requires=proxy-to-nginx.socket
    After=proxy-to-nginx.socket
    
    [Service]
    ExecStart=/usr/lib/systemd/systemd-socket-proxyd /run/nginx/socket
    PrivateTmp=yes
    PrivateNetwork=yes
.if n \{.RE
.\}

**Example&nbsp;3.&nbsp;nginx.conf**

.if n \{.RS 4
.\}
    [...]
    server {
        listen       unix:/run/nginx/socket;
        [...]
.if n \{.RE
.\}

**Example&nbsp;4.&nbsp;Enabling the proxy**

.if n \{.RS 4
.\}
    # systemctl enable --now proxy-to-nginx.socket
    $ curl http://localhost:80/
.if n \{.RE
.\}

<a name="namespace-example"></a>

### Namespace Example


Similar as above, but runs the socket proxy and the main service in the same private namespace, assuming that
nginx.service
has
_PrivateTmp=_
and
_PrivateNetwork=_
set, too.

**Example&nbsp;5.&nbsp;proxy-to-nginx.socket**

.if n \{.RS 4
.\}
    [Socket]
    ListenStream=80
    
    [Install]
    WantedBy=sockets.target
.if n \{.RE
.\}

**Example&nbsp;6.&nbsp;proxy-to-nginx.service**

.if n \{.RS 4
.\}
    [Unit]
    Requires=nginx.service
    After=nginx.service
    Requires=proxy-to-nginx.socket
    After=proxy-to-nginx.socket
    JoinsNamespaceOf=nginx.service
    
    [Service]
    ExecStart=/usr/lib/systemd/systemd-socket-proxyd 127.0.0.1:8080
    PrivateTmp=yes
    PrivateNetwork=yes
.if n \{.RE
.\}

**Example&nbsp;7.&nbsp;nginx.conf**

.if n \{.RS 4
.\}
    [...]
    server {
        listen       8080;
        [...]
.if n \{.RE
.\}

**Example&nbsp;8.&nbsp;Enabling the proxy**

.if n \{.RS 4
.\}
    # systemctl enable --now proxy-to-nginx.socket
    $ curl http://localhost:80/
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


**systemd**(1),
**systemd.socket**(5),
**systemd.service**(5),
**systemctl**(1),
**socat**(1),
**nginx**(1),
**curl**(1)
