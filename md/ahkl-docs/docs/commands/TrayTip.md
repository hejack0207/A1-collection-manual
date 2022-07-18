# TrayTip

Creates a balloon message window near the tray icon. On Windows 10, a toast notification may be shown instead.

```
<span class="func">TrayTip</span> <span class="optional">, Title, Text, Seconds, Options</span>
```

## Parameters

Title

The title of the window. Only the first 73 characters will be displayed.

If _Title_ is blank, the title line will be entirely omitted from the window, making it vertically shorter.

**Warning:** The window will not be shown if the _Text_ parameter is omitted, even if a _Title_ is specified.

Text

The message to display. Only the first 265 characters will be displayed.

If this parameter is omitted or blank, any TrayTip balloon window currently displayed will be removed. However, to hide a Windows 10 toast notification it may be necessary to [temporarily remove the tray icon](#Windows10).

Carriage return (\`r) or linefeed (\`n) may be used to create multiple lines of text. For example: ``Line1`nLine2``.

If _Text_ is long, it can be broken up into several shorter lines by means of a [continuation section](../Scripts.htm#continuation), which might improve readability and maintainability.

Seconds

**Note:** This parameter has no effect on Windows Vista and later.

The approximate number of seconds to display the window, after which it will be automatically removed by the OS. Specifying a number less than 10 or greater than 30 will usually cause the minimum (10) or maximum (30) display time to be used instead. If blank or omitted, the minimum time will usually be used. This parameter can be an [expression](../Variables.htm#Expressions).

The actual timeout may vary from the one specified. Microsoft explains, "if the user does not appear to be using the computer, the system does not count this time towards the timeout." (Technical details [here](https://msdn.microsoft.com/en-us/library/bb773352(VS.85).aspx)). Therefore, to have precise control over how long the TrayTip is displayed, use the [Sleep](Sleep.htm) command followed by TrayTip with no parameters, or use [SetTimer](SetTimer.htm) as illustrated in the Examples section below.

Options

The _Options_ parameter can be a combination (sum) of zero or more of the following values:

FunctionDecimal ValueHex ValueInfo icon10x1Warning icon20x2Error icon30x3Windows XP and later: Do not play the notification sound.160x10Windows Vista and later: Use the large version of the icon.320x20

If omitted, it defaults to 0, which is no icon. The icon is also not shown by the balloon window if it lacks a _Title_ (this does not apply to Windows 10 toast notifications).

This parameter can be an [expression](../Variables.htm#Expressions).

## Remarks

On Windows 10, a TrayTip window usually looks like this:

![TrayTip](../static/dlg_traytip.png)

**Windows 10** replaces all balloon windows with toast notifications by default (this can be overridden via group policy). Calling TrayTip multiple times will usually cause multiple notifications to be placed in a "queue" instead of each notification replacing the last. To hide a notification, temporarily removing the tray icon may be effective. For example:

```
TrayTip #1, This is TrayTip #1
Sleep 3000   <em>; Let it display for 3 seconds.</em>
HideTrayTip()
TrayTip #2, This is the second notification.
Sleep 3000

<em id="Hide">; Copy this function into your script to use it.</em>
HideTrayTip() {
    TrayTip  <em>; Attempt to hide it the normal way.</em>
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  <em>; It may be necessary to adjust this sleep.</em>
        Menu Tray, Icon
    }
}

```

TrayTip has no effect if the script lacks a tray icon (via [#NoTrayIcon](_NoTrayIcon.htm) or `<a href="Menu.htm" data-index="9">Menu</a>, Tray, NoIcon`). TrayTip also has no effect if the following REG\_DWORD value exists and has been set to 0:

```
HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced >> EnableBalloonTips
```

On a related note, there is a tooltip displayed whenever the user hovers the mouse over the script's tray icon. The contents of this tooltip can be changed via: `<a href="Menu.htm" data-index="10">Menu</a>, Tray, Tip, My New Text`.

## Related

[ToolTip](ToolTip.htm), [SetTimer](SetTimer.htm), [Menu](Menu.htm), [SplashTextOn](SplashTextOn.htm), [MsgBox](MsgBox.htm), [InputBox](InputBox.htm), [FileSelectFile](FileSelectFile.htm), [FileSelectFolder](FileSelectFolder.htm)

## Examples

Shows a multiline balloon message or toast notification for 20 seconds near the tray icon without playing the notification sound. It also has a title and contains an info icon.

```
TrayTip, My Title, Multiline`nText, 20, 17
```

Provides a more precise control over the display time without having to use Sleep (which would stop the current thread). For Windows 10, replace the HideTrayTip function definition with the one defined [above](#Hide).

```
#Persistent
TrayTip, Timed TrayTip, This will be displayed for 5 seconds.
SetTimer, HideTrayTip, -5000

HideTrayTip() {
    TrayTip
}

```

Permanently displays a TrayTip by refreshing it periodically via timer. Note that this probably won't work well on Windows 10 for [reasons described above](#Windows10).

```
#Persistent
SetTimer, RefreshTrayTip, 1000
Gosub, RefreshTrayTip  <em>; Call it once to get it started right away.</em>
return

RefreshTrayTip:
TrayTip, Refreshed TrayTip, This is a more permanent TrayTip., , 16
return
```

