# docker(1)

Docker Community,  Docker User Manuals

.nh



<a name="name"></a>

# Name


docker-run - Run a command in a new container



<a name="synopsis"></a>

# Synopsis

```

 docker run [-a|--attach[=[]]] [--add-host[=[]]] [--blkio-weight[=[BLKIO-WEIGHT]]] [--blkio-weight-device[=[]]] [--cpu-shares[=0]] [--cap-add[=[]]] [--cap-drop[=[]]] [--cgroup-parent[=CGROUP-PATH]] [--cidfile[=CIDFILE]] [--cpu-count[=0]] [--cpu-percent[=0]] [--cpu-period[=0]] [--cpu-quota[=0]] [--cpu-rt-period[=0]] [--cpu-rt-runtime[=0]] [--cpus[=0.0]] [--cpuset-cpus[=CPUSET-CPUS]] [--cpuset-mems[=CPUSET-MEMS]] [-d|--detach] [--detach-keys[=[]]] [--device[=[]]] [--device-cgroup-rule[=[]]] [--device-read-bps[=[]]] [--device-read-iops[=[]]] [--device-write-bps[=[]]] [--device-write-iops[=[]]] [--dns[=[]]] [--dns-option[=[]]] [--dns-search[=[]]] [-e|--env[=[]]] [--entrypoint[=ENTRYPOINT]] [--env-file[=[]]] [--expose[=[]]] [--group-add[=[]]] [-h|--hostname[=HOSTNAME]] [--help] [--init] [-i|--interactive] [--ip[=IPv4-ADDRESS]] [--ip6[=IPv6-ADDRESS]] [--ipc[=IPC]] [--isolation[=default]] [--kernel-memory[=KERNEL-MEMORY]] [-l|--label[=[]]] [--label-file[=[]]] [--link[=[]]] [--link-local-ip[=[]]] [--log-driver[=[]]] [--log-opt[=[]]] [-m|--memory[=MEMORY]] [--mac-address[=MAC-ADDRESS]] [--memory-reservation[=MEMORY-RESERVATION]] [--memory-swap[=LIMIT]] [--memory-swappiness[=MEMORY-SWAPPINESS]] [--mount[=[MOUNT]]] [--name[=NAME]] [--network-alias[=[]]] [--network[="bridge"]] [--oom-kill-disable] [--oom-score-adj[=0]] [-P|--publish-all] [-p|--publish[=[]]] [--pid[=[PID]]] [--userns[=[]]] [--pids-limit[=PIDS\_LIMIT]] [--privileged] [--read-only] [--restart[=RESTART]] [--rm] [--security-opt[=[]]] [--storage-opt[=[]]] [--stop-signal[=SIGNAL]] [--stop-timeout[=TIMEOUT]] [--shm-size[=[]]] [--sig-proxy[=true]] [--sysctl[=[]]] [-t|--tty] [--tmpfs[=[CONTAINER-DIR[:OPTIONS]]] [-u|--user[=USER]] [--ulimit[=[]]] [--uts[=[]]] [-v|--volume[=[[HOST-DIR:]CONTAINER-DIR[:OPTIONS]]]] [--volume-driver[=DRIVER]] [--volumes-from[=[]]] [-w|--workdir[=WORKDIR]] IMAGE [COMMAND] [ARG...]
```



<a name="description"></a>

# Description


Run a process in a new container. **docker run** starts a process with its own
file system, its own networking, and its own isolated process tree. The IMAGE
which starts the process may define defaults related to the process that will be
run in the container, the networking to expose, and more, but **docker run**
gives final control to the operator or administrator who starts the container
from the image. For that reason **docker run** has more options than any other
Docker command.


If the IMAGE is not already loaded then **docker run** will pull the IMAGE, and
all image dependencies, from the repository in the same way running docker
pull IMAGE, before it starts the container from that image.



<a name="options"></a>

# Options


**-a**, **--attach**=[]
   Attach to STDIN, STDOUT or STDERR.


In foreground mode (the default when **-d**
is not specified), **docker run** can start the process in the container
and attach the console to the process's standard input, output, and standard
error. It can even pretend to be a TTY (this is what most commandline
executables expect) and pass along signals. The **-a** option can be set for
each of stdin, stdout, and stderr.


**--add-host**=[]
   Add a custom host-to-IP mapping (host:ip)


Add a line to /etc/hosts. The format is hostname:ip.  The **--add-host**
option can be set multiple times.


**--blkio-weight**=_0_
   Block IO weight (relative weight) accepts a weight value between 10 and 1000.


**--blkio-weight-device**=[]
   Block IO weight (relative device weight, format: **\fCDEVICE\\_NAME:WEIGHT**).


**--cpu-shares**=_0_
   CPU shares (relative weight)


By default, all containers get the same proportion of CPU cycles. This proportion
can be modified by changing the container's CPU share weighting relative
to the weighting of all other running containers.


To modify the proportion from the default of 1024, use the **--cpu-shares**
flag to set the weighting to 2 or higher.


The proportion will only apply when CPU-intensive processes are running.
When tasks in one container are idle, other containers can use the
left-over CPU time. The actual amount of CPU time will vary depending on
the number of containers running on the system.


For example, consider three containers, one has a cpu-share of 1024 and
two others have a cpu-share setting of 512. When processes in all three
containers attempt to use 100% of CPU, the first container would receive
50% of the total CPU time. If you add a fourth container with a cpu-share
of 1024, the first container only gets 33% of the CPU. The remaining containers
receive 16.5%, 16.5% and 33% of the CPU.


On a multi-core system, the shares of CPU time are distributed over all CPU
cores. Even if a container is limited to less than 100% of CPU time, it can
use 100% of each individual CPU core.


