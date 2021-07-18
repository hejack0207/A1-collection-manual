# ctr(1)

01/30/2018

```

 ctr [global options] command [command options] [arguments...]
```


<a name="description"></a>

# Description


**ctr** is an unsupported debug and administrative client for interacting
with the containerd daemon. Because it is unsupported, the commands,
options, and operation are not guaranteed to be backward compatible or
stable from release to release of the containerd project.


<a name="options"></a>

# Options


The following commands are available in the **ctr** utility:


**plugins,plugin**
: Provides information about containerd plugins


**version**
: Prints the client and server versions


**containers,c,container**
: Manages and interacts with containers


**content**
: Manages and interacts with content


**events,event**
: Displays containerd events


**images,image**
: Manages and interacts with images


**namespaces,namespace**
: Manages and interacts with containerd namespaces


**pprof**
: Provides golang pprof outputs for containerd


**run**
: Runs a container


**snapshots,snapshot**
: Manages and interacts with snapshots


**tasks,t,task**
: Manages and interacts with tasks


**shim**
: Interacts with a containerd shim directly


**help,h**
: Displays a list of commands or help for one specific command


The following global options apply to all **ctr** commands:


**--debug**
: Enable debug output in logs


**--address value, -a value**
: Address for containerd's GRPC server (default: _/run/containerd/containerd.sock_)


**--timeout value**
: Total timeout for ctr commands (default: _0s_)


**--connect-timeout value**
: Timeout for connecting to containerd (default: _0s_)


**--namespace value, -n value**
: Namespace to use with commands (default: _default_) [also read from _$CONTAINERD\\_NAMESPACE_]


**--help, -h**
: Show help text


**--version, -v**
: Prints the **ctr** version


<a name="bugs"></a>

# Bugs


Note that the **ctr** utility is not an officially supported part of the
containerd project releases.


However, please feel free to file any specific issues that you encounter at

\[la]https://github.com/containerd/containerd\[ra].


<a name="author"></a>

# Author


Phil Estes 
\[la][estesp@gmail.com](mailto:estesp@gmail.com)\[ra]


<a name="see-also"></a>

# See Also


containerd(1), containerd-config(1), containerd-config.toml(5)
