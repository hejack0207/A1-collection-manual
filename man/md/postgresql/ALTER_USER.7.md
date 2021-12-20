# alter user(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ALTER_USER - change a database role

<a name="synopsis"></a>

# Synopsis

```


```
    ALTER USER role_specification [ WITH ] option [ ... ]
    
    where option can be:
    
          SUPERUSER | NOSUPERUSER
        | CREATEDB | NOCREATEDB
        | CREATEROLE | NOCREATEROLE
        | INHERIT | NOINHERIT
        | LOGIN | NOLOGIN
        | REPLICATION | NOREPLICATION
        | BYPASSRLS | NOBYPASSRLS
        | CONNECTION LIMIT connlimit
        | [ ENCRYPTED ] PASSWORD password*(Aq | PASSWORD NULL
        | VALID UNTIL timestamp*(Aq
    
    ALTER USER name RENAME TO new_name
    
    ALTER USER { role_specification | ALL } [ IN DATABASE database_name ] SET configuration_parameter { TO | = } { value | DEFAULT }
    ALTER USER { role_specification | ALL } [ IN DATABASE database_name ] SET configuration_parameter FROM CURRENT
    ALTER USER { role_specification | ALL } [ IN DATABASE database_name ] RESET configuration_parameter
    ALTER USER { role_specification | ALL } [ IN DATABASE database_name ] RESET ALL
    
    where role_specification can be:
    
        role_name
      | CURRENT_USER
      | SESSION_USER

<a name="description"></a>

# Description


**ALTER USER**
is now an alias for
ALTER ROLE (**ALTER\_ROLE**(7)).

<a name="compatibility"></a>

# Compatibility


The
**ALTER USER**
statement is a
PostgreSQL
extension. The SQL standard leaves the definition of users to the implementation.

<a name="see-also"></a>

# See Also

ALTER ROLE (**ALTER\_ROLE**(7))
