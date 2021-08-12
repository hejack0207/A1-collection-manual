# ceph(8) - ceph administration tool

dev, Apr 21, 2020

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="synopsis"></a>

# Synopsis

    ceph auth [ add | caps | del | export | get | get-key | get-or-create | get-or-create-key | import | list | print-key | print_key ] ...
```


</synopsis>
    ceph compact
<synopsis>


</synopsis>
    ceph config-key [ rm | exists | get | ls | dump | set ] ...
<synopsis>


</synopsis>
    ceph daemon <name> | <path> <command> ...
<synopsis>


</synopsis>
    ceph daemonperf <name> | <path> [ interval [ count ] ]
<synopsis>


</synopsis>
    ceph df {detail}
<synopsis>


</synopsis>
    ceph fs [ ls | new | reset | rm ] ...
<synopsis>


</synopsis>
    ceph fsid
<synopsis>


</synopsis>
    ceph health {detail}
<synopsis>


</synopsis>
    ceph heap [ dump | start_profiler | stop_profiler | release | get_release_rate | set_release_rate | stats ] ...
<synopsis>


</synopsis>
    ceph injectargs <injectedargs> [ <injectedargs>... ]
<synopsis>


</synopsis>
    ceph log <logtext> [ <logtext>... ]
<synopsis>


</synopsis>
    ceph mds [ compat | fail | rm | rmfailed | set_state | stat | repaired ] ...
<synopsis>


</synopsis>
    ceph mon [ add | dump | getmap | remove | stat ] ...
<synopsis>


</synopsis>
    ceph mon_status
<synopsis>


</synopsis>
    ceph osd [ blacklist | blocked-by | create | new | deep-scrub | df | down | dump | erasure-code-profile | find | getcrushmap | getmap | getmaxosd | in | ls | lspools | map | metadata | ok-to-stop | out | pause | perf | pg-temp | force-create-pg | primary-affinity | primary-temp | repair | reweight | reweight-by-pg | rm | destroy | purge | safe-to-destroy | scrub | set | setcrushmap | setmaxosd  | stat | tree | unpause | unset ] ...
<synopsis>


</synopsis>
    ceph osd crush [ add | add-bucket | create-or-move | dump | get-tunable | link | move | remove | rename-bucket | reweight | reweight-all | reweight-subtree | rm | rule | set | set-tunable | show-tunables | tunables | unlink ] ...
<synopsis>


</synopsis>
    ceph osd pool [ create | delete | get | get-quota | ls | mksnap | rename | rmsnap | set | set-quota | stats ] ...
<synopsis>


</synopsis>
    ceph osd pool application [ disable | enable | get | rm | set ] ...
<synopsis>


</synopsis>
    ceph osd tier [ add | add-cache | cache-mode | remove | remove-overlay | set-overlay ] ...
<synopsis>


</synopsis>
    ceph pg [ debug | deep-scrub | dump | dump_json | dump_pools_json | dump_stuck | getmap | ls | ls-by-osd | ls-by-pool | ls-by-primary | map | repair | scrub | stat ] ...
<synopsis>


</synopsis>
    ceph quorum [ enter | exit ]
<synopsis>


</synopsis>
    ceph quorum_status
<synopsis>


</synopsis>
    ceph report { <tags> [ <tags>... ] }
<synopsis>


</synopsis>
    ceph scrub
<synopsis>


</synopsis>
    ceph status
<synopsis>


</synopsis>
    ceph sync force {--yes-i-really-mean-it} {--i-know-what-i-am-doing}
<synopsis>


</synopsis>
    ceph tell <name (type.id)> <command> [options...]
<synopsis>


</synopsis>
    ceph version
<synopsis>


```

<a name="description"></a>

# Description


**ceph** is a control utility which is used for manual deployment and maintenance
of a Ceph cluster. It provides a diverse set of commands that allows deployment of
monitors, OSDs, placement groups, MDS and overall maintenance, administration
of the cluster.

<a name="commands"></a>

# Commands


<a name="auth"></a>

### auth


Manage authentication keys. It is used for adding, removing, exporting
or updating of authentication keys for a particular  entity such as a monitor or
OSD. It uses some additional subcommands.