For example, consider a system with more than three cores. If you start one
container **{C0}** with **-c=512** running one process, and another container
**{C1}** with **-c=1024** running two processes, this can result in the following
division of CPU shares:



    PID    container    CPU CPU share
    100    {C0}     0   100% of CPU0
    101    {C1}     1   100% of CPU1
    102    {C1}     2   100% of CPU2
    


**--cap-add**=[]
   Add Linux capabilities


**--cap-drop**=[]
   Drop Linux capabilities


**--cgroup-parent**=""
   Path to cgroups under which the cgroup for the container will be created. If the path is not absolute, the path is considered to be relative to the cgroups path of the init process. Cgroups will be created if they do not already exist.


**--cidfile**=""
   Write the container ID to the file


**--cpu-count**=_0_
    Limit the number of CPUs available for execution by the container.



    On Windows Server containers, this is approximated as a percentage of total CPU usage.
    
    On Windows Server containers, the processor resource controls are mutually exclusive, the order of precedence is CPUCount first, then CPUShares, and CPUPercent last.
    


**--cpu-percent**=_0_
    Limit the percentage of CPU available for execution by a container running on a Windows daemon.



    On Windows Server containers, the processor resource controls are mutually exclusive, the order of precedence is CPUCount first, then CPUShares, and CPUPercent last.
    


**--cpu-period**=_0_
   Limit the CPU CFS (Completely Fair Scheduler) period


Limit the container's CPU usage. This flag tell the kernel to restrict the container's CPU usage to the period you specify.


**--cpuset-cpus**=""
   CPUs in which to allow execution (0-3, 0,1)


**--cpuset-mems**=""
   Memory nodes (MEMs) in which to allow execution (0-3, 0,1). Only effective on NUMA systems.


If you have four memory nodes on your system (0-3), use **\fC--cpuset-mems=0,1**
then processes in your Docker container will only use memory from the first
two memory nodes.


**--cpu-quota**=_0_
   Limit the CPU CFS (Completely Fair Scheduler) quota


Limit the container's CPU usage. By default, containers run with the full
CPU resource. This flag tell the kernel to restrict the container's CPU usage
to the quota you specify.


**--cpu-rt-period**=0
   Limit the CPU real-time period in microseconds


Limit the container's Real Time CPU usage. This flag tell the kernel to restrict the container's Real Time CPU usage to the period you specify.


**--cpu-rt-runtime**=0
   Limit the CPU real-time runtime in microseconds


Limit the containers Real Time CPU usage. This flag tells the kernel to limit the amount of time in a given CPU period Real Time tasks may consume. Ex:
   Period of 1,000,000us and Runtime of 950,000us means that this container could consume 95% of available CPU and leave the remaining 5% to normal priority tasks.


The sum of all runtimes across containers cannot exceed the amount allotted to the parent cgroup.


**--cpus**=0.0
   Number of CPUs. The default is _0.0_ which means no limit.


**-d**, **--detach**=_true_|_false_
   Detached mode: run the container in the background and print the new container ID. The default is _false_.


At any time you can run **docker ps** in
the other shell to view a list of the running containers. You can reattach to a
detached container with **docker attach**.


When attached in the tty mode, you can detach from the container (and leave it
running) using a configurable key sequence. The default sequence is **\fCCTRL-p CTRL-q**.
You configure the key sequence using the **--detach-keys** option or a configuration file.
See **config-json(5)** for documentation on using a configuration file.


