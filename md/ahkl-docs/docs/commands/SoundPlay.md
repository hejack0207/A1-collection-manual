# SoundPlay

Plays a sound, video, or other supported file type.

```
<span class="func">SoundPlay</span>, Filename <span class="optional">, Wait</span>
```

## Parameters

Filename

The name of the file to be played, which is assumed to be in [%A\_WorkingDir%](../Variables.htm#WorkingDir) if an absolute path isn't specified.

To produce standard system sounds, specify an asterisk followed by a number as shown below (note that the _Wait_ parameter has no effect in this mode):

- \*-1 = Simple beep. If the sound card is not available, the sound is generated using the speaker.
- \*16 = Hand (stop/error)
- \*32 = Question
- \*48 = Exclamation
- \*64 = Asterisk (info)

Known limitation: Due to a quirk in Windows, WAV files with a path longer than 127 characters will not be played. To work around this, use other file types such as MP3 (with a path length of up to 255 characters) or use 8.3 short paths (see [A\_LoopFileShortPath](LoopFile.htm#LoopFileShortPath) how to retrieve such paths).

Wait

If omitted, the script's [current thread](../misc/Threads.htm) will move on to the next command(s) while the file is playing. To avoid this, specify 1 or the word WAIT, which causes the current thread to wait until the file is finished playing before continuing. Even while waiting, new [threads](../misc/Threads.htm) can be launched via [hotkey](../Hotkeys.htm), [custom menu item](Menu.htm), or [timer](SetTimer.htm).

Known limitation: If the WAIT parameter is omitted, the OS might consider the playing file to be "in use" until the script closes or until another file is played (even a nonexistent file).

## Error Handling

[v1.1.04+]: This command is able to throw an exception on failure. For more information, see [Runtime Errors](Catch.htm#RuntimeErrors).

[ErrorLevel](../misc/ErrorLevel.htm) is set to 1 if there was a problem or 0 otherwise.

## Remarks

All Windows OSes should be able to play .wav files. However, other files (.mp3, .avi, etc.) might not be playable if the right codecs or features aren't installed on the OS.

If a file is playing and the current script plays a second file, the first file will be stopped so that the second one can play. On some systems, certain file types might stop playing even when an entirely separate script plays a new file.

To stop a file that is currently playing, use SoundPlay on a nonexistent filename as in this example: `SoundPlay, Nonexistent.avi`.

If the script is exited, any currently-playing file that it started will stop.

## Related

[SoundBeep](SoundBeep.htm), [SoundGet](SoundGet.htm), [SoundSet](SoundSet.htm), [SoundGetWaveVolume](SoundGetWaveVolume.htm), [SoundSetWaveVolume](SoundSetWaveVolume.htm), [MsgBox](MsgBox.htm), [Threads](../misc/Threads.htm)

## Examples

Plays a sound file located in the Windows directory.

```
SoundPlay, %A_WinDir%\Media\ding.wav
```

Generates a simple beep. If the sound card is not available, the sound is generated using the speaker.

```
SoundPlay *-1
```

