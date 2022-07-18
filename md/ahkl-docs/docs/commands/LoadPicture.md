# LoadPicture() [v1.1.23+]

Loads a picture from file and returns a bitmap or icon handle.

```
Handle := <span class="func">LoadPicture</span>(Filename <span class="optional">, Options, ByRef ImageType</span>)
```

## Parameters

Filename

The filename of the picture, which is usually assumed to be in [A\_WorkingDir](../Variables.htm#WorkingDir) if an absolute path isn't specified. If the name of a DLL or EXE file is given without a path, it may be loaded from the directory of the current executable (AutoHotkey.exe or a compiled script) or a system directory.

Options

A string of zero or more of the following options, with each separated from the last by a space or tab:

**W** _n_ and **H** _n_: The width and height to load the image at, where _n_ is an integer. If one dimension is omitted or -1, it is calculated automatically based on the other dimension, preserving aspect ratio. If both are omitted, the image's original size is used. If either dimension is 0, the original size is used for that dimension. For example: `"w80 h50"`, `"w48 h-1"` or `"w48"` (preserve aspect ratio), `"h0 w100"` (use original height but override width).

**Icon** _n_: Indicates which icon to load from a file with multiple icons (generally an EXE or DLL file). For example, `"Icon2"` loads the file's second icon. [v1.1.27+]: Any supported image format can be converted to an icon by specifying `"Icon1"`. However, the icon is converted back to a bitmap if the _ImageType_ parameter is omitted.

**GDI+**: Use GDI+ to load the image, if available. For example, `"GDI+ w100"`.

ImageType

If a variable is specified, it is assigned a number indicating the type of handle being returned: 0 (IMAGE\_BITMAP), 1 (IMAGE\_ICON) or 2 (IMAGE\_CURSOR).

If this parameter is omitted or not a variable, the return value is always a bitmap handle (icons/cursors are converted if necessary). This is because reliably using or deleting an icon/cursor/bitmap handle requires knowing which type it is.

## Remarks

LoadPicture also supports [the handle syntax](../misc/ImageHandles.htm), such as for creating a resized image based on an icon or bitmap which has already been loaded into memory, or converting an icon to a bitmap by omitting _ImageType_.

If the image needs to be freed from memory, call whichever function is appropriate for the type of handle.

```
if (not ImageType)  <em>; IMAGE_BITMAP (0) or the ImageType parameter was omitted.</em>
    DllCall("DeleteObject", "ptr", Handle)
else if (ImageType = 1)  <em>; IMAGE_ICON</em>
    DllCall("DestroyIcon", "ptr", Handle)
else if (ImageType = 2)  <em>; IMAGE_CURSOR</em>
    DllCall("DestroyCursor", "ptr", Handle)
```

## Related

[Image Handles](../misc/ImageHandles.htm)

## Examples

Pre-loads and reuses some images.

```
Pics := []
<em>; Find some pictures to display.</em>
Loop, Files, %A_WinDir%\Web\Wallpaper\*.jpg, R
{
    <em>; Load each picture and add it to the array.</em>
    Pics.Push(LoadPicture(A_LoopFileFullPath))
}
if !Pics.Length()
{
    <em>; If this happens, edit the path on the Loop line above.</em>
    MsgBox, No pictures found!  Try a different directory.
    ExitApp
}
<em>; Add the picture control, preserving the aspect ratio of the first picture.</em>
Gui, Add, Pic, w600 h-1 vPic +Border, % "HBITMAP:*" Pics.1
Gui, Show
Loop
{
    <em>; Switch pictures!</em>
    GuiControl, , Pic, % "HBITMAP:*" Pics[Mod(A_Index, Pics.Length())+1]
    Sleep 3000
}
return
GuiClose:
GuiEscape:
ExitApp
```

