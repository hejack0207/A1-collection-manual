# create event trigger(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_EVENT_TRIGGER - define a new event trigger

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE EVENT TRIGGER name
        ON event
        [ WHEN filter_variable IN (filter_value [, ... ]) [ AND ... ] ]
        EXECUTE { FUNCTION | PROCEDURE } function_name()

<a name="description"></a>

# Description


**CREATE EVENT TRIGGER**
creates a new event trigger. Whenever the designated event occurs and the
WHEN
condition associated with the trigger, if any, is satisfied, the trigger function will be executed. For a general introduction to event triggers, see
Chapter&nbsp;39. The user who creates an event trigger becomes its owner.

<a name="parameters"></a>

# Parameters


_name_
The name to give the new trigger. This name must be unique within the database.

_event_
The name of the event that triggers a call to the given function. See
Section&nbsp;39.1
for more information on event names.

_filter\_variable_
The name of a variable used to filter events. This makes it possible to restrict the firing of the trigger to a subset of the cases in which it is supported. Currently the only supported
_filter\_variable_
is
TAG.

_filter\_value_
A list of values for the associated
_filter\_variable_
for which the trigger should fire. For
TAG, this means a list of command tags (e.g.,
DROP FUNCTION\*(Aq).

_function\_name_
A user-supplied function that is declared as taking no argument and returning type
event_trigger.

In the syntax of
CREATE EVENT TRIGGER, the keywords
FUNCTION
and
PROCEDURE
are equivalent, but the referenced function must in any case be a function, not a procedure. The use of the keyword
PROCEDURE
here is historical and deprecated.

<a name="notes"></a>

# Notes


Only superusers can create event triggers.

Event triggers are disabled in single-user mode (see
**postgres**(1)). If an erroneous event trigger disables the database so much that you cant even drop the trigger, restart in single-user mode and you\*(Aqll be able to do that.

<a name="examples"></a>

# Examples


Forbid the execution of any
DDL
command:

.if n \{.RS 4
.\}
    CREATE OR REPLACE FUNCTION abort_any_command()
      RETURNS event_trigger
     LANGUAGE plpgsql
      AS $$
    BEGIN
      RAISE EXCEPTION command % is disabled*(Aq, tg_tag;
    END;
    $$;
    
    CREATE EVENT TRIGGER abort_ddl ON ddl_command_start
       EXECUTE FUNCTION abort_any_command();
.if n \{.RE
.\}

<a name="compatibility"></a>

# Compatibility


There is no
**CREATE EVENT TRIGGER**
statement in the SQL standard.

<a name="see-also"></a>

# See Also

ALTER EVENT TRIGGER (**ALTER\_EVENT\_TRIGGER**(7)), DROP EVENT TRIGGER (**DROP\_EVENT\_TRIGGER**(7)), CREATE FUNCTION (**CREATE\_FUNCTION**(7))
