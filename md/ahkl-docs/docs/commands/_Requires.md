# \#Requires [v1.1.33+]

Displays an error and quits if a version requirement is not met.

```
<span class="func">#Requires</span> Requirement
```

## Parameters

Requirement

If this begins with the word "AutoHotkey" followed by a space or tab, it should be followed by a version string with optional leading "v". If [A\_AhkVersion](../Variables.htm#AhkVersion) is deemed compatible, loading of the script continues without displaying an error. For example, a script that requires v1.1.33 will also run on v1.1.33.01 and v1.1.34, but not v2.0.

Otherwise, an error message is shown and the program exits.

## Error Message

If a different version of AutoHotkey is required, the message includes [A\_AhkVersion](../Variables.htm#AhkVersion):

```
This script requires <i>%Requirement%</i>, but you have v<i>%A_AhkVersion%</i>.
```

If the requirement was not recognized, the message format is as follows:

```
This script requires <i>%Requirement%</i>.
```

If the script is launched with a version of AutoHotkey that does not support this directive, the error message is something like the following:

```
Line Text: #Requires <i>%Requirement%</i>
Error: This line does not contain a recognized action.
```

## Remarks

If the script uses syntax or functions which are unavailable in earlier versions, using this directive ensures that the error message shows the unmet requirement, rather than indicating an arbitrary syntax error. This cannot be done with something like `if (A_AhkVersion <= "1.1.33")` because a syntax error elsewhere in the script would prevent it from executing.

When sharing a script or posting code online, using this directive allows anyone who finds the code to readily identify which version of AutoHotkey it was intended for.

Other programs or scripts can check for this directive for various purposes. For example, a launcher script might use it to determine which AutoHotkey executable to launch, while a script editor or related tools might use it to determine how to interpret or highlight the script file.

Version strings are compared as a series of dot-delimited components, optionally followed by a hyphen and pre-release identifier(s).

- Numeric components are compared numerically. For example, v1.01 = v1.1, but a20 > a112.
- Numeric components are always considered lower than non-numeric components in the same position.
- Any missing dot-delimited components are assumed to be zero. For example, v1.1.33-alpha is the same as v1.1.33.00-alpha.0.
- Non-numeric components are compared alphabetically, and are case sensitive.
- Pre-release versions are considered lower than standard releases. For example, a script that`#Requires AutoHotkey v2` will not run on v2.0-a112. To permit pre-release versions, include a hyphen suffix. For example: `v2.0-`.
- Any suffix beginning with "+" is ignored.

A trailing "+" is sufficient to indicate to the reader that later versions are acceptable, but is not required.

Like other directives, #Requires cannot be executed conditionally.

## Related

[#ErrorStdOut](_ErrorStdOut.htm)

## Examples

Causes the script to run only on v1.1.33.00 and later v1.1.\* releases.

```
#Requires AutoHotkey v1.1.33+
MsgBox This script will run only on v1.1.33.00 and later v1.1.* releases.
```

