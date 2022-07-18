# Changes & New Features

Changes and new features introduced by the current branch of AutoHotkey development (a.k.a. AutoHotkey\_L) are listed below.

For older changes, see [Archived Changes](ChangeLogHelp.htm).

## 1.1.34.03 - June 5, 2022

Fixed double backspacing of supplementary Unicode characters in hotstrings.

Fixed `a::` not firing if `a up::` and `a & b::` are present.

Fixed MinSize/MaxSize being applied incorrectly before the first call to Gui Show.

Fixed the hook thread getting stuck in an infinite loop if an InputHook has been restarted too soon after being stopped.

Fixed crashes or undefined behaviour when a blank parameter is passed to FileCopy, FileMove, FileCopyDir, FileMoveDir or FileRemoveDir.

Fixed dead keys erroneously being reapplied by the keyboard hook after the final character of a hotstring is suppressed (e.g. for `:?*:ò::ó`).

## 1.1.34.02 - May 13, 2022

Fixed bugs introduced by v1.1.34.00:

- Fixed command line args for embedded script #1.
- Fixed`Alt::`, `Ctrl::` and `Shift::` behaving like normal keys, instead of firing on release as documented.
- Fixed`~a & b::` (when disabled with #If) causing `a::` to fire on key-up even after activating some other combo.

## 1.1.34.01 - May 7, 2022

Fixed bugs introduced by v1.1.34.00:

- `a up::` firing on press rather than release if it is the first hotkey and `~a & b::` is present.
- `a::` not suppressing the key if `~a & b::` is also present, unless `a::` is the first hotkey.
- `CapsLock::` not working when `CapsLock & x::` is also present, and likewise for NumLock and ScrollLock.

## 1.1.34.00 - May 5, 2022

Added the capability to use AutoHotkey.exe as the base for compiled scripts, allowing compiled scripts to execute external files when passed the `/script` command-line switch.

Added the capability to implicitly include code at the top of every script, either by embedding a resource within AutoHotkey.exe or by using the /include command-line switch.

Enabled the use of Menu NoMainWindow/MainWindow in uncompiled scripts.

Changed `~x & y::` to not affect suppression of _x_ when disabled by #If.

Enhanced FileCopyDir to permit the source directory to be a zip file, if supported by the OS, in which case its contents are extracted.

Fixed execution of multiple run-once timers in the same tick [broken by v1.1.33.11].

Fixed ToolTip positioning/sizing bugs.

- Attempting to position a tooltip overlapping the taskbar caused it to appear at the top of the screen instead, on Windows 10 and 11.
- Tooltips were limited by the primary screen's width even when they should appear on a secondary screen, and this could prevent them from appearing on the appropriate screen (when they're too wide).
- The maximum width was effectively`A_ScreenDPI/96` times larger than it should be due to OS behaviour; this is now accounted for.

Optimized ToolTip for cases where the text isn't changing, to reduce flicker and speed it up.

Fixed key-up hotkeys failing to execute if they are turned on after (but not before) the key is pressed down, and that key is also used as a custom prefix key with the tilde prefix (e.g. activating `~a & b::` interferes with `a up::`).

Fixed custom combo hotkeys where the prefix key causes a hook reset, such as `~RButton & WheelUp::` when `RButton::` enables or disables the script's only keyboard hook hotkey.

## 1.1.33.11 - April 20, 2022

Fixed `Format(n)` returning blank when `n` is a pure numeric expression.

Fixed the debugger's inability to query `obj.<base>.<base>`.

Changed debugger step/breakpoints to slip over Try/Catch/Finally/Case.

Fixed `Switch {` incorrectly raising a load-time error.

Fixed debugger stack\_get reporting incorrect line after OnError.

Fixed debugger stack\_get reporting incorrect line for auto-execute thread.

