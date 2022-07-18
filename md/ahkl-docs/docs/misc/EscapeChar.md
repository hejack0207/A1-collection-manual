# Escape Sequences

The escape character `` ` `` (back-tick or grave accent) is used to indicate that the character immediately following it should be interpreted differently than it normally would. This character is at the upper left corner of most English keyboards.

In AutoHotkey the following escape sequences can be used (when the accent is the escape character):

SequenceResult`` `,``

`,` (literal comma)

**Note:** Commas that appear within the last parameter of a command do not need to be escaped because the program knows to treat them literally (but it is best to escape them anyway, for clarity). The same is true for all parameters of [MsgBox](../commands/MsgBox.htm) because it has smart comma handling.

`` `%```%` (literal percent)``` `` ````` ` `` (literal accent; i.e. two consecutive escape characters result in a single literal character)`` `;``

`;` (literal semicolon)

**Note:** It is not necessary to escape a semicolon which has any character other than space or tab to its immediate left, since it would not be interpreted as a comment anyway.

`` `::```::` (literal pair of colons). [v1.0.40+]: It is no longer necessary to escape these, except when used literally in a [hotstring](../Hotstrings.htm)'s replacement text.`` `n``newline (linefeed/LF)`` `r``carriage return (CR)`` `b``backspace`` `t``tab (the more typical horizontal variety)`` `v``vertical tab -- corresponds to Ascii value 11. It can also be manifest in some applications by typing Ctrl+K.`` `a``alert (bell) -- corresponds to Ascii value 7. It can also be manifest in some applications by typing Ctrl+G.`` `f``formfeed -- corresponds to Ascii value 12. It can also be manifest in some applications by typing Ctrl+L.`""`Within an [expression](../Variables.htm#Expressions), two consecutive quotes enclosed inside a literal string resolve to a single literal quote. For example: `Var := "The color ""red"" was found."`.

## Remarks

When the [Send command](../commands/Send.htm) or [Hotstrings](../Hotstrings.htm) are used in their default (non-raw) mode, characters such as `{}^!+#` have special meaning. Therefore, to use them literally in these cases, enclose them in braces. For example: `Send {<strong>^</strong>}{<strong>!</strong>}{<strong>{</strong>}`.

## Examples

Reports a multi-line string. The lines are separated by a linefeed character.

```
MsgBox % "Line 1`nLine 2"
```

