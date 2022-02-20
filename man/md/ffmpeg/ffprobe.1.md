# ffprobe(1)

 ,  

.if n .ad l
.nh

<a name="name"></a>

# Name

ffprobe - ffprobe media prober

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" ffprobe [options] [input_url]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
ffprobe gathers information from multimedia streams and prints it in
human- and machine-readable fashion.

For example it can be used to check the format of the container used
by a multimedia stream and the format and type of each media stream
contained in it.

If a url is specified in input, ffprobe will try to open and
probe the url content. If the url cannot be opened or recognized as
a multimedia file, a positive exit code is returned.

ffprobe may be employed both as a standalone application or in
combination with a textual filter, which may perform more
sophisticated processing, e.g. statistical processing or plotting.

Options are used to list some of the formats supported by ffprobe or
for specifying which information to display, and for setting how
ffprobe will show it.

ffprobe output is designed to be easily parsable by a textual filter,
and consists of one or more sections of a form defined by the selected
writer, which is specified by the **print\_format** option.

Sections may contain other nested sections, and are identified by a
name (which may be shared by other sections), and an unique
name. See the output of **sections**.

Metadata tags stored in the container or in the streams are recognized
and printed in the corresponding \s-1FORMAT\*(R", \*(L"STREAM\*(R"\s0 or \*(L"\s-1PROGRAM_STREAM\*(R"\s0
section.

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

* **-f** _format_  
  .IX Item "-f format"
  Force format to use.
* **-unit**  
  .IX Item "-unit"
  Show the unit of the displayed values.
* **-prefix**  
  .IX Item "-prefix"
  Use \s-1SI\s0 prefixes for the displayed values.
  Unless the -byte_binary_prefix\*(R" option is used all the prefixes
  are decimal.
* **-byte\_binary\_prefix**  
  .IX Item "-byte_binary_prefix"
  Force the use of binary prefixes for byte values.
* **-sexagesimal**  
  .IX Item "-sexagesimal"
  Use sexagesimal format \s-1HH:MM:SS.MICROSECONDS\s0 for time values.
* **-pretty**  
  .IX Item "-pretty"
  Prettify the format of the displayed values, it corresponds to the
  options -unit -prefix -byte_binary_prefix -sexagesimal\*(R".
* **-of, -print\_format** _writer\_name_**[=**_writer\_options_**]**  
  .IX Item "-of, -print_format writer_name[=writer_options]"
  Set the output printing format.
  .Sp
  _writer\_name_ specifies the name of the writer, and
  _writer\_options_ specifies the options to be passed to the writer.
  .Sp
  For example for printing the output in \s-1JSON\s0 format, specify:
  .Sp
  .Vb 1
          -print_format json
  .Ve
  .Sp
  For more details on the available output printing formats, see the
  Writers section below.
* **-sections**  
  .IX Item "-sections"
  Print sections structure and section information, and exit. The output
  is not meant to be parsed by a machine.
* **-select\_streams** _stream\_specifier_  
  .IX Item "-select_streams stream_specifier"
  Select only the streams specified by _stream\_specifier_. This
  option affects only the options related to streams
  (e.g. \f(CW`show\_streams\*(C', \f(CW\*(C\`show\_packets\*(C', etc.).
  .Sp
  For example to show only audio streams, you can use the command:
  .Sp
  .Vb 1
          ffprobe -show_streams -select_streams a INPUT
  .Ve
  .Sp
  To show only video packets belonging to the video stream with index 1:
  .Sp
  .Vb 1
          ffprobe -show_packets -select_streams v:1 INPUT
  .Ve
* **-show\_data**  
  .IX Item "-show_data"
  Show payload data, as a hexadecimal and \s-1ASCII\s0 dump. Coupled with
  **-show\_packets**, it will dump the packets' data. Coupled with
  **-show\_streams**, it will dump the codec extradata.
  .Sp
  The dump is printed as the data\*(R" field. It may contain newlines.
* **-show\_data\_hash** _algorithm_  
  .IX Item "-show_data_hash algorithm"
  Show a hash of payload data, for packets with **-show\_packets** and for
  codec extradata with **-show\_streams**.
* **-show\_error**  
  .IX Item "-show_error"
  Show information about the error found when trying to probe the input.
  .Sp
  The error information is printed within a section with name \s-1ERROR\*(R".\s0
* **-show\_format**  
  .IX Item "-show_format"
  Show information about the container format of the input multimedia
  stream.
  .Sp
  All the container format information is printed within a section with
  name \s-1FORMAT\*(R".\s0
* **-show\_format\_entry** _name_  
  .IX Item "-show_format_entry name"
  Like **-show\_format**, but only prints the specified entry of the
  container format information, rather than all. This option may be given more
  than once, then all specified entries will be shown.
  .Sp
  This option is deprecated, use \f(CW`show\_entries\*(C' instead.
* **-show\_entries** _section\_entries_  
  .IX Item "-show_entries section_entries"
  Set list of entries to show.
  .Sp
  Entries are specified according to the following
  syntax. _section\_entries_ contains a list of section entries
  separated by \f(CW`:\*(C'. Each section entry is composed by a section
  name (or unique name), optionally followed by a list of entries local
  to that section, separated by \f(CW`,\*(C'.
  .Sp
  If section name is specified but is followed by no \f(CW`=\*(C', all
  entries are printed to output, together with all the contained
  sections. Otherwise only the entries specified in the local section
  entries list are printed. In particular, if \f(CW`=\*(C' is specified but
  the list of local entries is empty, then no entries will be shown for
  that section.
  .Sp
  Note that the order of specification of the local section entries is
  not honored in the output, and the usual display order will be
  retained.
  .Sp
  The formal syntax is given by:
  .Sp
  .Vb 3
          &lt;LOCAL_SECTION_ENTRIES&gt; ::= &lt;SECTION_ENTRY_NAME&gt;[,&lt;LOCAL_SECTION_ENTRIES&gt;]
          &lt;SECTION_ENTRY&gt;         ::= &lt;SECTION_NAME&gt;[=[&lt;LOCAL_SECTION_ENTRIES&gt;]]
          &lt;SECTION_ENTRIES&gt;       ::= &lt;SECTION_ENTRY&gt;[:&lt;SECTION_ENTRIES&gt;]
  .Ve
  .Sp
  For example, to show only the index and type of each stream, and the \s-1PTS\s0
  time, duration time, and stream index of the packets, you can specify
  the argument:
  .Sp
  .Vb 1
          packet=pts_time,duration_time,stream_index : stream=index,codec_type
  .Ve
  .Sp
  To show all the entries in the section format\*(R", but only the codec
  type in the section stream\*(R", specify the argument:
  .Sp
  .Vb 1
          format : stream=codec_type
  .Ve
  .Sp
  To show all the tags in the stream and format sections:
  .Sp
  .Vb 1
          stream_tags : format_tags
  .Ve
  .Sp
  To show only the \f(CW`title\*(C' tag (if available) in the stream
  sections:
  .Sp
  .Vb 1
          stream_tags=title
  .Ve
* **-show\_packets**  
  .IX Item "-show_packets"
  Show information about each packet contained in the input multimedia
  stream.
  .Sp
  The information for each single packet is printed within a dedicated
  section with name \s-1PACKET\*(R".\s0
* **-show\_frames**  
  .IX Item "-show_frames"
  Show information about each frame and subtitle contained in the input
  multimedia stream.
  .Sp
  The information for each single frame is printed within a dedicated
  section with name \s-1FRAME\*(R"\s0 or \*(L"\s-1SUBTITLE\*(R".\s0
* **-show\_log** _loglevel_  
  .IX Item "-show_log loglevel"
  Show logging information from the decoder about each frame according to
  the value set in _loglevel_, (see \f(CW`-loglevel\*(C'). This option requires \f(CW\*(C\`-show\_frames\*(C'.
  .Sp
  The information for each log message is printed within a dedicated
  section with name \s-1LOG\*(R".\s0
* **-show\_streams**  
  .IX Item "-show_streams"
  Show information about each media stream contained in the input
  multimedia stream.
  .Sp
  Each media stream information is printed within a dedicated section
  with name \s-1STREAM\*(R".\s0
* **-show\_programs**  
  .IX Item "-show_programs"
  Show information about programs and their streams contained in the input
  multimedia stream.
  .Sp
  Each media stream information is printed within a dedicated section
  with name \s-1PROGRAM_STREAM\*(R".\s0
* **-show\_chapters**  
  .IX Item "-show_chapters"
  Show information about chapters stored in the format.
  .Sp
  Each chapter is printed within a dedicated section with name \s-1CHAPTER\*(R".\s0
* **-count\_frames**  
  .IX Item "-count_frames"
  Count the number of frames per stream and report it in the
  corresponding stream section.
* **-count\_packets**  
  .IX Item "-count_packets"
  Count the number of packets per stream and report it in the
  corresponding stream section.
* **-read\_intervals** _read\_intervals_  
  .IX Item "-read_intervals read_intervals"
  Read only the specified intervals. _read\_intervals_ must be a
  sequence of interval specifications separated by ,\*(R".
  **ffprobe** will seek to the interval starting point, and will
  continue reading from that.
  .Sp
  Each interval is specified by two optional parts, separated by %\*(R".
  .Sp
  The first part specifies the interval start position. It is
  interpreted as an absolute position, or as a relative offset from the
  current position if it is preceded by the +\*(R" character. If this first
  part is not specified, no seeking will be performed when reading this
  interval.
  .Sp
  The second part specifies the interval end position. It is interpreted
  as an absolute position, or as a relative offset from the current
  position if it is preceded by the +\*(R" character. If the offset
  specification starts with #\*(R", it is interpreted as the number of
  packets to read (not including the flushing packets) from the interval
  start. If no second part is specified, the program will read until the
  end of the input.
  .Sp
  Note that seeking is not accurate, thus the actual interval start
  point may be different from the specified position. Also, when an
  interval duration is specified, the absolute end time will be computed
  by adding the duration to the interval start point found by seeking
  the file, rather than to the specified start value.
  .Sp
  The formal syntax is given by:
  .Sp
  .Vb 2
          &lt;INTERVAL&gt;  ::= [&lt;START&gt;|+&lt;START_OFFSET&gt;][%[&lt;END&gt;|+&lt;END_OFFSET&gt;]]
          &lt;INTERVALS&gt; ::= &lt;INTERVAL&gt;[,&lt;INTERVALS&gt;]
  .Ve
  .Sp
  A few examples follow.
    * ·  
      Seek to time 10, read packets until 20 seconds after the found seek
      point, then seek to position \f(CW`01:30\*(C' (1 minute and thirty
      seconds) and read packets until position \f(CW`01:45\*(C'.
      .Sp
      .Vb 1
              10%+20,01:30%01:45
      .Ve
    * ·  
      Read only 42 packets after seeking to position \f(CW`01:23\*(C':
      .Sp
      .Vb 1
              01:23%+#42
      .Ve
    * ·  
      Read only the first 20 seconds from the start:
      .Sp
      .Vb 1
              %+20
      .Ve
    * ·  
      Read from the start until position \f(CW`02:30\*(C':
      .Sp
      .Vb 1
              %02:30
      .Ve
* **-show_private_data, -private**  
  .IX Item "-show_private_data, -private"
  Show private data, that is data depending on the format of the
  particular shown element.
  This option is enabled by default, but you may need to disable it
  for specific uses, for example when creating XSD-compliant \s-1XML\s0 output.
* **-show\_program\_version**  
  .IX Item "-show_program_version"
  Show information related to program version.
  .Sp
  Version information is printed within a section with name
  \s-1PROGRAM_VERSION\*(R".\s0
* **-show\_library\_versions**  
  .IX Item "-show_library_versions"
  Show information related to library versions.
  .Sp
  Version information for each library is printed within a section with
  name \s-1LIBRARY_VERSION\*(R".\s0
* **-show\_versions**  
  .IX Item "-show_versions"
  Show information related to program and library versions. This is the
  equivalent of setting both **-show\_program\_version** and
  **-show\_library\_versions** options.
* **-show\_pixel\_formats**  
  .IX Item "-show_pixel_formats"
  Show information about all pixel formats supported by FFmpeg.
  .Sp
  Pixel format information for each format is printed within a section
  with name \s-1PIXEL_FORMAT\*(R".\s0
* **-bitexact**  
  .IX Item "-bitexact"
  Force bitexact output, useful to produce output which is not dependent
  on the specific build.
* **-i** _input\_url_  
  .IX Item "-i input_url"
  Read _input\_url_.

<a name="writers"></a>

# Writers

.IX Header "WRITERS"
A writer defines the output format adopted by **ffprobe**, and will be
used for printing all the parts of the output.

A writer may accept one or more arguments, which specify the options
to adopt. The options are specified as a list of _key_=_value_
pairs, separated by :\*(R".

All writers support the following options:

* **string_validation, sv**  
  .IX Item "string_validation, sv"
  Set string validation mode.
  .Sp
  The following values are accepted.
    * **fail**  
      .IX Item "fail"
      The writer will fail immediately in case an invalid string (\s-1UTF-8\s0)
      sequence or code point is found in the input. This is especially
      useful to validate input metadata.
    * **ignore**  
      .IX Item "ignore"
      Any validation error will be ignored. This will result in possibly
      broken output, especially with the json or xml writer.
    * **replace**  
      .IX Item "replace"
      The writer will substitute invalid \s-1UTF-8\s0 sequences or code points with
      the string specified with the **string\_validation\_replacement**.
      .Sp
      Default value is **replace**.
* **string_validation_replacement, svr**  
  .IX Item "string_validation_replacement, svr"
  Set replacement string to use in case **string\_validation** is
  set to **replace**.
  .Sp
  In case the option is not specified, the writer will assume the empty
  string, that is it will remove the invalid sequences from the input
  strings.

A description of the currently available writers follows.

<a name="default"></a>

### default

.IX Subsection "default"
Default format.

Print each section in the form:

.Vb 5
        [SECTION]
        key1=val1
        ...
        keyN=valN
        [/SECTION]
.Ve

Metadata tags are printed as a line in the corresponding \s-1FORMAT, STREAM\s0 or
\s-1PROGRAM_STREAM\s0 section, and are prefixed by the string \s-1TAG:\*(R".\s0

A description of the accepted options follows.

* **nokey, nk**  
  .IX Item "nokey, nk"
  If set to 1 specify not to print the key of each field. Default value
  is 0.
* **noprint_wrappers, nw**  
  .IX Item "noprint_wrappers, nw"
  If set to 1 specify not to print the section header and footer.
  Default value is 0.

<a name="compact-csv"></a>

### compact, csv

.IX Subsection "compact, csv"
Compact and \s-1CSV\s0 format.

The \f(CW`csv\*(C' writer is equivalent to \f(CW\*(C\`compact\*(C', but supports
different defaults.

Each section is printed on a single line.
If no option is specifid, the output has the form:

.Vb 1
        section|key1=val1| ... |keyN=valN
.Ve

Metadata tags are printed in the corresponding format\*(R" or \*(L"stream\*(R"
section. A metadata tag key, if printed, is prefixed by the string
tag:\*(R".

The description of the accepted options follows.

* **item_sep, s**  
  .IX Item "item_sep, s"
  Specify the character to use for separating fields in the output line.
  It must be a single printable character, it is |\*(R" by default (\*(L",\*(R" for
  the \f(CW`csv\*(C' writer).
* **nokey, nk**  
  .IX Item "nokey, nk"
  If set to 1 specify not to print the key of each field. Its default
  value is 0 (1 for the \f(CW`csv\*(C' writer).
* **escape, e**  
  .IX Item "escape, e"
  Set the escape mode to use, default to c\*(R" (\*(L"csv\*(R" for the \f(CW\*(C\`csv\*(C'
  writer).
  .Sp
  It can assume one of the following values:
    * **c**  
      .IX Item "c"
      Perform C-like escaping. Strings containing a newline (**\en**), carriage
      return (**\er**), a tab (**\et**), a form feed (**\ef**), the escaping
      character (**\e**) or the item separator character _\s-1SEP\s0_ are escaped
      using C-like fashioned escaping, so that a newline is converted to the
      sequence **\en**, a carriage return to **\er**, **\e** to **\e\e** and
      the separator _\s-1SEP\s0_ is converted to **\e**_\s-1SEP\s0_.
    * **csv**  
      .IX Item "csv"
      Perform CSV-like escaping, as described in \s-1RFC4180.\s0  Strings
      containing a newline (**\en**), a carriage return (**\er**), a double quote
      (**"**), or _\s-1SEP\s0_ are enclosed in double-quotes.
    * **none**  
      .IX Item "none"
      Perform no escaping.
* **print_section, p**  
  .IX Item "print_section, p"
  Print the section name at the beginning of each line if the value is
  \f(CW1, disable it with value set to \f(CW0. Default value is
  \f(CW1.

<a name="flat"></a>

### flat

.IX Subsection "flat"
Flat format.

A free-form output where each line contains an explicit key=value, such as
streams.stream.3.tags.foo=bar\*(R". The output is shell escaped, so it can be
directly embedded in sh scripts as long as the separator character is an
alphanumeric character or an underscore (see _sep\_char_ option).

The description of the accepted options follows.

* **sep_char, s**  
  .IX Item "sep_char, s"
  Separator character used to separate the chapter, the section name, IDs and
  potential tags in the printed field key.
  .Sp
  Default value is **.**.
* **hierarchical, h**  
  .IX Item "hierarchical, h"
  Specify if the section name specification should be hierarchical. If
  set to 1, and if there is more than one section in the current
  chapter, the section name will be prefixed by the name of the
  chapter. A value of 0 will disable this behavior.
  .Sp
  Default value is 1.

<a name="ini"></a>

### ini

.IX Subsection "ini"
\s-1INI\s0 format output.

Print output in an \s-1INI\s0 based format.

The following conventions are adopted:

* ·  
  all key and values are \s-1UTF-8\s0
* ·  
  **.** is the subgroup separator
* ·  
  newline, **\et**, **\ef**, **\eb** and the following characters are
  escaped
* ·  
  **\e** is the escape character
* ·  
  **#** is the comment indicator
* ·  
  **=** is the key/value separator
* ·  
  **:** is not used but usually parsed as key/value separator

This writer accepts options as a list of _key_=_value_ pairs,
separated by **:**.

The description of the accepted options follows.

* **hierarchical, h**  
  .IX Item "hierarchical, h"
  Specify if the section name specification should be hierarchical. If
  set to 1, and if there is more than one section in the current
  chapter, the section name will be prefixed by the name of the
  chapter. A value of 0 will disable this behavior.
  .Sp
  Default value is 1.

<a name="json"></a>

### json

.IX Subsection "json"
\s-1JSON\s0 based format.

Each section is printed using \s-1JSON\s0 notation.

The description of the accepted options follows.

* **compact, c**  
  .IX Item "compact, c"
  If set to 1 enable compact output, that is each section will be
  printed on a single line. Default value is 0.

For more information about \s-1JSON,\s0 see &lt;**http://www.json.org/**&gt;.

<a name="xml"></a>

### xml

.IX Subsection "xml"
\s-1XML\s0 based format.

The \s-1XML\s0 output is described in the \s-1XML\s0 schema description file
_ffprobe.xsd_ installed in the FFmpeg datadir.

An updated version of the schema can be retrieved at the url
&lt;**http://www.ffmpeg.org/schema/ffprobe.xsd**&gt;, which redirects to the
latest schema committed into the FFmpeg development source code tree.

Note that the output issued will be compliant to the
_ffprobe.xsd_ schema only when no special global output options
(**unit**, **prefix**, **byte\_binary\_prefix**,
**sexagesimal** etc.) are specified.

The description of the accepted options follows.

* **fully_qualified, q**  
  .IX Item "fully_qualified, q"
  If set to 1 specify if the output should be fully qualified. Default
  value is 0.
  This is required for generating an \s-1XML\s0 file which can be validated
  through an \s-1XSD\s0 file.
* **xsd_strict, x**  
  .IX Item "xsd_strict, x"
  If set to 1 perform more checks for ensuring that the output is \s-1XSD\s0
  compliant. Default value is 0.
  This option automatically sets **fully\_qualified** to 1.

For more information about the \s-1XML\s0 format, see
&lt;**http://www.w3.org/XML/**&gt;.

<a name="timecode"></a>

# Timecode

.IX Header "TIMECODE"
**ffprobe** supports Timecode extraction:

* ·  
  \s-1MPEG1/2\s0 timecode is extracted from the \s-1GOP,\s0 and is available in the video
  stream details (**-show\_streams**, see _timecode_).
* ·  
  \s-1MOV\s0 timecode is extracted from tmcd track, so is available in the tmcd
  stream metadata (**-show\_streams**, see _TAG:timecode_).
* ·  
  \s-1DV, GXF\s0 and \s-1AVI\s0 timecodes are available in format metadata
  (**-show\_format**, see _TAG:timecode_).

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ffprobe-all**\|(1),
**ffmpeg**\|(1), **ffplay**\|(1),
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
