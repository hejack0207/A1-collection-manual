# SoundGet

Retrieves various settings of a sound device (master mute, master volume, etc.)

```
<span class="func">SoundGet</span>, OutputVar <span class="optional">, ComponentType, ControlType, DeviceNumber</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved setting, which is either a floating point number between 0 and 100 (inclusive) or the word ON or OFF (used only for _ControlTypes_ ONOFF, MUTE, MONO, LOUDNESS, STEREOENH, and BASSBOOST). The variable will be made blank if there was a problem retrieving the setting. The format of the floating point number, such as its decimal places, is determined by [SetFormat](SetFormat.htm).

ComponentType

If omitted or blank, it defaults to the word MASTER. Otherwise, it can be one of the following words: MASTER (synonymous with SPEAKERS), DIGITAL, LINE, MICROPHONE, SYNTH, CD, TELEPHONE, PCSPEAKER, WAVE, AUX, ANALOG, HEADPHONES, or N/A. If the sound device lacks the specified _ComponentType_, ErrorLevel will indicate the problem.

The component labeled Auxiliary in some mixers might be accessible as ANALOG rather than AUX.

If a device has more than one instance of _ComponentType_ (two of type LINE, for example), usually the first contains the playback settings and the second contains the recording settings. To access an instance other than the first, append a colon and a number to this parameter. For example: `Analog:2` is the second instance of the analog component.

ControlType

If omitted or blank, it defaults to VOLUME. Otherwise, it can be one of the following words: VOLUME (or VOL), ONOFF, MUTE, MONO, LOUDNESS, STEREOENH, BASSBOOST, PAN, QSOUNDPAN, BASS, TREBLE, EQUALIZER, or the number of a valid control type (see [soundcard analysis script](SoundSet.htm#Ex)). If the specified _ComponentType_ lacks the specified _ControlType_, ErrorLevel will indicate the problem.

**Note:** Sound devices usually support only VOLUME (or VOL) and MUTE, although others may be available depending on Windows and the sound device.

DeviceNumber

A number between 1 and the total number of supported devices. If this parameter is omitted, it defaults to 1 (the first sound device), or on Windows Vista or above, the system's default device for playback. This parameter can be an [expression](../Variables.htm#Expressions). The [soundcard analysis script](SoundSet.htm#Ex) may help determine which number to use.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 0 if the command succeeded. Otherwise, it is set to one of the following phrases:

- Invalid Control Type or Component Type
- Can't Open Specified Mixer
- Mixer Doesn't Support This Component Type
- Mixer Doesn't Have That Many of That Component Type
- Component Doesn't Support This Control Type
- Can't Get Current Setting

## Remarks

Support for Windows Vista and later was added in v1.1.10.

To discover the capabilities of the sound devices (mixers) installed on the system -- such as the available component types and control types -- run the [soundcard analysis script](SoundSet.htm#Ex).

For more functionality and finer grained control over audio, consider using the [VA library](https://www.autohotkey.com/board/topic/21984-vista-audio-control-functions/).

Use [SoundSet](SoundSet.htm) to change a setting.

## Related

[SoundSet](SoundSet.htm), [SoundGetWaveVolume](SoundGetWaveVolume.htm), [SoundSetWaveVolume](SoundSetWaveVolume.htm), [SoundPlay](SoundPlay.htm)

## Examples

Retrieves and reports the master volume.

```
SoundGet, master_volume
MsgBox, Master volume is %master_volume% percent.
```

Retrieves and reports the master mute setting.

```
SoundGet, master_mute,, Mute
MsgBox, Master mute is currently %master_mute%.
```

Retrieves and reports the master bass level if possible, otherwise an error message is displayed.

```
SoundGet, bass_level, Master, Bass
if ErrorLevel
    MsgBox, Error description: %ErrorLevel%
else
    MsgBox, The BASS level for MASTER is %bass_level% percent.
```

Retrieves the microphone mute setting. If the microphone is not muted, a message box is displayed.

```
SoundGet, microphone_mute, Microphone, Mute
if (microphone_mute = "Off")
    MsgBox, The microphone is not muted.
```

