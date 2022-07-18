# RegisterCallback() [v1.0.47+]

Creates a machine-code address that when called, redirects the call to a [function](../Functions.htm) in the script.

```
Address := <span class="func">RegisterCallback</span>("FunctionName" <span class="optional">, Options := "", ParamCount := FormalCount, EventInfo := Address</span>)
```

## Parameters

Address

Upon success, RegisterCallback() returns a numeric address that may be called by [DllCall()](DllCall.htm) or anything else capable of calling a machine-code function. Upon failure, it returns an empty string. Failure occurs when _FunctionName_: 1) does not exist; 2) accepts too many or too few parameters according to _ParamCount_; or 3) accepts any [ByRef parameters](../Functions.htm#ByRef).

FunctionName

A [function](../Functions.htm)'s name, which must be enclosed in quotes if it is a literal string. This function is called automatically whenever _Address_ is called. The function also receives the parameters that were passed to _Address_.

[v1.1.06+]: A [function reference](../objects/Func.htm) can be passed instead of a function name.

Options

Specify zero or more of the following words. Separate each option from the next with a space (e.g. `C Fast`).

**Fast** or **F**: Avoids starting a new [thread](../misc/Threads.htm) each time _FunctionName_ is called. Although this performs better, it must be avoided whenever the thread from which _Address_ is called varies (e.g. when the callback is triggered by an incoming message). This is because _FunctionName_ will be able to change global settings such as [ErrorLevel](../misc/ErrorLevel.htm), [A\_LastError](../Variables.htm#LastError), and the [last-found window](../misc/WinTitle.htm#LastFoundWindow) for whichever thread happens to be running at the time it is called. For more information, see [Remarks](#Threads).

**CDecl** or **C**: Makes _Address_ conform to the "C" calling convention. This is typically omitted because the standard calling convention is much more common for callbacks.

ParamCount

The number of parameters that _Address_'s caller will pass to it. If entirely omitted, it defaults to the number of mandatory parameters in the [definition](../Functions.htm#define) of _FunctionName_. In either case, ensure that the caller passes exactly this number of parameters.

EventInfo

An integer that _FunctionName_ will see in [A\_EventInfo](../Variables.htm#EventInfo) whenever it is called via this _Address_. This is useful when _FunctionName_ is called by more than one _Address_. If omitted, it defaults to _Address_. Note: Unlike other global settings, the [current thread](../misc/Threads.htm)'s A\_EventInfo is not disturbed by the [fast mode](#Fast).

If the exe running the script is 32-bit, this parameter must be between 0 and 4294967295. If the exe is 64-bit, this parameter can be a 64-bit integer. Although [A\_EventInfo](../Variables.htm#EventInfo) usually returns an unsigned integer, AutoHotkey does not fully support unsigned 64-bit integers and therefore some operations may cause the value to wrap into the signed range.

## The Callback Function's Parameters

A [function](../Functions.htm) assigned to a callback address may accept up to 31 parameters. [Optional parameters](../Functions.htm#optional) are permitted, which is useful when the function is called by more than one caller.

Interpreting the parameters correctly requires some understanding of how the x86 calling conventions work. Since AutoHotkey does not have typed parameters, the callback's parameter list is assumed to consist of integers, and some reinterpretation may be required.

**AutoHotkey 32-bit:** All incoming parameters are unsigned 32-bit integers. Smaller types are padded out to 32 bits, while larger types are split into a series of 32-bit parameters.

If an incoming parameter is intended to be a signed integer, any negative numbers can be revealed by following either of the following examples:

```
<em>; Method #1</em>
if (wParam > 0x7FFFFFFF)
    wParam := -(~wParam) - 1

<em>; Method #2: Relies on the fact that AutoHotkey natively uses signed 64-bit integers.</em>
wParam := wParam << 32 >> 32
```

**AutoHotkey 64-bit:** All incoming parameters are signed 64-bit integers. AutoHotkey does not natively support unsigned 64-bit integers. Smaller types are padded out to 64 bits, while larger types are always passed by address.

**AutoHotkey 32-bit/64-bit:** If an incoming parameter is intended to be 8-bit or 16-bit (or 32-bit on x64), the upper bits of the value might contain "garbage" which can be filtered out by using bitwise-and, as in the following examples:

```
Callback(UCharParam, UShortParam, UIntParam) {
    UCharParam &= 0xFF
    UShortParam &= 0xFFFF
    UIntParam &= 0xFFFFFFFF
    <em>;...</em>
}
```

If an incoming parameter is intended by its caller to be a string, what it actually receives is the address of the string. To retrieve the string itself, use [StrGet()](StrGet.htm):

```
MyString := StrGet(MyParameter)  <em>; Requires <span class="ver">[AHK_L 46+]</span></em>
```

If an incoming parameter is the address of a structure, the individual members may be extracted by following the steps at [DllCall structures](DllCall.htm#struct).

**Receiving parameters by address**[AHK\_L 60+]: If the function is declared as [variadic](../Functions.htm#Variadic), its final parameter is assigned the _address_ of the first callback parameter which was not assigned to a script parameter. For example:

```
callback := RegisterCallback("TheFunc", "F", 3)  <em>; Parameter list size must be specified.</em>
TheFunc("TheFunc was called directly.")          <em>; Call TheFunc directly.</em>
DllCall(callback, "float", 10.5, "int64", 42)        <em>; Call TheFunc via callback.</em>
TheFunc(params*) {
    if IsObject(params)
        MsgBox % params[1]
    else
        MsgBox % <a href="NumGet.htm" data-index="21">NumGet</a>(params+0, "float") ", " NumGet(params+A_PtrSize, "int64")
}
```

Most callbacks use the _stdcall_ calling convention, which requires a fixed number of parameters. In those cases, _ParamCount_ must be set to the size of the parameter list, where Int64 and Double count as two 32-bit parameters.

With _Cdecl_ or the 64-bit calling convention, _ParamCount_ only affects how many script parameters are assigned values. If omitted, all optional parameters receive their default values and are excluded from the calculations for the address stored in _params_.

## What the Function Should _Return_

If the function uses [Return](Return.htm) without any parameters, or it specifies a blank value such as "" (or it never uses Return at all), 0 is returned to the caller of the callback. Otherwise, the function should return an integer, which is then returned to the caller. AutoHotkey 32-bit truncates return values to 32-bit, while AutoHotkey 64-bit supports 64-bit return values. Returning structs larger than this (by value) is not supported.

## Fast vs. Slow

The default/slow mode causes the function to start off fresh with the default values for settings such as [SendMode](SendMode.htm) and [DetectHiddenWindows](DetectHiddenWindows.htm). These defaults can be changed in the [auto-execute section](../Scripts.htm#auto).

By contrast, the [fast mode](#Fast) inherits global settings from whichever [thread](../misc/Threads.htm) happens to be running at the time the function is called. Furthermore, any changes the function makes to global settings (including [ErrorLevel](../misc/ErrorLevel.htm) and the [last-found window](../misc/WinTitle.htm#LastFoundWindow)) will go into effect for the [current thread](../misc/Threads.htm). Consequently, the fast mode should be used only when it is known exactly which thread(s) the function will be called from.

To avoid being interrupted by itself (or any other thread), a callback may use [Critical](Critical.htm) as its first line. However, this is not completely effective when the function is called indirectly via the arrival of a message less than 0x0312 (increasing Critical's [interval](Critical.htm#Interval) may help). Furthermore, [Critical](Critical.htm) does not prevent the function from doing something that might indirectly result in a call to itself, such as calling [SendMessage](PostMessage.htm) or [DllCall()](DllCall.htm).

## Memory

Each use of RegisterCallback() allocates a small amount of memory (32 bytes plus system overhead). Since the OS frees this memory automatically when the script exits, any script that allocates a small, _fixed_ number of callbacks does not have to explicitly free the memory. By contrast, a script that calls RegisterCallback() an indefinite/unlimited number of times should explicitly call the following on any unused callbacks:

```
DllCall("GlobalFree", "Ptr", Address, "Ptr")
```

## Related

[DllCall()](DllCall.htm), [OnMessage()](OnMessage.htm), [OnExit()](OnExit.htm#function), [OnExit](OnExit.htm#command), [OnClipboardChange()](OnClipboardChange.htm#function), [OnClipboardChange Label](OnClipboardChange.htm#label), [Sort's callback](Sort.htm#callback), [Critical](Critical.htm), [Post/SendMessage](PostMessage.htm), [Functions](../Functions.htm), [List of Windows Messages](../misc/SendMessageList.htm), [Threads](../misc/Threads.htm)

## Examples

Displays a summary of all top-level windows.

```
<em>; For performance and memory conservation, call RegisterCallback() only once for a given callback:</em>
if not EnumAddress  <em>; Fast-mode is okay because it will be called only from this thread:</em>
    EnumAddress := RegisterCallback("EnumWindowsProc", "Fast")

DetectHiddenWindows On  <em>; Due to fast-mode, this setting will go into effect for the callback too.</em>

<em>; Pass control to EnumWindows(), which calls the callback repeatedly:</em>
DllCall("EnumWindows", "Ptr", EnumAddress, "Ptr", 0)
MsgBox %Output%  <em>; Display the information accumulated by the callback.</em>

EnumWindowsProc(hwnd, lParam)
{
    global Output
    WinGetTitle, title, ahk_id %hwnd%
    WinGetClass, class, ahk_id %hwnd%
    if title
        Output .= "HWND: " . hwnd . "`tTitle: " . title . "`tClass: " . class . "`n"
    return true  <em>; Tell EnumWindows() to continue until all windows have been enumerated.</em>
}
```

Demonstrates how to subclass a GUI window by redirecting its WindowProc to a new WindowProc in the script. In this case, the background color of a text control is changed to a custom color.

```
TextBackgroundColor := 0xFFBBBB  <em>; A custom color in BGR format.</em>
TextBackgroundBrush := DllCall("CreateSolidBrush", "UInt", TextBackgroundColor)

Gui, Add, Text, HwndMyTextHwnd, Here is some text that is given`na custom background color.
Gui +LastFound
GuiHwnd := WinExist()

<em>; 64-bit scripts must call SetWindowLongPtr instead of SetWindowLong:</em>
SetWindowLong := A_PtrSize=8 ? "SetWindowLongPtr" : "SetWindowLong"

WindowProcNew := RegisterCallback("WindowProc", ""  <em>; Specify "" to avoid fast-mode for subclassing.</em>
    , , MyTextHwnd)  <em>; ParamCount can be omitted like this in <span class="ver">[v1.1.12+]</span>.</em>
WindowProcOld := DllCall(SetWindowLong, "Ptr", GuiHwnd, "Int", -4  <em>; -4 is GWL_WNDPROC</em>
    , "Ptr", WindowProcNew, "Ptr") <em>; Return value must be set to Ptr or UPtr vs. Int.</em>

Gui Show
return

WindowProc(hwnd, uMsg, wParam, lParam)
{
    Critical
    global TextBackgroundColor, TextBackgroundBrush, WindowProcOld
    if (uMsg = 0x0138 && lParam = A_EventInfo)  <em>; 0x0138 is WM_CTLCOLORSTATIC.</em>
    {
        DllCall("SetBkColor", "Ptr", wParam, "UInt", TextBackgroundColor)
        return TextBackgroundBrush  <em>; Return the HBRUSH to notify the OS that we altered the HDC.</em>
    }
    <em>; Otherwise (since above didn't return), pass all unhandled events to the original WindowProc.</em>
    return DllCall("CallWindowProc", "Ptr", WindowProcOld, "Ptr", hwnd, "UInt", uMsg, "Ptr", wParam, "Ptr", lParam)
}

GuiClose:
ExitApp
```

