# EnvSet

Writes a value to a [variable](../Variables.htm) contained in the environment.

```
<span class="func">EnvSet</span>, EnvVar, Value
```

## Parameters

EnvVarName of the [environment variable](../Concepts.htm#environment-variables) to use, e.g. "COMSPEC"
 or "PATH".Value

Value to set the [environment variable](../Concepts.htm#environment-variables) to.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

The operating system limits each environment variable to 32 KB of text.

An environment variable created or changed with this command will be accessible only to programs the script launches via [Run](Run.htm) or [RunWait](Run.htm). See [environment variables](../Concepts.htm#environment-variables) for more details.

This command exists separately from [SetEnv](SetEnv.htm) because [normal script variables](../Variables.htm) are not stored in the environment. This is because performance would be worse and also because the OS limits environment variables to 32 KB.

## Related

[EnvGet](EnvGet.htm), [#NoEnv](_NoEnv.htm), [environment variables](../Concepts.htm#environment-variables), [EnvUpdate](EnvUpdate.htm), [SetEnv](SetEnv.htm), [Run](Run.htm), [RunWait](Run.htm)

## Examples

Writes some text to the AutGUI variable contained in the environment.

```
EnvSet, AutGUI, Some text to put in the variable.
```

