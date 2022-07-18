# Trim() / LTrim() / RTrim() [AHK\_L 31+]

Trims characters from the beginning and/or end of a string.

```
Result :=  <span class="func">Trim</span>(String, OmitChars := " `t")
Result := <span class="func">LTrim</span>(String, OmitChars := " `t")
Result := <span class="func">RTrim</span>(String, OmitChars := " `t")

```

## Parameters

String

Any string value or variable. Numbers are not supported.

OmitChars

An optional list of characters (case sensitive) to exclude from the beginning and/or end of _String_. If omitted, spaces and tabs will be removed.

## Examples

Trims all spaces from the left and right side of a string.

```
text := "  text  "
MsgBox % "No trim:`t '" text "'"
    . "`nTrim:`t '" Trim(text) "'"
    . "`nLTrim:`t '" LTrim(text) "'"
    . "`nRTrim:`t '" RTrim(text) "'"
```

Trims all zeros from the left side of a string.

```
MsgBox % LTrim("00000123", "0")
```

