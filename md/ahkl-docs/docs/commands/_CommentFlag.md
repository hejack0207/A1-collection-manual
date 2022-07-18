# \#CommentFlag

Changes the script's comment symbol from semicolon to some other string.

**Deprecated:** This directive is not recommended for use in new scripts. Use the default comment flag (semicolon) instead.

```
<span class="func">#CommentFlag</span> NewString
```

## Parameters

NewString

One or more characters that should be used as the new comment flag. Up to 15 characters may be specified.

## Remarks

The default comment flag is semicolon (;).

The comment flag is used to indicate that text that follows it should not be acted upon by the script (comments are not loaded into memory when a script is launched, so they do not affect performance).

A comment flag that appears on the same line as a command is not considered to mark a comment unless it has at least one space or tab to its left. For example:

```
MsgBox, Test1 <em>; This is a comment.</em>
MsgBox, Test2; This is not a comment and will be displayed by MsgBox.
```

Like other directives, #CommentFlag cannot be executed conditionally.

## Related

[#EscapeChar](_EscapeChar.htm)

## Examples

Changes to C++ comment style.

```
#CommentFlag //
```

