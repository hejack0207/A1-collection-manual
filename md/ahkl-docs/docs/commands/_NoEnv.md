# \#NoEnv [v1.0.43.08+]

Avoids checking empty variables to see if they are environment variables (recommended for all new scripts).

```
<span class="func">#NoEnv</span>
```

Specifying the line `#NoEnv` anywhere in a script prevents empty variables from being looked up as potential environment variables. For example:

```
#NoEnv
MsgBox %WinDir%
```

The above would **not** retrieve the "WinDir" environment variable (though that could be solved by doing `WinDir := A_WinDir` near the top of the script).

Specifying `#NoEnv` is recommended for all new scripts because:

1. It significantly improves performance whenever empty variables are used in an expression or command. It also improves[DllCall](DllCall.htm)'s performance when unquoted parameter types are used (e.g. int vs. "int").
2. It prevents script bugs caused by environment variables whose names unexpectedly match variables used by the script.
3. [AutoHotkey v2](https://www.autohotkey.com/v2/) will make this behavior the default.

To help ease the transition to #NoEnv, the built-in variables [ComSpec](../Variables.htm#ComSpec) and [ProgramFiles](../Variables.htm#ProgramFiles) have been added. They contain the same strings as the corresponding environment variables.

When #NoEnv is in effect, the script should use [EnvGet](EnvGet.htm) to retrieve environment variables, or use built-in variables like [A\_WinDir](../Variables.htm#WinDir).

Like other directives, #NoEnv cannot be executed conditionally.

## Related

[EnvGet](EnvGet.htm), [ComSpec](../Variables.htm#ComSpec), [ProgramFiles](../Variables.htm#ProgramFiles), [A\_WinDir](../Variables.htm#WinDir)

