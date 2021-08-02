# kubernetes(1)

Eric Paris,  kubernetes User Manuals


kubectl get - Display one or many resources



<a name="synopsis"></a>

# Synopsis

```

 kubectl get [OPTIONS]
```



<a name="description"></a>

# Description


Display one or many resources


Prints a table of the most important information about the specified resources. You can filter the list using a label selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current namespace unless you pass --all-namespaces.


Uninitialized objects are not shown unless --include-uninitialized is passed.


By specifying the output as 'template' and providing a Go template as the value of the --template flag, you can filter the attributes of the fetched resources.


Use "kubectl api-resources" for a complete list of supported resources.



<a name="options"></a>

# Options


**-A**, **--all-namespaces**=false
    If present, list the requested object(s) across all namespaces. Namespace in current context is ignored even if specified with --namespace.


**--allow-missing-template-keys**=true
    If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.


**--chunk-size**=500
    Return large lists in chunks rather than all at once. Pass 0 to disable. This flag is beta and may change in the future.


**--export**=false
    If true, use 'export' for the resources.  Exported resources are stripped of cluster-specific information.


**--field-selector**=""
    Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector key1=value1,key2=value2). The server only supports a limited number of field queries per type.


**-f**, **--filename**=[]
    Filename, directory, or URL to files identifying the resource to get from a server.


**--ignore-not-found**=false
    If the requested object does not exist the command will return exit code 0.


**--include-uninitialized**=false
    If true, the kubectl command applies to uninitialized objects. If explicitly set to false, this flag overrides other flags that make the kubectl commands apply to uninitialized objects, e.g., "--all". Objects with empty metadata.initializers are regarded as initialized.


**-k**, **--kustomize**=""
    Process the kustomization directory. This flag can't be used together with -f or -R.


**-L**, **--label-columns**=[]
    Accepts a comma separated list of labels that are going to be presented as columns. Names are case-sensitive. You can also use multiple flag options like -L label1 -L label2...


**--no-headers**=false
    When using the default or custom-column output format, don't print headers (default print headers).


**-o**, **--output**=""
    Output format. One of: json|yaml|wide|name|custom-columns=...|custom-columns-file=...|go-template=...|go-template-file=...|jsonpath=...|jsonpath-file=... See custom columns [
\[la]http://kubernetes.io/docs/user-guide/kubectl-overview/#custom-columns\[ra]], golang template [
\[la]http://golang.org/pkg/text/template/#pkg-overview\[ra]] and jsonpath template [
\[la]http://kubernetes.io/docs/user-guide/jsonpath\[ra]].


**--raw**=""
    Raw URI to request from the server.  Uses the transport specified by the kubeconfig file.


**-R**, **--recursive**=false
    Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests organized within the same directory.


**-l**, **--selector**=""
    Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)


**--server-print**=true
    If true, have the server return the appropriate table output. Supports extension APIs and CRDs.


**--show-kind**=false
    If present, list the resource type for the requested object(s).


**--show-labels**=false
    When printing, show all labels as the last column (default hide labels column)


**--sort-by**=""
    If non-empty, sort list types using this field specification.  The field specification is expressed as a JSONPath expression (e.g. '{.metadata.name}'). The field in the API resource specified by this JSONPath expression must be an integer or a string.


