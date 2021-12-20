# create aggregate(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CREATE_AGGREGATE - define a new aggregate function

<a name="synopsis"></a>

# Synopsis

```


```
    CREATE [ OR REPLACE ] AGGREGATE name ( [ argmode ] [ argname ] arg_data_type [ , ... ] ) (
        SFUNC = sfunc,
        STYPE = state_data_type
        [ , SSPACE = state_data_size ]
        [ , FINALFUNC = ffunc ]
        [ , FINALFUNC_EXTRA ]
        [ , FINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE } ]
        [ , COMBINEFUNC = combinefunc ]
        [ , SERIALFUNC = serialfunc ]
        [ , DESERIALFUNC = deserialfunc ]
        [ , INITCOND = initial_condition ]
        [ , MSFUNC = msfunc ]
        [ , MINVFUNC = minvfunc ]
        [ , MSTYPE = mstate_data_type ]
        [ , MSSPACE = mstate_data_size ]
        [ , MFINALFUNC = mffunc ]
        [ , MFINALFUNC_EXTRA ]
        [ , MFINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE } ]
        [ , MINITCOND = minitial_condition ]
        [ , SORTOP = sort_operator ]
        [ , PARALLEL = { SAFE | RESTRICTED | UNSAFE } ]
    )
    
    CREATE [ OR REPLACE ] AGGREGATE name ( [ [ argmode ] [ argname ] arg_data_type [ , ... ] ]
                            ORDER BY [ argmode ] [ argname ] arg_data_type [ , ... ] ) (
        SFUNC = sfunc,
        STYPE = state_data_type
        [ , SSPACE = state_data_size ]
        [ , FINALFUNC = ffunc ]
        [ , FINALFUNC_EXTRA ]
        [ , FINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE } ]
        [ , INITCOND = initial_condition ]
        [ , PARALLEL = { SAFE | RESTRICTED | UNSAFE } ]
        [ , HYPOTHETICAL ]
    )
    
    or the old syntax
    
    CREATE [ OR REPLACE ] AGGREGATE name (
        BASETYPE = base_type,
        SFUNC = sfunc,
        STYPE = state_data_type
        [ , SSPACE = state_data_size ]
        [ , FINALFUNC = ffunc ]
        [ , FINALFUNC_EXTRA ]
        [ , FINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE } ]
        [ , COMBINEFUNC = combinefunc ]
        [ , SERIALFUNC = serialfunc ]
        [ , DESERIALFUNC = deserialfunc ]
        [ , INITCOND = initial_condition ]
        [ , MSFUNC = msfunc ]
        [ , MINVFUNC = minvfunc ]
        [ , MSTYPE = mstate_data_type ]
        [ , MSSPACE = mstate_data_size ]
        [ , MFINALFUNC = mffunc ]
        [ , MFINALFUNC_EXTRA ]
        [ , MFINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE } ]
        [ , MINITCOND = minitial_condition ]
        [ , SORTOP = sort_operator ]
    )

<a name="description"></a>

# Description


**CREATE AGGREGATE**
defines a new aggregate function.
**CREATE OR REPLACE AGGREGATE**
will either define a new aggregate function or replace an existing definition. Some basic and commonly-used aggregate functions are included with the distribution; they are documented in
Section&nbsp;9.20. If one defines new types or needs an aggregate function not already provided, then
**CREATE AGGREGATE**
can be used to provide the desired features.

When replacing an existing definition, the argument types, result type, and number of direct arguments may not be changed. Also, the new definition must be of the same kind (ordinary aggregate, ordered-set aggregate, or hypothetical-set aggregate) as the old one.

If a schema name is given (for example,
CREATE AGGREGATE myschema.myagg ...) then the aggregate function is created in the specified schema. Otherwise it is created in the current schema.

An aggregate function is identified by its name and input data type(s). Two aggregates in the same schema can have the same name if they operate on different input types. The name and input data type(s) of an aggregate must also be distinct from the name and input data type(s) of every ordinary function in the same schema. This behavior is identical to overloading of ordinary function names (see
CREATE FUNCTION (**CREATE\_FUNCTION**(7))).

A simple aggregate function is made from one or two ordinary functions: a state transition function
_sfunc_, and an optional final calculation function
_ffunc_. These are used as follows:

