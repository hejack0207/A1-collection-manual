# radosgw-admin(8) - rados REST gateway user administration utility

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

    radosgw-admin command [ options ... ]
```


```

<a name="description"></a>

# Description


**radosgw-admin** is a RADOS gateway user administration utility. It
allows creating and modifying users.

<a name="commands"></a>

# Commands


**radosgw-admin** utility uses many commands for administration purpose
which are as follows:
.INDENT 0.0

* **user create**  
  Create a new user.
* **user modify**  
  Modify a user.
* **user info**  
  Display information of a user, and any potentially available
  subusers and keys.
* **user rm**  
  Remove a user.
* **user suspend**  
  Suspend a user.
* **user enable**  
  Re-enable user after suspension.
* **user check**  
  Check user info.
* **user stats**  
  Show user stats as accounted by quota subsystem.
* **user list**  
  List all users.
* **caps add**  
  Add user capabilities.
* **caps rm**  
  Remove user capabilities.
* **subuser create**  
  Create a new subuser (primarily useful for clients using the Swift API).
* **subuser modify**  
  Modify a subuser.
* **subuser rm**  
  Remove a subuser.
* **key create**  
  Create access key.
* **key rm**  
  Remove access key.
* **bucket list**  
  List buckets, or, if bucket specified with --bucket=&lt;bucket&gt;,
  list its objects. If bucket specified adding --allow-unordered
  removes ordering requirement, possibly generating results more
  quickly in buckets with large number of objects.
* **bucket limit check**  
  Show bucket sharding stats.
* **bucket link**  
  Link bucket to specified user.
* **bucket unlink**  
  Unlink bucket from specified user.
* **bucket stats**  
  Returns bucket statistics.
* **bucket rm**  
  Remove a bucket.
* **bucket check**  
  Check bucket index.
* **bucket rewrite**  
  Rewrite all objects in the specified bucket.
* **bucket reshard**  
  Reshard a bucket.
* **bucket sync disable**  
  Disable bucket sync.
* **bucket sync enable**  
  Enable bucket sync.
* **bi get**  
  Retrieve bucket index object entries.
* **bi put**  
  Store bucket index object entries.
* **bi list**  
  List raw bucket index entries.
* **bi purge**  
  Purge bucket index entries.
* **object rm**  
  Remove an object.
* **object stat**  
  Stat an object for its metadata.
* **object unlink**  
  Unlink object from bucket index.
* **object rewrite**  
  Rewrite the specified object.
* **objects expire**  
  Run expired objects cleanup.
* **period rm**  
  Remove a period.
* **period get**  
  Get the period info.
* **period get-current**  
  Get the current period info.
* **period pull**  
  Pull a period.
* **period push**  
  Push a period.
* **period list**  
  List all periods.
* **period update**  
  Update the staging period.
* **period commit**  
  Commit the staging period.
* **quota set**  
  Set quota params.
* **quota enable**  
  Enable quota.
* **quota disable**  
  Disable quota.
* **global quota get**  
  View global quota parameters.
* **global quota set**  
  Set global quota parameters.
* **global quota enable**  
  Enable a global quota.
* **global quota disable**  
  Disable a global quota.
* **realm create**  
  Create a new realm.
* **realm rm**  
  Remove a realm.
* **realm get**  
  Show the realm info.
* **realm get-default**  
  Get the default realm name.
* **realm list**  
  List all realms.
* **realm list-periods**  
  List all realm periods.
* **realm rename**  
  Rename a realm.
* **realm set**  
  Set the realm info (requires infile).
* **realm default**  
  Set the realm as default.
* **realm pull**  
  Pull a realm and its current period.
* **zonegroup add**  
  Add a zone to a zonegroup.
* **zonegroup create**  
  Create a new zone group info.
* **zonegroup default**  
  Set the default zone group.
* **zonegroup rm**  
  Remove a zone group info.
* **zonegroup get**  
  Show the zone group info.
* **zonegroup modify**  
  Modify an existing zonegroup.
* **zonegroup set**  
  Set the zone group info (requires infile).
