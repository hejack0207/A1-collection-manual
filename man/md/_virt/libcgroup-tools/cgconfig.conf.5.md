# cgconfig.conf(5) - libcgroup configuration file


<a name="description"></a>

# Description

**cgconfig.conf**
is a configuration file used by
**libcgroup**
to define control groups, their parameters and their mount points.
The file consists of
_mount_
,
_group_
and
_default_
sections. These sections can be in arbitrary order and all of them are
optional. Any line starting with '#' is considered a comment line and
is ignored.

_mount_
section has this form:
    .ft B
    
    mount {
    .RS
    .ft B
    <controller> = <path>;
    "..."
    .RE
    .ft B
    }
    .ft R


* **controller**  
  Name of the kernel subsystem. The list of subsystems supported by the kernel
  can be found in 
  _/proc/cgroups_
  file. Named hierarchy can be specified as controller
  **"name=&lt;somename&gt;"**. Do not forget to use double quotes around
  this controller name (see examples below). Apart from named hierarchy,
  additional mount options may be specified by putting the controller and
  the options in quotes. Options supported are ** nosuid, noexec** and** nodev**.
  
  **Libcgroup**
  merges all subsystems mounted to the same directory (see
  Example 1) and the directory is mounted only once.
  
* **path**  
  The directory path where the group hierarchy associated to a given
  controller shall be mounted. The directory is created
  automatically on cgconfig service startup if it does not exist and
  is deleted on service shutdown.


If no
_mount_
section is specified, no controllers are mounted.

_group_
section has this form:
    .ft B
    
    group <name> {
    .RS
    .ft B
    [permissions]
    <controller> {
    .RS
    .ft B
    <param name> = <param value>;
    "..."
    .RE
    .ft B
    }
    "..."
    .RE
    .ft B
    }
    .ft R


* **name**  
  Name of the control group. It can contain only characters, which are
  allowed for directory names. 
  The groups form a tree, i.e. a control group can contain zero or more
  subgroups. Subgroups can be specified using '/' delimiter. 
  
  The root control group is always created automatically in all hierarchies
  and it is the base of the group hierarchy. It can be explicitly specified in
  **cgconfig.conf**
  by using '.' as group name. This can be used e.g. to set its permissions,
  as shown in Example 6.
  
  When the parent control group of a subgroup is not specified
  it is created automatically.
  
* **permissions**  
  Permissions of the given control group on mounted filesystem.
  _root_
  has always permission to do anything with the control group.
  Permissions have the following syntax:
    perm {
    .RS
    .ft B
    task {
    .RS
    .ft B
    uid = <task user>;
    gid = <task group>;
    fperm = <file permissions>
    .RE
    }
    admin {
    .RS
    uid = <admin name>;
    gid = <admin group>;
    dperm = <directory permissions>
    fperm = <file permissions>
    .RE
    }
    .RE
    }
  
    * **task user/group**  
      Name of the user and the group, which own the
      _tasks_
      file of the control group. Given fperm then specify the file permissions.
      Please note that the given value is not used as was specified. Instead,
      current file owner permissions are used as a "umask" for group and others
      permissions. For example if fperm = 777 then both group and others will get
      the same permissions as the file owner.
    * **admin user/group**  
      Name of the user and the group which own the rest of control group's
      files. Given fperm and dperm control file and directory permissions.
      Again, the given value is masked by the file/directory owner permissions.

Permissions are only apply to the enclosing control group and are not
inherited by subgroups. If there is no
**perm**
section in the control group definition,
_root:root_
is the owner of all files and default file permissions are preserved if
fperm resp. dperm are not specified.