.if n \{.RS 4
.\}
    sfunc( internal-state, next-data-values ) ---> next-internal-state
    ffunc( internal-state ) ---> aggregate-value
.if n \{.RE
.\}

PostgreSQL
creates a temporary variable of data type
_stype_
to hold the current internal state of the aggregate. At each input row, the aggregate argument value(s) are calculated and the state transition function is invoked with the current state value and the new argument value(s) to calculate a new internal state value. After all the rows have been processed, the final function is invoked once to calculate the aggregates return value. If there is no final function then the ending state value is returned as-is.

An aggregate function can provide an initial condition, that is, an initial value for the internal state value. This is specified and stored in the database as a value of type
text, but it must be a valid external representation of a constant of the state value data type. If it is not supplied then the state value starts out null.

If the state transition function is declared
“strict”, then it cannot be called with null inputs. With such a transition function, aggregate execution behaves as follows. Rows with any null input values are ignored (the function is not called and the previous state value is retained). If the initial state value is null, then at the first row with all-nonnull input values, the first argument value replaces the state value, and the transition function is invoked at each subsequent row with all-nonnull input values. This is handy for implementing aggregates like
**max**. Note that this behavior is only available when
_state\_data\_type_
is the same as the first
_arg\_data\_type_. When these types are different, you must supply a nonnull initial condition or use a nonstrict transition function.

If the state transition function is not strict, then it will be called unconditionally at each input row, and must deal with null inputs and null state values for itself. This allows the aggregate author to have full control over the aggregates handling of null values.

If the final function is declared
“strict”, then it will not be called when the ending state value is null; instead a null result will be returned automatically. (Of course this is just the normal behavior of strict functions.) In any case the final function has the option of returning a null value. For example, the final function for
**avg**
returns null when it sees there were zero input rows.

