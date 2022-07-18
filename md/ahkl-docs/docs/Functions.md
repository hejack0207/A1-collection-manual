# Functions

## Table of Contents

- [Introduction and Simple Examples](#intro)
- [Parameters](#param)
- [Optional Parameters](#optional)
- [Returning Values to Caller](#return)
- [Variadic Functions](#Variadic)
- [Local Variables](#Local)
- [Dynamically Calling a Function](#DynCall)
- [Short-circuit Boolean Evaluation](#ShortCircuit)
- [Using Subroutines Within a Function](#gosub)
- [Return, Exit, and General Remarks](#remarks)
- [Using #Include to Share Functions Among Multiple Scripts](#include)
- [Libraries of Functions: Standard Library and User Library](#lib)
- [Built-in Functions](#BuiltIn)

## Introduction and Simple Examples

A function is similar to a subroutine ( [Gosub](commands/Gosub.htm)) except that it can accept parameters (inputs) from its caller. In addition, a function may optionally return a value to its caller. Consider the following simple function that accepts two numbers and returns their sum:

```
Add(x, y)
{
    return x + y   <em>; "<a href="commands/Return.htm" data-index="15">Return</a>" expects an <a href="Variables.htm#Expressions" data-index="16">expression</a>.</em>
}
```

The above is known as a function _definition_ because it creates a function named "Add" (not case sensitive) and establishes that anyone who calls it must provide exactly two parameters (x and y). To call the function, assign its result to a variable with the **[:=](commands/SetExpression.htm)** [operator](commands/SetExpression.htm). For example:

```
Var := Add(2, 3)  <em>; The number 5 will be stored in Var.</em>
```

Also, a function may be called without storing its return value:

```
Add(2, 3)
```

But in this case, any value returned by the function is discarded; so unless the function produces some effect other than its return value, the call would serve no purpose.

Since a function call is an [expression](Variables.htm#Expressions), any variable names in its parameter list should not be enclosed in percent signs. By contrast, literal strings should be enclosed in double quotes. For example:

```
if <a href="#InStr" data-index="20">InStr</a>(MyVar, "fox")
    MsgBox The variable MyVar contains the word fox.
```

Finally, functions may be called in the parameters of any command (except OutputVar and InputVar parameters such as those of [StringLen](commands/StringLen.htm)). However, parameters that do not support [expressions](Variables.htm#Expressions) must use the "% " prefix as in this example:

```
MsgBox % "The answer is: " . Add(3, 2)
```

The "% " prefix is also permitted in parameters that natively support expressions, but it is simply ignored.

## Parameters

When a function is defined, its parameters are listed in parentheses next to its name (there must be no spaces between its name and the open-parenthesis). If a function does not accept any parameters, leave the parentheses empty; for example: `GetCurrentTimestamp()`.

**ByRef Parameters**: From the function's point of view, parameters are essentially the same as [local variables](#Local) unless they are defined as _ByRef_ as in this example:

```
Swap(ByRef Left, ByRef Right)
{
    temp := Left
    Left := Right
    Right := temp
}
```

In the example above, the use of _ByRef_ causes each parameter to become an alias for the variable passed in from the caller. In other words, the parameter and the caller's variable both refer to the same contents in memory. This allows the Swap function to alter the caller's variables by moving _Left_'s contents into _Right_ and vice versa.

By contrast, if _ByRef_ were not used in the example above, _Left_ and _Right_ would be copies of the caller's variables and thus the Swap function would have no external effect.

Since [return](commands/Return.htm) can send back only one value to a function's caller, _ByRef_ can be used to send back extra results. This is achieved by having the caller pass in a variable (usually empty) in which the function stores a value.

When passing large strings to a function, _ByRef_ enhances performance and conserves memory by avoiding the need to make a copy of the string. Similarly, using _ByRef_ to send a long string back to the caller usually performs better than something like `Return HugeString`.

[AHK\_L 60+]: If something other than a modifiable variable is passed to a ByRef parameter, the function behaves as though the keyword "ByRef" is absent. For example, `Swap(A_Index, i)` stores the value of _A\_Index_ in _i_, but the value assigned to _Left_ is discarded once the _Swap_ function returns.

[v1.1.01+]: The [IsByRef()](#IsByRef) function can be used to determine whether the caller supplied a variable for a given ByRef parameter.

Known limitations:

- Fields of objects are not considered variables for the purposes of_ByRef_. For example, if `foo.bar` is passed to a ByRef parameter, it will behave as though _ByRef_ was omitted.
- It is not possible to pass[Clipboard](misc/Clipboard.htm), [built-in variables](Variables.htm#BuiltIn), or [environment variables](Concepts.htm#environment-variables) to a function's _ByRef_ parameter, even when [#NoEnv](commands/_NoEnv.htm) is absent from the script.
- Although a function may call itself recursively, if it passes one of its own[local variables](#Local) or non-ByRef parameters to itself _ByRef_, the new layer's _ByRef_ parameter will refer to its own local variable of that name rather than the previous layer's. However, this issue does not occur when a function passes to itself a [global variable](#Global), [static variable](#static), or _ByRef_ parameter.
- If a parameter in a function-call resolves to a variable (e.g.`Var` or `++Var` or `Var*=2`), other parameters to its left or right can alter that variable before it is passed to the function. For example, `MyFunc(Var, Var++)` would unexpectedly pass 1 and 0 when _Var_ is initially 0, even when the function's first parameter is not _ByRef_. Since this behavior is counterintuitive, it might change in a future release.
- ByRef is not directly supported in functions called by COM clients, or when calling COM methods. Instead, the script receives or must pass a[wrapper object](commands/ComObjActive.htm#ByRef) containing the [VarType](commands/ComObjType.htm) and address of the value.

## Optional Parameters

When defining a function, one or more of its parameters can be marked as optional. This is done by appending `:=` (in [v1.1.09] or later) or `=`, followed by the parameter's default value, which must be one of the following: `true`, `false`, a literal integer, a literal floating point number, or a quoted/literal string such as "fox" or "" (but strings in versions prior to [v1.0.46.13] support only "").

The use of `=` (without a colon) is permitted for backward-compatibility, but not recommended, and will not be permitted by AutoHotkey v2. Regardless of which operator is used, default values which are strings must always be enclosed in quote marks.

The following function has its Z parameter marked optional:

```
Add(X, Y, Z:=0) {
    return X + Y + Z
}
```

When the caller passes **three** parameters to the function above, Z's default value is ignored. But when the caller passes only **two** parameters, Z automatically receives the value 0.

It is not possible to have optional parameters isolated in the middle of the parameter list. In other words, all parameters that lie to the right of the first optional parameter must also be marked optional. [AHK\_L 31+]: Optional parameters may be omitted from the middle of the parameter list when calling the function, as shown below. For dynamic function calls and method calls, this requires [v1.1.12+].

```
MyFunc(1,, 3)
MyFunc(X, Y:=2, Z:=0) {  <em>; Note that Z must still be optional in this case.</em>
    MsgBox %X%, %Y%, %Z%
}
```

[v1.0.46.13+]: [ByRef parameters](#ByRef) also support default values; for example: `MyFunc(ByRef p1 = "")`. Whenever the caller omits such a parameter, the function creates a local variable to contain the default value; in other words, the function behaves as though the keyword "ByRef" is absent.

## Returning Values to Caller

As described in [introduction](#intro), a function may optionally [return](commands/Return.htm) a value to its caller.

```
Test := returnTest()
MsgBox % Test

returnTest() {
    return 123
}

```

If you want to return extra results from a function, you may also use [ByRef](#ByRef):

```
returnByRef(A,B,C)
MsgBox % A "," B "," C

returnByRef(ByRef val1, ByRef val2, ByRef val3)
{
    val1 := "A"
    val2 := 100
    val3 := 1.1
    return
}

```

[v1.0.97+]: [Objects](Objects.htm#Usage_Objects) and [Arrays](Objects.htm#Usage_Simple_Arrays) can be used to return multiple values or even named values:

```
Test1 := returnArray1()
MsgBox % Test1[1] "," Test1[2]

Test2 := returnArray2()
MsgBox % Test2[1] "," Test2[2]

Test3 := returnObject()
MsgBox % Test3.id "," Test3.val

returnArray1() {
    Test := [123,"ABC"]
    return Test
}

returnArray2() {
    x := 456
    y := "EFG"
    return [x, y]
}

returnObject() {
    Test := {id: 789, val: "HIJ"}
    return Test
}

```

## Variadic Functions [AHK\_L 60+]

When defining a function, write an asterisk after the final parameter to mark the function as variadic, allowing it to receive a variable number of parameters:

```
Join(sep, <b class="blue">params*</b>) {
    for index,param in params
        str .= param . sep
    return SubStr(str, 1, -StrLen(sep))
}
MsgBox % Join("`n", "one", "two", "three")
```

When a variadic function is called, surplus parameters can be accessed via an object which is stored in the function's final parameter. The first surplus parameter is at `<i>params</i>[1]`, the second at `<i>params</i>[2]` and so on. As with any standard object, `<i>params</i>.MaxIndex()` can be used to determine the highest numeric index (in this case the number of parameters). However, if there are no parameters, MaxIndex returns an empty string.

Notes:

- The "variadic" parameter can only appear at the end of the formal parameter list.
- [RegEx callouts](misc/RegExCallout.htm) cannot be variadic; the "variadic" parameter is tolerated but left blank.
- [Callbacks](commands/RegisterCallback.htm) pass surplus parameters [by address](commands/RegisterCallback.htm#Indirect) rather than via an array.

### Variadic Function Calls

While variadic functions can _accept_ a variable number of parameters, an array of parameters can be passed to _any_ function by applying the same syntax to a function-call:

```
substrings := ["one", "two", "three"]
MsgBox % Join("`n", <b class="blue">substrings*</b>)
```

Notes:

- Numbering of parameters within the source array begins at 1.
- Optional parameters may be entirely omitted from the array.
- The array of parameters may contain named items when calling a user-defined function; in any other case, named items are not supported.
- The target function may also be variadic, in which case named items are copied even if they have no corresponding formal parameter.
- This syntax can also be used when calling methods or retrieving properties of objects; for example,`Object.Property[Params*]`. [v1.1.12+]: It can also be used for setting properties.

Known limitations:

- Only the right-most parameter can be expanded this way. For example,`MyFunc(x, y*)` is supported but `MyFunc(x*, y)` is not.
- There must not be any non-whitespace characters between the asterisk ( `*`) and the symbol which ends the parameter list.

## Local and Global Variables

### Local Variables

Local variables are specific to a single function and are visible only inside that function. Consequently, a local variable may have the same name as a global variable and both will have separate contents. Separate functions may also safely use the same variable names.

All local variables which are not [static](#static) are automatically freed (made empty) when the function returns.

Built-in variables such as [Clipboard](misc/Clipboard.htm), [ErrorLevel](misc/ErrorLevel.htm), and [A\_TimeIdle](Variables.htm#TimeIdle) are never local (they can be accessed from anywhere), and cannot be redeclared.

Functions are **assume-local** by default. Variables accessed or created inside an assume-local function are local by default, with the following exceptions:

- [Super-global](#SuperGlobal) variables, including [classes](Objects.htm#Custom_Classes).
- A[dynamic variable reference](#DynVar) may resolve to an existing global variable if no local variable exists by that name.
- [Commands that create pseudo-arrays](#PseudoArrays) may create all elements as global even if only the first element is declared.

The default may also be overridden as shown below (by declaring the variable or by changing the mode of the function).

**Force-local mode**[v1.1.27+]: If the function's first line is the word "local", all variable references (even dynamic ones) are assumed to be local unless they are declared as global _inside_ the function. Unlike the default mode, force-local mode has the following behavior:

- Super-global variables (including classes) cannot be accessed without declaring them inside the function.
- Dynamic variable references follow the same rules as non-dynamic ones. Only global variables which are declared inside the function can be accessed.
- StringSplit and other commands which create pseudo-arrays follow the same rules as non-dynamic variable references (avoiding a common source of confusion).
- The_LocalSameAsGlobal_ [warning](commands/_Warn.htm) is never raised for variables within a force-local function.

### Global variables

To refer to an existing global variable inside a function (or create a new one), declare the variable as global prior to using it. For example:

```
LogToFile(TextToLog)
{
    global LogFileName  <em>; This global variable was previously given a value somewhere outside this function.</em>
    FileAppend, %TextToLog%`n, %LogFileName%
}
```

**Assume-global mode**: If a function needs to access or create a large number of global variables, it can be defined to assume that all its variables are global (except its parameters) by making its first line either the word "global" or the declaration of a local variable. For example:

```
SetDefaults()
{
    global  <em>; This word may be omitted if the first line of this function will be something like "local MyVar".</em>
    MyGlobal := 33  <em>; Assigns 33 to a global variable, first creating the variable if necessary.</em>
    local x, y:=0, z  <em>; Local variables must be declared in this mode, otherwise they would be assumed global.</em>
}
```

This assume-global mode can also be used by a function to create a global [array](misc/Arrays.htm), such as a loop that assigns values to `Array%A_Index%`.

**Super-global variables**[v1.1.05+]: If a global declaration appears outside of any function, it takes effect for all functions by default (excluding [force-local](#ForceLocal) functions). This avoids the need to redeclare the variable in each function. However, if a function parameter or local variable with the same name is declared, it takes precedence over the global variable. Variables created by the [class](Objects.htm#Custom_Classes) keyword are also super-global.

### Static variables

Static variables are always implicitly local, but differ from locals because their values are remembered between calls. For example:

```
LogToFile(TextToLog)
{
    <strong>static</strong> LoggedLines := 0
    LoggedLines += 1  <em>; Maintain a tally locally (its value is remembered between calls).</em>
    global LogFileName
    FileAppend, %LoggedLines%: %TextToLog%`n, %LogFileName%
}
```

**Static Initializers**: In versions prior to 1.0.46, all static variables started off blank; so the only way to detect that one was being used for the first time was to check whether it was blank. [v1.0.46+]: A static variable may be initialized to something other than `""` by following it with `:=` or `=` followed by one of the following: `true`, `false`, a literal integer, a literal floating point number, or a literal/quoted string such as `"fox"`. For example: `static X:=0, Y:="fox"`. Each static variable is initialized only once (before the script begins executing).

[AHK\_L 58+]: `Static var := expression` is supported. All such expressions are evaluated immediately before the script's auto-execute section in the order they are encountered in the script.

**Assume-static mode**[v1.0.48+]: A function may be defined to assume that all its variables are static (except its parameters) by making its first line the word "static". For example:

```
GetFromStaticArray(WhichItemNumber)
{
    <strong>static</strong>
    static FirstCallToUs := true  <em>; A static declaration's initializer still runs only once (upon startup).</em>
    if FirstCallToUs  <em>; Create a static array during the first call, but not on subsequent calls.</em>
    {
        FirstCallToUs := false
        Loop 10
            StaticArray%A_Index% := "Value #" . A_Index
    }
    return StaticArray%WhichItemNumber%
}
```

In assume-static mode, any variable that should not be static must be declared as local or global (with the same exceptions as for [assume-local mode](#AssumeLocal), unless [force-local mode](#ForceLocal) is also in effect).

[v1.1.27+]: [Force-local mode](#ForceLocal) can be combined with assume-static mode by specifying `local` and then `static`, as shown below. This allows the function to use force-local rules but create variables as static by default.

```
global MyVar := "This is global"
DemonstrateForceStatic()

DemonstrateForceStatic()
{
    local
    static
    MyVar := "This is static"
    ListVars
    MsgBox
}

```

### More about locals and globals

Multiple variables may be declared on the same line by separating them with commas as in these examples:

```
global LogFileName, MaxRetries := 5
static TotalAttempts := 0, PrevResult
```

[v1.0.46+]: A local or global variable may be initialized on the same line as its declaration by following it with `:=` or `=` followed by any [expression](Variables.htm#Expressions) (the `=` operator behaves the same as `:=` in declarations). Unlike [static initializers](#InitStatic), the initializers of locals and globals execute every time the function is called, but only if/when the flow of control actually reaches them. In other words, a line like `local x := 0` has the same effect as writing two separate lines: `local x` followed by `x := 0`.

Because the words _local_, _global_, and _static_ are processed immediately when the script launches, a variable cannot be conditionally declared by means of an [IF statement](commands/IfExpression.htm). In other words, a declaration inside an IF's or ELSE's [block](commands/Block.htm) takes effect unconditionally for all lines between the declaration and the function's closing brace. Also note that it is not currently possible to declare a dynamic variable such as `global Array%i%`.

For commands that create [pseudo-arrays](misc/Arrays.htm) (such as [StringSplit](commands/StringSplit.htm)), each variable in the resulting pseudo-array is local if the [assume-global mode](#AssumeGlobal) is not in effect or if the pseudo-array's first element has been declared as a local variable (this is also true if one of the function's parameters is passed -- even if that parameter is [ByRef](#ByRef) \-\- because parameters are similar to local variables). Conversely, if the first element has been [declared global](#Global), a global array is created. However, the _common source of confusion_ below applies even in these cases. The first element for [StringSplit](commands/StringSplit.htm) is ArrayName0. For other array-creating commands such as [WinGet List](commands/WinGet.htm), the first element is ArrayName (i.e. without the number). [v1.1.27+]: When [force-local mode](#ForceLocal) is in effect, these commands follow rules consistent with normal variable references; that is, any pseudo-array element not declared as global will be local even if other elements are declared global.

Within a function (unless [force-local mode](#ForceLocal) is in effect), any dynamic variable reference such as `Array%i%` always resolves to a local variable unless no variable of that name exists, in which case a global is used if it exists. If neither exists and the usage requires the variable to be created, it is created as a local variable unless the [assume-global mode](#AssumeGlobal) is in effect. Consequently, a function can create a global [array](misc/Arrays.htm) manually (by means such as `Array%i% := A_Index`) only if it has been defined as an [assume-global](#AssumeGlobal) function.

**Common source of confusion**: Any _non_-dynamic reference to a variable creates that variable the moment the script launches. For example, when used outside a function, `MsgBox %Array1%` creates Array1 as a global the moment the script launches. Conversely, when used inside a function `MsgBox %Array1%` creates Array1 as one of the function's locals the moment the script launches (unless [assume-global](#AssumeGlobal) is in effect), even if Array and Array0 are declared global.

## Dynamically Calling a Function

[v1.0.47.06+]: A function (even a [built-in function](#BuiltIn)) may be called dynamically via percent signs. For example, `%Var%(x, "fox")` would call the function whose name is contained in _Var_. Similarly, `Func%A_Index%()` would call Func1() or Func2(), etc., depending on the current value of A\_Index.

[v1.1.07.00+]: _Var_ in `%Var%()` can contain a function name or a [function object](objects/Functor.htm). If the function does not exist, the [default base object](Objects.htm#Default_Base_Object)'s \_\_Call meta-function is invoked instead.

If the function cannot be called due to one of the reasons below, the evaluation of the expression containing the call stops silently and prematurely, which may lead to inconsistent results:

- Calling a nonexistent function, which can be avoided by using`If <a href="#IsFunc" data-index="79">IsFunc</a>(VarContainingFuncName)`. Except for [built-in functions](#BuiltIn), the called function's [definition](#define) must exist explicitly in the script by means such as [#Include](commands/_Include.htm) or a non-dynamic call to a [library function](#lib).
- Passing too few parameters, which can be avoided by checking[IsFunc()](#IsFunc)'s return value (which is the number of mandatory parameters plus one). [v1.0.48+]: Note that passing too many parameters is tolerated; each extra parameter is fully evaluated (including any calls to functions) and then discarded.

Finally, a dynamic call to a function is slightly slower than a normal call because normal calls are resolved (looked up) before the script begins running.

## Short-circuit Boolean Evaluation

When _AND, OR_, and the [ternary operator](Variables.htm#ternary) are used within an [expression](Variables.htm#Expressions), they short-circuit to enhance performance (regardless of whether any function calls are present). Short-circuiting operates by refusing to evaluate parts of an expression that cannot possibly affect its final result. To illustrate the concept, consider this example:

```
if (ColorName != "" AND not FindColor(ColorName))
    MsgBox %ColorName% could not be found.
```

In the example above, the FindColor() function never gets called if the _ColorName_ variable is empty. This is because the left side of the _AND_ would be _false_, and thus its right side would be incapable of making the final outcome _true_.

Because of this behavior, it's important to realize that any side-effects produced by a function (such as altering a global variable's contents) might never occur if that function is called on the right side of an _AND_ or _OR_.

It should also be noted that short-circuit evaluation cascades into nested _AND_ s and _OR_ s. For example, in the following expression, only the leftmost comparison occurs whenever _ColorName_ is blank. This is because the left side would then be enough to determine the final answer with certainty:

```
if (ColorName = "" <u>OR</u> FindColor(ColorName, Region1) <u>OR</u> FindColor(ColorName, Region2))
    break   <em>; Nothing to search for, or a match was found.</em>
```

As shown by the examples above, any expensive (time-consuming) functions should generally be called on the right side of an _AND_ or _OR_ to enhance performance. This technique can also be used to prevent a function from being called when one of its parameters would be passed a value it considers inappropriate, such as an empty string.

[v1.0.46+]: The [ternary conditional operator (?:)](Variables.htm#ternary) also short-circuits by not evaluating the losing branch.

## Using Subroutines Within a Function

Although a function cannot contain [definitions](#define) of other functions, it can contain subroutines. As with other subroutines, use [Gosub](commands/Gosub.htm) to launch them and [Return](commands/Return.htm) to return (in which case the Return would belong to the Gosub and not the function).

Known limitation: Currently, the name of each subroutine (label) must be unique among those of the entire script. The program will notify you upon launch if there are duplicate labels.

If a function uses [Gosub](commands/Gosub.htm) to jump to a public subroutine (one that lies outside of the function's braces), all variables outside are global and the function's own [local variables](#Local) are not accessible until the subroutine returns. However, A\_ThisFunc will still contain the name of the function.

Although [Goto](commands/Goto.htm) cannot be used to jump from inside a function to outside, it is possible for a function to [Gosub](commands/Gosub.htm) an external/public subroutine and then do a Goto from there.

Although the use of [Goto](commands/Goto.htm) is generally discouraged, it can be used inside a function to jump to another position within the same function. This can help simplify complex functions that have many points of return, all of which need to do some clean-up prior to returning.

A function may contain externally-called subroutines such as [timer](commands/SetTimer.htm) s, [GUI g-labels](commands/Gui.htm#label), and [menu items](commands/Menu.htm). This is generally done to encapsulate them in a separate file for use with [#Include](commands/_Include.htm), which prevents them from interfering with the script's [auto-execute section](Scripts.htm#auto). However, the following limitations apply:

- Such subroutines should use only[static](#static) and [global](#Global) variables (not [locals](#Local)) if their function is ever called normally. This is because a subroutine [thread](misc/Threads.htm) that interrupts a function-call thread (or vice versa) would be able to change the values of local variables seen by the interrupted thread. Furthermore, any time a function returns to its caller, all of its local variables are made blank to free their memory.
- Such subroutines should use only[global variables](#Global) (not [static variables](#static)) as [GUI control variables](commands/Gui.htm#var).
- When a function is entered by a subroutine[thread](misc/Threads.htm), any references to [dynamic variables](misc/Arrays.htm) made by that thread are treated as [globals](#Global) (including commands that create arrays).

## Return, Exit, and General Remarks

If the flow of execution within a function reaches the function's closing brace prior to encountering a [Return](commands/Return.htm), the function ends and returns a blank value (empty string) to its caller. A blank value is also returned whenever the function explicitly omits [Return](commands/Return.htm)'s parameter.

When a function uses the [Exit](commands/Exit.htm) command to terminate the [current thread](misc/Threads.htm), its caller does not receive a return value at all. For example, the statement `Var := Add(2, 3)` would leave `Var` unchanged if `Add()` exits. The same thing happens if a function causes a runtime error such as [running](commands/Run.htm) a nonexistent file (when [UseErrorLevel](commands/Run.htm#UseErrorLevel) is not in effect).

A function may alter the value of [ErrorLevel](misc/ErrorLevel.htm) for the purpose of returning an extra value that is easy to remember.

To call a function with one or more blank values (empty strings), use an empty pair of quotes as in this example: `FindColor(ColorName, "")`.

Since calling a function does not start a new [thread](misc/Threads.htm), any changes made by a function to settings such as [SendMode](commands/SendMode.htm) and [SetTitleMatchMode](commands/SetTitleMatchMode.htm) will go into effect for its caller too.

The caller of a function may pass a nonexistent variable or [array](misc/Arrays.htm) element to it, which is useful when the function expects the corresponding parameter to be [ByRef](#ByRef). For example, calling `GetNextLine(BlankArray%i%)` would create the variable `BlankArray%i%` automatically as a [local](#Local) or global (depending on whether the caller is inside a function and whether it has the [assume-global mode](#AssumeGlobal) in effect).

When used inside a function, [ListVars](commands/ListVars.htm) displays a function's [local variables](#Local) along with their contents. This can help debug a script.

## Style and Naming Conventions

You might find that complex functions are more readable and maintainable if their special variables are given a distinct prefix. For example, naming each parameter in a function's parameter list with a leading "p" or "p\_" makes their special nature easy to discern at a glance, especially when a function has several dozen [local variables](#Local) competing for your attention. Similarly, the prefix "r" or "r\_" could be used for [ByRef parameters](#ByRef), and "s" or "s\_" could be used for [static variables](#static).

The [One True Brace (OTB) style](commands/Block.htm#otb) may optionally be used to define functions. For example:

```
Add(x, y) {
    return x + y
}
```

## Using \#Include to Share Functions Among Multiple Scripts

The [#Include](commands/_Include.htm) directive may be used ( _even at the top of a script_) to load functions from an external file.

Explanation: When the script's flow of execution encounters a function definition, it jumps over it (using an instantaneous method) and resumes execution at the line after its closing brace. Consequently, execution can never fall into a function from above, nor does the presence of one or more functions at the very top of a script affect the [auto-execute section](Scripts.htm#auto).

## Libraries of Functions: Standard Library and User Library [v1.0.47+]

A script may call a function in an external file without having to use [#Include](commands/_Include.htm). For this to work, a file of the same name as the function must exist in one of the following library directories:

```
<a href="Variables.htm#ScriptDir" data-index="134">%A_ScriptDir%</a>\Lib\  <em>; Local library - requires <span class="ver">[AHK_L 42+]</span>.</em>
<a href="Variables.htm#MyDocuments" data-index="135">%A_MyDocuments%</a>\AutoHotkey\Lib\  <em>; User library.</em>
directory-of-the-currently-running-AutoHotkey.exe\Lib\  <em>; Standard library.</em>
```

For example, if a script calls a nonexistent function `MyFunc()`, the program searches for a file named "MyFunc.ahk" in the user library. If not found there, it searches for it in the standard library. If a match is still not found and the function's name contains an underscore (e.g. `MyPrefix_MyFunc`), the program searches both libraries for a file named `MyPrefix.ahk` and loads it if it exists. This allows `MyPrefix.ahk` to contain both the function `MyPrefix_MyFunc` and other related functions whose names start with `MyPrefix_`.

[AHK\_L 42+]: The local library is supported and is searched before the user library and standard library.

Only a direct function call such as `MyFunc()` can cause a library to be auto-included. If the function is only called dynamically or indirectly, such as by a timer or GUI event, the library must be explicitly included in the script. For example: `<a href="commands/_Include.htm" data-index="136">#Include</a> <MyFunc>`

Although a library file generally contains only a single function of the same name as its filename, it may also contain private functions and subroutines that are called only by it. However, such functions should have fairly distinct names because they will still be in the global namespace; that is, they will be callable from anywhere in the script.

If a library file uses [#Include](commands/_Include.htm), the working directory for #Include is the library file's own directory. This can be used to create a redirect to a larger library file that contains that function and others related to it.

The [script compiler (ahk2exe)](Scripts.htm#ahk2exe) also supports library functions. However, it requires that a copy of AutoHotkey.exe exist in the directory above the compiler directory (which is normally the case). If AutoHotkey.exe is absent, the compiler still works but library functions are not automatically included.

Functions included from a library perform just as well as other functions because they are pre-loaded before the script begins executing.

## Built-in Functions

Any optional parameters at the end of a built-in function's parameter list may be completely omitted. For example, `WinExist("Untitled - Notepad")` is valid because its other three parameters would be considered blank.

A built-in function is overridden if the script defines its own function of the same name. For example, a script could have its own custom WinExist() function that is called instead of the standard one. However, the script would then have no way to call the original function.

External functions that reside in DLL files may be called with [DllCall()](commands/DllCall.htm).

To get more details about a particular built-in function below, simply click on its name.

### Frequently-used Functions

FunctionDescription[FileExist](commands/FileExist.htm)Checks for the existence of a file or folder and returns its attributes.[GetKeyState](commands/GetKeyState.htm#function)Returns true (1) if the specified key is down and false (0) if it is up.[InStr](commands/InStr.htm)Searches for a given occurrence of a string, from the left or the right.[RegExMatch](commands/RegExMatch.htm)Determines whether a string contains a pattern (regular expression).[RegExReplace](commands/RegExReplace.htm)Replaces occurrences of a pattern (regular expression) inside a string.[StrLen](commands/StrLen.htm)Retrieves the count of how many characters are in a string.[StrReplace](commands/StrReplace.htm)Replaces occurrences of the specified substring with a new string.[StrSplit](commands/StrSplit.htm)Separates a string into an array of substrings using the specified delimiters.[SubStr](commands/SubStr.htm)Retrieves one or more characters from the specified position in a string.[WinActive](commands/WinActive.htm)Checks if the specified window is active and returns its unique ID (HWND).[WinExist](commands/WinExist.htm)Checks if the specified window exists and returns the unique ID (HWND) of the first matching window.

### Miscellaneous Functions

FunctionDescription[Asc](commands/Asc.htm)Returns the numeric value of the first byte or UTF-16 code unit in the specified string.[Chr](commands/Chr.htm)Returns the string (usually a single character) corresponding to the character code indicated by the specified number.[DllCall](commands/DllCall.htm)Calls a function inside a DLL, such as a standard Windows API function.[Exception](commands/Throw.htm#Exception)Creates an object which can be used to throw a custom exception.[FileOpen](commands/FileOpen.htm)Opens a file to read specific content from it and/or to write new content into it.[Format](commands/Format.htm)Formats a variable number of input values according to a format string.[Func](commands/Func.htm)Retrieves a reference to the specified function.[GetKeyName/VK/SC](commands/GetKey.htm)Retrieves the name/text, virtual key code or scan code of a key.[Hotstring](commands/Hotstring.htm)Creates, modifies, enables, or disables a hotstring while the script is running.[IL\_XXX](commands/ListView.htm#IL)Functions to add icons/pictures to, create or delete ImageLists used by ListView or TreeView controls.[InputHook](commands/InputHook.htm)Creates an object which can be used to collect or intercept keyboard input.[IsByRef](commands/IsByRef.htm)Returns a non-zero number if the specified [ByRef parameter](#ByRef) was supplied with a variable.[IsFunc](commands/IsFunc.htm)Returns a non-zero number if the specified function exists in the script.[IsLabel](commands/IsLabel.htm)Returns a non-zero number if the specified label exists in the script.[IsObject](commands/IsObject.htm)Returns a non-zero number if the specified value is an object.[LoadPicture](commands/LoadPicture.htm)Loads a picture from file and returns a bitmap or icon handle.[LV\_XXX](commands/ListView.htm#BuiltIn)Functions to add, insert, modify or delete ListView rows/colums, or to get data from them.[MenuGetHandle](commands/MenuGetHandle.htm)Retrieves the [Win32 menu](commands/Menu.htm#Win32_Menus) handle of a menu.[MenuGetName](commands/MenuGetName.htm)Retrieves the name of a menu given a handle to its underlying [Win32 menu](commands/Menu.htm#Win32_Menus).[NumGet](commands/NumGet.htm)Returns the binary number stored at the specified address+offset.[NumPut](commands/NumPut.htm)Stores a number in binary format at the specified address+offset.[ObjAddRef / ObjRelease](commands/ObjAddRef.htm)Increments or decrements an object's [reference count](Objects.htm#Reference_Counting).[ObjBindMethod](commands/ObjBindMethod.htm)Creates a [BoundFunc object](objects/Functor.htm#BoundFunc) which calls a method of a given object.[ObjGetBase](objects/Object.htm#GetBase)Retrieves an object's [base object](Objects.htm#Custom_Objects).[ObjRawGet](objects/Object.htm#RawGet)Retrieves a key-value pair from an object, bypassing the object's [meta-functions](Objects.htm#Meta_Functions).[ObjRawSet](objects/Object.htm#RawSet)Stores or overwrites a key-value pair in an object, bypassing the object's [meta-functions](Objects.htm#Meta_Functions).[ObjSetBase](objects/Object.htm#SetBase)Sets an object's [base object](Objects.htm#Custom_Objects).[ObjXXX](objects/Object.htm)Functions equivalent to the built-in methods of the Object type, such as [ObjInsertAt](objects/Object.htm#InsertAt). It is usually recommended to use the corresponding method instead.[OnClipboardChange](commands/OnClipboardChange.htm#function)Registers a function or [function object](objects/Functor.htm) to run whenever the clipboard's content changes.[OnError](commands/OnError.htm)Specifies a function to run automatically when an unhandled error occurs.[OnExit](commands/OnExit.htm#function)Specifies a function to run automatically when the script exits.[OnMessage](commands/OnMessage.htm)Monitors a message/event.[Ord](commands/Ord.htm)Returns the ordinal value (numeric character code) of the first character in the specified string.[SB\_XXX](commands/GuiControls.htm#StatusBar_Functions)Functions to add text/icons to or divide the bar of a StatusBar control.[StrGet](commands/StrGet.htm)Copies a string from a memory address, optionally converting it between code pages.[StrPut](commands/StrPut.htm)Copies a string to a memory address, optionally converting it between code pages.[RegisterCallback](commands/RegisterCallback.htm)Creates a machine-code address that when called, redirects the call to a function in the script.[Trim / LTrim / RTrim](commands/Trim.htm)Trims characters from the beginning and/or end of a string.[TV\_XXX](commands/TreeView.htm#BuiltIn)Functions to add, modify or delete TreeView items, or to get data from them.[VarSetCapacity](commands/VarSetCapacity.htm)Enlarges a variable's holding capacity or frees its memory.

### Math

FunctionDescription[Abs](commands/Math.htm#Abs)Returns the absolute value of _Number_.[Ceil](commands/Math.htm#Ceil)Returns _Number_ rounded up to the nearest integer (without any .00 suffix).[Exp](commands/Math.htm#Exp)Returns _e_ (which is approximately 2.71828182845905) raised to the _N_ th power.[Floor](commands/Math.htm#Floor)Returns _Number_ rounded down to the nearest integer (without any .00 suffix).[Log](commands/Math.htm#Log)Returns the logarithm (base 10) of _Number_.[Ln](commands/Math.htm#Ln)Returns the natural logarithm (base e) of _Number_.[Max](commands/Math.htm#Max) / [Min](commands/Math.htm#Min)Returns the highest/lowest value of one or more numbers.[Mod](commands/Math.htm#Mod)Returns the remainder when _Dividend_ is divided by _Divisor_.[Round](commands/Math.htm#Round)Returns _Number_ rounded to _N_ decimal places.[Sqrt](commands/Math.htm#Sqrt)Returns the square root of _Number_.[Sin](commands/Math.htm#Sin) / [Cos](commands/Math.htm#Cos) / [Tan](commands/Math.htm#Tan)Returns the trigonometric sine/cosine/tangent of _Number_.[ASin](commands/Math.htm#ASin) / [ACos](commands/Math.htm#ACos) / [ATan](commands/Math.htm#ATan)Returns the arcsine/arccosine/arctangent in radians.

### COM

FunctionDescription[ComObjActive](commands/ComObjActive.htm)Retrieves a registered COM object.[ComObjArray](commands/ComObjArray.htm)Creates a SAFEARRAY for use with COM.[ComObjConnect](commands/ComObjConnect.htm)Connects a COM object's event sources to functions with a given prefix.[ComObjCreate](commands/ComObjCreate.htm)Creates a COM object.[ComObject](commands/ComObjActive.htm)Creates an object representing a typed value to be passed as a parameter or return value.[ComObjEnwrap / ComObjUnwrap](commands/ComObjActive.htm)Wraps/unwraps a COM object.[ComObjError](commands/ComObjError.htm)Enables or disables notification of COM errors.[ComObjFlags](commands/ComObjFlags.htm)Retrieves or changes flags which control a COM wrapper object's behaviour.[ComObjGet](commands/ComObjGet.htm)Returns a reference to an object provided by a COM component.[ComObjMissing](commands/ComObjActive.htm)Creates a "missing parameter" object to pass to a COM method.[ComObjParameter](commands/ComObjActive.htm)Wraps a value and type to pass as a parameter to a COM method.[ComObjQuery](commands/ComObjQuery.htm)Queries a COM object for an interface or service.[ComObjType](commands/ComObjType.htm)Retrieves type information from a COM object.[ComObjValue](commands/ComObjValue.htm)Retrieves the value or pointer stored in a COM wrapper object.

### Other Functions

[Polyethene's Command Functions](https://github.com/polyethene/AutoHotkey-Scripts/blob/master/Functions.ahk): Provides a callable function for each AutoHotkey command that has an OutputVar. This library can be included in any script via [#Include](commands/_Include.htm).

