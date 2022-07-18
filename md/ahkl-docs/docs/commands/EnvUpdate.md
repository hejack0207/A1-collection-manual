# EnvUpdate

Notifies the OS and all running applications that [environment variable(s)](../Concepts.htm#environment-variables) have changed.

```
<span class="func">EnvUpdate</span>
```

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

Refreshes the OS environment. Similar effect as logging off and then on again.

For example, after making changes to the following registry key, EnvUpdate could be used to broadcast the change:

```
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment
```

## Related

[EnvSet](EnvSet.htm), [RegWrite](RegWrite.htm)

## Examples

Refreshes the OS environment.

```
EnvUpdate
```

