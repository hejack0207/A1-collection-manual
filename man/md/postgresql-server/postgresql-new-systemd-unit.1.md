# postgresql-new-systemd-unit(1) - manual page for postgresql-new-systemd-unit 8.4

Version 8.4, May 2021

```
postgresql-new-systemd-unit --unit SYSTEMD_UNIT --datadir DATADIR
```

<a name="description"></a>

# Description

Automatically create systemd unit for PostgreSQL service.

For more info and howto/when use this script please look at the documentation
file _/usr/share/doc/postgresql/README.rpm-dist_.

<a name="options"></a>

# Options


* **--unit**=_UNIT\_NAME_  
  The name of new systemdunit, of form
  postgresql@&lt;string&gt;, will generate service file
  postgresql@&lt;string&gt;.service.
* **--datadir**=_DATADIR_  
  Where the data will be stored.  The postgres
  user needs to have permissions to create this
  directory.

Built against PostgreSQL version 12.7.
