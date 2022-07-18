# Function Objects

"Function object" usually means any of the following:

- A reference to a[Func object](Func.htm), which represents an actual [function](../Functions.htm); either built-in or defined by the script.
- A user-defined object which can be called like a function. This is sometimes also referred to as a "functor".
- Any other object which can be called like a function, such as a[BoundFunc object](#BoundFunc) or a JavaScript function object returned by a COM method.

Function objects can be used with the following:

- [Gui control events](../commands/Gui.htm#label) (g-labels)
- [Hotkey](../commands/Hotkey.htm#Functor)
- [Menu](../commands/Menu.htm#Functor)
- [OnClipboardChange()](../commands/OnClipboardChange.htm#function)
- [OnExit()](../commands/OnExit.htm#function)
- [OnMessage()](../commands/OnMessage.htm)
- [SetTimer](../commands/SetTimer.htm#Functor)

## User-Defined

User-defined function objects should follow this general pattern:

```
class YourClassName {
    Call(a, b) {  <em>; Declare parameters as needed, or an <a href="../Functions.htm#Variadic" data-index="11">array*</a>.</em>
        <em>;...</em>
    }
    __Call(method, args*) {
        if (method = "")  <em>; For <a href="../Functions.htm#DynCall" data-index="12">%fn%()</a> or fn.()</em>
            return this.Call(args*)
        if (IsObject(method))  <em>; If this function object is being used as a method.</em>
            return this.Call(method, args*)
    }
    <em>;...</em>
}

```

Exactly which parts are needed depends on the usage:

- `method` is an empty string if the script used `<a href="../Functions.htm#DynCall" data-index="13">%this%()</a>` or `this.()`.
- If the object is being used as a method,`IsObject(method)` is true and `method` contains a reference to the target object. For example, if `x.y` refers to `this` function object, `x.y()` → `this[x]()` → `this.__Call(x)` → `this.Call(x)`.
- [v1.1.20+]: If the object is being used by one of the built-in functions which accept a callback function, such as OnMessage() or SetTimer, only the Call method is needed.

The work can also be done directly in \_\_Call. However, having \_\_Call redirect to Call is recommended to ease the transition to [AutoHotkey v2](https://www.autohotkey.com/v2/), which will change the behaviour of `%this%()` and method calls to call the Call method directly.

### Examples

If you are defining multiple function object types, boilerplate code should be delegated to a base class (but if you'll ever combine your code with someone else's, be wary of conflicts). For example:

```
class FunctionObject {
    __Call(method, args*) {
        if (method = "")
            return this.Call(args*)
        if (IsObject(method))
            return this.Call(method, args*)
    }
}
```

The following example defines a function array which can be called; when called, it calls each element of the array in turn.

```
<em>; This example requires the <a href="#class_FunctionObject" data-index="15">FunctionObject class</a> above in order to work.</em>
class FuncArrayType extends FunctionObject {
    Call(obj, params*) {
        <em>; Call a list of functions.</em>
        Loop % this.Length()
            this[A_Index].Call(params*)
    }
}

<em>; Create an array of functions.</em>
funcArray := new FuncArrayType
<em>; Add some functions to the array (can be done at any point).</em>
funcArray.Push(Func("One"))
funcArray.Push(Func("Two"))
<em>; Create an object which uses the array as a method.</em>
obj := {method: funcArray}
<em>; Call the method.</em>
obj.method("foo", "bar")

One(param1, param2) {
    ListVars
    MsgBox
}
Two(param1, param2) {
    ListVars
    MsgBox
}
```

## BoundFunc Object [v1.1.20+]

Acts like a function, but just passes predefined parameters to another function.

There are two ways that BoundFunc objects can be created:

- By calling the[Func.Bind()](Func.htm#Bind) method, which binds parameter values to a function.
- By calling the[ObjBindMethod()](../commands/ObjBindMethod.htm) function, which binds parameter values and a method name to a target object.

BoundFunc objects can be called as shown in the example below. No other methods are supported. When the BoundFunc is called, it calls the function or method to which it is bound, passing any bound parameters followed by any which were passed by the caller. For example:

```
fn := Func("RealFn").Bind(1)

%fn%(2)    <em>; Shows "1, 2"</em>
fn.Call(3) <em>; Shows "1, 3"</em>

RealFn(a, b) {
    MsgBox %a%, %b%
}
```

[ObjBindMethod()](../commands/ObjBindMethod.htm) can be used to bind to a method when it isn't possible to retrieve a reference to the method itself. For example:

```
file := FileOpen(A_ScriptFullPath, "r")
getLine := ObjBindMethod(file, "ReadLine")
MsgBox % %getLine%()  <em>; Shows the first line of this file.</em>
```

For a more complex example, see [SetTimer](../commands/SetTimer.htm#ExampleClass).