Subcommand **add** adds authentication info for a particular entity from input
file, or random key if no input is given and/or any caps specified in the command.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth add <entity> {<caps> [<caps>...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **caps** updates caps for **name** from caps specified in the command.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth caps <entity> <caps> [<caps>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **del** deletes all caps for **name**.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth del <entity>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **export** writes keyring for requested entity, or master keyring if
none given.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth export {<entity>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **get** writes keyring file with requested key.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth get <entity>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **get-key** displays requested key.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth get-key <entity>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **get-or-create** adds authentication info for a particular entity
from input file, or random key if no input given and/or any caps specified in the
command.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth get-or-create <entity> {<caps> [<caps>...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **get-or-create-key** gets or adds key for **name** from system/caps
pairs specified in the command.  If key already exists, any given caps must match
the existing caps for that key.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth get-or-create-key <entity> {<caps> [<caps>...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **import** reads keyring from input file.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth import
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls** lists authentication state.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth ls
    .ft P
.UNINDENT
.UNINDENT

Subcommand **print-key** displays requested key.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth print-key <entity>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **print\_key** displays requested key.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph auth print_key <entity>
    .ft P
.UNINDENT
.UNINDENT

<a name="compact"></a>

### compact


Causes compaction of monitor's leveldb storage.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph compact
    .ft P
.UNINDENT
.UNINDENT

<a name="config-key"></a>

### config\-key


Manage configuration key. It uses some additional subcommands.

Subcommand **rm** deletes configuration key.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph config-key rm <key>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **exists** checks for configuration keys existence.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph config-key exists <key>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **get** gets the configuration key.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph config-key get <key>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls** lists configuration keys.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph config-key ls
    .ft P
.UNINDENT
.UNINDENT

Subcommand **dump** dumps configuration keys and values.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph config-key dump
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set** puts configuration key and value.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph config-key set <key> {<val>}
    .ft P
.UNINDENT
.UNINDENT

<a name="daemon"></a>

### daemon


Submit admin-socket commands.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph daemon {daemon_name|socket_path} {command} ...
    .ft P
.UNINDENT
.UNINDENT

Example:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph daemon osd.0 help
    .ft P
.UNINDENT
.UNINDENT

<a name="daemonperf"></a>

### daemonperf


Watch performance counters from a Ceph daemon.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph daemonperf {daemon_name|socket_path} [{interval} [{count}]]
    .ft P
.UNINDENT
.UNINDENT

<a name="df"></a>

### df


Show cluster's free space status.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph df {detail}
    .ft P
.UNINDENT
.UNINDENT

<a name="features"></a>

### features


Show the releases and features of all connected daemons and clients connected
to the cluster, along with the numbers of them in each bucket grouped by the
corresponding features/releases. Each release of Ceph supports a different set
of features, expressed by the features bitmask. New cluster features require
that clients support the feature, or else they are not allowed to connect to
these new features. As new features or capabilities are enabled after an
upgrade, older clients are prevented from connecting.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph features
    .ft P
.UNINDENT
.UNINDENT

<a name="fs"></a>

### fs


Manage cephfs filesystems. It uses some additional subcommands.

Subcommand **ls** to list filesystems

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph fs ls
    .ft P
.UNINDENT
.UNINDENT

Subcommand **new** to make a new filesystem using named pools &lt;metadata&gt; and &lt;data&gt;

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph fs new <fs_name> <metadata> <data>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **reset** is used for disaster recovery only: reset to a single-MDS map

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph fs reset <fs_name> {--yes-i-really-mean-it}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rm** to disable the named filesystem

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph fs rm <fs_name> {--yes-i-really-mean-it}
    .ft P
.UNINDENT
.UNINDENT

<a name="fsid"></a>

### fsid


Show cluster's FSID/UUID.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph fsid
    .ft P
.UNINDENT
.UNINDENT

<a name="health"></a>

### health


Show cluster's health.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph health {detail}
    .ft P
.UNINDENT
.UNINDENT

<a name="heap"></a>

### heap


Show heap usage info (available only if compiled with tcmalloc)

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph heap dump|start_profiler|stop_profiler|stats
    .ft P
.UNINDENT
.UNINDENT

Subcommand **release** to make TCMalloc to releases no-longer-used memory back to the kernel at once.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph heap release
    .ft P
.UNINDENT
.UNINDENT

Subcommand **(get|set)\_release\_rate** get or set the TCMalloc memory release rate. TCMalloc releases
no-longer-used memory back to the kernel gradually. the rate controls how quickly this happens.
Increase this setting to make TCMalloc to return unused memory more frequently. 0 means never return
memory to system, 1 means wait for 1000 pages after releasing a page to system. It is **1.0** by default..

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph heap get_release_rate|set_release_rate {<val>}
    .ft P
.UNINDENT
.UNINDENT

<a name="injectargs"></a>

### injectargs


Inject configuration arguments into monitor.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph injectargs <injected_args> [<injected_args>...]
    .ft P
.UNINDENT
.UNINDENT

<a name="log"></a>

### log


Log supplied text to the monitor log.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph log <logtext> [<logtext>...]
    .ft P
.UNINDENT
.UNINDENT

<a name="mds"></a>

### mds


Manage metadata server configuration and administration. It uses some
additional subcommands.

Subcommand **compat** manages compatible features. It uses some additional
subcommands.

Subcommand **rm\_compat** removes compatible feature.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mds compat rm_compat <int[0-]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rm\_incompat** removes incompatible feature.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mds compat rm_incompat <int[0-]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **show** shows mds compatibility settings.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mds compat show
    .ft P
.UNINDENT
.UNINDENT

Subcommand **fail** forces mds to status fail.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mds fail <role|gid>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rm** removes inactive mds.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mds rm <int[0-]> <name> (type.id)>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rmfailed** removes failed mds.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mds rmfailed <int[0-]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set\_state** sets mds state of &lt;gid&gt; to &lt;numeric-state&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mds set_state <int[0-]> <int[0-20]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **stat** shows MDS status.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mds stat
    .ft P
.UNINDENT
.UNINDENT

Subcommand **repaired** mark a damaged MDS rank as no longer damaged.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mds repaired <role>
    .ft P
.UNINDENT
.UNINDENT

<a name="mon"></a>

### mon


Manage monitor configuration and administration. It uses some additional
subcommands.

Subcommand **add** adds new monitor named &lt;name&gt; at &lt;addr&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mon add <name> <IPaddr[:port]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **dump** dumps formatted monmap (optionally from epoch)

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mon dump {<int[0-]>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **getmap** gets monmap.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mon getmap {<int[0-]>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **remove** removes monitor named &lt;name&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mon remove <name>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **stat** summarizes monitor status.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mon stat
    .ft P
.UNINDENT
.UNINDENT

<a name="mon_status"></a>

### mon_status


Reports status of monitors.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mon_status
    .ft P
.UNINDENT
.UNINDENT

<a name="mgr"></a>

### mgr


Ceph manager daemon configuration and management.

Subcommand **dump** dumps the latest MgrMap, which describes the active
and standby manager daemons.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mgr dump
    .ft P
.UNINDENT
.UNINDENT

Subcommand **fail** will mark a manager daemon as failed, removing it
from the manager map.  If it is the active manager daemon a standby
will take its place.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mgr fail <name>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **module ls** will list currently enabled manager modules (plugins).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mgr module ls
    .ft P
.UNINDENT
.UNINDENT

Subcommand **module enable** will enable a manager module.  Available modules are included in MgrMap and visible via **mgr dump**.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mgr module enable <module>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **module disable** will disable an active manager module.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mgr module disable <module>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **metadata** will report metadata about all manager daemons or, if the name is specified, a single manager daemon.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mgr metadata [name]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **versions** will report a count of running daemon versions.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mgr versions
    .ft P
.UNINDENT
.UNINDENT

Subcommand **count-metadata** will report a count of any daemon metadata field.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph mgr count-metadata <field>
    .ft P
.UNINDENT
.UNINDENT

<a name="osd"></a>

### osd


Manage OSD configuration and administration. It uses some additional
subcommands.

Subcommand **blacklist** manage blacklisted clients. It uses some additional
subcommands.

Subcommand **add** add &lt;addr&gt; to blacklist (optionally until &lt;expire&gt; seconds
from now)

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd blacklist add <EntityAddr> {<float[0.0-]>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls** show blacklisted clients

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd blacklist ls
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rm** remove &lt;addr&gt; from blacklist

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd blacklist rm <EntityAddr>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **blocked-by** prints a histogram of which OSDs are blocking their peers

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd blocked-by
    .ft P
.UNINDENT
.UNINDENT

Subcommand **create** creates new osd (with optional UUID and ID).

This command is DEPRECATED as of the Luminous release, and will be removed in
a future release.

Subcommand **new** should instead be used.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd create {<uuid>} {<id>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **new** can be used to create a new OSD or to recreate a previously
destroyed OSD with a specific _id_. The new OSD will have the specified _uuid_,
and the command expects a JSON file containing the base64 cephx key for auth
entity _client.osd.&lt;id&gt;_, as well as optional base64 cepx key for dm-crypt
lockbox access and a dm-crypt key. Specifying a dm-crypt requires specifying
the accompanying lockbox cephx key.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd new {<uuid>} {<id>} -i {<params.json>}
    .ft P
.UNINDENT
.UNINDENT

The parameters JSON file is optional but if provided, is expected to maintain
a form of the following format:
.INDENT 0.0
.INDENT 3.5

    .ft C
    {
        "cephx_secret": "AQBWtwhZdBO5ExAAIDyjK2Bh16ZXylmzgYYEjg==",
        "crush_device_class": "myclass"
    }
    .ft P
.UNINDENT
.UNINDENT

Or:
.INDENT 0.0
.INDENT 3.5

    .ft C
    {
        "cephx_secret": "AQBWtwhZdBO5ExAAIDyjK2Bh16ZXylmzgYYEjg==",
        "cephx_lockbox_secret": "AQDNCglZuaeVCRAAYr76PzR1Anh7A0jswkODIQ==",
        "dmcrypt_key": "<dm-crypt key>",
        "crush_device_class": "myclass"
    }
    .ft P
.UNINDENT
.UNINDENT

Or:
.INDENT 0.0
.INDENT 3.5

    .ft C
    {
        "crush_device_class": "myclass"
    }
    .ft P
.UNINDENT
.UNINDENT

The "crush_device_class" property is optional. If specified, it will set the
initial CRUSH device class for the new OSD.

Subcommand **crush** is used for CRUSH management. It uses some additional
subcommands.

Subcommand **add** adds or updates crushmap position and weight for &lt;name&gt; with
&lt;weight&gt; and location &lt;args&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush add <osdname (id|osd.id)> <float[0.0-]> <args> [<args>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **add-bucket** adds no-parent (probably root) crush bucket &lt;name&gt; of
type &lt;type&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush add-bucket <name> <type>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **create-or-move** creates entry or moves existing entry for &lt;name&gt;
&lt;weight&gt; at/to location &lt;args&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush create-or-move <osdname (id|osd.id)> <float[0.0-]> <args>
    [<args>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **dump** dumps crush map.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush dump
    .ft P
.UNINDENT
.UNINDENT

Subcommand **get-tunable** get crush tunable straw_calc_version

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush get-tunable straw_calc_version
    .ft P
.UNINDENT
.UNINDENT

Subcommand **link** links existing entry for &lt;name&gt; under location &lt;args&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush link <name> <args> [<args>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **move** moves existing entry for &lt;name&gt; to location &lt;args&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush move <name> <args> [<args>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **remove** removes &lt;name&gt; from crush map (everywhere, or just at
&lt;ancestor&gt;).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush remove <name> {<ancestor>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rename-bucket** renames bucket &lt;srcname&gt; to &lt;dstname&gt;

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush rename-bucket <srcname> <dstname>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **reweight** change &lt;name&gt;'s weight to &lt;weight&gt; in crush map.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush reweight <name> <float[0.0-]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **reweight-all** recalculate the weights for the tree to
ensure they sum correctly

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush reweight-all
    .ft P
.UNINDENT
.UNINDENT

Subcommand **reweight-subtree** changes all leaf items beneath &lt;name&gt;
to &lt;weight&gt; in crush map

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush reweight-subtree <name> <weight>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rm** removes &lt;name&gt; from crush map (everywhere, or just at
&lt;ancestor&gt;).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush rm <name> {<ancestor>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rule** is used for creating crush rules. It uses some additional
subcommands.

Subcommand **create-erasure** creates crush rule &lt;name&gt; for erasure coded pool
created with &lt;profile&gt; (default default).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush rule create-erasure <name> {<profile>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **create-simple** creates crush rule &lt;name&gt; to start from &lt;root&gt;,
replicate across buckets of type &lt;type&gt;, using a choose mode of &lt;firstn|indep&gt;
(default firstn; indep best for erasure pools).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush rule create-simple <name> <root> <type> {firstn|indep}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **dump** dumps crush rule &lt;name&gt; (default all).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush rule dump {<name>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls** lists crush rules.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush rule ls
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rm** removes crush rule &lt;name&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush rule rm <name>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set** used alone, sets crush map from input file.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush set
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set** with osdname/osd.id update crushmap position and weight
for &lt;name&gt; to &lt;weight&gt; with location &lt;args&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush set <osdname (id|osd.id)> <float[0.0-]> <args> [<args>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set-tunable** set crush tunable &lt;tunable&gt; to &lt;value&gt;.  The only
tunable that can be set is straw_calc_version.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush set-tunable straw_calc_version <value>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **show-tunables** shows current crush tunables.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush show-tunables
    .ft P
.UNINDENT
.UNINDENT

Subcommand **tree** shows the crush buckets and items in a tree view.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush tree
    .ft P
.UNINDENT
.UNINDENT

Subcommand **tunables** sets crush tunables values to &lt;profile&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush tunables legacy|argonaut|bobtail|firefly|hammer|optimal|default
    .ft P
.UNINDENT
.UNINDENT

Subcommand **unlink** unlinks &lt;name&gt; from crush map (everywhere, or just at
&lt;ancestor&gt;).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd crush unlink <name> {<ancestor>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **df** shows OSD utilization

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd df {plain|tree}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **deep-scrub** initiates deep scrub on specified osd.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd deep-scrub <who>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **down** sets osd(s) &lt;id&gt; [&lt;id&gt;...] down.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd down <ids> [<ids>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **dump** prints summary of OSD map.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd dump {<int[0-]>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **erasure-code-profile** is used for managing the erasure code
profiles. It uses some additional subcommands.

Subcommand **get** gets erasure code profile &lt;name&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd erasure-code-profile get <name>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls** lists all erasure code profiles.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd erasure-code-profile ls
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rm** removes erasure code profile &lt;name&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd erasure-code-profile rm <name>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set** creates erasure code profile &lt;name&gt; with [&lt;key[=value]&gt; ...]
pairs. Add a --force at the end to override an existing profile (IT IS RISKY).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd erasure-code-profile set <name> {<profile> [<profile>...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **find** find osd &lt;id&gt; in the CRUSH map and shows its location.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd find <int[0-]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **getcrushmap** gets CRUSH map.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd getcrushmap {<int[0-]>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **getmap** gets OSD map.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd getmap {<int[0-]>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **getmaxosd** shows largest OSD id.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd getmaxosd
    .ft P
.UNINDENT
.UNINDENT

Subcommand **in** sets osd(s) &lt;id&gt; [&lt;id&gt;...] in.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd in <ids> [<ids>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **lost** marks osd as permanently lost. THIS DESTROYS DATA IF NO
MORE REPLICAS EXIST, BE CAREFUL.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd lost <int[0-]> {--yes-i-really-mean-it}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls** shows all OSD ids.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd ls {<int[0-]>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **lspools** lists pools.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd lspools {<int>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **map** finds pg for &lt;object&gt; in &lt;pool&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd map <poolname> <objectname>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **metadata** fetches metadata for osd &lt;id&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd metadata {int[0-]} (default all)
    .ft P
.UNINDENT
.UNINDENT

Subcommand **out** sets osd(s) &lt;id&gt; [&lt;id&gt;...] out.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd out <ids> [<ids>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ok-to-stop** checks whether the list of OSD(s) can be
stopped without immediately making data unavailable.  That is, all
data should remain readable and writeable, although data redundancy
may be reduced as some PGs may end up in a degraded (but active)
state.  It will return a success code if it is okay to stop the
OSD(s), or an error code and informative message if it is not or if no
conclusion can be drawn at the current time.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd ok-to-stop <id> [<ids>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **pause** pauses osd.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pause
    .ft P
.UNINDENT
.UNINDENT

Subcommand **perf** prints dump of OSD perf summary stats.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd perf
    .ft P
.UNINDENT
.UNINDENT

Subcommand **pg-temp** set pg_temp mapping pgid:[&lt;id&gt; [&lt;id&gt;...]] (developers
only).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pg-temp <pgid> {<id> [<id>...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **force-create-pg** forces creation of pg &lt;pgid&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd force-create-pg <pgid>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **pool** is used for managing data pools. It uses some additional
subcommands.

Subcommand **create** creates pool.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool create <poolname> <int[0-]> {<int[0-]>} {replicated|erasure}
    {<erasure_code_profile>} {<rule>} {<int>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **delete** deletes pool.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool delete <poolname> {<poolname>} {--yes-i-really-really-mean-it}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **get** gets pool parameter &lt;var&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool get <poolname> size|min_size|pg_num|pgp_num|crush_rule|write_fadvise_dontneed
    .ft P
.UNINDENT
.UNINDENT

Only for tiered pools:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool get <poolname> hit_set_type|hit_set_period|hit_set_count|hit_set_fpp|
    target_max_objects|target_max_bytes|cache_target_dirty_ratio|cache_target_dirty_high_ratio|
    cache_target_full_ratio|cache_min_flush_age|cache_min_evict_age|
    min_read_recency_for_promote|hit_set_grade_decay_rate|hit_set_search_last_n
    .ft P
.UNINDENT
.UNINDENT

Only for erasure coded pools:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool get <poolname> erasure_code_profile
    .ft P
.UNINDENT
.UNINDENT

Use **all** to get all pool parameters that apply to the pool's type:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool get <poolname> all
    .ft P
.UNINDENT
.UNINDENT

Subcommand **get-quota** obtains object or byte limits for pool.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool get-quota <poolname>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls** list pools

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool ls {detail}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **mksnap** makes snapshot &lt;snap&gt; in &lt;pool&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool mksnap <poolname> <snap>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rename** renames &lt;srcpool&gt; to &lt;destpool&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool rename <poolname> <poolname>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rmsnap** removes snapshot &lt;snap&gt; from &lt;pool&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool rmsnap <poolname> <snap>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set** sets pool parameter &lt;var&gt; to &lt;val&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool set <poolname> size|min_size|pg_num|
    pgp_num|crush_rule|hashpspool|nodelete|nopgchange|nosizechange|
    hit_set_type|hit_set_period|hit_set_count|hit_set_fpp|debug_fake_ec_pool|
    target_max_bytes|target_max_objects|cache_target_dirty_ratio|
    cache_target_dirty_high_ratio|
    cache_target_full_ratio|cache_min_flush_age|cache_min_evict_age|
    min_read_recency_for_promote|write_fadvise_dontneed|hit_set_grade_decay_rate|
    hit_set_search_last_n
    <val> {--yes-i-really-mean-it}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set-quota** sets object or byte limit on pool.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool set-quota <poolname> max_objects|max_bytes <val>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **stats** obtain stats from all pools, or from specified pool.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool stats {<name>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **application** is used for adding an annotation to the given
pool. By default, the possible applications are object, block, and file
storage (corresponding app-names are "rgw", "rbd", and "cephfs"). However,
there might be other applications as well. Based on the application, there
may or may not be some processing conducted.

Subcommand **disable** disables the given application on the given pool.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool application disable <pool-name> <app> {--yes-i-really-mean-it}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **enable** adds an annotation to the given pool for the mentioned
application.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool application enable <pool-name> <app> {--yes-i-really-mean-it}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **get** displays the value for the given key that is assosciated
with the given application of the given pool. Not passing the optional
arguments would display all key-value pairs for all applications for all
pools.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool application get {<pool-name>} {<app>} {<key>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rm** removes the key-value pair for the given key in the given
application of the given pool.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool application rm <pool-name> <app> <key>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set** assosciates or updates, if it already exists, a key-value
pair with the given application for the given pool.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd pool application set <pool-name> <app> <key> <value>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **primary-affinity** adjust osd primary-affinity from 0.0 &lt;=&lt;weight&gt;
&lt;= 1.0

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd primary-affinity <osdname (id|osd.id)> <float[0.0-1.0]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **primary-temp** sets primary_temp mapping pgid:&lt;id&gt;|-1 (developers
only).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd primary-temp <pgid> <id>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **repair** initiates repair on a specified osd.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd repair <who>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **reweight** reweights osd to 0.0 &lt; &lt;weight&gt; &lt; 1.0.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    osd reweight <int[0-]> <float[0.0-1.0]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **reweight-by-pg** reweight OSDs by PG distribution
[overload-percentage-for-consideration, default 120].

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd reweight-by-pg {<int[100-]>} {<poolname> [<poolname...]}
    {--no-increasing}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **reweight-by-utilization** reweight OSDs by utilization
[overload-percentage-for-consideration, default 120].

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd reweight-by-utilization {<int[100-]>}
    {--no-increasing}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **rm** removes osd(s) &lt;id&gt; [&lt;id&gt;...] from the OSD map.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd rm <ids> [<ids>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **destroy** marks OSD _id_ as _destroyed_, removing its cephx
entity's keys and all of its dm-crypt and daemon-private config key
entries.

This command will not remove the OSD from crush, nor will it remove the
OSD from the OSD map. Instead, once the command successfully completes,
the OSD will show marked as _destroyed_.

In order to mark an OSD as destroyed, the OSD must first be marked as
**lost**.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd destroy <id> {--yes-i-really-mean-it}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **purge** performs a combination of **osd destroy**,
**osd rm** and **osd crush remove**.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd purge <id> {--yes-i-really-mean-it}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **safe-to-destroy** checks whether it is safe to remove or
destroy an OSD without reducing overall data redundancy or durability.
It will return a success code if it is definitely safe, or an error
code and informative message if it is not or if no conclusion can be
drawn at the current time.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd safe-to-destroy <id> [<ids>...]
    .ft P
.UNINDENT
.UNINDENT

Subcommand **scrub** initiates scrub on specified osd.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd scrub <who>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set** sets &lt;key&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd set full|pause|noup|nodown|noout|noin|nobackfill|
    norebalance|norecover|noscrub|nodeep-scrub|notieragent
    .ft P
.UNINDENT
.UNINDENT

Subcommand **setcrushmap** sets crush map from input file.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd setcrushmap
    .ft P
.UNINDENT
.UNINDENT

Subcommand **setmaxosd** sets new maximum osd value.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd setmaxosd <int[0-]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set-require-min-compat-client** enforces the cluster to be backward
compatible with the specified client version. This subcommand prevents you from
making any changes (e.g., crush tunables, or using new features) that
would violate the current setting. Please note, This subcommand will fail if
any connected daemon or client is not compatible with the features offered by
the given &lt;version&gt;. To see the features and releases of all clients connected
to cluster, please see _ceph features_.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd set-require-min-compat-client <version>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **stat** prints summary of OSD map.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd stat
    .ft P
.UNINDENT
.UNINDENT

Subcommand **tier** is used for managing tiers. It uses some additional
subcommands.

Subcommand **add** adds the tier &lt;tierpool&gt; (the second one) to base pool &lt;pool&gt;
(the first one).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd tier add <poolname> <poolname> {--force-nonempty}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **add-cache** adds a cache &lt;tierpool&gt; (the second one) of size &lt;size&gt;
to existing pool &lt;pool&gt; (the first one).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd tier add-cache <poolname> <poolname> <int[0-]>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **cache-mode** specifies the caching mode for cache tier &lt;pool&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd tier cache-mode <poolname> none|writeback|forward|readonly|
    readforward|readproxy
    .ft P
.UNINDENT
.UNINDENT

Subcommand **remove** removes the tier &lt;tierpool&gt; (the second one) from base pool
&lt;pool&gt; (the first one).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd tier remove <poolname> <poolname>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **remove-overlay** removes the overlay pool for base pool &lt;pool&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd tier remove-overlay <poolname>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **set-overlay** set the overlay pool for base pool &lt;pool&gt; to be
&lt;overlaypool&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd tier set-overlay <poolname> <poolname>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **tree** prints OSD tree.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd tree {<int[0-]>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **unpause** unpauses osd.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd unpause
    .ft P
.UNINDENT
.UNINDENT

Subcommand **unset** unsets &lt;key&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph osd unset full|pause|noup|nodown|noout|noin|nobackfill|
    norebalance|norecover|noscrub|nodeep-scrub|notieragent
    .ft P
.UNINDENT
.UNINDENT

<a name="pg"></a>

### pg


It is used for managing the placement groups in OSDs. It uses some
additional subcommands.

Subcommand **debug** shows debug info about pgs.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg debug unfound_objects_exist|degraded_pgs_exist
    .ft P
.UNINDENT
.UNINDENT

Subcommand **deep-scrub** starts deep-scrub on &lt;pgid&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg deep-scrub <pgid>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **dump** shows human-readable versions of pg map (only 'all' valid
with plain).

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg dump {all|summary|sum|delta|pools|osds|pgs|pgs_brief} [{all|summary|sum|delta|pools|osds|pgs|pgs_brief...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **dump\_json** shows human-readable version of pg map in json only.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg dump_json {all|summary|sum|delta|pools|osds|pgs|pgs_brief} [{all|summary|sum|delta|pools|osds|pgs|pgs_brief...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **dump\_pools\_json** shows pg pools info in json only.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg dump_pools_json
    .ft P
.UNINDENT
.UNINDENT

Subcommand **dump\_stuck** shows information about stuck pgs.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg dump_stuck {inactive|unclean|stale|undersized|degraded [inactive|unclean|stale|undersized|degraded...]}
    {<int>}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **getmap** gets binary pg map to -o/stdout.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg getmap
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls** lists pg with specific pool, osd, state

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg ls {<int>} {<pg-state> [<pg-state>...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls-by-osd** lists pg on osd [osd]

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg ls-by-osd <osdname (id|osd.id)> {<int>}
    {<pg-state> [<pg-state>...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls-by-pool** lists pg with pool = [poolname]

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg ls-by-pool <poolstr> {<int>} {<pg-state> [<pg-state>...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **ls-by-primary** lists pg with primary = [osd]

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg ls-by-primary <osdname (id|osd.id)> {<int>}
    {<pg-state> [<pg-state>...]}
    .ft P
.UNINDENT
.UNINDENT

Subcommand **map** shows mapping of pg to osds.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg map <pgid>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **repair** starts repair on &lt;pgid&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg repair <pgid>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **scrub** starts scrub on &lt;pgid&gt;.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg scrub <pgid>
    .ft P
.UNINDENT
.UNINDENT

Subcommand **stat** shows placement group status.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph pg stat
    .ft P
.UNINDENT
.UNINDENT

<a name="quorum"></a>

### quorum


Cause MON to enter or exit quorum.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph quorum enter|exit
    .ft P
.UNINDENT
.UNINDENT

Note: this only works on the MON to which the **ceph** command is connected.
If you want a specific MON to enter or exit quorum, use this syntax:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph tell mon.<id> quorum enter|exit
    .ft P
.UNINDENT
.UNINDENT

<a name="quorum_status"></a>

### quorum_status


Reports status of monitor quorum.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph quorum_status
    .ft P
.UNINDENT
.UNINDENT

<a name="report"></a>

### report


Reports full status of cluster, optional title tag strings.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph report {<tags> [<tags>...]}
    .ft P
.UNINDENT
.UNINDENT

<a name="scrub"></a>

### scrub


Scrubs the monitor stores.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph scrub
    .ft P
.UNINDENT
.UNINDENT

<a name="status"></a>

### status


Shows cluster status.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph status
    .ft P
.UNINDENT
.UNINDENT

<a name="sync-force"></a>

### sync force


Forces sync of and clear monitor store.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph sync force {--yes-i-really-mean-it} {--i-know-what-i-am-doing}
    .ft P
.UNINDENT
.UNINDENT

<a name="tell"></a>

### tell


Sends a command to a specific daemon.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph tell <name (type.id)> <command> [options...]
    .ft P
.UNINDENT
.UNINDENT

List all available commands.

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph tell <name (type.id)> help
    .ft P
.UNINDENT
.UNINDENT

<a name="version"></a>

### version


Show mon daemon version

Usage:
.INDENT 0.0
.INDENT 3.5

    .ft C
    ceph version
    .ft P
.UNINDENT
.UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0

* **-i infile**  
  will specify an input file to be passed along as a payload with the
  command to the monitor cluster. This is only used for specific
  monitor commands.
  .UNINDENT
  .INDENT 0.0
* **-o outfile**  
  will write any payload returned by the monitor cluster with its
  reply to outfile.  Only specific monitor commands (e.g. osd getmap)
  return a payload.
  .UNINDENT
  .INDENT 0.0
* **--setuser user**  
  will apply the appropriate user ownership to the file specified by
  the option '-o'.
  .UNINDENT
  .INDENT 0.0
* **--setgroup group**  
  will apply the appropriate group ownership to the file specified by
  the option '-o'.
  .UNINDENT
  .INDENT 0.0
* **-c ceph.conf, --conf=ceph.conf**  
  Use ceph.conf configuration file instead of the default
  **/etc/ceph/ceph.conf** to determine monitor addresses during startup.
  .UNINDENT
  .INDENT 0.0
* **--id CLIENT_ID, --user CLIENT_ID**  
  Client id for authentication.
  .UNINDENT
  .INDENT 0.0
* **--name CLIENT_NAME, -n CLIENT_NAME**  
  Client name for authentication.
  .UNINDENT
  .INDENT 0.0
* **--cluster CLUSTER**  
  Name of the Ceph cluster.
  .UNINDENT
  .INDENT 0.0
* **--admin-daemon ADMIN_SOCKET, daemon DAEMON_NAME**  
  Submit admin-socket commands via admin sockets in /var/run/ceph.
  .UNINDENT
  .INDENT 0.0
* **--admin-socket ADMIN_SOCKET_NOPE**  
  You probably mean --admin-daemon
  .UNINDENT
  .INDENT 0.0
* **-s, --status**  
  Show cluster status.
  .UNINDENT
  .INDENT 0.0
* **-w, --watch**  
  Watch live cluster changes.
  .UNINDENT
  .INDENT 0.0
* **--watch-debug**  
  Watch debug events.
  .UNINDENT
  .INDENT 0.0
* **--watch-info**  
  Watch info events.
  .UNINDENT
  .INDENT 0.0
* **--watch-sec**  
  Watch security events.
  .UNINDENT
  .INDENT 0.0
* **--watch-warn**  
  Watch warning events.
  .UNINDENT
  .INDENT 0.0
* **--watch-error**  
  Watch error events.
  .UNINDENT
  .INDENT 0.0
* **--version, -v**  
  Display version.
  .UNINDENT
  .INDENT 0.0
* **--verbose**  
  Make verbose.
  .UNINDENT
  .INDENT 0.0
* **--concise**  
  Make less verbose.
  .UNINDENT
  .INDENT 0.0
* **-f {json,json-pretty,xml,xml-pretty,plain}, --format**  
  Format of output.
  .UNINDENT
  .INDENT 0.0
* **--connect-timeout CLUSTER_TIMEOUT**  
  Set a timeout for connecting to the cluster.
  .UNINDENT
  .INDENT 0.0
* **--no-increasing**  
  **--no-increasing** is off by default. So increasing the osd weight is allowed
  using the **reweight-by-utilization** or **test-reweight-by-utilization** commands.
  If this option is used with these commands, it will help not to increase osd weight
  even the osd is under utilized.
  .UNINDENT
  .INDENT 0.0
* **--block**  
  block until completion (scrub and deep-scrub only)
  .UNINDENT

<a name="availability"></a>

# Availability


**ceph** is part of Ceph, a massively scalable, open-source, distributed storage system. Please refer to
the Ceph documentation at _http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


ceph-mon(8),
ceph-osd(8),
ceph-mds(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