Sometimes it is useful to declare the final function as taking not just the state value, but extra parameters corresponding to the aggregates input values. The main reason for doing this is if the final function is polymorphic and the state value\*(Aqs data type would be inadequate to pin down the result type. These extra parameters are always passed as NULL (and so the final function must not be strict when the
FINALFUNC_EXTRA
option is used), but nonetheless they are valid parameters. The final function could for example make use of
**get\_fn\_expr\_argtype**
to identify the actual argument type in the current call.

An aggregate can optionally support
moving-aggregate mode, as described in
Section&nbsp;37.12.1. This requires specifying the
MSFUNC,
MINVFUNC, and
MSTYPE
parameters, and optionally the
MSSPACE,
MFINALFUNC,
MFINALFUNC_EXTRA,
MFINALFUNC_MODIFY, and
MINITCOND
parameters. Except for
MINVFUNC, these parameters work like the corresponding simple-aggregate parameters without
M; they define a separate implementation of the aggregate that includes an inverse transition function.

The syntax with
ORDER BY
in the parameter list creates a special type of aggregate called an
ordered-set aggregate; or if
HYPOTHETICAL
is specified, then a
hypothetical-set aggregate
is created. These aggregates operate over groups of sorted values in order-dependent ways, so that specification of an input sort order is an essential part of a call. Also, they can have
direct
arguments, which are arguments that are evaluated only once per aggregation rather than once per input row. Hypothetical-set aggregates are a subclass of ordered-set aggregates in which some of the direct arguments are required to match, in number and data types, the aggregated argument columns. This allows the values of those direct arguments to be added to the collection of aggregate-input rows as an additional
“hypothetical”
row.

An aggregate can optionally support
partial aggregation, as described in
Section&nbsp;37.12.4. This requires specifying the
COMBINEFUNC
parameter. If the
_state\_data\_type_
is
internal, its usually also appropriate to provide the
SERIALFUNC
and
DESERIALFUNC
parameters so that parallel aggregation is possible. Note that the aggregate must also be marked
PARALLEL SAFE
to enable parallel aggregation.

Aggregates that behave like
**MIN**
or
**MAX**
can sometimes be optimized by looking into an index instead of scanning every input row. If this aggregate can be so optimized, indicate it by specifying a
sort operator. The basic requirement is that the aggregate must yield the first element in the sort ordering induced by the operator; in other words:

.if n \{.RS 4
.\}
    SELECT agg(col) FROM tab;
.if n \{.RE
.\}

must be equivalent to:

.if n \{.RS 4
.\}
    SELECT col FROM tab ORDER BY col USING sortop LIMIT 1;
.if n \{.RE
.\}

Further assumptions are that the aggregate ignores null inputs, and that it delivers a null result if and only if there were no non-null inputs. Ordinarily, a data types
&lt;
operator is the proper sort operator for
**MIN**, and
&gt;
is the proper sort operator for
**MAX**. Note that the optimization will never actually take effect unless the specified operator is the
“less than”
or
“greater than”
strategy member of a B-tree index operator class.

To be able to create an aggregate function, you must have
USAGE
privilege on the argument types, the state type(s), and the return type, as well as
EXECUTE
privilege on the supporting functions.

<a name="parameters"></a>

# Parameters


_name_
The name (optionally schema-qualified) of the aggregate function to create.

_argmode_
The mode of an argument:
IN
or
VARIADIC. (Aggregate functions do not support
OUT
arguments.) If omitted, the default is
IN. Only the last argument can be marked
VARIADIC.

_argname_
The name of an argument. This is currently only useful for documentation purposes. If omitted, the argument has no name.

_arg\_data\_type_
An input data type on which this aggregate function operates. To create a zero-argument aggregate function, write
*
in place of the list of argument specifications. (An example of such an aggregate is
**count(*)**.)

_base\_type_
In the old syntax for
**CREATE AGGREGATE**, the input data type is specified by a
basetype
parameter rather than being written next to the aggregate name. Note that this syntax allows only one input parameter. To define a zero-argument aggregate function with this syntax, specify the
basetype
as
"ANY"
(not
*). Ordered-set aggregates cannot be defined with the old syntax.

_sfunc_
The name of the state transition function to be called for each input row. For a normal
_N_-argument aggregate function, the
_sfunc_
must take
_N_+1 arguments, the first being of type
_state\_data\_type_
and the rest matching the declared input data type(s) of the aggregate. The function must return a value of type
_state\_data\_type_. This function takes the current state value and the current input data value(s), and returns the next state value.

For ordered-set (including hypothetical-set) aggregates, the state transition function receives only the current state value and the aggregated arguments, not the direct arguments. Otherwise it is the same.

_state\_data\_type_
The data type for the aggregates state value.

_state\_data\_size_
The approximate average size (in bytes) of the aggregates state value. If this parameter is omitted or is zero, a default estimate is used based on the
_state\_data\_type_. The planner uses this value to estimate the memory required for a grouped aggregate query. The planner will consider using hash aggregation for such a query only if the hash table is estimated to fit in
work_mem; therefore, large values of this parameter discourage use of hash aggregation.

_ffunc_
The name of the final function called to compute the aggregates result after all input rows have been traversed. For a normal aggregate, this function must take a single argument of type
_state\_data\_type_. The return data type of the aggregate is defined as the return type of this function. If
_ffunc_
is not specified, then the ending state value is used as the aggregates result, and the return type is
_state\_data\_type_.

For ordered-set (including hypothetical-set) aggregates, the final function receives not only the final state value, but also the values of all the direct arguments.

If
FINALFUNC_EXTRA
is specified, then in addition to the final state value and any direct arguments, the final function receives extra NULL values corresponding to the aggregates regular (aggregated) arguments. This is mainly useful to allow correct resolution of the aggregate result type when a polymorphic aggregate is being defined.

FINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE }
This option specifies whether the final function is a pure function that does not modify its arguments.
READ_ONLY
indicates it does not; the other two values indicate that it may change the transition state value. See
NOTES
below for more detail. The default is
READ_ONLY, except for ordered-set aggregates, for which the default is
READ_WRITE.

_combinefunc_
The
_combinefunc_
function may optionally be specified to allow the aggregate function to support partial aggregation. If provided, the
_combinefunc_
must combine two
_state\_data\_type_
values, each containing the result of aggregation over some subset of the input values, to produce a new
_state\_data\_type_
that represents the result of aggregating over both sets of inputs. This function can be thought of as an
_sfunc_, where instead of acting upon an individual input row and adding it to the running aggregate state, it adds another aggregate state to the running state.

