# Finally [v1.1.14+]

Ensures that one or more statements are always executed after a [Try](Try.htm) statement finishes.

```
<span class="func">Finally</span> <i>Statement</i>
```

```
<span class="func">Finally</span>
{
    <i>Statements</i>
}

```

## Remarks

Every use of _finally_ must belong to (be associated with) a [try](Try.htm) (or [catch](Catch.htm)) statement above it. A _finally_ always belongs to the nearest unclaimed _try_ statement above it unless a [block](Block.htm) is used to change that behavior.

_Try_ statements behave differently depending on whether _catch_ or _finally_ is present. For more information, see [Try](Try.htm).

_Goto_, _break_, _continue_ and _return_ cannot be used to exit a _finally_ block, as that would require suppressing any control flow instructions within the _try_ block. For example, if _try_ uses `return 42`, the value 42 is returned after the finally block executes. Attempts to jump out of a _finally_ block using one of these commands are detected as errors at load time where possible, or at run time otherwise.

Prior to [v1.1.19.02], a bug existed which prevented control flow statements within _try_ from working when _finally_ was present. _Return_ was erroneously permitted within _finally_, but was ignored if an exception had been thrown.

_Finally_ statements are not executed if the script is directly terminated by any means, including the tray menu, [ExitApp](ExitApp.htm), or [Exit](Exit.htm) (when the script is not [persistent](_Persistent.htm)). However, if only the current [thread](../misc/Threads.htm) (not the entire script) is exiting, _finally_ statements are executed.

The [One True Brace (OTB) style](Block.htm#otb) may optionally be used with the _finally_ command. For example:

```
try {
    ...
} finally {
    ...
}

try {
    ...
} catch e {
    ...
} finally {
    ...
}
```

## Related

[Try](Try.htm), [Catch](Catch.htm), [Throw](Throw.htm), [Blocks](Block.htm)

## Examples

Demonstrates the behavior of _finally_ in detail.

```
try
{
    ToolTip, Working...
    Example1()
}
catch e
{
    <em>; For more detail about the object that e contains, see <a href="Catch.htm" data-index="16">Catch</a>.</em>
    MsgBox, 16,, % "Exception thrown!`n`nwhat: " e.what "`nfile: " e.file
        . "`nline: " e.line "`nmessage: " e.message "`nextra: " e.extra
}
finally
{
    ToolTip <em>; hide the tooltip</em>
}

MsgBox, Done!

<em>; This function has a Finally block that acts as cleanup code</em>
Example1()
{
    try
        Example2()
    finally
        MsgBox, This is always executed regardless of exceptions
}

<em>; This function fails when the minutes are odd</em>
Example2()
{
    if Mod(A_Min, 2)
        throw Exception("Test exception")
    MsgBox, Example2 did not fail
}
```

