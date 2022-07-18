# StrGet() [AHK\_L 46+]

Copies a string from a memory address, optionally converting it from a given code page.

```
String := <span class="func">StrGet</span>(Source <span class="optional">, Length</span> <span class="optional">, Encoding := <i>None</i></span>)
```

## Parameters

Source

The memory address of the string.

The string is not required to be [null-terminated](../Concepts.htm#null-termination) if the _Length_ parameter is specified.

Length

The length of the string, in [characters](../Concepts.htm#character). This can be omitted if the string is [null-terminated](../Concepts.htm#null-termination).

**Note:** Omitting _Length_ when the string is not null-terminated may cause an access violation which terminates the program, or some other undesired result. Specifying an incorrect length may produce unexpected behaviour.

**Note:** Embedded null characters are unsupported and will generally cause truncation of the string.

Encoding

The source encoding; for example, `"UTF-8"`, `"UTF-16"` or `"CP936"`. For numeric identifiers, the prefix "CP" can be omitted only if _Length_ is specified. Specify an empty string or `"CP0"` to use the system default ANSI code page.

## Return Value

This function returns the copied or converted string. If the source encoding was specified correctly, the return value always uses the [native encoding](../Concepts.htm#string-encoding). It is always [null-terminated](../Concepts.htm#null-termination), but the null-terminator is not included in the return value's [length](StrLen.htm).

## Error Handling

An empty string is returned if invalid parameters are detected, or if the conversion cannot be performed.

## Remarks

Note that the return value is always in the [native encoding](../Concepts.htm#string-encoding) of the current executable, whereas _Encoding_ specifies how to interpret the string read from the given _Source_. If no _Encoding_ is specified, the string is simply copied without any conversion taking place.

In other words, StrGet is used to retrieve text from a memory address, or convert it to a format the script can understand.

If conversion between code pages is necessary, the length of the return value may differ from the length of the source string.

## Related

[String Encoding](../Concepts.htm#string-encoding), [StrPut()](StrPut.htm), [Script Compatibility](../Compat.htm), [FileEncoding](FileEncoding.htm), [DllCall()](DllCall.htm), [VarSetCapacity()](VarSetCapacity.htm)

## Examples

Either _Length_ or _Encoding_ may be specified directly after _Source_, but in those cases _Encoding_ must be non-numeric.

```
str := StrGet(address, "cp0")  <em>; Code page 0, unspecified length</em>
str := StrGet(address, n, 0)   <em>; Maximum n chars, code page 0</em>
str := StrGet(address, 0)      <em>; Maximum 0 chars (always blank)</em>

```