The
_combinefunc_
must be declared as taking two arguments of the
_state\_data\_type_
and returning a value of the
_state\_data\_type_. Optionally this function may be
“strict”. In this case the function will not be called when either of the input states are null; the other state will be taken as the correct result.

For aggregate functions whose
_state\_data\_type_
is
internal, the
_combinefunc_
must not be strict. In this case the
_combinefunc_
must ensure that null states are handled correctly and that the state being returned is properly stored in the aggregate memory context.

_serialfunc_
An aggregate function whose
_state\_data\_type_
is
internal
can participate in parallel aggregation only if it has a
_serialfunc_
function, which must serialize the aggregate state into a
bytea
value for transmission to another process. This function must take a single argument of type
internal
and return type
bytea. A corresponding
_deserialfunc_
is also required.

_deserialfunc_
Deserialize a previously serialized aggregate state back into
_state\_data\_type_. This function must take two arguments of types
bytea
and
internal, and produce a result of type
internal. (Note: the second,
internal
argument is unused, but is required for type safety reasons.)

_initial\_condition_
The initial setting for the state value. This must be a string constant in the form accepted for the data type
_state\_data\_type_. If not specified, the state value starts out null.

_msfunc_
The name of the forward state transition function to be called for each input row in moving-aggregate mode. This is exactly like the regular transition function, except that its first argument and result are of type
_mstate\_data\_type_, which might be different from
_state\_data\_type_.

_minvfunc_
The name of the inverse state transition function to be used in moving-aggregate mode. This function has the same argument and result types as
_msfunc_, but it is used to remove a value from the current aggregate state, rather than add a value to it. The inverse transition function must have the same strictness attribute as the forward state transition function.

_mstate\_data\_type_
The data type for the aggregates state value, when using moving-aggregate mode.

_mstate\_data\_size_
The approximate average size (in bytes) of the aggregates state value, when using moving-aggregate mode. This works the same as
_state\_data\_size_.

_mffunc_
The name of the final function called to compute the aggregates result after all input rows have been traversed, when using moving-aggregate mode. This works the same as
_ffunc_, except that its first arguments type is
_mstate\_data\_type_
and extra dummy arguments are specified by writing
MFINALFUNC_EXTRA. The aggregate result type determined by
_mffunc_
or
_mstate\_data\_type_
must match that determined by the aggregates regular implementation.

MFINALFUNC_MODIFY = { READ_ONLY | SHAREABLE | READ_WRITE }
This option is like
FINALFUNC_MODIFY, but it describes the behavior of the moving-aggregate final function.

_minitial\_condition_
The initial setting for the state value, when using moving-aggregate mode. This works the same as
_initial\_condition_.

_sort\_operator_
The associated sort operator for a
**MIN**- or
**MAX**-like aggregate. This is just an operator name (possibly schema-qualified). The operator is assumed to have the same input data types as the aggregate (which must be a single-argument normal aggregate).

PARALLEL = { SAFE | RESTRICTED | UNSAFE }
The meanings of
PARALLEL SAFE,
PARALLEL RESTRICTED, and
PARALLEL UNSAFE
are the same as in
CREATE FUNCTION (**CREATE\_FUNCTION**(7)). An aggregate will not be considered for parallelization if it is marked
PARALLEL UNSAFE
(which is the default!) or
PARALLEL RESTRICTED. Note that the parallel-safety markings of the aggregates support functions are not consulted by the planner, only the marking of the aggregate itself.

HYPOTHETICAL
For ordered-set aggregates only, this flag specifies that the aggregate arguments are to be processed according to the requirements for hypothetical-set aggregates: that is, the last few direct arguments must match the data types of the aggregated (WITHIN GROUP) arguments. The
HYPOTHETICAL
flag has no effect on run-time behavior, only on parse-time resolution of the data types and collations of the aggregates arguments.

The parameters of
**CREATE AGGREGATE**
can be written in any order, not just the order illustrated above.

<a name="notes"></a>

# Notes


In parameters that specify support function names, you can write a schema name if needed, for example
SFUNC = public.sum. Do not write argument types there, however — the argument types of the support functions are determined from other parameters.

