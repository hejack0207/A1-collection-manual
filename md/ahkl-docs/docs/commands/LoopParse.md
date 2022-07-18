# Loop (parse a string)

Retrieves substrings (fields) from a string, one at a time.

```
<span class="func">Loop, Parse</span>, InputVar <span class="optional">, Delimiters, OmitChars</span>
```

## Parameters

Parse

This parameter must be the word PARSE, and unlike other loop types, it must not be a variable reference that resolves to the word PARSE.

InputVar

The name of the variable whose contents will be analyzed. Do not enclose the name in percent signs unless you want the _contents_ of the variable to be used as the name.

[v1.1.21+]: This parameter can be an `% <a href="../Variables.htm#Expressions" data-index="1">expression</a>`, but the percent-space prefix must be used.

Delimiters

If this parameter is blank or omitted, each character of _InputVar_ will be treated as a separate substring.

If this parameter is **CSV**, _InputVar_ will be parsed in standard comma separated value format. Here is an example of a CSV line produced by MS Excel:

```
"first field",SecondField,"the word ""special"" is quoted literally",,"last field, has literal comma"
```

Otherwise, _Delimiters_ contains one or more characters (case sensitive), each of which is used to determine where the boundaries between substrings occur in _InputVar_.

Delimiter characters are not considered to be part of the substrings themselves. In addition, if there is nothing between a pair of delimiters within _InputVar_, the corresponding substring will be empty.

For example: `` `,`` (an escaped comma) would divide the string based on every occurrence of a comma. Similarly, %A\_Tab%%A\_Space% would start a new substring every time a space or tab is encountered in _InputVar_.

To use a string as a delimiter rather than a character, first use [StrReplace()](StrReplace.htm) or [StringReplace](StringReplace.htm) to replace all occurrences of the string with a single character that is never used literally in the text, e.g. one of these special characters: ¢¤¥¦§©ª«®µ¶. Consider this example, which uses the string <br> as a delimiter:

```
StringReplace, NewHTML, HTMLString, <br>, ¢, All
Loop, parse, NewHTML, ¢ <em>; Parse the string based on the cent symbol.</em>
{
...
}
```

OmitChars

An optional list of characters (case sensitive) to exclude from the beginning and end of each substring. For example, if _OmitChars_ is %A\_Space%%A\_Tab%, spaces and tabs will be removed from the beginning and end (but not the middle) of every retrieved substring.

If _Delimiters_ is blank, _OmitChars_ indicates which characters should be excluded from consideration (the loop will not see them).

Unlike the last parameter of most other commands, commas in _OmitChars_ must be escaped (\`,).

## Remarks

A string parsing loop is useful when you want to operate on each field contained in a string, one at a time. Parsing loops use less memory than [StrSplit()](StrSplit.htm) or [StringSplit](StringSplit.htm) (since it creates a permanent [array](../misc/Arrays.htm#object-based) or [pseudo-array](../misc/Arrays.htm#pseudo)) and in most cases they are easier to use.

The built-in variable **A\_LoopField** exists within any parsing loop. It contains the contents of the current substring (field) from _InputVar_. If an inner parsing loop is enclosed by an outer parsing loop, the innermost loop's field will take precedence.

Although there is no built-in variable "A\_LoopDelimiter", the example at the very bottom of this page demonstrates how to detect which delimiter was encountered for each field.

There is no restriction on the size of _InputVar_ or its fields. In addition, if _InputVar_'s contents change during the execution of the loop, the loop will not "see" the changes because it is operating on a temporary copy of the original contents.

To arrange the fields in a different order prior to parsing, use the [Sort](Sort.htm) command.

See [Loop](Loop.htm) for information about [Blocks](Block.htm), [Break](Break.htm), [Continue](Continue.htm), and the A\_Index variable (which exists in every type of loop).

## Related

[StrSplit()](StrSplit.htm), [file-reading loop](LoopReadFile.htm), [Loop](Loop.htm), [Break](Break.htm), [Continue](Continue.htm), [Blocks](Block.htm), [Sort](Sort.htm), [FileSetAttrib](FileSetAttrib.htm), [FileSetTime](FileSetTime.htm), [StringSplit](StringSplit.htm)

## Examples

Parses a comma-separated string.

```
Colors := "red,green,blue"
Loop, parse, Colors, `,
{
    MsgBox, Color number %A_Index% is %A_LoopField%.
}
```

Reads the lines inside a variable, one by one (similar to a [file-reading](LoopReadFile.htm) loop). A file can be loaded into a variable via [FileRead](FileRead.htm).

```
Loop, parse, FileContents, `n, `r  <em>; Specifying `n prior to `r allows both Windows and Unix files to be parsed.</em>
{
    MsgBox, 4, , Line number %A_Index% is %A_LoopField%.`n`nContinue?
    IfMsgBox, No, break
}
```

This is the same as the example above except that it's for the clipboard. It's useful whenever the clipboard contains files, such as those copied from an open Explorer window (the program automatically converts such files to their file names).

```
Loop, parse, clipboard, `n, `r
{
    MsgBox, 4, , File number %A_Index% is %A_LoopField%.`n`nContinue?
    IfMsgBox, No, break
}
```

Parses a comma separated value (CSV) file.

```
Loop, read, C:\Database Export.csv
{
    LineNumber := A_Index
    Loop, parse, A_LoopReadLine, CSV
    {
        MsgBox, 4, , Field %LineNumber%-%A_Index% is:`n%A_LoopField%`n`nContinue?
        IfMsgBox, No
            return
    }
}
```

Determines which delimiter was encountered.

```
<em>; Initialize string to search.</em>
Colors := "red,green|blue;yellow|cyan,magenta"
<em>; Initialize counter to keep track of our position in the string.</em>
Position := 0

Loop, Parse, Colors, `,|;
{
    <em>; Calculate the position of the delimiter at the end of this field.</em>
    Position += StrLen(A_LoopField) + 1
    <em>; Retrieve the delimiter found by the parsing loop.</em>
    Delimiter := SubStr(Colors, Position, 1)

    MsgBox Field: %A_LoopField%`nDelimiter: %Delimiter%
}
```

