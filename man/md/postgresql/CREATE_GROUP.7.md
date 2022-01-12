# create group(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_GROUP - define a new database role

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE GROUP name [ [ WITH ] option [ ... ] ]
    
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
        | IN ROLE role_name [, ...]
        | IN GROUP role_name [, ...]
        | ROLE role_name [, ...]
        | ADMIN role_name [, ...]
        | USER role_name [, ...]
        | SYSID uid

<a name="description"></a>

# Description


**CREATE GROUP**
is now an alias for
CREATE ROLE (**CREATE\_ROLE**(7)).

<a name="compatibility"></a>

# Compatibility


There is no
**CREATE GROUP**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE ROLE (**CREATE\_ROLE**(7))
