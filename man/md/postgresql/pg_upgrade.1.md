# pg_upgrade(1)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pg_upgrade - upgrade a PostgreSQL server instance

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pg_upgrade&nbsp;'u pg_upgrade -b oldbindir -B newbindir -d oldconfigdir -D newconfigdir [option...]
```

<a name="description"></a>

# Description


pg_upgrade
(formerly called
pg_migrator) allows data stored in
PostgreSQL
data files to be upgraded to a later
PostgreSQL
major version without the data dump/reload typically required for major version upgrades, e.g., from 9.5.8 to 9.6.4 or from 10.7 to 11.2. It is not required for minor version upgrades, e.g., from 9.6.2 to 9.6.3 or from 10.1 to 10.2.

Major PostgreSQL releases regularly add new features that often change the layout of the system tables, but the internal data storage format rarely changes.
pg_upgrade
uses this fact to perform rapid upgrades by creating new system tables and simply reusing the old user data files. If a future major release ever changes the data storage format in a way that makes the old data format unreadable,
pg_upgrade
will not be usable for such upgrades. (The community will attempt to avoid such situations.)

pg_upgrade
does its best to make sure the old and new clusters are binary-compatible, e.g., by checking for compatible compile-time settings, including 32/64-bit binaries. It is important that any external modules are also binary compatible, though this cannot be checked by
pg_upgrade.

pg_upgrade supports upgrades from 8.4.X and later to the current major release of
PostgreSQL, including snapshot and beta releases.

<a name="options"></a>

# Options


pg_upgrade
accepts the following command-line arguments:

**-b** _bindir_  
**--old-bindir=**_bindir_
the old PostgreSQL executable directory; environment variable
**PGBINOLD**

**-B** _bindir_  
**--new-bindir=**_bindir_
the new PostgreSQL executable directory; environment variable
**PGBINNEW**

**-c**  
**--check**
check clusters only, dont change any data

**-d** _configdir_  
**--old-datadir=**_configdir_
the old database cluster configuration directory; environment variable
**PGDATAOLD**

**-D** _configdir_  
**--new-datadir=**_configdir_
the new database cluster configuration directory; environment variable
**PGDATANEW**

**-j ****njobs**  
**--jobs=****njobs**
number of simultaneous processes or threads to use

**-k**  
**--link**
use hard links instead of copying files to the new cluster

**-o** _options_  
**--old-options** _options_
options to be passed directly to the old
**postgres**
command; multiple option invocations are appended

**-O** _options_  
**--new-options** _options_
options to be passed directly to the new
**postgres**
command; multiple option invocations are appended

**-p** _port_  
**--old-port=**_port_
the old cluster port number; environment variable
**PGPORTOLD**

**-P** _port_  
**--new-port=**_port_
the new cluster port number; environment variable
**PGPORTNEW**

**-r**  
**--retain**
retain SQL and log files even after successful completion

**-s** _dir_  
**--socketdir=**_dir_
directory to use for postmaster sockets during upgrade; default is current working directory; environment variable
**PGSOCKETDIR**

**-U** _username_  
**--username=**_username_
clusters install user name; environment variable
**PGUSER**

**-v**  
**--verbose**
enable verbose internal logging

**-V**  
**--version**
display version information, then exit

**--clone**
Use efficient file cloning (also known as
“reflinks”
on some systems) instead of copying files to the new cluster. This can result in near-instantaneous copying of the data files, giving the speed advantages of
**-k**/**--link**
while leaving the old cluster untouched.

File cloning is only supported on some operating systems and file systems. If it is selected but not supported, the
pg_upgrade
run will error. At present, it is supported on Linux (kernel 4.5 or later) with Btrfs and XFS (on file systems created with reflink support), and on macOS with APFS.

**-?**  
**--help**
show help, then exit

<a name="usage"></a>

# Usage


These are the steps to perform an upgrade with
pg_upgrade:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  Optionally move the old cluster: If you are using a version-specific installation directory, e.g.,
  /opt/PostgreSQL/12, you do not need to move the old cluster. The graphical installers all use version-specific installation directories.

If your installation directory is not version-specific, e.g.,
/usr/local/pgsql, it is necessary to move the current PostgreSQL install directory so it does not interfere with the new
PostgreSQL
installation. Once the current
PostgreSQL
server is shut down, it is safe to rename the PostgreSQL installation directory; assuming the old directory is
/usr/local/pgsql, you can do:

.if n \{.RS 4
.\}
    mv /usr/local/pgsql /usr/local/pgsql.old
.if n \{.RE
.\}

to rename the directory.

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  For source installs, build the new version: Build the new PostgreSQL source with
  **configure**
  flags that are compatible with the old cluster.
  pg_upgrade
  will check
  **pg\_controldata**
  to make sure all settings are compatible before starting the upgrade.

.ie n \{\h'-04' 3.\h'+01'\c
.\}
.el \{.sp -1

*   3.  
  .\}
  Install the new PostgreSQL binaries: Install the new servers binaries and support files.
  pg_upgrade
  is included in a default installation.

For source installs, if you wish to install the new server in a custom location, use the
prefix
variable:

.if n \{.RS 4
.\}
    make prefix=/usr/local/pgsql.new install
.if n \{.RE
.\}

.ie n \{\h'-04' 4.\h'+01'\c
.\}
.el \{.sp -1

*   4.  
  .\}
  Initialize the new PostgreSQL cluster: Initialize the new cluster using
  **initdb**. Again, use compatible
  **initdb**
  flags that match the old cluster. Many prebuilt installers do this step automatically. There is no need to start the new cluster.

.ie n \{\h'-04' 5.\h'+01'\c
.\}
.el \{.sp -1

*   5.  
  .\}
  Install custom shared object files: Install any custom shared object files (or DLLs) used by the old cluster into the new cluster, e.g.,
  pgcrypto.so, whether they are from
  contrib
  or some other source. Do not install the schema definitions, e.g.,
  **CREATE EXTENSION pgcrypto**, because these will be upgraded from the old cluster. Also, any custom full text search files (dictionary, synonym, thesaurus, stop words) must also be copied to the new cluster.

.ie n \{\h'-04' 6.\h'+01'\c
.\}
.el \{.sp -1

*   6.  
  .\}
  Adjust authentication: **pg\_upgrade**
  will connect to the old and new servers several times, so you might want to set authentication to
  peer
  in
  pg_hba.conf
  or use a
  ~/.pgpass
  file (see
  Section&nbsp;33.15).

.ie n \{\h'-04' 7.\h'+01'\c
.\}
.el \{.sp -1

*   7.  
  .\}
  Stop both servers: Make sure both database servers are stopped using, on Unix, e.g.:

.if n \{.RS 4
.\}
    pg_ctl -D /opt/PostgreSQL/9.6 stop
    pg_ctl -D /opt/PostgreSQL/12 stop
.if n \{.RE
.\}

or on Windows, using the proper service names:

.if n \{.RS 4
.\}
    NET STOP postgresql-9.6
    NET STOP postgresql-12
.if n \{.RE
.\}

Streaming replication and log-shipping standby servers can remain running until a later step.

.ie n \{\h'-04' 8.\h'+01'\c
.\}
.el \{.sp -1

*   8.  
  .\}
  Prepare for standby server upgrades: If you are upgrading standby servers using methods outlined in section
  Step 10, verify that the old standby servers are caught up by running
  pg_controldata
  against the old primary and standby clusters. Verify that the
  “Latest checkpoint location”
  values match in all clusters. (There will be a mismatch if old standby servers were shut down before the old primary or if the old standby servers are still running.) Also, make sure
  _wal\_level_
  is not set to
  minimal
  in the
  postgresql.conf
  file on the new primary cluster.

.ie n \{\h'-04' 9.\h'+01'\c
.\}
.el \{.sp -1

*   9.  
  .\}
  Run pg_upgrade: Always run the
  pg_upgrade
  binary of the new server, not the old one.
  pg_upgrade
  requires the specification of the old and new clusters data and executable (bin) directories. You can also specify user and port values, and whether you want the data files linked or cloned instead of the default copy behavior.

If you use link mode, the upgrade will be much faster (no file copying) and use less disk space, but you will not be able to access your old cluster once you start the new cluster after the upgrade. Link mode also requires that the old and new cluster data directories be in the same file system. (Tablespaces and
pg_wal
can be on different file systems.) Clone mode provides the same speed and disk space advantages but does not cause the old cluster to be unusable once the new cluster is started. Clone mode also requires that the old and new data directories be in the same file system. This mode is only available on certain operating systems and file systems.

The
**--jobs**
option allows multiple CPU cores to be used for copying/linking of files and to dump and reload database schemas in parallel; a good place to start is the maximum of the number of CPU cores and tablespaces. This option can dramatically reduce the time to upgrade a multi-database server running on a multiprocessor machine.

For Windows users, you must be logged into an administrative account, and then start a shell as the
postgres
user and set the proper path:

.if n \{.RS 4
.\}
    RUNAS /USER:postgres "CMD.EXE"
    SET PATH=%PATH%;C:eProgram FilesePostgreSQLe12ebin;
.if n \{.RE
.\}

and then run
pg_upgrade
with quoted directories, e.g.:

.if n \{.RS 4
.\}
    pg_upgrade.exe
            --old-datadir "C:/Program Files/PostgreSQL/9.6/data"
            --new-datadir "C:/Program Files/PostgreSQL/12/data"
            --old-bindir "C:/Program Files/PostgreSQL/9.6/bin"
            --new-bindir "C:/Program Files/PostgreSQL/12/bin"
.if n \{.RE
.\}

Once started,
**pg\_upgrade**
will verify the two clusters are compatible and then do the upgrade. You can use
**pg_upgrade --check**
to perform only the checks, even if the old server is still running.
**pg_upgrade --check**
will also outline any manual adjustments you will need to make after the upgrade. If you are going to be using link or clone mode, you should use the option
**--link**
or
**--clone**
with
**--check**
to enable mode-specific checks.
**pg\_upgrade**
requires write permission in the current directory.

Obviously, no one should be accessing the clusters during the upgrade.
pg_upgrade
defaults to running servers on port 50432 to avoid unintended client connections. You can use the same port number for both clusters when doing an upgrade because the old and new clusters will not be running at the same time. However, when checking an old running server, the old and new port numbers must be different.

If an error occurs while restoring the database schema,
**pg\_upgrade**
will exit and you will have to revert to the old cluster as outlined in
Step 16
below. To try
**pg\_upgrade**
again, you will need to modify the old cluster so the pg_upgrade schema restore succeeds. If the problem is a
contrib
module, you might need to uninstall the
contrib
module from the old cluster and install it in the new cluster after the upgrade, assuming the module is not being used to store user data.

.ie n \{\h'-04' 10.\h'+01'\c
.\}
.el \{.sp -1

*   10.  
  .\}
  Upgrade streaming replication and log-shipping standby servers: If you used link mode and have Streaming Replication (see
  Section&nbsp;26.2.5) or Log-Shipping (see
  Section&nbsp;26.2) standby servers, you can follow these steps to quickly upgrade them. You will not be running
  pg_upgrade
  on the standby servers, but rather
  rsync
  on the primary. Do not start any servers yet.

If you did
_not_
use link mode, do not have or do not want to use
rsync, or want an easier solution, skip the instructions in this section and simply recreate the standby servers once
pg_upgrade
completes and the new primary is running.
Install the new PostgreSQL binaries on standby servers: Make sure the new binaries and support files are installed on all standby servers.
Make sure the new standby data directories do _not_ exist: Make sure the new standby data directories do
_not_
exist or are empty. If
initdb
was run, delete the standby servers new data directories.
Install custom shared object files: Install the same custom shared object files on the new standbys that you installed in the new primary cluster.
Stop standby servers: If the standby servers are still running, stop them now using the above instructions.
Save configuration files: Save any configuration files from the old standbys configuration directories you need to keep, e.g.,
postgresql.conf
(and any files included by it),
postgresql.auto.conf,
pg_hba.conf, because these will be overwritten or removed in the next step.
Run rsync: When using link mode, standby servers can be quickly upgraded using
rsync. To accomplish this, from a directory on the primary server that is above the old and new database cluster directories, run this on the
_primary_
for each standby server:

.if n \{.RS 4
.\}
    rsync --archive --delete --hard-links --size-only --no-inc-recursive old_cluster new_cluster remote_dir
.if n \{.RE
.\}

where
**old\_cluster**
and
**new\_cluster**
are relative to the current directory on the primary, and
**remote\_dir**
is
_above_
the old and new cluster directories on the standby. The directory structure under the specified directories on the primary and standbys must match. Consult the
rsync
manual page for details on specifying the remote directory, e.g.,

.if n \{.RS 4
.\}
    rsync --archive --delete --hard-links --size-only --no-inc-recursive /opt/PostgreSQL/9.5 e
          /opt/PostgreSQL/9.6 standby.example.com:/opt/PostgreSQL
.if n \{.RE
.\}

You can verify what the command will do using
rsyncs
**--dry-run**
option. While
rsync
must be run on the primary for at least one standby, it is possible to run
rsync
on an upgraded standby to upgrade other standbys, as long as the upgraded standby has not been started.

What this does is to record the links created by
pg_upgrades link mode that connect files in the old and new clusters on the primary server. It then finds matching files in the standby\*(Aqs old cluster and creates links for them in the standby\*(Aqs new cluster. Files that were not linked on the primary are copied from the primary to the standby. (They are usually small.) This provides rapid standby upgrades. Unfortunately,
rsync
needlessly copies files associated with temporary and unlogged tables because these files dont normally exist on standby servers.

If you have tablespaces, you will need to run a similar
rsync
command for each tablespace directory, e.g.:

.if n \{.RS 4
.\}
    rsync --archive --delete --hard-links --size-only --no-inc-recursive /vol1/pg_tblsp/PG_9.5_201510051 e
          /vol1/pg_tblsp/PG_9.6_201608131 standby.example.com:/vol1/pg_tblsp
.if n \{.RE
.\}

If you have relocated
pg_wal
outside the data directories,
rsync
must be run on those directories too.
Configure streaming replication and log-shipping standby servers: Configure the servers for log shipping. (You do not need to run
**pg\_start\_backup()**
and
**pg\_stop\_backup()**
or take a file system backup as the standbys are still synchronized with the primary.)

.ie n \{\h'-04' 11.\h'+01'\c
.\}
.el \{.sp -1

*   11.  
  .\}
  Restore pg_hba.conf: If you modified
  pg_hba.conf, restore its original settings. It might also be necessary to adjust other configuration files in the new cluster to match the old cluster, e.g.,
  postgresql.conf
  (and any files included by it),
  postgresql.auto.conf.

.ie n \{\h'-04' 12.\h'+01'\c
.\}
.el \{.sp -1

*   12.  
  .\}
  Start the new server: The new server can now be safely started, and then any
  rsynced standby servers.

.ie n \{\h'-04' 13.\h'+01'\c
.\}
.el \{.sp -1

*   13.  
  .\}
  Post-upgrade processing: If any post-upgrade processing is required, pg_upgrade will issue warnings as it completes. It will also generate script files that must be run by the administrator. The script files will connect to each database that needs post-upgrade processing. Each script should be run using:

.if n \{.RS 4
.\}
    psql --username=postgres --file=script.sql postgres
.if n \{.RE
.\}

The scripts can be run in any order and can be deleted once they have been run.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Caution**
.ps -1  
In general it is unsafe to access tables referenced in rebuild scripts until the rebuild scripts have run to completion; doing so could yield incorrect results or poor performance. Tables not referenced in rebuild scripts can be accessed immediately.


.ie n \{\h'-04' 14.\h'+01'\c
.\}
.el \{.sp -1

*   14.  
  .\}
  Statistics: Because optimizer statistics are not transferred by
  **pg\_upgrade**, you will be instructed to run a command to regenerate that information at the end of the upgrade. You might need to set connection parameters to match your new cluster.

.ie n \{\h'-04' 15.\h'+01'\c
.\}
.el \{.sp -1

*   15.  
  .\}
  Delete old cluster: Once you are satisfied with the upgrade, you can delete the old clusters data directories by running the script mentioned when
  **pg\_upgrade**
  completes. (Automatic deletion is not possible if you have user-defined tablespaces inside the old data directory.) You can also delete the old installation directories (e.g.,
  bin,
  share).

.ie n \{\h'-04' 16.\h'+01'\c
.\}
.el \{.sp -1

*   16.  
  .\}
  Reverting to old cluster: If, after running
  **pg\_upgrade**, you wish to revert to the old cluster, there are several options:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If the
  **--check**
  option was used, the old cluster was unmodified; it can be restarted.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If the
  **--link**
  option was
  _not_
  used, the old cluster was unmodified; it can be restarted.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If the
  **--link**
  option was used, the data files might be shared between the old and new cluster:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If
  **pg\_upgrade**
  aborted before linking started, the old cluster was unmodified; it can be restarted.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If you did
  _not_
  start the new cluster, the old cluster was unmodified except that, when linking started, a
  .old
  suffix was appended to
  $PGDATA/global/pg_control. To reuse the old cluster, remove the
  .old
  suffix from
  $PGDATA/global/pg_control; you can then restart the old cluster.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  If you did start the new cluster, it has written to shared files and it is unsafe to use the old cluster. The old cluster will need to be restored from backup in this case.



<a name="notes"></a>

# Notes


pg_upgrade
creates various working files, such as schema dumps, in the current working directory. For security, be sure that that directory is not readable or writable by any other users.

pg_upgrade
launches short-lived postmasters in the old and new data directories. Temporary Unix socket files for communication with these postmasters are, by default, made in the current working directory. In some situations the path name for the current directory might be too long to be a valid socket name. In that case you can use the
**-s**
option to put the socket files in some directory with a shorter path name. For security, be sure that that directory is not readable or writable by any other users. (This is not relevant on Windows.)

All failure, rebuild, and reindex cases will be reported by
pg_upgrade
if they affect your installation; post-upgrade scripts to rebuild tables and indexes will be generated automatically. If you are trying to automate the upgrade of many clusters, you should find that clusters with identical database schemas require the same post-upgrade steps for all cluster upgrades; this is because the post-upgrade steps are based on the database schemas, and not user data.

For deployment testing, create a schema-only copy of the old cluster, insert dummy data, and upgrade that.

pg_upgrade
does not support upgrading of databases containing table columns using these
reg*
OID-referencing system data types:
regproc,
regprocedure,
regoper,
regoperator,
regconfig, and
regdictionary. (regtype
can be upgraded.)

If you are upgrading a pre-PostgreSQL
9.2 cluster that uses a configuration-file-only directory, you must pass the real data directory location to
pg_upgrade, and pass the configuration directory location to the server, e.g.,
-d /real-data-directory -o -D /configuration-directory\*(Aq.

If using a pre-9.1 old server that is using a non-default Unix-domain socket directory or a default that differs from the default of the new cluster, set
**PGHOST**
to point to the old servers socket location. (This is not relevant on Windows.)

If you want to use link mode and you do not want your old cluster to be modified when the new cluster is started, consider using the clone mode. If that is not available, make a copy of the old cluster and upgrade that in link mode. To make a valid copy of the old cluster, use
**rsync**
to create a dirty copy of the old cluster while the server is running, then shut down the old server and run
**rsync --checksum**
again to update the copy with any changes to make it consistent. (**--checksum**
is necessary because
**rsync**
only has file modification-time granularity of one second.) You might want to exclude some files, e.g.,
postmaster.pid, as documented in
Section&nbsp;25.3.3. If your file system supports file system snapshots or copy-on-write file copies, you can use that to make a backup of the old cluster and tablespaces, though the snapshot and copies must be created simultaneously or while the database server is down.

<a name="see-also"></a>

# See Also

**initdb**(1), **pg\_ctl**(1), **pg\_dump**(1), **postgres**(1)