* **zonegroup remove**  
  Remove a zone from a zonegroup.
* **zonegroup rename**  
  Rename a zone group.
* **zonegroup list**  
  List all zone groups set on this cluster.
* **zonegroup placement list**  
  List zonegroup's placement targets.
* **zonegroup placement add**  
  Add a placement target id to a zonegroup.
* **zonegroup placement modify**  
  Modify a placement target of a specific zonegroup.
* **zonegroup placement rm**  
  Remove a placement target from a zonegroup.
* **zonegroup placement default**  
  Set a zonegroup's default placement target.
* **zone create**  
  Create a new zone.
* **zone rm**  
  Remove a zone.
* **zone get**  
  Show zone cluster params.
* **zone set**  
  Set zone cluster params (requires infile).
* **zone modify**  
  Modify an existing zone.
* **zone list**  
  List all zones set on this cluster.
* **metadata sync status**  
  Get metadata sync status.
* **metadata sync init**  
  Init metadata sync.
* **metadata sync run**  
  Run metadata sync.
* **data sync status**  
  Get data sync status of the specified source zone.
* **data sync init**  
  Init data sync for the specified source zone.
* **data sync run**  
  Run data sync for the specified source zone.
* **sync error list**  
  list sync error.
* **sync error trim**  
  trim sync error.
* **zone rename**  
  Rename a zone.
* **zone placement list**  
  List zone's placement targets.
* **zone placement add**  
  Add a zone placement target.
* **zone placement modify**  
  Modify a zone placement target.
* **zone placement rm**  
  Remove a zone placement target.
* **pool add**  
  Add an existing pool for data placement.
* **pool rm**  
  Remove an existing pool from data placement set.
* **pools list**  
  List placement active set.
* **policy**  
  Display bucket/object policy.
* **log list**  
  List log objects.
* **log show**  
  Dump a log from specific object or (bucket + date + bucket-id).
  (NOTE: required to specify formatting of date to "YYYY-MM-DD-hh")
* **log rm**  
  Remove log object.
* **usage show**  
  Show the usage information (with optional user and date range).
* **usage trim**  
  Trim usage information (with optional user and date range).
* **gc list**  
  Dump expired garbage collection objects (specify --include-all to list all
  entries, including unexpired).
* **gc process**  
  Manually process garbage.
* **lc list**  
  List all bucket lifecycle progress.
* **lc process**  
  Manually process lifecycle.
* **metadata get**  
  Get metadata info.
* **metadata put**  
  Put metadata info.
* **metadata rm**  
  Remove metadata info.
* **metadata list**  
  List metadata info.
* **mdlog list**  
  List metadata log.
* **mdlog trim**  
  Trim metadata log.
* **mdlog status**  
  Read metadata log status.
* **bilog list**  
  List bucket index log.
* **bilog trim**  
  Trim bucket index log (use start-marker, end-marker).
* **datalog list**  
  List data log.
* **datalog trim**  
  Trim data log.
* **datalog status**  
  Read data log status.
* **orphans find**  
  Init and run search for leaked rados objects
* **orphans finish**  
  Clean up search for leaked rados objects
* **orphans list-jobs**  
  List the current job-ids for the orphans search.
* **role create**  
  create a new AWS role for use with STS.
* **role rm**  
  Remove a role.
* **role get**  
  Get a role.
* **role list**  
  List the roles with specified path prefix.
* **role modify**  
  Modify the assume role policy of an existing role.
* **role-policy put**  
  Add/update permission policy to role.
* **role-policy list**  
  List the policies attached to a role.
* **role-policy get**  
  Get the specified inline policy document embedded with the given role.
* **role-policy rm**  
  Remove the policy attached to a role
* **reshard add**  
  Schedule a resharding of a bucket
* **reshard list**  
  List all bucket resharding or scheduled to be resharded
* **reshard process**  
  Process of scheduled reshard jobs
* **reshard status**  
  Resharding status of a bucket
* **reshard cancel**  
  Cancel resharding a bucket
  .UNINDENT

<a name="options"></a>

# Options

.INDENT 0.0

