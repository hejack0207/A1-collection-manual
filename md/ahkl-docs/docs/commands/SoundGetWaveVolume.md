# SoundGetWaveVolume

Retrieves the wave output volume of a sound device.

```
<span class="func">SoundGetWaveVolume</span>, OutputVar <span class="optional">, DeviceNumber</span>
```

## Parameters

OutputVar

The name of the variable in which to store the retrieved volume level, which is a floating point number between 0 and 100 inclusive. The variable will be made blank if there was a problem retrieving the volume. The format of the floating point number, such as its decimal places, is determined by [SetFormat](SetFormat.htm).

DeviceNumber

If this parameter is omitted, it defaults to 1 (the first sound device), which is usually the system's default device for recording and playback. Specify a number higher than 1 to operate upon a different sound device.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

The current wave output volume level can be set via [SoundSetWaveVolume](SoundSetWaveVolume.htm). Settings such as Master Volume, Synth, Microphone, Mute, Treble, and Bass can be set and retrieved using [SoundSet](SoundSet.htm) and [SoundGet](SoundGet.htm).

[v1.1.10+]: On Windows Vista and later, this command is equivalent to [SoundGet](SoundGet.htm) with _ComponentType_ set to `Wave` and _ControlType_ set to `Volume`.

## Related

[SoundSetWaveVolume](SoundSetWaveVolume.htm), [SoundSet](SoundSet.htm), [SoundGet](SoundGet.htm), [SoundPlay](SoundPlay.htm)

## Examples

Retrieves and reports the current wave output volume.

```
SoundGetWaveVolume, OutputVar
MsgBox, The current wave output volume level is %OutputVar%`%.
```

