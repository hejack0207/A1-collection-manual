# \fbmariadb-service-convert\fr(1)

MariaDB 10\&.3, 9 May 2017

.nh


<a name="name"></a>

# Name

mariadb-service-convert - generate a mariadb.service file based on the current mysql/mariadb settings

<a name="description"></a>

# Description

Use: Generate a mariadb.service file based on the current mysql/mariadb settings\.
This is to assist distro maintainers in migrating to systemd service definations from 
a user mysqld_safe settings in the my.cnf files\.

Redirect output to user directory like /etc/systemd/system/mariadb.service.d/migrated-from-my.cnf-settings.conf

For more information, please refer to the MariaDB Knowledge Base, available online at https://mariadb.com/kb/
