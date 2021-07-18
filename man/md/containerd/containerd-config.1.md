# containerd\-config(1)

01/30/2018

```

 containerd config [command]
```


<a name="description"></a>

# Description


The _containerd config_ command has one subcommand, named _default_, which
will display on standard output the default containerd config for this version
of the containerd daemon.


This output can be piped to a **containerd-config.toml(5)** file and placed in
**/etc/containerd** to be used as the configuration for containerd on daemon
startup. The configuration can be placed in any filesystem location and used
with the **--config** option to the containerd daemon as well.


See **containerd-config.toml(5)** for more information on the containerd
configuration options.


<a name="options"></a>

# Options


**default**
: This subcommand will output the TOML formatted containerd configuration to standard output


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


ctr(1), containerd(1), containerd-config.toml(5)
