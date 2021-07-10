# kubernetes(1)

Eric Paris,  kubernetes User Manuals


kubectl create secret generic - Create a secret from a local file, directory or literal value



<a name="synopsis"></a>

# Synopsis

```

 kubectl create secret generic [OPTIONS]
```



<a name="description"></a>

# Description


Create a secret based on a file, directory, or specified literal value.


A single secret may package one or more key/value pairs.


When creating a secret based on a file, the key will default to the basename of the file, and the value will default to the file content. If the basename is an invalid key or you wish to chose your own, you may specify an alternate key.


When creating a secret based on a directory, each file whose basename is a valid key in the directory will be packaged into the secret. Any directory entries except regular files are ignored (e.g. subdirectories, symlinks, devices, pipes, etc).



<a name="options"></a>

# Options


**--allow-missing-template-keys**=true
    If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.


**--append-hash**=false
    Append a hash of the secret to its name.


**--dry-run**=false
    If true, only print the object that would be sent, without sending it.


**--from-env-file**=""
    Specify the path to a file to read lines of key=val pairs to create a secret (i.e. a Docker .env file).


**--from-file**=[]
    Key files can be specified using their file path, in which case a default name will be given to them, or optionally with a name and file path, in which case the given name will be used.  Specifying a directory will iterate each named file in the directory that is a valid secret key.


**--from-literal**=[]
    Specify a key and literal value to insert in secret (i.e. mykey=somevalue)


**--generator**="secret/v1"
    The name of the API generator to use.


**-o**, **--output**=""
    Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.


**--save-config**=false
    If true, the configuration of current object will be saved in its annotation. Otherwise, the annotation will be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.


**--template**=""
    Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates [
\[la]http://golang.org/pkg/text/template/#pkg-overview\[ra]].


**--type**=""
    The type of secret to create


**--validate**=true
    If true, use a schema to validate the input before sending it



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



      # Create a new secret named my-secret with keys for each file in folder bar
      kubectl create secret generic my-secret --from-file=path/to/bar
      
      # Create a new secret named my-secret with specified keys instead of names on disk
      kubectl create secret generic my-secret --from-file=ssh-privatekey=path/to/id_rsa --from-file=ssh-publickey=path/to/id_rsa.pub
      
      # Create a new secret named my-secret with key1=supersecret and key2=topsecret
      kubectl create secret generic my-secret --from-literal=key1=supersecret --from-literal=key2=topsecret
      
      # Create a new secret named my-secret using a combination of a file and a literal
      kubectl create secret generic my-secret --from-file=ssh-privatekey=path/to/id_rsa --from-literal=passphrase=topsecret
      
      # Create a new secret named my-secret from an env file
      kubectl create secret generic my-secret --from-env-file=path/to/bar.env
    



<a name="see-also"></a>

# See Also


**kubectl-create-secret(1)**,



<a name="history"></a>

# History


January 2015, Originally compiled by Eric Paris (eparis at redhat dot com) based on the kubernetes source material, but hopefully they have been automatically generated since!
