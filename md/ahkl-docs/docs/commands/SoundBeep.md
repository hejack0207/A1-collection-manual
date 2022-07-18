# SoundBeep

Emits a tone from the PC speaker.

```
<span class="func">SoundBeep</span> <span class="optional">, Frequency, Duration</span>
```

## Parameters

Frequency

The frequency of the sound, which can be an [expression](../Variables.htm#Expressions). It should be a number between 37 and 32767. If omitted, the frequency will be 523.

Duration

The duration of the sound, in milliseconds (can be an [expression](../Variables.htm#Expressions)). If omitted, the duration will be 150.

## Remarks

The script waits for the sound to finish before continuing. In addition, system responsiveness might be reduced during sound production.

If the computer lacks a sound card, a standard beep is played through the PC speaker.

To produce the standard system sounds instead of beeping the PC Speaker, see the asterisk mode of [SoundPlay](SoundPlay.htm).

## Related

[SoundPlay](SoundPlay.htm)

## Examples

Plays the default pitch and duration.

```
SoundBeep
```

Plays a higher pitch for half a second.

```
SoundBeep, 750, 500
```

