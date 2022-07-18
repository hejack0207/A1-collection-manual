# Enumerator Object [AHK\_L 49+]

Allows items in a collection to be enumerated.

## Table of Contents

- [Methods](#Methods):

  - [Next](#Next): Retrieves the next item or items in an enumeration.

## Methods

### Next

Retrieves the next item or items in an enumeration.

```
Boolean := Enum.<span class="func">Next</span>(OutputVar1 <span class="optional">, OutputVar2, ...</span>)
```

OutputVar1, OutputVar2Receives an implementation-specific value....Additional parameters, if supported.

This method returns 1 (true) if successful or 0 (false) if there were no items remaining.

Enumerators returned by [ObjNewEnum()](Object.htm#NewEnum) are called once for each key-value pair, and allow up to two parameters:

- OutputVar1: Receives the**key** in a key-value pair.
- OutputVar2: Receives the**value** associated with _OutputVar1_.

Key-value pairs are returned in an implementation-defined order. That is, they are typically not returned in the same order that they were assigned. Existing key-value pairs may be modified during enumeration, but inserting or removing keys may cause some items to be enumerated multiple times or not at all.

Related: [For-loop](../commands/For.htm), [Object.NewEnum()](Object.htm#NewEnum)

Examples:

```
<em>; Create some sample data.</em>
obj := Object("red", 0xFF0000, "blue", 0x0000FF, "green", 0x00FF00)

<em>; Enumerate!</em>
enum := obj._NewEnum()
While enum[k, v]
    t .= k "=" v "`n"
MsgBox % t

<em>; Requires <span class="ver">[AHK_L 59+]</span></em>
For k, v in obj
    s .= k "=" v "`n"
MsgBox % s

```

