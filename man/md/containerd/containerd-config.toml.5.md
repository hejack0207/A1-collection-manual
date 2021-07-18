# /etc/containerd/config.toml(5)

08/08/2018

```

 The config.toml file is a configuration file for the containerd daemon. The file must be placed at /etc/containerd/config.toml or specified with the --config option of containerd to be used by the daemon. If the file does not exist at the appropriate location or is not provided via the --config option containerd uses its default configuration settings, which can be displayed with the containerd config(1) command.
```


<a name="description"></a>

# Description


The TOML file used to configure the containerd daemon settings has a short
list of global settings followed by a series of sections for specific areas
of daemon configuration. There is also a section for **plugins** that allows
each containerd plugin to have an area for plugin-specific configuration and
settings.


<a name="format"></a>

# Format


**root**
: The root directory for containerd metadata. (Default: "/var/lib/containerd")


**state**
: The state directory for containerd (Default: "/run/containerd")


**oom\\_score**
: The out of memory (OOM) score applied to the containerd daemon process (Default: 0)


**[grpc]**
: Section for gRPC socket listener settings. Contains three properties:
 - **address** (Default: "/run/containerd/containerd.sock")
 - **uid** (Default: 0)
 - **gid** (Default: 0)


**[debug]**
: Section to enable and configure a debug socket listener. Contains four properties:
 - **address** (Default: "/run/containerd/debug.sock")
 - **uid** (Default: 0)
 - **gid** (Default: 0)
 - **level** (Default: "info") sets the debug log level


**[metrics]**
: Section to enable and configure a metrics listener. Contains two properties:
 - **address** (Default: "") Metrics endpoint does not listen by default
 - **grpc\\_histogram** (Default: false) Turn on or off gRPC histogram metrics


**[cgroup]**
: Section for Linux cgroup specific settings
 - **path** (Default: "") Specify a custom cgroup path for created containers


**[plugins]**
: The plugins section contains configuration options exposed from installed plugins.
The following plugins are enabled by default and their settings are shown below.
Plugins that are not enabled by default will provide their own configuration values
documentation.
 - **[plugins.cgroup]** has one option **no\\_prometheus** (Default: **false**)
 - **[plugins.diff]** has one option **default**, a list by default set to **["walking"]**
 - **[plugins.linux]** has several options for configuring the runtime, shim, and related options:
   **shim** specifies the shim binary (Default: **"containerd-shim"**),
   **runtime** is the OCI compliant runtime binary (Default: **"runc"**),
   **runtime\\_root** is the root directory used by the runtime (Default: **""**),
   **no\\_shim** specifies whether to use a shim or not (Default: **false**),
   **shim\\_debug** turns on debugging for the shim (Default: **false**)
 - **[plugins.scheduler]** has several options that perform advanced tuning for the scheduler:
   **pause\\_threshold** is the maximum amount of time GC should be scheduled (Default: **0.02**),
   **deletion\\_threshold** guarantees GC is scheduled after n number of deletions (Default: **0** [not triggered]),
   **mutation\\_threshold** guarantees GC is scheduled after n number of database mutations (Default: **100**),
   **schedule\\_delay** defines the delay after trigger event before scheduling a GC (Default **"0ms"** [immediate]),
   **startup\\_delay** defines the delay after startup before scheduling a GC (Default **"100ms"**)


<a name="example"></a>

# Example


The following is a complete **config.toml** default configuration example:



    root = "/var/lib/containerd"
    state = "/run/containerd"
    oom_score = 0
    
    [grpc]
      address = "/run/containerd/containerd.sock"
      uid = 0
      gid = 0
    
    [debug]
      address = "/run/containerd/debug.sock"
      uid = 0
      gid = 0
      level = "info"
    
    [metrics]
      address = ""
      grpc_histogram = false
    
    [cgroup]
      path = ""
    
    [plugins]
      [plugins.cgroups]
        no_prometheus = false
      [plugins.diff]
        default = ["walking"]
      [plugins.linux]
        shim = "containerd-shim"
        runtime = "runc"
        runtime_root = ""
        no_shim = false
        shim_debug = false
      [plugins.scheduler]
        pause_threshold = 0.02
        deletion_threshold = 0
        mutation_threshold = 100
        schedule_delay = 0
        startup_delay = 100000000
    


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


ctr(1), containerd-config(1), containerd(1)