* **-c ceph.conf, --conf=ceph.conf**  
  Use **ceph.conf** configuration file instead of the default
  **/etc/ceph/ceph.conf** to determine monitor addresses during
  startup.
  .UNINDENT
  .INDENT 0.0
* **-m monaddress[:port]**  
  Connect to specified monitor (instead of looking through ceph.conf).
  .UNINDENT
  .INDENT 0.0
* **--tenant=&lt;tenant&gt;**  
  Name of the tenant.
  .UNINDENT
  .INDENT 0.0
* **--uid=uid**  
  The radosgw user ID.
  .UNINDENT
  .INDENT 0.0
* **--subuser=&lt;name&gt;**  
  Name of the subuser.
  .UNINDENT
  .INDENT 0.0
* **--access-key=&lt;key&gt;**  
  S3 access key.
  .UNINDENT
  .INDENT 0.0
* **--email=email**  
  The e-mail address of the user.
  .UNINDENT
  .INDENT 0.0
* **--secret/--secret-key=&lt;key&gt;**  
  The secret key.
  .UNINDENT
  .INDENT 0.0
* **--gen-access-key**  
  Generate random access key (for S3).
  .UNINDENT
  .INDENT 0.0
* **--gen-secret**  
  Generate random secret key.
  .UNINDENT
  .INDENT 0.0
* **--key-type=&lt;type&gt;**  
  key type, options are: swift, s3.
  .UNINDENT
  .INDENT 0.0
* **--temp-url-key[-2]=&lt;key&gt;**  
  Temporary url key.
  .UNINDENT
  .INDENT 0.0
* **--max-buckets**  
  max number of buckets for a user (0 for no limit, negative value to disable bucket creation).
  Default is 1000.
  .UNINDENT
  .INDENT 0.0
* **--access=&lt;access&gt;**  
  Set the access permissions for the sub-user.
  Available access permissions are read, write, readwrite and full.
  .UNINDENT
  .INDENT 0.0
* **--display-name=&lt;name&gt;**  
  The display name of the user.
  .UNINDENT
  .INDENT 0.0
* **--admin**  
  Set the admin flag on the user.
  .UNINDENT
  .INDENT 0.0
* **--system**  
  Set the system flag on the user.
  .UNINDENT
  .INDENT 0.0
* **--bucket=bucket**  
  Specify the bucket name.
  .UNINDENT
  .INDENT 0.0
* **--pool=&lt;pool&gt;**  
  Specify the pool name.
  Also used with _orphans find_ as data pool to scan for leaked rados objects.
  .UNINDENT
  .INDENT 0.0
* **--object=object**  
  Specify the object name.
  .UNINDENT
  .INDENT 0.0
* **--date=yyyy-mm-dd**  
  The date in the format yyyy-mm-dd.
  .UNINDENT
  .INDENT 0.0
* **--start-date=yyyy-mm-dd**  
  The start date in the format yyyy-mm-dd.
  .UNINDENT
  .INDENT 0.0
* **--end-date=yyyy-mm-dd**  
  The end date in the format yyyy-mm-dd.
  .UNINDENT
  .INDENT 0.0
* **--bucket-id=&lt;bucket-id&gt;**  
  Specify the bucket id.
  .UNINDENT
  .INDENT 0.0
* **--shard-id=&lt;shard-id&gt;**  
  Optional for mdlog list, data sync status. Required for **mdlog trim**.
  .UNINDENT
  .INDENT 0.0
* **--max-entries=&lt;entries&gt;**  
  Optional for listing operations to specify the max entires
  .UNINDENT
  .INDENT 0.0
* **--purge-data**  
  When specified, user removal will also purge all the user data.
  .UNINDENT
  .INDENT 0.0
* **--purge-keys**  
  When specified, subuser removal will also purge all the subuser keys.
  .UNINDENT
  .INDENT 0.0
* **--purge-objects**  
  When specified, the bucket removal will also purge all objects in it.
  .UNINDENT
  .INDENT 0.0
