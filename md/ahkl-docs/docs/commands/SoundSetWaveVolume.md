# SoundSetWaveVolume

Changes the wave output volume of a sound device.

```
<span class="func">SoundSetWaveVolume</span>, Percent <span class="optional">, DeviceNumber</span>
```

## Parameters

Percent

Percentage number between -100 and 100 inclusive (it can be a floating point number or an [expression](../Variables.htm#Expressions)). If the number begins with a plus or minus sign, the **current volume level** will be adjusted up or down by the indicated amount. Otherwise, the volume will be set explicitly to the level indicated by _Percent_.

DeviceNumber

If this parameter is omitted, it defaults to 1 (the first sound device), which is usually the system's default device for recording and playback. Specify a number higher than 1 to operate upon a different sound device.

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

The current wave output volume level can be retrieved via [SoundGetWaveVolume](SoundGetWaveVolume.htm). Settings such as Master Volume, Synth, Microphone, Mute, Treble, and Bass can be set and retrieved using [SoundSet](SoundSet.htm) and [SoundGet](SoundGet.htm).

[v1.1.10+]: On Windows Vista and later, this command is equivalent to [SoundSet](SoundSet.htm) with _ComponentType_ set to `Wave` and _ControlType_ set to `Volume`. Both commands attempt to preserve the existing balance between channels.

Windows 2000/XP/2003: Unlike [SoundSet](SoundSet.htm), this command attempts to preserve the existing balance between channels (e.g. left and right) when changing the volume level.

## Related

[SoundGetWaveVolume](SoundGetWaveVolume.htm), [SoundSet](SoundSet.htm), [SoundGet](SoundGet.htm), [SoundPlay](SoundPlay.htm)

## Examples

Sets the wave output volume to its half-way point.

```
SoundSetWaveVolume, 50
```

Decreases the current wave output volume by 10 (e.g. 80 would become 70).

```
SoundSetWaveVolume, -10
```

Increases the current wave output volume by 20.

```
SoundSetWaveVolume, +20
```

