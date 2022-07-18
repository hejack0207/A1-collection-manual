# Objects

An _object_ in AutoHotkey is an abstract datatype which provides three basic functions:

- GET a value.
- SET a value.
- CALL a method (that is, a function which does something with the target object).

Related topics:

- [Objects](Concepts.htm#objects): General explanation of objects.
- [Object Protocol](Concepts.htm#object-protocol): Specifics about how a script interacts with an object.

**IsObject()** can be used to determine if a value is an object:

```
Result := IsObject(<i>expression</i>)
```

See _Object Types_ in the documentation side bar for a list of standard object types. There are three fundamental types:

- [**Object**](objects/Object.htm): the basic type of all user-defined objects, simple arrays and associative arrays.
- **Built-in objects**, such as [File](objects/File.htm). Built-in objects have a strict set of properties and methods and do not permit new properties or methods to be added.
- **COM wrapper objects**. These typically represent a COM or "Automation" object implementing the [IDispatch interface](https://docs.microsoft.com/windows/desktop/api/oaidl/nn-oaidl-idispatch), but are also used to [wrap values of specific types](commands/ComObjActive.htm) to be passed to COM objects and functions. COM objects are implemented by external libraries, so often differ in behaviour to AutoHotkey objects.

Support for objects requires [AHK\_L 31+], but some features may require a later version.

## Table of Contents

- [Basic Usage](#Usage) \- [Simple Arrays](#Usage_Simple_Arrays), [Associative Arrays](#Usage_Associative_Arrays), [Objects](#Usage_Objects), [Freeing Objects](#Usage_Freeing_Objects), [Remarks](#Usage_Remarks)
- [Extended Usage](#Extended_Usage) \- [Function References](#Function_References), [Arrays of Arrays](#Usage_Arrays_of_Arrays), [Arrays of Functions](#Usage_Arrays_of_Functions)
- [Custom Objects](#Custom_Objects) \- [Prototypes](#Custom_Prototypes), [Classes](#Custom_Classes), [Construction and Destruction](#Custom_NewDelete), [Meta-Functions](#Meta_Functions)
- [Default Base Object](#Default_Base_Object) \- [Automatic Var Init](#Automatic_Var_Init), [Pseudo-Properties](#Pseudo_Properties), [Debugging](#Default__Warn)
- [Implementation](#Implementation) \- [Reference-Counting](#Reference_Counting), [Pointers to Objects](#Implementation_Pointers)

## Basic Usage

### Simple Arrays [v1.1.21+]

Create an array:

```
Array := [Item1, Item2, ..., ItemN]
Array := Array(Item1, Item2, ..., ItemN)
```

Retrieve an item:

```
Value := Array[Index]
```

Assign an item:

```
Array[Index] := Value
```

Insert one or more items at a given index using the [InsertAt](objects/Object.htm#InsertAt) method:

```
Array.InsertAt(Index, Value, Value2, ...)
```

Append one or more items using the [Push](objects/Object.htm#Push) method:

```
Array.Push(Value, Value2, ...)
```

Remove an item using the [RemoveAt](objects/Object.htm#RemoveAt) method:

```
RemovedValue := Array.RemoveAt(Index)
```

Remove the last item using the [Pop](objects/Object.htm#Pop) method:

```
RemovedValue := Array.Pop()
```

If the array is not empty, [MinIndex](objects/Object.htm#MinMaxIndex) and [MaxIndex](objects/Object.htm#MinMaxIndex)/ [Length](objects/Object.htm#Length) return the lowest and highest index currently in use in the array. Since the lowest index is nearly always 1, MaxIndex usually returns the number of items. However, if there are no integer keys, MaxIndex returns an empty string whereas Length returns 0. Looping through an array's contents can be done either by index or with a For-loop. For example:

```
array := ["one", "two", "three"]

<em>; Iterate from 1 to the end of the array:</em>
<a href="commands/Loop.htm" data-index="36">Loop</a> % array.Length()
    MsgBox % array[A_Index]

<em>; Enumerate the array's contents:</em>
<a href="commands/For.htm" data-index="37">For</a> index, value in array
    MsgBox % "Item " index " is '" value "'"

```

### Associative Arrays [v1.1.21+]

An associative array is an object which contains a collection of unique keys and a collection of values, where each key is associated with one value. Keys can be strings, integers or objects, while values can be of any type. An associative array can be created as follows:

```
Array := {KeyA: ValueA, KeyB: ValueB, ..., KeyZ: ValueZ}
Array := Object("KeyA", ValueA, "KeyB", ValueB, ..., "KeyZ", ValueZ)
```

Using the `{key:value}` notation, quote marks are optional for keys which consist only of word characters. Any expression can be used as a key, but to use a variable as a key, it must be enclosed in parentheses. For example, `{(KeyVar): Value}` and `{GetKey(): Value}` are both valid.

Retrieve an item:

```
Value := Array[Key]
```

Assign an item:

```
Array[Key] := Value
```

Remove an item using the [Delete](objects/Object.htm#Delete) method:

```
RemovedValue := Array.Delete(Key)
```

Enumerating items:

```
array := {ten: 10, twenty: 20, thirty: 30}
<a href="commands/For.htm" data-index="39">For</a> key, value in array
    MsgBox %key% = %value%
```

Associative arrays can be sparsely populated - that is, `{1:"a",1000:"b"}` contains only two key-value pairs, not 1000.

In AutoHotkey v1.x, simple arrays and associative arrays are the same thing. However, treating `[]` as a simple linear array helps to keep its role clear, and improves the chance of your script working with a future version of AutoHotkey, which might differentiate between simple arrays and associative arrays.

### Objects [AHK\_L 31+]

For all types of objects, the notation `Object.LiteralKey` can be used to access a property, array element or method, where _LiteralKey_ is an identifier or integer and _Object_ is any expression. Identifiers are unquoted strings which may consist of alphanumeric characters, underscore and, in [v1.1.09+], non-ASCII characters. For example, `match.Pos` is equivalent to `match["Pos"]` while `arr.1` is equivalent to `arr[1]`. There must be no space after the dot.

**Examples:**

Retrieve a property:

```
Value := Object.Property
```

Set a property:

```
Object.Property := Value
```

Call a method:

```
ReturnValue := Object.Method(Parameters)
```

Call a method with a computed method name:

```
ReturnValue := Object[MethodName](Parameters)
```

Some properties of COM objects and user-defined objects can accept parameters:

```
Value := Object.Property[Parameters]
Object.Property[Parameters] := Value
```

**Related:** [Object](objects/Object.htm), [File Object](objects/File.htm), [Func Object](objects/Func.htm), [COM object](commands/ComObjCreate.htm)

**Known limitation:**

- Currently`<span class="dull">x</span>.y[z]<span class="dull">()</span>` is treated as `<span class="dull">x</span>["y", z]<span class="dull">()</span>`, which is not supported. As a workaround, `<span class="red">(</span><span class="dull">x.y</span><span class="red">)</span>[z]()` evaluates `x.y` first, then uses the result as the target of the method call. Note that `x.y[z].Call()` does not have this limitation since it is evaluated the same as `(x.y[z]).Call()`.

### Freeing Objects

Scripts do not free objects explicitly. When the last reference to an object is released, the object is freed automatically. A reference stored in a variable is released automatically when that variable is assigned some other value. For example:

```
obj := {}  <em>; Creates an object.</em>
obj := ""  <em>; Releases the last reference, and therefore frees the object.</em>
```

Similarly, a reference stored in a field of another object is released when that field is assigned some other value or removed from the object. This also applies to arrays, which are actually objects.

```
arr := [{}]  <em>; Creates an array containing an object.</em>
arr[1] := {}  <em>; Creates a second object, implicitly freeing the first object.</em>
arr.RemoveAt(1)  <em>; Removes and frees the second object.</em>
```

Because all references to an object must be released before the object can be freed, objects containing circular references aren't freed automatically. For instance, if `x.child` refers to `y` and `y.parent` refers to `x`, clearing `x` and `y` is not sufficient since the parent object still contains a reference to the child and vice versa. To resolve this situation, remove the circular reference.

```
x := {}, y := {}             <em>; Create two objects.</em>
x.child := y, y.parent := x  <em>; Create a circular reference.</em>

y.parent := ""               <em>; The circular reference must be removed before the objects can be freed.</em>
x := "", y := ""             <em>; Without the above line, this would not free the objects.</em>

```

For more advanced usage and details, see [Reference Counting](#Reference_Counting).

### Remarks

#### Syntax

All types of objects support both array syntax (brackets) and object syntax (dots).

Additionally, object references can themselves be used in expressions:

- When an object reference is compared with some other value using`=`, `==`, `!=` or `<>`, they are considered equal only if both values are references to the same object.
- Objects are always considered_true_ when a boolean value is required, such as in `if obj`, `!obj` or `obj ? x : y`.
- An object's address can be retrieved using the`&` address-of operator. This uniquely identifies the object from the point of its creation to the moment its last reference is [released](#Refs).

If an object is used in any context where an object is not expected, it is treated as an empty string. For example, `MsgBox %object%` shows an empty MsgBox and `object + 1` yields an empty string. Do not rely on this behaviour as it may change.

When a method-call is followed immediately by an assignment operator, it is equivalent to setting a property with parameters. For example, the following are equivalent:

```
obj.item(x) := y
obj.item[x] := y
```

Compound assignments such as `x.y += 1` and `--arr[1]` are supported.

[v1.1.20+]: Parameters can be omitted when getting or setting properties. For example, `x[,2]`. Scripts can utilize this by defining default values for parameters in [properties](#Custom_Classes_property) and [meta-functions](#Meta_Functions). The method name can also be completely omitted, as in `x[](a)`. Scripts can utilize this by defining a default value for the \_\_Call [meta-function](#Meta_Functions)'s first parameter, since it is not otherise supplied with a value. Note that this differs from `x.(a)`, which is equivalent to `x[""](a)`. If the property or method name is omitted when invoking a COM object, its "default member" is invoked.

#### Keys

Some limitations apply to which values can be used as keys in objects created with `[]`, `{}` or the `new` operator:

- Integer keys are stored using the native signed integer type. AutoHotkey 32-bit supports integer keys in the range -2147483648 to 2147483647, and truncates values outside that range. AutoHotkey supports 64-bit integers, but only AutoHotkey 64-bit supports the full range as keys in an object.
- The string format of integer values is not retained. For example, AutoHotkey v1 produces two different strings for`0x10` and `16` (unlike [AutoHotkey v2](https://www.autohotkey.com/v2/)), but `x[0x10]`, `x[16]` and `x[00016]` are equivalent as only the numeric value is used.
- Numeric strings that do not contain a decimal point are converted to pure integers, so are subject to the limitations described above. Numeric strings outside the 64-bit range may produce inconsistent results.
- Quoted literal strings are considered purely non-numeric in v1.x, so`x[1]` and `x["1"]` are _not_ equivalent. Additionally, if a quoted literal string is concatenated with another value (as in `"0x" x`), the result is treated as purely non-numeric. However, this does not apply to variables, so `x[1]` and `x[y:="1"]` are equivalent. This issue will be resolved in [AutoHotkey v2](https://www.autohotkey.com/v2/), so scripts should avoid using quoted numeric literals as keys.
- Floating-point numbers are not supported as keys - instead they are converted to strings. In v1.x, floating-point literals retain their original format whereas pure floating-point numbers (such as the result of`0+1.0` or `Sqrt(y)`) are forced into the current [float format](commands/SetFormat.htm). For consistency and clarity, scripts should avoid using floating-point literals as keys.
- By default, the string key "base" corresponds to the object's[base](objects/Object.htm#Base) property, so cannot be used for storing ordinary values with a normal assignment. However, any property can be overridden by storing a value by some other means, such as `<a href="objects/Object.htm#RawSet" data-index="53">ObjRawSet</a>(Object, "base", "")` or `<a href="objects/Object.htm#SetCapacity" data-index="54">Object.SetCapacity</a>("base", 0)`. Once this is done, the key "base" acts like any other string.
- Although[built-in method](objects/Object.htm) names such as "Length" can be used as keys, storing a value will prevent the corresponding method from being called (unless that value is a reference to the appropriate function, such as _ObjLength_).

## Extended Usage

### Function References [v1.1.00+]

If the variable _func_ contains a function name, the function can be called one of two ways: `%func%()` or `func.()`. However, this requires the function name to be resolved each time, which is inefficient if the function is called more than once. To improve performance, the script can retrieve a reference to the function and store it for later use:

```
Func := Func("MyFunc")
```

A function can be called by reference using the following syntax:

```
RetVal := %Func%(<i>Params</i>)     <em>; Requires <span class="ver">[v1.1.07+]</span></em>
RetVal := Func.Call(<i>Params</i>)  <em>; Requires <span class="ver">[v1.1.19+]</span></em>
RetVal := Func.(<i>Params</i>)      <em>; Not recommended</em>

```

For details about additional properties of function references, see [Func Object](objects/Func.htm).

### Arrays of Arrays

AutoHotkey supports "multi-dimensional" arrays by transparently storing arrays inside other arrays. For example, a table could be represented as an array of rows, where each row is itself an array of columns. In that case, the content of column `y` of row `x` can be set using either of the methods below:

```
table[x][y] := content  <em>; A</em>
table[x, y] := content  <em>; B</em>
```

If `table[x]` does not exist, _A_ and _B_ differ in two ways:

- _A_ fails whereas _B_ automatically creates an object and stores it in `table[x]`.
- If`table`'s [base](#Custom_Objects) defines [meta-functions](#Meta_Functions), they are invoked as follows:


  ```
  table.base.__Get(table, x)<span class="dull">[y] := content</span>   <em>; A</em>
  table.base.__Set(table, x, y, content)     <em>; B</em>
  ```


   Consequently, _B_ allows the object to define custom behaviour for the overall assignment.

Multi-dimensional assignments such as `table[a, b, c, d] := value` are handled as follows:

- If there is only one key remaining, perform the assignment and return. Otherwise:
- Search the object for the first key in the list.
- If a non-object is found, fail.
- If an object is not found, create one and store it.
- Recursively invoke the sub-object, passing the remaining keys and value - repeat from the top.

This behaviour only applies to script-created objects, not more specialized types of objects such as COM objects or COM arrays.

### Arrays of Functions

An array of functions is simply an array containing function names or references. For example:

```
array := [Func("FirstFunc"), Func("SecondFunc")]

<em>; Call each function, passing "foo" as a parameter:</em>
Loop 2
    array[A_Index].Call("foo")

<em>; Call each function, implicitly passing the array itself as a parameter:</em>
Loop 2
    array[A_Index]()

FirstFunc(param) {
    MsgBox % A_ThisFunc ": " (IsObject(param) ? "object" : param)
}
SecondFunc(param) {
    MsgBox % A_ThisFunc ": " (IsObject(param) ? "object" : param)
}
```

For backward-compatibility, the second form will not pass _array_ as a parameter if `array[A_Index]` contains a function name instead of a function reference. However, if `array[A_Index]` is [inherited](#Custom_Objects) from `array.base[A_Index]`, _array_ will be passed as a parameter.

## Custom Objects

Objects created by the script do not need to have any predefined structure. Instead, each object can inherit properties and methods from its `base` object (otherwise known as a "prototype" or "class"). Properties and methods can also be added to (or removed from) an object at any time, and those changes will affect any and all derived objects. For more complex or specialized situations, a base object can override the standard behaviour of any objects derived from it by defining [_meta-functions_](#Meta_Functions).

_Base_ objects are just ordinary objects, and are typically created one of two ways:

```
class baseObject {
    static foo := "bar"
}
<em>; OR</em>
baseObject := {foo: "bar"}
```

To create an object derived from another object, scripts can assign to the [base property](objects/Object.htm#Base) or use the [`new` keyword](#Custom_NewDelete):

```
obj1 := Object(), obj1.base := baseObject
obj2 := {base: baseObject}
obj3 := new baseObject
MsgBox % obj1.foo " " obj2.foo " " obj3.foo
```

It is possible to reassign an object's `base` at any time, effectively replacing all of the properties and methods that the object inherits.

### Prototypes

Prototype or `base` objects are constructed and manipulated the same as any other object. For example, an ordinary object with one property and one method might be constructed like this:

```
<em>; Create an object.</em>
thing := {}
<em>; Store a value.</em>
thing.foo := "bar"
<em>; Create a method by storing a function reference.</em>
thing.test := Func("thing_test")
<em>; Call the method.</em>
thing.test()

thing_test(this) {
    MsgBox % this.foo
}
```

When `thing.test()` is called, _thing_ is automatically inserted at the beginning of the parameter list. However, for backward-compatibility, this does not occur when a function is stored by name (rather than by reference) directly in the object (rather than being inherited from a base object). By convention, the function is named by combining the "type" of object and the method name.

An object is a _prototype_ or _base_ if another object derives from it:

```
other := {}
other.base := thing
other.test()
```

In this case, _other_ inherits _foo_ and _test_ from _thing_. This inheritance is dynamic, so if `thing.foo` is modified, the change will be reflected by `other.foo`. If the script assigns to `other.foo`, the value is stored in _other_ and any further changes to `thing.foo` will have no effect on `other.foo`. When `other.test()` is called, its _this_ parameter contains a reference to _other_ instead of _thing_.

### Classes [v1.1.00+]

At its root, a "class" is a set or category of things having some property or attribute in common. Since a [base](#Custom_Objects) or [prototype](#Custom_Prototypes) object defines properties and behaviour for set of objects, it can also be called a _class_ object. For convenience, base objects can be defined using the "class" keyword as shown below:

```
class ClassName extends BaseClassName
{
    InstanceVar := Expression
    static ClassVar := Expression

    class NestedClass
    {
        ...
    }

    Method()
    {
        ...
    }

    Property[]  <em>; Brackets are optional</em>
    {
        get {
            return ...
        }
        set {
            return ... := value
        }
    }
}

```

When the script is loaded, this constructs an object and stores it in the global (or [in v1.1.05+] [super-global](Functions.htm#SuperGlobal)) variable _ClassName_. To reference this class inside a [force-local](Functions.htm#ForceLocal) function (or an assume-local or assume-static function prior to [v1.1.05]), a declaration such as `global ClassName` is required. If `extends BaseClassName` is present, _BaseClassName_ must be the full name of another class (but as of [v1.1.11], the order that they are defined in does not matter). The full name of each class is stored in `<i>object</i>.__Class`.

Because the class is referenced via a variable, the class name cannot be used to both reference the class and create a separate variable (such as to hold an instance of the class) in the same context. For example, `box := new Box` would replace the class object in _Box_ with an instance of itself. [v1.1.27+]: [#Warn ClassOverwrite](commands/_Warn.htm#ClassOverwrite) enables a warning to be shown at load time for each attempt to overwrite a class.

Within this documentation, the word "class" on its own usually means a class object constructed with the `class` keyword.

Class definitions can contain variable declarations, method definitions and nested class definitions.

#### Instance Variables [v1.1.01+]

An _instance variable_ is one that each instance of the class (that is, each object derived from the class) has its own copy of. They are declared like normal assignments, but the `this.` prefix is omitted (only directly within the class body):

```
InstanceVar := Expression
```

These declarations are evaluated each time a new instance of the class is created with the [new](#Custom_NewDelete) keyword. The method name `__Init` is reserved for this purpose, and should not be used by the script. The [\_\_New()](#Custom_NewDelete) method is called after all such declarations have been evaluated, including those defined in base classes. _Expression_ can access other instance variables and methods via `this`, but all other variable references are assumed to be global.

To access an instance variable (even within a method), always specify the target object; for example, `<b>this</b>.InstanceVar`.

[v1.1.08+]: Declarations like `x.y := z` are also supported, provided that `x` was previously declared in this class. For example, `x := {}, x.y := 42` declares `x` and also initializes `this.x.y`.

#### Static/Class Variables [v1.1.00.01+]

Static/class variables belong to the class itself, but can be inherited by derived objects (including sub-classes). They are declared like instance variables, but using the static keyword:

```
static ClassVar := Expression
```

Static declarations are evaluated only once, before the [auto-execute section](Scripts.htm#auto), in the order they appear in the script. Each declaration stores a value in the class object. Any variable references in _Expression_ are assumed to be global.

To assign to a class variable, always specify the class object; for example, `<b>ClassName</b>.ClassVar := Value`. If an object _x_ is derived from _ClassName_ and _x_ itself does not contain the key "ClassVar", `x.ClassVar` may also be used to dynamically retrieve the value of `ClassName.ClassVar`. However, `x.ClassVar := y` would store the value in _x_, not in _ClassName_.

[v1.1.08+]: Declarations like `static x.y := z` are also supported, provided that `x` was previously declared in this class. For example, `static x := {}, x.y := 42` declares `x` and also initializes `<i>ClassName</i>.x.y`.

#### Nested Classes

Nested class definitions allow a class object to be stored inside another class object rather than a separate global variable. In the example above, `class NestedClass` constructs an object and stores it in `ClassName.NestedClass`. Sub-classes could inherit _NestedClass_ or override it with their own nested class (in which case `new this.NestedClass` could be used to instantiate whichever class is appropriate).

```
class NestedClass
{
    ...
}

```

#### Methods

Method definitions look identical to function definitions. Each method has a hidden parameter named `this`, which typically contains a reference to an object derived from the class. However, it could contain a reference to the class itself or a derived class, depending on how the method was called. Methods are stored [by reference](#Function_References) in the class object.

```
Method()
{
    ...
}

```

Inside a method, the pseudo-keyword `base` can be used to access the super-class versions of methods or properties which are overridden in a derived class. For example, `base.Method()` in the class defined above would call the version of _Method_ which is defined by _BaseClassName_. [Meta-functions](#Meta_Functions) are not called; otherwise, `base.Method()` behaves like `BaseClassName.Method.Call(this)`. That is,

- `base.Method()` always invokes the base of the class where the current method was defined, even if `this` is derived from a _sub-class_ of that class or some other class entirely.
- `base.Method()` implicitly passes `this` as the first (hidden) parameter.

`base` only has special meaning if followed by a dot `.` or brackets `[]`, so code like `obj := base, obj.Method()` will not work. Scripts can disable the special behaviour of _base_ by assigning it a non-empty value; however, this is not recommended. Since the variable _base_ must be empty, performance may be reduced if the script omits [#NoEnv](commands/_NoEnv.htm).

#### Properties [v1.1.16+]

Property definitions allow a method to be executed whenever the script gets or sets a specific key.

```
Property[]
{
    get {
        return ...
    }
    set {
        return ... := value
    }
}
```

_Property_ is simply the name of the property, which will be used to invoke it. For example, `obj.Property` would call _get_ while `obj.Property := value` would call _set_. Within _get_ or _set_, `this` refers to the object being invoked. Within _set_, `value` contains the value being assigned.

Parameters can be passed by enclosing them in square brackets to the right of the property name, both when defining the property and when calling it. Aside from using square brackets, parameters of properties are defined the same way as parameters of methods - optional, ByRef and variadic parameters are supported.

The return value of _get_ or _set_ becomes the result of the sub-expression which invoked the property. For example, `val := obj.Property := 42` stores the return value of _set_ in `val`.

Each class can define one or both halves of a property. If a class overrides a property, it can use `<a href="#Custom_Classes_base" data-index="74">base.Property</a>` to access the property defined by its base class. If _get_ or _set_ is not defined, it can be handled by a base class. If _set_ is not defined and is not handled by a meta-function or base class, assigning a value stores it in the object, effectively disabling the property.

Internally, _get_ and _set_ are two separate methods, so cannot share variables (except by storing them in `this`).

[Meta-functions](#Meta_Functions) provide a broader way of controlling access to properties and methods of an object, but are more complicated and error-prone.

### Construction and Destruction

Whenever a derived object is created with the `new` keyword [requires v1.1.00+], the `__New` method defined by its base object is called. This method can accept parameters, initialize the object and override the result of the `new` operator by returning a value. When an object is destroyed, `__Delete` is called. For example:

```
m1 := new GMem(0, 20)
m2 := {base: GMem}.__New(0, 30)

class GMem
{
    __New(aFlags, aSize)
    {
        this.ptr := DllCall("GlobalAlloc", "UInt", aFlags, "Ptr", aSize, "Ptr")
        if !this.ptr
            return ""
        MsgBox % "New GMem of " aSize " bytes at address " this.ptr "."
        return this  <em>; This line can be omitted when using the 'new' operator.</em>
    }

    __Delete()
    {
        MsgBox % "Delete GMem at address " this.ptr "."
        DllCall("GlobalFree", "Ptr", this.ptr)
    }
}
```

\_\_Delete is not called for any object which has the key "\_\_Class". [Class objects](#Custom_Classes) have this key by default.

If the class has a super-class which defines these methods, `base.__New()` (with parameters as appropriate) and `base.__Delete()` should typically be called. Otherwise, only the most derived definition of the method is called, excluding any definition within the target object itself.

[v1.1.28+]: If an exception or runtime error is thrown while \_\_Delete is executing and is not handled within \_\_Delete, it acts as though \_\_Delete was called from a new [thread](misc/Threads.htm). That is, an error dialog is displayed and \_\_Delete returns, but the thread does not exit (unless it was already exiting). Prior to v1.1.28, unhandled exceptions caused inconsistent behavior.

If the script is directly terminated by any means, including the tray menu, [ExitApp](commands/ExitApp.htm), or [Exit](commands/Exit.htm) (when the script is not [persistent](commands/_Persistent.htm)), any functions which have yet to return do not get the chance to do so. Therefore, any objects referenced by local variables of those functions are not released, so \_\_Delete is not called.

When the script exits, objects contained by global and static variables are released automatically in an arbitrary, implementation-defined order. When \_\_Delete is called during this process, some global or static variables may have already been released, but any references contained by the object itself are still valid. It is therefore best for \_\_Delete to be entirely self-contained, and not rely on any global or static variables.

### Meta-Functions

```
<strong>Method syntax:</strong>
class <i>ClassName</i> {
    __Get([Key, Key2, ...])
    __Set([Key, Key2, ...], Value)
    __Call(Name [, Params...])
}

<strong>Function syntax:</strong>
<i>MyGet</i>(this [, Key, Key2, ...])
<i>MySet</i>(this [, Key, Key2, ...], Value)
<i>MyCall</i>(this, Name [, Params...])

<i>ClassName</i> := { __Get: Func("<i>MyGet</i>"), __Set: Func("<i>MySet</i>"), __Call: Func("<i>MyCall</i>") }

```

Meta-functions define what happens when a key is requested but not found within the target object. For example, if `obj.key` has not been assigned a value, it invokes the _\_\_Get_ meta-function. Similarly, `obj.key := value` invokes _\_\_Set_ and `obj.key()` invokes _\_\_Call_. These meta-functions (or methods) would need to be defined in `obj.base`, `obj.base.base` or such.

Meta-functions are generally defined like methods, but do not follow the same rules (except when called explicitly by the script). They must be defined in a base object; any definition in the target object itself is ignored. Each definition of \_\_Get, \_\_Set and \_\_Call applicable to the target object is called automatically according to the rules below, and should not call `base.__Get(key)` or similar. [\_\_New](#Custom_NewDelete) and [\_\_Delete](#Custom_NewDelete) must be defined in a base object, but otherwise behave like methods.

**Note:** AutoHotkey v2 replaces meta-functions with more conventional methods.

When the script gets, sets or calls a key which does not exist within the target object, the base object is invoked as follows:

- If this base object defines the appropriate meta-function, call it. If the meta-function explicitly`return` s, use the return value as the result of the operation (whatever caused the meta-function to be called) and return control to the script. Otherwise, continue as described below.

  _Set_: If the meta-function handled an assignment, it should return the value which was assigned. This allows assignments to be chained, as in `a.x := b.y := z`. The return value may differ from the original value of `z` (for instance, if restrictions are imposed on which values can be assigned).

- Search for a matching key in the base object's own fields.
- [v1.1.16+]: If a key corresponding to a property is found and it implements _get_ or _set_ (as appropriate), invoke the property and return. If this is a method call, invoke _get_.
- If no key was found, recursively invoke this base object's own base (apply each of these steps to it, starting at the top of this list). If we're not finished yet, search this base object for a matching key again in case one was added by a meta-function.

  Due to backward-compatibility, this step is performed for _set_ operations even if a key was found (unless it defines a property which implements _set_).

- If multiple parameters were given for_get_ or _set_ and a key was found, check its value. If that value is an object, handle the remaining parameters by invoking it, and do nothing further.
- If a key was found,

  _Get_: Return the value.

  _Call_: Attempt to call the value, passing the target object as the first parameter ( `this`). The value should be a function name or a [function object](objects/Functor.htm).

If a meta-function stores a matching key in the object but does not `return`, the behaviour is the same as if the key initially existed in the object. For an example using \_\_Set, see [Sub-classing Arrays of Arrays](#Subclassing_aoa).

If the operation still hasn't been handled, check if this is a built-in method or property:

- _Get_: If the key is "base", return the object's base.
- _Set_: If the key is "base", set the object's base (or remove it if the value isn't an object).
- _Call_: Call a [built-in method](objects/Object.htm) if applicable.

If the operation still hasn't been handled,

- _Get_ and _Call_: Return an empty string.
- _Set_: If only one key parameter was given, store the key and value in the target object and return the assigned value. If multiple parameters were given, create a new object and store it using the first parameter as a key, then handle the remaining parameters by invoking the new object. (See [Arrays of Arrays](#Usage_Arrays_of_Arrays).)

**Known limitation:**

- Using`return` without a value is equivalent to `return ""`. This may be changed in a future version so that `return` can be used to "escape" from a meta-function without overriding the default behaviour.

#### Dynamic Properties

[Property syntax](#Custom_Classes_property) can be used to define properties which compute a value each time they are evaluated, but each property must be known in advance and defined individually in the script. By contrast, _\_\_Get_ and _\_\_Set_ can be used to implement properties which aren't known by the script.

For example, a "proxy" object could be created which sends requests for properties over the network (or through some other channel). A remote server would send back a response containing the value of the property, and the proxy would return the value to its caller. Even if the name of each property was known in advance, it would not be logical to define each property individually in the proxy class since every property does the same thing (send a network request). Meta-functions receive the property name as a parameter, so are a good solution for this problem.

Another use of _\_\_Get_ and _\_\_Set_ is to implement a set of related properties which share code. In the example below they are used to implement a "Color" object with R, G, B and RGB properties, where only the RGB value is actually stored:

```
red  := new Color(0xff0000), red.R -= 5
cyan := new Color(0), cyan.G := 255, cyan.B := 255

MsgBox % "red: " red.R "," red.G "," red.B " = " red.RGB
MsgBox % "cyan: " cyan.R "," cyan.G "," cyan.B " = " cyan.RGB

class Color
{
    __New(aRGB)
    {
        this.RGB := aRGB
    }

    static Shift := {R:16, G:8, B:0}

    __Get(aName)
    {
        <em>; <span class="red">NOTE:</span> Using this.Shift here would cause an infinite loop!</em>
        shift := Color.Shift[aName]  <em>; Get the number of bits to shift.</em>
        if (shift != "")  <em>; Is it a known property?</em>
            return (this.RGB >> shift) & 0xff
        <em>; <span class="red">NOTE:</span> Using 'return' here would break this.RGB.</em>
    }

    __Set(aName, aValue)
    {
        if ((shift := Color.Shift[aName]) != "")
        {
            aValue &= 255  <em>; Truncate it to the proper range.

            ; Calculate and store the new RGB value.</em>
            this.RGB := (aValue << shift) | (this.RGB & ~(0xff << shift))

            <em>; 'Return' must be used to indicate a new key-value pair should not be created.
            ; This also defines what will be stored in the 'x' in 'x := clr[name] := val':</em>
            return aValue
        }
        <em>; <span class="red">NOTE:</span> Using 'return' here would break this.stored_RGB and this.RGB.</em>
    }

    <em>; Meta-functions can be mixed with properties:</em>
    RGB {
        get {
            <em>; Return it in hex format:</em>
            return format("0x{:06x}", this.stored_RGB)
        }
        set {
            return this.stored_RGB := value
        }
    }
}
```

However, in this case [Property syntax](#Custom_Classes_property) could have been used instead, where code is shared by simply having each property call a central method. It is better to avoid using meta-functions where possible due to the high risk of misuse (see the notes in red above).

#### Objects as Functions

For an outline of how to create objects which can act as functions, see [Function Objects](objects/Functor.htm#User-Defined).

A function object can also act as a meta-function, such as to define dynamic properties similar to those in the previous section. Although it is recommended to use [property syntax](#Custom_Classes_property) instead, the example below shows the potential of meta-functions for implementing new concepts or behaviour, or changing the structure of the script.

```
<em>; This example requires the <a href="objects/Functor.htm#class_FunctionObject" data-index="91">FunctionObject class</a> in order to work.</em>
blue := new Color(0x0000ff)
MsgBox % blue.R "," blue.G "," blue.B

class Properties extends FunctionObject
{
    Call(aTarget, aName, aParams*)
    {
        <em>; If this Properties object contains a definition for this half-property, call it.</em>
        if ObjHasKey(this, aName)
            return this[aName].Call(aTarget, aParams*)
    }
}

class Color
{
    __New(aRGB)
    {
        this.RGB := aRGB
    }

    class __Get extends Properties
    {
        R() {
            return (this.RGB >> 16) & 255
        }
        G() {
            return (this.RGB >> 8) & 255
        }
        B() {
            return this.RGB & 255
        }
    }

    <em>;...</em>
}
```

#### Sub-classing Arrays of Arrays

When a [multi-parameter assignment](#Usage_Arrays_of_Arrays) such as `table[x, y] := content` implicitly causes a new object to be created, the new object ordinarily has no base and therefore no custom methods or special behaviour. `__Set` may be used to initialize these objects, as demonstrated below.

```
x := {base: {addr: Func("x_Addr"), __Set: Func("x_Setter")}}

<em>; Assign value, implicitly calling x_Setter to create sub-objects.</em>
x[1,2,3] := "..."

<em>; Retrieve value and call example method.</em>
MsgBox % x[1,2,3] "`n" x.addr() "`n" x[1].addr() "`n" x[1,2].addr()

x_Setter(x, p1, p2, p3) {
    x[p1] := new x.base
}

x_Addr(x) {
    return &x
}
```

Since `x_Setter` has four mandatory parameters, it will only be called when there are two or more key parameters. When the assignment above occurs, the following takes place:

- `x[1]` does not exist, so `x_Setter(x,1,2,3)` is called ( `"..."` is not passed as there are too few parameters).

  - `x[1]` is assigned a new object with the same base as `x`.
  - No value is returned – the assignment continues.
- `x[1][2]` does not exist, so `x_Setter(x[1],2,3,"...")` is called.

  - `x[1][2]` is assigned a new object with the same base as `x[1]`.
  - No value is returned – the assignment continues.
- `x[1][2][3]` does not exist, but since `x_Setter` requires four parameters and there are only three ( `x[1][2], 3, "..."`), it is not called and the assignment completes as normal.

## Default Base Object

When a non-object value is used with object syntax, the _default base object_ is invoked. This can be used for debugging or to globally define object-like behaviour for strings, numbers and/or variables. The default base may be accessed by using `.base` with any non-object value; for instance, `"".base`. Although the default base cannot be _set_ as in `"".base := Object()`, the default base may itself have a base as in `"".base.base := Object()`.

### Automatic Var Init

When an empty variable is used as the target of a _set_ operation, it is passed directly to the \_\_Set meta-function, giving it opportunity to insert a new object into the variable. For brevity, this example does not support multiple parameters; it could, by using a [variadic function](Functions.htm#Variadic).

```
"".base.__Set := Func("Default_Set_AutomaticVarInit")

empty_var.foo := "bar"
MsgBox % empty_var.foo

Default_Set_AutomaticVarInit(ByRef var, key, value)
{
    if (var = "")
        var := Object(key, value)
}
```

### Pseudo-Properties

Object "syntax sugar" can be applied to strings and numbers.

```
"".base.__Get := Func("Default_Get_PseudoProperty")
"".base.is    := Func("Default_is")

MsgBox % A_AhkPath.length " == " StrLen(A_AhkPath)
MsgBox % A_AhkPath.length.is("integer")

Default_Get_PseudoProperty(nonobj, key)
{
    if (key = "length")
        return StrLen(nonobj)
}

Default_is(nonobj, type)
{
    if nonobj is %type%
        return true
    return false
}
```

Note that built-in functions may also be used, but in this case the parentheses cannot be omitted:

```
"".base.length := Func("StrLen")
MsgBox % A_AhkPath.length() " == " StrLen(A_AhkPath)
```

### Debugging

If allowing a value to be treated as an object is undesirable, a warning may be shown whenever a non-object value is invoked:

```
"".base.__Get := "".base.__Set := "".base.__Call := Func("Default__Warn")

empty_var.foo := "bar"
x := (1 + 1).is("integer")

Default__Warn(nonobj, p1="", p2="", p3="", p4="")
{
    ListLines
    MsgBox A non-object value was improperly invoked.`n`nSpecifically: %nonobj%
}
```

## Implementation

### Reference-Counting

AutoHotkey uses a basic reference-counting mechanism to automatically free the resources used by an object when it is no longer referenced by the script. Script authors should not invoke this mechanism explicitly, except when dealing directly with unmanaged [pointers to objects](#Implementation_Pointers).

Currently in AutoHotkey v1.1, temporary references created within an expression (but not stored anywhere) are released immediately after use. For example, `Fn(&{})` passes an invalid address to the function, because the temporary reference returned by `{}` is released immediately after the [address-of](Variables.htm#amp) operator is evaluated.

To run code when the last reference to an object is being released, implement the [\_\_Delete](#Custom_NewDelete) meta-function.

**Known Limitations:**

- Circular references must be broken before an object can be freed. For details and an example, see[Freeing Objects](#Circular_References).
- Although references in static and global variables are released automatically when the program exits, references in non-static local variables or on the expression evaluation stack are not. These references are only released if the function or expression is allowed to complete normally.

Although memory used by the object is reclaimed by the operating system when the program exits, [\_\_Delete](#Custom_NewDelete) will not be called unless all references to the object are freed. This can be important if it frees other resources which are not automatically reclaimed by the operating system, such as temporary files.

### Pointers to Objects

In some rare cases it may be necessary to pass an object to external code via DllCall() or store it in a binary data structure for later retrieval. An object's address can be retrieved via `address := &object`; however, this effectively makes two references to the object, but the program only knows about the one in _object_. If the last _known_ reference to the object was released, the object would be deleted. Therefore, the script must inform the object that it has gained a reference. There are two ways to do this:

```
<em>; Method #1: Explicitly increment the reference count.</em>
address := &object
<a href="commands/ObjAddRef.htm" data-index="99">ObjAddRef</a>(address)

<em>; Method #2: Use Object(), which increments the reference count and returns an address.</em>
address := Object(object)
```

This function can also be used to convert an address back into a reference:

```
object := Object(address)
```

Either way, the script must also inform the object when it is finished with that reference:

```
<em>; Decrement the object's reference count to allow it to be freed:</em>
<a href="commands/ObjAddRef.htm" data-index="100">ObjRelease</a>(address)

```

Generally each new copy of an object's address should be treated as another reference to the object, so the script should call ObjAddRef() when it gains a copy and ObjRelease() immediately before losing one. For example, whenever an address is copied via something like `x := address`, ObjAddRef() should be called. Similarly, when the script is finished with _x_ (or is about to overwrite _x_'s value), it should call ObjRelease().

Note that the Object() function can be used even on objects which it did not create, such as [COM objects](commands/ComObjCreate.htm) and [File objects](objects/File.htm).

