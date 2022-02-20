# ffplay(1)

 ,  

.if n .ad l
.nh

<a name="name"></a>

# Name

ffplay - FFplay media player

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" ffplay [options] [input_url]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
FFplay is a very simple and portable media player using the FFmpeg
libraries and the \s-1SDL\s0 library. It is mostly used as a testbed for the
various FFmpeg APIs.

<a name="options"></a>

# Options

.IX Header "OPTIONS"
All the numerical options, if not specified otherwise, accept a string
representing a number as input, which may be followed by one of the \s-1SI\s0
unit prefixes, for example: 'K', 'M', or 'G'.

If 'i' is appended to the \s-1SI\s0 unit prefix, the complete prefix will be
interpreted as a unit prefix for binary multiples, which are based on
powers of 1024 instead of powers of 1000. Appending 'B' to the \s-1SI\s0 unit
prefix multiplies the value by 8. This allows using, for example:
'\s-1KB\s0', 'MiB', 'G' and 'B' as number suffixes.

Options which do not take arguments are boolean options, and set the
corresponding value to true. They can be set to false by prefixing
the option name with no\*(R". For example using \*(L"-nofoo\*(R"
will set the boolean option with name foo\*(R" to false.

<a name="stream-specifiers"></a>

### Stream specifiers

.IX Subsection "Stream specifiers"
Some options are applied per-stream, e.g. bitrate or codec. Stream specifiers
are used to precisely specify which stream(s) a given option belongs to.

A stream specifier is a string generally appended to the option name and
separated from it by a colon. E.g. \f(CW`-codec:a:1 ac3\*(C' contains the
\f(CW`a:1\*(C' stream specifier, which matches the second audio stream. Therefore, it
would select the ac3 codec for the second audio stream.

A stream specifier can match several streams, so that the option is applied to all
of them. E.g. the stream specifier in \f(CW`-b:a 128k\*(C' matches all audio
streams.

An empty stream specifier matches all streams. For example, \f(CW`-codec copy\*(C'
or \f(CW`-codec: copy\*(C' would copy all the streams without reencoding.

Possible forms of stream specifiers are:

* _stream\_index_  
  .IX Item "stream_index"
  Matches the stream with this index. E.g. \f(CW`-threads:1 4\*(C' would set the
  thread count for the second stream to 4.
* _stream\_type_**[:**_stream\_index_**]**  
  .IX Item "stream_type[:stream_index]"
  _stream\_type_ is one of following: 'v' or 'V' for video, 'a' for audio, 's'
  for subtitle, 'd' for data, and 't' for attachments. 'v' matches all video
  streams, 'V' only matches video streams which are not attached pictures, video
  thumbnails or cover arts.  If _stream\_index_ is given, then it matches
  stream number _stream\_index_ of this type. Otherwise, it matches all
  streams of this type.
* **p:**_program\_id_**[:**_stream\_index_**] or p:**_program\_id_**[:**_stream\_type_**[:**_stream\_index_**]] or**  
  .IX Item "p:program_id[:stream_index] or p:program_id[:stream_type[:stream_index]] or"
  p:_program\_id_:m:_key_[:_value_]
  In first version, if _stream\_index_ is given, then it matches the stream with number _stream\_index_
  in the program with the id _program\_id_. Otherwise, it matches all streams in the
  program. In the second version, _stream\_type_ is one of following: 'v' for video, 'a' for audio, 's'
  for subtitle, 'd' for data. If _stream\_index_ is also given, then it matches
  stream number _stream\_index_ of this type in the program with the id _program\_id_.
  Otherwise, if only _stream\_type_ is given, it matches all
  streams of this type in the program with the id _program\_id_.
  In the third version matches streams in the program with the id _program\_id_ with the metadata
  tag _key_ having the specified value. If
  _value_ is not given, matches streams that contain the given tag with any
  value.
* **#**_stream\_id_ **or i:**_stream\_id_  
  .IX Item "#stream_id or i:stream_id"
  Match the stream by stream id (e.g. \s-1PID\s0 in MPEG-TS container).
* **m:**_key_**[:**_value_**]**  
  .IX Item "m:key[:value]"
  Matches streams with the metadata tag _key_ having the specified value. If
  _value_ is not given, matches streams that contain the given tag with any
  value.
* **u**  
  .IX Item "u"
  Matches streams with usable configuration, the codec must be defined and the
  essential information such as video dimension or audio sample rate must be present.
  .Sp
  Note that in **ffmpeg**, matching by metadata will only work properly for
  input files.

<a name="generic-options"></a>

### Generic options

.IX Subsection "Generic options"
These options are shared amongst the ff* tools.

* **-L**  
  .IX Item "-L"
  Show license.
* **-h, -?, -help, --help [**_arg_**]**  
  .IX Item "-h, -?, -help, --help [arg]"
  Show help. An optional parameter may be specified to print help about a specific
  item. If no argument is specified, only basic (non advanced) tool
  options are shown.
  .Sp
  Possible values of _arg_ are:
    * **long**  
      .IX Item "long"
      Print advanced tool options in addition to the basic tool options.
    * **full**  
      .IX Item "full"
      Print complete list of options, including shared and private options
      for encoders, decoders, demuxers, muxers, filters, etc.
    * **decoder=**_decoder\_name_  
      .IX Item "decoder=decoder_name"
      Print detailed information about the decoder named _decoder\_name_. Use the
      **-decoders** option to get a list of all decoders.
    * **encoder=**_encoder\_name_  
      .IX Item "encoder=encoder_name"
      Print detailed information about the encoder named _encoder\_name_. Use the
      **-encoders** option to get a list of all encoders.
    * **demuxer=**_demuxer\_name_  
      .IX Item "demuxer=demuxer_name"
      Print detailed information about the demuxer named _demuxer\_name_. Use the
      **-formats** option to get a list of all demuxers and muxers.
    * **muxer=**_muxer\_name_  
      .IX Item "muxer=muxer_name"
      Print detailed information about the muxer named _muxer\_name_. Use the
      **-formats** option to get a list of all muxers and demuxers.
    * **filter=**_filter\_name_  
      .IX Item "filter=filter_name"
      Print detailed information about the filter name _filter\_name_. Use the
      **-filters** option to get a list of all filters.
* **-version**  
  .IX Item "-version"
  Show version.
* **-formats**  
  .IX Item "-formats"
  Show available formats (including devices).
* **-demuxers**  
  .IX Item "-demuxers"
  Show available demuxers.
* **-muxers**  
  .IX Item "-muxers"
  Show available muxers.
* **-devices**  
  .IX Item "-devices"
  Show available devices.
* **-codecs**  
  .IX Item "-codecs"
  Show all codecs known to libavcodec.
  .Sp
  Note that the term 'codec' is used throughout this documentation as a shortcut
  for what is more correctly called a media bitstream format.
* **-decoders**  
  .IX Item "-decoders"
  Show available decoders.
* **-encoders**  
  .IX Item "-encoders"
  Show all available encoders.
* **-bsfs**  
  .IX Item "-bsfs"
  Show available bitstream filters.
* **-protocols**  
  .IX Item "-protocols"
  Show available protocols.
* **-filters**  
  .IX Item "-filters"
  Show available libavfilter filters.
* **-pix\_fmts**  
  .IX Item "-pix_fmts"
  Show available pixel formats.
* **-sample\_fmts**  
  .IX Item "-sample_fmts"
  Show available sample formats.
* **-layouts**  
  .IX Item "-layouts"
  Show channel names and standard channel layouts.
* **-colors**  
  .IX Item "-colors"
  Show recognized color names.
* **-sources** _device_**[,**_opt1_**=**_val1_**[,**_opt2_**=**_val2_**]...]**  
  .IX Item "-sources device[,opt1=val1[,opt2=val2]...]"
  Show autodetected sources of the input device.
  Some devices may provide system-dependent source names that cannot be autodetected.
  The returned list cannot be assumed to be always complete.
  .Sp
  .Vb 1
          ffmpeg -sources pulse,server=192.168.0.4
  .Ve
* **-sinks** _device_**[,**_opt1_**=**_val1_**[,**_opt2_**=**_val2_**]...]**  
  .IX Item "-sinks device[,opt1=val1[,opt2=val2]...]"
  Show autodetected sinks of the output device.
  Some devices may provide system-dependent sink names that cannot be autodetected.
  The returned list cannot be assumed to be always complete.
  .Sp
  .Vb 1
          ffmpeg -sinks pulse,server=192.168.0.4
  .Ve
* **-loglevel [**_flags_**+]**_loglevel_ **| -v [**_flags_**+]**_loglevel_  
  .IX Item "-loglevel [flags+]loglevel | -v [flags+]loglevel"
  Set logging level and flags used by the library.
  .Sp
  The optional _flags_ prefix can consist of the following values:
    * **repeat**  
      .IX Item "repeat"
      Indicates that repeated log output should not be compressed to the first line
      and the Last message repeated n times\*(R" line will be omitted.
    * **level**  
      .IX Item "level"
      Indicates that log output should add a \f(CW`[level]\*(C' prefix to each message
      line. This can be used as an alternative to log coloring, e.g. when dumping the
      log to file.
      .Sp
      Flags can also be used alone by adding a '+'/'-' prefix to set/reset a single
      flag without affecting other _flags_ or changing _loglevel_. When
      setting both _flags_ and _loglevel_, a '+' separator is expected
      between the last _flags_ value and before _loglevel_.
      .Sp
      _loglevel_ is a string or a number containing one of the following values:
    * **quiet, -8**  
      .IX Item "quiet, -8"
      Show nothing at all; be silent.
    * **panic, 0**  
      .IX Item "panic, 0"
      Only show fatal errors which could lead the process to crash, such as
      an assertion failure. This is not currently used for anything.
    * **fatal, 8**  
      .IX Item "fatal, 8"
      Only show fatal errors. These are errors after which the process absolutely
      cannot continue.
    * **error, 16**  
      .IX Item "error, 16"
      Show all errors, including ones which can be recovered from.
    * **warning, 24**  
      .IX Item "warning, 24"
      Show all warnings and errors. Any message related to possibly
      incorrect or unexpected events will be shown.
    * **info, 32**  
      .IX Item "info, 32"
      Show informative messages during processing. This is in addition to
      warnings and errors. This is the default value.
    * **verbose, 40**  
      .IX Item "verbose, 40"
      Same as \f(CW`info\*(C', except more verbose.
    * **debug, 48**  
      .IX Item "debug, 48"
      Show everything, including debugging information.
    * **trace, 56**  
      .IX Item "trace, 56"
      .Sp
      For example to enable repeated log output, add the \f(CW`level\*(C' prefix, and set
      _loglevel_ to \f(CW`verbose\*(C':
      .Sp
      .Vb 1
              ffmpeg -loglevel repeat+level+verbose -i input output
      .Ve
      .Sp
      Another example that enables repeated log output without affecting current
      state of \f(CW`level\*(C' prefix flag or _loglevel_:
      .Sp
      .Vb 1
              ffmpeg [...] -loglevel +repeat
      .Ve
      .Sp
      By default the program logs to stderr. If coloring is supported by the
      terminal, colors are used to mark errors and warnings. Log coloring
      can be disabled setting the environment variable
      **\s-1AV\_LOG\_FORCE\_NOCOLOR\s0** or **\s-1NO\_COLOR\s0**, or can be forced setting
      the environment variable **\s-1AV\_LOG\_FORCE\_COLOR\s0**.
      The use of the environment variable **\s-1NO\_COLOR\s0** is deprecated and
      will be dropped in a future FFmpeg version.
* **-report**  
  .IX Item "-report"
  Dump full command line and console output to a file named
  \f(CW`\f(CIprogram\f(CW-\f(CIYYYYMMDD\f(CW-\f(CIHHMMSS\f(CW.log\*(C' in the current
  directory.
  This file can be useful for bug reports.
  It also implies \f(CW`-loglevel verbose\*(C'.
  .Sp
  Setting the environment variable **\s-1FFREPORT\s0** to any value has the
  same effect. If the value is a ':'-separated key=value sequence, these
  options will affect the report; option values must be escaped if they
  contain special characters or the options delimiter ':' (see the
  \`\`Quoting and escaping'' section in the ffmpeg-utils manual).
  .Sp
  The following options are recognized:
    * **file**  
      .IX Item "file"
      set the file name to use for the report; \f(CW%p is expanded to the name
      of the program, \f(CW%t is expanded to a timestamp, \f(CW`%%\*(C' is expanded
      to a plain \f(CW`%\*(C'
    * **level**  
      .IX Item "level"
      set the log verbosity level using a numerical value (see \f(CW`-loglevel\*(C').
      .Sp
      For example, to output a report to a file named _ffreport.log_
      using a log level of \f(CW32 (alias for log level \f(CW`info\*(C'):
      .Sp
      .Vb 1
              FFREPORT=file=ffreport.log:level=32 ffmpeg -i input output
      .Ve
      .Sp
      Errors in parsing the environment variable are not fatal, and will not
      appear in the report.
* **-hide\_banner**  
  .IX Item "-hide_banner"
  Suppress printing banner.
  .Sp
  All FFmpeg tools will normally show a copyright notice, build options
  and library versions. This option can be used to suppress printing
  this information.
* **-cpuflags flags (**_global_**)**  
  .IX Item "-cpuflags flags (global)"
  Allows setting and clearing cpu flags. This option is intended
  for testing. Do not use it unless you know what you're doing.
  .Sp
  .Vb 3
          ffmpeg -cpuflags -sse+mmx ...
          ffmpeg -cpuflags mmx ...
          ffmpeg -cpuflags 0 ...
  .Ve
  .Sp
  Possible flags for this option are:
    * **x86**  
      .IX Item "x86"
        * **mmx**  
          .IX Item "mmx"
        * **mmxext**  
          .IX Item "mmxext"
        * **sse**  
          .IX Item "sse"
        * **sse2**  
          .IX Item "sse2"
        * **sse2slow**  
          .IX Item "sse2slow"
        * **sse3**  
          .IX Item "sse3"
        * **sse3slow**  
          .IX Item "sse3slow"
        * **ssse3**  
          .IX Item "ssse3"
        * **atom**  
          .IX Item "atom"
        * **sse4.1**  
          .IX Item "sse4.1"
        * **sse4.2**  
          .IX Item "sse4.2"
        * **avx**  
          .IX Item "avx"
        * **avx2**  
          .IX Item "avx2"
        * **xop**  
          .IX Item "xop"
        * **fma3**  
          .IX Item "fma3"
        * **fma4**  
          .IX Item "fma4"
        * **3dnow**  
          .IX Item "3dnow"
        * **3dnowext**  
          .IX Item "3dnowext"
        * **bmi1**  
          .IX Item "bmi1"
        * **bmi2**  
          .IX Item "bmi2"
        * **cmov**  
          .IX Item "cmov"
    * **\s-1ARM\s0**  
      .IX Item "ARM"
        * **armv5te**  
          .IX Item "armv5te"
        * **armv6**  
          .IX Item "armv6"
        * **armv6t2**  
          .IX Item "armv6t2"
        * **vfp**  
          .IX Item "vfp"
        * **vfpv3**  
          .IX Item "vfpv3"
        * **neon**  
          .IX Item "neon"
        * **setend**  
          .IX Item "setend"
    * **AArch64**  
      .IX Item "AArch64"
        * **armv8**  
          .IX Item "armv8"
        * **vfp**  
          .IX Item "vfp"
        * **neon**  
          .IX Item "neon"
    * **PowerPC**  
      .IX Item "PowerPC"
        * **altivec**  
          .IX Item "altivec"
    * **Specific Processors**  
      .IX Item "Specific Processors"
        * **pentium2**  
          .IX Item "pentium2"
        * **pentium3**  
          .IX Item "pentium3"
        * **pentium4**  
          .IX Item "pentium4"
        * **k6**  
          .IX Item "k6"
        * **k62**  
          .IX Item "k62"
        * **athlon**  
          .IX Item "athlon"
        * **athlonxp**  
          .IX Item "athlonxp"
        * **k8**  
          .IX Item "k8"

<a name="avoptions"></a>

### AVOptions

.IX Subsection "AVOptions"
These options are provided directly by the libavformat, libavdevice and
libavcodec libraries. To see the list of available AVOptions, use the
**-help** option. They are separated into two categories:

* **generic**  
  .IX Item "generic"
  These options can be set for any container, codec or device. Generic options
  are listed under AVFormatContext options for containers/devices and under
  AVCodecContext options for codecs.
* **private**  
  .IX Item "private"
  These options are specific to the given container, device or codec. Private
  options are listed under their corresponding containers/devices/codecs.

For example to write an ID3v2.3 header instead of a default ID3v2.4 to
an \s-1MP3\s0 file, use the **id3v2\_version** private option of the \s-1MP3\s0
muxer:

.Vb 1
        ffmpeg -i input.flac -id3v2_version 3 out.mp3
.Ve

All codec AVOptions are per-stream, and thus a stream specifier
should be attached to them.

Note: the **-nooption** syntax cannot be used for boolean
AVOptions, use **-option 0**/**-option 1**.

Note: the old undocumented way of specifying per-stream AVOptions by
prepending v/a/s to the options name is now obsolete and will be
removed soon.

<a name="main-options"></a>

### Main options

.IX Subsection "Main options"

* **-x** _width_  
  .IX Item "-x width"
  Force displayed width.
* **-y** _height_  
  .IX Item "-y height"
  Force displayed height.
* **-s** _size_  
  .IX Item "-s size"
  Set frame size (WxH or abbreviation), needed for videos which do
  not contain a header with the frame size like raw \s-1YUV.\s0  This option
  has been deprecated in favor of private options, try -video_size.
* **-fs**  
  .IX Item "-fs"
  Start in fullscreen mode.
* **-an**  
  .IX Item "-an"
  Disable audio.
* **-vn**  
  .IX Item "-vn"
  Disable video.
* **-sn**  
  .IX Item "-sn"
  Disable subtitles.
* **-ss** _pos_  
  .IX Item "-ss pos"
  Seek to _pos_. Note that in most formats it is not possible to seek
  exactly, so **ffplay** will seek to the nearest seek point to
  _pos_.
  .Sp
  _pos_ must be a time duration specification,
  see **the Time duration section in the ffmpeg-utils\|(1) manual**.
* **-t** _duration_  
  .IX Item "-t duration"
  Play _duration_ seconds of audio/video.
  .Sp
  _duration_ must be a time duration specification,
  see **the Time duration section in the ffmpeg-utils\|(1) manual**.
* **-bytes**  
  .IX Item "-bytes"
  Seek by bytes.
* **-seek\_interval**  
  .IX Item "-seek_interval"
  Set custom interval, in seconds, for seeking using left/right keys. Default is 10 seconds.
* **-nodisp**  
  .IX Item "-nodisp"
  Disable graphical display.
* **-noborder**  
  .IX Item "-noborder"
  Borderless window.
* **-volume**  
  .IX Item "-volume"
  Set the startup volume. 0 means silence, 100 means no volume reduction or
  amplification. Negative values are treated as 0, values above 100 are treated
  as 100.
* **-f** _fmt_  
  .IX Item "-f fmt"
  Force format.
* **-window\_title** _title_  
  .IX Item "-window_title title"
  Set window title (default is the input filename).
* **-left** _title_  
  .IX Item "-left title"
  Set the x position for the left of the window (default is a centered window).
* **-top** _title_  
  .IX Item "-top title"
  Set the y position for the top of the window (default is a centered window).
* **-loop** _number_  
  .IX Item "-loop number"
  Loops movie playback &lt;number&gt; times. 0 means forever.
* **-showmode** _mode_  
  .IX Item "-showmode mode"
  Set the show mode to use.
  Available values for _mode_ are:
    * **0, video**  
      .IX Item "0, video"
      show video
    * **1, waves**  
      .IX Item "1, waves"
      show audio waves
    * **2, rdft**  
      .IX Item "2, rdft"
      show audio frequency band using \s-1RDFT\s0 ((Inverse) Real Discrete Fourier Transform)
      .Sp
      Default value is video\*(R", if video is not present or cannot be played
      rdft\*(R" is automatically selected.
      .Sp
      You can interactively cycle through the available show modes by
      pressing the key **w**.
* **-vf** _filtergraph_  
  .IX Item "-vf filtergraph"
  Create the filtergraph specified by _filtergraph_ and use it to
  filter the video stream.
  .Sp
  _filtergraph_ is a description of the filtergraph to apply to
  the stream, and must have a single video input and a single video
  output. In the filtergraph, the input is associated to the label
  \f(CW`in\*(C', and the output to the label \f(CW\*(C\`out\*(C'. See the
  ffmpeg-filters manual for more information about the filtergraph
  syntax.
  .Sp
  You can specify this parameter multiple times and cycle through the specified
  filtergraphs along with the show modes by pressing the key **w**.
* **-af** _filtergraph_  
  .IX Item "-af filtergraph"
  _filtergraph_ is a description of the filtergraph to apply to
  the input audio.
  Use the option -filters\*(R" to show all the available filters (including
  sources and sinks).
* **-i** _input\_url_  
  .IX Item "-i input_url"
  Read _input\_url_.

<a name="advanced-options"></a>

### Advanced options

.IX Subsection "Advanced options"

* **-pix\_fmt** _format_  
  .IX Item "-pix_fmt format"
  Set pixel format.
  This option has been deprecated in favor of private options, try -pixel_format.
* **-stats**  
  .IX Item "-stats"
  Print several playback statistics, in particular show the stream
  duration, the codec parameters, the current position in the stream and
  the audio/video synchronisation drift. It is on by default, to
  explicitly disable it you need to specify \f(CW`-nostats\*(C'.
* **-fast**  
  .IX Item "-fast"
  Non-spec-compliant optimizations.
* **-genpts**  
  .IX Item "-genpts"
  Generate pts.
* **-sync** _type_  
  .IX Item "-sync type"
  Set the master clock to audio (\f(CW`type=audio\*(C'), video
  (\f(CW`type=video\*(C') or external (\f(CW\*(C\`type=ext\*(C'). Default is audio. The
  master clock is used to control audio-video synchronization. Most media
  players use audio as master clock, but in some cases (streaming or high
  quality broadcast) it is necessary to change that. This option is mainly
  used for debugging purposes.
* **-ast** _audio\_stream\_specifier_  
  .IX Item "-ast audio_stream_specifier"
  Select the desired audio stream using the given stream specifier. The stream
  specifiers are described in the **Stream specifiers** chapter. If this option
  is not specified, the best\*(R" audio stream is selected in the program of the
  already selected video stream.
* **-vst** _video\_stream\_specifier_  
  .IX Item "-vst video_stream_specifier"
  Select the desired video stream using the given stream specifier. The stream
  specifiers are described in the **Stream specifiers** chapter. If this option
  is not specified, the best\*(R" video stream is selected.
* **-sst** _subtitle\_stream\_specifier_  
  .IX Item "-sst subtitle_stream_specifier"
  Select the desired subtitle stream using the given stream specifier. The stream
  specifiers are described in the **Stream specifiers** chapter. If this option
  is not specified, the best\*(R" subtitle stream is selected in the program of the
  already selected video or audio stream.
* **-autoexit**  
  .IX Item "-autoexit"
  Exit when video is done playing.
* **-exitonkeydown**  
  .IX Item "-exitonkeydown"
  Exit if any key is pressed.
* **-exitonmousedown**  
  .IX Item "-exitonmousedown"
  Exit if any mouse button is pressed.
* **-codec:**_media\_specifier_** **_codec\_name_  
  .IX Item "-codec:media_specifier codec_name"
  Force a specific decoder implementation for the stream identified by
  _media\_specifier_, which can assume the values \f(CW`a\*(C' (audio),
  \f(CW`v\*(C' (video), and \f(CW\*(C\`s\*(C' subtitle.
* **-acodec** _codec\_name_  
  .IX Item "-acodec codec_name"
  Force a specific audio decoder.
* **-vcodec** _codec\_name_  
  .IX Item "-vcodec codec_name"
  Force a specific video decoder.
* **-scodec** _codec\_name_  
  .IX Item "-scodec codec_name"
  Force a specific subtitle decoder.
* **-autorotate**  
  .IX Item "-autorotate"
  Automatically rotate the video according to file metadata. Enabled by
  default, use **-noautorotate** to disable it.
* **-framedrop**  
  .IX Item "-framedrop"
  Drop video frames if video is out of sync. Enabled by default if the master
  clock is not set to video. Use this option to enable frame dropping for all
  master clock sources, use **-noframedrop** to disable it.
* **-infbuf**  
  .IX Item "-infbuf"
  Do not limit the input buffer size, read as much data as possible from the
  input as soon as possible. Enabled by default for realtime streams, where data
  may be dropped if not read in time. Use this option to enable infinite buffers
  for all inputs, use **-noinfbuf** to disable it.

<a name="while-playing"></a>

### While playing

.IX Subsection "While playing"

* **q, \s-1ESC\s0**  
  .IX Item "q, ESC"
  Quit.
* **f**  
  .IX Item "f"
  Toggle full screen.
* **p, \s-1SPC\s0**  
  .IX Item "p, SPC"
  Pause.
* **m**  
  .IX Item "m"
  Toggle mute.
* **9, 0**  
  .IX Item "9, 0"
  Decrease and increase volume respectively.
* **/, ***  
  .IX Item "/, *"
  Decrease and increase volume respectively.
* **a**  
  .IX Item "a"
  Cycle audio channel in the current program.
* **v**  
  .IX Item "v"
  Cycle video channel.
* **t**  
  .IX Item "t"
  Cycle subtitle channel in the current program.
* **c**  
  .IX Item "c"
  Cycle program.
* **w**  
  .IX Item "w"
  Cycle video filters or show modes.
* **s**  
  .IX Item "s"
  Step to the next frame.
  .Sp
  Pause if the stream is not already paused, step to the next video
  frame, and pause.
* **left/right**  
  .IX Item "left/right"
  Seek backward/forward 10 seconds.
* **down/up**  
  .IX Item "down/up"
  Seek backward/forward 1 minute.
* **page down/page up**  
  .IX Item "page down/page up"
  Seek to the previous/next chapter.
  or if there are no chapters
  Seek backward/forward 10 minutes.
* **right mouse click**  
  .IX Item "right mouse click"
  Seek to percentage in file corresponding to fraction of width.
* **left mouse double-click**  
  .IX Item "left mouse double-click"
  Toggle full screen.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ffplay-all**\|(1),
**ffmpeg**\|(1), **ffprobe**\|(1),
**ffmpeg-utils**\|(1), **ffmpeg-scaler**\|(1), **ffmpeg-resampler**\|(1),
**ffmpeg-codecs**\|(1), **ffmpeg-bitstream-filters**\|(1), **ffmpeg-formats**\|(1),
**ffmpeg-devices**\|(1), **ffmpeg-protocols**\|(1), **ffmpeg-filters**\|(1)

<a name="authors"></a>

# Authors

.IX Header "AUTHORS"
The FFmpeg developers.

For details about the authorship, see the Git history of the project
(git://source.ffmpeg.org/ffmpeg), e.g. by typing the command
**git log** in the FFmpeg source directory, or browsing the
online repository at &lt;**http://source.ffmpeg.org**&gt;.

Maintainers for the specific components are listed in the file
_\s-1MAINTAINERS\s0_ in the source code tree.
