# Throw [v1.1.04+]

Signals the occurrence of an error. This signal can be caught by a [try](Try.htm)- [catch](Catch.htm) statement.

```
<span class="func">Throw</span> <span class="optional">, Expression</span>
```

## Parameters

Expression

A value to store in [catch](Catch.htm)'s OutputVar.

Since this parameter is an [expression](../Variables.htm#Expressions), all of the following are valid examples:

```
throw 3
throw "literal string"
throw MyVar
throw i + 1
throw { what: "Custom error", file: A_LineFile, line: A_LineNumber } <em>; Throws an <a href="../objects/Object.htm" data-index="5">object</a></em>
```

This parameter is always an expression, so variable references should not be enclosed in [percent signs](../FAQ.htm#percent) except to perform a [double-deref](../Variables.htm#ref).

[v1.1.05+]: If omitted, an [exception object](#Exception) is thrown with a default message.

## Exception()

Creates an object with properties, also common to exceptions created by [runtime errors](Catch.htm#RuntimeErrors).

```
<span class="func">Exception</span>(Message <span class="optional">, What, Extra</span>)
```

This object contains the following properties:

- **Message:** An error message or [ErrorLevel](../misc/ErrorLevel.htm) value.
- **What:** The name of the command, function or label which was executing or about to execute when the error occurred.
- **Extra:** Additional information about the error, if available.
- **File:** Set automatically to the full path of the script file which contains the line at which the error occurred.
- **Line:** Set automatically to the line number at which the error occurred.

If _What_ is omitted, it defaults to the name of the current function or subroutine. Otherwise it can be a string or a negative offset from the top of the call stack. For example, a value of -1 sets `Exception.What` to the current function or subroutine, and `Exception.Line` and `Exception.File` to the line and file which called it. However, if the script is [compiled](../Scripts.htm#ahk2exe) or the offset is invalid, _What_ is simply converted to a string.

_Message_ and _Extra_ are converted to strings. These are displayed by an error dialog if the exception is thrown and not caught.

```
try
    SomeFunction()
catch e
    MsgBox % "Error in " e.What ", which was called at line " e.Line

SomeFunction() {
    throw Exception("Fail", -1)
}
```

## Related

[Try](Try.htm), [Catch](Catch.htm), [Finally](Finally.htm), [OnError()](OnError.htm)

## Examples

See [Try](Try.htm#Examples).

