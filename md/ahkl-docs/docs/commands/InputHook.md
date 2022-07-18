# InputHook() [v1.1.31+]

Creates an object which can be used to collect or intercept keyboard input.

```
InputHook := <span class="func">InputHook</span>(<span class="optional">Options, EndKeys, MatchList</span>)
```

## Parameters

Options

A string of zero or more of the following letters (in any order, with optional spaces in between):

**B**: Sets [BackspaceIsUndo](#BackspaceIsUndo) to false, which causes Backspace to be ignored.

**C**: Sets [CaseSensitive](#CaseSensitive) to true, making _MatchList_ case sensitive.

**I**: Sets [MinSendLevel](#MinSendLevel) to 1 or a given value, causing any input with [send level](SendLevel.htm) below this value to be ignored. For example, `I2` would ignore any input with a level of 0 (the default) or 1, but would capture input at level 2.

**L**: Length limit (e.g. `L5`). The maximum allowed length of the input. When the text reaches this length, the Input is terminated and EndReason is set to the word Max (unless the text matches one of the _MatchList_ phrases, in which case EndReason is set to the word Match). If unspecified, the length limit is 1023.

Specifying `L0` disables collection of text and the length limit, but does not affect which keys are counted as producing text (see [VisibleText](#VisibleText)). This can be useful in combination with [OnChar](#OnChar), [OnKeyDown](#OnKeyDown), [KeyOpt](#KeyOpt) or _[EndKeys](#EndKeys)_.

**M**: Modified keystrokes such as Ctrl+A through Ctrl+Z are recognized and transcribed if they correspond to real ASCII characters. Consider this example, which recognizes Ctrl+C:

```
CtrlC := Chr(3) <em>; Store the character for Ctrl-C in the CtrlC var.</em>
ih := InputHook("L1 M")
ih.Start()
ih.Wait()
if (ih.Input = CtrlC)
    MsgBox, You pressed Control-C.
```

**Note**: The characters Ctrl+A through Ctrl+Z correspond to [Chr(1)](Chr.htm) through [Chr(26)](Chr.htm). Also, the **M** option might cause some keyboard shortcuts such as Ctrl+← to misbehave while an Input is in progress.

**T**: Sets [Timeout](#Timeout) (e.g. `T3` or `T2.5`).

**V**: Sets [VisibleText](#VisibleText) and [VisibleNonText](#VisibleNonText) to true. Normally, the user's input is blocked (hidden from the system). Use this option to have the user's keystrokes sent to the active window.

**\***: Wildcard. Sets [FindAnywhere](#FindAnywhere) to true, allowing matches to be found anywhere within what the user types.

**E**: Handle single-character end keys by character code instead of by keycode. This provides more consistent results if the active window's keyboard layout is different to the script's keyboard layout. It also prevents key combinations which don't actually produce the given end characters from ending input; for example, if `@` is an end key, on the US layout Shift+2 will trigger it but Ctrl+Shift+2 will not (if the E option is used). If the **C** option is also used, the end character is case-sensitive.

EndKeys

A list of zero or more keys, any one of which terminates the Input when pressed (the end key itself is not written to the Input buffer). When an Input is terminated this way, EndReason is set to the word EndKey and the [EndKey](#EndKey) property is set to the name of the key.

The _EndKeys_ list uses a format similar to the [Send](Send.htm) command. For example, specifying `{Enter}.{Esc}` would cause either Enter, ., or Esc to terminate the Input. To use the braces themselves as end keys, specify `{{}` and/or `{}}`.

To use Ctrl, Alt, or Shift as end-keys, specify the left and/or right version of the key, not the neutral version. For example, specify `{LControl}{RControl}` rather than `{Control}`.

Although modified keys such as Alt+C (!c) are not supported, non-alphanumeric characters such as `?!:@&{}` by default require the Shift key to be pressed or not pressed depending on how the character is normally typed. If the **E** option is present, single character key names are interpreted as characters instead, and in those cases the modifier keys must be in the correct state to produce that character. When the **E** and **M** options are both used, Ctrl+A through Ctrl+Z are supported by including the corresponding ASCII control characters in _EndKeys_.

An explicit key code such as `{vkFF}` or `{sc001}` may also be specified. This is useful in the rare case where a key has no name and produces no visible character when pressed. Its virtual key code can be determined by following the steps at the bottom fo the [key list page](../KeyList.htm#SpecialKeys).

MatchList

A comma-separated list of key phrases, any of which will cause the Input to be terminated (in which case EndReason will be set to the word Match). The entirety of what the user types must exactly match one of the phrases for a match to occur (unless the [\\* option](#asterisk) is present). In addition, **any spaces or tabs around the delimiting commas are significant**, meaning that they are part of the match string. For example, if _MatchList_ is `ABC , XYZ`, the user must type a space after ABC or before XYZ to cause a match.

Two consecutive commas results in a single literal comma. For example, the following would produce a single literal comma at the end of string: `string1,,,string2`. Similarly, the following list contains only a single item with a literal comma inside it: `single,,item`.

Because the items in _MatchList_ are not treated as individual parameters, the list can be contained entirely within a variable. In fact, all or part of it must be contained in a variable if its length exceeds 16383 since that is the maximum length of any script line. For example, _MatchList_ might consist of `%List1%,%List2%,%List3%` \-\- where each of the variables contains a large sub-list of match phrases.

## Input Stack

Any number of InputHook objects can be created and in progress at any time, but the order in which they are started affects how input is collected.

When each Input is started (by the [Start](#Start) method or [Input](Input.htm) command), it is pushed onto the top of a stack, and is removed from this stack only when the Input is terminated. Keyboard events are passed to each Input in order of most recently started to least. If an Input suppresses a given keyboard event, it is passed no further down the stack.

[Sent](Send.htm) keystrokes are ignored if the [send level](SendLevel.htm) of the keystroke is below the InputHook's [MinSendLevel](#MinSendLevel). In such cases, the keystroke may still be processed by an Input lower on the stack.

Multiple InputHooks can be used in combination with [MinSendLevel](#MinSendLevel) to separately collect both sent keystrokes and real ones.

Calling the [Input](Input.htm) command terminates any previous Input started by the Input command, but leaves any InputHooks active. If the Input is not [visible](Input.htm#vis), any InputHooks which it interrupts will generally not collect any input until the Input command returns.

## InputHook Object

The InputHook function returns an InputHook object, which has the following methods and properties.

- [Methods](#Methods):

  - [KeyOpt](#KeyOpt): Sets options for a key or list of keys.
  - [Start](#Start): Starts collecting input.
  - [Stop](#Stop): Terminates the Input and sets EndReason to the word Stopped.
  - [Wait](#Wait): Waits until the Input is terminated (InProgress is false).
- [General Properties](#General_Properties):

  - [EndKey](#EndKey): Returns the name of the [end key](#EndKeys) which was pressed to terminate the Input.
  - [EndMods](#EndMods): Returns a string of the modifiers which were logically down when Input was terminated.
  - [EndReason](#EndReason): Returns an [EndReason string](#EndReasons) indicating how Input was terminated.
  - [InProgress](#InProgress): Returns true if the Input is in progress and false otherwise.
  - [Input](#Input): Returns any text collected since the last time Input was started.
  - [Match](#Match): Returns the _MatchList_ item which caused the Input to terminate.
  - [OnEnd](#OnEnd): Retrieves or sets the [function object](../objects/Functor.htm) which is called when Input is terminated.
  - [OnChar](#OnChar): Retrieves or sets the [function object](../objects/Functor.htm) which is called after a character is added to the input buffer.
  - [OnKeyDown](#OnKeyDown): Retrieves or sets the [function object](../objects/Functor.htm) which is called when a notification-enabled key is pressed.
  - [OnKeyUp](#OnKeyUp): Retrieves or sets the [function object](../objects/Functor.htm) which is called when a notification-enabled key is released.
- [Option Properties](#Option_Properties):

  - [BackspaceIsUndo](#BackspaceIsUndo): Controls whether Backspace removes the most recently pressed character from the end of the Input buffer.
  - [CaseSensitive](#CaseSensitive): Controls whether _MatchList_ is case sensitive.
  - [FindAnywhere](#FindAnywhere): Controls whether each match can be a substring of the input text.
  - [MinSendLevel](#MinSendLevel): Retrieves or sets the minimum [send level](SendLevel.htm) of input to collect.
  - [NotifyNonText](#NotifyNonText): Controls whether the [OnKeyDown](#OnKeyDown) and [OnKeyUp](#OnKeyUp) callbacks are called whenever a non-text key is pressed.
  - [Timeout](#Timeout): Retrieves or sets the timeout value in seconds.
  - [VisibleNonText](#VisibleNonText): Controls whether keys or key combinations which do not produce text are visible (not blocked).
  - [VisibleText](#VisibleText): Controls whether keys or key combinations which produce text are visible (not blocked).

### Methods

### KeyOpt

Sets options for a key or list of keys.

```
InputHook.<span class="func">KeyOpt</span>(Keys, KeyOptions)
```

Keys

A list of keys. Braces are used to enclose key names, virtual key codes or scan codes, similar to the [Send](Send.htm) command. For example, `{Enter}.{{}` would apply to Enter, . and {. Specifying a key by name, by `{vkNN}` or by `{scNNN}` may produce three different results; see below for details.

Specify the string `{All}` (case-insensitive) on its own to apply _KeyOptions_ to all VK and all SC. KeyOpt may then be called a second time to remove options from specific keys.

KeyOptions

One or more of the following single-character options (spaces and tabs are ignored).

**-** (minus): Removes any of the options following the `-`, up to the next `+`.

**+** (plus): Cancels any previous `-`, otherwise has no effect.

**E**: End key. If enabled, pressing the key terminates Input, sets [EndReason](#EndReason) to the word EndKey and the [EndKey](#EndKey) property to the key's normalized name. Unlike the _EndKeys_ parameter, the state of the Shift key is ignored. For example, `@` and `2` are both equivalent to `{vk32}` on the US keyboard layout.

**I**: Ignore text. Any text normally produced by this key is ignored, and the key is treated as a non-text key (see [VisibleNonText](#VisibleNonText)). Has no effect if the key normally does not produce text.

**N**: Notify. Causes the [OnKeyDown](#OnKeyDown) and [OnKeyUp](#OnKeyUp) callbacks to be called each time the key is pressed.

**S**: Suppresses (blocks) the key after processing it. This overrides [VisibleText](#VisibleText) or [VisibleNonText](#VisibleNonText) until `-S` is used. `+S` implies `-V`.

**V**: Visible. Prevents the key from being suppressed (blocked). This overrides [VisibleText](#VisibleText) or [VisibleNonText](#VisibleNonText) until `-V` is used. `+V` implies `-S`.

Options can be set by both virtual key code and scan code, and are accumulative.

When a key is specified by name, the options are set either by VK or by SC. Where two physical keys share the same VK but differ by SC (such as Up and NumpadUp), they are handled by SC. By contrast, if a VK number is used, it will apply to any physical key which produces that VK (and this may vary over time as it depends on the active keyboard layout).

Removing an option by VK number does not affect any options that were set by SC, or vice versa. However, when an option is removed by key name and that name is handled by VK, the option is also removed for the corresponding SC (according to the script's keyboard layout). This allows keys to be excluded by name after applying an option to [all keys](#all-keys).

If `+V` is set by VK and `+S` is set by SC (or vice versa), `+V` takes precedence.

### Start

Starts collecting input.

```
InputHook.<span class="func">Start</span>()
```

Has no effect if the Input is already in progress.

The newly started Input is placed on the top of the [InputHook stack](#stack), which allows it to override any previously started Input.

This method installs the [keyboard hook](_InstallKeybdHook.htm) (if it was not already).

### Stop

Terminates the Input and sets [EndReason](#EndReason) to the word Stopped.

```
InputHook.<span class="func">Stop</span>()
```

Has no effect if the Input is not in progress.

### Wait

Waits until the Input is terminated ( [InProgress](#InProgress) is false).

```
InputHook.<span class="func">Wait</span>(<span class="optional">MaxTime</span>)
```

MaxTime

The maximum number of seconds to wait. If Input is still in progress after _MaxTime_ seconds, the method returns and does not terminate Input.

Returns [EndReason](#EndReason).

### General Properties

### EndKey

Returns the name of the [end key](#EndKeys) which was pressed to terminate the Input.

```
KeyName := InputHook.EndKey
```

Note that EndKey returns the "normalized" name of the key regardless of how it was written in _EndKeys_. For example, `{Esc}` and `{vk1B}` both produce `Escape`. [GetKeyName()](GetKey.htm) can be used to retrieve the normalized name.

If the [E option](#E) was used, EndKey returns the actual character which was typed (if applicable). Otherwise, the key name is determined according to the script's active keyboard layout.

EndKey returns an empty string if [EndReason](#EndReason) is not "EndKey".

### EndMods

Returns a string of the modifiers which were logically down when Input was terminated.

```
Mods := InputHook.EndMods
```

If all modifiers were logically down (pressed), the full string is:

```
<^>^<!>!<+>+<#>#
```

These modifiers have the same meaning as with [hotkeys](../Hotkeys.htm). Each modifier is always qualified with < (left) or > (right). The corresponding key names are: LCtrl, RCtrl, LAlt, RAlt, LShift, RShift, LWin, RWin.

[InStr()](InStr.htm) can be used to check whether a given modifier (such as `>!` or `^`) is present. The following line can be used to convert _Mods_ to a string of neutral modifiers, such as `^!+#`:

```
Mods := RegExReplace(Mods, "[<>](.)(?:>\1)?", "$1")
```

Due to split-second timing, this property may be more reliable than [GetKeyState()](GetKeyState.htm#function) even if it is used immediately after Input terminates, or in the [OnEnd](#OnEnd) callback.

### EndReason

Returns an [EndReason string](#EndReasons) indicating how Input was terminated.

```
Reason := InputHook.EndReason
```

Returns an empty string if the Input is still in progress.

### InProgress

Returns true if the Input is in progress and false otherwise.

```
Boolean := InputHook.InProgress
```

### Input

Returns any text collected since the last time Input was started.

```
String := InputHook.Input
```

This property can be used while the Input is in progress, or after it has ended.

### Match

Returns the _[MatchList](#MatchList)_ item which caused the Input to terminate.

```
String := InputHook.Match
```

Returns the matched item with its original case, which may differ from what the user typed if the **C** option was omitted. Returns an empty string if [EndReason](#EndReason) is not "Match".

### OnEnd

Retrieves or sets the [function object](../objects/Functor.htm) which is called when Input is terminated.

```
MyFunc := InputHook.OnEnd
```

```
InputHook.OnEnd := MyFunc
```

Type: [function object](../objects/Functor.htm) or [empty string](../Concepts.htm#nothing). Default: empty string.

The function is passed one parameter: a reference to the InputHook object.

The function is called as a new [thread](../misc/Threads.htm), so starts off fresh with the default values for settings such as [SendMode](SendMode.htm) and [DetectHiddenWindows](DetectHiddenWindows.htm).

### OnChar

Retrieves or sets the [function object](../objects/Functor.htm) which is called after a character is added to the input buffer.

```
MyFunc := InputHook.OnChar
```

```
InputHook.OnChar := MyFunc
```

Type: [function object](../objects/Functor.htm) or [empty string](../Concepts.htm#nothing). Default: empty string.

The function is passed the following parameters: `InputHook, Char`. _Char_ is a string containing the character or characters.

The presence of multiple characters indicates that a dead key was used prior to the last keypress, but the two keys could not be transliterated to a single character. For example, on some keyboard layouts \`e produces `è` while \`z produces `` `z``.

The function is never called when an end key is pressed.

### OnKeyDown

Retrieves or sets the [function object](../objects/Functor.htm) which is called when a notification-enabled key is pressed.

```
MyFunc := InputHook.OnKeyDown
```

```
InputHook.OnKeyDown := MyFunc
```

Type: [function object](../objects/Functor.htm) or [empty string](../Concepts.htm#nothing). Default: empty string.

Key-down notifications must first be enabled by [KeyOpt](#KeyOpt) or [NotifyNonText](#NotifyNonText).

The function is passed the following parameters: `InputHook, VK, SC`. _VK_ and _SC_ are integers. To retrieve the key name (if any), use `GetKeyName(Format("vk{:x}sc{:x}", VK, SC))`.

The function is called as a new [thread](../misc/Threads.htm), so starts off fresh with the default values for settings such as [SendMode](SendMode.htm) and [DetectHiddenWindows](DetectHiddenWindows.htm).

The function is never called when an end key is pressed.

### OnKeyUp [v1.1.32+]

Retrieves or sets the [function object](../objects/Functor.htm) which is called when a notification-enabled key is released.

```
MyFunc := InputHook.OnKeyUp
```

```
InputHook.OnKeyUp := MyFunc
```

Type: [function object](../objects/Functor.htm) or [empty string](../Concepts.htm#nothing). Default: empty string.

Key-up notifications must first be enabled by [KeyOpt](#KeyOpt) or [NotifyNonText](#NotifyNonText). Whether a key is considered text or non-text is determined when the key is pressed. If an InputHook detects a key-up without having detected key-down, it is considered non-text.

The function is passed the following parameters: `InputHook, VK, SC`. _VK_ and _SC_ are integers. To retrieve the key name (if any), use `GetKeyName(Format("vk{:x}sc{:x}", VK, SC))`.

The function is called as a new [thread](../misc/Threads.htm), so starts off fresh with the default values for settings such as [SendMode](SendMode.htm) and [DetectHiddenWindows](DetectHiddenWindows.htm).

### Option Properties

### BackspaceIsUndo

Controls whether Backspace removes the most recently pressed character from the end of the Input buffer.

```
Boolean := InputHook.BackspaceIsUndo
```

```
InputHook.BackspaceIsUndo := Boolean
```

Type: [Integer (boolean)](../Concepts.htm#boolean). Default: true. Option **B** sets the value to false.

When Backspace acts as undo, it is treated as a text entry key. Specifically, whether the key is suppressed depends on [VisibleText](#VisibleText) rather than [VisibleNonText](#VisibleNonText).

Backspace is always ignored if pressed in combination with a modifier key such as Ctrl (the logical modifier state is checked rather than the physical state).

**Note:** If the input text is visible (such as in an editor) and the arrow keys or other means are used to navigate within it, Backspace will still remove the last character rather than the one behind the caret (insertion point).

### CaseSensitive

Controls whether _MatchList_ is case sensitive.

```
Boolean := InputHook.CaseSensitive
```

```
InputHook.CaseSensitive := Boolean
```

Type: [Integer (boolean)](../Concepts.htm#boolean). Default: false. Option **C** sets the value to true.

### FindAnywhere

Controls whether each match can be a substring of the input text.

```
Boolean := InputHook.FindAnywhere
```

```
InputHook.FindAnywhere := Boolean
```

Type: [Integer (boolean)](../Concepts.htm#boolean). Default: false. Option **\*** sets the value to true.

If true, a match can be found anywhere within what the user types (the match can be a substring of the input text). If false, the entirety of what the user types must match one of the _MatchList_ phrases. In both cases, one of the _MatchList_ phrases must be typed in full.

### MinSendLevel

Retrieves or sets the minimum [send level](SendLevel.htm) of input to collect.

```
Level := InputHook.MinSendLevel
```

```
InputHook.MinSendLevel := Level
```

Type: [Integer](../Concepts.htm#numbers). Default: 0. Option **I** sets the value to 1 (or a given value).

_Level_ should be an integer between 0 and 101. Events which have a send level _lower_ than this value are ignored. For example, a value of 101 causes all input generated by [SendEvent](Send.htm) to be ignored, while a value of 1 only ignores input at the default send level (zero).

The [SendInput](Send.htm#SendInput) and [SendPlay](Send.htm#SendPlay) methods are always ignored, regardless of this setting. Input generated by any source other than AutoHotkey is never ignored as a result of this setting.

### NotifyNonText

Controls whether the [OnKeyDown](#OnKeyDown) and [OnKeyUp](#OnKeyUp) callbacks are called whenever a non-text key is pressed.

```
Boolean := InputHook.NotifyNonText
```

```
InputHook.NotifyNonText := Boolean
```

Type: [Integer (boolean)](../Concepts.htm#boolean). Default: false.

Setting this to true enables notifications for all keypresses which do not produce text, such as when pressing Left or Alt+F. Setting this property does not affect a key's [options](#KeyOpt), since the production of text depends on the active window's keyboard layout at the time the key is pressed.

NotifyNonText is applied to key-up events by considering whether a previous key-down with a matching VK code was classified as text or non-text. For example, if NotifyNonText is true, pressing Ctrl+A will produce [OnKeyDown](#OnKeyDown) and [OnKeyUp](#OnKeyUp) calls for both Ctrl and A, while pressing A on its own will not call OnKeyDown or OnKeyUp unless [KeyOpt](#KeyOpt) has been used to enable notifications for that key.

See [VisibleText](#VisibleText) for details about which keys are counted as producing text.

### Timeout

Retrieves or sets the timeout value in seconds.

```
Seconds := InputHook.Timeout
```

```
InputHook.Timeout := Seconds
```

Type: [Float](../Concepts.htm#numbers). Default: 0.0 (none). Option **T** also sets the timeout value.

The timeout period ordinarily starts when [Start](#Start) is called, but will restart if this property is assigned a value while Input is in progress. If Input is still in progress when the timeout period elapses, it is terminated and [EndReason](#EndReason) is set to the word Timeout.

### VisibleNonText

Controls whether keys or key combinations which do not produce text are visible (not blocked).

```
Boolean := InputHook.VisibleNonText
```

```
InputHook.VisibleNonText := Boolean
```

Type: [Integer (boolean)](../Concepts.htm#boolean). Default: true. Option **V** sets the value to true.

If true, keys and key combinations which do not produce text may trigger hotkeys or be passed on to the active window. If false, they are blocked.

See [VisibleText](#VisibleText) for details about which keys are counted as producing text.

### VisibleText

Controls whether keys or key combinations which produce text are visible (not blocked).

```
Boolean := InputHook.VisibleText
```

```
InputHook.VisibleText := Boolean
```

Type: [Integer (boolean)](../Concepts.htm#boolean). Default: false. Option **V** sets the value to true.

If true, keys and key combinations which produce text may trigger hotkeys or be passed on to the active window. If false, they are blocked.

Any keystrokes which cause text to be appended to the Input buffer are counted as producing text, even if they do not normally do so in other applications. For instance, Ctrl+A produces text if the [**M** option](#option-m) is used, and Esc produces the control character `Chr(27)`.

Dead keys are counted as producing text, although they do not typically produce an immediate effect. Pressing a dead key might also cause the following key to produce text (if only the dead key's character).

Backspace is counted as producing text only when it [acts as undo](#BackspaceIsUndo).

The [standard modifier keys](../KeyList.htm#modifier) and CapsLock, NumLock and ScrollLock are always visible (not blocked).

## EndReason

The EndReason property returns one of the following strings:

StringDescriptionStoppedThe Stop method was called or Start has not yet been called for the first time.MaxThe Input reached the maximum allowed length and it does not match any of the items in _MatchList_.TimeoutThe Input timed out.MatchThe Input matches one of the items in _MatchList_. The [Match](#Match) property contains the matched item.EndKey

One of the _EndKeys_ was pressed to terminate the Input. The [EndKey](#EndKey) property contains the terminating key name or character without braces.

If the Input is in progress, EndReason is blank.

## Remarks

The [Start](#Start) method must be called before input will be collected.

InputHook is designed to allow different parts of the script to monitor input, with minimal conflicts. It can operate continuously, such as to watch for [arbitrary words](#ExSac) or other patterns. It can also operate temporarily, such as to collect user input or temporarily override specific (or [non-specific](#ExKeyWaitAny)) keys without interfering with hotkeys.

Keyboard [hotkeys](../Hotkeys.htm) are still in effect while an Input is in progress, but cannot activate if any of the required modifier keys are suppressed, or if the hotkey uses the _reg_ method and its suffix key is suppressed. For example, the hotkey `^+a::` _might_ be overridden by InputHook, whereas the hotkey `$^+a::` would take priority unless the InputHook suppressed Ctrl or Shift.

Keys are either suppressed (blocked) or not depending on the following factors (in order):

- If the[V option](#KeyOpt-v) is in effect for this VK or SC, it is not suppressed.
- If the[S option](#KeyOpt-s) is in effect for this VK or SC, it is suppressed.
- If the key is a[standard modifier key](../KeyList.htm#modifier) or CapsLock, NumLock or ScrollLock, it is not suppressed.
- [VisibleText](#VisibleText) or [VisibleNonText](#VisibleNonText) is consulted, depending on whether the key produces text. If the property is false, the key is suppressed. See [VisibleText](#VisibleText) for details about which keys are counted as producing text.

The [keyboard hook](_InstallKeybdHook.htm) is required while an Input is in progress, but will be uninstalled automatically if it is no longer needed when the Input is terminated. The presence of the keyboard hook causes the script to become temporarily [persistent](_Persistent.htm), meaning that [ExitApp](ExitApp.htm) may be needed to terminate it.

AutoHotkey does not support Input Method Editors (IME). The keyboard hook intercepts keyboard events and translates them to text by using [ToUnicodeEx](https://docs.microsoft.com/windows/desktop/api/winuser/nf-winuser-tounicodeex) or ToAsciiEx (except in the case of [VK\_PACKET](https://docs.microsoft.com/windows/desktop/inputdev/virtual-key-codes#vk_packet) events, which encapsulate a single character).

If you use multiple languages or keyboard layouts, Input uses the keyboard layout of the active window rather than the script's (regardless of whether the Input is [visible](#vis)).

Although not as flexible, [hotstrings](../Hotstrings.htm) are generally easier to use.

## InputHook vs. Input

InputHook and the [Input](Input.htm) command are two different interfaces for the same underlying functionality. The following are mostly equivalent:

```
Input, OutputVar, %Options%, %EndKeys%, %MatchList%

```

```
ih := InputHook(Options, EndKeys, MatchList)
ih.Start()
ErrorLevel := ih.Wait()
if (ErrorLevel = "EndKey")
    ErrorLevel .= ":" ih.EndKey
OutputVar := ih.Input

```

The Input command terminates any previous Input which it started, whereas InputHook allows [more than one Input](#stack) at a time.

_Options_ is interpreted the same, but the default settings differ:

- The Input command limits the length of the input to 16383, while InputHook limits it to 1023. This can be overridden with the[L option](#option-l), and there is no absolute maximum.
- The Input command blocks both text and non-text keystrokes by default, and blocks neither if the[V option](Input.htm#vis) is present. By contrast, InputHook blocks only text keystrokes by default ( [VisibleNonText](#VisibleNonText) defaults to true), so most hotkeys can be used while an Input is in progress.

The Input command blocks the [thread](../misc/Threads.htm) while it is in progress, whereas InputHook allows the thread to continue, or even exit (which allows any thread that it interrupted to resume). Instead of waiting, the script can register an [OnEnd](#OnEnd) function to be called when the Input is terminated.

The Input command returns the user's input only after the Input is terminated, whereas InputHook's [Input](#Input) property allows it to be retrieved at any time. The script can register an [OnChar](#OnChar) function to be called whenever a character is added, instead of continuously checking the Input property.

InputHook gives much more control over individual keys via the [KeyOpt](#KeyOpt) method. This includes adding or removing end keys, suppressing or not suppressing specific keys, or ignoring the text produced by specific keys.

Unlike the Input command, InputHook can be used to detect keys which do not produce text, _without_ terminating the Input. This is done by registering an [OnKeyDown](#OnKeyDown) function and using [KeyOpt](#KeyOpt) or [NotifyNonText](#NotifyNonText) to specify which keys are of interest.

If a _MatchList_ item caused the Input to terminate, the [Match](#Match) property can be consulted to determine exactly which match (this is more useful when the [\\* option](#asterisk) is present).

Although the script can consult [GetKeyState()](GetKeyState.htm#function) after the Input command returns, sometimes it does not accurately reflect which keys were pressed when the Input was terminated. InputHook's [EndMods](#EndMods) property reflects the logical state of the modifier keys at the time Input was terminated.

There are some differences relating to backward-compatibility:

- The Input command stores end keysA-Z in uppercase even though other letters on some keyboard layouts are lowercase. Passing the value to [Send](Send.htm) would produce a shifted keystroke instead of a plain one. By contrast, InputHook's [EndKeys](#EndKeys) property always returns the normalized name; i.e. whichever character is produced by pressing the key without holding Shift or other modifiers.
- If a key name used in _EndKeys_ corresponds to a VK which is shared between two physical keys (such as NumpadUp and Up), the Input command handles the primary key by VK and the secondary key by SC, whereas InputHook handles both by SC. `{vkNN}` notation can be used to handle the key by VK.

  When the end key is handled by VK, both physical keys can terminate the Input. For example, `{NumpadUp}` would cause the Input command to be terminated by pressing Up, but ErrorLevel would contain `EndKey:NumpadUp` since only the VK is considered.

  When an end key is handled by SC, the Input command always produces names for the known secondary SC of any given VK, and always produces `sc<i>NNN</i>` for any other key (even if it has a name). By contrast, InputHook produces a name if the key has one.


## Related

[Input](Input.htm), [KeyWait](KeyWait.htm), [Hotstrings](../Hotstrings.htm), [InputBox](InputBox.htm), [#InstallKeybdHook](_InstallKeybdHook.htm), [Threads](../misc/Threads.htm), [if var in/contains MatchList](IfIn.htm)

## Examples

Waits for the user to press any single key.

```
MsgBox % KeyWaitAny()

<em>; Same again, but don't block the key.</em>
MsgBox % KeyWaitAny("V")

KeyWaitAny(Options:="")
{
    ih := InputHook(Options)
    if !InStr(Options, "V")
        ih.VisibleNonText := false
    ih.KeyOpt("{All}", "E")  <em>; End</em>
    ih.Start()
    ErrorLevel := ih.Wait()  <em>; Store EndReason in ErrorLevel</em>
    return ih.EndKey  <em>; Return the key name</em>
}

```

Waits for any key in combination with Ctrl/Alt/Shift/Win.

```
MsgBox % KeyWaitCombo()

KeyWaitCombo(Options:="")
{
    ih := InputHook(Options)
    if !InStr(Options, "V")
        ih.VisibleNonText := false
    ih.KeyOpt("{All}", "E")  <em>; End</em>
    <em>; Exclude the modifiers</em>
    ih.KeyOpt("{LCtrl}{RCtrl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}", "-E")
    ih.Start()
    ErrorLevel := ih.Wait()  <em>; Store EndReason in ErrorLevel</em>
    return ih.EndMods . ih.EndKey  <em>; Return a string like <^<+Esc</em>
}

```

Simple auto-complete: any day of the week. Pun aside, this is a fully functional example. Simply run the script and start typing today, press Tab to complete or press Esc to exit.

```
global WordList := "Monday`nTuesday`nWednesday`nThursday`nFriday`nSaturday`nSunday"

global Suffix := "", SacHook

SacHook := InputHook("V", "{Esc}")
SacHook.OnChar := Func("SacChar")
SacHook.OnKeyDown := Func("SacKeyDown")
SacHook.OnEnd := Func("SacEnd")
SacHook.KeyOpt("{Backspace}", "N")
SacHook.Start()

SacChar(ih, char)  <em>; Called when a character is added to SacHook.Input.</em>
{
    Suffix := ""
    if RegExMatch(ih.Input, "`nm)\w+$", prefix)
        RegExMatch(WordList, "`nmi)^" prefix "\K.*", Suffix)

    ToolTip % Suffix, % A_CaretX + 15, % A_CaretY

    <em>; Intercept Tab only while we're showing a tooltip.</em>
    ih.KeyOpt("{Tab}", Suffix = "" ? "-NS" : "+NS")
}

SacKeyDown(ih, vk, sc)
{
    if (vk = 8) <em>; Backspace</em>
        SacChar(ih, "")
    else if (vk = 9) <em>; Tab</em>
        Send % "{Text}" Suffix
}

SacEnd()
{
    ExitApp
}

```

