# Concepts and Conventions

This document covers some general concepts and conventions used by AutoHotkey, with focus on explanation rather than code. The reader is not assumed to have any prior knowledge of scripting or programming, but should be prepared to learn new terminology.

For more specific details about syntax, see [Scripting Language](Language.htm).

## Table of Contents

- [Values](#values)
  - [Strings](#strings)
  - [Numbers](#numbers)
  - [Boolean](#boolean)
  - [Nothing](#nothing)
  - [Objects](#objects)
  - [Object Protocol](#object-protocol)
- [Variables](#variables)
  - [Uninitialised Variables](#uninitialised-variables)
  - [Built-in Variables](#built-in-variables)
  - [Environment Variables](#environment-variables)
  - [Caching](#caching)
- [Functions/Commands](#functions)
- [Control Flow](#control-flow)
- [Details](#details)
  - [String Encoding](#string-encoding)
  - [Pure Numbers](#pure-numbers)
  - [Names](#names)
  - [Variable References vs Values](#variable-references)
  - [References to Objects](#references-to-objects)

## Values

A _value_ is simply a piece of information within a program. For example, the name of a key to send or a program to run, the number of times a hotkey has been pressed, the title of a window to activate, or whatever else has some meaning within the program or script.

AutoHotkey supports these types of values:

- [Strings](#strings) (text)
- [Numbers](#numbers) (integers and floating-point numbers)
- [Objects](#objects)

Some other related concepts:

- [Boolean](#boolean)
- [Nothing](#nothing)

### Strings

A _string_ is simply text. Each string is actually a sequence or _string_ of characters, but can be treated as a single entity. The _length_ of a string is the number of characters in the sequence, while the _position_ of a character in the string is merely that character's sequential number. By convention in AutoHotkey, the first character is at position 1.

**Numeric strings:** A string of digits (or any other supported [number format](#numbers)) is automatically interpreted as a number when a math operation or comparison requires it. In AutoHotkey v1, comparisons are performed numerically if both values are numeric even if both values are strings. However, a quoted string (or the result of concatenating with a quoted string) is never considered numeric when used directly in an expression.

How literal text should be written within the script depends on the context. For details, see [Legacy Syntax](Language.htm#legacy-syntax) and [Strings (in expressions)](Language.htm#strings).

For a more detailed explanation of how strings work, see [String Encoding](#string-encoding).

### Numbers

AutoHotkey supports these number formats:

- Decimal integers, such as`123`, `00123` or `-1`.
- Hexadecimal integers, such as`0x7B`, `0x007B` or `-0x1`.
- Decimal floating-point numbers, such as`3.14159`.

Hexadecimal numbers must use the `0x` or `0X` prefix, except where noted in the documentation. This prefix must be written after the `+` or `-` sign, if present, and before any leading zeroes. For example, `0x001` is valid, but `000x1` is not.

Numbers written with a decimal point are always considered to be floating-point, even if the fractional part is zero. For example, `42` and `42.0` are usually interchangeable, but not always. Scientific notation is also recognized, but only if a decimal point is present (e.g. `1.0e4` and `-2.1E-4`).

The decimal separator is always a dot, even if the user's regional settings specify a comma.

When a number is converted to a string, it is formatted according to the current [integer or float format](commands/SetFormat.htm#remarks). Although the [SetFormat](commands/SetFormat.htm) command can be used to change the current format, it is usually better to use the [Format](commands/Format.htm) function to format a string. Floating-point numbers can also be formatted by using the [Round](commands/Math.htm#Round) function.

For details about the range and accuracy of numeric values, see [Pure Numbers](#pure-numbers).

### Boolean

A _boolean_ value can be either _true_ or _false_. Boolean values are used to represent anything that has exactly two possible states, such as the _truth_ of an expression. For example, the expression `(x <= y)` is _true_ when x has lesser or equal value to y. A boolean value could also represent _yes_ or _no_, _on_ or _off_, _down_ or _up_ (such as for [GetKeyState](commands/GetKeyState.htm#function)) and so on.

AutoHotkey does not have a specific boolean type, so it uses the integer value `0` to represent false and `1` to represent true. When a value is required to be either true or false, a blank or zero value is considered false and all other values are considered true. (Objects are always considered true.)

The words `true` and `false` are [built-in variables](#built-in-variables) containing 1 and 0. They can be used to make a script more readable.

### Nothing

AutoHotkey does not have a value which uniquely represents _nothing_, _null_, _nil_ or _undefined_, as seen in other languages. Instead, an empty string (a string of zero length) often has this meaning.

If a [variable](#variables) or parameter is said to be "empty" or "blank", that usually means an empty string (a string of zero length).

### Objects

There are generally two ways of viewing objects:

- An object contains a group of values, allowing the group itself to be treated as one value. For example, an object could contain an_array_ or sequence of items, or a set of related values, such as the X and Y coordinates of a position on the screen. Objects can be used to build complex structures by combining them with other objects.
- An object can represent a_thing_, a _service_, or something else, and can provide ways for the script to interact with this thing or service. For example, a _BankAccount_ object might have properties such as the account number, current balance and the owner of the account, and methods to withdraw or deposit an amount.

The proper use of objects (and in particular, [classes](Objects.htm#Custom_Classes)) can result in code which is _modular_ and _reusable_. Modular code is usually easier to test, understand and maintain. For instance, one can improve or modify one section of code without having to know the details of other sections, and without having to make corresponding changes to those sections. Reusable code saves time, by avoiding the need to write and test code for the same or similar tasks over and over.

When you assign an object to a [variable](#variables), as in `myObj := {}`, what you store is not the object itself, but a [_reference_](#references-to-objects) to the object. Copying that variable, as in `yourObj := myObj`, creates a new reference to the _same_ object. A change such as `myObj.ans := 42` would be reflected by both `myObj.ans` and `yourObj.ans`, since they both refer to the same object. However, `myObj := Object()` only affects the variable _myObj_, not the variable _yourObj_, which still refers to the original object.

### Object Protocol

This section builds on these concepts which are covered in later sections: [variables](#variables), [functions](#functions)

Objects work through the principle of _message passing_. You don't know where an object's code or variables actually reside, so you must pass a message to the object, like "give me _foo_" or "go do _bar_", and rely on the object to respond to the message. Objects in AutoHotkey support the following basic messages:

- **Get** a value.
- **Set** a value, denoted by `:=`.
- **Call** a method, denoted by `()`.

Each message can optionally have one or more [parameters](#parameters) (and, for **Set**, the value). Usually there is at least one parameter, and it is interpreted as the name of a property or method, a key or an array index, depending on the object and how you're using it. The parameters of a message are specified using three different patterns: `.Name`, `[Parameters]` and `(Parameters)`, where _Name_ is a literal [name or identifier](#names), and _Parameters_ is a list of parameters (as sub-expressions), which can be empty/blank ( `[]` or `()`).

For **Get** and **Set**, `.Name` and `[Parameters]` can be used interchangeably, or in combination:

```
myObj[arg1, arg2, ..., argN]
myObj.name
myObj.name[arg2, ..., argN]

```

For **Call**, `.Name` and `[Parameter]` can be used interchangeably, and must always be followed by `(Parameters)`:

```
myObj.name(arg2, ..., argN)
myObj[arg1](arg2, ..., argN)

```

Notice that if `name` is present, it becomes the first parameter. `myObj.name` is equivalent to `myObj["name"]`, while `myObj.123` is equivalent to `myObj[123]`. This is true for every type of object, so it is always possible to compute the name of a property or method at runtime, rather than hard-coding it into the script.

Although _name_ or _arg1_ is considered to be the first parameter, remember that these are just _messages_, and the object is free to handle them in any way. In a method call such as those shown above, usually the object uses _name_ or _arg1_ to identify which method should be called, and then only _arg2_ and beyond are passed to the method. In effect, _arg2_ becomes the method's first apparent parameter.

Generally, **Set** has the same meaning as an assignment, so it uses the same operator:

```
myObj[arg1, arg2, ..., argN] := value
myObj.name := value
myObj.name[arg2, ..., argN] := value

```

Currently there is also a "hybrid" syntax allowed with **Set**, but it is best not to use it:

```
myObj.name(arg2, ..., argN) := value

```

Technically, `value` is passed as the last the parameter of the _Set_ message; however, this detail is almost never relevant to script authors. Generally one can simply think of it as "the value being assigned".

## Variables

A variable allows you to use a name as a placeholder for a value. Which value that is could change repeatedly during the time your script is running. For example, a hotkey could use a variable `press_count` to count the number of times it is pressed, and send a different key whenever `press_count` is a multiple of 3 (every third press). Even a variable which is only assigned a value once can be useful. For example, a `WebBrowserTitle` variable could be used to make your code easier to update when and if you were to change your preferred web browser, or if the [title](misc/WinTitle.htm) or [window class](misc/WinTitle.htm#ahk_class) changes due to a software update.

In AutoHotkey, variables are created simply by using them. Each variable is _not_ permanently restricted to a single [data type](#values), but can instead hold a value of any type: string, number or object. Each variable starts off empty/blank; in other words, each newly created variable contains an empty string until it is assigned some other value.

A variable has three main aspects:

- The variable's_name_.
- The variable itself.
- The variable's_value_.

Certain restrictions apply to variable names - see [Names](#names) for details. In short, it is safest to stick to names consisting of ASCII letters (which are case insensitive), digits and underscore, and to avoid using names that start with a digit.

A variable name has **_scope_**, which defines where in the code that name can be used to refer to that particular variable; in other words, where the variable is _visible_. If a variable is not visible within a given scope, the same name can refer to a different variable. Both variables might exist at the same time, but only one is visible to each part of the script. [Global variables](Functions.htm#Global) are visible in the "global scope" (that is, outside of functions), but must usually be [declared](Functions.htm#Global) to make them visible inside a function. [Local variables](Functions.htm#Local) are visible only inside the function which created them.

A variable can be thought of as a container or storage location for a value, so you'll often find the documentation refers to a variable's value as _the contents of the variable_. For a variable `x := 42`, we can also say that the variable x has the number 42 as its value, or that the value of x is 42.

It is important to note that a variable and its value are not the same thing. For instance, we might say " `myArray` is an array", but what we really mean is that myArray is a variable containing a reference to an array. We're taking a shortcut by using the name of the variable to refer to its value, but "myArray" is really just the name of the variable; the array object doesn't know that it has a name, and could be referred to by many different variables (and therefore many names).

### Uninitialised Variables

To _initialise_ a variable is to assign it a starting value. Although the program automatically initialises all variables (an empty string being the default value), it is good practice for a script to always initialise its variables before use. That way, anyone reading the script can see what variables the script will be using and what starting values they are expected to have.

It is usually necessary for the script to initialise any variable which is expected to hold a number. For example, `x := x + 1` will not work if x has never been assigned a value, since the _empty string_ is considered to be non-numeric. The script should have assigned a starting value, such as `x := 0`. There are some cases where empty values _are_ assumed to be 0, but it is best not to rely on this.

Script authors can use the [#Warn](commands/_Warn.htm) directive to help find instances where a variable is used without having been initialised by the script.

### Built-in Variables

A number of useful variables are built into the program and can be referenced by any script. With the exception of [Clipboard](misc/Clipboard.htm), [ErrorLevel](misc/ErrorLevel.htm), and [command line parameters](Scripts.htm#cmd), these variables are read-only; that is, their contents cannot be directly altered by the script. By convention, most of these variables start with the prefix `A_`, so it is best to avoid using this prefix for your own variables.

Some variables such as [A\_KeyDelay](Variables.htm#KeyDelay) and [A\_TitleMatchMode](Variables.htm#TitleMatchMode) represent settings that control the script's behavior, and retain separate values for each [thread](misc/Threads.htm). This allows subroutines launched by new threads (such as for hotkeys, menus, timers and such) to change settings without affecting other threads.

Some special variables are not updated periodically, but rather their value is retrieved or calculated whenever the script references the variable. For example, [Clipboard](misc/Clipboard.htm) retrieves the current contents of the clipboard as text, and [A\_TimeSinceThisHotkey](Variables.htm#TimeSinceThisHotkey) calculates the number of milliseconds that have elapsed since the hotkey was pressed.

Related: [list of built-in variables](Variables.htm#BuiltIn).

### Environment Variables

Environment variables are maintained by the operating system. You can see a list of them at the command prompt by typing SET then pressing Enter.

A script may create a new environment variable or change the contents of an existing one with [EnvSet](commands/EnvSet.htm). Such additions and changes are not seen by the rest of the system. However, any programs or scripts which the script launches by calling [Run](commands/Run.htm) or [RunWait](commands/Run.htm) usually inherit a copy of the parent script's environment variables.

It is recommended that all new scripts retrieve environment variables such as Path via [EnvGet](commands/EnvGet.htm):

```
EnvGet, OutputVar, Path  <em>; For explanation, see #NoEnv.</em>
```

If a script lacks the [#NoEnv](commands/_NoEnv.htm) directive, reading an empty variable will instead return the value of the environment variable with that name, if there is one. This can cause confusion, so it is recommended that all new scripts use #NoEnv.

### Caching

Although a variable is typically thought of as holding a single value, and that value having a distinct type (string, number or object), AutoHotkey automatically converts between numbers and strings in cases like `myString + 1` and `MsgBox %myNumber%`. As these conversions can happen very frequently, whenever a variable is converted, the result is _cached_ in the variable.

In effect, a variable can contain both a string and a number simultaneously. Usually this just improves the script's performance with no down-sides, but if a variable contains both a number and a string, is it number, or is it a string? This ambiguity causes unexpected behavior in at least two cases:

1. COM objects. In order to pass parameters to a COM object, the program must convert the variable's content to either a number_or_ a string. Some COM objects throw an exception if the wrong type of value is passed. If a variable has both, the number is used. Usually this gets the right result, but sometimes it doesn't.
2. Objects don't have the capability to store both a number and a string as a key or value. Since numbers are more memory-efficient, if a variable has both, the number is used (except for floating-point values used as keys).

[SetFormat](commands/SetFormat.htm)'s slow mode forces the assignment of a pure number to immediately convert that number to a string. For integers, the number is also stored, so this doesn't have adverse effects other than to performance. For floats, the number is not stored, since SetFormat affects the precision of the value, possibly even truncating all decimal places. In other words, SetFormat's slow mode prevents pure floats from being stored in variables.

Taking the address of a variable effectively converts the variable's value to a string, disabling caching until the variable's address changes (this happens when its capacity changes). This is both for backward-compatibility and because the script could change the value indirectly via its address at any time, making the cache inaccurate.

### Related

- [Variables](Variables.htm#Intro): basic usage and examples.
- [Variable Capacity and Memory](Variables.htm#cap): details about limitations.

## Functions/Commands

A _function_ or _command_ is the basic means by which a script _does something_.

In essence, functions and commands are the same thing, so the concepts explained here apply to both. However, the long history of AutoHotkey v1 and an emphasis on backward-compatibility have resulted in a divide between _commands_, which require legacy syntax, and _functions_, which require expression syntax.

Commands and functions can have many different purposes. Some functions might do no more than perform a simple calculation, while others have immediately visible effects, such as moving a window. One of AutoHotkey's strengths is the ease with which scripts can automate other programs and perform many other common tasks by simply calling a few functions. See the [command and function list](commands/index.htm) for examples.

Throughout this documentation, some common words are used in ways that might not be obvious to someone without prior experience. Below are several such words/phrases which are used frequently in relation to functions and commands:

Call a function or command

_Calling_ a function or command causes the program to invoke, execute or evaluate it. In other words, a _function call_ temporarily transfers control from the script to the function. When the function has completed its purpose, it _returns_ control to the script. In other words, any code following the function call does not execute until after the function completes.

However, sometimes a function or command completes before its effects can be seen by the user. For example, the [Send](commands/Send.htm) command _sends_ keystrokes, but may return before the keystrokes reach their destination and cause their intended effect.

Parameters

Usually a command or function accepts _parameters_ which tell it how to operate or what to operate on. Each parameter is a [value](#values), such as a string or number. For example, [WinMove](commands/WinMove.htm) moves a window, so its parameters tell it which window to move and where to move it to. Parameters can also be called _arguments_. Common abbreviations include _param_ and _arg_.

Pass parameters

Parameters are _passed_ to a function or command, meaning that a value is specified for each parameter of the function or command when it is called. For example, one can _pass_ the name of a key to [GetKeyState()](commands/GetKeyState.htm#function) to determine whether that key is being held down.

Return a value

Functions _return_ a value, so the result of the function is often called a _return value_. For example, [StrLen()](commands/StrLen.htm) returns the number of characters in a string. Commands do not return a result directly; instead, they store the result in a [variable](#variables). Functions may also do this, such as when there is more than one result.

Functions and commands usually expect parameters to be written in a specific order, so the meaning of each parameter value depends on its position in the comma-delimited list of parameters. Some parameters can be omitted, in which case the parameter can be left blank, but the comma following it can only be omitted if all remaining parameters are also omitted. For example, the syntax for [ControlSend](commands/ControlSend.htm) is:

```
<span class="func">ControlSend</span> <span class="optional">, Control, Keys, WinTitle, WinText, ExcludeTitle, ExcludeText</span>
```

Square brackets signify that the enclosed parameters are optional (the brackets themselves should not appear in the actual code). However, ControlSend isn't useful unless _Keys_ are specified, and usually one must also specify the target window. For example:

```
ControlSend, Edit1, ^{Home}, A  <em>; Correct. Control is specified.</em>
ControlSend, ^{Home}, A         <em>; Incorrect: Parameters are mismatched.</em>
ControlSend,, ^{Home}, A        <em>; Correct. Control is omitted.</em>

```

### Methods

_Methods_ are functions which operate on a particular [object](#objects). While there can only be one function named `Send` (for example), there can be as many methods named `Send` as there are objects, as each object (or class of objects) can respond in a different way. For this reason, the target object (which may be a variable or sub-expression) is specified to left of the method name instead of inside the parameter list. For details, see [Object Protocol](#object-protocol).

## Control Flow

_Control flow_ is the order in which individual statements are executed. Normally statements are executed sequentially from top to bottom, but a control flow statement can override this, such as by specifying that statements should be executed repeatedly, or only if a certain condition is met.

Statement

A _statement_ is simply the smallest standalone element of the language that expresses some action to be carried out. In AutoHotkey, statements include commands, assignments, function calls and other expressions. However, directives, labels (including hotkeys and hotstrings), and declarations without assignments are not statements; they are processed when the program first starts up, before the script _executes_.

Execute

Carry out, perform, evaluate, put into effect, etc. _Execute_ basically has the same meaning as in non-programming speak.

Body

The _body_ of a control flow statement is the statement or group of statements to which it applies. For example, the body of an [if statement](Language.htm#if-statement) is executed only if a specific condition is met.

For example, consider this simple set of instructions:

1. Open Notepad
2. Wait for Notepad to appear on the screen
3. Type "Hello, world!"

We take one step at a time, and when that step is finished, we move on to the next step. In the same way, control in a program or script usually flows from one statement to the next statement. But what if we want to type into an existing Notepad window? Consider this revised set of instructions:

1. If Notepad is not running:
   1. Open Notepad
   2. Wait for Notepad to appear on the screen
2. Otherwise:
   1. Activate Notepad
3. Type "Hello, world!"

So we either open Notepad or activate Notepad depending on whether it is already running. #1 is a _conditional statement_, also known as an _if statement_; that is, we execute its _body_ (#1.1 - #1.2) only if a condition is met. #2 is an _else statement_; we execute its body (#2.1) only if the condition of a previous _if statement_ (#1) is not met. Depending on the condition, control _flows_ one of two ways: #1 (if true) → #1.1 → #1.2 → #3; or #1 (if false) → #2 (else) → #2.1 → #3.

The instructions above can be translated into the code below:

```
if (not WinExist("ahk_class Notepad"))
{
    Run Notepad
    WinWait ahk_class Notepad
}
else
    WinActivate ahk_class Notepad
Send Hello`, world!

```

In our written instructions, we used indentation and numbering to group the statements. Scripts work a little differently. Although indentation makes code easier to read, in AutoHotkey it does not affect the grouping of statements. Instead, statements are grouped by enclosing them in braces, as shown above. This is called a [_block_](commands/Block.htm).

For details about syntax - that is, how to write or recognise control flow statements in AutoHotkey - see [Control Flow](Language.htm#control-flow).

## Details

### String Encoding

Each character in the string is represented by a number, called its _ordinal number_, or _character code_. For example, the value "Abc" would be represented as follows:

Abc6598990

**Encoding:** The _encoding_ of a string defines how symbols are mapped to ordinal numbers, and ordinal numbers to bytes. There are many different encodings, but as all of those supported by AutoHotkey include ASCII as a subset, character codes 0 to 127 always have the same meaning. For example, 'A' always has the character code 65.

**Null-termination:** Each string is terminated with a "null character", or in other words, a character with binary value zero marks the end of the string. The length of the string does not need to be stored as it can be inferred by the position of the null-terminator. For performance, AutoHotkey sometimes also stores the length, such as when a string is stored in a variable.

**Note:** Due to reliance on null-termination, AutoHotkey v1 does not generally support strings with embedded null characters. Such strings can be created with [VarSetCapacity()](commands/VarSetCapacity.htm) and [NumPut()](commands/NumPut.htm) or [DllCall()](commands/DllCall.htm), but may produce inconsistent results.

**Native encoding:** Although AutoHotkey provides ways to work with text in various encodings, the built-in commands and functions--and to some degree the language itself--all assume string values to be in one particular encoding. This is referred to as the _native_ encoding. The native encoding depends on the version of AutoHotkey:

- Unicode versions of AutoHotkey use UTF-16. The smallest element in a UTF-16 string is two bytes (16 bits). Unicode characters in the range 0 to 65535 (U+FFFF) are represented by a single 16-bit code unit of the same value, while characters in the range 65536 (U+10000) to 1114111 (U+10FFFF) are represented by a _surrogate pair_; that is, exactly two 16-bit code units between 0xD800 and 0xDFFF. (For further explanation of surrogate pairs and methods of encoding or decoding them, search the Internet.)

- ANSI versions of AutoHotkey use the system default ANSI code page, which depends on the system locale or "language for non-Unicode programs" system setting. The smallest element of an ANSI string is one byte. However, some code pages contain characters which are represented by sequences of multiple bytes (these are always non-ASCII characters).


**Character:** Generally, other parts of this documentation use the term "character" to mean a string's smallest unit; bytes for ANSI strings and 16-bit code units for Unicode (UTF-16) strings. For practical reasons, the length of a string and positions within a string are measured by counting these fixed-size units, even though they may not be complete Unicode characters.

[FileRead](commands/FileRead.htm), [FileAppend](commands/FileAppend.htm), [FileOpen()](commands/FileOpen.htm) and the [File object](objects/File.htm) provide ways of reading and writing text in files with a specific encoding.

The functions [StrGet](commands/StrGet.htm) and [StrPut](commands/StrPut.htm) can be used to convert strings between the native encoding and some other specified encoding. However, these are usually only useful in combination with data structures and the [DllCall](commands/DllCall.htm) function. Strings which are passed directly to or from [DllCall()](commands/DllCall.htm) can be converted to ANSI or UTF-16 by using the `AStr` or `WStr` parameter types.

Techniques for dealing with the differences between ANSI and Unicode versions of AutoHotkey can be found under [Unicode vs ANSI](Compat.htm#Format).

### Pure Numbers

A _pure_ or _binary_ number is one which is stored in memory in a format that the computer's CPU can directly work with, such as to perform math. In most cases, AutoHotkey automatically converts between numeric strings and pure numbers as needed, and rarely differentiates between the two types. AutoHotkey primarily uses two data types for pure numbers:

- 64-bit signed integers ( _int64_).
- 64-bit binary floating-point numbers (the_double_ or _binary64_ format of the IEEE 754 international standard).

In other words, scripts are affected by the following limitations:

- Integers must be within the range -9223372036854775808 (-0x8000000000000000, or -263) to 9223372036854775807 (0x7FFFFFFFFFFFFFFF, or 263-1). Although larger values can be contained within a string, any attempt to convert the string to a number (such as by using it in a math operation) might yield inconsistent results.

- Floating-point numbers generally support 15 digits of precision. However, converting a floating-point number to a string causes the number to be rounded according to the current [float format](commands/SetFormat.htm#Float), which defaults to 6 decimal places. If the "slow" mode of [SetFormat](commands/SetFormat.htm) is present anywhere in the script, numbers are _always_ converted to strings when assigned to a [variable](#variables).


**Note:** There are some decimal fractions which the binary floating-point format cannot precisely represent, so a number is rounded to the closest representable number. This may lead to unexpected results. For example:

```
SetFormat FloatFast, 0.17  <em>; Show "over-full" precision</em>
MsgBox % 0.1 + 0           <em>; 0.10000000000000001</em>
MsgBox % 0.1 + 0.2         <em>; 0.30000000000000004</em>
MsgBox % 0.3 + 0           <em>; 0.29999999999999999</em>
MsgBox % 0.1 + 0.2 = 0.3   <em>; 0 (not equal)</em>

```

One strategy for dealing with this is to avoid direct comparison, instead comparing the difference. For example:

```
MsgBox % Abs((0.1 + 0.2) - (0.3)) < 0.0000000000000001

```

Another strategy is to always convert to string (thereby applying rounding) before comparison. There are generally two ways to do this while specifying the precision, and both are shown below:

```
MsgBox % Round(0.1 + 0.2, 15) = Format("{:.15f}", 0.3)

```

### Names

AutoHotkey uses the same set of rules for naming various things, including variables, functions, [window groups](commands/GroupAdd.htm), [GUIs](commands/Gui.htm), classes and methods:

- **Case sensitivity:** None for ASCII characters. For example, `CurrentDate` is the same as `currentdate`. However, uppercase non-ASCII characters such as 'Ä' are _not_ considered equal to their lowercase counterparts, regardless of the current user's locale. This helps the script to behave consistently across multiple locales.
- **Maximum length:** 253 characters.
- **Allowed characters:** Letters, numbers, non-ASCII characters, and the following symbols: \_ # @ $

Due to style conventions, it is generally better to name your variables using only letters, numbers, and the underscore character (for example: _CursorPosition_, _Total\_Items_, and _entry\_is\_valid_). This style allows people familiar with other computer languages to understand your scripts more easily.

Although a [variable](#variables) name may consist entirely of digits, this is generally used only for [incoming command line parameters](Scripts.htm#cmd_args_old). Such numeric names cannot be used in expressions because they would be seen as numbers rather than variables. It is best to avoid starting a name with a digit, as such names are confusing and will be considered invalid in AutoHotkey v2.

As the following characters may be reserved for other purposes in AutoHotkey v2, it is recommended to avoid using them: # @ $

Property names in classes have the same rules and restrictions as variable names, except that the three characters listed above (# @ $) are not allowed. Although they can be used in a method definition, calling such a method requires using square brackets. For example, `myObject.@home()` is not valid, but `myObject["@home"]()` is acceptable.

### Variable References vs Values

Variables have certain attributes that blur the line between a variable and its value, but it is important to make the distinction. In particular, consider [objects](#objects) and ByRef parameters.

Although we may say the variable `myArray` _contains_ an array (which is a type of object), what the variable contains isn't the array itself but rather a _reference or pointer_ to the array. Any number of variables can contain a reference to the same object. It may be helpful to think of a variable as just a name in that case. For instance, giving a person a nickname doesn't cause a clone of that person to come into existence.

By default, variables are passed to user-defined functions _by value_. In other words, the value contained by the variable is copied into the variable which corresponds to the function's parameter. **ByRef** parameters allow you to pass a variable _by reference_, or in other words, to make one parameter of the function an _alias_ for your variable, allowing the function to assign a new value to your variable.

Because a variable only ever contains a _reference_ to an object and not the object itself, when you pass such a variable to a non-ByRef parameter, what the function receives is a reference to the same object. This allows the function to modify the object, but it does not allow the function to modify the _variable_ which the function's caller used, because the function only has a reference to the object, not the variable.

### References to Objects

Scripts interact with an object only indirectly, through a _reference_ to the object. When you create an object, the object is created at some location you don't control, and you're given a reference. Passing this reference to a function or storing it in a variable or another object creates a new reference to the _same_ object. You release a reference by simply using an assignment to replace it with any other value. An object is deleted only after all references have been released; you cannot delete an object explicitly, and should not try.

```
ref1 := Object()  <em>; Create an object and store first reference</em>
ref2 := ref1      <em>; Create a new reference to the same object</em>
ref1 := ""        <em>; Release the first reference</em>
ref2 := ""        <em>; Release the second reference; object is deleted</em>

```

If that's difficult to understand, try thinking of an object as a rental unit. When you rent a unit, you're given a key which you can use to access the unit. You can get more keys and use them to access the same unit, but when you're finished with the unit, you must hand all keys back to the rental agent. Usually a unit wouldn't be _deleted_, but maybe the agent will have any junk you left behind removed; just as any values you stored in an object are freed when the object is deleted.

