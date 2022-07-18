# Try [v1.1.04+]

Guards one or more statements (commands or expressions) against runtime errors and exceptions thrown by the [throw](Throw.htm) command.

```
<span class="func">Try</span> <i>Statement</i>
```

```
<span class="func">Try</span>
{
    <i>Statements</i>
}

```

## Remarks

The _try_ command is usually followed by a [block](Block.htm) \- one or more statements (commands or expressions) enclosed in braces. If only a single statement is to be executed, it can be placed on the same line as _try_ or on the next line, and the braces can be omitted. To specify code that executes only when _try_ catches an error, use the [catch](Catch.htm) command.

An exception can be thrown by the [throw](Throw.htm) command or by the program when a runtime error occurs. When an exception is thrown from within a try block or a function called by one, the following occurs:

- If there is a corresponding[catch](Catch.htm) statement, execution continues there.
- If there is no catch statement but there is a[finally](Finally.htm) statement, it is executed, but once it finishes the exception is automatically thrown again.
- If there is neither a catch statement nor a finally statement, execution continues at the next line outside the try block.

If an exception is thrown while no try blocks are executing, an error message is shown and the current thread exits.

The [One True Brace (OTB) style](Block.htm#otb) may optionally be used with the _try_ command. For example:

```
try {
    ...
} catch e {
    ...
}
```

## Related

[Catch](Catch.htm), [Throw](Throw.htm), [Finally](Finally.htm), [Blocks](Block.htm), [OnError()](OnError.htm)

## Examples

Demonstrates the basic concept of try/catch/throw.

```
try  <em>; Attempts to execute code.</em>
{
    HelloWorld()
    MakeToast()
}
<a href="Catch.htm" data-index="14">catch</a> e  <em>; Handles the first error/exception raised by the block above.</em>
{
    MsgBox, An exception was thrown!`nSpecifically: %e%
    <a href="Exit.htm" data-index="15">Exit</a>
}

HelloWorld()  <em>; Always succeeds.</em>
{
    MsgBox, Hello, world!
}

MakeToast()  <em>; Always fails.</em>
{
    <em>; Jump immediately to the try block's error handler:</em>
    <a href="Throw.htm" data-index="16">throw</a> A_ThisFunc " is not implemented, sorry"
}

```

Demonstrates the use of try/catch instead of ErrorLevel.

```
try
{
    <em>; The following tries to back up certain types of files:</em>
    FileCopy, %A_MyDocuments%\*.txt, D:\Backup\Text documents
    FileCopy, %A_MyDocuments%\*.doc, D:\Backup\Text documents
    FileCopy, %A_MyDocuments%\*.jpg, D:\Backup\Photos
}
catch
{
    MsgBox, 16,, There was a problem while backing the files up!
    ExitApp
}

```

Demonstrates the use of try/catch dealing with COM errors. For details about the COM object used below, see [Using the ScriptControl (Microsoft Docs)](http://msdn.microsoft.com/en-us/library/aa227633(v=vs.60).aspx).

```
try
{
    obj := <a href="ComObjCreate.htm" data-index="20">ComObjCreate</a>("ScriptControl")
    obj.ExecuteStatement("MsgBox ""This is embedded VBScript""")
    obj.InvalidMethod() <em>; This line produces a runtime error.</em>
}
catch e
{
    <em>; For more detail about the object that e contains, see <a href="Throw.htm#Exception" data-index="21">Exception()</a>.</em>
    MsgBox, 16,, % "Exception thrown!`n`nwhat: " e.what "`nfile: " e.file
        . "`nline: " e.line "`nmessage: " e.message "`nextra: " e.extra
}

```

Demonstrates nesting try-catch statements.

```
try Example1() <em>; Any single statement can be on the same line with a Try command.</em>
catch e
    MsgBox, Example1() threw %e%.

Example1()
{
    try Example2()
    catch e
    {
        if (e = 1)
            throw e <em>; Rethrow the exception so that the caller can catch it.</em>
        else
            MsgBox, Example2() threw %e%.
    }
}

Example2()
{
    Random, o, 1, 2
    throw o
}
```

