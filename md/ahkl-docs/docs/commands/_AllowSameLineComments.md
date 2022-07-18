# \#AllowSameLineComments

[v1.1.09+]: **This directive was removed.** AutoIt scripts are no longer supported.

Only for AutoIt v2 (.aut) scripts: Allows a comment to appear on the same line as a command.

```
<span class="func">#AllowSameLineComments</span>
```

Specifying this directive at the **top** of any AutoIt v2 (.aut) script will enable the use of same-line comments, which are normally disabled for compatibility reasons. If not used at the top of the script, same-line comments are not supported above the point where the directive occurs.

Like other directives, #AllowSameLineComments cannot be executed conditionally.

## Examples

Allows a comment to appear on the same line as a command.

```
#AllowSameLineComments
Sleep, 1  <em>; This comment is a same-line comment.</em>
```

