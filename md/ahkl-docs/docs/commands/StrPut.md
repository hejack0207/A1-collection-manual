# StrPut() [AHK\_L 46+]

Copies a string to a memory address, optionally converting it to a given code page.

```
<span class="func">StrPut</span>(String <span class="optional">, Encoding := <i>None</i></span>)
<span class="func">StrPut</span>(String, Target <span class="optional">, Length</span> <span class="optional">, Encoding := <i>None</i></span>)

```

## Parameters

String

Any string. If a number is given, it is automatically converted to a string.

_String_ is assumed to be in the [native encoding](../Concepts.htm#string-encoding).

Target

The memory address to which the string will be written.

**Note:** If conversion between code pages is necessary, the required buffer size may differ from the size of the source string. For such cases, call StrPut with two parameters to calculate the required size.

Length

The maximum number of [characters](../Concepts.htm#character) to write, including the [null-terminator](../Concepts.htm#null-termination) if required.

If _Length_ is zero or less than the projected length after conversion (or the length of the source string if conversion is not required), zero characters are written.

_Length_ must not be omitted unless the buffer size is known to be sufficient, such as if the buffer was allocated based on a previous call to StrPut with the same _Source_ and _Encoding_.

**Note:** When _Encoding_ is specified, _Length_ should be the size of the buffer (in characters), **not** the length of _String_ or a substring, as conversion may increase its length.

**Note:** _Length_ and StrPut's return value are measured in characters, whereas buffer sizes are usually measured in bytes.

Encoding

The target encoding; for example, `"UTF-8"`, `"UTF-16"` or `"CP936"`. For numeric identifiers, the prefix "CP" can be omitted only if _Length_ is specified. Specify an empty string or `"CP0"` to use the system default ANSI code page.

## Return Value

This function returns the number of [characters](../Concepts.htm#character) written. If no _Target_ was given, it returns the required buffer size in characters. If _Length_ is exactly the length of the converted string, the string is not [null-terminated](../Concepts.htm#null-termination); otherwise the returned size includes the null-terminator.

## Error Handling

An empty string is returned if invalid parameters are detected, or if the conversion cannot be performed. If the final number of characters would exceed _Length_, the return value is zero.

## Remarks

Note that the _String_ parameter is always assumed to use the [native encoding](../Concepts.htm#string-encoding) of the current executable, whereas _Encoding_ specifies the encoding of the string written to the given _Target_. If no _Encoding_ is specified, the string is simply measured or copied without any conversion taking place.

## Related

[String Encoding](../Concepts.htm#string-encoding), [StrGet()](StrGet.htm), [Script Compatibility](../Compat.htm), [FileEncoding](FileEncoding.htm), [DllCall()](DllCall.htm), [VarSetCapacity()](VarSetCapacity.htm)

## Examples

Either _Length_ or _Encoding_ may be specified directly after _Target_, but in those cases _Encoding_ must be non-numeric.

```
StrPut(str, address, "cp0")  <em>; Code page 0, unspecified buffer size</em>
StrPut(str, address, n, 0)   <em>; Maximum n chars, code page 0</em>
StrPut(str, address, 0)      <em>; Unsupported (maximum 0 chars)</em>

```

StrPut may be called once to calculate the required buffer size for a string in a particular encoding, then again to encode and write the string into the buffer. The process can be simplified by adding this function to your [library](../Functions.htm#lib).

```
StrPutVar(string, ByRef var, encoding)
{
    <em>; Ensure capacity.</em>
    VarSetCapacity( var, StrPut(string, encoding)
        <em>; StrPut returns char count, but VarSetCapacity needs bytes.</em>
        * ((encoding="utf-16"||encoding="cp1200") ? 2 : 1) )
    <em>; Copy or convert the string.</em>
    return StrPut(string, &var, encoding)
}
```

