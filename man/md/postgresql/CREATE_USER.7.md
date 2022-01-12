# create user(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_USER - define a new database role

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE USER name [ [ WITH ] option [ ... ] ]
    
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


**CREATE USER**
is now an alias for
CREATE ROLE (**CREATE\_ROLE**(7)). The only difference is that when the command is spelled
**CREATE USER**,
LOGIN
is assumed by default, whereas
NOLOGIN
is assumed when the command is spelled
**CREATE ROLE**.

<a name="compatibility"></a>

# Compatibility


The
**CREATE USER**
statement is a
PostgreSQL
extension. The SQL standard leaves the definition of users to the implementation.

<a name="see-also"></a>

# See Also

CREATE ROLE (**CREATE\_ROLE**(7))
