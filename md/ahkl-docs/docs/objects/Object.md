# Object

AutoHotkey's basic object datatype is an associative array with features which allow its behaviour to be [customized](../Objects.htm#Custom_Objects). By default, all objects created by `{}`, `[]`, `Object()` and `Array()` support the following methods, properties and functions.

## Table of Contents

- [Methods](#Methods):

  - [InsertAt](#InsertAt): Inserts one or more values at a given position within a linear array.
  - [RemoveAt](#RemoveAt): Removes items from the given position in a linear array.
  - [Push](#Push): Appends values to the end of an array.
  - [Pop](#Pop): Removes and returns the last array element.
  - [Delete](#Delete): Removes key-value pairs from an object.
  - [MinIndex / MaxIndex](#MinMaxIndex): Returns the lowest or highest integer key, if present.
  - [Length](#Length): Returns the length of a linear array.
  - [Count](#Count): Returns the number of key-value pairs present in an object.
  - [SetCapacity](#SetCapacity): Adjusts the capacity of an object or one of its fields.
  - [GetCapacity](#GetCapacity): Returns the current capacity of an object or one of its fields.
  - [GetAddress](#GetAddress): Returns the current address of a field's string buffer, if it has one.
  - [\_NewEnum](#NewEnum): Returns a new enumerator to enumerate an object's key-value pairs.
  - [HasKey](#HasKey): Returns true if the specified key is associated with a value within an object.
  - [Clone](#Clone): Returns a shallow copy of an object.
  - [Insert](#Insert "Deprecated. Use InsertAt, Push, ObjRawSet or a simple assignment instead.") (deprecated): Inserts key-value pairs into an object.
  - [Remove](#Remove "Deprecated. Use RemoveAt, Delete or Pop instead.") (deprecated): Removes key-value pairs from an object.
- [Properties](#Properties):

  - [Base](#Base): Retrieves or sets an object's base object.
- [Functions](#Functions):

  - [ObjRawGet](#RawGet): Retrieves the value associated with a given key within an object.
  - [ObjRawSet](#RawSet): Stores or overwrites a key-value pair in an object.
  - [ObjGetBase](#GetBase): Returns an object's base object.
  - [ObjSetBase](#SetBase): Sets an object's base object.
- [Remarks](#Remarks)

## Methods

### InsertAt [v1.1.21+]

Inserts one or more values at a given position within a linear array.

```
Object.<span class="func">InsertAt</span>(Pos, Value1 <span class="optional">, Value2, ... Value<i>N</i></span>)
```

Pos

The position to insert _Value1_ at. Subsequent values are inserted at Pos+1, Pos+2, etc.

Value1 ...

One or more values to insert. To insert an array of values, pass `<a href="../Functions.htm#VariadicCall" data-index="27">theArray*</a>` as the last parameter.

InsertAt is the counterpart of [RemoveAt](#RemoveAt).

As Objects are associative arrays, _Pos_ is also the integer key which will be associated with _Value1_. Any items previously at or to the right of _Pos_ are shifted to the right by the exact number of value parameters, even if some values are missing (i.e. the object is a sparse array). For example:

```
x := []
x.InsertAt(1, "A", "B") <em>; =>  ["A", "B"]</em>
x.InsertAt(2, "C")      <em>; =>  ["A", "C", "B"]</em>

<em>; Sparse/unassigned elements are preserved:</em>
x := ["A", , "C"]
x.InsertAt(2, "B")      <em>; =>  ["A", "B",    , "C"]</em>

x := ["C"]
x.InsertAt(1, , "B")    <em>; =>  [   , "B", "C"]</em>
```

InsertAt should be used only when the object's integer keys represent positions in a linear array. If the object contains arbitrary integer keys such as IDs or handles, InsertAt is likely to cause unwanted side-effects. For example:

```
x := [], handleX := 0x4321, handleY := 0x1234
x.InsertAt(handleX, "A")
MsgBox % x[handleX]  <em>; A - okay</em>
x.InsertAt(handleY, "B")
MsgBox % x[handleX]  <em>; Empty</em>
MsgBox % x[handleX+1]  <em>; This is the new "position" of "A"</em>
```

InsertAt does not affect string or object keys, so can be safely used with objects containing mixed key types.

### RemoveAt [v1.1.21+]

Removes items from the given position in a linear array.

```
Object.<span class="func">RemoveAt</span>(Pos <span class="optional">, Length</span>)
```

Pos

The position of the value or values to remove.

Length

The length of the range of values to remove. Items from `Pos` to `Pos+Length-1` are removed. If omitted, one item is removed.

If _Length_ is omitted, the value removed from _Pos_ is returned (blank if none). Otherwise the return value is the number of removed items which had values, which can differ from _Length_ in a sparse array, but is always between 0 and _Length_ (inclusive).

RemoveAt is the counterpart of [InsertAt](#InsertAt).

The remaining items to the right of _Pos_ are shifted to the left by _Length_ (or 1 if omitted), even if some items in the removed range did not have values. For example:

```
x := ["A", "B"]
MsgBox % x.RemoveAt(1)  <em>; A</em>
MsgBox % x[1]           <em>; B</em>

x := ["A", , "C"]
MsgBox % x.RemoveAt(1, 2)  <em>; 1</em>
MsgBox % x[1]              <em>; C</em>
```

RemoveAt should be used only when the object's integer keys represent positions in a linear array. If the object contains arbitrary integer keys such as IDs or handles, RemoveAt is likely to cause unwanted side-effects. For example:

```
x := {0x4321: "A", 0x1234: "B"}
MsgBox % x.RemoveAt(0x1234) <em>; B</em>
MsgBox % x[0x4321]          <em>; Empty</em>
MsgBox % x[0x4321-1]        <em>; A</em>
```

RemoveAt does not affect string or object keys, so can be safely used with objects containing mixed key types.

### Push [v1.1.21+]

Appends values to the end of an array.

```
Object.<span class="func">Push</span>(<span class="optional"> Value, Value2, ..., Value<i>N</i> </span>)
```

Value ...

One or more values to insert. To insert an array of values, pass `<a href="../Functions.htm#VariadicCall" data-index="30">theArray*</a>` as the last parameter.

Returns the position of the last inserted value. Can be negative if the array only contained elements at negative indices.

The first value is inserted at position 1 if the array is empty or contains only string or object keys.

Otherwise, the first value is inserted at `Object.MaxIndex() + 1`, even if that position is negative or zero. If this is undesired and the object can contain negative keys, `Object.InsertAt(Object.Length() + 1, ...)` can be used intead.

### Pop [v1.1.21+]

Removes and returns the last array element.

```
Value := Object.<span class="func">Pop</span>()
```

If there are no array elements, the return value is an empty string. Otherwise, it is equivalent to the following:

```
Value := Object.RemoveAt(Object.Length())
```

### Delete [v1.1.21+]

Removes key-value pairs from an object.

```
Object.<span class="func">Delete</span>(Key)
Object.<span class="func">Delete</span>(FirstKey, LastKey)

```

Key

Any single key.

FirstKey, LastKey

Any valid range of integer or string keys, where _FirstKey_ <= _LastKey_. Both keys must be the same type.

If there is exactly one parameter, the removed value is returned (blank if none). Otherwise the return value is the number of matching keys which were found and removed.

Unlike [RemoveAt](#RemoveAt), Delete does not affect any of the key-value pairs that it does not remove. For example:

```
x := ["A", "B"]
MsgBox % x.RemoveAt(1)  <em>; A</em>
MsgBox % x[1]           <em>; B</em>

x := ["A", "B"]
MsgBox % x.Delete(1)    <em>; A</em>
MsgBox % x[1]           <em>; Empty</em>
```

### MinIndex / MaxIndex [AHK\_L 31+]

Returns the lowest or highest integer key, if present.

```
MinIndex := Object.<span class="func">MinIndex</span>()
MaxIndex := Object.<span class="func">MaxIndex</span>()

```

If no integer keys are present, an empty string is returned.

### Length [v1.1.21+]

Returns the length of a linear array.

```
Length := Object.<span class="func">Length</span>()
```

This method returns the length of a linear array beginning at position 1; that is, the highest positive integer key contained by the object, or 0 if there aren't any.

```
MsgBox % ["A", "B", "C"].Length()  <em>;  3</em>
MsgBox % ["A",    , "C"].Length()  <em>;  3</em>
MsgBox % {-10: 0, 10: 0}.Length()  <em>; 10</em>
MsgBox % {-10: 0, -1: 0}.Length()  <em>;  0</em>

```

### Count [v1.1.29+]

Returns the number of key-value pairs present in an object.

```
Count := Object.<span class="func">Count</span>()
```

Examples:

```
MsgBox % {A: 1, Z: 26}.Count()    <em>;  2</em>
MsgBox % ["A", "B", "C"].Count()  <em>;  3</em>
MsgBox % ["A",    , "C"].Count()  <em>;  2</em>

```

### SetCapacity [AHK\_L 31+]

Adjusts the capacity of an object or one of its fields.

```
Object.<span class="func">SetCapacity</span>(MaxItems)
Object.<span class="func">SetCapacity</span>(Key, ByteSize)

```

MaxItems

The maximum number of key-value pairs the object should be able to contain before it must be automatically expanded. If less than the current number of key-value pairs, that number is used instead, and any unused space is freed.

Key

Any valid key.

ByteSize

The new size in bytes of the field's string buffer, excluding the null-terminator. If the field does not exist, it is created. If _ByteSize_ is zero, the buffer is freed but the empty field is not removed. If _ByteSize_ is less than the current size, excess data is truncated; otherwise all existing data is preserved.

Returns the new capacity if successful, otherwise an empty string.

### GetCapacity [AHK\_L 31+]

Returns the current capacity of an object or one of its fields.

```
MaxItems := Object.<span class="func">GetCapacity</span>()
ByteSize := Object.<span class="func">GetCapacity</span>(Key)

```

If the field does not exist or does not contain a string, an empty string is returned.

### GetAddress [AHK\_L 31+]

Returns the current address of a field's string buffer, if it has one.

```
Ptr := Object.<span class="func">GetAddress</span>(Key)
```

### NewEnum [AHK\_L 49+]

Returns a new [enumerator](Enumerator.htm) to enumerate an object's key-value pairs.

```
Enum := Object._<span class="func">NewEnum</span>()
```

This method is usually not called directly, but by the [for-loop](../commands/For.htm).

### HasKey [AHK\_L 53+]

Returns true if the specified key is associated with a value (even "") within an object, otherwise false.

```
Object.<span class="func">HasKey</span>(Key)
```

### Clone [AHK\_L 60+]

Returns a shallow copy of an object.

```
Clone := Object.<span class="func">Clone</span>()
```

### Insert [AHK\_L 31+]

**Deprecated:** Insert is not recommended for use in new scripts. Use [InsertAt](#InsertAt), [Push](#Push), [ObjRawSet](#RawSet) or a simple assignment instead.

Inserts key-value pairs into the object, automatically adjusting existing keys if given an integer key.

```
Object.<span class="func">Insert</span>(Pos, Value1 <span class="optional">, Value2, ... Value<i>N</i> </span>)
Object.<span class="func">Insert</span>(Value)
Object.<span class="func">Insert</span>(StringOrObjectKey, Value)

```

The behaviour of Insert depends on the number and type of its parameters:

- If there are multiple parameters and the first parameter is an integer, Insert behaves like[InsertAt](#InsertAt).
- If there are multiple parameters and the first parameter is not an integer, Insert behaves like[ObjRawSet](#RawSet).
- If there is only one parameter, Insert behaves like[Push](#Push).

Insert returns _true_. In [v1.1.21] and later, an exception is thrown if a memory allocation fails. Earlier versions returned an empty string in that case.

### Remove [AHK\_L 31+]

**Deprecated:** Remove is not recommended for use in new scripts. Use [RemoveAt](#RemoveAt), [Delete](#Delete) or [Pop](#Pop) instead.

Removes key-value pairs from an object.

```
Object.<span class="func">Remove</span>(FirstKey, LastKey)
```

The behaviour of Remove depends on the number and type of parameters:

- `Object.Remove(Integer)` behaves like `Object.<a href="#RemoveAt" data-index="43">RemoveAt</a>(Integer)`.
- `Object.Remove(Integer, "")` behaves like `Object.<a href="#Delete" data-index="44">Delete</a>(Integer)`.
- `Object.Remove(Integer1, Integer2)` behaves like `Object.<a href="#RemoveAt" data-index="45">RemoveAt</a>(Integer1, Integer2 - Integer1 + 1)`.
- `Object.Remove()` behaves like `Object.<a href="#Pop" data-index="46">Pop</a>()`.
- Any other valid combination of parameters behaves like[Delete](#Delete).

## Properties

### Base

Retrieves or sets an object's [base object](../Objects.htm#Custom_Objects).

```
BaseObject := Object.Base
```

```
Object.Base := BaseObject
```

_BaseObject_ must be an object or an empty string.

Properties and methods defined by a base object are accessible only while that base object is in use. Therefore, changing _Object_'s base also changes the set of available properties and methods.

See also: [ObjGetBase()](#GetBase), [ObjSetBase()](#SetBase)

## Functions

### ObjRawGet [v1.1.29+]

Retrieves the value associated with a given key within an object.

```
Value := <span class="func">ObjRawGet</span>(Object, Key)
```

If _Object_ does not contain _Key_, the return value is an empty string. No [meta-functions](../Objects.htm#Meta_Functions) or [property functions](../Objects.htm#Custom_Classes_property) are called. The content of _Object_'s base objects are not considered, and since [base](#Base) itself is a property and not a key-value pair [by default](../Objects.htm#base-key), it is typically not returned.

An exception is thrown if _Object_ is of an incorrect type.

### ObjRawSet [v1.1.21+]

Stores or overwrites a key-value pair in an object.

```
<span class="func">ObjRawSet</span>(Object, Key, Value)
```

This function is provided to allow scripts to bypass the \_\_Set [meta-function](../Objects.htm#Meta_Functions) and [properties](../Objects.htm#Custom_Classes_property). If that isn't required, a normal assignment should be used instead. For example: `Object[Key] := Value`

Since the purpose is to bypass meta-functions, this is a function only, not a method. Calling a built-in method generally causes the \_\_Call meta-function to be called.

An exception is thrown if _Object_ is of an incorrect type.

### ObjGetBase [v1.1.29+]

Returns an object's [base object](../Objects.htm#Custom_Objects).

```
BaseObject := <span class="func">ObjGetBase</span>(Object)
```

No [meta-functions](../Objects.htm#Meta_Functions) are called. The object's base is returned even if the key "base" has been stored in the object (such as with [ObjRawSet](#RawSet) or [SetCapacity](#SetCapacity)). An empty string is returned if the object has no base.

An exception is thrown if _Object_ is of an incorrect type.

See also: [Base property](#Base)

### ObjSetBase [v1.1.29+]

Sets an object's [base object](../Objects.htm#Custom_Objects).

```
<span class="func">ObjSetBase</span>(Object, BaseObject)
```

No [meta-functions](../Objects.htm#Meta_Functions) are called. The object's base is set even if the key "base" has been stored in the object (such as with [ObjRawSet](#RawSet) or [SetCapacity](#SetCapacity)). An empty string is returned if the object has no base.

An exception is thrown if _Object_ is of an incorrect type or if _BaseObject_ is not an object or empty string.

See also: [Base property](#Base)

## Remarks

Each method also has an equivalent function, which can be used to bypass any [custom behaviour](../Objects.htm#Custom_Objects) implemented by the object -- it is recommended that these functions only be used for that purpose. To call one, prefix the method name with "Obj" and pass the target object as the first parameter. For example:

```
array := [1, 2, 3]
MsgBox % ObjMaxIndex(array) " = " array.MaxIndex()
```

If an Obj method-function is called with an object or value of the wrong type, it returns an empty string. Standalone functions such as ObjRawSet throw an exception.

