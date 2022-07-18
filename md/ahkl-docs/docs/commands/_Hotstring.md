# \#Hotstring

Changes [hotstring](../Hotstrings.htm) options or ending characters.

```
<span class="func">#Hotstring</span> NoMouse
<span class="func">#Hotstring</span> EndChars NewChars
<span class="func">#Hotstring</span> NewOptions

```

## Parameters

NoMouse

Prevents mouse clicks from resetting the hotstring recognizer as described [here](../Hotstrings.htm#NoMouse). As a side-effect, this also prevents the [mouse hook](_InstallMouseHook.htm) from being required by hotstrings (though it will still be installed if the script requires it for other purposes, such as mouse hotkeys). The presence of `#Hotstring NoMouse` anywhere in the script affects all hotstrings, not just those physically beneath it.

EndChars NewChars

Specify the word EndChars followed a single space and then the new ending characters. For example:

```
#Hotstring EndChars -()[]{}':;"/\,.?!`n `t
```

Since the new ending characters are in effect globally for the entire script -- regardless of where the EndChars directive appears -- there is no need to specify EndChars more than once.

The maximum number of ending characters is 100. Characters beyond this length are ignored.

To make tab an ending character, include \`t in the list. To make space an ending character, include it between two other characters in the list (or at the beginning if the list contains only one other character, or no other characters).

NewOptions

Specify new options as described in [Hotstring Options](../Hotstrings.htm#Options). For example: `#Hotstring r s k0 c0`.

Unlike _EndChars_ above, the #Hotstring directive is positional when used this way. In other words, entire sections of hotstrings can have different default options as in this example:

```
::btw::by the way

#Hotstring r c  <em>; All the below hotstrings will use "send raw" and will be case sensitive by default.</em>
::al::airline
::CEO::Chief Executive Officer

#Hotstring c0  <em>; Make all hotstrings below this point case insensitive.</em>
```

## Remarks

Like other directives, #Hotstring cannot be executed conditionally.

## Related

[Hotstrings](../Hotstrings.htm)

[v1.1.28+]: The [Hotstring](Hotstring.htm) function can be used to change hotstring options while the script is running.

