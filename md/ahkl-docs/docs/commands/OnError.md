# OnError() [v1.1.29+]

Specifies a [function](../Functions.htm) to run automatically when an unhandled error occurs.

```
<span class="func">OnError</span>(Func <span class="optional">, AddRemove</span>)
```

## Parameters

Func

A function name or [function object](../objects/Functor.htm) to call when an unhandled error occurs. The function is given the exception object as a parameter, and may return a non-zero integer to block the default error dialog.

AddRemove

If blank or omitted, it defaults to 1 (call the function after any previously registered functions). Otherwise, specify one of the following numbers:

- 1 = Call the function after any previously registered functions.
- -1 = Call the function before any previously registered functions.
- 0 = Do not call the function.

## Remarks

_Func_ is called only for errors or exceptions which would normally cause an error message to be displayed. It cannot be called for a load-time error, since OnError cannot be called until after the script has loaded.

If any error function returns a non-zero integer, the thread exits. If an error occurs (or an exception is thrown) within an error function, an error message is displayed for the new error and the thread exits. Otherwise, all error function are called, an error message is displayed and the thread exits.

_Func_'s first parameter receives the thrown value or [Exception](Throw.htm#Exception) object. If this is an object, it can be modified to affect what the default error dialog displays.

_Func_ is called on the current [thread](../misc/Threads.htm), before it exits (that is, before the call stack unwinds).

## Related

[Try](Try.htm), [Catch](Catch.htm), [Throw](Throw.htm), [OnExit()](OnExit.htm#function), [OnExit](OnExit.htm#command)

## Examples

Logs errors caused by the script into a text file instead of displaying them to the user.

```
OnError("LogError")
%cause% := error

LogError(exception) {
    FileAppend % "Error on line " exception.Line ": " exception.Message "`n"
        , errorlog.txt
    return true
}

```