* **controller**  
  Name of the kernel subsystem.
  The section can be
  empty, default kernel parameters will be used in this case. By
  specifying
  **controller**
  the control group and all its parents are controlled by the specific
  subsystem. One control group can be controlled by multiple subsystems,
  even if the subsystems are mounted on different directories. Each
  control group must be controlled by at least one subsystem, so that
  **libcgroup**
  knows in which hierarchies the control group should be created.
  
  The parameters of the given controller can be modified in the following
  section enclosed in brackets.
    * **param name**  
      Name of the file to set. Each controller can have zero or more
      parameters.
    * **param value**  
      Value which should be written to the file when the control group is
      created. If it is enclosed in double quotes \`"', it can contain spaces
      and other special characters.
  
  If no
  _group_
  section is specified, no groups are created.
  
  _default_
  section has this form:
    .ft B
    
    default {
    .RS
    .ft B
    perm {
    .RS
    .ft B
    task {
    .RS
    .ft B
    uid = <task user>;
    gid = <task group>;
    fperm = <file permissions>
    .RE
    }
    admin {
    .RS
    uid = <admin name>;
    gid = <admin group>;
    dperm = <directory permissions>
    fperm = <file permissions>
    .RE
    }
    .RE
    }
    .RE
    }
    .ft R

Content of the
**perm**
section has the same form as in
_group_
section. The permissions defined here specify owner and permissions of
groups and files of all groups, which do not have explicitly specified
their permissions in their
_group_
section.

_template_
section has the same structure as
**group**
section. Template name uses the same templates string as
**cgrules.conf**
destination tag (see (**cgrules.conf** (5)).
Template definition is used as a control group definition for rules in
**cgrules.conf** (5) with the same destination name.
Templates does not use
**default**
section settings.

_/etc/cgconfig.d/_
directory can be used for additional configuration files. cgrulesengd searches this directory for additional templates.



<a name="examples"></a>

# Examples



<a name="example-1"></a>

### Example 1


The configuration file:

    mount {
    .RS
    cpu = /mnt/cgroups/cpu;
    cpuacct = /mnt/cgroups/cpu;
    .RE
    }

creates the hierarchy controlled by two subsystems with no groups
inside. It corresponds to the following operations:

    mkdir /mnt/cgroups/cpu
    mount -t cgroup -o cpu,cpuacct cpu /mnt/cgroups/cpu


<a name="example-2"></a>

### Example 2


The configuration file:

    mount {
    .RS
    cpu = /mnt/cgroups/cpu;
    "name=scheduler" = /mnt/cgroups/cpu;
    "name=noctrl" = /mnt/cgroups/noctrl;
    .RE
    }
    
    group daemons {
    .RS
    cpu {
    .RS
    cpu.shares = "1000";
    .RE
    }
    .RE
    }
    group test {
    .RS
    "name=noctrl" {
    }
    .RE
    }
    .RE
creates two hierarchies. One hierarchy named **scheduler** controlled by cpu
subsystem, with group **daemons** inside. Second hierarchy is named
**noctrl** without any controller, with group **test**. It corresponds to
following operations:

    mkdir /mnt/cgroups/cpu
    mount -t cgroup -o cpu,name=scheduler cpu /mnt/cgroups/cpu
    mount -t cgroup -o none,name=noctrl none /mnt/cgroups/noctrl
    
    mkdir /mnt/cgroups/cpu/daemons
    echo 1000 > /mnt/cgroups/cpu/daemons/www/cpu.shares
    
    mkdir /mnt/cgroups/noctrl/tests

The
_daemons_
group is created automatically when its first subgroup is
created. All its parameters have the default value and only root can
access group's files.

Since both
_cpuacct_
and
_cpu_
subsystems are mounted to the same directory, all
groups are implicitly controlled also by
_cpuacct_
subsystem, even if there is no
_cpuacct_
section in any of the groups.


<a name="example-3"></a>

### Example 3


The configuration file:

    mount {
    .RS
    cpu = /mnt/cgroups/cpu;
    cpuacct = /mnt/cgroups/cpu;
    .RE
    }
    
    group daemons/www {
    .RS
    perm {
    .RS
    task {
    .RS
    uid = root;
    gid = webmaster;
    fperm = 770;
    .RE
    }
    admin {
    .RS
    uid = root;
    gid = root;
    dperm = 775;
    fperm = 744;
    .RE
    }
    .RE
    }
    cpu {
    .RS
    cpu.shares = "1000";
    .RE
    }
    .RE
    }
    
    group daemons/ftp {
    .RS
    perm {
    .RS
    task {
    .RS
    uid = root;
    gid = ftpmaster;
    fperm = 774;
    .RE
    }
    admin {
    .RS
    uid = root;
    gid = root;
    dperm = 755;
    fperm = 700;
    .RE
    }
    .RE
    }
    cpu {
    .RS
    cpu.shares = "500";
    .RE
    }
    .RE
    }
    .RE
creates the hierarchy controlled by two subsystems with one group and
two subgroups inside, setting one parameter.
It corresponds to the following operations (except for file permissions
which are little bit trickier to emulate via chmod):


    mkdir /mnt/cgroups/cpu
    mount -t cgroup -o cpu,cpuacct cpu /mnt/cgroups/cpu
    
    mkdir /mnt/cgroups/cpu/daemons
    
    mkdir /mnt/cgroups/cpu/daemons/www
    chown root:root /mnt/cgroups/cpu/daemons/www/*
    chown root:webmaster /mnt/cgroups/cpu/daemons/www/tasks
    echo 1000 > /mnt/cgroups/cpu/daemons/www/cpu.shares
    
     # + chmod the files so the result looks like:
     # ls -la /mnt/cgroups/cpu/daemons/www/
     # admin.dperm = 755:
     # drwxr-xr-x. 2 root webmaster 0 Jun 16 11:51 .
     #
     # admin.fperm = 744:
     # --w-------. 1 root webmaster 0 Jun 16 11:51 cgroup.event_control
     # -r--r--r--. 1 root webmaster 0 Jun 16 11:51 cgroup.procs
     # -r--r--r--. 1 root webmaster 0 Jun 16 11:51 cpuacct.stat
     # -rw-r--r--. 1 root webmaster 0 Jun 16 11:51 cpuacct.usage
     # -r--r--r--. 1 root webmaster 0 Jun 16 11:51 cpuacct.usage_percpu
     # -rw-r--r--. 1 root webmaster 0 Jun 16 11:51 cpu.rt_period_us
     # -rw-r--r--. 1 root webmaster 0 Jun 16 11:51 cpu.rt_runtime_us
     # -rw-r--r--. 1 root webmaster 0 Jun 16 11:51 cpu.shares
     # -rw-r--r--. 1 root webmaster 0 Jun 16 11:51 notify_on_release
     #
     # tasks.fperm = 770
     # -rw-rw----. 1 root webmaster 0 Jun 16 11:51 tasks
    
    
    mkdir /mnt/cgroups/cpu/daemons/ftp
    chown root:root /mnt/cgroups/cpu/daemons/ftp/*
    chown root:ftpmaster /mnt/cgroups/cpu/daemons/ftp/tasks
    echo 500 > /mnt/cgroups/cpu/daemons/ftp/cpu.shares
    
     # + chmod the files so the result looks like:
     # ls -la /mnt/cgroups/cpu/daemons/ftp/
     # admin.dperm = 755:
     # drwxr-xr-x. 2 root ftpmaster 0 Jun 16 11:51 .
     #
     # admin.fperm = 700:
     # --w-------. 1 root ftpmaster 0 Jun 16 11:51 cgroup.event_control
     # -r--------. 1 root ftpmaster 0 Jun 16 11:51 cgroup.procs
     # -r--------. 1 root ftpmaster 0 Jun 16 11:51 cpuacct.stat
     # -rw-------. 1 root ftpmaster 0 Jun 16 11:51 cpuacct.usage
     # -r--------. 1 root ftpmaster 0 Jun 16 11:51 cpuacct.usage_percpu
     # -rw-------. 1 root ftpmaster 0 Jun 16 11:51 cpu.rt_period_us
     # -rw-------. 1 root ftpmaster 0 Jun 16 11:51 cpu.rt_runtime_us
     # -rw-------. 1 root ftpmaster 0 Jun 16 11:51 cpu.shares
     # -rw-------. 1 root ftpmaster 0 Jun 16 11:51 notify_on_release
     #
     # tasks.fperm = 774:
     # -rw-rw-r--. 1 root ftpmaster 0 Jun 16 11:51 tasks
    

The
_daemons_
group is created automatically when its first subgroup is
created. All its parameters have the default value and only root can
access the group's files.

Since both
_cpuacct_
and
_cpu_
subsystems are mounted to the same directory, all
groups are implicitly also controlled by the
_cpuacct_
subsystem, even if there is no
_cpuacct_
section in any of the groups.


<a name="example-4"></a>

### Example 4


The configuration file:


    mount {
    .RS
    cpu = /mnt/cgroups/cpu;
    cpuacct = /mnt/cgroups/cpuacct;
    .RE
    }
    
    group daemons {
    .RS
    cpuacct{
    }
    cpu {
    }
    .RE
    }
creates two hierarchies and one common group in both of them.
It corresponds to the following operations:

    mkdir /mnt/cgroups/cpu
    mkdir /mnt/cgroups/cpuacct
    mount -t cgroup -o cpu cpu /mnt/cgroups/cpu
    mount -t cgroup -o cpuacct cpuacct /mnt/cgroups/cpuacct
    
    mkdir /mnt/cgroups/cpu/daemons
    mkdir /mnt/cgroups/cpuacct/daemons

In fact there are two groups created. One in the
_cpuacct_
hierarchy, the second in the
_cpu_
hierarchy. These two groups have nothing in common and can
contain different subgroups and different tasks.


<a name="example-5"></a>

### Example 5



The configuration file:


    mount {
    .RS
    cpu = /mnt/cgroups/cpu;
    cpuacct = /mnt/cgroups/cpuacct;
    .RE
    }
    
    group daemons {
    .RS
    cpuacct{
    }
    .RE
    }
    
    group daemons/www {
    .RS
    cpu {
    .RS
    cpu.shares = "1000";
    .RE
    }
    .RE
    }
    
    group daemons/ftp {
    .RS
    cpu {
    .RS
    cpu.shares = "500";
    .RE
    }
    .RE
    }
creates two hierarchies with few groups inside. One of the groups
is created in both hierarchies.

It corresponds to the following operations:

    mkdir /mnt/cgroups/cpu
    mkdir /mnt/cgroups/cpuacct
    mount -t cgroup -o cpu cpu /mnt/cgroups/cpu
    mount -t cgroup -o cpuacct cpuacct /mnt/cgroups/cpuacct
    
    mkdir /mnt/cgroups/cpuacct/daemons
    mkdir /mnt/cgroups/cpu/daemons
    mkdir /mnt/cgroups/cpu/daemons/www
    echo 1000 > /mnt/cgroups/cpu/daemons/www/cpu.shares
    mkdir /mnt/cgroups/cpu/daemons/ftp
    echo 500 > /mnt/cgroups/cpu/daemons/ftp/cpu.shares
Group
_daemons_
is created in both hierarchies. In the
_cpuacct_
hierarchy the group is explicitly mentioned in the configuration
file. In the
_cpu_
hierarchy the group is created implicitly when
_www_
is created there. These two groups have nothing in common, for example
they do not share processes and subgroups. Groups
_www_
and
_ftp_
are created only in the
_cpu_
hierarchy and are not controlled by the
_cpuacct_
subsystem.


<a name="example-6"></a>

### Example 6


The configuration file:

    mount {
    .RS
    cpu = /mnt/cgroups/cpu;
    cpuacct = /mnt/cgroups/cpu;
    .RE
    }
    
    group . {
    .RS
    perm {
    .RS
    task {
    .RS
    uid = root;
    gid = operator;
    .RE
    }
    admin {
    .RS
    uid = root;
    gid = operator;
    .RE
    }
    .RE
    }
    cpu {
    }
    .RE
    }
    
    group daemons {
    .RS
    perm {
    .RS
    task {
    .RS
    uid = root;
    gid = daemonmaster;
    .RE
    }
    admin {
    .RS
    uid = root;
    gid = operator;
    .RE
    }
    .RE
    }
    cpu {
    }
    .RE
    }
    .RE
creates the hierarchy controlled by two subsystems with one group having some
special permissions.
It corresponds to the following operations:

    mkdir /mnt/cgroups/cpu
    mount -t cgroup -o cpu,cpuacct cpu /mnt/cgroups/cpu
    
    chown root:operator /mnt/cgroups/cpu/*
    chown root:operator /mnt/cgroups/cpu/tasks
    
    mkdir /mnt/cgroups/cpu/daemons
    chown root:operator /mnt/cgroups/cpu/daemons/*
    chown root:daemonmaster /mnt/cgroups/cpu/daemons/tasks

Users which are members of the
_operator_
group are allowed to administer the control groups, i.e. create new control
groups and move processes between these groups without having root
privileges.

Members of the
_daemonmaster_
group can move processes to the
_daemons_
control group, but they can not move the process out of the group. Only the
_operator_
or root can do that.


<a name="example-7"></a>

### Example 7


The configuration file:


    mount {
    .RS
    cpu = /mnt/cgroups/cpu;
    cpuacct = /mnt/cgroups/cpuacct;
    .RE
    }
    
    group students {
    .RS
    cpuacct{
    }
    cpu {
    }
    .RE
    }
    
    template students/%u {
    .RS
    cpuacct{
    }
    cpu {
    }
    .RE
    }
    
    mkdir /mnt/cgroups/cpu/daemons
    mkdir /mnt/cgroups/cpuacct/daemons

The situation is the similar as in Example 4. The only difference is template,
which is used if some rule uses "/students/%u" as a destination.


<a name="example-8"></a>

### Example 8


The configuration file:


    mount {
    .RS
    "cpu,nodev,nosuid,noexec" = /mnt/cgroups/cpu;
    .RE
    }
    

This is the same as
mount -t cgroup cgroup -o nodev,nosuid,noexec,cpu /mnt/cgroups/cpu
It mounts the cpu controller with MS_NODEV, MS_NOSUID and MS_NOEXEC
options passed.



<a name="recommendations"></a>

# Recommendations


<a name="keep-hierarchies-separated"></a>

### Keep hierarchies separated

Having multiple hierarchies is perfectly valid and can be useful
in various scenarios. To keeps things clean, do not
create one group in multiple hierarchies. Examples 4 and 5 show
how unreadable and confusing it can be, especially when reading
somebody elses configuration file.


<a name="explicit-is-better-than-implicit"></a>

### Explicit is better than implicit

**libcgroup**
can implicitly create groups which are needed for the creation of
configured subgroups. This may be useful and save some typing in
simple scenarios. When it comes to multiple hierarchies, it's
better to explicitly specify all groups and all controllers
related to them.


<a name="files"></a>

# Files


* **/etc/cgconfig.conf**  
  default libcgroup configuration file
* **/etc/cgconfig.d/**  
  default libcgroup configuration files directory
  

<a name="see-also"></a>

# See Also

cgconfigparser (8)


<a name="bugs"></a>

# Bugs

Parameter values must be single strings without spaces.
Parsing of quoted strings is not implemented.

.SH

