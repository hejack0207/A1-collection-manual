# pacat(1) - Play back or record raw or encoded audio streams on a PulseAudio sound server

Manuals, User

```
paplay [options] [FILE]
</synopsis>

<synopsis>
parecord [options] [FILE]
</synopsis>

<synopsis>
pacat [options] [FILE]
</synopsis>

<synopsis>
parec [options] [FILE]
</synopsis>

<synopsis>
pamon [options] [FILE]
</synopsis>

<synopsis>
pacat --help
</synopsis>

<synopsis>
pacat --version 
```

<a name="description"></a>

# Description

_pacat_ is a simple tool for playing back or capturing raw or encoded audio files on a PulseAudio sound server. It understands all audio file formats supported by _libsndfile_.

<a name="options"></a>

# Options


* **-h | --help**  
  Show help.
* **--version**  
  Show version information.
* **-r | --record**  
  Capture audio data and write it to the specified file or to STDOUT if none is specified. If the tool is called under the name _parec_ this is the default.
* **-p | --playback**  
  Read audio data from the specified file or STDIN if none is specified, and play it back. If the tool is called under the name _pacat_ this is the default.
* **-v | --verbose**  
  Enable verbose operation. Dumps the current playback time to STDERR during playback/capturing.
* **-s | --server**_=SERVER_  
  Choose the server to connect to.
* **-d | --device**_=SINKORSOURCE_  
  Specify the symbolic name of the sink/source to play/record this stream on/from.
* **--monitor-stream**_=INDEX_  
  Record from the sink input with index INDEX.
* **-n | --client-name**_=NAME_  
  Specify the client name _paplay_ shall pass to the server when connecting.
* **--stream-name**_=NAME_  
  Specify the stream name _paplay_ shall pass to the server when creating the stream.
* **--volume**_=VOLUME_  
  Specify the initial playback volume to use. Choose a value between 0 (silent) and 65536 (100% volume).
* **--rate**_=SAMPLERATE_  
  Capture or play back audio with the specified sample rate. Defaults to 44100 Hz.
* **--format**_=FORMAT_  
  Capture or play back audio with the specified sample format. Specify one of **u8**, **s16le**, **s16be**, **s32le**, **s32be**, **float32le**, **float32be**, **ulaw**, **alaw**, **s32le**, **s32be**, **s24le**, **s24be**, **s24-32le**, **s24-32be**. Depending on the endianness of the CPU the formats **s16ne**, **s16re**, **s32ne**, **s32re**, **float32ne**, **float32re**, **s32ne**, **s32re**, **s24ne**, **s24re**, **s24-32ne**, **s24-32re** (for native, resp. reverse endian) are available as aliases. Defaults to s16ne.
* **--channels**_=CHANNELS_  
  Capture or play back audio with the specified number of channels. If more than two channels are used it is recommended to use the **--channel-map** option below. Defaults to 2.
* **--channel-map**_=CHANNELMAP_  
  Explicitly choose a channel map when playing back this stream. The argument should be a comma separated list of channel names: **front-left**, **front-right**, **mono**, **front-center**, **rear-left**, **rear-right**, **rear-center**, **lfe**, **front-left-of-center**, **front-right-of-center**, **side-left**, **side-right**, **top-center**, **top-front-center**, **top-front-left**, **top-front-right**, **top-rear-left**, **top-rear-right**, **top-rear-center**, or any of the 32 auxiliary channel names **aux0** to **aux31**.
* **--fix-format**  
  If passed, the sample format of the stream is changed to the native format of the sink the stream is connected to.
* **--fix-rate**  
  If passed, the sampling rate of the stream is changed to the native rate of the sink the stream is connected to.
* **--fix-channels**  
  If passed, the number of channels and the channel map of the stream is changed to the native number of channels and the native channel map of the sink the stream is connected to.
* **--no-remix**  
  Never upmix or downmix channels.
* **--no-remap**  
  Never remap channels. Instead of mapping channels by their name this will match them solely by their index/order.
* **--latency**_=BYTES_  
  Explicitly configure the latency, with a time specified in bytes in the selected sample format. If left out the server will pick the latency, usually relatively high for power saving reasons. Use either this option or **--latency-msec**, but not both.
* **--latency-msec**_=MSEC_  
  Explicitly configure the latency, with a time specified in milliseconds. If left out the server will pick the latency, usually relatively high for power saving reasons. Use either this option or **--latency**, but not both.
* **--process-time**_=BYTES_  
  Explicitly configure the process time, with a time specified in bytes in the selected sample format. If left out the server will pick the process time. Use either this option or **--process-time-msec**, but not both.
* **--process-time-msec**_=MSEC_  
  Explicitly configure the process time, with a time specified in miliseconds. If left out the server will pick the process time. Use either this option or **--process-time**, but not both.
* **--property**_=PROPERTY=VALUE_  
  Attach a property to the client and stream. May be used multiple times
* **--raw**  
  Play/record raw audio data. This is the default if this program is invoked as pacat
  , 
  parec
  or 
  pamon
* **--file-format**_[=FFORMAT]_  
  Play/record encoded audio data in the file format specified. This is the default if this program is invoked as paplay
  and 
  parecord
* **--list-file-formats**  
  List supported file formats.

<a name="limitations"></a>

# Limitations

Due to a limitation in _libsndfile_ _paplay_ currently does not always set the correct channel mapping for playback of multichannel (i.e. surround) audio files, even if the channel mapping information is available in the audio file.

<a name="authors"></a>

# Authors

The PulseAudio Developers &lt;pulseaudio-discuss (at) lists (dot) freedesktop (dot) org&gt;; PulseAudio is available from **http://pulseaudio.org/**

<a name="see-also"></a>

# See Also

**pulseaudio(1)**, **pactl(1)**
