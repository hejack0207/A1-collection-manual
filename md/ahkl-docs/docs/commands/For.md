# For-loop [AHK\_L 59+]

Repeats a series of commands once for each key-value pair in an object.

```
<span class="func">For</span> Key <span class="optional">, Value</span> in Expression
```

## Parameters

Key

Name of the variable in which to store the key at the beginning of each iteration.

Value

Name of the variable in which to store the value associated with the current key.

Expression

An [expression](../Variables.htm#Expressions) which results in an object, or a variable which contains an object.

## Remarks

_Expression_ is evaluated only once, before the loop begins. If its result is not an object, execution jumps immediately to the line following the loop's body; otherwise, the object's `_NewEnum()` method is called to retrieve an [_enumerator_](../objects/Enumerator.htm) object. At the beginning of each iteration, the enumerator's [Next()](../objects/Enumerator.htm#Next) method is used to retrieve the next key-value pair. If Next() returns zero or an empty string, the loop terminates.

Although not exactly equivalent to a for-loop, the following demonstrates this process:

```
_enum := (<i>Expression</i>)._NewEnum()
if IsObject(_enum)
    while _enum.Next(Key, Value)
    {
        ...
    }

```

Existing key-value pairs may be modified during the loop, but inserting or removing keys may cause some items to be skipped or enumerated multiple times. One workaround is to build a list of keys to remove, then use a second loop to remove the keys after the first loop completes. Note that `<a href="../objects/Object.htm#Remove" data-index="4">Object.Remove</a>(<i>first</i>, <i>last</i>)` can be used to remove a range of keys without looping.

A for-loop is usually followed by a [block](Block.htm), which is a collection of statements that form the _body_ of the loop. However, a loop with only a single statement does not require a block (an "if" and its "else" count as a single statement for this purpose). The One True Brace (OTB) style may optionally be used, which allows the open-brace to appear on the same line rather than underneath. For example: `for x, y in z {`.

As with all loops, [Break](Break.htm), [Continue](Continue.htm) and [A\_Index](../Variables.htm#Index) may be used.

## COM Objects

Since _Key_ and _Value_ are passed directly to the enumerator's Next() method, the values they are assigned depends on what type of object is being enumerated. For COM objects, _Key_ contains the value returned by [IEnumVARIANT::Next()](http://msdn.microsoft.com/en-us/library/ms221369.aspx) and _Value_ contains a number which represents its [variant type](http://msdn.microsoft.com/en-us/library/cc237865.aspx). For example, when used with a [Scripting.Dictionary](http://msdn.microsoft.com/en-us/library/x4k5wbx4.aspx) object, each _Key_ contains a key from the dictionary and _Value_ is typically 8 for strings and 3 for integers. See [ComObjType()](ComObjType.htm) for a list of type codes.

[v1.0.96.00+]: When enumerating a [SafeArray](ComObjArray.htm), _Key_ contains the current element and _Value_ contains its variant type.

## Related

[Enumerator object](../objects/Enumerator.htm), [Object.NewEnum()](../objects/Object.htm#NewEnum), [While-loop](While.htm), [Loop](Loop.htm), [Until](Until.htm), [Break](Break.htm), [Continue](Continue.htm), [Blocks](Block.htm)

## Examples

Lists the key-value pairs of an object.

```
colours := <a href="../Objects.htm#Arrays" data-index="23">Object</a>("red", 0xFF0000, "blue", 0x0000FF, "green", 0x00FF00)
<em>; The above expression could be used directly in place of "colours" below:</em>
for k, v in colours
    s .= k "=" v "`n"
MsgBox % s

```

Lists all open Explorer and Internet Explorer windows, using the [Shell](https://docs.microsoft.com/en-us/windows/win32/shell/shell) object.

```
for window in ComObjCreate("Shell.Application").Windows
    windows .= window.LocationName " :: " window.LocationURL "`n"
MsgBox % windows
```

Class: CEnumerator

Provides a generic enumerator object that can be used for iterating over numeric keys. The array must not be modified during iteration, otherwise the iterated range will be invalid.
It's possible to define a custom MaxIndex() functions for array boundaries. If there are missing array members between 1 and max index, they will be iterated but will have a value of "". This means that real sparse arrays are not supported by this enumerator by design. Source: [Suggestions on documentation improvements](https://www.autohotkey.com/board/topic/2667-suggestions-on-documentation-improvements/?p=531509)

```
<em>/*
Class: CEnumerator

To make an object use this iterator, insert this function in the class definition:

    _NewEnum()
    {
    	return new CEnumerator(this)
    }
*/</em>

<em>; Iterate over the enumerator</em>
For k, v in Test
    MsgBox %k%=%v%

<em>; Test class for demonstrating usage</em>
class Test
{
    static Data := ["abc", "def", "ghi"]

    _NewEnum()
    {
        return new CEnumerator(this.Data)
    }
}

class CEnumerator
{
    __New(Object)
    {
        this.Object := Object
        this.first := true
        <em>; Cache for speed. Useful if custom MaxIndex() functions have poor performance.</em>
        <em>; In return, that means that no key-value pairs may be inserted during iteration or the range will become invalid.</em>
        this.ObjMaxIndex := Object.MaxIndex()
    }

    Next(ByRef key, ByRef value)
    {
        if (this.first)
        {
            this.Remove("first")
            key := 1
        }
        else
            key ++
        if (key <= this.ObjMaxIndex)
            value := this.Object[key]
        else
            key := ""
        return key != ""
    }
}
```