Fixed auto-env retrieval and A\_ComVar to safely allow for variables larger than the official limit [PR #259 from mikeblas].

Fixed A\_EventInfo for mouse wheel hotkeys [broken by v1.1.33.05].

Fixed ControlClick to convert coordinates correctly for wheel messages.

Fixed the IDispatch implementation for AutoHotkey objects to preserve case for property names.

Fixed #Warn StdOut to default to codepage 0 when /ErrorStdOut is not used.

Fixed crashes when a timer's \_\_delete() meta-function deletes the next timer.

## 1.1.33.10 - August 29, 2021

Fixed loading of JPG/GIF files which are already open for reading.

Fixed misidentification of digits/xdigits by if-var-is.

Added a safety check for ControlGet Selected in case it is used with a non-Edit control.

Fixed variables being set to NULL in certain rare cases, causing crashes. The only confirmed case being when a string longer than 63 characters is returned from a function and assigned to a variable while AutoHotkey is running as a Windows store app.

Fixed InputHook callbacks failing after input is stopped and restarted.

## 1.1.33.09 - May 8, 2021

Fixed crash on load when an AltTab action is used in a key-up/down pair.

Fixed garbage error text when the main script file cannot be opened.

Removed "Error at line 0" from error messages which appear before the first line is read.

Fixed focus resetting when a minimized GUI is restored.

Fixed focus not saving when a GUI is minimized with Gui Show.

## 1.1.33.08 - April 23, 2021

Fixed non-zero SendLevel events erroneously being suppressed in cases not covered by the v1.1.33.07 fix:

- When there's a matching context-sensitive hotkey with a higher #InputLevel and no enabled global variant.
- When there's no matching key-down hotkey, but there's a key-up hotkey with a higher #InputLevel.

## 1.1.33.07 - April 21, 2021

Fixed tray icon freezing and becoming blurry after screen DPI changes.

Fixed hotkeys disabled by #InputLevel erroneously suppressing keys.

## 1.1.33.06 - March 14, 2021

Fixed a bug introduced by v1.1.33.05 were certain hotkeys were ignored. This included joystick hotkeys and all hotkeys to which #MaxThreadsBuffer or the B option is applied.

## 1.1.33.05 - March 10, 2021

Fixed bugs with hotkey variants having different #InputLevels.

- Hotkey variants executing despite send level being too low, due to a global variant having lower #InputLevel.
- Hotkey variants not executing because a previous variant was ineligible due to #InputLevel.

Fixed Ctrl/Shift/Alt (without L/R) as hook hotkeys.

## 1.1.33.04 - March 2, 2021

Removed dependency on the POPCNT instruction, which is not supported by old CPUs (e.g. Core 2).

## 1.1.33.03 - March 1, 2021

Fixed crashing when an empty SafeArray is enumerated.

Fixed height to not auto-expand for Button/Checkbox/Radio with -Wrap.

Fixed WM\_DESTROY bypassing release of objects in global/static vars.

Fixed WinMenuSelectItem second-attempt matching to handle & correctly. Specifically, items with actual text like "a && b" which appear as "a & b" will now match "a & b" instead of "a  b".

Fixed breakpoint on Case/Default line breaking at end of previous case.

Changed SoundBeep to ignore duration if negative, instead of wrapping around to a large positive value.

Fixed mouse hotkeys with ! to mask Alt-up after key-repeat if possible.

Fixed several issues with overlapping hotkeys.

- Key-up hotkeys firing incorrectly because they were paired with a hotkey with overlapping but different requirements, such as`<^a up` firing for RCtrl+A because it was paired with `^a`; or `*^c up` firing for Shift+C because it was paired with `*+c`, and both can fire for Ctrl+Shift+C.
- Unpredictable prioritization of hotkeys with the same modifiers but different L/R variants, or different modifiers when neither one is a perfect subset of the other. Priority was affected by order of definition to a degree but shifted unpredictably when hotkeys were added or removed.

## 1.1.33.02 - July 17, 2020

Fixed InputHook.EndKey to prefer any vk over sc000.

Fixed `InputHook.KeyOpt("{sc000}", flags)`.

Fixed #Warn Unreachable flagging Case/Default as unreachable.

## 1.1.33.01 - July 13, 2020

Fixed modifier key-up hotkeys like `LShift up::` not suppressing key-up unless a corresponding key-down hotkey is defined.

Fixed icons loaded from DLL/EXE not using the closest matching size if it's first in the icon group [broken by v1.1.33.00].

Fixed `a up::` erroneously taking precedence over `b & a up::` if `a::` is defined but not `b & a::`.

Fixed `b & a up::` not suppressing `a` when `a::` is defined but disabled by #If and `b & a::` is not defined.

## 1.1.33.00 - June 30, 2020

Added [#ErrorStdOut](commands/_ErrorStdOut.htm) _Encoding_ parameter.

Added [/ErrorStdOut= _Encoding_](Scripts.htm#ErrorStdOut) command line switch.

Added [#Warn Unreachable](commands/_Warn.htm#Unreachable) (warning mode).

Added [#Requires AutoHotkey v _Version_](commands/_Requires.htm) (directive).

Added detection of program-terminating SEH exceptions, to display an error dialog.

Implemented numerous improvements to Ahk2Exe developed by fincs, TAC109, Joe DF, and Ben Allred.

Fixed Send causing unwanted hotkey buffering.

Fixed a possible bug where Input causes undefined behaviour. [PR #159 from Helgef]

Fixed WinKill to actually do more than WinClose.

Fixed A\_WinDir to always return the system Windows directory.

Fixed FileGetShortcut/FileCreateShortcut to not increment/decrement negative icon indices (resource IDs).

Fixed InputBox Locale option to not focus the Cancel button.

Fixed menu bar keyboard shortcuts not working when GUI has no controls.

Fixed LoadPicture to use 256x256 graphic when available in a DLL/EXE.

Fixed DBGp stderr copy mode to not suppress error dialogs.

Fixed ControlGet Line setting ErrorLevel=1 when line is just empty.

## 1.1.32.00 - November 24, 2019

Changed commands and functions with a WinTitle parameter to treat cloaked windows as hidden.

Added support for reverse PixelSearch in fast mode. [PR #156 from changyuheng]

Added InputHook OnKeyUp callback.

Fixed GroupDeactivate to exclude the Desktop on Windows 10 (and possibly 8).

Fixed Switch treating strings as always true.

Fixed A\_PriorKey being blank after Unicode characters are sent.

Fixed WinActivate to not assume NULL foreground window == taskbar.

Fixed `Send {Del}` not restoring AltGr after releasing it.

Fixed vk13 and sc045 as remap destination keys.

Removed unnecessary checks for Control and Sleep in one-line hotkeys.

Removed obsolete Windows 9x/NT4 support code and performed other maintenance.

## 1.1.31.01 - October 14, 2019

Fixed `Switch %v%`, `Case %v%` and `Throw %v%`.

Fixed `Case 2,,:` to show an error message rather than crash.

Fixed AltTab hotkeys [broken by v1.1.31.00].

Fixed hotstring X option to permit whitespace after `::`.

Fixed single-line hotkeys to prohibit multi-line statements such as IF.

## 1.1.31.00 - September 28, 2019

Added [Switch](commands/Switch.htm).

Added [InputHook](commands/InputHook.htm).

Added `Locale` option to enable InputBox to use locale-specific button names. [PR #143 from Ragnar-F]

Improved support for [long paths](misc/LongPaths.htm).

General hotkey improvements:

- Improved support for overlapping hotkeys like`<^a` and `^a` with `#If`. If all variants of a hotkey are disabled by #If, a more general hotkey may be triggered. In other words, disabling the hotkeys with #If should now behave more like turning them off or removing them from the script.
- Improved detection of incorrect modifier key state by the hook.
- Fixed wildcard hotkey selection to ignore modifier changes made by Send.

AltGr bug-fixes:

- Fixed hotkeys misfiring after`Send <i>xy</i>` where _x_ requires AltGr.
- Fixed an unnecessary LCtrl being sent after`Send <i>x</i>` where _x_ requires AltGr.
- Fixed AltGr detection on Unicode 32-bit builds when OS is 64-bit.
- Fixed sending of AltGr combinations while RCtrl is down.

Shift-numpad bug-fixes:

- Fixed interaction between Send and Shift-numpad causing Shift to stick. This fixes intermittent issues with hotkeys like`Numpad1::Send +1`.
- Optimized detection of fake Shift generated by system numpad handling.
- Fixed fake RShift being considered physical, inconsistent with LShift.

Fixed Slider `+TickInterval` to take effect even if `Range` is not set.

Fixed Slider `+TickInterval0` to set interval to 0, disabling ticks.

Fixed menu and GUI events causing CPU-maxing loops in some cases. Specifically, when a modal message loop is running and the script is uninterruptible, menu and GUI event messages were repeatedly re-posted. These are now discarded, as they can't be handled or kept in the queue. This is consistent with hotkeys, etc.

Fixed DllCall critical errors to always exit, ignoring OnExit result.

Fixed `ExitApp 2` bypassing release of objects in global/static vars.

Changed ComObjCreate to use CLSIDFromProgID for non-GUID strings. This fixes `ComObjCreate("Microsoft.Windows.ActCtx")` and possibly others which aren't in the registry but work with VBScript and JScript.

## 1.1.30.03 - April 4, 2019

Fixed debugger context\_get triggering #Warn UseUnset.

Fixed straight modifier hotkeys such as Shift:: (broken by v1.1.30.02).

## 1.1.30.02 - April 1, 2019

Fixed Menu Rename to allow duplicates and no-op/case-only renames.

Fixed X option for Hotstring(). [PR #132 from Helgef]

Fixed \_\_init/\_\_delete causing misleading error line/stack trace.

Fixed #if expressions stalling in Sleep and similar.

Fixed custom combos triggering incorrectly after a custom combo suspends itself.

## 1.1.30.01 - November 11, 2018

Changed TV\_Add/TV\_Modify to allow "Bold1" and "Bold0".

Fixed hotkey pairs with non-zero #InputLevel blocking sent events.

Fixed `Control Choose` to send WM\_COMMAND even if the control's ID is 0.

Fixed heap corruption in scripts with keyboard hook but no hotkeys.

Fixed escape sequences in one-line hotstrings with 'X' option.

Fixed ``` `` ``` escape sequence preceding a `;` comment flag.

Fixed `finally` corrupting the value of a pending `return`.

Fixed MsgBox to detect timeouts even if the thread is interrupted.

Fixed Ahk2Exe to support more built-in variables in #Include.

## 1.1.30.00 - August 22, 2018

Fixed SendInput/SendPlay to restore DownR/remapped modifiers.

Increased limit of hotkeys per script from 1000 to 32762.

Changed commands which accept On/Off/Toggle to also accept 1/0/-1 (where documented).

Improvements to debugger (DBGp) support:

- Added support for the -d (stack depth) option.
- Added (DBGp-only) .<base> pseudo-property to resolve ambiguity.
- Fixed debugger to avoid unsupported re-entry during break state.
- Fixed DBGp command parser to support quoted parameters.

## 1.1.29.01 - June 2, 2018

Fixed WinMove crashing the program in some cases [broken by v1.1.29.00].

Fixed `Gui x:Default` if no Gui has been created [broken by v1.1.29.00].

## 1.1.29.00 - May 25, 2018

Added `Object.Count()` and `ObjCount(Object)`.

Added `ObjGetBase(Object)` and `ObjSetBase(Object, Base)`.

Added `ObjRawGet(Object, Key)`.

Added `OnError(Func [, AddRemove])`.

Revised exception handling:

- If unhandled, show an error message/call OnError_before_ the stack unwinds (making exceptions consistent with runtime errors).
- Fixed \_\_Delete causing commands to throw even when Try is not used.
- Fixed COM clients unable to catch built-in script errors.

Removed the limits on the number of custom modifiers that can be used with each key.

Changed `Send {Text}` to avoid toggling CapsLock or waiting for Win+L.

Fixed #Warn ClassOverwrite to not warn for A\_Args.

Improved DBGp `source` command to properly convert between file codepage and UTF-8, and to reduce code size.

Other code size optimizations and trivial maintenance.

## 1.1.28.02 - April 7, 2018

Fixed `Control ChooseString` and `ControlGet FindString` ignoring the first two items.

Fixed `Control ChooseString` to send WM\_COMMAND even if the control's ID is 0.

Fixed WinActivate to restore the active window, as originally intended for [v1.1.20.00].

## 1.1.28.01 - March 31, 2018

Fixed Thread treating omitted parameters as 0.

Fixed FileAppend to stderr (\*\*).

Fixed `break label` being able to jump to an unrelated loop.

Reverted hotstring reset behaviour to pre-v1.1.28.00.

Added `Hotstring("Reset")` for manually resetting the hotstring recognizer.

## 1.1.28.00 - February 11, 2018

**Changes:**

- Changed \_\_Delete to catch and report exceptions when called during object cleanup. It previously had the (erroneous) effect of "postponing" the exception until the next function call or the end of the try-block/thread.
- Changed hotstring recognizer to reset when focus changes instead of just when the active window changes.
- Changed WinMenuSelectItem to treat menu`0&` as the window's system menu.

**New features:**

- Added support for all built-in variables in the path passed to #Include.
- Added[A\_TimeIdleKeyboard](Variables.htm#TimeIdleKeyboard) and [A\_TimeIdleMouse](Variables.htm#TimeIdleMouse).
- Added[A\_ListLines](Variables.htm#ListLines).
- Added[A\_ComSpec](Variables.htm#ComSpec) (alias of ComSpec).
- Added[A\_LoopFilePath](commands/LoopFile.htm#LoopFileFullPath) (alias of A\_LoopFileFullPath, which is a misnomer).
- Added hotstring[X option](Hotstrings.htm#X) to execute a same-line action instead of auto-replace.
- Added[Hotstring()](commands/Hotstring.htm).
- Added[function hotstrings](Hotstrings.htm#Function).
- Added MaxParts parameter to[StrSplit](commands/StrSplit.htm).
- Improved[#MenuMaskKey](commands/_MenuMaskKey.htm) to allow specifying VK and SC, or vk00sc000.

**Bug fixes:**

- Fixed #MenuMaskKey treating some valid keys (such as Del) as invalid.
- Optimised detection of AltGr on Unicode builds. This fixes a delay which occurred at startup (since v1.1.27.00) or the first time Send is called for each target keyboard layout (prior to v1.1.27.00).
- Fixed misleading vicinity lines for`x up::y` remap error.
- Fixed`Menu Tray, Icon, HICON:%hicon%`, which now uses _hicon_ without resizing it.

## 1.1.27.07 - January 21, 2018

Fixed default size of Gui with +Parent to not be restricted by parent [broken by v1.1.27.05].

Fixed controls not redrawing if a separate Tab control is shown/hidden immediately after the control was invalidated (such as when showing/hiding multiple controls at once).

## 1.1.27.06 - January 16, 2018

Fixed hotstrings/Input causing stuck dead keys (broken by v1.1.27.05).

## 1.1.27.05 - January 16, 2018

Fixed visible Input end keys causing any pending dead key to double up.

Fixed hotstrings/Input affecting how Tab/Esc act in a dead key sequence.

Fixed A\_IconFile returning an incorrect path if a DLL was used.

Fixed Gui with +Parent to center within the parent GUI vs. the screen.

Fixed Input/hotstring detection of dead key sequences in Universal Windows Platform (UWP) apps.

Fixed `< & v` and `> & v` being seen as duplicates, and similar cases. This affects custom combinations where the prefix key is also a modifier symbol. This also fixes hotkeys which consist only of modifier symbols and a single trailing space, such as `+ ::`, to be treated as errors rather than ignoring the space (hotkeys do not permit trailing space).

## 1.1.27.04 - January 10, 2018

Fixed #Warn ClassOverwrite giving erroneous warnings.

## 1.1.27.03 - January 6, 2018

Improved `Menu x, NoStandard` and `Menu x, DeleteAll` to work without attempting to destroy the underlying Win32 menu. This allows them to work when x is a menu bar or sub-menu of one.

Reworked the handling of `vkXXscYYY`:

- Fixed GetKeyVK and GetKeyName treating vkXXscYYY as vk00scYYY.
- Send is now more strict with {vk...} and invalid suffixes, consistent with similar changes made by[v1.1.27.00] (but sc is still supported).
- Reduced code size.

Fixed mishandling of numeric keys outside the 32-bit range (but inside the 64-bit range) in some corner cases on 64-bit builds. This only affects classes which use such numbers as names (not recommended for multiple reasons) and array access via IDispatch with such numbers as keys/member names.

## 1.1.27.02 - January 1, 2018

Fixed loading of bmp files as icons at original size.

Fixed compound assignments such as `Test.Prop[1] += 1` (broken by v1.1.27.01).

## 1.1.27.01 - December 31, 2017

Fixed program crashes caused by `++X` or `--X` in scripts which lack #NoEnv (broken by v1.1.27.00).

Fixed #Warn ClassOverwrite giving an erroneous warning for `++MyClass.X`.

Fixed remapping to allow custom combinations such as `a & b::c`.

Fixed Send/hotstrings/Input to adapt to the keyboard layout of the focused control instead of just the active window. In particular, this affects UWP apps such as Microsoft Edge.

Fixed hook hotkeys to suppress the Start menu activation which occurs when an isolated Ctrl/Shift up is received. Ctrl up may be generated by the system when switching from a keyboard layout with AltGr to one without (such as from UK to US), if Ctrl is not held down at the time. This fixes hotkeys such as `$#z::WinActivate x` when the change in focus causes those conditions.

Fixed Input not collecting characters when both Shift keys are down.

Fixed Input to use "sc" and "vk" for end keys in ErrorLevel rather than "Sc" and "Vk" (caused by v1.1.20).

Fixed `GetKeyName/VK/SC("vkXXscYYY")` where YYY begins with A-F (broken by v1.1.26).

## 1.1.27.00 - December 25, 2017

**Changes:**

Replaced AU3\_Spy.exe with WindowSpy.ahk.

- AU3\_Spy.exe is still launched if WindowSpy.ahk is not found.
- It now follows the focused control by default, and has a checkbox for both window and control to follow the mouse.
- It no longer takes over a global hotkey (Win+A). Instead, hold Ctrl or Shift to suspend updates (release them after focusing Window Spy).
- It is now possible to Alt-Tab to Window Spy on Windows 10 without the contents of the GUI changing.

Changed [a-z to mean vk41-vk5A](commands/Send.htm#AZ) when absent from the keyboard layout, except with Raw mode or when sending single unmodified characters. This allows hotkeys and sent keyboard shortcuts to work more intuitively on certain non-English keyboard layouts.

Changed Send on ANSI versions to use [SendInput()](http://msdn.microsoft.com/en-us/library/ms646310) in place of Alt+nnnnn for [special characters](commands/Send.htm#characters).

Changed the rules for [masking Alt/Win](commands/_MenuMaskKey.htm) after pressing a hook hotkey:

- Explicitly sent Alt/Win up may be masked. This fixes remappings such as`AppsKey::RWin`, but hotkeys which are intended to activate the Start Menu may require new workarounds.
- If Alt/Win is logically but not physically down, only hotkeys which require Alt/Win (such as`#a::`, not `*a::`) cause masking. This is to allow a remapping or wildcard hotkey to send the key-up without it being masked.
- Unsuppressed hotkeys such as`~#a::` no longer cause masking, because the unsuppressed keydown/keyup is sufficient to prevent a menu. However, mouse hotkeys like `~*MButton::` no longer suppress the Start Menu if combined with the Win key. It can be suppressed manually with `Send {Blind}{vk07}` or similar.
- The keyboard hook now tracks events in relation to Alt/Win, so that the mask key does not need to be sent if Alt/Win was already masked by some other event (physical or sent).

The hotkeys `~LWin::` and `~RWin::` no longer suppress the Start Menu. See [#MenuMaskKey](commands/_MenuMaskKey.htm) for details and a workaround.

Added proper validation for vk or sc key names, so names such as "sc01notvalid" are no longer recognized as keys.

Scripts containing hotkeys of the form `VKnnSCnnn::` will need to be corrected by removing `SCnnn`, which was previously ignored.

Help file: Replaced the standard HTML Help Viewer sidebar with the new HTML5 sidebar developed by Ragnar-F.

**New features:**

- Added[Min](commands/Math.htm#Min)/ [Max](commands/Math.htm#Max) built-in functions. [PR #84 from Ragnar-F]
- Added[A\_Args](Variables.htm#Args) as an alternative to the numbered variables.
- Added[force-local mode](Functions.htm#ForceLocal) for functions.
- Added[#Warn ClassOverwrite](commands/_Warn.htm#ClassOverwrite).
- Added[{Text} mode](commands/Send.htm#SendText) for Send and [T option](Hotstrings.htm#T) for hotstrings. These are like the Raw mode, but more reliable.
- Added[{ _key_ **DownR**}](commands/Send.htm#DownR) and changed remapping to use it, to fix issues with `AppsKey::RWin` and similar.

**Bug fixes:**

- Fixed icon-loading to not default to ID 0 when the index is invalid.
- Fixed VK↔SC mapping of PrintScreen. SC→VK was already correct on Vista and later.
- Fixed Hotkey control returning scXXX instead of names in some cases.
- Fixed ListVars crashing if a ByRef parameter refers to a variable containing an object. [PR #86 from HotKeyIt]
- Fixed some (very unlikely) memory leaks.
- Fixed menu handles not being freed if only the standard items are used.
- Fixed bold font not being applied to default menu item if it has a submenu and a Win32 menu handle.
- Fixed Send to use the correct modifier state with Unicode chars.
- Fixed`ControlSend {u n}`, where u is Unicode, to send n times, not just 1.
- Fixed inconsistent behavior of AltGr between OS versions. Specifically,`RAlt::` once again causes the system to "release" LCtrl on Windows 10, as it did prior to v1.1.26.01 (but unlike those old versions, it prevents the RAlt-up from reaching the active window). This change should not affect layouts without AltGr.
- Fixed`Menu Tray, Icon`, SB\_SetIcon and LoadPicture with non-zero Icon option to allow bitmaps (but convert if needed).
- Fixed menu items to not disappear when a cursor is set as a menu item's icon.
- Improved launching of Window Spy and the help file:
  - If AutoHotkey is installed but the current executable is in a different directory (i.e. portable), the installed file is no longer preferred as it may be the wrong version. It may still be used as a fallback.
  - On failure to launch the file, show the error message inside the dialog, not in its titlebar.
- Fixed one-line hotkeys with expressions beginning in`sc` or `vk`.
- Fixed`>`/ `<` hotkey modifiers incorrectly allowing both keys to be pressed. For example, `<^A` could erroneously be triggered by LCtrl+RCtrl+A, thereby preventing the `<>^A` hotkey from working.
- Fixed auto-replace hotstrings inserting the literal text "{Raw}" in some cases (specifically, when the replacement contains`{Raw}` and the O, R and \* options were not used).
- Fixed some hotkeys not using the hook when eclipsed by a wildcard hotkey, depending on the order of definition.
- Fixed key-down hotkeys to revert to "reg" if they were only "k-hook" because of a corresponding key-up hotkey which has since been disabled. (Prior to v1.1.07.03 this already happened, but the key-down hotkey was never set to "k-hook" in the first place if defined after the key-up.)
- Fixed hook hotkeys to ignore modifier changes made by`Send !^+#{key}` or when sending Unicode characters. This restores Send to how it was prior to v1.1.06 when at SendLevel 0, but keeps the v1.1.06+ behavior at SendLevel >= 1, allowing Send to trigger the right hotkeys.
- Improved the odds that Send from a "reg" hotkey such as`^m::Send x` will restore the modifier state if Send is being called for the very first time. This makes it less likely to produce a different (and unexpected) result the first time it is held down, such as xmmm instead of xxxx.

## 1.1.26.01 - July 16, 2017

Fixed RegDelete (with no args) failing when A\_LoopRegSubKey is blank, such as when enumerating keys directly under the root key.

Fixed `RAlt/LAlt::` sometimes failing to prevent menu activation after the user alt-tabs away from a window and reactivates it.

Fixed SC → VK translation for multimedia keys, PrintScreen, CtrlBreak, Pause, LWin and RWin, with the exception that multimedia keys, PrintScreen and CtrlBreak are still translated incorrectly on Windows 2000 and XP.

Fixed VK → SC translation for multimedia keys, CtrlBreak and Pause.

Fixed 'Wait commands such as RunWait to log extra lines for ListLines only when necessary to show that it is still waiting; that is, after resuming from an interruption which logged other lines.

## 1.1.26.00 - June 10, 2017

Changed the format ListVars uses to display variables containing objects. The object's class name is now shown.

Added "class" and "clsid" modes to ComObjType().

Revised class names shown by the debugger and significantly reduced code size in the process.

Revised FileSetAttrib, FileSetTime and FileDelete to reduce code size. There should not be any changes in behaviour.

Made other minor optimizations to code size.

Fixed GetKeySC() with the key names Esc, Escape, ScrollLock and PrintScreen.

Fixed hotstring word detection of words containing nonspacing marks, such as Arabic diacritics.

## 1.1.25.02 - May 13, 2017

Fixed GUI option strings being permanently truncated if an error is raised.

Fixed properties and class sub-variables to allow non-ASCII characters.

Fixed `new` operator to allow \_\_New to throw or exit.

## 1.1.25.01 - March 5, 2017

Fixed Send to allow other scripts to act on modifier state changes which immediately precede a special character, such as the Shift release in `Send Mört`.

## 1.1.25.00 - March 4, 2017

Added [Hotkey, If, % FunctionObject](commands/Hotkey.htm#IfFn).

Fixed website address in Help menu.

## 1.1.24.05 - February 3, 2017

Fixed WinSet AlwaysOnTop/Trans/TransColor to work on windows with 0 ExStyle.

## 1.1.24.04 - December 17, 2016

Fixed `File.Read<i>Num</i>()` repeating old data if a prior `File.Read()` had stopped reading at the end of the buffer.

Improved buffer utilisation when `File.Read()` reaches the end of the buffered data.

Fixed `GuiControl +Password` to use the default bullet character on XP and later.

Fixed `GuiControl +/-Password` to redraw the control immediately.

## 1.1.24.03 - November 19, 2016

Fixed COM exception messages to not end in `` `r``.

Fixed `{U+x}` to support supplementary characters (x > 0xFFFF).

Fixed class properties which lack get{} to return an empty value instead of the internal Property object when the class has a base which does not define a value for the property. Properties defined in baseless classes already behaved correctly.

Fixed the background color of controls on a Tab3 control when the system has visual styles disabled (i.e. Windows Classic).

Fixed handling of thread-exit in functions which are called directly by an event (such as OnExit functions). This bug had no known effect except in the v2-alpha branch.

Fixed the debugger to detect disconnection immediately (i.e. when a client terminates without calling stop/detach).

Fixed the debugger to treat `property_get -m 0` as "unlimited", as per the DBGp spec.

Fixed the debugger to expect base64 for `property_set -t integer/float`, as per the DBGp spec.

## 1.1.24.02 - October 13, 2016

Added a [Run with UI Access](Program.htm#Installer_uiAccess) option to the installer.

Added documentation for Tab3 [autosizing](commands/GuiControls.htm#Tab_Autosize).

Fixed several Tab3 bugs:

- Autosizing was not being triggered by the first call to[Gui Show](commands/Gui.htm#Show) if the `AutoSize` or `w` and `h` options were used.
- If a Tab3 control is empty when autosizing occurs, it now retains the default size instead of becoming unusable.
- Autosizing now occurs immediately before creating another tab control, as though[Gui Tab](commands/GuiControls.htm#TabCmd) was called.
- Autosizing failed if the tab control had negative screen coords.
- Hiding a Tab3 control with GuiControl now also hides its dialog/background.

Fixed OnMessage to pass lParam as unsigned on 32-bit.

Fixed `Gui Name :` to allow spaces before the colon.

Fixed identifying a Gui or GuiControl by HWND with a negative value.

Fixed ComObject to suppress any errors raised by [disconnection of events](commands/ComObjConnect.htm) after the script has released the object.

Fixed Gui Show causing the window to shrink if it had a multi-line menu bar.

Fixed `LV_InsertCol(n, width)` not causing ListView scrollbar to update on some OS versions.

Optimized code size of FileRecycleEmpty.

## 1.1.24.01 - August 2, 2016

Changed `Hotkey, If, Expression` to raise an error if the unused third parameter is not blank.

Fixed `&&`, `||` and ternary to release any object used as the condition, as in `if (a.subObject && b)`.

Fixed Gui/GuiControl failing to "check" radio buttons within a Tab3 control.

Fixed FileCreateShortcut to allow relative paths for the LinkFile parameter on Windows 10.

Fixed themed Tab3 control to not override the custom text color of its controls.

Fixed debugger mishandling continuation commands in some specific cases.

## 1.1.24.00 - May 22, 2016

**Breaking changes:**

Passing SetTimer's [_Label_](commands/SetTimer.htm#Label) parameter an empty variable or an expression which results in an empty value is now considered an error. The parameter must be either given a non-empty value or [completely omitted](commands/SetTimer.htm#OmitLabel).

[Run-once timers](commands/SetTimer.htm#once) are automatically deleted after running if they are associated with an object created by the script. This allows the object to be freed if the script is no longer referencing it, but it also means the timer's _Period_ and _Priority_ are not retained.

SetTimer, Hotkey, GuiControl and Menu now check the minimum parameter count of functions given by reference (not just by name, as in previous versions). If the function requires too many parameters, an error is raised or ErrorLevel is set (as appropriate).

**Backward-compatible changes:**

If SetTimer's [_Label_](commands/SetTimer.htm#Label) parameter is [omitted](commands/SetTimer.htm#OmitLabel) and [A\_ThisLabel](Variables.htm#ThisLabel) is empty, the current timer (if any) is used.

**New features:**

Added [Tab3 control type](commands/GuiControls.htm#Tab), solving a number of issues with Tab controls.

**Bug-fixes:**

Fixed GuiControl to update controls when adding/deleting tabs. Specifically:

- Selecting a new tab with`||` now works correctly.
- Deleting all tabs now hides the controls of the former tab.

Fixed `+Disabled`/ `+Hidden` losing effect on controls in a tab.

Fixed disabled tab controls to ignore Ctrl+Tab.

Fixed `Gui Tab` without parameters to start a new radio group if applicable. `Gui Tab` with parameters already had this effect.

## 1.1.23.07 - May 20, 2016

Fixed `Menu x, Insert, y, z, % object` to use the object, not ignore it.

Fixed `Menu x, Add, :item text, % object` to use the object, not look for a submenu.

## 1.1.23.06 - May 15, 2016

Fixed `break label` crashing the program if nested directly inside its target loop.

## 1.1.23.05 - March 27, 2016

Fixed InputBox, MsgBox, FileSelectFile and FileSelectFolder sending an unwanted Alt-up if Alt is down. This was due to an error with the Ctrl/Shift workaround added in v1.1.22.01.

Improved the Ctrl/Shift workaround to avoid unnecessarily "masking" the Win key if Ctrl, Shift or Alt is also down.

## 1.1.23.04 - March 26, 2016

Fixed LV\_Modify to support omitting Options, as in `LV_Modify(r,, col1)`.

## 1.1.23.03 - March 12, 2016

Fixed \_\_Delete meta-functions erroneously suppressing or prematurely re-throwing exceptions, when they are called during exception propagation.

Fixed load-time detection of function calls where a required parameter is blank, as in `fn(x,,y)`.

## 1.1.23.02 - March 12, 2016

Fixed RegDelete deleting the entire key instead of the default value.

Code maintenance; minor code size improvement.

## 1.1.23.01 - January 24, 2016

Fixed a theoretical issue with loading scripts from weird/very long paths.

Ahk2Exe: Fixed Unicode in compiled scripts (broken by v1.1.23.00 release).

## 1.1.23.00 - January 16, 2016

Added [Menu Insert](commands/Menu.htm#Insert) sub-command.

Added [MenuGetHandle()](commands/MenuGetHandle.htm).

Added [MenuGetName()](commands/MenuGetName.htm).

Added menu item options: Radio, Right, Break and BarBreak.

Improved the Menu command to allow identifying items by position: `1&`

Added [LoadPicture()](commands/LoadPicture.htm).

Added [hicon/hbitmap: syntax](misc/ImageHandles.htm) for passing handles to commands which normally load an image from file.

Added built-in variables: A\_CoordModeToolTip/Pixel/Mouse/Caret/Menu, A\_DefaultGui, A\_DefaultListView, A\_DefaultTreeView, A\_KeyDelayPlay, A\_KeyDuration/Play, A\_MouseDelayPlay, A\_SendLevel, A\_SendMode and A\_StoreCapsLockMode.

Added `Ix` Hotkey option to set the hotkey variant's input level to x.

Improved Picture control to support BackgroundTrans with icons.

Improved Picture control to reduce flicker when loading large images.

Small optimizations to the menu code and built-in var lookups.

Fixed conversion of menu items to/from separators.

Fixed A\_ThisMenuItemPos to support duplicate item names.

Fixed sub-menus sometimes not being recreated after a menu is deleted.

Fixed AutoHotkeyXXX.exe to launch AutoHotkey.chm, not AutoHotkeyXXX.chm.

## 1.1.22.09 - November 11, 2015

Fixed some issues with SetTimer Delete.

- KeyHistory's timer count erroneously included deleted timers.
- Calling KeyHistory within a thread started by a timer crashed the script if the timer had been deleted but not turned off.
- Deleting the most recently created timer prevented subsequently created timers from working unless ALL timers were deleted.

## 1.1.22.08 - November 11, 2015

Fixed For-loop to pass control correctly when \_NewEnum/Next throws an exception.

Fixed Finally to suspend the pending exception until its body has been evaluated, not just until the first built-in function call.

Fixed load-time detection of invalid jumps from Finally blocks (broken by v1.1.20).

## 1.1.22.07 - September 27, 2015

Fixed Gui control `w-1` and `h-1` options failing when DPI is 150+% and the Gui has not applied `-DPIScale`.

Fixed `~<i>key</i> up` hotkeys to not perform an automatic `Send {<i>key</i> down}`. This was occurring only if the hotkey was turned on after the key was pressed down.

## 1.1.22.06 - September 13, 2015

Fixed Input and hotstrings to catch Unicode/non-key character events.

Fixed auto-sizing of Edit controls to include the last line if blank.

Fixed handling of out-of-memory in ComObj functions.

Fixed ComObjArray to ignore excess parameters rather than crashing (only applies to dynamic calls).

Fixed GuiControl to append--not prepend--tabs, as documented.

Fixed XP64 support.

## 1.1.22.05 - September 10, 2015

Fixed icons which have non-numeric IDs loading with sub-optimal quality.

Fixed Gui Destroy not releasing function objects which were set by the +g option.

Fixed Gui Show to avoid attempting to force-activate a child GUI.

Fixed failure to set Caps/Num/ScrollLock state while the key is down.

Fixed Gui Color causing incorrect text color (usually black).

Changed Gui Show to improve the odds of GuiSize executing immediately.

_For developers:_

- Modified project config to support more VC++ versions.
- Fixed various build warnings on VC++ 2015.
- 64-bit binaries are now built with VC++ 2015. 32-bit binaries still use VC++ 2010.

## 1.1.22.04 - August 19, 2015

Fixed ObjRawSet() to return nothing.

Added Windows 10 supportedOS tag to the exe manifest (avoids some issues with the Program Compatibility Assistant and similar).

Added detection of syntax errors after ")" in a function declaration.

## 1.1.22.03 - July 12, 2015

Fixed A\_EndChar returning a truncated value for Unicode end chars.

Small implementation changes:

- Changed A\_Language to use GetSystemDefaultUILanguage().
- Refactored Window Spy/help file launching from tray menu to improve code re-use.
- Optimized Gui/Menu/Hotkey/Hotstring/OnClipboard message handling (minor).

## 1.1.22.02 - May 27, 2015

Fixed TreeView to not raise `*` events for unknown notifications.

Fixed crashing/bad behaviour when a timer deletes itself.

Fixed RWin-up being [masked](commands/_MenuMaskKey.htm) in some rare cases where LWin-up wouldn't have been.

## 1.1.22.01 - May 24, 2015

Fixed Text/Edit/Button control sizing to compensate for character overhang.

Fixed registry commands to allow `:` in the SubKey when combined with RootKey.

Fixed hotkey prioritization to take modifiers into consideration.

Refactored else/try/catch/finally handling to support `hotkey::try cmd`.

Added a workaround for the script's dialogs acting as though Ctrl or Shift is pressed after they are blocked by the keyboard hook.

## 1.1.22.00 - May 1, 2015

Added SetErrorMode(SEM\_FAILCRITICALERRORS) on program startup to suppress system-level error messages such as "There is no disk in the drive". Calling Drive or DriveGet no longer affects the process' error mode.

Changed MonthCal controls to have tab-stop by default on Vista or later.

Improved ComObjConnect to use IProvideClassInfo when available.

Fixed some issues with method/property definitions following an end brace on the same line.

Fixed Text/Link control auto-sizing to compensate for the +Border (WS\_BORDER) style.

Fixed `Break <i>N</i>` when Loop is used directly below If/Else/Try/Catch.

## 1.1.21.03 - April 12, 2015

Fixed detection of naming conflicts between properties and methods.

## 1.1.21.02 - April 4, 2015

Fixed `OnMessage(msg, fnobj, 0)` to do nothing if _fnobj_ wasn't previously registered.

## 1.1.21.01 - April 3, 2015

Fixed StrReplace() to allow ReplaceText to be omitted.

Fixed class variables to allow non-ASCII names.

## 1.1.21.00 - March 28, 2015

Added [Loop, Reg, RootKey[\\Key, Mode]](commands/LoopReg.htm).

Added [Loop, Files, FilePattern [, Mode]](commands/LoopFile.htm).

Changed _InputVar_ parameters to allow [% expression](Variables.htm#percent-space) (except with If commands).

Revised [Object methods](objects/Object.htm):

- Added Object.InsertAt(), Object.Push() and ObjRawSet().
- Added Object.Delete(), Object.RemoveAt() and Object.Pop().
- Added Object.Length().

Added [Ord()](commands/Ord.htm) and updated Chr() to support supplementary chars (>0xFFFF).

Added [StrReplace()](commands/StringReplace.htm).

Removed the obsolete and undocumented 5-parameter mode of RegRead, which was exclusively for AutoIt v2 compatibility (the extra parameter was unused).

Changed [RegRead](commands/RegRead.htm), [RegWrite](commands/RegWrite.htm) and [RegDelete](commands/RegDelete.htm) so that the RootKey and SubKey parameters can optionally be combined.

## 1.1.20.03 - March 21, 2015

Fixed MouseGetPos (OutputVarControl), GuiContextMenu and GuiDropFiles (A\_GuiControl) to not ignore disabled controls [broken by v1.1.20.00].

## 1.1.20.02 - March 11, 2015

Fixed add-first mode of OnMessage.

Fixed A\_OSVersion for unrecognized OSes on x64 builds.

Fixed ExitApp to unpause the script before releasing objects in case a \_\_delete meta-function is called.

Trivial optimizations and code maintenance.

## 1.1.20.01 - March 10, 2015

Reverted the changes made in v1.1.20.00 to saving and restoring of ErrorLevel on thread interrupt, due to unintended consequences.

- ErrorLevel is not reset or cleared when a new thread starts. Instead, it retains the value it had in the interrupted thread, as in v1.1.19 and older.
- If ErrorLevel contains an object and the thread is interrupted, the object is replaced with an empty string when the thread resumes, as in v1.1.19 and older.
- If ErrorLevel contains a string longer than 127 characters, it is truncated when the thread resumes, as in v1.1.19 and older.

Re-fixed timers sometimes causing ErrorLevel to be formatted as hex.

Fixed class methods to retain a counted reference to the class.

## 1.1.20.00 - March 8, 2015

**New features:**

Enhanced Hotkey, Menu, SetTimer, Gui events and Gui control events to accept [a function instead of a label](misc/Labels.htm#Functions), if no label is found.

Enhanced Hotkey, Menu, SetTimer and Gui control events to accept a [function object](objects/Functor.htm). Added a Delete sub-command for SetTimer to allow the object to be released.

Enhanced [OnMessage()](commands/OnMessage.htm) to allow any number of functions or function objects to monitor a single message.

Added [OnExit()](commands/OnExit.htm#function) and [OnClipboardChange()](commands/OnClipboardChange.htm#function), which accept a function name or object.

Added capability to [point hotkey labels at a function definition](Hotkeys.htm#Function).

Added [U/L/T modifiers](commands/Format.htm#ULT) to perform case conversion with Format().

Added the [E option](commands/Input.htm#E) to the Input command, for handling end keys by character instead of keycode.

Added \*\* (stderr) support to FileAppend.

Added [ObjBindMethod(obj, method, args\*)](commands/ObjBindMethod.htm) and [Func.Bind(args\*)](objects/Func.htm#Bind).

**Changes:**

Changed the default behavior when the main script file is not found:

- If no script was specified and the default script files are not found, show the new[Welcome](Welcome.htm) page in the help file.
- If a script was specified or the help file is missing (or is named differently to the executable), just show an error message.

Changed WinActivate to restore the window if already active but minimized.

Changed WinActivate to look for a visible window to activate if DetectHiddenWindows is off and the active window is hidden, instead of doing nothing.

Changed the method used by A\_CaretX/A\_CaretY to retrieve the caret position.

- Returns blank in more cases where the real caret position can't be determined, instead of returning the top-left of the active window.
- Less likely to cause side-effects.
- Works in console windows.

Changed A\_OSVersion to use [RtlGetVersion()](http://msdn.microsoft.com/en-us/library/ff561910), so that it can detect Windows 10 and hopefully future versions.

Changed A\_OSVersion to return a version number of the form "major.minor.build" if it doesn't have a name for the OS.

Changed objects to support `x[,y]`, `x.y[,z]` and `x[](y)`.

- User-defined objects can utilize this by specifying default values for parameters of properties and meta-functions. For \_\_Call, the first parameter is omitted, as in`x.__Call(,y)`.
- COM objects invoke DISPID\_VALUE if the member name is omitted. For example,`x[]` retrieves x's default property and `fn[]()` can be used to call JScript functions.

Several under-the-hood changes to fix bugs, reduce code size or improve performance, including:

- Changes to preparsing of #if and static var initializers.
- Changes to preparsing of { blocks }.

**Bug-fixes:**

Fixed VK to keyname conversions for keys 'A' to 'Z' to respect layout.

- Applies to: GetKeyName, Hotkey control, A\_PriorKey, KeyHistory and Input EndKey ErrorLevel (except where Shift key is required).
- All other keys, including those that produce non-ASCII letters, were already translated according to AutoHotkey's current keyboard layout.

Fixed FileAppend to \* (stdout) to respect the encoding parameter instead of always outputting ANSI text.

Fixed auto-sizing of GUIs with only one scrollbar.

Fixed `Exception(m, n)` crashing when n is too far out of bounds.

Fixed GuiContextMenu to set A\_GuiEvent correctly on x64.

Fixed FileGetSize sometimes giving an indeterminate result if the file doesn't exist or can't be opened.

Fixed thread interrupts to save and restore ErrorLevel more fully [reverted in v1.1.20.01 due to unintended consequences].

Fixed ControlClick Pos mode to ignore disabled controls.

Fixed odd behaviour when Gui +MaxSize is smaller than +MinSize.

Fixed GuiControl/Get requiring a Gui name when given a control HWND.

Fixed meta-functions interfering with the line number reported by Exception().

## 1.1.19.03 - February 11, 2015

Improved remapping to allow `scXXX::Y` when the current keyboard layout does not map `scXXX` to a VK code. However, `Y` must still exist on the current keyboard layout.

Fixed `break n` to work correctly when `until` is present, instead of terminating the thread.

Fixed ControlGetFocus disrupting the user's ability to double-click (thanks HotKeyIt).

Fixed ListView to not call the control's g-label for unsupported (and previously unknown) notifications such as LVN\_GETEMPTYMARKUP.

Fixed `#Include *i <X>` to exit the program as intended if X has a syntax error.

Fixed `for var in <i>expression</i>` sometimes crashing the program when _expression_ calls a script function.

## 1.1.19.02 - January 25, 2015

Removed the 16-color icons which were used on Win9x/Win2k.

Removed the separate tray icon resources.

Improved selection of icon size when loading icons from DLL/EXE files.

- In short, prefer to downscale rather than upscale. This is especially helpful on systems with 125% or 150% DPI, where the system icon sizes are 20/40 or 24/48 instead of 16/32. If all of these sizes are present in the icon resource, this change makes no difference.

Fixed some issues with hotkey validation at load time.

- Hotkeys which are never valid, like foo::, are now always treated as errors instead of giving a misleading warning about keyboard layout.
- Hotkeys like ^!ä:: which are inactive because of the current keyboard layout are now allowed to have a same-line action, and the label is registered correctly (e.g. as "^!ä" and not as "^!ä:"). If the /iLib command line switch is used, the warning is suppressed.
- Remappings which are inactive because of the current keyboard layout now show two warnings instead of an unrecoverable error.
- If a Wheel hotkey is used as a prefix key, there is only one error message instead of two, and it respects /ErrorStdOut.

Fixed /iLib switch to write the file even if there's a syntax error.

Fixed return/break/continue/goto in try.. [finally](commands/Finally.htm).

## 1.1.19.01 - January 5, 2015

Fixed Hotkey command crashing the program when trying to create new variants of existing hotkeys (broken by v1.1.19.00).

Made some minor optimizations to the Hotkey command and A\_TimeIdle, relating to removal of Win9x support.

## 1.1.19.00 - January 4, 2015

Added a name for `Func.Call()`. `Func.()` still works but is deprecated.

Fixed some issues with `X.Y` and `X.Y(Z)` in VBScript/JScript/C#:

- If`X.__Call` contained a function _name_, it was being returned instead of called.
- When`X.Y(Z)` returned a value, Z was ignored. Now it acts like `X.Y[Z]` when X.Y is not a function.

Fixed the Hotkey command ignoring the ~ (pass-through) prefix if _Label_ was omitted.

Fixed the Hotkey command ignoring the $ (use-hook) prefix if the hotkey variant was already created without $.

Fixed `%Fn%()` syntax to work with JavaScript Function objects.

Fixed EXE manifest to disable UAC installer detection heuristics (broken by v1.1.17).

Improved the way threads are represented on the debugger's call stack.

- The type of thread is shown instead of the label name, which is still available in the next stack entry. For hotkeys, the hotkey is shown instead.
- The line number of the sub or function that the thread called is shown instead of the line the script was at before starting the thread.

## 1.1.18.00 - December 30, 2014

Improved IDispatch implementation for AutoHotkey objects:

- `X.Y` in VBScript and C# now returns X.Y if it is NOT a Func object; previously, it attempted to call X.Y() regardless of type.
- `X(Y)` in VBScript, JScript and C# now returns X[Y] unless X is a Func object, in which case it is called as before.
- `X[Y]` in C# now returns X[Y] if X is NOT a Func object; previously, it attempted to call X[Y]() regardless of type.
- `X.Y()` in C# now returns X.Y if it is NOT a Func object, due to ambiguity in the C# dispatch implementation.
- Unhandled exceptions are now converted to IDispatch exceptions.

Added support for creating new properties in JavaScript/IE DOM objects.

Fixed `FileAppend, %VarContainingClipboardAll%, File` causing crashes.

## 1.1.17.01 - December 28, 2014

Fixed COM event handlers not receiving the final object parameter.

## 1.1.17.00 - December 27, 2014

**New features:**

Added [Format()](commands/Format.htm).

[FileOpen()](commands/FileOpen.htm) can now be used to read from stdin or write to stdout or stderr by passing `"*"` or `"**"` as the filename. `AutoHotkey.exe *` can be used to execute script text piped from another process instead of read from file. For an example, see [ExecScript()](commands/Run.htm#ExecScript).

Added support for passing AutoHotkey objects to COM APIs as IDispatch.

Added support for VT\_BYREF in ComObject wrappers. Use `obj[]` to access the referenced value.

**Bug-fixes:**

Fixed blue-screening on XP SP2.

Fixed owned ComObjArrays to be returned by value, not by pointer. That is, a copy of the array is returned instead of a pointer to an array which is about to be deleted.

Changed the URL in the sample script which is created when you first run AutoHotkey.

Fixed `sc15D` to map to `vk5D`/AppsKey (Send, GetKeyName, etc.).

Fixed Edit controls to not treat AltGr+A as Ctrl+A.

Fixed static class vars to not act as a target for labels which immediately precede the class.

## 1.1.16.05 - September 28, 2014

Fixed x.y/[]/{} sometimes falsely being flagged as variadic.

## 1.1.16.04 - September 16, 2014

Fixed a crash which occurred when overwriting a non-writable property.

Fixed a crash which occurred when a RegExMatch object is created with uncaptured subpatterns during a regex callout.

## 1.1.16.03 - September 11, 2014

Fixed some bad behaviour in Abs() and Mod() caused by a broken bug-fix in v1.1.16.01.

## 1.1.16.02 - September 11, 2014

Fixed parser to allow #include inside a class (broken by a6ea27f).

Fixed Clipboard returning binary CF\_HDROP data in some instances.

Improved accuracy of FileGetSize on files which are still open.

Improved for-loop compatibility with COM objects.

## 1.1.16.01 - September 10, 2014

Added syntax for defining dynamic [properties](Objects.htm#Custom_Classes_property) in classes.

Added x+m and y+m options for Gui control positioning.

Added the #InputLevel of each hotkey to ListHotkeys (when non-zero).

Optimized RegExMatch with the O (object) option; capturing part of a long string is much faster than before in some cases.

Fixed objects to check for new methods after \_\_Call completes (consistent with \_\_Set and \_\_Get).

Fixed some undefined behaviour occurring after VarSetCapacity fails.

Fixed FileRead to correctly report an error with files over 4GB, instead of truncating even when it wasn't requested.

Fixed FileRead \*c to null-terminate correctly when byte length is odd.

Fixed some ClipboardAll issues and changed behaviour:

- [#ClipboardTimeout](commands/_ClipboardTimeout.htm) is ignored for GetClipboardData(), since it never actually worked and it caused problems. This fixes timeouts and lost data when a file is on the clipboard (any file on Windows 8, or any file in a zip file or similar).
- Zero-length clipboard items are allocated 1 byte upon restoring to the clipboard, since setting a zero-length item seems to always fail.
- The presence of MSDEVColumnSelect/MSDEVLineSelect is now preserved when set by Scintilla, though any data set by VS is discarded.
- When writing ClipboardAll directly to file, it now prefers Unicode (other usages of ClipboardAll have had this behaviour since v1.1.08).
- ClipboardAll and FileRead \*c on Unicode builds now round length up when odd. This increases the reported StrLen by 1, potentially avoiding truncation of the last byte.

Fixed A\_EventInfo for TreeView items with negative screen coords.

Fixed a possible ListView/TreeView message filtering issue.

Fixed A\_LineFile/A\_LineNumber in #If expressions.

Fixed #If to add itself to ListLines (though as "If").

Fixed `Abs(["-"]*)` and similar crashing the program.

Fixed `} funcdef(){` globally and `}}` ending a method/property/class.

## 1.1.15.04 - August 12, 2014

Fixed a performance issue with `&var_containing_long_string_of_digits`.

Fixed built-in variables corrupting memory when an object is assigned.

Fixed parser to disallow `continue` where appropriate even if the current function is defined inside a Loop.

Fixed `File.Encoding := x "-RAW"` breaking encoding/decoding of non-ASCII characters. The `-RAW` suffix is now ignored.

## 1.1.15.03 - August 2, 2014

Fixed meta-functions to exit the thread correctly after using Exit or Throw.

Fixed FileInstall to use A\_WorkingDir when Dest is relative in a non-compiled script.

## 1.1.15.02 - July 7, 2014

Fixed debugging negative integer keys in objects.

## 1.1.15.01 - June 30, 2014

Changed built-in error and warning dialogs to be always-on-top.

Fixed `Until` not breaking out of recursive file/registry loops.

## 1.1.15.00 - May 4, 2014

Added A\_OSVersion value `WIN_8.1`.

Changed the Hotkey command to apply/remove passthrough behavior on existing hotkey variants depending on whether the [tilde (~) prefix](Hotkeys.htm#Tilde) is present.

Changed exe manifest to allow [GetVersion](http://msdn.microsoft.com/en-us/library/windows/desktop/ms724439)/ [GetVersionEx](http://msdn.microsoft.com/en-us/library/windows/desktop/ms724451) to detect Windows 8.1.

## 1.1.14.04 - April 25, 2014

Fixed DllCall() crashing the script when _Function_ is pure integer 0.

Fixed `IsFunc("ComObj(")` to return false instead of throwing an exception.

Fixed ControlClick to send XButton1/XButton2 correctly.

## 1.1.14.03 - February 14, 2014

Fixed a memory leak in `new X` when `X.__Init` aborts the thread.

Fixed breakpoints shifting onto class var initializers when they are interspersed with method definitions.

## 1.1.14.02 - January 30, 2014

Fixed `x::` and `x up::` both firing on key-up if the state of the modifier keys prevented x from firing on key-down. The intended behaviour as of v1.1.14 is for both hotkeys to fire on key-up if x is also used in a custom combination like `x & y::`.

## 1.1.14.01 - January 15, 2014

Fixed Try without Catch/Finally crashing if no exception was thrown.

## 1.1.14.00 - January 15, 2014

Added [Finally](commands/Finally.htm) statement for performing cleanup after try/catch. [fincs]

**Changed behaviour** of [~ prefix](Hotkeys.htm#Tilde) with custom combos to be more intuitive.

Fixed `x & y::` to fire both `x::` and `x up::` when x is released.

Fixed ImageSearch to set ErrorLevel=2, not 0, when a GDI call fails.

Fixed EnvGet crashing the program when the var exceeds 32767 chars.

Fixed a minor error-handling bug with StatusBarWait's ErrorLevel.

Fixed a cause of heap corruption with FileRead \*c on ANSI builds.

Fixed passing of local vars in recursive calls to variadic functions.

Fixed script failing to load if the first line is an expression in parentheses.

Fixed PixelSearch Fast mode to set OutputVarX/Y only on success.

## 1.1.13.01 - October 11, 2013

Fixed variadic function calls with named values for required parameters.

## 1.1.13.00 - August 27, 2013

Ported [StrSplit()](commands/StrSplit.htm) from v2 alpha.

## 1.1.12.00 - August 14, 2013

Optional parameters can be omitted by writing two consecutive commas, as in `InStr(a, b,, 2)`. Unlike previous versions, this now works for objects (including COM objects) and built-in functions. `[a,,b]` can be used to create a sparse array.

Object properties can now be set using variadic syntax, as in `x[y*]:=z`, where y contains an array of keys/indices or parameters.

## 1.1.11.02 - July 28, 2013

Fixed GuiControl/Get to accept the ClassNN of a ComboBox's child Edit. Specifying the HWND of a ComboBox's child Edit was already supported as a means of identifying the ComboBox.

## 1.1.11.01 - June 25, 2013

Fixed InputBox default width/height (broken by v1.1.11.00 - commit [7373cc6443](https://github.com/Lexikos/AutoHotkey_L/commit/7373cc6443)).

Fixed DllCall arg type validation to handle SYM\_OBJECT safely, and to respect #Warn UseUnset (when var name is not a valid type).

Changed VarSetCapacity(var) to never warn about uninitialized vars.

## 1.1.11.00 - June 21, 2013

Added support for `%A_LineFile%` in [#Include](commands/_Include.htm).

Reduced the file size of AutoHotkeySC.bin by reducing the resolution of the (rarely used) filetype icon.

Fixed `class X extends Y` to allow Y to be defined after X.

Developed by fincs: AutoHotkey is now DPI-aware. The Gui commands automatically compensate when DPI is not 96. See [Gui -DPIScale](commands/Gui.htm#DPIScale).

## 1.1.10.01 - May 17, 2013

Improved RegRead to support REG\_BINARY values larger than 64K.

Improved RegWrite to support REG\_BINARY/REG\_MULTI\_SZ values larger than 64K.

Fixed Process Close (and possibly other things) on Windows XP.

## 1.1.10.00 - May 11, 2013

Added basic support for [custom Gui control types](commands/GuiControls.htm#Custom).

Revised [SoundSet](commands/SoundSet.htm), [SoundGet](commands/SoundGet.htm) and 'WaveVolume commands to better support Windows Vista and later.

Fixed `Run "<file>" <args>` to not pass the space as part of the args.

Fixed some issues with reading from console input (CONIN$).

## 1.1.09.04 - March 14, 2013

Fixed Gui menu accelerator keys not working when the Gui itself (not a control) has focus.

## 1.1.09.03 - February 9, 2013

Fixed [two bugs](https://www.autohotkey.com/board/index.php?showtopic=89624) which affected certain assignments where the target variable contains an unflushed binary number but has zero capacity.

Fixed GuiControl and GuiControlGet acting on the wrong control when given a HWND which does not belong to the current Gui. Instead, the condition is treated as an error.

Fixed OnMessage functions to set A\_Gui and A\_GuiControl correctly when the target Gui is a child window.

## 1.1.09.02 - December 24, 2012

Fixed MsgBox to show an error message when given invalid Options, instead of silently exiting the thread.

Fixed syntax errors in class var initializers causing the program to crash without the proper error message.

## 1.1.09.01 - December 15, 2012

Fixed AND/OR following a multi-statement comma, like `((x, y) and z)`.

Fixed RegExReplace to support duplicate subpattern names correctly.

Fixed Object.Remove() not freeing string keys.

Fixed base.Invoke() to not depend on dynamic variable resolution.

## 1.1.09.00 - November 7, 2012

**Breaking changes:**

Removed [.aut file compatibility](misc/AutoIt2Compat.htm) and #AllowSameLineComments.

Removed undocumented AutoIt v2 commands.

**Backward-compatible changes:**

Allow optional parameters to be declared with `:=` instead of `=`, for consistency with variable declarations and expressions.

Allow non-ASCII characters in unquoted keys ( `{<b>key</b>: x}` and `obj.<b>key</b>`).

Changed name in version info from "AutoHotkey\_L" to "AutoHotkey".

**Bug-fixes:**

Fixed instability caused by warning dialogs appearing part-way through evaluation of a command's args.

Fixed PixelSearch Fast mode treating "not found" as an error.

Fixed ahk\_exe to allow other ahk\_ criteria after it.

Fixed `else continue 2` and similar requiring braces around the loop.

Fixed RegRead indicating failure after successfully reading binary data.

Fixed `File.Length` to compensate for or flush any buffered data.

Fixed Gui sizing to account for scrollbars when present.

**Debugger:**

Added support for asynchronous commands.

Improved handling of breakpoints on lines like `else foo()` or `{ bar()` so that the debugger will actually break when appropriate.

Optimized code size, fixed several bugs and made the debugger generally more robust.

## 1.1.08.01 - August 3, 2012

Debugger: Fixed max\_depth being either half the intended limit or unlimited.

## 1.1.08.00 - July 14, 2012

**Breaking changes:**

Changed the default script codepage to ANSI, as the previous behaviour was a common source of confusion. UTF-8 files must now have a byte order mark (BOM) to be recognized correctly. Notepad adds a BOM to any file saved as UTF-8.

Changed `return x` to preserve formatting of numeric strings; it is now equivalent to `return (x)`.

Changed `Gui, Name: New` to set the new GUI as the default.

**Other changes:**

Changed ClipboardAll to prefer CF\_UNICODETEXT over other text formats.

Changed Gui Show to allow floating-point numbers.

Changed A\_OSVersion to return WIN\_8 on Windows 8.

Changed AutoHotkey.exe file description to include "ANSI/Unicode 32/64-bit".

Changed the parser to allow lines like `new MyObject()` with no assignment.

Upgraded PCRE to 8.30.

Improved wording of some [warnings](commands/_Warn.htm) and added a pointer to the documentation at the bottom of the warning dialog.

Improvements to the debugger:

- Added basic support for inspecting Func, ComObject and RegExMatchObject objects.
- Fixed the "attach debugger" message being ignored in some situations. See commit[83f0a0e](https://github.com/Lexikos/AutoHotkey_L/commit/83f0a0e39a0f69fc8861f8c4234690557c4ab347).

**New features:**

Added support for the PCRE construct `(*MARK:NAME)` via `RegExMatchObject.Mark`.

Added support for `classvar.x := y` assignments in class definitions (after declaring _classvar_).

Added [A\_Is64bitOS](Variables.htm#Is64bitOS).

Added [SetRegView](commands/SetRegView.htm) and [A\_RegView](Variables.htm#RegView).

**Fixes:**

Fixed `Func.()` to merely skip the function call if mandatory parameters were omitted instead of causing the thread to silently exit.

Fixed `Object.Remove()` not releasing object keys.

Fixed key-down/key-up hotkey pairs to suppress input correctly when only one hotkey in the pair is enabled.

Fixed `#Include <Lib>` to not affect the working directory used by subsequent #include directives.

Fixed `objaddref()` acting like `ObjRelease()` when called with a lower-case 'a'.

Fixed A\_AhkPath in 32-bit compiled scripts to detect 64-bit AutoHotkey installations and vice versa.

Fixed TreeView controls with `-Background` option rendering incorrectly on older OSes.

Fixed error messages shown during execution of While/Until to identify the appropriate line.

## 1.1.07.03 - March 25, 2012

Fixed Ctrl/Alt/Shift key-down hotkey breaking any corresponding key-up hotkey defined before it.

Fixed key-down hotkeys to always use the hook if defined after a key-up hotkey of the same key. If the key-down hotkey used the "reg" method, the hook would block the key-down event and trigger only the key-up hotkey.

Fixed load-time checks interpreting expressions with no derefs as raw text. For example, `gosub % "foo"` resolved to `"foo":` at load-time. Similarly, `% ""` was seen as invalid in various cases even if an empty string should be allowed.

## 1.1.07.02 - March 22, 2012

Fixed a rare crash which can occur when GetClipboardData() fails.

Fixed ComObjArray() to return an empty string on failure instead of an arbitrary integer.

Fixed `Object.Remove(i, "")` affecting integer keys when `!Object.HasKey(i)`.

## 1.1.07.01 - March 2, 2012

Fixed FileRead to ignore #MaxMem when reading UTF-16 on Unicode builds.

Fixed dynamic function calls with built-in vars such as `%A_ThisLabel%()`.

## 1.1.07.00 - February 27, 2012

Enhanced `<a href="Functions.htm#DynCall" data-index="97">%var%()</a>` to support [function objects](objects/Functor.htm) and the [default \_\_Call meta-function](Objects.htm#Default_Base_Object).

Fixed [ControlGet List](commands/ControlGet.htm#List) to work for ListViews where the script and the target process aren't both 32-bit or both 64-bit.

Fixed [SendEvent](commands/Send.htm#SendEvent) with a key delay of 0; a change introduced by v1.1.05.04 caused it to be slower than intended.

Fixed [Object.Remove(i)](objects/Object.htm#Remove) not adjusting keys if Object[i] doesn't exist.

Fixed an error in [ComObjType()](commands/ComObjType.htm) which may have caused unpredictable behaviour when it is called via an [alternative name](commands/ComObjActive.htm#Remarks).

Fixed [ExitApp](commands/ExitApp.htm) to exit the thread if an [OnExit](commands/OnExit.htm#command) subroutine prevents the script from terminating, instead of resuming execution after the [block](commands/Block.htm) which contained ExitApp.

Calling a function via an object no longer acts as a barrier to exiting the thread. Consequently, if [Exit](commands/Exit.htm) is used or a runtime error occurs within a [class method](Objects.htm#Custom_Classes_method), the entire thread exits instead of just the function.

Calling a base-class method using [base.Method()](Objects.htm#Custom_Classes_base) or similar inside a class definition no longer causes a [UseUnset](commands/_Warn.htm) warning if the method doesn't exist. Consequently, instantiating an object which has [instance variables](Objects.htm#Custom_Classes_var) no longer causes a warning about the internal `base.__Init` method if the base class has no instance variables.

## 1.1.06.02 - February 13, 2012

Fixed IniRead crashing when Section is omitted but Key isn't.

Fixed accuracy of FileGetSize with files which are 4GB or larger.

## 1.1.06.01 - February 12, 2012

Fixed MsgBox smart comma handling to require numeric Options, not Title.

## 1.1.06.00 - February 12, 2012

**New features:**

Integrated [#InputLevel](commands/_InputLevel.htm) directive and [SendLevel](commands/SendLevel.htm) command [by Russell Davis](https://github.com/Lexikos/AutoHotkey_L/pull/7).

Integrated support for [Link](commands/GuiControls.htm#Link) controls [by ChrisS85](https://github.com/Lexikos/AutoHotkey_L/pull/9).

**Breaking changes:**

Changed command parser to avoid trimming escaped characters such as `` `t`` or `` ` `` at the beginning or end of an arg.

Changed [MsgBox](commands/MsgBox.htm)'s smart comma handling to improve flexibility and consistency.

- `%` can now be used to make Options or Timeout an expression.
- If the first arg is an expression, any unescaped comma which is not
   enclosed in quote marks or parentheses/brackets/braces will cause
   multi-arg mode to be used. These commas were formerly interpreted
   as multi-statement operators within the first-and-only arg (Text).
- When Title is an expression, unescaped commas contained within the
   expression no longer interfere with smart comma handling.
- If there are exactly two args and the first is empty or an integer,
   multi-arg mode is used. The former behaviour was to combine both
   into a single arg (Text).
- Timeout can be a literal number or a single deref (and optionally
   part of a number; for example,`%Timeout%.500`). Contrary to the
   documentation, the former behaviour interpreted most other cases
   beginning with `%` as expressions (containing a double-deref).
- Title can be an expression even if Text and Options are omitted.

Changed A\_IsUnicode/A\_IsCompiled to be defined as an empty string in ANSI versions/uncompiled scripts instead of being left undefined. This allows them to be checked without triggering [#Warn](commands/_Warn.htm) warnings. Side effects include:

- Attempting to assign directly to A\_IsCompiled or A\_IsUnicode always causes a load-time error. Dynamic assignments always fail, either silently or with an error dialog as appropriate. Previously assignments were allowed in uncompiled/non-Unicode scripts.
- Attempting to take the address of A\_IsCompiled or A\_IsUnicode always fails.
- A\_IsCompiled and A\_IsUnicode no longer appear in ListVars when referenced by a script which is not compiled/Unicode.

Changed [Send](commands/Send.htm) and related commands to respect [#MenuMaskKey](commands/_MenuMaskKey.htm) when changing modifier keystates.

**Other changes:**

Changed [GuiControl Choose](commands/GuiControl.htm#Choose) to remove the ListBox/ComboBox/DDL's current selection when N=0.

Changed [RegisterCallback](commands/RegisterCallback.htm) to allow a [Func object](objects/Func.htm) in place of a name.

Changed [ListLines](commands/ListLines.htm) to show filenames (except when compiled).

Improved [Run](commands/Run.htm) to output a process ID if possible when ShellExecuteEx is used.

**Fixes:**

Fixed handle leaks in RegRead.

Fixed `x.y++` and similar to assign an empty string if x.y is non-numeric.

Fixed SendInput Win+L workaround causing Win key to "stick down".

Fixed Ahk2Exe auto-including the wrong file if an auto-include used [#Include <Lib>](commands/_Include.htm).

## 1.1.05.06 - December 31, 2011

Fixed inc (++) and dec (--) having no effect when used on an object field containing a string.

Fixed inc (++) and dec (--) to cause a warning when used on an uninitialized variable.

## 1.1.05.05 - December 17, 2011

Fixed `continue <i>n</i>` misbehaving when an inner loop has no braces.

Fixed `RegExMatchObject[Name]` to work correctly with duplicate names.

## 1.1.05.04 - December 5, 2011

Fixed: Selected sub-command of ControlGet was unreliable on x64.

Fixed: CPU was maxed out while waiting if an underlying thread displayed a dialog (and possibly in other cases).

## 1.1.05.03 - November 30, 2011

Fixed `Loop ... Until VarContainingObject`.

## 1.1.05.02 - November 20, 2011

Fixed false detection of end-of-file when loading a compiled script in some cases.

Fixed SendInput to automatically release modifier keys when sending special characters or {U+xxxx} (which was broken by v1.1.00.01).

Fixed ComObjConnect to filter out non-dispatch interfaces instead of allowing the script to crash.

Fixed `new %VarContainingClassName%()`.

## 1.1.05.01 - October 16, 2011

Fixed class declarations to allow directives such as #Include.

## 1.1.05.00 - October 8, 2011

Added [Client coordinate mode](commands/CoordMode.htm).

Added [object output mode](commands/RegExMatch.htm#ObjectMode) for RegExMatch and RegEx callouts.

Added [super-global](Functions.htm#SuperGlobal) declarations, which avoid the need to repeat global declarations.

**Breaking change:** Class declarations such as `Class c` now create a super-global variable instead of an ordinary global.

Added more detail to unhandled exception error dialogs.

Changed `<a href="commands/Gui.htm#Owner" data-index="131">Gui +Owner</a>` to work even after the GUI is created.

Changed instance var declarations in class definitions to avoid leaving empty key-value pairs in the class object.

Changed #Include to use standard error message formatting when it fails (more detail; also respects ErrorStdOut).

Changed [Throw](commands/Throw.htm) to throw an Exception object by default when its parameter is omitted.

Changed format of runtime error messages slightly to improve consistency and code size.

Modified PCRE to use UTF-16 for input on Unicode builds, for performance.

Upgraded PCRE to 8.13.

Fixed thread not exiting as intended when an assignment in an expression fails.

Fixed #MaxMem preventing assignments to variables which don't require expansion.

Fixed inability of Try/Catch to catch COM errors.

Fixed GuiControlGet incorrectly treating parameter #2 as invalid in some cases.

Fixed input vars being resolved too soon, allowing them to be invalidated by an expression later on the same line.

Fixed RegEx callouts not causing matching to abort when an exception is thrown.

Fixed DllCall setting ErrorLevel to -4 when it should be -3.

Fixed While appearing twice in ListLines for its first iteration.

Fixed Try/Catch to allow If/Loop/For/While with no enclosing block.

Fixed enumerator object not being released when Until is used to break a For-loop.

## 1.1.04.01 - September 15, 2011

Fixed FileRemoveDir setting ErrorLevel incorrectly.

## 1.1.04.00 - September 11, 2011

**Warning**: This release contains a number of potentially script-breaking changes.

Added exception handling support: [try](commands/Try.htm)/ [catch](commands/Catch.htm)/ [throw](commands/Throw.htm) and [Exception()](commands/Throw.htm#Exception).

Added StdOut mode for [#Warn](commands/_Warn.htm).

Added [Gui +HwndVARNAME](commands/Gui.htm#GuiHwndOutputVar) option.

Added [Gui, New [, Options, Title]](commands/Gui.htm#New).

Added automatic support for keyboard accelerators such as Ctrl+O in [Gui menus](commands/Gui.htm#Menu).

Changed handling of `#Include <Lib>` when the /iLib command-line switch is present to resolve a [problem](https://github.com/fincs/Ahk2Exe/issues/4) with Ahk2Exe.

Changed GuiControl to retain the Progress control's current value when its style is changed.

Changed GuiControl and GuiControlGet to allow a HWND to be passed in the _ControlID_ parameter.

Removed the 1GB limit from FileRead.

Improved error detection:

- `Hotkey, If, <i>Expression</i>`, where _Expression_ does not match an existing #If expression, is caught at load-time when possible.
- `Hotkey, If<i>Something</i>`, where _Something_ is invalid, is caught at load-time.
- Class definitions with missing braces are detected as errors.
- If a function call is used on the first line of a class definition, it is now correctly treated as an error.
- GroupAdd now shows an error message when the group name is blank, instead of silently exiting the thread.
- Removed some redundant "unset var" warnings which appeared when using the OutputDebug or StdOut warning modes.
- If an unrecognized option is used with[Gui](commands/Gui.htm#Options), [Gui Show](commands/Gui.htm#Show), [Gui New](commands/Gui.htm#New) or [GuiControl](commands/GuiControl.htm), an error message is shown and the thread exits unless [try](commands/Try.htm) is used. This validation is not done at load-time due to complexity (it is common for the option parameters to contain variable references).
- RegRead, RegWrite and RegDelete now set A\_LastError to the result of the operating system's GetLastError() function.
- [+LastFoundExist](commands/Gui.htm#LastFoundExist) is now treated as an error if it is combined with another option ( [+LastFound](commands/Gui.htm#LastFound) should be used in that case).

Fixed a [bug](https://www.autohotkey.com/forum/topic76133.html) affecting recursive variadic functions.

## 1.1.03.00 - August 28, 2011

Added support for GUI names.

Added support for identifying a GUI by its HWND.

Added `+Parent%ParentGui%` Gui option.

Added support for external windows as Gui owners via `+Owner%HWND%`.

Added Name sub-command for GuiControlGet.

Added support for ActiveX controls via the Gui command.

Fixed: Empty hotkey control returned "vk00".

Fixed: Crashes and memory leaks related to COM events/ComObjConnect.

Fixed: `GuiControlGet OutputVar, Subcmd, <b>%OutputVar%</b>` always failed.

Changed "Missing (/[/{" error messages to "Unexpected )/]/}" for greater clarity.

Changed ListLines to display While and Until lines which are executed each iteration.

Changed ~= to have higher precedence than =/!=/</>/<=/>= but lower than concat, and added it to the documentation.

## 1.1.02.03 - August 21, 2011

Fixed (Debugger): numchildren attribute did not include Object.Base.

## 1.1.02.02 - August 20, 2011

Fixed: Variable capacity was capped at 2GB on x64 builds.

Fixed: Last Found Window not set by `#if WinExist(T)`.

## 1.1.02.01 - August 13, 2011

Changed A\_PriorKey to exclude key-up events.

Fixed process name/path retrieval in certain cases, including:

- Retrieving name/path of a 64-bit process from a 32-bit script.
- Retrieving name/path of an elevated process from a non-elevated process (UAC).

## 1.1.02.00 - August 6, 2011

Added TV\_SetImageList().

Characters which require non-standard shift states 16 and 32 now use a fallback method instead of producing the wrong keystrokes.

Revised handling of dead keys to solve problems which occur when multiple scripts with hotstrings are active.

## 1.1.01.00 - July 30, 2011

Added support for instance variables in class definitions, using simple assignment syntax.

**Removed** `var` keyword used in class definitions; use `static` instead.

Added new built-in variables: A\_ScriptHwnd and A\_PriorKey.

Added new built-in functions: GetKeyName(), GetKeyVK(), GetKeySC() and IsByRef().

Added new sub-command: WinGet, OutputVar, ProcessPath.

Added the capability to specify a window by process name or path: `ahk_exe %Name%.exe` or `ahk_exe %FullPath%`.

Optimized ProcessName sub-command of WinGet.

Changed SetTimer to use A\_ThisLabel if Label is omitted.

Updated ComObjConnect() to support using an object in place of a function name prefix.

Improved ComObjConnect() to allow the prefix/object to be updated without first disconnecting.

Improved parsing of continuation sections to allow expressions like `(x.y)[z]()` without escaping "(".

Replaced the method used to store script text in 32-bit compiled scripts; now consistent with 64-bit.

Fixed detection of AltGr in the active window's keyboard layout (on Unicode builds).

Fixed SendInput applying a redundant LCtrl-up some time after AltGr-up.

## 1.1.00.01 - July 17, 2011

Fixed: Modifier keys weren't auto-released when sending special chars.

Fixed: Scancode/modifier-key mapping conflicts such as sc1xx vs ^sc0xx.

Fixed: $ and #UseHook had no effect if used only on the second or subsequent instance(s) of a hotkey.

Fixed: Potential crash when returning a value from a \_\_Delete meta-function.

Fixed: "Uninitialized variable" warnings were triggered by the debugger.

Changed: `base.Method()` no longer triggers a default meta-function or a warning.

Changed: `Gui +(Ex)Style` no longer hides/shows the Gui.

Changed the debugger to report type="undefined" for uninitialized variables.

Added check to avoid incorrectly sending keystrokes for characters which actually require the "hankaku" key.

Added support for integers as class variable names.

Added "Static" keyword for declaring class variables.

## 1.1.00.00 - May 1, 2011

**New features:**

Implemented basic [class definition syntax](Objects.htm#Custom_Classes).

Implemented the `<a href="Objects.htm#Custom_NewDelete" data-index="151">new</a>` keyword for creating a derived object.

Added [Func()](commands/Func.htm) for retrieving a reference to an existing function and improved [IsFunc](commands/IsFunc.htm) to recognize [function references](Objects.htm#Function_References).

Added support for `++` and `--` with object fields, such as `x.y[z]++`.

**Changes:**

Changed \_\_Delete to not trigger \_\_Call.

Changed OnClipboardChange to use AddClipboardFormatListener when available (i.e. on Windows Vista and later) to improve reliability.

Auto-concat with `(` is more selective, so some invalid expressions like `12(34)` will no longer work.

**Fixes:**

Fixed `SetTimer Label, -0` to be treated as "run-once, very soon".

Fixed A\_MyDocuments etc. to use SHGetFolderPath instead of undocumented registry keys.

Fixed non-empty ExcludeText causing windows with no text to be excluded.

## 1.0.97.02 - April 14, 2011

Fixed misinterpretation of comma as an arg delimiter when enclosed in `{}` in an expression.

Fixed For-loop to set A\_Index only after the _Expression_ arg is evaluated, so that the outer loop's value can be used.

Fixed default script location to be based on the directory containing the EXE (as documented), not the working directory.

Improved load-time validation to detect invalid attempts to jump out of a function with Goto.

## 1.0.97.01 - April 2, 2011

Fixed the 64-bit build to not truncate HWNDs or SendMessage/PostMessage params to 32 bits.

Fixed `*/::` being treated as an invalid hotkey (broken since L54).

Fixed the icons.

## 1.0.97.00 - March 28, 2011

Added `{key: value}` as syntax sugar for `Object("key", value)`.

Added `[x, y, z]` as syntax sugar for `Array(x, y, z)`, which is a new function equivalent to `Object(1, x, 2, y, 3, z)`.

Added slight optimization: resolve any reference to True, False, A\_PtrSize or A\_IsUnicode in expressions at load-time.

Fixed hotkey parser to treat `x & ^y` as an error instead of ignoring `^`.

## 1.0.96.00 - March 21, 2011

**New features:**

[ComObjQuery](commands/ComObjQuery.htm): Queries a COM object for an interface or service.

[ComObjFlags](commands/ComObjFlags.htm): Retrieves or changes flags which control a COM wrapper object's behaviour.

[ComObjCreate](commands/ComObjCreate.htm) allows non-dispatch objects to be created if an interface identifier (IID) is given.

[COM arrays](commands/ComObjArray.htm) support for-loops and the Clone() method.

ListVars shows the inner variant type and value of each COM wrapper object, in addition to the wrapper's address.

**Changes:**

When a literal integer or variable containing both a numeric string and cached binary integer is assigned to a field of an object, an integer is stored instead of a string. This particularly benefits scripts calling COM methods which accept integers but not strings, or have different behaviour depending on the type of value.

NULL values are now allowed with ComObjParameter for the VT\_UNKNOWN and VT\_DISPATCH types.

Improved support for Common Language Runtime (.NET) objects via COM.

FileRecycle should now warn before deleting a file which is too large to recycle.

When a SafeArray created with ComObjArray is assigned to an element of another SafeArray, a separate copy is created. This prevents the script from crashing due to a second attempt at "destroying" the array. ComObjFlags allows this behaviour to be avoided.

**Fixes:**

Assigning to a COM array of VT\_DISPATCH or VT\_UNKNOWN crashed the script.

Break and Continue were tolerated outside of loops in some cases.

Standalone carriage-return (\`r) was not correctly interpreted as end-of-line.

MouseMove miscalculated negative coordinates with the Input and Event send modes.

Selecting _Edit This Script_ from the tray menu or using the Edit command crashed the script (broken by v1.0.95).

Error dialogs pointed at irrelevant lines of code in some cases.

## 1.0.95.00 - March 12, 2011

All file I/O has been heavily optimized.

Added [#Warn](commands/_Warn.htm) to assist with debugging; initial design by ac.

By default, if _name\_var_ contains a function name, `name_var.()` calls the function. This can be overidden via the [default base object](Objects.htm#Default_Base_Object), as before.

Run supports verbs with parameters, such as `Run *RunAs %A_ScriptFullPath% /Param`.

If an operator which can accept either one operand ( `&x`) or two _numeric_ operands ( `x & y`) follows a quoted literal string, auto-concat occurs and the operator is applied only to the right-hand operand. This is because quoted literal strings are always considered non-numeric and are therefore not valid input for numeric operators. For example, expressions like `"x" &y` and `"x" ++y` now work.

**Fixed:**

- Wildcard hotkeys were not respecting modifiers such as`^!+` in specific cases.
- File.Pos returned garbage for non-seeking file types; now it returns -1.
- File.AtEOF was incorrectly true in some cases.
- COM wrapper objects left A\_LastError unset in some cases.
- Gui submenu icons did not work on Windows 2000/XP/Server 2003.
- SplashImage clipped the image if height > width.
- ComObjConnect did not alert when the first parameter is invalid.
- SplashImage now uses GDI+ only when the other methods fail, for compatibility.
- Tilde in`~x::` now affects `x & y::` in the same way that `~x & z::` would, instead of having no effect.
- A\_PriorHotkey and A\_TimeSincePriorHotkey now have the expected values when used with #If.
- RegExReplace did not advance through the string correctly after a match failure if the string contained non-ASCII characters.

## 1.0.92.02 - January 19, 2011

Fixed a memory leak which occurred when the return value of an object invocation or built-in function was not used, such as `file.ReadLine()` or `SubStr(x,y,z)` alone on a line.

Replaced the fix from v1.0.92.01 with a better fix, which also fixes `k::MsgBox(),x:=y` and doesn't break `if()`.

## 1.0.92.01 - January 18, 2011

Changed: FileCreateDir now sets A\_LastError.

Fixed: `GuiControl()` or similar was sometimes misinterpreted as a command.

## 1.0.92.00 - January 13, 2011

Added support for compound assignments with objects, such as `x.y += z`.

Improved IniWrite in Unicode builds to prevent an empty line from appearing at the top of each new file.

Improved the parser to be more permissive about what can follow `{`/ `}`/ `Else`, especially when combined.

## 1.0.91.05 - January 1, 2011

Fixed: Cleanup code in COM method calls was freeing the wrong parameters.

Fixed (ANSI): DllCall set incorrect length for WStr parameters on output.

Fixed: Variadic function calls were unstable when param object was empty.

## 1.0.91.04 - December 29, 2010

Fixed (Unicode): RegExReplace omitted all text up to StartingPos (broken by v1.0.90.00).

## 1.0.91.03 - December 27, 2010

Fixed: RegEx callout subpattern vars - broken by v1.0.90.00.

## 1.0.91.02 - December 26, 2010

COM: Added protection against NULL IDispatch/IUnknown pointers.

COM: Skip QueryInterface for IDispatch if VT\_DISPATCH is passed explicitly.

Minor fix for maintainability: `obj.field := var` now correctly yields SYM\_STRING, not SYM\_OPERAND.

## 1.0.91.01 - December 24, 2010

Fixed: Unexpected results with `File.Write(Str)` after text-reading.

Fixed: UTF BOM check caused unexpected results in files without a BOM.

Fixed (ANSI): Parsing loops and `File.ReadLine()` treated `Chr(255)` as EOF.

Fixed (Unicode): RegExReplace errors where the UTF-8 and UTF-16 lengths differed.

Fixed: Disabling the last hook hotkey breaks Input.

Added: Simple optimization for RegExMatch/Replace.

## 1.0.91.00 - December 21, 2010

_All changes in this release are COM-related._

Added: [ComObjError](commands/ComObjError.htm) now returns the previous setting.

Added: [ComObjType(co)](commands/ComObjType.htm) and [ComObjValue(co)](commands/ComObjValue.htm).

Added: [ComObjMissing()](commands/ComObjActive.htm).

Added: [ComObjArray()](commands/ComObjArray.htm) and basic SAFEARRAY support.

Added: "Take ownership" parameter for [ComObjParameter()](commands/ComObjActive.htm).

Changed: Values passed to COM functions via ComObjParameter are no longer freed in the process of calling the function.

Changed: `ComObj.x()` now falls back to PROPERTYGET if member 'x' is not found. This fixes for-loops for some objects.

Changed: Wrap unhandled variant types in an object rather than returning integer value.

Changed: Manage VT\_UNKNOWN/VT\_ARRAY lifetime automatically, by default.

## 1.0.90.00 - November 27, 2010

Fixed: UrlDownloadToFile in Unicode builds on Windows < 7.

Fixed: Upper-ANSI characters were sent as Alt+0 in ANSI build.

Fixed: File.Pos was incorrect after attempting to read past EOF.

Fixed: Escape sequences in #If expressions and static initializers.

Fixed: ClipboardAll sometimes crashed the script with certain formats.

Fixed: Transform HTML calculated length incorrectly for &#NNN; entities.

Fixed: VarSetCapacity now correctly ignores #MaxMem for ByRef variables.

Fixed: `FileAppend,,file.txt` set ErrorLevel=1 even on success.

Fixed: Match length was miscalculated for RegEx callouts with the P) option.

Integrated Sean's improvements to number handling in COM interop.

Optimized RegExReplace and RegExMatch in Unicode builds.

## Revision 61 - October 3, 2010

Added: `ObjClone(Object)`, forgotten when `Object.Clone()` was implemented.

Added: Support for RegEx Unicode properties in Unicode builds. Also upgraded PCRE to 8.10.

Added: `Object.Remove(int, "")` removes `Object[int]` without affecting other keys.

Changed: `ComObj.xyz()` is now always treated as a method-call.

Changed: `Var := 123` is now left as an expression, for consistency. This makes `Var := 123` and `Var := (123)` equivalent, whereas previously the former assigned only a string and the latter assigned both a string and a cached binary integer. In particular, this avoids some confusing type mismatch errors with COM objects.

Fixed: Dynamic variadic calls to functions with mandatory parameters.

Fixed: The final parameter of an assume-global variadic function had to be explicitly declared local.

Fixed: Static initializers interfering with setting of breakpoints.

Fixed: More pointer size-related errors with PCRE callouts on x64 builds.

Fixed: Input with 'M' option treated Ctrl-M ( `` `r``) as Ctrl-J ( `` `n``).

Fixed: `Object.Remove(n)` returned 0 (not "") if `Object[n]` didn't exist.

## Revision 60 - September 24, 2010

Added: [File.Encoding](objects/File.htm#Encoding) for changing or retrieving the codepage in use by a File object.

Added: [Variadic functions and function-calls](Functions.htm#Variadic) and [indirect mode](commands/RegisterCallback.htm#Indirect) for callbacks.

Added: [Object.Clone()](objects/Object.htm#Clone)

Changed: ByRef parameters no longer require the caller to supply a variable.

Changed: `Obj.foo := ""` now frees foo's contents as originally intended (but still doesn't remove the field).

Changed: OnMessage functions now tolerate optional and ByRef parameters.

Changed: RegisterCallback now enables execute access on callbacks in 32-bit builds (already did in 64-bit builds).

Changed: RegisterCallback now treats explicit ParamCount="" as omitted.

Fixed: For-loop was treating non-expression "0" as true for scripted enumerators.

Fixed: ComEvent (ComObjConnect) not working on the ANSI build.

Fixed: ComEvent (ComObjConnect) not correctly backing up/restoring local vars when calling a function which is already running.

Fixed: Buffer overflow in A\_EndChar when there is no end char.

Fixed: Func->mNextFunc not inititialized to NULL (used only by LowLevel scripts).

Debugger: Added the capability to retrieve an object's contents (with a supported debugger client).

Debugger: Fixed a few bugs.

## Revision 59 - September 12, 2010

Fixed: #If _expression_ should now evaluate each _expression_ at most once per keypress in all cases.

Changed: SplashImage uses common image-loading routines; now supports PNG and similar, but results may differ from before for icon files.

Added: `<a href="commands/For.htm" data-index="171">For</a> x,y in z`.

Added: `Loop .. <a href="commands/Until.htm" data-index="172">Until</a> <i>expression</i>`, usable with any Loop or For-loop.

Added: Named loops; `<a href="commands/Continue.htm" data-index="173">continue</a> outer_loop`, `<a href="commands/Break.htm" data-index="174">break</a> 2`, etc.

Debugger: Encode stdout and stderr packets as UTF-8.

Debugger: Allow user to Abort, **Retry** or Ignore when the initial connection fails.

Debugger: Allow [attaching a debugger client](Scripts.htm#debug_attach) by sending the script a registered window message.

Debugger: Allow detaching debugger client by sending the "detach" DBGp command.

## Revision 58 - September 5, 2010

Added: `static var := expression`.

## Revision 57 - September 4, 2010

Fixed Str\*, WStr\* and AStr\* DllCall return types on x64.

Added functionality to [InStr](commands/InStr.htm) to bring it in line with StringGetPos:

- If_StartingPos_ is negative, the search is conducted right-to-left beginning at that offset from the end.
- An additional parameter is available to specify which_occurrence_ of the string to find.

Added `<a href="commands/_Include.htm" data-index="177">#include</a> <<i>LibName</i>>` for explicitly including a script from a [function library folder](Functions.htm#lib).

Added functionality to [IniRead](commands/IniRead.htm) and [IniWrite](commands/IniWrite.htm) allowing an entire section to be read or written.

Added functionality to [IniRead](commands/IniRead.htm) allowing a list of section names to be retrieved.

Added support for [custom verbs](commands/Run.htm#verbs) to Run/RunWait: `Run *<i>verb file</i>`.

Made [improvements](Compat.htm#Run) to the way Run/RunWait extracts the action and its parameters from the _Target_ parameter.

Changed [NumGet](commands/NumGet.htm)/ [NumPut](commands/NumPut.htm) to allow _Offset_ to be omitted entirely since _Type_ is always non-numeric.

Removed the restriction that a label can't point to the end of a block.

## Revision 56 - August 29, 2010

Added support for x64 compiled scripts. Requires Ahk2Exe\_L and x64 AutoHotkeySC.bin.

Fixed: Deref operator ( `*addr`) rejected addresses outside 32-bit range.

Fixed: `#If <i>expression</i>` memory allocation error on x64.

Fixed: Custom hotstring end chars with code points greater than U+00FF.

Fixed: Special characters being sent out of sequence by SendInput/Play.

Fixed: `*/` being discarded in continuation sections (see L54).

## Revision 55 - August 19, 2010

Fixed: GroupActivate not setting ErrorLevel=1 if no Label was specified.

Fixed: Tab controls in x64 build.

Fixed: String-copy mode of StrPut when length is omitted; broken by L53.

Fixed: Data-alignment issues in x64 builds.

Changed: Set A\_LastError for more File\* commands to assist debugging.

Includes FileAppend, FileRead, FileReadLine, FileDelete, FileCopy, FileMove, FileGetAttrib/Time/Size/Version and FileSetAttrib/Time.

Excludes FileCopyDir, FileRecycle, FileMoveDir, FileRemoveDir, FileRecycleEmpty, FileCreateDir and FileInstall as the APIs used do not consistently set or return a Win32 error code.

## Revision 54 - August 15, 2010

Fixed: RunAs in Unicode build. [jackieku]

Fixed: RegisterCallback in x64 build. [fincs]

Fixed: Executables failing to run on Win2k and WinXP prior to SP2. Win2k requires SP4 and updates (probably KB 816542). XP not tested.

Fixed: Dialogs such as MsgBox became unresponsive when interrupted by another script thread. Message filter/workaround added in L45 had to be removed.

Fixed: Multi-byte characters in default ANSI codepage; this was also causing a memory leak.

Fixed: ComObject now allows purely numeric property/method names.

Enhanced usability and capabilities of FileOpen/File object.

- FileOpen's_Flags_ parameter accepts a human-readable string of flags.
- FileOpen's "update" mode has been renamed "read/write" and now creates the file if it didn't already exist.
- FileOpen sets A\_LastError as appropriate.
- `File := FileOpen(handle,"h")` wraps an existing file handle in an object.
- `File.Seek(n)` defaults to SEEK\_END when n is negative.
- `File.Pos` (or `File.Position`) can be used in place of Tell and Seek.
- `File.Pos`, `File.Length`, `File.AtEOF` and `File.__Handle` can be used without empty parentheses `()`.
- `File.Length` can be set, as in `File.Length:=n`.
- `File.Read<i>Num</i>()` and `File.Write<i>Num</i>(n)` read or write a number, where _Num_ is a NumGet-compatible type name.
- `File.WriteLine(s)` is equivalent to ``File.Write(s "`n")``, for symmetry with `File.ReadLine()`.
- `File.Read()` reads and returns the remainder of the file when used without parameters.
- File object now returns "" for unrecognized methods and invalid syntax rather than the numeric_address_ of "".

Changed: GroupAdd's Label parameter now applies to the whole group. [[Discussion]](https://www.autohotkey.com/forum/topic61362.html)

Changed: GroupActivate sets ErrorLevel on success/failure. (Same thread as above.)

Changed: `*/` at the beginning of a line is ignored if there was no `/*`. [[Discussion]](https://www.autohotkey.com/forum/topic61109.html)

Removed ToCodePage and FromCodePage subcommands of Transform.

## Revision 53 - August 8, 2010

**Merged AutoHotkey64** \- COM support and x64 compatibility.

**x64** ( _changes since AutoHotkey64_):

- Fixed floating-point return values and exception handling for DllCall.
- Fixed RegEx callouts.
- Re-enabled GetProcAddress optimisation for DllCall.
- NumPut and NumGet default to "Int64" in x64 builds.

**COM** ( _changes since AutoHotkey64_):

- Allow ComObjParameter to wrap 64-bit values in 32-bit builds.
- Implemented more standard ref counting conventions in ComObjActive.
- Prevent extraneous AddRef for new ComObjects in certain cases.
- Don't treat pdispVal==NULL return value from Invoke as an error.
- Fail more predictably when given wrong type of object.
- Require explicit second param in ComObjType, don't assume "IID".
- Free local vars after ComEvent calls a function.
- Remove pVarResult param from ComEvent; use return value instead.
- Pass the original wrapper ComObject in each ComEvent call.
- Add context to ComError dialog; let the buttons make more sense.

Implemented common syntax validation code for enumerators. `Enum[]` and `Enum.Next()` are now supported with or without parameters. `Enum[]:=val` and similar obscure forms which worked in AutoHotkey\_COM/AutoHotkey64 are not allowed.

"Ptr" type is still signed (unlike AutoHotkey64), for maximum flexibility and consistency.

**Other changes:**

Added: `Object.<b>HasKey</b>(key)`.

Added: `Object(obj)` increments obj's reference count and returns its address.

Added: `ObjAddRef()` and `ObjRelease()`.

Fixed: A\_ThisHotkey now has the expected value when used with #If.

Fixed: RunAs in Unicode build (fixed by jackieku).

Changed: Default script codepage for ANSI builds is now CP0 (ANSI).

Changed: `x.y[]` is now equivalent to `(x.y)[]` rather than `x["y"]`.

Changed: Built-in methods can now be called with or without the underscore prefix (e.g. `obj.MaxIndex()` or `obj._MaxIndex()`).

## Revision 52 (again) - July 10, 2010

Added support for built-in and environment variables in double-derefs.

Improved support for multi-byte characters in certain codepages (previously only 932, 936, 949, 950 and 1361 were supported).

Fixed: StrPut failed for codepages which don't support WC\_NO\_BEST\_FIT\_CHARS, such as UTF-7.

Fixed: Double-deref as object - `literal%var%.literal`.

Fixed: `StrPut("", Encoding)` null-terminated an invalid address.

## Revision 52 - June 12, 2010

Fixed: ObjRemove's Key parameter is now optional, as with [Object.\_Remove](objects/Object.htm#Remove).

Fixed: Files were improperly locked while reading, unlike in older versions.

Fixed: Uppercase Hex format caused negative integers to become unsigned.

Fixed: RegExMatch was corrupting output array items when specific conditions were met. See [bug report](https://www.autohotkey.com/forum/topic59120.html).

## Revision 51 - April 11, 2010

Changed: Use <EXENAME>.ahk instead of AutoHotkey.ini or AutoHotkey.ahk.

Changed: Default to UTF-8 for script files; override with /CPnnn.

Fixed: Unpause when the script exits so that object \_\_Delete meta-functions can run.

## Revision 50 - March 27, 2010

Improved flexibility of [Object.\_Insert](objects/Object.htm#Insert).

- `Object._Insert(x)` \- inserts x at `_MaxIndex()="" ? 1 : _MaxIndex() + 1`.
- `Object._Insert(i,x,y,z)` \- inserts `x,y,z` at `i,i+1,i+2`.

Improved flexibility of [Object.\_Remove](objects/Object.htm#Remove).

- `Object._Remove(k)` \- removes and returns the value associated with k.
- `Object._Remove()` \- removes and returns the value at \_MaxIndex().

Added file share mode flags to FileOpen [by jackieku].

Fixed: 'P' option of RegExMatch incorrectly output 1 for subpatterns which did not match anything.

Fixed: `Object._SetCapacity(key,n)` was not null-terminating in some cases.

Fixed: StatusBarGetText returned only half of the text in Unicode builds.

## Revision 49 - March 14, 2010

Added [obj.\_NewEnum()](objects/Object.htm#NewEnum).

Added [ObjMethod(obj)](objects/Object.htm) for each built-in `obj._Method()`.

Changed: ObjSet/Get/Call can no longer be called/overridden by script.

Fixed: Potential crash caused by VK\_PACKET check added in L48.

Fixed: Character codes in VK\_PACKET events were potentially misinterpreted as scancodes.

Fixed: ExcludeText was ineffective after the first matching control.

## Revision 48 - February 21, 2010

Fixed: Standalone `obj.()` was not recognized as a valid expression.

ControlSend now uses WM\_CHAR to support characters which have no associated keycode. For instance, this applies to "…" (en-US), "∞" in a Unicode build and `{U+221e}` in either build.

KeyHistory now shows the full 16-bit character code for VK\_PACKET (VK=E7) events. [Send](commands/Send.htm#Unicode) may indirectly cause these to be generated for Unicode characters.

## Revision 47 - February 13, 2010

Fixed (Unicode): ControlGet,List with ListView controls.

## Revision 46 - February 11, 2010

Added A\_FileEncoding, which returns the current default file encoding.

Added [StrPut](commands/StrPut.htm) and extended [StrGet](commands/StrGet.htm) with additional features.

## Revision 45 - February 8, 2010

Added \_GetAddress; \_SetCapacity/\_GetCapacity may now operate on a given field. [[more info]](objects/Object.htm)

Added workaround for WM\_PAINT infinite loop often caused by subclassing.

Allow `obj.()` as a means to call the default method of an object; equivalent to `obj[""]()`.

Dev: Added solution and project files for MSBuild 4.0 & VS2010. [[more info]](https://github.com/Lexikos/AutoHotkey_L/commit/ed81ea089c223b46c883036c14454aa4386d3801)

Fixed (Unicode): 'Running' column in ListHotkeys.

## Revision 44 - February 7, 2010

Fixed: Attempting to set "nothing" crashed the script. For instance, `x[]:=z`.

Fixed (Unicode): Unable to find default script (Documents\\AutoHotkey.ahk).

Fixed (Unicode): A\_Desktop, A\_ProgramFiles and several other built-in variables which read their value from the registry caused strings to be incorrectly terminated.

Fixed (ANSI): Characters in the range 0x80-0xFF couldn't be found by InStr or StringReplace.

Changed (ANSI): Treat ToCodePage/FromCodePage like other unsupported/invalid subcommands.

## Revision 43 - January 29, 2010

Fixed: obj.Func() resulting in a random integer when it should be an empty string.

## Revision 42 - January 28, 2010

Merged with AutoHotkeyU.

Numerous bug-fixes and improvements, some relating to the merge.

## Revision 41 - December 20, 2009

Fixed: Floating-point numbers were equivalent to an empty string when used as keys in objects. They are now converted to numeric strings in the current [float format](commands/SetFormat.htm), as originally intended.

## Revision 40 - December 13, 2009

Changed meta-functions and multi-param behaviour to improve flexibility. Meta-functions are now invoked \*before\* searching for an appropriate field in each base object; however, values in x.base will override meta-functions defined in x.base.base. Chaining meta-functions (inheritence) is now possible by avoiding "Return"

Improved Default Base functionality to be more consistent with real objects.

Changed (Debugger): While stepping through code, skip all braces except those which end a function.

Changed (Debugger): When stepping onto the hidden "Exit" at end of the script, consider it to be \*below\* the last physical line to avoid confusion.

## Revision 39 - December 2, 2009

Fixed (Debugger): Error in Base64 decoding used by property\_set.

## Revision 38 - November 17, 2009

Added: [#MenuMaskKey](commands/_MenuMaskKey.htm) directive to change which key is used to mask Alt/Win keyup events. See [this thread](https://www.autohotkey.com/forum/topic22378.html) for background information.

Changed: If `x[1,2]:=3` creates an object for `x[1]`, it's base is no longer automatically set to `x.base`. See [the documentation](Objects.htm#Subclassing_aoa) for a method of controlling this behaviour.

## Revision 37 - November 7, 2009

Added: Support for `obj[method_name](params)` object-call syntax.

## Revision 36 - November 4, 2009

Changed: If `x.y` or similar is immediately followed by an open-bracket ( `[`), the right-most identifier preceding the bracket is treated as the first parameter of the operation. For instance, `a.b.c[d]` is equivalent to `ObjGet(a.b,"c",d)` and `x.y[z]:=v` is equivalent to `ObjSet(x,"y",z,v)`. Previously each sub-expression preceding a bracket was evaluated separately.

Changed: If a method-call such as `x.y()` is followed immediately by an assignment, the parentheses are treated as brackets. For instance, `x.y(z):=v` is now equivalent to `ObjSet(x,"y",z,v)`.

Fixed: If(expr) and While(expr) with no delimiting space or comma.

## Revision 35 - October 25, 2009

Fixed: Standalone expressions beginning with two or more "dots", such as `x.y.z()`. (Broken by L34.) Note that '(' or '[' or ':=' is still required.

## Revision 34 - October 24, 2009

Changed: Setting a value within an object to an empty string now stores the empty string rather than removing the key-value pair from the object. \_Remove can still be used to completely remove key-value pairs.

Changed: Command names must be terminated with a space, tab or comma. The following characters no longer bypass this requirement: `<>:+-*/!~&|^[]`. For instance, syntax errors such as `MsgBox< foo` and `If!foo` are now caught at load-time.

Fixed: Return now properly handles expressions which result in a variable containing an object. For instance, `Return x:=y`, `Return (x)`, `Return x,...` and similar should work now ( `Return x` already worked).

Fixed: Multi-parameter get/set did not correctly support meta-functions for multiple objects (such as for `x` _and_ `x[y]` in the expression `x[y,z]`).

Fixed: Cascading object-assignments such as the `x[y]:=z` in `r:=x[y]:=z` could not yield numbers or objects - broken by L33.

Fixed: `x._Remove(y)` crashed the script or removed the wrong item if `x` did not contain `y`.

Fixed: `x.=y`, `if x.y=...` and similar. May affect other expressions.

Fixed: Standalone ternary expressions no longer requires spaces. For instance, `x? F(1) : F(2)` is now allowed.

Debugger: On script exit, disconnect debugger \*after\* releasing objects to allow debugging of \_\_Delete handlers.

## Revision 33 - October 3, 2009

Fixed: Local variables were not automatically freed for functions which return objects or pure numbers.

Fixed: Two separate reference-counting errors related to ternary operator and Object().

Fixed: If a string returned by a scripted object function was assigned directly to a variable, the variable's length was set incorrectly.

Fixed: If the last operation in an expression retrieved a string from a temporary object, the object and string were freed prematurely.

Fixed: Numeric strings with special formatting were not preserved when returned from a function via a variable or passed to a recursive function.

Fixed: If the final result of an expression (other than for Return) is an object, correctly yield an empty string instead of silently aborting the thread.

Fixed: \_\_Delete meta-functions sometimes overwrote temporary values in the deref buffer.

Added: An address retrieved via &object may be cast back into an object reference by using Object(address).

## Revision 32 - September 26, 2009

Fixed: Send/PostMessage crash when less than three parameters were specified.

## Revision 31 - September 26, 2009

Added: Object/array support and numerous minor changes to make this possible.

Added: Support for While(expression) with no delimiting space.

Added: Trim, LTrim, RTrim.

Added: A ~= B; equivalent to RegExMatch(A, B). May be removed in a future revision.

Fixed: An incompatibility with LowLevel.

Changed: Characters [, ] and ? are no longer valid in variable names. Consequently, ? (ternary) no longer requires a space on either side.

Changed: Optional parameters may now be omitted at any position in the parameter list of a non-dynamic function call. Since this works by automatically inserting the parameter's default value at load-time, it is not supported or allowed for dynamic function-calls.

Debugger: Various minor changes to make program flow easier to follow while stepping through code.

Optimization: If DllCall's first parameter is a literal string which identifies a function already present in memory, it is replaced with the actual address of the function.

Updated from v1.0.48.03 to v1.0.48.04.

## Revision 30 - May 31, 2009

Updated from v1.0.48.02 to v1.0.48.03.

## Revision 29 - May 2, 2009

All supported image formats may now be used as menu icons. Currently it is necessary to specify "actual size" when setting the icon to preserve transparency on Windows Vista and later. For example:

```
Menu, Icon, MenuItemName, Filename.png,, 0
```

## Revision 28 - May 2, 2009

Improved average-case performance of dynamic function calls by implementing binary search for function name look-ups. This change also applies to other areas, such as load-time resolution of function references in expressions and run-time resolution by OnMessage, RegisterCallback, etc.

## Revision 27 - April 26, 2009

Updated from v1.0.48.00 to v1.0.48.02.

## Revision 26 - April 11, 2009

Fixed: Menu icons were not drawn on items which have sub-menus if owner-drawing was in use.

Fixed: Menu icons were not freed if all menu items were deleted at once.

Changed (Source): Renamed AutoHotkey.sln to AutoHotkey\_L.sln to allow VS window to be identified more easily.

## Revision 25 - March 30, 2009

Fixed: Send {U+xxxx} correctly sets modifier key-state as with any normal key.

Fixed: Send {U+..xx} no longer triggers hotkey SCxx.

## Revision 24 - March 30, 2009

Added: Support for Send {U+xxxx}. SendInput() is used where available for proper unicode support, otherwise falls back to Alt+Numpad.

## Revision 23 - March 30, 2009

Fixed: GuiControl, Enable/Disable now only resets focus if the focused control was disabled.

## Revision 22 - March 26, 2009

Optimized If var [not] in/contains MatchList, especially for long lists containing shorter fields.

## Revision 21 - March 16, 2009

Minor optimizations to While. [thanks Chris]

Fixed (Debugger): Revisions 19 and 20 omitted timer threads from the call stack.

Fixed (Debugger): XML-reserved characters were not escaped in most situations.

Fixed (Debugger): Incorrect command and transaction\_id were used in the final response before exiting the script.

## Revision 20 - February 27, 2009

Changed: If an icon cannot be loaded with the new method, fall back to the old method.

## Revision 19 - February 26, 2009

Added: Gui, Font, qN option to set font quality/control anti-aliasing, where N is between 0 and 5.

Fixed: IL\_Add now loads icons at the most appropriate size when multiple sizes exist.

Merged with AutoHotkey v1.0.48, introducing bug fixes, optimizations and other changes by Chris. Some AutoHotkey\_L features were integrated into the mainstream release; changes to these features since previous revisions are as follows:

- Legacy behaviour is no longer applied to While - e.g. "While %x%" is correctly interpreted as a double-deref rather than as "While x".
- One-True-Brace style is now supported for While.
- Static vars may now be declared and initialized in assume-static functions.
- Passing too_few_ parameters in a dynamic function call is no longer allowed, as it allows the function's caller to second-guess the function's designer, reduces the ability to detect script bugs at runtime, and may cause the application to crash if calling a built-in function.

## Revision 18 - February 21, 2009

Fixed: Incomplete bug-fix in previous revision causing concat followed by assignment to skip the rest of the expression in some cases.

## Revision 17 - February 20, 2009

Added: Menu icons via Icon and NoIcon sub-commands of the Menu command.

Changed: Negative icon numbers can now be used to indicate a resource ID within an executable.

Changed: Set default style of menus to include MNS\_CHECKORBMP.

Changed: Load both small and large versions of custom tray icons to allow the correct icons to be shown in the appropriate places.

Fixed: Loading of icons from executable files at sizes other than the system small/large.

## Revision 16 - February 4, 2009

Fixed: Deleting a menu item partially deleted its associated sub-menu.

## Revision 15 - February 1, 2009

Fixed: SetFormat's presence in a \*compiled\* script was not disabling binary number write-caching. SetFormat should now work correctly in compiled scripts.

## Revision 14 - February 1, 2009

Numerous bug-fixes and optimizations by Chris (pre-v1.0.48 beta).

Added: Support for regex callouts and the auto-callout option 'C'.

Changed: A\_AhkVersion now includes the revision number. For instance, this is 1.0.47.07.L14.

Fixed: HWND's/window ID's were sign-extended to 64-bit. For instance, 0xb482057e became 0xffffffffb482057e.

## Revision 13 - November 29, 2008

Fixed: Invalid DllCall types were treated as INT in some build environments.

Added: Workaround for GuiEscape issue when disabling focused control.

Changed version info: InternalName, ProductName and FileDescription are now "AutoHotkey\_L" instead of "AutoHotkey".

## Revision 12 - September 6, 2008

Fixed: Potential access violation when using property\_get on a built-in variable. -- DBGP

## Revision 11 - September 5, 2008

Fixed: Remove checksum from AutoHotkeySC.bin via post-build script (AutoHotkey must be installed).

Added: .L suffix to A\_AhkVersion.

Added: Preliminary support for DBGp (interactive debugging).

## Revision 10 - August 2, 2008

Fixed: WheelLeft/WheelRight support, which was broken in revision 9.

## Revision 9 - July 29, 2008

Fixed: Allow Break/Continue in While.

Fixed: TrayTip in non-English Windows and possibly other side-effects of using Vista headers.

## Revision 8 - July 27, 2008

Added: #IfTimeout directive to set the timeout for evaluation of #If expressions, in milliseconds. Default is 1000.

Added: Assume-static mode for functions. "Static" must precede any local/global variable declarations.

Added: One-true-brace support for While.

Changed: While now sets A\_Index to the iteration about to begin.

## Revision 7 - July 26, 2008

Added: IsFunc(FuncName) - Returns a non-zero number if FuncName exists in the script or as a built-in function.

## Revision 5 - July 19, 2008

Cleaned up obsolete references to test scripts.

Added basic default test script.

## Revision 4 - July 18, 2008

Added: #if (expression) - Similar to #IfWinActive, but for arbitrary expressions.

Added: WheelLeft, WheelRight - Support for WM\_MOUSEHWHEEL, which was introduced with Windows Vista. (Requires Vista.)

Added: While, expression - Loop while a condition is true.

Added: A\_IsPaused - True if the underlying thread is paused.

Added: A\_IsCritical - True if the current thread has been marked uninterruptible by the "Critical" command.

Changed: Allow any number of parameters to be passed in dynamic function calls.

Fixed: Access Violation caused by WinGetClass and subclassed windows.

Fixed: Access Violation caused by empty dynamic function references.

