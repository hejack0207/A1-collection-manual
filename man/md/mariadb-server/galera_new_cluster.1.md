# \fbgalera_new_cluster\fr(1)

MariaDB 10\&.3, 9 May 2017

.nh


<a name="name"></a>

# Name

galera_new_cluster - starting a new Galera cluster

<a name="description"></a>

# Description

Used to bootstrap a new Galera Cluster when all nodes are down.
Run galera_new_cluster on the first node only.
On the remaining nodes simply run 'service @DAEMON_NAME@ start'.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  
  
  **--help**,
  **-h**

Display a help message and exit.



<a name="see-also"></a>

# See Also

For more information on configuration and usage see 
https://mariadb.com/kb/en/mariadb/getting-started-with-mariadb-galera-cluster/
