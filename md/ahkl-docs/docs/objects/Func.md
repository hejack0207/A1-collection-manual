# Func Object [v1.1.00+]

Represents a user-defined or built-in function which can be called by the script. [Func](../commands/Func.htm) returns an object of this type.

For information about other objects which can be called like functions, see [Function Objects](Functor.htm).

A reference to a Func object is also known as a _function reference_. To retrieve a function reference, use the Func function as in the following example:

```
<em>; Retrieve a reference to the function named "StrLen".</em>
fn := Func("StrLen")

<em>; Display information about the function.</em>
MsgBox % fn.Name "() is " (fn.IsBuiltIn ? "built-in." : "user-defined.")
```

## Table of Contents

- [Methods](#Methods):

  - [Call](#Call): Calls the function.
  - [Bind](#Bind): Binds parameters to the function and returns a [BoundFunc object](Functor.htm#BoundFunc).
  - [IsByRef](#IsByRef): Determines whether a parameter is ByRef.
  - [IsOptional](#IsOptional): Determines whether a parameter is optional.
- [Properties](#Properties):

  - [Name](#Name): Returns the function's name.
  - [IsBuiltIn](#IsBuiltIn): Returns _true_ if the function is [built-in](../Functions.htm#BuiltIn) and _false_ otherwise.
  - [IsVariadic](#IsVariadic): Returns _true_ if the function is [variadic](../Functions.htm#Variadic) and _false_ otherwise.
  - [MinParams](#MinParams): Returns the number of required parameters.
  - [MaxParams](#MaxParams): Returns the number of formally-declared parameters for a user-defined function or maximum parameters for a built-in function.

## Methods

### Call

Calls the function.

```
Func.<span class="func">Call</span>(Param1, Param2, ...)  <em>; Requires <span class="ver">[v1.1.19+]</span></em>
Func.(Param1, Param2, ...)  <em>; Old form - deprecated</em>

```

Param1, Param2, ...Parameters and return value are defined by the function.

[v1.1.07+]: `<a href="../Functions.htm#DynCall" data-index="17">%Func%()</a>` can be used to call a function by name or reference, or to call an object which implements the \_\_Call [meta-function](../Objects.htm#Meta_Functions). This should be used instead of `Func.()` wherever possible.

### Bind [v1.1.20+]

Binds parameters to the function and returns a [BoundFunc object](Functor.htm#BoundFunc).

```
BoundFunc := Func.<span class="func">Bind</span>(Param1, Param2, ...)
```

Param1, Param2, ...Any number of parameters.

For details and examples, see [BoundFunc object](Functor.htm#BoundFunc).

### IsByRef

Determines whether a parameter is ByRef.

```
Boolean := Func.<span class="func">IsByRef</span>(<span class="optional">ParamIndex</span>)
```

ParamIndexOptional: the one-based index of a parameter. If omitted, _Boolean_ indicates whether the function has any ByRef parameters.

Returns an empty string if the function is built-in or _ParamIndex_ is invalid; otherwise, a boolean value indicating whether the parameter is ByRef.

### IsOptional

Determines whether a parameter is optional.

```
Boolean := Func.<span class="func">IsOptional</span>(<span class="optional">ParamIndex</span>)
```

ParamIndexOptional: the one-based index of a parameter. If omitted, _Boolean_ indicates whether the function has any optional parameters.

Returns an empty string if _ParamIndex_ is invalid; otherwise, a boolean value indicating whether the parameter is optional.

Parameters do not need to be formally declared if the function is variadic. Built-in functions are supported.

## Properties

### Name

Returns the function's name.

```
FunctionName := Func.Name
```

### IsBuiltIn

Returns _true_ if the function is [built-in](../Functions.htm#BuiltIn) and _false_ otherwise.

```
Boolean := Func.IsBuiltIn
```

### IsVariadic

Returns _true_ if the function is [variadic](../Functions.htm#Variadic) and _false_ otherwise.

```
Boolean := Func.IsVariadic
```

### MinParams

Returns the number of required parameters.

```
ParamCount := Func.MinParams
```

### MaxParams

Returns the number of formally-declared parameters for a user-defined function or maximum parameters for a built-in function.

```
ParamCount := Func.MaxParams
```

If the function is [variadic](../Functions.htm#Variadic), _ParamCount_ indicates the maximum number of parameters which can be accepted by the function without overflowing into the "variadic\*" parameter.

