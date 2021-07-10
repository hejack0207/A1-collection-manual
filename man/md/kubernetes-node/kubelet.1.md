# kubernetes(1)

 kubernetes User Manuals

.nh



<a name="name"></a>

# Name


kubelet - Processes a container manifest so the containers are launched according to how they are described.



<a name="synopsis"></a>

# Synopsis

```

 kubelet [OPTIONS]
```



<a name="description"></a>

# Description


The kubelet is the primary "node agent" that runs on each
node. It can register the node with the apiserver using one of: the hostname; a flag to
override the hostname; or specific logic for a cloud provider.


The kubelet works in terms of a PodSpec. A PodSpec is a YAML or JSON object
that describes a pod. The kubelet takes a set of PodSpecs that are provided through
various mechanisms (primarily through the apiserver) and ensures that the containers
described in those PodSpecs are running and healthy. The kubelet doesn't manage
containers which were not created by Kubernetes.


Other than from an PodSpec from the apiserver, there are three ways that a container
manifest can be provided to the Kubelet.


File: Path passed as a flag on the command line. Files under this path will be monitored
periodically for updates. The monitoring period is 20s by default and is configurable
via a flag.


HTTP endpoint: HTTP endpoint passed as a parameter on the command line. This endpoint
is checked every 20 seconds (also configurable with a flag).


HTTP server: The kubelet can also listen for HTTP and respond to a simple API
(underspec'd currently) to submit a new manifest.


kubelet [flags]



<a name="options"></a>

# Options



      --azure-container-registry-config string   Path to the file containing Azure container registry configuration information.
    


-h, --help                                     help for kubelet
      --log-flush-frequency duration             Maximum number of seconds between log flushes (default 5s)
      --version version[=true]                   Print version information and quit



<a name="examples"></a>

# Examples


/usr/bin/kubelet --logtostderr=true --v=0 --api\_servers=
\[la]http://127.0.0.1:8080\[ra] --address=127.0.0.1 --port=10250 --hostname\_override=127.0.0.1 --allow-privileged=false
