# Regular Expression Callouts [AHK\_L 14+]

RegEx callouts provide a means of temporarily passing control to the script in the middle of regular expression pattern matching. For detailed information about the PCRE-standard callout feature, see [pcre.txt](http://www.pcre.org/pcre.txt).

RegEx callouts are currently supported only by [RegExMatch()](../commands/RegExMatch.htm) and [RegExReplace()](../commands/RegExReplace.htm).

## Table of Contents

- [Syntax](#syntax)
- [RegEx Callout Functions](#callout-functions)
- [EventInfo](#EventInfo)
- [Auto-Callout](#auto)
- [Remarks](#remarks)

## Syntax

The syntax for a RegEx callout in AutoHotkey is (?C _Number_: _Function_), where both _Number_ and _Function_ are optional. Colon ':' is allowed only if _Function_ is specified, and is optional if _Number_ is omitted. If _Function_ is specified but is not the name of a user-defined function, a compile error occurs and pattern-matching does not begin.

If _Function_ is omitted, the function name must be specified in a variable named **pcre\_callout**. If both a global variable and local variable exist with this name, the local variable takes precedence. If _pcre\_callout_ does not contain the name of a user-defined function, RegEx callouts which omit _Function_ are ignored.

## RegEx Callout Functions

```
Function(Match, CalloutNumber, FoundPos, Haystack, NeedleRegEx)
{
    ...
}

```

RegEx callout functions may define up to 5 parameters:

- **Match**: Equivalent to the _OutputVar_ of RegExMatch(), including the creation of array variables if appropriate.
- **CalloutNumber**: Receives the _Number_ of the RegEx callout.
- **FoundPos**: Receives the position of the current potential match.
- **Haystack**: Receives the _Haystack_ passed to RegExMatch() or RegExReplace().
- **NeedleRegEx**: Receives the _NeedleRegEx_ passed to RegExMatch() or RegExReplace().

These names are suggestive only. Actual names may vary.

**Warning:** Changing the input parameters of [RegExReplace()](../commands/RegExReplace.htm) or [RegExMatch()](../commands/RegExMatch.htm) during a call is unsupported and may cause unpredictable behaviour.

Pattern-matching may proceed or fail depending on the return value of the RegEx callout function:

- If the function returns**0** or does not return a numeric value, matching proceeds as normal.
- If the function returns**1** or greater, matching fails at the current point, but the testing of other matching possibilities goes ahead.
- If the function returns**-1**, matching is abandoned.
- If the function returns a value less than -1, it is treated as a PCRE error code and matching is abandoned. RegExMatch() returns a blank string, while RegExReplace() returns the original_Haystack_. In either case, ErrorLevel contains the error code.

For example:

```
Haystack := "The quick brown fox jumps over the lazy dog."
RegExMatch(Haystack, "i)(The) (\w+)\b(?CCallout)")
Callout(m) {
    MsgBox m=%m%`nm1=%m1%`nm2=%m2%
    return 1
}
```

In the above example, _Callout_ is called once for each substring which matches the part of the pattern preceding the RegEx callout. \\b is used to exclude incomplete words in matches such as _The quic_, _The qui_, _The qu_, etc.

## EventInfo

Additional information is available by accessing the pcre\_callout\_block structure via **A\_EventInfo**.

```
version           := NumGet(A_EventInfo,  0, "Int")
callout_number    := NumGet(A_EventInfo,  4, "Int")
offset_vector     := NumGet(A_EventInfo,  8)
subject           := NumGet(A_EventInfo,  8 + A_PtrSize)
subject_length    := NumGet(A_EventInfo,  8 + A_PtrSize*2, "Int")
start_match       := NumGet(A_EventInfo, 12 + A_PtrSize*2, "Int")
current_position  := NumGet(A_EventInfo, 16 + A_PtrSize*2, "Int")
capture_top       := NumGet(A_EventInfo, 20 + A_PtrSize*2, "Int")
capture_last      := NumGet(A_EventInfo, 24 + A_PtrSize*2, "Int")
pad := A_PtrSize=8 ? 4 : 0  <em>; Compensate for 64-bit data alignment.</em>
callout_data      := NumGet(A_EventInfo, 28 + pad + A_PtrSize*2)
pattern_position  := NumGet(A_EventInfo, 28 + pad + A_PtrSize*3, "Int")
next_item_length  := NumGet(A_EventInfo, 32 + pad + A_PtrSize*3, "Int")
if (version >= 2)
    mark   := StrGet(NumGet(A_EventInfo, 36 + pad + A_PtrSize*3, "Int"), "UTF-8")

```

For more information, see [pcre.txt](http://www.pcre.org/pcre.txt), [NumGet()](../commands/NumGet.htm) and [A\_PtrSize](../Variables.htm#PtrSize).

## Auto-Callout

Including **C** in the options of the pattern enables the auto-callout mode. In this mode, RegEx callouts equivalent to (?C255) are inserted before each item in the pattern. For example, the following template may be used to debug regular expressions:

```
<em>; Set the default RegEx callout function.</em>
pcre_callout := "DebugRegEx"

<em>; Call RegExMatch with auto-callout option C.</em>
RegExMatch("xxxabc123xyz", "C)abc.*xyz")

DebugRegEx(Match, CalloutNumber, FoundPos, Haystack, NeedleRegEx)
{
    <em>; See pcre.txt for descriptions of these fields.</em>
    start_match       := NumGet(A_EventInfo, 12 + A_PtrSize*2, "Int")
    current_position  := NumGet(A_EventInfo, 16 + A_PtrSize*2, "Int")
    pad := A_PtrSize=8 ? 4 : 0
    pattern_position  := NumGet(A_EventInfo, 28 + pad + A_PtrSize*3, "Int")
    next_item_length  := NumGet(A_EventInfo, 32 + pad + A_PtrSize*3, "Int")

    <em>; Point out >>current match<<.</em>
    _HAYSTACK:=SubStr(Haystack, 1, start_match)
        . ">>" SubStr(Haystack, start_match + 1, current_position - start_match)
        . "<<" SubStr(Haystack, current_position + 1)

    <em>; Point out >>next item to be evaluated<<.</em>
    _NEEDLE:=  SubStr(NeedleRegEx, 1, pattern_position)
        . ">>" SubStr(NeedleRegEx, pattern_position + 1, next_item_length)
        . "<<" SubStr(NeedleRegEx, pattern_position + 1 + next_item_length)

    ListVars
    <em>; Press Pause to continue.</em>
    Pause
}
```

## Remarks

RegEx callouts are executed on the current quasi-thread, but the previous value of A\_EventInfo will be restored after the RegEx callout function returns. ErrorLevel is not set until immediately before RegExMatch() or RegExReplace() returns.

PCRE is optimized to abort early in some cases if it can determine that a match is not possible. For all RegEx callouts to be called in such cases, it may be necessary to disable these optimizations by specifying (\*NO\_START\_OPT) at the start of the pattern. This requires [v1.1.05] or later.

