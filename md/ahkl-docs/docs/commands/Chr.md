# Chr()

Returns the string (usually a single character) corresponding to the character code indicated by the specified number.

```
String := <span class="func">Chr</span>(Number)
```

## Parameters

Number

If Unicode is supported, _Number_ is a Unicode character code between 0 and 0x10FFFF (or 0xFFFF prior to [v1.1.21]); otherwise it is an ANSI character code between 0 and 255.

## Return Value

This function returns a string corresponding to _Number_. If _Number_ is not in the valid range of character codes, an empty string is returned.

## Remarks

This function supersedes [Transform, OutputVar, Chr](Transform.htm#Chr).

The meaning of character codes greater than 127 depends on the [string encoding](../Compat.htm#Format) in use, which in turn depends on whether a [Unicode or ANSI](../Variables.htm#IsUnicode) executable is in use.

Common character codes include 9 (tab), 10 (linefeed), 13 (carriage return), 32 (space), 48-57 (the digits 0-9), 65-90 (uppercase A-Z), and 97-122 (lowercase a-z).

## Related

[Transform](Transform.htm), [Ord()](Ord.htm), [Asc()](Asc.htm)

## Examples

Reports the string corresponding to the character code 116.

```
MsgBox % Chr(116) <em>; Reports "t".</em>
```

