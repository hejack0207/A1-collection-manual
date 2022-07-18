# Ord() [v1.1.21+]

Returns the ordinal value (numeric character code) of the first character in the specified string.

```
Number := <span class="func">Ord</span>(String)
```

## Parameters

String

The string whose ordinal value is retrieved.

## Return Value

This function returns the ordinal value of _String_, or 0 if _String_ is empty. If _String_ begins with a Unicode supplementary character, this function returns the corresponding Unicode character code (a number between 0x10000 and 0x10FFFF). Otherwise it returns a value in the range 0 to 255 (for ANSI) or 0 to 0xFFFF (for Unicode). See [Unicode vs ANSI](../Compat.htm#Format) for details.

## Remarks

Apart from the Unicode supplementary character detection, this function is identical to [Asc()](Asc.htm).

## Related

[Asc()](Asc.htm), [Chr()](Chr.htm)

## Examples

Both message boxes below show 116, because only the first character is considered.

```
MsgBox, % Ord("t")
MsgBox, % Ord("test")
```

