# \#EscapeChar

Changes the script's escape character (e.g. accent vs. backslash).

**Deprecated:** This directive is not recommended for use in new scripts. Use the default escape character (accent/backtick) instead.

```
<span class="func">#EscapeChar</span> NewChar
```

## Parameters

NewChar

Specify a single character.

## Remarks

The escape character is used to indicate that the character immediately following it should be interpreted differently than it normally would.

The default escape character is accent/backtick (\`), which is at the upper left corner of most English keyboards. Using this character rather than backslash avoids the need for double blackslashes in file paths.

See [Escape Sequences](../misc/EscapeChar.htm) for a complete list of sequences and its results (e.g. `` `n`` would produce a linefeed character).

Like other directives, #EscapeChar cannot be executed conditionally.

## Related

The following rarely used directives also exist; their usage is shown in these examples:

```
#DerefChar #  <em id="DerefChar">; Change it from its normal default, which is %.</em>
#Delimiter /  <em id="Delimiter">; Change it from its normal default, which is comma.</em>
```

**Deprecated:** These directives are not recommended for use in new scripts. Use the default dereference character (percent) and the default delimiter character (comma) instead.

## Examples

Changes the default escape character (\`) to backslash.

```
#EscapeChar \
```

