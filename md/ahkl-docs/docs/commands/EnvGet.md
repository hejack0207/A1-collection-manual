# EnvGet [v1.0.43.08+]

Retrieves an environment variable.

```
<span class="func">EnvGet</span>, OutputVar, EnvVarName
```

## Parameters

OutputVar

The name of the variable in which to store the string.

EnvVarName

The name of the [environment variable](../Concepts.htm#environment-variables) to retrieve. For example: `EnvGet, OutputVar, Path`.

## Remarks

If the specified environment variable is empty or does not exist, _OutputVar_ is made blank.

The operating system limits each environment variable to 32 KB of text.

## Related

[EnvSet](EnvSet.htm), [#NoEnv](_NoEnv.htm), [environment variables](../Concepts.htm#environment-variables), [EnvUpdate](EnvUpdate.htm), [SetEnv](SetEnv.htm), [Run](Run.htm), [RunWait](Run.htm)

## Examples

Retrieves an environment variable and stores its value in OutputVar.

```
EnvGet, OutputVar, LogonServer
```

Retrieves and reports the path of the "Program Files" directory. See [RegRead example #2](RegRead.htm#ExProgramFiles) for an alternative method.

```
EnvGet, OutputVar, % <a href="../Variables.htm#Is64bitOS" data-index="12">A_Is64bitOS</a> ? "ProgramW6432" : "ProgramFiles"
MsgBox, Program files are in: %OutputVar%
```

Retrieves and reports the path of the current user's Local AppData directory.

```
EnvGet, LocalAppData, LocalAppData
MsgBox, %A_UserName%'s Local directory is located at: %LocalAppData%
```

