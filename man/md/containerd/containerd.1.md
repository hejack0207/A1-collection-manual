# containerd(1)

01/29/2018

```

 containerd [global options] command [command options] [arguments...]
```


<a name="description"></a>

# Description


**containerd** is a high performance container runtime whose daemon can be started
by using this command. If none of the _config_, _publish_, or _help_ commands
are specified the default action of the **containerd** command is to start the
containerd daemon in the foreground.


A default configuration is used if no TOML configuration is specified or located
at the default file location. The _containerd config_ command can be used to
generate the default configuration for containerd. The output of that command
can be used and modified as necessary as a custom configuration.


The _publish_ command is used internally by parts of the containerd runtime
to publish events. It is not meant to be used as a standalone utility.


<a name="options"></a>

# Options


**--config value, -c value**
: Specify the default path to the configuration file (default: "/etc/containerd/config.toml")


**--log-level value, -l value**
: Set the logging level. Available levels are: [debug, info, warn, error, fatal, panic]


**--address value, -a value**
: UNIX socket address for containerd's GRPC server to listen on (default: "/run/containerd/containerd.sock")


**--root value**
: The containerd root directory (default: "/var/lib/containerd"). A persistent directory location where metadata and image content are stored


**--state value**
: The containerd state directory (default: "/run/containerd"). A transient state directory used during containerd operation


**--help, -h**
: Show containerd command help text


**--version, -v**
: Print the containerd server version


<a name="bugs"></a>

# Bugs


Please file any specific issues that you encounter at

\[la]https://github.com/containerd/containerd\[ra].


<a name="author"></a>

# Author


Phil Estes 
\[la][estesp@gmail.com](mailto:estesp@gmail.com)\[ra]


<a name="see-also"></a>

# See Also


ctr(1), containerd-config(1), containerd-config.toml(5)