* **--metadata-key=&lt;key&gt;**  
  Key to retrieve metadata from with **metadata get**.
  .UNINDENT
  .INDENT 0.0
* **--remote=&lt;remote&gt;**  
  Zone or zonegroup id of remote gateway.
  .UNINDENT
  .INDENT 0.0
* **--period=&lt;id&gt;**  
  Period id.
  .UNINDENT
  .INDENT 0.0
* **--url=&lt;url&gt;**  
  url for pushing/pulling period or realm.
  .UNINDENT
  .INDENT 0.0
* **--epoch=&lt;number&gt;**  
  Period epoch.
  .UNINDENT
  .INDENT 0.0
* **--commit**  
  Commit the period during 'period update'.
  .UNINDENT
  .INDENT 0.0
* **--staging**  
  Get the staging period info.
  .UNINDENT
  .INDENT 0.0
* **--master**  
  Set as master.
  .UNINDENT
  .INDENT 0.0
* **--master-zone=&lt;id&gt;**  
  Master zone id.
  .UNINDENT
  .INDENT 0.0
* **--rgw-realm=&lt;name&gt;**  
  The realm name.
  .UNINDENT
  .INDENT 0.0
* **--realm-id=&lt;id&gt;**  
  The realm id.
  .UNINDENT
  .INDENT 0.0
* **--realm-new-name=&lt;name&gt;**  
  New name of realm.
  .UNINDENT
  .INDENT 0.0
* **--rgw-zonegroup=&lt;name&gt;**  
  The zonegroup name.
  .UNINDENT
  .INDENT 0.0
* **--zonegroup-id=&lt;id&gt;**  
  The zonegroup id.
  .UNINDENT
  .INDENT 0.0
* **--zonegroup-new-name=&lt;name&gt;**  
  The new name of the zonegroup.
  .UNINDENT
  .INDENT 0.0
* **--rgw-zone=&lt;zone&gt;**  
  Zone in which radosgw is running.
  .UNINDENT
  .INDENT 0.0
* **--zone-id=&lt;id&gt;**  
  The zone id.
  .UNINDENT
  .INDENT 0.0
* **--zone-new-name=&lt;name&gt;**  
  The new name of the zone.
  .UNINDENT
  .INDENT 0.0
* **--source-zone**  
  The source zone for data sync.
  .UNINDENT
  .INDENT 0.0
* **--default**  
  Set the entity (realm, zonegroup, zone) as default.
  .UNINDENT
  .INDENT 0.0
* **--read-only**  
  Set the zone as read-only when adding to the zonegroup.
  .UNINDENT
  .INDENT 0.0
* **--placement-id**  
  Placement id for the zonegroup placement commands.
  .UNINDENT
  .INDENT 0.0
* **--tags=&lt;list&gt;**  
  The list of tags for zonegroup placement add and modify commands.
  .UNINDENT
  .INDENT 0.0
* **--tags-add=&lt;list&gt;**  
  The list of tags to add for zonegroup placement modify command.
  .UNINDENT
  .INDENT 0.0
* **--tags-rm=&lt;list&gt;**  
  The list of tags to remove for zonegroup placement modify command.
  .UNINDENT
  .INDENT 0.0
* **--endpoints=&lt;list&gt;**  
  The zone endpoints.
  .UNINDENT
  .INDENT 0.0
* **--index-pool=&lt;pool&gt;**  
  The placement target index pool.
  .UNINDENT
  .INDENT 0.0
* **--data-pool=&lt;pool&gt;**  
  The placement target data pool.
  .UNINDENT
  .INDENT 0.0
* **--data-extra-pool=&lt;pool&gt;**  
  The placement target data extra (non-ec) pool.
  .UNINDENT
  .INDENT 0.0