Ordinarily, PostgreSQL functions are expected to be true functions that do not modify their input values. However, an aggregate transition function,
_when used in the context of an aggregate_, is allowed to cheat and modify its transition-state argument in place. This can provide substantial performance benefits compared to making a fresh copy of the transition state each time.

Likewise, while an aggregate final function is normally expected not to modify its input values, sometimes it is impractical to avoid modifying the transition-state argument. Such behavior must be declared using the
FINALFUNC_MODIFY
parameter. The
READ_WRITE
value indicates that the final function modifies the transition state in unspecified ways. This value prevents use of the aggregate as a window function, and it also prevents merging of transition states for aggregate calls that share the same input values and transition functions. The
SHAREABLE
value indicates that the transition function cannot be applied after the final function, but multiple final-function calls can be performed on the ending transition state value. This value prevents use of the aggregate as a window function, but it allows merging of transition states. (That is, the optimization of interest here is not applying the same final function repeatedly, but applying different final functions to the same ending transition state value. This is allowed as long as none of the final functions are marked
READ_WRITE.)

If an aggregate supports moving-aggregate mode, it will improve calculation efficiency when the aggregate is used as a window function for a window with moving frame start (that is, a frame start mode other than
UNBOUNDED PRECEDING). Conceptually, the forward transition function adds input values to the aggregates state when they enter the window frame from the bottom, and the inverse transition function removes them again when they leave the frame at the top. So, when values are removed, they are always removed in the same order they were added. Whenever the inverse transition function is invoked, it will thus receive the earliest added but not yet removed argument value(s). The inverse transition function can assume that at least one row will remain in the current state after it removes the oldest row. (When this would not be the case, the window function mechanism simply starts a fresh aggregation, rather than using the inverse transition function.)

The forward transition function for moving-aggregate mode is not allowed to return NULL as the new state value. If the inverse transition function returns NULL, this is taken as an indication that the inverse function cannot reverse the state calculation for this particular input, and so the aggregate calculation will be redone from scratch for the current frame starting position. This convention allows moving-aggregate mode to be used in situations where there are some infrequent cases that are impractical to reverse out of the running state value.

If no moving-aggregate implementation is supplied, the aggregate can still be used with moving frames, but
PostgreSQL
will recompute the whole aggregation whenever the start of the frame moves. Note that whether or not the aggregate supports moving-aggregate mode,
PostgreSQL
can handle a moving frame end without recalculation; this is done by continuing to add new values to the aggregates state. This is why use of an aggregate as a window function requires that the final function be read-only: it must not damage the aggregate\*(Aqs state value, so that the aggregation can be continued even after an aggregate result value has been obtained for one set of frame boundaries.

The syntax for ordered-set aggregates allows
VARIADIC
to be specified for both the last direct parameter and the last aggregated (WITHIN GROUP) parameter. However, the current implementation restricts use of
VARIADIC
in two ways. First, ordered-set aggregates can only use
VARIADIC "any", not other variadic array types. Second, if the last direct parameter is
VARIADIC "any", then there can be only one aggregated parameter and it must also be
VARIADIC "any". (In the representation used in the system catalogs, these two parameters are merged into a single
VARIADIC "any"
item, since
pg_proc
cannot represent functions with more than one
VARIADIC
parameter.) If the aggregate is a hypothetical-set aggregate, the direct arguments that match the
VARIADIC "any"
parameter are the hypothetical ones; any preceding parameters represent additional direct arguments that are not constrained to match the aggregated arguments.

Currently, ordered-set aggregates do not need to support moving-aggregate mode, since they cannot be used as window functions.

Partial (including parallel) aggregation is currently not supported for ordered-set aggregates. Also, it will never be used for aggregate calls that include
DISTINCT
or
ORDER BY
clauses, since those semantics cannot be supported during partial aggregation.

<a name="examples"></a>

# Examples


See
Section&nbsp;37.12.

<a name="compatibility"></a>

# Compatibility


**CREATE AGGREGATE**
is a
PostgreSQL
language extension. The SQL standard does not provide for user-defined aggregate functions.

<a name="see-also"></a>

# See Also

ALTER AGGREGATE (**ALTER\_AGGREGATE**(7)), DROP AGGREGATE (**DROP\_AGGREGATE**(7))
