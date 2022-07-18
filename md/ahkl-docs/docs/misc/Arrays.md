# Arrays

In AutoHotkey, there are two different types of things that are related to arrays:

- [Object-based Arrays](#object-based)
- [Pseudo-Arrays](#pseudo) (not recommended for use)

**Note**: The following code examples show different approaches which lead to the same end result.

## Object-based Arrays [AHK\_L 31+]

Such arrays can be [associative arrays](../Objects.htm#Usage_Associative_Arrays) or [simple arrays](../Objects.htm#Usage_Simple_Arrays). Associative arrays are created using the Object function or the brace syntax, while simple arrays are created using the array function or bracket syntax. For more information, see the [AutoHotkey Beginner Tutorial](../Tutorial.htm#s7) or the [Objects page](../Objects.htm).

The following example shows the usage of a simple array:

```
<em>; Create the array, initially empty:</em>
Array := [] <em>; or Array := Array()</em>

<em>; Write to the array:</em>
Loop, Read, %A_WinDir%\system.ini <em>; This loop retrieves each line from the file, one at a time.</em>
{
    Array.Push(A_LoopReadLine) <em>; Append this line to the array.</em>
}

<em>; Read from the array:
; Loop % Array.MaxIndex()   ; More traditional approach.</em>
for index, element in Array <em>; Enumeration is the recommended approach in most cases.</em>
{
    <em>; Using "Loop", indices must be consecutive numbers from 1 to the number
    ; of elements in the array (or they must be calculated within the loop).
    ; MsgBox % "Element number " . A_Index . " is " . Array[A_Index]

    ; Using "for", both the index (or "key") and its associated value
    ; are provided, and the index can be *any* value of your choosing.</em>
    MsgBox % "Element number " . index . " is " . element
}
```

This shows only a small subset of the [functionality](../objects/Object.htm) provided by [objects](../Objects.htm). Items can be set, retrieved, inserted, removed and enumerated. Strings and objects can be used as keys in addition to numbers. Objects can be stored as values in other objects and passed as function parameters or return values. Objects can also be [extended](../Objects.htm#Custom_Objects) with new functionality.

Though Push() and enumerators have their uses, some users might find it easier to use the more traditional approach (the commented out lines are the counterparts using the [pseudo-arrays](#pseudo) described below):

```
  <em>; Each array must be initialized before use:</em>
  Array := []

<em>; Array%j% := A_LoopField</em>
  Array[j] := A_LoopField

<em>; Array%j%_%k% := A_LoopReadLine</em>
  Array[j, k] := A_LoopReadLine

  ArrayCount := 0
  Loop, Read, %A_WinDir%\system.ini
  {
      ArrayCount += 1
    <em>; Array%ArrayCount% := A_LoopReadLine</em>
      Array[ArrayCount] := A_LoopReadLine
  }

  Loop % ArrayCount
  {
    <em>; element := Array%A_Index%</em>
      element := Array[A_Index]
    <em>; MsgBox % "Element number " . A_Index . " is " . Array%A_Index%</em>
      MsgBox % "Element number " . A_Index . " is " . Array[A_Index]
  }

```

_ArrayCount_ is left as a variable for convenience, but can be stored in the array itself with `Array.Count := <i>n</i>` or it can be removed and `Array.<a href="../objects/Object.htm#MinMaxIndex" data-index="11">MaxIndex</a>()` used in its place. If a starting index other than 1 is desired, `Array.<a href="../objects/Object.htm#MinMaxIndex" data-index="12">MinIndex</a>()` can also be used.

## Pseudo-Arrays

**Note**: If possible, always use the object-based array mentioned above. It is superior to a pseudo-array in almost every aspect: it is space-saving, more flexible, clearer, and similar to many other programming languages.

Pseudo-arrays are mostly conceptual: Each array is really just a collection of sequentially numbered [variables](../Variables.htm) or [functions](../Functions.htm), each one being perceived as an _element_ of the array. AutoHotkey does not link these elements together in any way.

In addition to array-creating commands like [StringSplit](../commands/StringSplit.htm) and [WinGet List](../commands/WinGet.htm#List), any command that accepts an OutputVar or that assigns a value to a variable can be used to create an array. The simplest example is the [assignment operator (:=)](../commands/SetExpression.htm), as shown below:

```
Array%j% := A_LoopField
```

Multidimensional arrays are possible by using a separator character of your choice between the indices. For example:

```
Array%j%_%k% := A_LoopReadLine
```

The following example demonstrates how to create and access an array, in this case a series of names retrieved from a text file:

```
<em><strong>; Write to the array:</strong></em>
ArrayCount := 0
Loop, Read, %A_WinDir%\system.ini   <em>; This loop retrieves each line from the file, one at a time.</em>
{
    ArrayCount += 1  <em>; Keep track of how many items are in the array.</em>
    Array%ArrayCount% := A_LoopReadLine  <em>; Store this line in the next array element.</em>
}

<em><strong>; Read from the array:</strong></em>
Loop %ArrayCount%
{
    <em>; The following line uses the := operator to retrieve an array element:</em>
    element := Array%A_Index%  <em>; <a href="../Variables.htm#Index" data-index="18">A_Index</a> is a built-in variable.</em>
    <em>; Alternatively, you could use the "% " prefix to make MsgBox or some other command <a href="../Variables.htm#Expressions" data-index="19">expression-capable</a>:</em>
    MsgBox % "Element number " . A_Index . " is " . Array%A_Index%
}
```

A concept related to arrays is the use of [NumPut()](../commands/NumPut.htm) and [NumGet()](../commands/NumGet.htm) to store/retrieve a collection of numbers in binary format. This might be helpful in cases where performance and/or memory conservation are important.

