# kubernetes(1)

Eric Paris,  kubernetes User Manuals


kubectl - kubectl controls the Kubernetes cluster manager



<a name="synopsis"></a>

# Synopsis

```

 kubectl [OPTIONS]
```



<a name="description"></a>

# Description


kubectl controls the Kubernetes cluster manager.


Find more information at: 
\[la]https://kubernetes.io/docs/reference/kubectl/overview/\[ra]



<a name="options"></a>

# Options


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



<a name="see-also"></a>

# See Also


**kubectl-alpha(1)**, **kubectl-annotate(1)**, **kubectl-api-resources(1)**, **kubectl-api-versions(1)**, **kubectl-apply(1)**, **kubectl-attach(1)**, **kubectl-auth(1)**, **kubectl-autoscale(1)**, **kubectl-certificate(1)**, **kubectl-cluster-info(1)**, **kubectl-completion(1)**, **kubectl-config(1)**, **kubectl-convert(1)**, **kubectl-cordon(1)**, **kubectl-cp(1)**, **kubectl-create(1)**, **kubectl-delete(1)**, **kubectl-describe(1)**, **kubectl-diff(1)**, **kubectl-drain(1)**, **kubectl-edit(1)**, **kubectl-exec(1)**, **kubectl-explain(1)**, **kubectl-expose(1)**, **kubectl-get(1)**, **kubectl-kustomize(1)**, **kubectl-label(1)**, **kubectl-logs(1)**, **kubectl-options(1)**, **kubectl-patch(1)**, **kubectl-plugin(1)**, **kubectl-port-forward(1)**, **kubectl-proxy(1)**, **kubectl-replace(1)**, **kubectl-rolling-update(1)**, **kubectl-rollout(1)**, **kubectl-run(1)**, **kubectl-scale(1)**, **kubectl-set(1)**, **kubectl-taint(1)**, **kubectl-top(1)**, **kubectl-uncordon(1)**, **kubectl-version(1)**, **kubectl-wait(1)**,



<a name="history"></a>

# History


January 2015, Originally compiled by Eric Paris (eparis at redhat dot com) based on the kubernetes source material, but hopefully they have been automatically generated since!