**--detach-keys**=_key_
   Override the key sequence for detaching a container; _key_ is a single character from the [a-Z] range, or **ctrl**-_value_, where _value_ is one of: **a-z**, **@**, **^**, **[**, **,**, or **\\_**.


**--device**=_onhost_:_incontainer_[:_mode_]
   Add a host device _onhost_ to the container under the _incontainer_ name.
Optional _mode_ parameter can be used to specify device permissions, it is
a combination of **r** (for read), **w** (for write), and **m** (for **mknod**(2)).


For example, **--device=/dev/sdc:/dev/xvdc:rwm** will give a container all
permissions for the host device **/dev/sdc**, seen as **/dev/xvdc** inside the container.


**--device-cgroup-rule**="_type_ _major_:_minor_ _mode_"
   Add a rule to the cgroup allowed devices list. The rule is expected to be in the format specified in the Linux kernel documentation (Documentation/cgroup-v1/devices.txt):
     - _type_: **a** (all), **c** (char), or **b** (block);
     - _major_ and _minor_: either a number, or <b>\*</b> for all;
     - _mode_: a composition of **r** (read), **w** (write), and **m** (**mknod**(2)).


Example: **--device-cgroup-rule "c 1:3 mr"**: allow for a character device idendified by **1:3**  to be created and read.


**--device-read-bps**=[]
   Limit read rate from a device (e.g. --device-read-bps=/dev/sda:1mb)


**--device-read-iops**=[]
   Limit read rate from a device (e.g. --device-read-iops=/dev/sda:1000)


**--device-write-bps**=[]
   Limit write rate to a device (e.g. --device-write-bps=/dev/sda:1mb)


**--device-write-iops**=[]
   Limit write rate to a device (e.g. --device-write-iops=/dev/sda:1000)


**--dns-search**=[]
   Set custom DNS search domains (Use --dns-search=. if you don't wish to set the search domain)


**--dns-option**=[]
   Set custom DNS options


**--dns**=[]
   Set custom DNS servers


This option can be used to override the DNS
configuration passed to the container. Typically this is necessary when the
host DNS configuration is invalid for the container (e.g., 127.0.0.1). When this
is the case the **--dns** flags is necessary for every run.


**-e**, **--env**=[]
   Set environment variables


This option allows you to specify arbitrary
environment variables that are available for the process that will be launched
inside of the container.


**--entrypoint**=""
   Overwrite the default ENTRYPOINT of the image


This option allows you to overwrite the default entrypoint of the image that
is set in the Dockerfile. The ENTRYPOINT of an image is similar to a COMMAND
because it specifies what executable to run when the container starts, but it is
(purposely) more difficult to override. The ENTRYPOINT gives a container its
default nature or behavior, so that when you set an ENTRYPOINT you can run the
container as if it were that binary, complete with default options, and you can
pass in more options via the COMMAND. But, sometimes an operator may want to run
something else inside the container, so you can override the default ENTRYPOINT
at runtime by using a **--entrypoint** and a string to specify the new
ENTRYPOINT.


**--env-file**=[]
   Read in a line delimited file of environment variables


**--expose**=[]
   Expose a port, or a range of ports (e.g. --expose=3300-3310) informs Docker
that the container listens on the specified network ports at runtime. Docker
uses this information to interconnect containers using links and to set up port
redirection on the host system.


**--group-add**=[]
   Add additional groups to run as


**-h**, **--hostname**=""
   Container host name


Sets the container host name that is available inside the container.


**--help**
   Print usage statement


**--init**
   Run an init inside the container that forwards signals and reaps processes


**-i**, **--interactive**=_true_|_false_
   Keep STDIN open even if not attached. The default is _false_.


When set to true, keep stdin open even if not attached.


**--ip**=""
   Sets the container's interface IPv4 address (e.g., 172.23.0.9)


It can only be used in conjunction with **--network** for user-defined networks


**--ip6**=""
   Sets the container's interface IPv6 address (e.g., 2001:db8::1b99)


It can only be used in conjunction with **--network** for user-defined networks


**--ipc**=""
   Sets the IPC mode for the container. The following values are accepted:

.TS
allbox;
l l 
l l .
**\fCValue**	**\fCDescription**
(empty)	Use daemon's default.
**none**	T{
Own private IPC namespace, with /dev/shm not mounted.
T}
**private**	Own private IPC namespace.
**shareable**	T{
Own private IPC namespace, with a possibility to share it with other containers.
T}
T{
**container:**_name-or-ID_
T}	T{
Join another ("shareable") container's IPC namespace.
T}
**host**	T{
Use the host system's IPC namespace.
T}
.TE


If not specified, daemon default is used, which can either be **private**
or **shareable**, depending on the daemon version and configuration.


**--isolation**="_default_"
   Isolation specifies the type of isolation technology used by containers. Note
that the default on Windows server is **\fCprocess**, and the default on Windows client
is **\fChyperv**. Linux only supports **\fCdefault**.


**-l**, **--label** _key_=_value_
   Set metadata on the container (for example, **--label com.example.key=value**).


**--kernel-memory**=_number_[_S_]
   Kernel memory limit; _S_ is an optional suffix which can be one of **b**, **k**, **m**, or **g**.


Constrains the kernel memory available to a container. If a limit of 0
is specified (not using **--kernel-memory**), the container's kernel memory
is not limited. If you specify a limit, it may be rounded up to a multiple
of the operating system's page size and the value can be very large,
millions of trillions.


**--label-file**=[]
   Read in a line delimited file of labels


**--link**=_name-or-id_[:_alias_]
   Add link to another container.


If the operator
uses **--link** when starting the new client container, then the client
container can access the exposed port via a private networking interface. Docker
will set some environment variables in the client container to help indicate
which interface and port to use.


**--link-local-ip**=[]
   Add one or more link-local IPv4/IPv6 addresses to the container's interface


**--log-driver**="_json-file_|_syslog_|_journald_|_gelf_|_fluentd_|_awslogs_|_splunk_|_etwlogs_|_gcplogs_|_none_"
  Logging driver for the container. Default is defined by daemon **--log-driver** flag.
  **Warning**: the **\fCdocker logs** command works only for the **\fCjson-file** and
  **\fCjournald** logging drivers.


**--log-opt**=[]
  Logging driver specific options.


**-m**, **--memory**=_number_[*S]
   Memory limit; _S_ is an optional suffix which can be one of **b**, **k**, **m**, or **g**.


Allows you to constrain the memory available to a container. If the host
supports swap memory, then the **-m** memory setting can be larger than physical
RAM. If a limit of 0 is specified (not using **-m**), the container's memory is
not limited. The actual limit may be rounded up to a multiple of the operating
system's page size (the value would be very large, that's millions of trillions).


**--memory-reservation**=_number_[*S]
   Memory soft limit; _S_ is an optional suffix which can be one of **b**, **k**, **m**, or **g**.


After setting memory reservation, when the system detects memory contention
or low memory, containers are forced to restrict their consumption to their
reservation. So you should always set the value below **--memory**, otherwise the
hard limit will take precedence. By default, memory reservation will be the same
as memory limit.


**--memory-swap**=_number_[_S_]
   Combined memory plus swap limit; _S_ is an optional suffix which can be one of **b**, **k**, **m**, or **g**.


This option can only be used together with **--memory**. The argument should always be larger than that of **--memory**. Default is double the value of **--memory**. Set to **-1** to enable unlimited swap.


**--mac-address**=""
   Container MAC address (e.g., **92:d0:c6:0a:29:33**)


Remember that the MAC address in an Ethernet network must be unique.
The IPv6 link-local address will be based on the device's MAC address
according to RFC4862.


**--mount** **type=**_TYPE_,_TYPE-SPECIFIC-OPTION_[,...]
   Attach a filesystem mount to the container


Current supported mount **\fCTYPES** are **\fCbind**, **\fCvolume**, and **\fCtmpfs**.


e.g.


**\fCtype=bind,source=/path/on/host,destination=/path/in/container**


**\fCtype=volume,source=my-volume,destination=/path/in/container,volume-label="color=red",volume-label="shape=round"**


**\fCtype=tmpfs,tmpfs-size=512M,destination=/path/in/container**


Common Options:


* ·  
  **\fCsrc**, **\fCsource**: mount source spec for **\fCbind** and **\fCvolume**. Mandatory for **\fCbind**.
* ·  
  **\fCdst**, **\fCdestination**, **\fCtarget**: mount destination spec.
* ·  
  **\fCro**, **\fCread-only**: **\fCtrue** or **\fCfalse** (default).
  


Options specific to **\fCbind**:


* ·  
  **\fCbind-propagation**: **\fCshared**, **\fCslave**, **\fCprivate**, **\fCrshared**, **\fCrslave**, or **\fCrprivate**(default). See also **\fCmount(2)**.
* ·  
  **\fCconsistency**: **\fCconsistent**(default), **\fCcached**, or **\fCdelegated**. Currently, only effective for Docker for Mac.
  


Options specific to **\fCvolume**:


* ·  
  **\fCvolume-driver**: Name of the volume-driver plugin.
* ·  
  **\fCvolume-label**: Custom metadata.
* ·  
  **\fCvolume-nocopy**: **\fCtrue**(default) or **\fCfalse**. If set to **\fCfalse**, the Engine copies existing files and directories under the mount-path into the volume, allowing the host to access them.
* ·  
  **\fCvolume-opt**: specific to a given volume driver.
  


Options specific to **\fCtmpfs**:


* ·  
  **\fCtmpfs-size**: Size of the tmpfs mount in bytes. Unlimited by default in Linux.
* ·  
  **\fCtmpfs-mode**: File mode of the tmpfs in octal. (e.g. **\fC700** or **\fC0700**.) Defaults to **\fC1777** in Linux.
  


**--name**=""
   Assign a name to the container


The operator can identify a container in three ways:

.TS
allbox;
l l 
l l .
**\fCIdentifier type**	**\fCExample value**
UUID long identifier	T{
"f78375b1c487e03c9438c729345e54db9d20cfa2ac1fc3494b6eb60872e74778"
T}
UUID short identifier	"f78375b1c487"
Name	"evil\_ptolemy"
.TE


The UUID identifiers come from the Docker daemon, and if a name is not assigned
to the container with **--name** then the daemon will also generate a random
string name. The name is useful when defining links (see **--link**) (or any
other place you need to identify a container). This works for both background
and foreground Docker containers.


**--network**=_type_
   Set the Network mode for the container. Supported values are:

.TS
allbox;
l l 
l l .
**\fCValue**	**\fCDescription**
**none**	T{
No networking in the container.
T}
**bridge**	T{
Connect the container to the default Docker bridge via veth interfaces.
T}
**host**	T{
Use the host's network stack inside the container.
T}
**container:**_name_	_id_
_network-name_	_network-id_
.TE


Default is **bridge**.


**--network-alias**=[]
   Add network-scoped alias for the container


**--oom-kill-disable**=_true_|_false_
   Whether to disable OOM Killer for the container or not.


**--oom-score-adj**=""
   Tune the host's OOM preferences for containers (accepts -1000 to 1000)


**-P**, **--publish-all**=_true_|_false_
   Publish all exposed ports to random ports on the host interfaces. The default is _false_.


When set to true publish all exposed ports to the host interfaces. The
default is false. If the operator uses -P (or -p) then Docker will make the
exposed port accessible on the host and the ports will be available to any
client that can reach the host. When using -P, Docker will bind any exposed
port to a random port on the host within an _ephemeral port range_ defined by
**\fC/proc/sys/net/ipv4/ip\\_local\\_port\\_range**. To find the mapping between the host
ports and the exposed ports, use **\fCdocker port**(1).


**-p**, **--publish** _ip_:[_hostPort_]:_containerPort_ | [_hostPort_:]_containerPort_
   Publish a container's port, or range of ports, to the host.


Both _hostPort_ and _containerPort_ can be specified as a range.
When specifying ranges for both, the number of ports in ranges should be equal.


Examples: **-p 1234-1236:1222-1224**, **-p 127.0.0.1:$HOSTPORT:$CONTAINERPORT**.


Use **\fCdocker port**(1) to see the actual mapping, e.g. **\fCdocker port CONTAINER $CONTAINERPORT**.


**--pid**=""
   Set the PID mode for the container
   Default is to create a private PID namespace for the container
                               'container:&lt;name|id&gt;': join another container's PID namespace
                               'host': use the host's PID namespace for the container. Note: the host mode gives the container full access to local PID and is therefore considered insecure.


**--userns**=""
   Set the usernamespace mode for the container when **\fCuserns-remap** option is enabled.
     **host**: use the host usernamespace and enable all privileged options (e.g., **\fCpid=host** or **\fC--privileged**).


**--pids-limit**=""
   Tune the container's pids (process IDs) limit. Set to **\fC-1** to have unlimited pids for the container.


**--uts**=_type_
   Set the UTS mode for the container. The only possible _type_ is **host**, meaning to
use the host's UTS namespace inside the container.
     Note: the host mode gives the container access to changing the host's hostname and is therefore considered insecure.


**--privileged** [**true**|**false**]
   Give extended privileges to this container. A "privileged" container is given access to all devices.


When the operator executes **docker run --privileged**, Docker will enable access
to all devices on the host as well as set some configuration in AppArmor to
allow the container nearly all the same access to the host as processes running
outside of a container on the host.


**--read-only**=**true**|**false**
   Mount the container's root filesystem as read only.


By default a container will have its root filesystem writable allowing processes
to write files anywhere.  By specifying the **\fC--read-only** flag the container will have
its root filesystem mounted as read only prohibiting any writes.


**--restart** _policy_
   Restart policy to apply when a container exits. Supported values are:

.TS
allbox;
l l 
l l .
**\fCPolicy**	**\fCResult**
**no**	T{
Do not automatically restart the container when it exits.
T}
T{
**on-failure**[:_max-retries_]
T}	T{
Restart only if the container exits with a non-zero exit status. Optionally, limit the number of restart retries the Docker daemon attempts.
T}
**always**	T{
Always restart the container regardless of the exit status. When you specify always, the Docker daemon will try to restart the container indefinitely. The container will also always start on daemon startup, regardless of the current state of the container.
T}
**unless-stopped**	T{
Always restart the container regardless of the exit status, but do not start it on daemon startup if the container has been put to a stopped state before.
T}
.TE


Default is **no**.


**--rm** **true**|**false**
   Automatically remove the container when it exits. The default is **false**.
   **\fC--rm** flag can work together with **\fC-d**, and auto-removal will be done on daemon side. Note that it's
incompatible with any restart policy other than **\fCnone**.


**--security-opt** _value_[,...]
   Security Options for the container. The following options can be given:



    "label=user:USER"   : Set the label user for the container
    "label=role:ROLE"   : Set the label role for the container
    "label=type:TYPE"   : Set the label type for the container
    "label=level:LEVEL" : Set the label level for the container
    "label=disable"     : Turn off label confinement for the container
    "no-new-privileges" : Disable container processes from gaining additional privileges
    
    "seccomp=unconfined" : Turn off seccomp confinement for the container
    "seccomp=profile.json :  White listed syscalls seccomp Json file to be used as a seccomp filter
    
    "apparmor=unconfined" : Turn off apparmor confinement for the container
    "apparmor=your-profile" : Set the apparmor confinement profile for the container
    


**--storage-opt**
   Storage driver options per container


$ docker run -it --storage-opt size=120G fedora /bin/bash


This (size) will allow to set the container rootfs size to 120G at creation time.
   This option is only available for the **\fCdevicemapper**, **\fCbtrfs**, **\fCoverlay2**  and **\fCzfs** graph drivers.
   For the **\fCdevicemapper**, **\fCbtrfs** and **\fCzfs** storage drivers, user cannot pass a size less than the Default BaseFS Size.
   For the **\fCoverlay2** storage driver, the size option is only available if the backing fs is **\fCxfs** and mounted with the **\fCpquota** mount option.
   Under these conditions, user can pass any size less than the backing fs size.


**--stop-signal**=_SIGTERM_
  Signal to stop a container. Default is SIGTERM.


**--stop-timeout**=_10_
  Timeout (in seconds) to stop a container. Default is 10.


**--shm-size**=""
   Size of **\fC/dev/shm**. The format is **\fC&lt;number&gt;&lt;unit&gt;**.
   **\fCnumber** must be greater than **\fC0**.  Unit is optional and can be **\fCb** (bytes), **\fCk** (kilobytes), **\fCm**(megabytes), or **\fCg** (gigabytes).
   If you omit the unit, the system uses bytes. If you omit the size entirely, the system uses **\fC64m**.


**--sysctl**=SYSCTL
  Configure namespaced kernel parameters at runtime


IPC Namespace - current sysctls allowed:


kernel.msgmax, kernel.msgmnb, kernel.msgmni, kernel.sem, kernel.shmall, kernel.shmmax, kernel.shmmni, kernel.shm\_rmid\_forced
  Sysctls beginning with fs.mqueue.*


If you use the **\fC--ipc=host** option these sysctls will not be allowed.


Network Namespace - current sysctls allowed:
      Sysctls beginning with net.*


If you use the **\fC--network=host** option these sysctls will not be allowed.


**--sig-proxy**=_true_|_false_
   Proxy received signals to the process (non-TTY mode only). SIGCHLD, SIGSTOP, and SIGKILL are not proxied. The default is _true_.


**--memory-swappiness**=""
   Tune a container's memory swappiness behavior. Accepts an integer between 0 and 100.


**-t**, **--tty**=_true_|_false_
   Allocate a pseudo-TTY. The default is _false_.


When set to true Docker can allocate a pseudo-tty and attach to the standard
input of any container. This can be used, for example, to run a throwaway
interactive shell. The default is false.


The **-t** option is incompatible with a redirection of the docker client
standard input.


**--tmpfs**=[] Create a tmpfs mount


Mount a temporary filesystem (**\fCtmpfs**) mount into a container, for example:


$ docker run -d --tmpfs /tmp:rw,size=787448k,mode=1777 my\_image


This command mounts a **\fCtmpfs** at **\fC/tmp** within the container.  The supported mount
options are the same as the Linux default **\fCmount** flags. If you do not specify
any options, the systems uses the following options:
**\fCrw,noexec,nosuid,nodev,size=65536k**.


See also **\fC--mount**, which is the successor of **\fC--tmpfs** and **\fC--volume**.
   Even though there is no plan to deprecate **\fC--tmpfs**, usage of **\fC--mount** is recommended.


**-u**, **--user**=""
   Sets the username or UID used and optionally the groupname or GID for the specified command.


The followings examples are all valid:
   --user [user | user:group | uid | uid:gid | user:gid | uid:group ]


Without this argument the command will be run as root in the container.


**--ulimit**=[]
    Ulimit options


**-v**|**--volume**[=_[[HOST-DIR:]CONTAINER-DIR[:OPTIONS]]_]
   Create a bind mount. If you specify, **\fC-v /HOST-DIR:/CONTAINER-DIR**, Docker
   bind mounts **\fC/HOST-DIR** in the host to **\fC/CONTAINER-DIR** in the Docker
   container. If 'HOST-DIR' is omitted,  Docker automatically creates the new
   volume on the host.  The **\fCOPTIONS** are a comma delimited list and can be:


* ·  
  [rw|ro]
* ·  
  [z|Z]
* ·  
  [**\fC[r]shared**|**\fC[r]slave**|**\fC[r]private**]
* ·  
  [**\fCdelegated**|**\fCcached**|**\fCconsistent**]
* ·  
  [nocopy]
  


The **\fCCONTAINER-DIR** must be an absolute path such as **\fC/src/docs**. The **\fCHOST-DIR**
can be an absolute path or a **\fCname** value. A **\fCname** value must start with an
alphanumeric character, followed by **\fCa-z0-9**, **\fC\\_** (underscore), **\fC.** (period) or
**\fC-** (hyphen). An absolute path starts with a **\fC/** (forward slash).


If you supply a **\fCHOST-DIR** that is an absolute path,  Docker bind-mounts to the
path you specify. If you supply a **\fCname**, Docker creates a named volume by that
**\fCname**. For example, you can specify either **\fC/foo** or **\fCfoo** for a **\fCHOST-DIR**
value. If you supply the **\fC/foo** value, Docker creates a bind mount. If you
supply the **\fCfoo** specification, Docker creates a named volume.


You can specify multiple  **-v** options to mount one or more mounts to a
container. To use these same mounts in other containers, specify the
**--volumes-from** option also.


You can supply additional options for each bind mount following an additional
colon.  A **\fC:ro** or **\fC:rw** suffix mounts a volume in read-only or read-write
mode, respectively. By default, volumes are mounted in read-write mode.
You can also specify the consistency requirement for the mount, either
**\fC:consistent** (the default), **\fC:cached**, or **\fC:delegated**.  Multiple options are
separated by commas, e.g. **\fC:ro,cached**.


Labeling systems like SELinux require that proper labels are placed on volume
content mounted into a container. Without a label, the security system might
prevent the processes running inside the container from using the content. By
default, Docker does not change the labels set by the OS.


To change a label in the container context, you can add either of two suffixes
**\fC:z** or **\fC:Z** to the volume mount. These suffixes tell Docker to relabel file
objects on the shared volumes. The **\fCz** option tells Docker that two containers
share the volume content. As a result, Docker labels the content with a shared
content label. Shared volume labels allow all containers to read/write content.
The **\fCZ** option tells Docker to label the content with a private unshared label.
Only the current container can use a private volume.


By default bind mounted volumes are **\fCprivate**. That means any mounts done
inside container will not be visible on host and vice-a-versa. One can change
this behavior by specifying a volume mount propagation property. Making a
volume **\fCshared** mounts done under that volume inside container will be
visible on host and vice-a-versa. Making a volume **\fCslave** enables only one
way mount propagation and that is mounts done on host under that volume
will be visible inside container but not the other way around.


To control mount propagation property of volume one can use **\fC:[r]shared**,
**\fC:[r]slave** or **\fC:[r]private** propagation flag. Propagation property can
be specified only for bind mounted volumes and not for internal volumes or
named volumes. For mount propagation to work source mount point (mount point
where source dir is mounted on) has to have right propagation properties. For
shared volumes, source mount point has to be shared. And for slave volumes,
source mount has to be either shared or slave.


Use **\fCdf &lt;source-dir&gt;** to figure out the source mount and then use
**\fCfindmnt -o TARGET,PROPAGATION &lt;source-mount-dir&gt;** to figure out propagation
properties of source mount. If **\fCfindmnt** utility is not available, then one
can look at mount entry for source mount point in **\fC/proc/self/mountinfo**. Look
at **\fCoptional fields** and see if any propagation properties are specified.
**\fCshared:X** means mount is **\fCshared**, **\fCmaster:X** means mount is **\fCslave** and if
nothing is there that means mount is **\fCprivate**.


To change propagation properties of a mount point use **\fCmount** command. For
example, if one wants to bind mount source directory **\fC/foo** one can do
**\fCmount --bind /foo /foo** and **\fCmount --make-private --make-shared /foo**. This
will convert /foo into a **\fCshared** mount point. Alternatively one can directly
change propagation properties of source mount. Say **\fC/** is source mount for
**\fC/foo**, then use **\fCmount --make-shared /** to convert **\fC/** into a **\fCshared** mount.




**Note**:
When using systemd to manage the Docker daemon's start and stop, in the systemd
unit file there is an option to control mount propagation for the Docker daemon
itself, called **\fCMountFlags**. The value of this setting may cause Docker to not
see mount propagation changes made on the mount point. For example, if this value
is **\fCslave**, you may not be able to use the **\fCshared** or **\fCrshared** propagation on
a volume.


To disable automatic copying of data from the container path to the volume, use
the **\fCnocopy** flag. The **\fCnocopy** flag can be set on bind mounts and named volumes.


See also **\fC--mount**, which is the successor of **\fC--tmpfs** and **\fC--volume**.
Even though there is no plan to deprecate **\fC--volume**, usage of **\fC--mount** is recommended.


**--volume-driver**=""
   Container's volume driver. This driver creates volumes specified either from
   a Dockerfile's **\fCVOLUME** instruction or from the **\fCdocker run -v** flag.
   See **docker-volume-create(1)** for full details.


**--volumes-from**=[]
   Mount volumes from the specified container(s)


Mounts already mounted volumes from a source container onto another
   container. You must supply the source's container-id. To share
   a volume, use the **--volumes-from** option when running
   the target container. You can share volumes even if the source container
   is not running.


By default, Docker mounts the volumes in the same mode (read-write or
   read-only) as it is mounted in the source container. Optionally, you
   can change this by suffixing the container-id with either the **\fC:ro** or
   **\fC:rw** keyword.


If the location of the volume from the source container overlaps with
   data residing on a target container, then the volume hides
   that data on the target.


**-w**, **--workdir**=""
   Working directory inside the container


The default working directory for
running binaries within a container is the root directory (/). The developer can
set a different default with the Dockerfile WORKDIR instruction. The operator
can override the working directory by using the **-w** option.



<a name="exit-status"></a>

# Exit Status


The exit code from **\fCdocker run** gives information about why the container
failed to run or why it exited.  When **\fCdocker run** exits with a non-zero code,
the exit codes follow the **\fCchroot** standard, see below:


**125** if the error is with Docker daemon **itself**



    $ docker run --foo busybox; echo $?
    # flag provided but not defined: --foo
      See 'docker run --help'.
      125
    


**126** if the **contained command** cannot be invoked



    $ docker run busybox /etc; echo $?
    # exec: "/etc": permission denied
      docker: Error response from daemon: Contained command could not be invoked
      126
    


**127** if the **contained command** cannot be found



    $ docker run busybox foo; echo $?
    # exec: "foo": executable file not found in $PATH
      docker: Error response from daemon: Contained command not found or does not exist
      127
    


**Exit code** of **contained command** otherwise



    $ docker run busybox /bin/sh -c 'exit 3' 
    # 3
    



<a name="examples"></a>

# Examples


<a name="running-container-in-read-only-mode"></a>

# Running Container in Read\-Only Mode


During container image development, containers often need to write to the image
content.  Installing packages into /usr, for example.  In production,
applications seldom need to write to the image.  Container applications write
to volumes if they need to write to file systems at all.  Applications can be
made more secure by running them in read-only mode using the --read-only switch.
This protects the containers image from modification. Read only containers may
still need to write temporary data.  The best way to handle this is to mount
tmpfs directories on /run and /tmp.



    # docker run --read-only --tmpfs /run --tmpfs /tmp -i -t fedora /bin/bash
    


<a name="exposing-log-messages-from-the-container-to-the-hosts-log"></a>

# Exposing Log Messages from the Container to the Host's Log


If you want messages that are logged in your container to show up in the host's
syslog/journal then you should bind mount the /dev/log directory as follows.



    # docker run -v /dev/log:/dev/log -i -t fedora /bin/bash
    


From inside the container you can test this by sending a message to the log.



    (bash)# logger "Hello from my container"
    


Then exit and check the journal.



    # exit
    
    # journalctl -b | grep Hello
    


This should list the message sent to logger.


<a name="attaching-to-one-or-more-from-stdin-stdout-stderr"></a>

# Attaching to One or More from Stdin, Stdout, Stderr


If you do not specify -a then Docker will attach everything (stdin,stdout,stderr)
you'd like to connect instead, as in:



    # docker run -a stdin -a stdout -i -t fedora /bin/bash
    


<a name="sharing-ipc-between-containers"></a>

# Sharing Ipc Between Containers


Using shm\_server.c available here: 
\[la]https://www.cs.cf.ac.uk/Dave/C/node27.html\[ra]


Testing **\fC--ipc=host** mode:


Host shows a shared memory segment with 7 pids attached, happens to be from httpd:



     $ sudo ipcs -m
    
     ------ Shared Memory Segments --------
     key        shmid      owner      perms      bytes      nattch     status      
     0x01128e25 0          root       600        1000       7                       
    


Now run a regular container, and it correctly does NOT see the shared memory segment from the host:



     $ docker run -it shm ipcs -m
    
     ------ Shared Memory Segments --------
     key        shmid      owner      perms      bytes      nattch     status      
    


Run a container with the new **\fC--ipc=host** option, and it now sees the shared memory segment from the host httpd:



     $ docker run -it --ipc=host shm ipcs -m
    
     ------ Shared Memory Segments --------
     key        shmid      owner      perms      bytes      nattch     status      
     0x01128e25 0          root       600        1000       7                   
    


Testing **\fC--ipc=container:CONTAINERID** mode:


Start a container with a program to create a shared memory segment:



     $ docker run -it shm bash
     $ sudo shm/shm_server 
     $ sudo ipcs -m
    
     ------ Shared Memory Segments --------
     key        shmid      owner      perms      bytes      nattch     status      
     0x0000162e 0          root       666        27         1                       
    


Create a 2nd container correctly shows no shared memory segment from 1st container:



     $ docker run shm ipcs -m
    
     ------ Shared Memory Segments --------
     key        shmid      owner      perms      bytes      nattch     status      
    


Create a 3rd container using the new --ipc=container:CONTAINERID option, now it shows the shared memory segment from the first:



     $ docker run -it --ipc=container:ed735b2264ac shm ipcs -m
     $ sudo ipcs -m
    
     ------ Shared Memory Segments --------
     key        shmid      owner      perms      bytes      nattch     status      
     0x0000162e 0          root       666        27         1
    


<a name="linking-containers"></a>

# Linking Containers




**Note**: This section describes linking between containers on the
default (bridge) network, also known as "legacy links". Using **\fC--link**
on user-defined networks uses the DNS-based discovery, which does not add
entries to **\fC/etc/hosts**, and does not set environment variables for
discovery.


The link feature allows multiple containers to communicate with each other. For
example, a container whose Dockerfile has exposed port 80 can be run and named
as follows:



    # docker run --name=link-test -d -i -t fedora/httpd
    


A second container, in this case called linker, can communicate with the httpd
container, named link-test, by running with the **--link=&lt;name&gt;:&lt;alias&gt;**



    # docker run -t -i --link=link-test:lt --name=linker fedora /bin/bash
    


Now the container linker is linked to container link-test with the alias lt.
Running the **env** command in the linker container shows environment variables
 with the LT (alias) context (**LT\\_**)



    # env
    HOSTNAME=668231cb0978
    TERM=xterm
    LT_PORT_80_TCP=tcp://172.17.0.3:80
    LT_PORT_80_TCP_PORT=80
    LT_PORT_80_TCP_PROTO=tcp
    LT_PORT=tcp://172.17.0.3:80
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    PWD=/
    LT_NAME=/linker/lt
    SHLVL=1
    HOME=/
    LT_PORT_80_TCP_ADDR=172.17.0.3
    _=/usr/bin/env
    


When linking two containers Docker will use the exposed ports of the container
to create a secure tunnel for the parent to access.


If a container is connected to the default bridge network and **\fClinked**
with other containers, then the container's **\fC/etc/hosts** file is updated
with the linked container's name.




**Note** Since Docker may live update the container's **\fC/etc/hosts** file, there
may be situations when processes inside the container can end up reading an
empty or incomplete **\fC/etc/hosts** file. In most cases, retrying the read again
should fix the problem.


<a name="mapping-ports-for-external-usage"></a>

# Mapping Ports for External Usage


The exposed port of an application can be mapped to a host port using the **-p**
flag. For example, an httpd port 80 can be mapped to the host port 8080 using the
following:



    # docker run -p 8080:80 -d -i -t fedora/httpd
    


<a name="creating-and-mounting-a-data-volume-container"></a>

# Creating and Mounting a Data Volume Container


Many applications require the sharing of persistent data across several
containers. Docker allows you to create a Data Volume Container that other
containers can mount from. For example, create a named container that contains
directories /var/volume1 and /tmp/volume2. The image will need to contain these
directories so a couple of RUN mkdir instructions might be required for you
fedora-data image:



    # docker run --name=data -v /var/volume1 -v /tmp/volume2 -i -t fedora-data true
    # docker run --volumes-from=data --name=fedora-container1 -i -t fedora bash
    


Multiple --volumes-from parameters will bring together multiple data volumes from
multiple containers. And it's possible to mount the volumes that came from the
DATA container in yet another container via the fedora-container1 intermediary
container, allowing to abstract the actual data source from users of that data:



    # docker run --volumes-from=fedora-container1 --name=fedora-container2 -i -t fedora bash
    


<a name="mounting-external-volumes"></a>

# Mounting External Volumes


To mount a host directory as a container volume, specify the absolute path to
the directory and the absolute path for the container directory separated by a
colon:



    # docker run -v /var/db:/data1 -i -t fedora bash
    


When using SELinux, be aware that the host has no knowledge of container SELinux
policy. Therefore, in the above example, if SELinux policy is enforced, the
**\fC/var/db** directory is not writable to the container. A "Permission Denied"
message will occur and an avc: message in the host's syslog.


To work around this, at time of writing this man page, the following command
needs to be run in order for the proper SELinux policy type label to be attached
to the host directory:



    # chcon -Rt svirt_sandbox_file_t /var/db
    


Now, writing to the /data1 volume in the container will be allowed and the
changes will also be reflected on the host in /var/db.


<a name="using-alternative-security-labeling"></a>

# Using Alternative Security Labeling


You can override the default labeling scheme for each container by specifying
the **\fC--security-opt** flag. For example, you can specify the MCS/MLS level, a
requirement for MLS systems. Specifying the level in the following command
allows you to share the same content between containers.



    # docker run --security-opt label=level:s0:c100,c200 -i -t fedora bash
    


An MLS example might be:



    # docker run --security-opt label=level:TopSecret -i -t rhel7 bash
    


To disable the security labeling for this container versus running with the
**\fC--permissive** flag, use the following command:



    # docker run --security-opt label=disable -i -t fedora bash
    


If you want a tighter security policy on the processes within a container,
you can specify an alternate type for the container. You could run a container
that is only allowed to listen on Apache ports by executing the following
command:



    # docker run --security-opt label=type:svirt_apache_t -i -t centos bash
    


Note:


You would have to write policy defining a **\fCsvirt\\_apache\\_t** type.


<a name="setting-device-weight"></a>

# Setting Device Weight


If you want to set **\fC/dev/sda** device weight to **\fC200**, you can specify the device
weight by **\fC--blkio-weight-device** flag. Use the following command:



    # docker run -it --blkio-weight-device "/dev/sda:200" ubuntu
    


<a name="specify-isolation-technology-for-container-isolation"></a>

# Specify Isolation Technology for Container (\-\-Isolation)


This option is useful in situations where you are running Docker containers on
Microsoft Windows. The **\fC--isolation &lt;value&gt;** option sets a container's isolation
technology. On Linux, the only supported is the **\fCdefault** option which uses
Linux namespaces. These two commands are equivalent on Linux:



    $ docker run -d busybox top
    $ docker run -d --isolation default busybox top
    


On Microsoft Windows, can take any of these values:


* ·  
  **\fCdefault**: Use the value specified by the Docker daemon's **\fC--exec-opt** . If the **\fCdaemon** does not specify an isolation technology, Microsoft Windows uses **\fCprocess** as its default value.
* ·  
  **\fCprocess**: Namespace isolation only.
* ·  
  **\fChyperv**: Hyper-V hypervisor partition-based isolation.
  


In practice, when running on Microsoft Windows without a **\fCdaemon** option set,  these two commands are equivalent:



    $ docker run -d --isolation default busybox top
    $ docker run -d --isolation process busybox top
    


If you have set the **\fC--exec-opt isolation=hyperv** option on the Docker **\fCdaemon**, any of these commands also result in **\fChyperv** isolation:



    $ docker run -d --isolation default busybox top
    $ docker run -d --isolation hyperv busybox top
    


<a name="setting-namespaced-kernel-parameters-sysctls"></a>

# Setting Namespaced Kernel Parameters (Sysctls)


The **\fC--sysctl** sets namespaced kernel parameters (sysctls) in the
container. For example, to turn on IP forwarding in the containers
network namespace, run this command:



    $ docker run --sysctl net.ipv4.ip_forward=1 someimage
    


Note:


Not all sysctls are namespaced. Docker does not support changing sysctls
inside of a container that also modify the host system. As the kernel
evolves we expect to see more sysctls become namespaced.


See the definition of the **\fC--sysctl** option above for the current list of
supported sysctls.



<a name="history"></a>

# History


April 2014, Originally compiled by William Henry (whenry at redhat dot com)
based on docker.com source material and internal work.
June 2014, updated by Sven Dowideit 
\[la]SvenDowideit@home.org.au\[ra]
July 2014, updated by Sven Dowideit 
\[la]SvenDowideit@home.org.au\[ra]
November 2015, updated by Sally O'Malley 
\[la]somalley@redhat.com\[ra]