* **--placement-index-type=&lt;type&gt;**  
  The placement target index type (normal, indexless, or #id).
  .UNINDENT
  .INDENT 0.0
* **--tier-type=&lt;type&gt;**  
  The zone tier type.
  .UNINDENT
  .INDENT 0.0
* **--tier-config=&lt;k&gt;=&lt;v&gt;[,...]**  
  Set zone tier config keys, values.
  .UNINDENT
  .INDENT 0.0
* **--tier-config-rm=&lt;k&gt;[,...]**  
  Unset zone tier config keys.
  .UNINDENT
  .INDENT 0.0
* **--sync-from-all[=false]**  
  Set/reset whether zone syncs from all zonegroup peers.
  .UNINDENT
  .INDENT 0.0
* **--sync-from=[zone-name][,...]**  
  Set the list of zones to sync from.
  .UNINDENT
  .INDENT 0.0
* **--sync-from-rm=[zone-name][,...]**  
  Remove the zones from list of zones to sync from.
  .UNINDENT
  .INDENT 0.0
* **--fix**  
  Besides checking bucket index, will also fix it.
  .UNINDENT
  .INDENT 0.0
* **--check-objects**  
  bucket check: Rebuilds bucket index according to actual objects state.
  .UNINDENT
  .INDENT 0.0
* **--format=&lt;format&gt;**  
  Specify output format for certain operations. Supported formats: xml, json.
  .UNINDENT
  .INDENT 0.0
* **--sync-stats**  
  Option for 'user stats' command. When specified, it will update user stats with
  the current stats reported by user's buckets indexes.
  .UNINDENT
  .INDENT 0.0
* **--show-log-entries=&lt;flag&gt;**  
  Enable/disable dump of log entries on log show.
  .UNINDENT
  .INDENT 0.0
* **--show-log-sum=&lt;flag&gt;**  
  Enable/disable dump of log summation on log show.
  .UNINDENT
  .INDENT 0.0
* **--skip-zero-entries**  
  Log show only dumps entries that don't have zero value in one of the numeric
  field.
  .UNINDENT
  .INDENT 0.0
* **--infile**  
  Specify a file to read in when setting data.
  .UNINDENT
  .INDENT 0.0
* **--categories=&lt;list&gt;**  
  Comma separated list of categories, used in usage show.
  .UNINDENT
  .INDENT 0.0
* **--caps=&lt;caps&gt;**  
  List of caps (e.g., "usage=read, write; user=read".
  .UNINDENT
  .INDENT 0.0
* **--compression=&lt;compression-algorithm&gt;**  
  Placement target compression algorithm (lz4|snappy|zlib|zstd)
  .UNINDENT
  .INDENT 0.0
* **--yes-i-really-mean-it**  
  Required for certain operations.
  .UNINDENT
  .INDENT 0.0
* **--min-rewrite-size**  
  Specify the min object size for bucket rewrite (default 4M).
  .UNINDENT
  .INDENT 0.0
* **--max-rewrite-size**  
  Specify the max object size for bucket rewrite (default ULLONG_MAX).
  .UNINDENT
  .INDENT 0.0
* **--min-rewrite-stripe-size**  
  Specify the min stripe size for object rewrite (default 0). If the value
  is set to 0, then the specified object will always be
  rewritten for restriping.
  .UNINDENT
  .INDENT 0.0
* **--warnings-only**  
  When specified with bucket limit check,
  list only buckets nearing or over the current max objects per shard value.
  .UNINDENT
  .INDENT 0.0
* **--bypass-gc**  
  When specified with bucket deletion,
  triggers object deletions by not involving GC.
  .UNINDENT
  .INDENT 0.0
* **--inconsistent-index**  
  When specified with bucket deletion and bypass-gc set to true,
  ignores bucket index consistency.
  .UNINDENT

<a name="quota-options"></a>

# Quota Options

.INDENT 0.0

* **--max-objects**  
  Specify max objects (negative value to disable).
  .UNINDENT
  .INDENT 0.0
* **--max-size**  
  Specify max size (in B/K/M/G/T, negative value to disable).
  .UNINDENT
  .INDENT 0.0
* **--quota-scope**  
  The scope of quota (bucket, user).
  .UNINDENT

<a name="orphans-search-options"></a>

# Orphans Search Options

.INDENT 0.0

* **--num-shards**  
  Number of shards to use for keeping the temporary scan info
  .UNINDENT
  .INDENT 0.0
* **--orphan-stale-secs**  
  Number of seconds to wait before declaring an object to be an orphan.
  Default is 86400 (24 hours).
  .UNINDENT
  .INDENT 0.0
* **--job-id**  
  Set the job id (for orphans find)
  .UNINDENT
  .INDENT 0.0
* **--max-concurrent-ios**  
  Maximum concurrent ios for orphans find.
  Default is 32.
  .UNINDENT

<a name="orphans-list-jobs-options"></a>

# Orphans List-Jobs Options

.INDENT 0.0

* **--extra-info**  
  Provide extra info in the job list.
  .UNINDENT

<a name="role-options"></a>

# Role Options

.INDENT 0.0

* **--role-name**  
  The name of the role to create.
  .UNINDENT
  .INDENT 0.0
* **--path**  
  The path to the role.
  .UNINDENT
  .INDENT 0.0
* **--assume-role-policy-doc**  
  The trust relationship policy document that grants an entity permission to
  assume the role.
  .UNINDENT
  .INDENT 0.0
* **--policy-name**  
  The name of the policy document.
  .UNINDENT
  .INDENT 0.0
* **--policy-doc**  
  The permission policy document.
  .UNINDENT
  .INDENT 0.0
* **--path-prefix**  
  The path prefix for filtering the roles.
  .UNINDENT

<a name="examples"></a>

# Examples


Generate a new user:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ radosgw-admin user create --display-name="johnny rotten" --uid=johnny
    { "user_id": "johnny",
      "rados_uid": 0,
      "display_name": "johnny rotten",
      "email": "",
      "suspended": 0,
      "subusers": [],
      "keys": [
            { "user": "johnny",
              "access_key": "TCICW53D9BQ2VGC46I44",
              "secret_key": "tfm9aHMI8X76L3UdgE+ZQaJag1vJQmE6HDb5Lbrz"}],
      "swift_keys": []}
    .ft P
.UNINDENT
.UNINDENT

Remove a user:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ radosgw-admin user rm --uid=johnny
    .ft P
.UNINDENT
.UNINDENT

Remove a user and all associated buckets with their contents:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ radosgw-admin user rm --uid=johnny --purge-data
    .ft P
.UNINDENT
.UNINDENT

Remove a bucket:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ radosgw-admin bucket rm --bucket=foo
    .ft P
.UNINDENT
.UNINDENT

Link bucket to specified user:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ radosgw-admin bucket link --bucket=foo --bucket_id=<bucket id> --uid=johnny
    .ft P
.UNINDENT
.UNINDENT

Unlink bucket from specified user:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ radosgw-admin bucket unlink --bucket=foo --uid=johnny
    .ft P
.UNINDENT
.UNINDENT

Show the logs of a bucket from April 1st, 2012:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ radosgw-admin log show --bucket=foo --date=2012-04-01-01 --bucket-id=default.14193.1
    .ft P
.UNINDENT
.UNINDENT

Show usage information for user from March 1st to (but not including) April 1st, 2012:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ radosgw-admin usage show --uid=johnny e
                    --start-date=2012-03-01 --end-date=2012-04-01
    .ft P
.UNINDENT
.UNINDENT

Show only summary of usage information for all users:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ radosgw-admin usage show --show-log-entries=false
    .ft P
.UNINDENT
.UNINDENT

Trim usage information for user until March 1st, 2012:
.INDENT 0.0
.INDENT 3.5

    .ft C
    $ radosgw-admin usage trim --uid=johnny --end-date=2012-04-01
    .ft P
.UNINDENT
.UNINDENT

<a name="availability"></a>

# Availability


**radosgw-admin** is part of Ceph, a massively scalable, open-source,
distributed storage system.  Please refer to the Ceph documentation at
_http://ceph.com/docs_ for more information.

<a name="see-also"></a>

# See Also


ceph(8)
radosgw(8)

<a name="copyright"></a>

# Copyright

2010-2014, Inktank Storage, Inc. and contributors. Licensed under Creative Commons Attribution Share Alike 3.0 (CC-BY-SA-3.0)

