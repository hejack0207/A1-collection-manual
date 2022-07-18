# Catch [v1.1.04+]

Specifies the code to execute if an exception is raised during execution of a [try](Try.htm) statement.

```
<span class="func">Catch</span> <span class="optional">, OutputVar</span>
    <i>Statement</i>

```

```
<span class="func">Catch</span> <span class="optional">, OutputVar</span>
{
    <i>Statements</i>
}

```

## Parameters

OutputVar

_(Optional)_ The name of the variable in which to store the value of the exception.

_Statement(s)_

The commands or expressions to execute if an exception is raised.

## Remarks

Every use of _catch_ must belong to (be associated with) a [try](Try.htm) statement above it. A _catch_ always belongs to the nearest unclaimed _try_ statement above it unless a [block](Block.htm) is used to change that behavior.

The [One True Brace (OTB) style](Block.htm#otb) may optionally be used. For example:

```
try {
    ...
} catch e {
    ...
}
```

## Runtime Errors

A _try-catch_ statement can also be used to handle runtime errors. There are two kinds of runtime errors: those which normally set [ErrorLevel](../misc/ErrorLevel.htm), and those which normally cause the current thread to exit after displaying an error message. Loadtime errors cannot be handled, since they occur before the _try_ statement is executed. For backward-compatibility (and in some cases convenience), runtime errors only throw exceptions while a _try_ block is executing. Most commands support the use of _try-catch_; however, [ErrorLevel](../misc/ErrorLevel.htm) is still set to 0 if the command succeeds.

The value that is stored in _OutputVar_ (if present) is an [exception object](Throw.htm#Exception).

## Related

[Try](Try.htm), [Throw](Throw.htm), [Finally](Finally.htm), [Blocks](Block.htm), [OnError()](OnError.htm)

## Examples

See [Try](Try.htm#Examples).

