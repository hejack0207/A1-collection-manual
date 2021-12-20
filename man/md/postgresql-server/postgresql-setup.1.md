# postgresql-setup(1) - manual page for postgresql-setup 8.4

Version 8.4, May 2021

```
postgresql-setup MODE_OPTION [--unit=UNIT_NAME] [OPTION...]
```

<a name="description"></a>

# Description

Script is aimed to help sysadmin with basic database cluster administration.
Usually, "postgresql-setup **--initdb**" and "postgresql-setup **--upgrade**" is
enough, however there are other options described below.

For more info and howto/when use this script please look at the documentation
file _/usr/share/doc/postgresql/README.rpm-dist_.

<a name="available-operation-mode"></a>

### Available operation mode:


* **--initdb**  
  Initialize new PostgreSQL database cluster.  This is usually the
  first action you perform after PostgreSQL server installation.
* **--upgrade**  
  Upgrade database cluster for new major version of PostgreSQL
  server.  See the **--upgrade-from** option for more info.

<a name="options"></a>

# Options


* **--unit**=_UNIT\_NAME_  
  The UNIT_NAME is used to select proper unit
  configuration (unit == service or initscript name
  on non-systemd systems).  For example, if you want
  to work with unit called
  'postgresql@com_example.service', you should use
  'postgresql@com_example' (without trailing .service
  string).  When no UNIT_NAME is explicitly passed,
  the 'postgresql' string is used by default.
* **--port**=_PORT_  
  port where the initialized server will listen for
  connections
* **--new-systemd-unit**  
  We dropped this option for security reasons.
  Nowadays, please use the root-only script
  _/usr/sbin/postgresql-new-systemd-unit_.
* **--datadir**  
  Dropped with **--new-systemd-unit**.
* **--upgrade-from-unit**=_UNIT_  
  Select proper unit name to upgrade from.  This
  has similar semantics as **--unit** option.
* **--upgrade-ids**  
  Print list of available IDs of upgrade scenarios to
  standard output.
* **--upgrade-from**=_ID_  
  Specify id "old" postgresql stack to upgrade
  from.  List of available IDs can be listed by
  **--upgrade-ids**.  Default is 'postgresql'.

<a name="other-options"></a>

### Other options:


* **--help**  
  show this help
* **--version**  
  show version of this package
* **--debug**  
  show basic debugging information

<a name="environment"></a>

# Environment


* PGSETUP_INITDB_OPTIONS  
  Options carried by this variable are passed to
  subsequent call of \`initdb\` binary (see man
  initdb(1)).  This variable is used also during
  'upgrade' mode because the new cluster is actually
  re-initialized from the old one.
* PGSETUP_PGUPGRADE_OPTIONS  
  Options in this variable are passed next to the
  subsequent call of \`pg_upgrade\`.  For more info
  about possible options please look at man
  pg_upgrade(1).
* PGSETUP_DEBUG  
  Set to '1' if you want to see very verbose shell
  debugging output.

Built against PostgreSQL version 12.7.
