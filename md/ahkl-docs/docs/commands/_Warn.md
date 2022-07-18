# \#Warn [v1.0.95.00+]

Enables or disables warnings for specific conditions which may indicate an error, such as a typo or missing "global" declaration.

```
<span class="func">#Warn</span> <span class="optional">WarningType, WarningMode</span>
```

## Parameters

WarningType

The type of warning to enable or disable. If omitted, it defaults to _All_.

**UseUnsetLocal** or **UseUnsetGlobal**: Warn when a variable is read without having previously been assigned a value or initialized with [VarSetCapacity()](VarSetCapacity.htm). If the variable is intended to be empty, assign an empty string to suppress this warning.

This is split into separate warning types for locals and globals because it is more common to use a global variable without prior initialization, due to their persistent and script-wide nature. For this reason, some script authors may wish to enable this type of warning for locals but disable it for globals.

```
#Warn
<em>;y := ""  ; This would suppress the warning.</em>
x := y    <em>; y hasn't been assigned a value.</em>
```

**UseEnv**: Warn when an environment variable is automatically used in place of an empty script variable. This sometimes occurs when an environment variable's name unexpectedly matches a variable used by the script. This warning occurs when the variable is accessed, but never occurs if the script enables [#NoEnv](_NoEnv.htm) (recommended for multiple reasons).

```
#Warn
<em>;#NoEnv             ; Add this if "temp" is not intended to be an environment variable.</em>
<em>;EnvGet temp, TEMP  ; This would copy the environment variable's value into the script variable.</em>
temp := ""          <em>; Despite this line, temp still seems to have a value.</em>
MsgBox % temp       <em>; This accesses the environment variable named "TEMP".</em>
```

**LocalSameAsGlobal**: Before the script starts to run, display a warning for each _undeclared_ local variable which has the same name as a global variable. This is intended to prevent errors caused by forgetting to declare a global variable inside a function before attempting to access it. If the variable really was intended to be local, a declaration such as `local x` or `static y` can be used to suppress the warning. This warning is never shown for variables inside a [force-local](../Functions.htm#ForceLocal) function.

```
#Warn
g := 1
ShowG() {       <em>; The warning is displayed even if the function is never called.</em>
    <em>;global g   ; <-- This is required to access the global variable.</em>
    MsgBox % g  <em>; Without the declaration, "g" is an empty local variable.</em>
}
```

**ClassOverwrite**[v1.1.27+]: Before the script starts to run, show a warning for each assignment targetting a class variable. For example, `box := new Box` will show a warning if _Box_ is a class, since this would overwrite the class (within the super-global variable, _Box_). Warnings are also shown for output variables of commands, but not ByRef parameters. Warnings are not shown for nested classes or dynamic variable references.

**Unreachable**[v1.1.33+]: Before the script starts to run, show a warning for each line that immediately follows a `Return`, `Break`, `Continue`, `Throw`, `Goto` or `Exit` at the same nesting level, unless that line is the target of a label. Although this does not detect all unreachable code, it detects common errors such as:

- Placing initialization code (such as an assignment or[GroupAdd](GroupAdd.htm)) in between hotkey subroutines, when it should be in the [auto-execute section](../Language.htm#auto-execute-section).
- Placing the first line of a "multi-line" hotkey subroutine on the same line as the hotkey label. Doing so will make it a[single-line hotkey](../Hotkeys.htm#Intro), with an implicit `return` that prevents any subsequent lines from executing. Similarly, placing `return` after a single-line hotkey is redundant and will cause a warning.
- Placing a[subroutine](../Language.htm#subroutines) inside another subroutine, breaking the flow of code.

If the code is intended to be unreachable - such as if a `return` has been used to temporarily disable a block of code, or a hotkey or hotstring has been temporarily disabled by commenting it out - consider commenting out the unreachable code as well. Alternatively, the warning can be suppressed by defining a [label](../misc/Labels.htm) above the first unreachable line.

**All**: Apply the given _WarningMode_ to all supported warning types.

WarningMode

A value indicating how warnings should be delivered. If omitted, it defaults to _MsgBox_.

**MsgBox**: Show a message box describing the warning. Note that once the message box is dismissed, the script will continue as usual.

**StdOut**[v1.1.04+]: Send a description of the warning to _stdout_ (the program's standard output stream), along with the filename and line number. This allows fancy editors such as SciTE to capture warnings without disrupting the script - the user can later jump to each offending line via the editor's output pane.

**OutputDebug**: Send a description of the warning to the debugger for display. If a debugger is not active, this will have no effect. For more details, see [OutputDebug](OutputDebug.htm).

**Off**: Disable warnings of the given _WarningType_.

## Remarks

By default, all warnings are off.

Warnings can't be enabled or disabled at run-time; the settings are determined when a script loads. Therefore, the location in the script is not significant (and, like other directives, #Warn cannot be executed conditionally).

However, the ordering of multiple #Warn directives is significant: the last occurrence that sets a given warning determines the mode for that warning. So, for example, the two statements below have the combined effect of enabling all warnings except UseEnv:

```
#Warn All
#Warn UseEnv, Off

EnvSet EnvVar, 1
x := EnvVar       <em>; Okay since #NoEnv has not been used.</em>
x := NotAnEnvVar  <em>; Warning.</em>

```

## Related

[Local and Global Variables](../Functions.htm#Local)

## Examples

Disables all warnings. This is the default state.

```
#Warn All, Off
```

Enables every type of warning and shows each warning in a message box.

```
#Warn
```

Warns when a local variable is used before it is set and sends each warning to OutputDebug.

```
#Warn UseUnsetLocal, OutputDebug
```

