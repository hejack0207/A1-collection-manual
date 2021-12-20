# do(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

DO - execute an anonymous code block

<a name="synopsis"></a>

# Synopsis

```


```
    DO [ LANGUAGE lang_name ] code

<a name="description"></a>

# Description


**DO**
executes an anonymous code block, or in other words a transient anonymous function in a procedural language.

The code block is treated as though it were the body of a function with no parameters, returning
void. It is parsed and executed a single time.

The optional
LANGUAGE
clause can be written either before or after the code block.

<a name="parameters"></a>

# Parameters


_code_
The procedural language code to be executed. This must be specified as a string literal, just as in
**CREATE FUNCTION**. Use of a dollar-quoted literal is recommended.

_lang\_name_
The name of the procedural language the code is written in. If omitted, the default is
plpgsql.

<a name="notes"></a>

# Notes


The procedural language to be used must already have been installed into the current database by means of
**CREATE EXTENSION**.
plpgsql
is installed by default, but other languages are not.

The user must have
USAGE
privilege for the procedural language, or must be a superuser if the language is untrusted. This is the same privilege requirement as for creating a function in the language.

If
**DO**
is executed in a transaction block, then the procedure code cannot execute transaction control statements. Transaction control statements are only allowed if
**DO**
is executed in its own transaction.

<a name="examples"></a>

# Examples


Grant all privileges on all views in schema
public
to role
webuser:

.if n \{.RS 4
.\}
    DO $$DECLARE r record;
    BEGIN
        FOR r IN SELECT table_schema, table_name FROM information_schema.tables
                 WHERE table_type = VIEW*(Aq AND table_schema = *(Aqpublic*(Aq
        LOOP
            EXECUTE GRANT ALL ON *(Aq || quote_ident(r.table_schema) || *(Aq.*(Aq || quote_ident(r.table_name) || *(Aq TO webuser*(Aq;
        END LOOP;
    END$$;
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**DO**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

CREATE LANGUAGE (**CREATE\_LANGUAGE**(7))
