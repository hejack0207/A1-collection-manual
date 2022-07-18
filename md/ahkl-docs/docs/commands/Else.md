# Else

Specifies one or more [statements](../Concepts.htm#statement) to execute if an [If statement](../Language.htm#if-statement) evaluates to false.

```
<span class="func">Else</span> <i>Statement</i>
```

```
<span class="func">Else</span>
{
    <i>Statements</i>
}
```

## Remarks

Every use of an _Else_ must belong to (be associated with) an [If statement](../Language.htm#if-statement) above it. An _Else_ always belongs to the nearest unclaimed If statement above it unless a [block](Block.htm) is used to change that behavior.

An _Else_ can be followed immediately by any other single [statement](../Concepts.htm#statement) on the same line. This is most often used for "else if" ladders (see examples at the bottom).

If an _Else_ owns more than one line, those lines must be enclosed in braces (to create a [block](Block.htm)). However, if only one line belongs to an _Else_, the braces are optional. For example:

```
if (count > 0)  <em>; No braces are required around the next line because it's only a single line.</em>
    MsgBox Press OK to begin the process.
else  <em>; Braces must be used around the section below because it consists of more than one line.</em>
{
    WinClose Untitled - Notepad
    MsgBox There are no items present.
}
```

The [One True Brace (OTB) style](Block.htm#otb) may optionally be used around an _Else_. For example:

```
if IsDone {
    <em>; ...</em>
} else if (x < y) {
    <em>; ...</em>
} else {
    <em>; ...</em>
}
```

## Related

[Blocks](Block.htm), [If Statements](../Language.htm#if-statement), [Control Flow Statements](../Language.htm#control-flow)

## Examples

Common usage of an _Else_ statement. This example is executed as follows:

1. If Notepad exists:
1. Activate it
2. Send the string "This is a test." followed byEnter.
2. Otherwise (that is, if Notepad does not exist):
1. Activate another window
2. Left-click at the coordinates 100, 200

```
if WinExist("Untitled - Notepad")
{
    WinActivate
    Send This is a test.{Enter}
}
else
{
    WinActivate, Some Other Window
    MouseClick, Left, 100, 200
}
```

Demonstrates different styles of how the _Else_ statement can be used too. Note that IfEqual is deprecated and should generally be avoided.

```
if (x = 1)
    Gosub, a1
else if (x = 2) <em>; "else if" style</em>
    Gosub, a2
else IfEqual, x, 3 <em>; alternate style</em>
{
    Gosub, a3
    Sleep, 1
}
else Gosub, a4  <em>; i.e. Any single statement can be on the same line with an Else.</em>

<em>; Also OK:</em>
IfEqual, y, 1, Gosub, b1
else {
    Sleep, 1
    Gosub, b2
}
```

