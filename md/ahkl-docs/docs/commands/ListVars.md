# ListVars

Displays the script's [variables](../Variables.htm): their names and current contents.

```
<span class="func">ListVars</span>
```

## Remarks

This command is equivalent to selecting the "View->Variables" menu item in the main window. It can help you [debug a script](../Scripts.htm#debug).

For each variable in the list, the variable's name and contents are shown, along with other information depending on what the variable contains. Each item is terminated with a carriage return and newline ( `` `r`n``), but may span multiple lines if the variable contains `` `r`n``.

List items may take the following forms (where words in _italics_ are placeholders):

```
<i>VarName</i>[<i>Length</i> of <i>Capacity</i>]: <i>String</i>
<em>; <span class="ver">[v1.1.26+]</span></em>
<i>VarName</i>: <i>TypeName</i> object {<i>Info</i>}
<em>; Prior to <span class="ver">[v1.1.26]</span>:</em>
<i>VarName</i>[Object]: <i>Address</i>
<i>VarName</i>[Object]: <i>Address</i> <= ComObject(<i>VarType</i>, <i>Value</i>)

```

_Capacity_ is the variable's current [capacity](VarSetCapacity.htm) measured in characters, not bytes.

_String_ is the first 60 characters of the variable's contents.

_Info_ depends on the type of object, but is currently very limited.

If this command is used inside a [function](../Functions.htm), the function's [local variables](../Functions.htm#Local) will be listed first (above the script's global variables).

Known limitation: If a [function](../Functions.htm) (or the list of global variables itself) contains more than 10,000 variables, this command might not show them in exact alphabetical order; that is, some might be missing from the display.

## Related

[KeyHistory](KeyHistory.htm), [ListHotkeys](ListHotkeys.htm), [ListLines](ListLines.htm)

The [DebugVars](https://github.com/Lexikos/DebugVars.ahk#debugvars) script can be used to inspect and change the contents of variables and objects.

## Examples

Displays information about the script's variables.

```
ListVars
```

