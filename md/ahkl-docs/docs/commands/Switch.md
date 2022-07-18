# Switch [v1.1.31+]

Executes one case from a list of mutually exclusive candidates.

```
<span class="func">Switch</span> <span class="optional">SwitchValue</span>
{
<span class="func">Case</span> CaseValue1:
    <i>Statements1</i>
<span class="func">Case</span> CaseValue2a, CaseValue2b:
    <i>Statements2</i>
<span class="func">Default</span>:
    <i>Statements3</i>
}
```

## Remarks

If present, _SwitchValue_ is evaluated once and compared to each case value until a match is found, and then that case is executed. Otherwise, the first case which evaluates to [true](../Concepts.htm#boolean) (non-zero and non-empty) is executed. If there is no matching case and a `Default` is present, it is executed.

[StringCaseSense](StringCaseSense.htm) controls the case-sensitivity of string comparisons performed by Switch.

Each case may list up to 20 values. Each value must be an [expression](../Language.htm#expressions), but can be a simple one such as a literal number, quoted string or variable. `Case` and `Default` must be terminated with a colon `:`.

The first statement of each case may be below `Case` or on the same line, following the colon. Each case implicitly ends at the next `Case`/ `Default` or the closing brace. Unlike the switch statement found in some other languages, there is no implicit fall-through and [Break](Break.htm) is not used (except to break out of an enclosing loop).

As all cases are enclosed in the same block, a label defined in one case can be the target of [Goto](Goto.htm) from another case. However, if a label is placed immediately above `Case` or `Default`, it targets the end of the previous case, not the beginning of the next one.

`Default` is not required to be listed last.

## Related

[If (expression)](IfExpression.htm), [Else](Else.htm), [Blocks](Block.htm)

## Examples

This is a working hotkey example. There is a functionally equivalent [example](Input.htm#ExHotkey) using if-else-if in the documentation for the [Input](Input.htm) command.

```
~[::
Input, UserInput, V T5 L4 C, {enter}.{esc}{tab}, btw,otoh,fl,ahk,ca
switch ErrorLevel
{
case "Max":
    MsgBox, You entered "%UserInput%", which is the maximum length of text.
    return
case "Timeout":
    MsgBox, You entered "%UserInput%" at which time the input timed out.
    return
case "NewInput":
    return
default:
    if InStr(ErrorLevel, "EndKey:")
    {
        MsgBox, You entered "%UserInput%" and terminated the input with %ErrorLevel%.
        return
    }
}
switch UserInput
{
case "btw":   Send, {backspace 4}by the way
case "otoh":  Send, {backspace 5}on the other hand
case "fl":    Send, {backspace 3}Florida
case "ca":    Send, {backspace 3}California
case "ahk":   Run, https://www.autohotkey.com
}
return

```

