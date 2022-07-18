# SoundSet

Changes various settings of a sound device (master mute, master volume, etc.)

```
<span class="func">SoundSet</span>, NewSetting <span class="optional">, ComponentType, ControlType, DeviceNumber</span>
```

## Parameters

NewSetting

Percentage number between -100 and 100 inclusive (it can be a floating point number or [expression](../Variables.htm#Expressions)). If the number begins with a plus or minus sign, the **current setting** will be adjusted up or down by the indicated amount. Otherwise, the setting will be set explicitly to the level indicated by _NewSetting_.

For _ControlTypes_ with only two possible settings -- namely ONOFF, MUTE, MONO, LOUDNESS, STEREOENH, and BASSBOOST -- any positive number will turn on the setting and a zero will turn it off. However, if the number begins with a plus or minus sign, the setting will be toggled (set to the opposite of its current state).

ComponentType

If omitted or blank, it defaults to the word MASTER. Otherwise, it can be one of the following words: MASTER (synonymous with SPEAKERS), DIGITAL, LINE, MICROPHONE, SYNTH, CD, TELEPHONE, PCSPEAKER, WAVE, AUX, ANALOG, HEADPHONES, or N/A. If the sound device lacks the specified _ComponentType_, ErrorLevel will indicate the problem.

The component labeled Auxiliary in some mixers might be accessible as ANALOG rather than AUX.

If a device has more than one instance of _ComponentType_ (two of type LINE, for example), usually the first contains the playback settings and the second contains the recording settings. To access an instance other than the first, append a colon and a number to this parameter. For example: `Analog:2` is the second instance of the analog component.

ControlType

If omitted or blank, it defaults to VOLUME. Otherwise, it can be one of the following words: VOLUME (or VOL), ONOFF, MUTE, MONO, LOUDNESS, STEREOENH, BASSBOOST, PAN, QSOUNDPAN, BASS, TREBLE, EQUALIZER, or the number of a valid control type (see [soundcard analysis script](#Ex)). If the specified _ComponentType_ lacks the specified _ControlType_, ErrorLevel will indicate the problem.

**Note:** Sound devices usually support only VOLUME (or VOL) and MUTE, although others may be available depending on Windows and the sound device.

DeviceNumber

A number between 1 and the total number of supported devices. If this parameter is omitted, it defaults to 1 (the first sound device), or on Windows Vista or above, the system's default device for playback. This parameter can be an [expression](../Variables.htm#Expressions). The [soundcard analysis script](#Ex) may help determine which number to use.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 0 if the command succeeded. Otherwise, it is set to one of the following phrases:

- Invalid Control Type or Component Type
- Can't Open Specified Mixer
- Mixer Doesn't Support This Component Type
- Mixer Doesn't Have That Many of That Component Type
- Component Doesn't Support This Control Type
- Can't Get Current Setting
- Can't Change Setting

## Remarks

[v1.1.10+]: This command supports Windows Vista and later.

For more functionality and finer grained control over audio, consider using the [VA library](https://www.autohotkey.com/board/topic/21984-vista-audio-control-functions/).

An alternative way to adjust the volume is to have the script send volume-control keystrokes to change the master volume for the entire system, such as in the example below:

```
Send {Volume_Up}  <em>; Raise the master volume by 1 interval (typically 5%).</em>
Send {Volume_Down 3}  <em>; Lower the master volume by 3 intervals.</em>
Send {Volume_Mute}  <em>; Mute/unmute the master volume.</em>
```

To discover the capabilities of the sound devices (mixers) installed on the system -- such as the available component types and control types -- run the [soundcard analysis script](#Ex).

Windows 2000/XP/2003: When SoundSet changes the volume of a component, all of that component's channels (e.g. left and right) are set to the same level. In other words, any off-center "balance" that may have been set previously is lost. This can be avoided for the WAVE component by using [SoundSetWaveVolume](SoundSetWaveVolume.htm) instead, which attempts to preserve the existing balance when changing the volume level.

[v1.1.10+]: On Windows Vista and later, SoundSet attempts to preserve the existing balance when changing the volume level.

Use [SoundGet](SoundGet.htm) to retrieve the current value of a setting.

## Related

[SoundGet](SoundGet.htm), [SoundGetWaveVolume](SoundGetWaveVolume.htm), [SoundSetWaveVolume](SoundSetWaveVolume.htm), [SoundPlay](SoundPlay.htm)

## Examples

Sets the master volume to 50%.

```
SoundSet, 50
```

Increases the master volume by 10%.

```
SoundSet +10
```

Decreases the master volume by 10%.

```
SoundSet -10
```

Mutes the microphone.

```
SoundSet, 1, Microphone, Mute
```

Toggles the master mute setting (sets it to the opposite state).

```
SoundSet, +1,, Mute
```

Increases the master bass level by 20% if possible, otherwise an error message is displayed.

```
SoundSet, +20, Master, Bass
if ErrorLevel
    MsgBox, The BASS setting is not supported for MASTER.
```

Soundcard Analysis. Use the following script to discover your soundcard's capabilities (component types and control types). It displays the results in a simple ListView. Alternatively, a script for Windows Vista and later which provides more detail (such as display names of devices) can be downloaded from the following forum topic: [https://www.autohotkey.com/board/topic/90877-/](https://www.autohotkey.com/board/topic/90877-/)

```
SetBatchLines -1
SplashTextOn,,, Gathering Soundcard Info...

<em>; Most of the pure numbers below probably don't exist in any mixer, but they're queried for completeness.
; The numbers correspond to the following items (in order): CUSTOM, BOOLEANMETER, SIGNEDMETER, PEAKMETER,
; UNSIGNEDMETER, BOOLEAN, BUTTON, DECIBELS, SIGNED, UNSIGNED, PERCENT, SLIDER, FADER, SINGLESELECT, MUX,
; MULTIPLESELECT, MIXER, MICROTIME, MILLITIME</em>
ControlTypes := "VOLUME,ONOFF,MUTE,MONO,LOUDNESS,STEREOENH,BASSBOOST,PAN,QSOUNDPAN,BASS,TREBLE,EQUALIZER,0x00000000, 0x10010000,0x10020000,0x10020001,0x10030000,0x20010000,0x21010000,0x30040000,0x30020000,0x30030000,0x30050000,0x40020000,0x50030000,0x70010000,0x70010001,0x71010000,0x71010001,0x60030000,0x61030000"

ComponentTypes := "MASTER,HEADPHONES,DIGITAL,LINE,MICROPHONE,SYNTH,CD,TELEPHONE,PCSPEAKER,WAVE,AUX,ANALOG,N/A"

<em>; Create a ListView and prepare for the main loop:</em>
Gui, Add, ListView, w400 h400 vMyListView, Component Type|Control Type|Setting|Mixer
LV_ModifyCol(4, "Integer")
SetFormat, Float, 0.2  <em>; Limit number of decimal places in percentages to two.</em>

Loop  <em>; For each mixer number that exists in the system, query its capabilities.</em>
{
    CurrMixer := A_Index
    SoundGet, Setting,,, %CurrMixer%
    if (ErrorLevel = "Can't Open Specified Mixer")  <em>; Any error other than this indicates that the mixer exists.</em>
        break

    <em>; For each component type that exists in this mixer, query its instances and control types:</em>
    Loop, parse, ComponentTypes, `,
    {
        CurrComponent := A_LoopField
        <em>; First check if this component type even exists in the mixer:</em>
        SoundGet, Setting, %CurrComponent%,, %CurrMixer%
        if (ErrorLevel = "Mixer Doesn't Support This Component Type")
            continue  <em>; Start a new iteration to move on to the next component type.</em>
        Loop  <em>; For each instance of this component type, query its control types.</em>
        {
            CurrInstance := A_Index
            <em>; First check if this instance of this instance even exists in the mixer:</em>
            SoundGet, Setting, %CurrComponent%:%CurrInstance%,, %CurrMixer%
            <em>; Checking for both of the following errors allows this script to run on older versions:</em>
            if ErrorLevel in Mixer Doesn't Have That Many of That Component Type,Invalid Control Type or Component Type
                break  <em>; No more instances of this component type.</em>
            <em>; Get the current setting of each control type that exists in this instance of this component:</em>
            Loop, parse, ControlTypes, `,
            {
                CurrControl := A_LoopField
                SoundGet, Setting, %CurrComponent%:%CurrInstance%, %CurrControl%, %CurrMixer%
                <em>; Checking for both of the following errors allows this script to run on older versions:</em>
                if ErrorLevel in Component Doesn't Support This Control Type,Invalid Control Type or Component Type
                    continue
                if ErrorLevel  <em>; Some other error, which is unexpected so show it in the results.</em>
                    Setting := ErrorLevel
                ComponentString := CurrComponent
                if (CurrInstance > 1)
                    ComponentString := ComponentString ":" CurrInstance
                LV_Add("", ComponentString, CurrControl, Setting, CurrMixer)
            }  <em>; For each control type.</em>
        }  <em>; For each component instance.</em>
    }  <em>; For each component type.</em>
}  <em>; For each mixer.</em>

Loop % LV_GetCount("Col")  <em>; Auto-size each column to fit its contents.</em>
    LV_ModifyCol(A_Index, "AutoHdr")

SplashTextOff
Gui, Show
return

GuiClose:
ExitApp
```