**--template**=""
    Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates [
\[la]http://golang.org/pkg/text/template/#pkg-overview\[ra]].


**--use-openapi-print-columns**=false
    If true, use x-kubernetes-print-column metadata (if present) from the OpenAPI schema for displaying a resource.


**-w**, **--watch**=false
    After listing/getting the requested object, watch for changes. Uninitialized objects are excluded if no object name is provided.


**--watch-only**=false
    Watch for changes to the requested object(s), without listing/getting first.



<a name="options-inherited-from-parent-commands"></a>

# Options Inherited from Parent Commands


**--alsologtostderr**=false
    log to standard error as well as files


**--application-metrics-count-limit**=100
    Max number of application metrics to store (per container)


**--as**=""
    Username to impersonate for the operation


**--as-group**=[]
    Group to impersonate for the operation, this flag can be repeated to specify multiple groups.


**--azure-container-registry-config**=""
    Path to the file containing Azure container registry configuration information.


**--boot-id-file**="/proc/sys/kernel/random/boot\_id"
    Comma-separated list of files to check for boot-id. Use the first one that exists.


**--cache-dir**="/builddir/.kube/http-cache"
    Default HTTP cache directory


**--certificate-authority**=""
    Path to a cert file for the certificate authority


**--client-certificate**=""
    Path to a client certificate file for TLS


**--client-key**=""
    Path to a client key file for TLS


**--cloud-provider-gce-lb-src-cidrs**=130.211.0.0/22,209.85.152.0/22,209.85.204.0/22,35.191.0.0/16
    CIDRs opened in GCE firewall for LB traffic proxy  health checks


**--cluster**=""
    The name of the kubeconfig cluster to use


**--container-hints**="/etc/cadvisor/container\_hints.json"
    location of the container hints file


**--containerd**="/run/containerd/containerd.sock"
    containerd endpoint


**--containerd-namespace**="k8s.io"
    containerd namespace


**--context**=""
    The name of the kubeconfig context to use


**--default-not-ready-toleration-seconds**=300
    Indicates the tolerationSeconds of the toleration for notReady:NoExecute that is added by default to every pod that does not already have such a toleration.


**--default-unreachable-toleration-seconds**=300
    Indicates the tolerationSeconds of the toleration for unreachable:NoExecute that is added by default to every pod that does not already have such a toleration.


**--docker**="unix:///var/run/docker.sock"
    docker endpoint


**--docker-env-metadata-whitelist**=""
    a comma-separated list of environment variable keys that needs to be collected for docker containers


**--docker-only**=false
    Only report docker containers in addition to root stats


**--docker-root**="/var/lib/docker"
    DEPRECATED: docker root is read from docker info (this is a fallback, default: /var/lib/docker)


**--docker-tls**=false
    use TLS to connect to docker


**--docker-tls-ca**="ca.pem"
    path to trusted CA


**--docker-tls-cert**="cert.pem"
    path to client certificate


**--docker-tls-key**="key.pem"
    path to private key


**--enable-load-reader**=false
    Whether to enable cpu load reader


**--event-storage-age-limit**="default=0"
    Max length of time for which to store events (per type). Value is a comma separated list of key values, where the keys are event types (e.g.: creation, oom) or "default" and the value is a duration. Default is applied to all non-specified event types


**--event-storage-event-limit**="default=0"
    Max number of events to store (per type). Value is a comma separated list of key values, where the keys are event types (e.g.: creation, oom) or "default" and the value is an integer. Default is applied to all non-specified event types


**--global-housekeeping-interval**=1m0s
    Interval between global housekeepings


**--housekeeping-interval**=10s
    Interval between container housekeepings


**--insecure-skip-tls-verify**=false
    If true, the server's certificate will not be checked for validity. This will make your HTTPS connections insecure


**--kubeconfig**=""
    Path to the kubeconfig file to use for CLI requests.


**--log-backtrace-at**=:0
    when logging hits line file:N, emit a stack trace


**--log-cadvisor-usage**=false
    Whether to log the usage of the cAdvisor container


**--log-dir**=""
    If non-empty, write log files in this directory


**--log-file**=""
    If non-empty, use this log file


**--log-file-max-size**=1800
    Defines the maximum size a log file can grow to. Unit is megabytes. If the value is 0, the maximum file size is unlimited.


**--log-flush-frequency**=5s
    Maximum number of seconds between log flushes


**--logtostderr**=true
    log to standard error instead of files


**--machine-id-file**="/etc/machine-id,/var/lib/dbus/machine-id"
    Comma-separated list of files to check for machine-id. Use the first one that exists.


**--match-server-version**=false
    Require server version to match client version


**-n**, **--namespace**=""
    If present, the namespace scope for this CLI request


**--password**=""
    Password for basic authentication to the API server


**--profile**="none"
    Name of profile to capture. One of (none|cpu|heap|goroutine|threadcreate|block|mutex)


**--profile-output**="profile.pprof"
    Name of the file to write the profile to


**--request-timeout**="0"
    The length of time to wait before giving up on a single server request. Non-zero values should contain a corresponding time unit (e.g. 1s, 2m, 3h). A value of zero means don't timeout requests.


**-s**, **--server**=""
    The address and port of the Kubernetes API server


**--skip-headers**=false
    If true, avoid header prefixes in the log messages


**--skip-log-headers**=false
    If true, avoid headers when opening log files


**--stderrthreshold**=2
    logs at or above this threshold go to stderr


**--storage-driver-buffer-duration**=1m0s
    Writes in the storage driver will be buffered for this duration, and committed to the non memory backends as a single transaction


**--storage-driver-db**="cadvisor"
    database name


**--storage-driver-host**="localhost:8086"
    database host:port


**--storage-driver-password**="root"
    database password


**--storage-driver-secure**=false
    use secure connection with database


**--storage-driver-table**="stats"
    table name


**--storage-driver-user**="root"
    database username


**--token**=""
    Bearer token for authentication to the API server


**--update-machine-info-interval**=5m0s
    Interval between machine info updates.


**--user**=""
    The name of the kubeconfig user to use


**--username**=""
    Username for basic authentication to the API server


**-v**, **--v**=0
    number for the log level verbosity


**--version**=false
    Print version information and quit


**--vmodule**=
    comma-separated list of pattern=N settings for file-filtered logging



<a name="example"></a>

# Example



      # List all pods in ps output format.
      kubectl get pods
      
      # List all pods in ps output format with more information (such as node name).
      kubectl get pods -o wide
      
      # List a single replication controller with specified NAME in ps output format.
      kubectl get replicationcontroller web
      
      # List deployments in JSON output format, in the "v1" version of the "apps" API group:
      kubectl get deployments.v1.apps -o json
      
      # List a single pod in JSON output format.
      kubectl get -o json pod web-pod-13je7
      
      # List a pod identified by type and name specified in "pod.yaml" in JSON output format.
      kubectl get -f pod.yaml -o json
      
      # List resources from a directory with kustomization.yaml - e.g. dir/kustomization.yaml.
      kubectl get -k dir/
      
      # Return only the phase value of the specified pod.
      kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
      
      # List resource information in custom columns.
      kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
      
      # List all replication controllers and services together in ps output format.
      kubectl get rc,services
      
      # List one or more resources by their type and names.
      kubectl get rc/web service/frontend pods/web-pod-13je7
    



<a name="see-also"></a>

# See Also


**kubectl(1)**,



<a name="history"></a>

# History


January 2015, Originally compiled by Eric Paris (eparis at redhat dot com) based on the kubernetes source material, but hopefully they have been automatically generated since!
