# ffmpeg-formats(1)

 ,  

.if n .ad l
.nh

<a name="name"></a>

# Name

ffmpeg-formats - FFmpeg formats

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This document describes the supported formats (muxers and demuxers)
provided by the libavformat library.

<a name="format-options"></a>

# Format Options

.IX Header "FORMAT OPTIONS"
The libavformat library provides some generic global options, which
can be set on all the muxers and demuxers. In addition each muxer or
demuxer may support so-called private options, which are specific for
that component.

Options may be set by specifying -_option_ _value_ in the
FFmpeg tools, or by setting the value explicitly in the
\f(CW`AVFormatContext\*(C' options or using the _libavutil/opt.h_ \s-1API\s0
for programmatic use.

The list of supported options follows:

* **avioflags** _flags_ **(**_input/output_**)**  
  .IX Item "avioflags flags (input/output)"
  Possible values:
    * **direct**  
      .IX Item "direct"
      Reduce buffering.
* **probesize** _integer_ **(**_input_**)**  
  .IX Item "probesize integer (input)"
  Set probing size in bytes, i.e. the size of the data to analyze to get
  stream information. A higher value will enable detecting more
  information in case it is dispersed into the stream, but will increase
  latency. Must be an integer not lesser than 32. It is 5000000 by default.
* **packetsize** _integer_ **(**_output_**)**  
  .IX Item "packetsize integer (output)"
  Set packet size.
* **fflags** _flags_  
  .IX Item "fflags flags"
  Set format flags. Some are implemented for a limited number of formats.
  .Sp
  Possible values for input files:
    * **discardcorrupt**  
      .IX Item "discardcorrupt"
      Discard corrupted packets.
    * **fastseek**  
      .IX Item "fastseek"
      Enable fast, but inaccurate seeks for some formats.
    * **genpts**  
      .IX Item "genpts"
      Generate missing \s-1PTS\s0 if \s-1DTS\s0 is present.
    * **igndts**  
      .IX Item "igndts"
      Ignore \s-1DTS\s0 if \s-1PTS\s0 is set. Inert when nofillin is set.
    * **ignidx**  
      .IX Item "ignidx"
      Ignore index.
    * **keepside (**_deprecated_**,**_inert_**)**  
      .IX Item "keepside (deprecated,inert)"
    * **nobuffer**  
      .IX Item "nobuffer"
      Reduce the latency introduced by buffering during initial input streams analysis.
    * **nofillin**  
      .IX Item "nofillin"
      Do not fill in missing values in packet fields that can be exactly calculated.
    * **noparse**  
      .IX Item "noparse"
      Disable AVParsers, this needs \f(CW`+nofillin\*(C' too.
    * **sortdts**  
      .IX Item "sortdts"
      Try to interleave output packets by \s-1DTS.\s0 At present, available only for AVIs with an index.
      .Sp
      Possible values for output files:
    * **autobsf**  
      .IX Item "autobsf"
      Automatically apply bitstream filters as required by the output format. Enabled by default.
    * **bitexact**  
      .IX Item "bitexact"
      Only write platform-, build- and time-independent data.
      This ensures that file and data checksums are reproducible and match between
      platforms. Its primary use is for regression testing.
    * **flush\_packets**  
      .IX Item "flush_packets"
      Write out packets immediately.
    * **latm (**_deprecated_**,**_inert_**)**  
      .IX Item "latm (deprecated,inert)"
    * **shortest**  
      .IX Item "shortest"
      Stop muxing at the end of the shortest stream.
      It may be needed to increase max_interleave_delta to avoid flushing the longer
      streams before \s-1EOF.\s0
* **seek2any** _integer_ **(**_input_**)**  
  .IX Item "seek2any integer (input)"
  Allow seeking to non-keyframes on demuxer level when supported if set to 1.
  Default is 0.
* **analyzeduration** _integer_ **(**_input_**)**  
  .IX Item "analyzeduration integer (input)"
  Specify how many microseconds are analyzed to probe the input. A
  higher value will enable detecting more accurate information, but will
  increase latency. It defaults to 5,000,000 microseconds = 5 seconds.
* **cryptokey** _hexadecimal string_ **(**_input_**)**  
  .IX Item "cryptokey hexadecimal string (input)"
  Set decryption key.
* **indexmem** _integer_ **(**_input_**)**  
  .IX Item "indexmem integer (input)"
  Set max memory used for timestamp index (per stream).
* **rtbufsize** _integer_ **(**_input_**)**  
  .IX Item "rtbufsize integer (input)"
  Set max memory used for buffering real-time frames.
* **fdebug** _flags_ **(**_input/output_**)**  
  .IX Item "fdebug flags (input/output)"
  Print specific debug info.
  .Sp
  Possible values:
    * **ts**  
      .IX Item "ts"
* **max\_delay** _integer_ **(**_input/output_**)**  
  .IX Item "max_delay integer (input/output)"
  Set maximum muxing or demuxing delay in microseconds.
* **fpsprobesize** _integer_ **(**_input_**)**  
  .IX Item "fpsprobesize integer (input)"
  Set number of frames used to probe fps.
* **audio\_preload** _integer_ **(**_output_**)**  
  .IX Item "audio_preload integer (output)"
  Set microseconds by which audio packets should be interleaved earlier.
* **chunk\_duration** _integer_ **(**_output_**)**  
  .IX Item "chunk_duration integer (output)"
  Set microseconds for each chunk.
* **chunk\_size** _integer_ **(**_output_**)**  
  .IX Item "chunk_size integer (output)"
  Set size in bytes for each chunk.
* **err_detect, f\_err\_detect** _flags_ **(**_input_**)**  
  .IX Item "err_detect, f_err_detect flags (input)"
  Set error detection flags. \f(CW`f\_err\_detect\*(C' is deprecated and
  should be used only via the **ffmpeg** tool.
  .Sp
  Possible values:
    * **crccheck**  
      .IX Item "crccheck"
      Verify embedded CRCs.
    * **bitstream**  
      .IX Item "bitstream"
      Detect bitstream specification deviations.
    * **buffer**  
      .IX Item "buffer"
      Detect improper bitstream length.
    * **explode**  
      .IX Item "explode"
      Abort decoding on minor error detection.
    * **careful**  
      .IX Item "careful"
      Consider things that violate the spec and have not been seen in the
      wild as errors.
    * **compliant**  
      .IX Item "compliant"
      Consider all spec non compliancies as errors.
    * **aggressive**  
      .IX Item "aggressive"
      Consider things that a sane encoder should not do as an error.
* **max\_interleave\_delta** _integer_ **(**_output_**)**  
  .IX Item "max_interleave_delta integer (output)"
  Set maximum buffering duration for interleaving. The duration is
  expressed in microseconds, and defaults to 1000000 (1 second).
  .Sp
  To ensure all the streams are interleaved correctly, libavformat will
  wait until it has at least one packet for each stream before actually
  writing any packets to the output file. When some streams are
  sparse\*(R" (i.e. there are large gaps between successive packets), this
  can result in excessive buffering.
  .Sp
  This field specifies the maximum difference between the timestamps of the
  first and the last packet in the muxing queue, above which libavformat
  will output a packet regardless of whether it has queued a packet for all
  the streams.
  .Sp
  If set to 0, libavformat will continue buffering packets until it has
  a packet for each stream, regardless of the maximum timestamp
  difference between the buffered packets.
* **use\_wallclock\_as\_timestamps** _integer_ **(**_input_**)**  
  .IX Item "use_wallclock_as_timestamps integer (input)"
  Use wallclock as timestamps if set to 1. Default is 0.
* **avoid\_negative\_ts** _integer_ **(**_output_**)**  
  .IX Item "avoid_negative_ts integer (output)"
  Possible values:
    * **make\_non\_negative**  
      .IX Item "make_non_negative"
      Shift timestamps to make them non-negative.
      Also note that this affects only leading negative timestamps, and not
      non-monotonic negative timestamps.
    * **make\_zero**  
      .IX Item "make_zero"
      Shift timestamps so that the first timestamp is 0.
    * **auto (default)**  
      .IX Item "auto (default)"
      Enables shifting when required by the target format.
    * **disabled**  
      .IX Item "disabled"
      Disables shifting of timestamp.
      .Sp
      When shifting is enabled, all output timestamps are shifted by the
      same amount. Audio, video, and subtitles desynching and relative
      timestamp differences are preserved compared to how they would have
      been without shifting.
* **skip\_initial\_bytes** _integer_ **(**_input_**)**  
  .IX Item "skip_initial_bytes integer (input)"
  Set number of bytes to skip before reading header and frames if set to 1.
  Default is 0.
* **correct\_ts\_overflow** _integer_ **(**_input_**)**  
  .IX Item "correct_ts_overflow integer (input)"
  Correct single timestamp overflows if set to 1. Default is 1.
* **flush\_packets** _integer_ **(**_output_**)**  
  .IX Item "flush_packets integer (output)"
  Flush the underlying I/O stream after each packet. Default is -1 (auto), which
  means that the underlying protocol will decide, 1 enables it, and has the
  effect of reducing the latency, 0 disables it and may increase \s-1IO\s0 throughput in
  some cases.
* **output\_ts\_offset** _offset_ **(**_output_**)**  
  .IX Item "output_ts_offset offset (output)"
  Set the output time offset.
  .Sp
  _offset_ must be a time duration specification,
  see **the Time duration section in the ffmpeg-utils\|(1) manual**.
  .Sp
  The offset is added by the muxer to the output timestamps.
  .Sp
  Specifying a positive offset means that the corresponding streams are
  delayed bt the time duration specified in _offset_. Default value
  is \f(CW0 (meaning that no offset is applied).
* **format\_whitelist** _list_ **(**_input_**)**  
  .IX Item "format_whitelist list (input)"
  ,\*(R" separated list of allowed demuxers. By default all are allowed.
* **dump\_separator** _string_ **(**_input_**)**  
  .IX Item "dump_separator string (input)"
  Separator used to separate the fields printed on the command line about the
  Stream parameters.
  For example to separate the fields with newlines and indention:
  .Sp
  .Vb 2
          ffprobe -dump_separator "
                                    "  -i ~/videos/matrixbench_mpeg2.mpg
  .Ve
* **max\_streams** _integer_ **(**_input_**)**  
  .IX Item "max_streams integer (input)"
  Specifies the maximum number of streams. This can be used to reject files that
  would require too many resources due to a large number of streams.
* **skip\_estimate\_duration\_from\_pts** _bool_ **(**_input_**)**  
  .IX Item "skip_estimate_duration_from_pts bool (input)"
  Skip estimation of input duration when calculated using \s-1PTS.\s0
  At present, applicable for MPEG-PS and MPEG-TS.

<a name="format-stream-specifiers"></a>

### Format stream specifiers

.IX Subsection "Format stream specifiers"
Format stream specifiers allow selection of one or more streams that
match specific properties.

Possible forms of stream specifiers are:

* _stream\_index_  
  .IX Item "stream_index"
  Matches the stream with this index.
* _stream\_type_**[:**_stream\_index_**]**  
  .IX Item "stream_type[:stream_index]"
  _stream\_type_ is one of following: 'v' for video, 'a' for audio,
  's' for subtitle, 'd' for data, and 't' for attachments. If
  _stream\_index_ is given, then it matches the stream number
  _stream\_index_ of this type. Otherwise, it matches all streams of
  this type.
* **p:**_program\_id_**[:**_stream\_index_**]**  
  .IX Item "p:program_id[:stream_index]"
  If _stream\_index_ is given, then it matches the stream with number
  _stream\_index_ in the program with the id
  _program\_id_. Otherwise, it matches all streams in the program.
* **#**_stream\_id_  
  .IX Item "#stream_id"
  Matches the stream by a format-specific \s-1ID.\s0

The exact semantics of stream specifiers is defined by the
\f(CW`avformat\_match\_stream\_specifier()\*(C' function declared in the
_libavformat/avformat.h_ header.

<a name="demuxers"></a>

# Demuxers

.IX Header "DEMUXERS"
Demuxers are configured elements in FFmpeg that can read the
multimedia streams from a particular type of file.

When you configure your FFmpeg build, all the supported demuxers
are enabled by default. You can list all available ones using the
configure option \f(CW`--list-demuxers\*(C'.

You can disable all the demuxers using the configure option
\f(CW`--disable-demuxers\*(C', and selectively enable a single demuxer with
the option \f(CW`--enable-demuxer=\f(CIDEMUXER\f(CW\*(C', or disable it
with the option \f(CW`--disable-demuxer=\f(CIDEMUXER\f(CW\*(C'.

The option \f(CW`-demuxers\*(C' of the ff* tools will display the list of
enabled demuxers. Use \f(CW`-formats\*(C' to view a combined list of
enabled demuxers and muxers.

The description of some of the currently available demuxers follows.

<a name="aa"></a>

### aa

.IX Subsection "aa"
Audible Format 2, 3, and 4 demuxer.

This demuxer is used to demux Audible Format 2, 3, and 4 (.aa) files.

<a name="applehttp"></a>

### applehttp

.IX Subsection "applehttp"
Apple \s-1HTTP\s0 Live Streaming demuxer.

This demuxer presents all AVStreams from all variant streams.
The id field is set to the bitrate variant index number. By setting
the discard flags on AVStreams (by pressing 'a' or 'v' in ffplay),
the caller can decide which variant streams to actually receive.
The total bitrate of the variant that the stream belongs to is
available in a metadata key named variant_bitrate\*(R".

<a name="apng"></a>

### apng

.IX Subsection "apng"
Animated Portable Network Graphics demuxer.

This demuxer is used to demux \s-1APNG\s0 files.
All headers, but the \s-1PNG\s0 signature, up to (but not including) the first
fcTL chunk are transmitted as extradata.
Frames are then split as being all the chunks between two fcTL ones, or
between the last fcTL and \s-1IEND\s0 chunks.

* **-ignore\_loop** _bool_  
  .IX Item "-ignore_loop bool"
  Ignore the loop variable in the file if set.
* **-max\_fps** _int_  
  .IX Item "-max_fps int"
  Maximum framerate in frames per second (0 for no limit).
* **-default\_fps** _int_  
  .IX Item "-default_fps int"
  Default framerate in frames per second when none is specified in the file
  (0 meaning as fast as possible).

<a name="asf"></a>

### asf

.IX Subsection "asf"
Advanced Systems Format demuxer.

This demuxer is used to demux \s-1ASF\s0 files and \s-1MMS\s0 network streams.

* **-no\_resync\_search** _bool_  
  .IX Item "-no_resync_search bool"
  Do not try to resynchronize by looking for a certain optional start code.

<a name="concat"></a>

### concat

.IX Subsection "concat"
Virtual concatenation script demuxer.

This demuxer reads a list of files and other directives from a text file and
demuxes them one after the other, as if all their packets had been muxed
together.

The timestamps in the files are adjusted so that the first file starts at 0
and each next file starts where the previous one finishes. Note that it is
done globally and may cause gaps if all streams do not have exactly the same
length.

All files must have the same streams (same codecs, same time base, etc.).

The duration of each file is used to adjust the timestamps of the next file:
if the duration is incorrect (because it was computed using the bit-rate or
because the file is truncated, for example), it can cause artifacts. The
\f(CW`duration\*(C' directive can be used to override the duration stored in
each file.

_Syntax_
.IX Subsection "Syntax"

The script is a text file in extended-ASCII, with one directive per line.
Empty lines, leading spaces and lines starting with '#' are ignored. The
following directive is recognized:
.ie n .IP "**\f(CB""file \f(CBpath\f(CB""**" 4
.el .IP "**\f(CBfile \f(CBpath\f(CB**" 4
.IX Item "file path"
Path to a file to read; special characters and spaces must be escaped with
backslash or single quotes.
.Sp
All subsequent file-related directives apply to that file.
.ie n .IP "**\f(CB""ffconcat version 1.0""**" 4
.el .IP "**\f(CBffconcat version 1.0**" 4
.IX Item "ffconcat version 1.0"
Identify the script type and version. It also sets the **safe** option
to 1 if it was -1.
.Sp
To make FFmpeg recognize the format automatically, this directive must
appear exactly as is (no extra space or byte-order-mark) on the very first
line of the script.
.ie n .IP "**\f(CB""duration \f(CBdur\f(CB""**" 4
.el .IP "**\f(CBduration \f(CBdur\f(CB**" 4
.IX Item "duration dur"
Duration of the file. This information can be specified from the file;
specifying it here may be more efficient or help if the information from the
file is not available or accurate.
.Sp
If the duration is set for all files, then it is possible to seek in the
whole concatenated video.
.ie n .IP "**\f(CB""inpoint \f(CBtimestamp\f(CB""**" 4
.el .IP "**\f(CBinpoint \f(CBtimestamp\f(CB**" 4
.IX Item "inpoint timestamp"
In point of the file. When the demuxer opens the file it instantly seeks to the
specified timestamp. Seeking is done so that all streams can be presented
successfully at In point.
.Sp
This directive works best with intra frame codecs, because for non-intra frame
ones you will usually get extra packets before the actual In point and the
decoded content will most likely contain frames before In point too.
.Sp
For each file, packets before the file In point will have timestamps less than
the calculated start timestamp of the file (negative in case of the first
file), and the duration of the files (if not specified by the \f(CW`duration\*(C'
directive) will be reduced based on their specified In point.
.Sp
Because of potential packets before the specified In point, packet timestamps
may overlap between two concatenated files.
.ie n .IP "**\f(CB""outpoint \f(CBtimestamp\f(CB""**" 4
.el .IP "**\f(CBoutpoint \f(CBtimestamp\f(CB**" 4
.IX Item "outpoint timestamp"
Out point of the file. When the demuxer reaches the specified decoding
timestamp in any of the streams, it handles it as an end of file condition and
skips the current and all the remaining packets from all streams.
.Sp
Out point is exclusive, which means that the demuxer will not output packets
with a decoding timestamp greater or equal to Out point.
.Sp
This directive works best with intra frame codecs and formats where all streams
are tightly interleaved. For non-intra frame codecs you will usually get
additional packets with presentation timestamp after Out point therefore the
decoded content will most likely contain frames after Out point too. If your
streams are not tightly interleaved you may not get all the packets from all
streams before Out point and you may only will be able to decode the earliest
stream until Out point.
.Sp
The duration of the files (if not specified by the \f(CW`duration\*(C'
directive) will be reduced based on their specified Out point.
.ie n .IP "**\f(CB""file_packet_metadata \f(CBkey=value\f(CB""**" 4
.el .IP "**\f(CBfile_packet_metadata \f(CBkey=value\f(CB**" 4
.IX Item "file_packet_metadata key=value"
Metadata of the packets of the file. The specified metadata will be set for
each file packet. You can specify this directive multiple times to add multiple
metadata entries.
.ie n .IP "**\f(CB""stream""**" 4
.el .IP "**\f(CBstream**" 4
.IX Item "stream"
Introduce a stream in the virtual file.
All subsequent stream-related directives apply to the last introduced
stream.
Some streams properties must be set in order to allow identifying the
matching streams in the subfiles.
If no streams are defined in the script, the streams from the first file are
copied.
.ie n .IP "**\f(CB""exact_stream_id \f(CBid\f(CB""**" 4
.el .IP "**\f(CBexact_stream_id \f(CBid\f(CB**" 4
.IX Item "exact_stream_id id"
Set the id of the stream.
If this directive is given, the string with the corresponding id in the
subfiles will be used.
This is especially useful for MPEG-PS (\s-1VOB\s0) files, where the order of the
streams is not reliable.

_Options_
.IX Subsection "Options"

This demuxer accepts the following option:

* **safe**  
  .IX Item "safe"
  If set to 1, reject unsafe file paths. A file path is considered safe if it
  does not contain a protocol specification and is relative and all components
  only contain characters from the portable character set (letters, digits,
  period, underscore and hyphen) and have no period at the beginning of a
  component.
  .Sp
  If set to 0, any file name is accepted.
  .Sp
  The default is 1.
  .Sp
  -1 is equivalent to 1 if the format was automatically
  probed and 0 otherwise.
* **auto\_convert**  
  .IX Item "auto_convert"
  If set to 1, try to perform automatic conversions on packet data to make the
  streams concatenable.
  The default is 1.
  .Sp
  Currently, the only conversion is adding the h264_mp4toannexb bitstream
  filter to H.264 streams in \s-1MP4\s0 format. This is necessary in particular if
  there are resolution changes.
* **segment\_time\_metadata**  
  .IX Item "segment_time_metadata"
  If set to 1, every packet will contain the _lavf.concat.start\_time_ and the
  _lavf.concat.duration_ packet metadata values which are the start_time and
  the duration of the respective file segments in the concatenated output
  expressed in microseconds. The duration metadata is only set if it is known
  based on the concat file.
  The default is 0.

_Examples_
.IX Subsection "Examples"

* ·  
  Use absolute filenames and include some comments:
  .Sp
  .Vb 6
          # my first filename
          file /mnt/share/file-1.wav
          # my second filename including whitespace
          file /mnt/share/file 2.wav\*(Aq
          # my third filename including whitespace plus single quote
          file /mnt/share/file 3\*(Aq\e\*(Aq\*(Aq.wav\*(Aq
  .Ve
* ·  
  Allow for input format auto-probing, use safe filenames and set the duration of
  the first file:
  .Sp
  .Vb 1
          ffconcat version 1.0
          
          file file-1.wav
          duration 20.0
          
          file subdir/file-2.wav
  .Ve

<a name="dash"></a>

### dash

.IX Subsection "dash"
Dynamic Adaptive Streaming over \s-1HTTP\s0 demuxer.

This demuxer presents all AVStreams found in the manifest.
By setting the discard flags on AVStreams the caller can decide
which streams to actually receive.
Each stream mirrors the \f(CW`id\*(C' and \f(CW\*(C\`bandwidth\*(C' properties from the
\f(CW`&lt;Representation&gt;\*(C' as metadata keys named \*(L"id\*(R" and \*(L"variant_bitrate\*(R" respectively.

<a name="flv-live_flv"></a>

### flv, live_flv

.IX Subsection "flv, live_flv"
Adobe Flash Video Format demuxer.

This demuxer is used to demux \s-1FLV\s0 files and \s-1RTMP\s0 network streams. In case of live network streams, if you force format, you may use live_flv option instead of flv to survive timestamp discontinuities.

.Vb 2
        ffmpeg -f flv -i myfile.flv ...
        ffmpeg -f live_flv -i rtmp://&lt;any.server&gt;/anything/key ....
.Ve

* **-flv\_metadata** _bool_  
  .IX Item "-flv_metadata bool"
  Allocate the streams according to the onMetaData array content.
* **-flv\_ignore\_prevtag** _bool_  
  .IX Item "-flv_ignore_prevtag bool"
  Ignore the size of previous tag value.
* **-flv\_full\_metadata** _bool_  
  .IX Item "-flv_full_metadata bool"
  Output all context of the onMetadata.

<a name="gif"></a>

### gif

.IX Subsection "gif"
Animated \s-1GIF\s0 demuxer.

It accepts the following options:

* **min\_delay**  
  .IX Item "min_delay"
  Set the minimum valid delay between frames in hundredths of seconds.
  Range is 0 to 6000. Default value is 2.
* **max\_gif\_delay**  
  .IX Item "max_gif_delay"
  Set the maximum valid delay between frames in hundredth of seconds.
  Range is 0 to 65535. Default value is 65535 (nearly eleven minutes),
  the maximum value allowed by the specification.
* **default\_delay**  
  .IX Item "default_delay"
  Set the default delay between frames in hundredths of seconds.
  Range is 0 to 6000. Default value is 10.
* **ignore\_loop**  
  .IX Item "ignore_loop"
  \s-1GIF\s0 files can contain information to loop a certain number of times (or
  infinitely). If **ignore\_loop** is set to 1, then the loop setting
  from the input will be ignored and looping will not occur. If set to 0,
  then looping will occur and will cycle the number of times according to
  the \s-1GIF.\s0 Default value is 1.

For example, with the overlay filter, place an infinitely looping \s-1GIF\s0
over another video:

.Vb 1
        ffmpeg -i input.mp4 -ignore_loop 0 -i input.gif -filter_complex overlay=shortest=1 out.mkv
.Ve

Note that in the above example the shortest option for overlay filter is
used to end the output video at the length of the shortest input file,
which in this case is _input.mp4_ as the \s-1GIF\s0 in this example loops
infinitely.

<a name="hls"></a>

### hls

.IX Subsection "hls"
\s-1HLS\s0 demuxer

It accepts the following options:

* **live\_start\_index**  
  .IX Item "live_start_index"
  segment index to start live streams at (negative values are from the end).
* **allowed\_extensions**  
  .IX Item "allowed_extensions"
  ',' separated list of file extensions that hls is allowed to access.
* **max\_reload**  
  .IX Item "max_reload"
  Maximum number of times a insufficient list is attempted to be reloaded.
  Default value is 1000.
* **http\_persistent**  
  .IX Item "http_persistent"
  Use persistent \s-1HTTP\s0 connections. Applicable only for \s-1HTTP\s0 streams.
  Enabled by default.
* **http\_multiple**  
  .IX Item "http_multiple"
  Use multiple \s-1HTTP\s0 connections for downloading \s-1HTTP\s0 segments.
  Enabled by default for \s-1HTTP/1.1\s0 servers.

<a name="image2"></a>

### image2

.IX Subsection "image2"
Image file demuxer.

This demuxer reads from a list of image files specified by a pattern.
The syntax and meaning of the pattern is specified by the
option _pattern\_type_.

The pattern may contain a suffix which is used to automatically
determine the format of the images contained in the files.

The size, the pixel format, and the format of each image must be the
same for all the files in the sequence.

This demuxer accepts the following options:

* **framerate**  
  .IX Item "framerate"
  Set the frame rate for the video stream. It defaults to 25.
* **loop**  
  .IX Item "loop"
  If set to 1, loop over the input. Default value is 0.
* **pattern\_type**  
  .IX Item "pattern_type"
  Select the pattern type used to interpret the provided filename.
  .Sp
  _pattern\_type_ accepts one of the following values.
    * **none**  
      .IX Item "none"
      Disable pattern matching, therefore the video will only contain the specified
      image. You should use this option if you do not want to create sequences from
      multiple images and your filenames may contain special pattern characters.
    * **sequence**  
      .IX Item "sequence"
      Select a sequence pattern type, used to specify a sequence of files
      indexed by sequential numbers.
      .Sp
      A sequence pattern may contain the string %d\*(R" or "%0_N_d\*(L", which
      specifies the position of the characters representing a sequential
      number in each filename matched by the pattern. If the form
      %d0_N_d" is used, the string representing the number in each
      filename is 0-padded and _N_ is the total number of 0-padded
      digits representing the number. The literal character '%' can be
      specified in the pattern with the string %%\*(R".
      .Sp
      If the sequence pattern contains %d\*(R" or "%0_N_d", the first filename of
      the file list specified by the pattern must contain a number
      inclusively contained between _start\_number_ and
      _start\_number_+_start\_number\_range_-1, and all the following
      numbers must be sequential.
      .Sp
      For example the pattern img-%03d.bmp\*(R" will match a sequence of
      filenames of the form _img-001.bmp_, _img-002.bmp_, ...,
      _img-010.bmp_, etc.; the pattern i%%m%%g-%d.jpg\*(R" will match a
      sequence of filenames of the form _i%m%g-1.jpg_,
      _i%m%g-2.jpg_, ..., _i%m%g-10.jpg_, etc.
      .Sp
      Note that the pattern must not necessarily contain %d\*(R" or
      "%0_N_d", for example to convert a single image file
      _img.jpeg_ you can employ the command:
      .Sp
      .Vb 1
              ffmpeg -i img.jpeg img.png
      .Ve
    * **glob**  
      .IX Item "glob"
      Select a glob wildcard pattern type.
      .Sp
      The pattern is interpreted like a \f(CW`glob()\*(C' pattern. This is only
      selectable if libavformat was compiled with globbing support.
    * **glob\_sequence** _(deprecated, will be removed)_  
      .IX Item "glob_sequence (deprecated, will be removed)"
      Select a mixed glob wildcard/sequence pattern.
      .Sp
      If your version of libavformat was compiled with globbing support, and
      the provided pattern contains at least one glob meta character among
      \f(CW`%*?[]{}\*(C' that is preceded by an unescaped \*(L"%\*(R", the pattern is
      interpreted like a \f(CW`glob()\*(C' pattern, otherwise it is interpreted
      like a sequence pattern.
      .Sp
      All glob special characters \f(CW`%*?[]{}\*(C' must be prefixed
      with %\*(R". To escape a literal \*(L"%\*(R" you shall use \*(L"%%\*(R".
      .Sp
      For example the pattern \f(CW`foo-%*.jpeg\*(C' will match all the
      filenames prefixed by foo-\*(R" and terminating with \*(L".jpeg\*(R", and
      \f(CW`foo-%?%?%?.jpeg\*(C' will match all the filenames prefixed with
      foo-\*(R", followed by a sequence of three characters, and terminating
      with .jpeg\*(R".
      .Sp
      This pattern type is deprecated in favor of _glob_ and
      _sequence_.
      .Sp
      Default value is _glob\_sequence_.
* **pixel\_format**  
  .IX Item "pixel_format"
  Set the pixel format of the images to read. If not specified the pixel
  format is guessed from the first image file in the sequence.
* **start\_number**  
  .IX Item "start_number"
  Set the index of the file matched by the image file pattern to start
  to read from. Default value is 0.
* **start\_number\_range**  
  .IX Item "start_number_range"
  Set the index interval range to check when looking for the first image
  file in the sequence, starting from _start\_number_. Default value
  is 5.
* **ts\_from\_file**  
  .IX Item "ts_from_file"
  If set to 1, will set frame timestamp to modification time of image file. Note
  that monotonity of timestamps is not provided: images go in the same order as
  without this option. Default value is 0.
  If set to 2, will set frame timestamp to the modification time of the image file in
  nanosecond precision.
* **video\_size**  
  .IX Item "video_size"
  Set the video size of the images to read. If not specified the video
  size is guessed from the first image file in the sequence.

_Examples_
.IX Subsection "Examples"

* ·  
  Use **ffmpeg** for creating a video from the images in the file
  sequence _img-001.jpeg_, _img-002.jpeg_, ..., assuming an
  input frame rate of 10 frames per second:
  .Sp
  .Vb 1
          ffmpeg -framerate 10 -i img-%03d.jpeg\*(Aq out.mkv
  .Ve
* ·  
  As above, but start by reading from a file with index 100 in the sequence:
  .Sp
  .Vb 1
          ffmpeg -framerate 10 -start_number 100 -i img-%03d.jpeg\*(Aq out.mkv
  .Ve
* ·  
  Read images matching the *.png\*(R" glob pattern , that is all the files
  terminating with the .png\*(R" suffix:
  .Sp
  .Vb 1
          ffmpeg -framerate 10 -pattern_type glob -i "*.png" out.mkv
  .Ve

<a name="libgme"></a>

### libgme

.IX Subsection "libgme"
The Game Music Emu library is a collection of video game music file emulators.

See &lt;**http://code.google.com/p/game-music-emu/**&gt; for more information.

Some files have multiple tracks. The demuxer will pick the first track by
default. The **track\_index** option can be used to select a different
track. Track indexes start at 0. The demuxer exports the number of tracks as
_tracks_ meta data entry.

For very large files, the **max\_size** option may have to be adjusted.

<a name="libopenmpt"></a>

### libopenmpt

.IX Subsection "libopenmpt"
libopenmpt based module demuxer

See &lt;**https://lib.openmpt.org/libopenmpt/**&gt; for more information.

Some files have multiple subsongs (tracks) this can be set with the **subsong**
option.

It accepts the following options:

* **subsong**  
  .IX Item "subsong"
  Set the subsong index. This can be either  'all', 'auto', or the index of the
  subsong. Subsong indexes start at 0. The default is 'auto'.
  .Sp
  The default value is to let libopenmpt choose.
* **layout**  
  .IX Item "layout"
  Set the channel layout. Valid values are 1, 2, and 4 channel layouts.
  The default value is \s-1STEREO.\s0
* **sample\_rate**  
  .IX Item "sample_rate"
  Set the sample rate for libopenmpt to output.
  Range is from 1000 to \s-1INT_MAX.\s0 The value default is 48000.

<a name="movmp43gpquicktime"></a>

### mov/mp4/3gp/QuickTime

.IX Subsection "mov/mp4/3gp/QuickTime"
QuickTime / \s-1MP4\s0 demuxer.

This demuxer accepts the following options:

* **enable\_drefs**  
  .IX Item "enable_drefs"
  Enable loading of external tracks, disabled by default.
  Enabling this can theoretically leak information in some use cases.
* **use\_absolute\_path**  
  .IX Item "use_absolute_path"
  Allows loading of external tracks via absolute paths, disabled by default.
  Enabling this poses a security risk. It should only be enabled if the source
  is known to be non malicious.

<a name="mpegts"></a>

### mpegts

.IX Subsection "mpegts"
\s-1MPEG-2\s0 transport stream demuxer.

This demuxer accepts the following options:

* **resync\_size**  
  .IX Item "resync_size"
  Set size limit for looking up a new synchronization. Default value is
  65536.
* **skip\_unknown\_pmt**  
  .IX Item "skip_unknown_pmt"
  Skip PMTs for programs not defined in the \s-1PAT.\s0 Default value is 0.
* **fix\_teletext\_pts**  
  .IX Item "fix_teletext_pts"
  Override teletext packet \s-1PTS\s0 and \s-1DTS\s0 values with the timestamps calculated
  from the \s-1PCR\s0 of the first program which the teletext stream is part of and is
  not discarded. Default value is 1, set this option to 0 if you want your
  teletext packet \s-1PTS\s0 and \s-1DTS\s0 values untouched.
* **ts\_packetsize**  
  .IX Item "ts_packetsize"
  Output option carrying the raw packet size in bytes.
  Show the detected raw packet size, cannot be set by the user.
* **scan\_all\_pmts**  
  .IX Item "scan_all_pmts"
  Scan and combine all PMTs. The value is an integer with value from -1
  to 1 (-1 means automatic setting, 1 means enabled, 0 means
  disabled). Default value is -1.
* **merge\_pmt\_versions**  
  .IX Item "merge_pmt_versions"
  Re-use existing streams when a \s-1PMT\s0's version is updated and elementary
  streams move to different PIDs. Default value is 0.

<a name="mpjpeg"></a>

### mpjpeg

.IX Subsection "mpjpeg"
\s-1MJPEG\s0 encapsulated in multi-part \s-1MIME\s0 demuxer.

This demuxer allows reading of \s-1MJPEG,\s0 where each frame is represented as a part of
multipart/x-mixed-replace stream.

* **strict\_mime\_boundary**  
  .IX Item "strict_mime_boundary"
  Default implementation applies a relaxed standard to multi-part \s-1MIME\s0 boundary detection,
  to prevent regression with numerous existing endpoints not generating a proper \s-1MIME
  MJPEG\s0 stream. Turning this option on by setting it to 1 will result in a stricter check
  of the boundary value.

<a name="rawvideo"></a>

### rawvideo

.IX Subsection "rawvideo"
Raw video demuxer.

This demuxer allows one to read raw video data. Since there is no header
specifying the assumed video parameters, the user must specify them
in order to be able to decode the data correctly.

This demuxer accepts the following options:

* **framerate**  
  .IX Item "framerate"
  Set input video frame rate. Default value is 25.
* **pixel\_format**  
  .IX Item "pixel_format"
  Set the input video pixel format. Default value is \f(CW`yuv420p\*(C'.
* **video\_size**  
  .IX Item "video_size"
  Set the input video size. This value must be specified explicitly.

For example to read a rawvideo file _input.raw_ with
**ffplay**, assuming a pixel format of \f(CW`rgb24\*(C', a video
size of \f(CW`320x240\*(C', and a frame rate of 10 images per second, use
the command:

.Vb 1
        ffplay -f rawvideo -pixel_format rgb24 -video_size 320x240 -framerate 10 input.raw
.Ve

<a name="sbg"></a>

### sbg

.IX Subsection "sbg"
SBaGen script demuxer.

This demuxer reads the script language used by SBaGen
&lt;**http://uazu.net/sbagen/**&gt; to generate binaural beats sessions. A \s-1SBG\s0
script looks like that:

.Vb 9
        -SE
        a: 300-2.5/3 440+4.5/0
        b: 300-2.5/0 440+4.5/3
        off: -
        NOW      == a
        +0:07:00 == b
        +0:14:00 == a
        +0:21:00 == b
        +0:30:00    off
.Ve

A \s-1SBG\s0 script can mix absolute and relative timestamps. If the script uses
either only absolute timestamps (including the script start time) or only
relative ones, then its layout is fixed, and the conversion is
straightforward. On the other hand, if the script mixes both kind of
timestamps, then the _\s-1NOW\s0_ reference for relative timestamps will be
taken from the current time of day at the time the script is read, and the
script layout will be frozen according to that reference. That means that if
the script is directly played, the actual times will match the absolute
timestamps up to the sound controller's clock accuracy, but if the user
somehow pauses the playback or seeks, all times will be shifted accordingly.

<a name="tedcaptions"></a>

### tedcaptions

.IX Subsection "tedcaptions"
\s-1JSON\s0 captions used for &lt;**http://www.ted.com/**&gt;.

\s-1TED\s0 does not provide links to the captions, but they can be guessed from the
page. The file _tools/bookmarklets.html_ from the FFmpeg source tree
contains a bookmarklet to expose them.

This demuxer accepts the following option:

* **start\_time**  
  .IX Item "start_time"
  Set the start time of the \s-1TED\s0 talk, in milliseconds. The default is 15000
  (15s). It is used to sync the captions with the downloadable videos, because
  they include a 15s intro.

Example: convert the captions to a format most players understand:

.Vb 1
        ffmpeg -i http://www.ted.com/talks/subtitles/id/1/lang/en talk1-en.srt
.Ve

<a name="muxers"></a>

# Muxers

.IX Header "MUXERS"
Muxers are configured elements in FFmpeg which allow writing
multimedia streams to a particular type of file.

When you configure your FFmpeg build, all the supported muxers
are enabled by default. You can list all available muxers using the
configure option \f(CW`--list-muxers\*(C'.

You can disable all the muxers with the configure option
\f(CW`--disable-muxers\*(C' and selectively enable / disable single muxers
with the options \f(CW`--enable-muxer=\f(CIMUXER\f(CW\*(C' /
\f(CW`--disable-muxer=\f(CIMUXER\f(CW\*(C'.

The option \f(CW`-muxers\*(C' of the ff* tools will display the list of
enabled muxers. Use \f(CW`-formats\*(C' to view a combined list of
enabled demuxers and muxers.

A description of some of the currently available muxers follows.

<a name="aiff"></a>

### aiff

.IX Subsection "aiff"
Audio Interchange File Format muxer.

_Options_
.IX Subsection "Options"

It accepts the following options:

* **write\_id3v2**  
  .IX Item "write_id3v2"
  Enable ID3v2 tags writing when set to 1. Default is 0 (disabled).
* **id3v2\_version**  
  .IX Item "id3v2_version"
  Select ID3v2 version to write. Currently only version 3 and 4 (aka.
  ID3v2.3 and ID3v2.4) are supported. The default is version 4.

<a name="asf"></a>

### asf

.IX Subsection "asf"
Advanced Systems Format muxer.

Note that Windows Media Audio (wma) and Windows Media Video (wmv) use this
muxer too.

_Options_
.IX Subsection "Options"

It accepts the following options:

* **packet\_size**  
  .IX Item "packet_size"
  Set the muxer packet size. By tuning this setting you may reduce data
  fragmentation or muxer overhead depending on your source. Default value is
  3200, minimum is 100, maximum is 64k.

<a name="avi"></a>

### avi

.IX Subsection "avi"
Audio Video Interleaved muxer.

_Options_
.IX Subsection "Options"

It accepts the following options:

* **reserve\_index\_space**  
  .IX Item "reserve_index_space"
  Reserve the specified amount of bytes for the OpenDML master index of each
  stream within the file header. By default additional master indexes are
  embedded within the data packets if there is no space left in the first master
  index and are linked together as a chain of indexes. This index structure can
  cause problems for some use cases, e.g. third-party software strictly relying
  on the OpenDML index specification or when file seeking is slow. Reserving
  enough index space in the file header avoids these problems.
  .Sp
  The required index space depends on the output file size and should be about 16
  bytes per gigabyte. When this option is omitted or set to zero the necessary
  index space is guessed.
* **write\_channel\_mask**  
  .IX Item "write_channel_mask"
  Write the channel layout mask into the audio stream header.
  .Sp
  This option is enabled by default. Disabling the channel mask can be useful in
  specific scenarios, e.g. when merging multiple audio streams into one for
  compatibility with software that only supports a single audio stream in \s-1AVI\s0
  (see **the amerge\*(R" section in the ffmpeg-filters manual**).

<a name="chromaprint"></a>

### chromaprint

.IX Subsection "chromaprint"
Chromaprint fingerprinter

This muxer feeds audio data to the Chromaprint library, which generates
a fingerprint for the provided audio data. It takes a single signed
native-endian 16-bit raw audio stream.

_Options_
.IX Subsection "Options"

* **silence\_threshold**  
  .IX Item "silence_threshold"
  Threshold for detecting silence, ranges from 0 to 32767. -1 for default
  (required for use with the AcoustID service).
* **algorithm**  
  .IX Item "algorithm"
  Algorithm index to fingerprint with.
* **fp\_format**  
  .IX Item "fp_format"
  Format to output the fingerprint as. Accepts the following options:
    * **raw**  
      .IX Item "raw"
      Binary raw fingerprint
    * **compressed**  
      .IX Item "compressed"
      Binary compressed fingerprint
    * **base64**  
      .IX Item "base64"
      Base64 compressed fingerprint

<a name="crc"></a>

### crc

.IX Subsection "crc"
\s-1CRC\s0 (Cyclic Redundancy Check) testing format.

This muxer computes and prints the Adler-32 \s-1CRC\s0 of all the input audio
and video frames. By default audio frames are converted to signed
16-bit raw audio and video frames to raw video before computing the
\s-1CRC.\s0

The output of the muxer consists of a single line of the form:
CRC=0x_\s-1CRC\s0_, where _\s-1CRC\s0_ is a hexadecimal number 0-padded to
8 digits containing the \s-1CRC\s0 for all the decoded input frames.

See also the **framecrc** muxer.

_Examples_
.IX Subsection "Examples"

For example to compute the \s-1CRC\s0 of the input, and store it in the file
_out.crc_:

.Vb 1
        ffmpeg -i INPUT -f crc out.crc
.Ve

You can print the \s-1CRC\s0 to stdout with the command:

.Vb 1
        ffmpeg -i INPUT -f crc -
.Ve

You can select the output format of each frame with **ffmpeg** by
specifying the audio and video codec and format. For example to
compute the \s-1CRC\s0 of the input audio converted to \s-1PCM\s0 unsigned 8-bit
and the input video converted to \s-1MPEG-2\s0 video, use the command:

.Vb 1
        ffmpeg -i INPUT -c:a pcm_u8 -c:v mpeg2video -f crc -
.Ve

<a name="flv"></a>

### flv

.IX Subsection "flv"
Adobe Flash Video Format muxer.

This muxer accepts the following options:

* **flvflags** _flags_  
  .IX Item "flvflags flags"
  Possible values:
    * **aac\_seq\_header\_detect**  
      .IX Item "aac_seq_header_detect"
      Place \s-1AAC\s0 sequence header based on audio stream data.
    * **no\_sequence\_end**  
      .IX Item "no_sequence_end"
      Disable sequence end tag.
    * **no\_metadata**  
      .IX Item "no_metadata"
      Disable metadata tag.
    * **no\_duration\_filesize**  
      .IX Item "no_duration_filesize"
      Disable duration and filesize in metadata when they are equal to zero
      at the end of stream. (Be used to non-seekable living stream).
    * **add\_keyframe\_index**  
      .IX Item "add_keyframe_index"
      Used to facilitate seeking; particularly for \s-1HTTP\s0 pseudo streaming.

<a name="dash"></a>

### dash

.IX Subsection "dash"
Dynamic Adaptive Streaming over \s-1HTTP\s0 (\s-1DASH\s0) muxer that creates segments
and manifest files according to the MPEG-DASH standard \s-1ISO/IEC 23009-1:2014.\s0

For more information see:

* ·  
  \s-1ISO DASH\s0 Specification: &lt;**http://standards.iso.org/ittf/PubliclyAvailableStandards/c065274\_ISO\_IEC\_23009-1\_2014.zip**&gt;
* ·  
  WebM \s-1DASH\s0 Specification: &lt;**https://sites.google.com/a/webmproject.org/wiki/adaptive-streaming/webm-dash-specification**&gt;

It creates a \s-1MPD\s0 manifest file and segment files for each stream.

The segment filename might contain pre-defined identifiers used with SegmentTemplate
as defined in section 5.3.9.4.4 of the standard. Available identifiers are $RepresentationID$\*(R",
$Number$\*(R", \*(L"$Bandwidth$\*(R" and \*(L"$Time$\*(R".

.Vb 6
        ffmpeg -re -i &lt;input&gt; -map 0 -map 0 -c:a libfdk_aac -c:v libx264
        -b:v:0 800k -b:v:1 300k -s:v:1 320x170 -profile:v:1 baseline
        -profile:v:0 main -bf 1 -keyint_min 120 -g 120 -sc_threshold 0
        -b_strategy 0 -ar:a:1 22050 -use_timeline 1 -use_template 1
        -window_size 5 -adaptation_sets "id=0,streams=v id=1,streams=a"
        -f dash /path/to/out.mpd
.Ve

* **-min\_seg\_duration** _microseconds_  
  .IX Item "-min_seg_duration microseconds"
  This is a deprecated option to set the segment length in microseconds, use _seg\_duration_ instead.
* **-seg\_duration** _duration_  
  .IX Item "-seg_duration duration"
  Set the segment length in seconds (fractional value can be set). The value is
  treated as average segment duration when _use\_template_ is enabled and
  _use\_timeline_ is disabled and as minimum segment duration for all the other
  use cases.
* **-window\_size** _size_  
  .IX Item "-window_size size"
  Set the maximum number of segments kept in the manifest.
* **-extra\_window\_size** _size_  
  .IX Item "-extra_window_size size"
  Set the maximum number of segments kept outside of the manifest before removing from disk.
* **-remove\_at\_exit** _remove_  
  .IX Item "-remove_at_exit remove"
  Enable (1) or disable (0) removal of all segments when finished.
* **-use\_template** _template_  
  .IX Item "-use_template template"
  Enable (1) or disable (0) use of SegmentTemplate instead of SegmentList.
* **-use\_timeline** _timeline_  
  .IX Item "-use_timeline timeline"
  Enable (1) or disable (0) use of SegmentTimeline in SegmentTemplate.
* **-single\_file** _single\_file_  
  .IX Item "-single_file single_file"
  Enable (1) or disable (0) storing all segments in one file, accessed using byte ranges.
* **-single\_file\_name** _file\_name_  
  .IX Item "-single_file_name file_name"
  DASH-templated name to be used for baseURL. Implies _single\_file_ set to 1\*(R".
* **-init\_seg\_name** _init\_name_  
  .IX Item "-init_seg_name init_name"
  DASH-templated name to used for the initialization segment. Default is init-stream$RepresentationID$.m4s\*(R"
* **-media\_seg\_name** _segment\_name_  
  .IX Item "-media_seg_name segment_name"
  DASH-templated name to used for the media segments. Default is chunk-stream$RepresentationID$-$Number%05d$.m4s\*(R"
* **-utc\_timing\_url** _utc\_url_  
  .IX Item "-utc_timing_url utc_url"
  \s-1URL\s0 of the page that will return the \s-1UTC\s0 timestamp in \s-1ISO\s0 format. Example: https://time.akamai.com/?iso\*(R"
* **method** _method_  
  .IX Item "method method"
  Use the given \s-1HTTP\s0 method to create output files. Generally set to \s-1PUT\s0 or \s-1POST.\s0
* **-http\_user\_agent** _user\_agent_  
  .IX Item "-http_user_agent user_agent"
  Override User-Agent field in \s-1HTTP\s0 header. Applicable only for \s-1HTTP\s0 output.
* **-http\_persistent** _http\_persistent_  
  .IX Item "-http_persistent http_persistent"
  Use persistent \s-1HTTP\s0 connections. Applicable only for \s-1HTTP\s0 output.
* **-hls\_playlist** _hls\_playlist_  
  .IX Item "-hls_playlist hls_playlist"
  Generate \s-1HLS\s0 playlist files as well. The master playlist is generated with the filename master.m3u8.
  One media playlist file is generated for each stream with filenames media_0.m3u8, media_1.m3u8, etc.
* **-streaming** _streaming_  
  .IX Item "-streaming streaming"
  Enable (1) or disable (0) chunk streaming mode of output. In chunk streaming
  mode, each frame will be a moof fragment which forms a chunk.
* **-adaptation\_sets** _adaptation\_sets_  
  .IX Item "-adaptation_sets adaptation_sets"
  Assign streams to AdaptationSets. Syntax is id=x,streams=a,b,c id=y,streams=d,e\*(R" with x and y being the IDs
  of the adaptation sets and a,b,c,d and e are the indices of the mapped streams.
  .Sp
  To map all video (or audio) streams to an AdaptationSet, v\*(R" (or \*(L"a\*(R") can be used as stream identifier instead of IDs.
  .Sp
  When no assignment is defined, this defaults to an AdaptationSet for each stream.
* **-timeout** _timeout_  
  .IX Item "-timeout timeout"
  Set timeout for socket I/O operations. Applicable only for \s-1HTTP\s0 output.
* **-index\_correction** _index\_correction_  
  .IX Item "-index_correction index_correction"
  Enable (1) or Disable (0) segment index correction logic. Applicable only when
  _use\_template_ is enabled and _use\_timeline_ is disabled.
  .Sp
  When enabled, the logic monitors the flow of segment indexes. If a streams's
  segment index value is not at the expected real time position, then the logic
  corrects that index value.
  .Sp
  Typically this logic is needed in live streaming use cases. The network bandwidth
  fluctuations are common during long run streaming. Each fluctuation can cause
  the segment indexes fall behind the expected real time position.
* **-format\_options** _options\_list_  
  .IX Item "-format_options options_list"
  Set container format (mp4/webm) options using a \f(CW`:\*(C' separated list of
  key=value parameters. Values containing \f(CW`:\*(C' special characters must be
  escaped.
* **dash\_segment\_type** _dash\_segment\_type_  
  .IX Item "dash_segment_type dash_segment_type"
  Possible values:
* **mp4**  
  .IX Item "mp4"
  If this flag is set, the dash segment files will be in in \s-1ISOBMFF\s0 format. This is the default format.
* **webm**  
  .IX Item "webm"
  If this flag is set, the dash segment files will be in in WebM format.

<a name="framecrc"></a>

### framecrc

.IX Subsection "framecrc"
Per-packet \s-1CRC\s0 (Cyclic Redundancy Check) testing format.

This muxer computes and prints the Adler-32 \s-1CRC\s0 for each audio
and video packet. By default audio frames are converted to signed
16-bit raw audio and video frames to raw video before computing the
\s-1CRC.\s0

The output of the muxer consists of a line for each audio and video
packet of the form:

.Vb 1
        &lt;stream_index&gt;, &lt;packet_dts&gt;, &lt;packet_pts&gt;, &lt;packet_duration&gt;, &lt;packet_size&gt;, 0x&lt;CRC&gt;
.Ve

_\s-1CRC\s0_ is a hexadecimal number 0-padded to 8 digits containing the
\s-1CRC\s0 of the packet.

_Examples_
.IX Subsection "Examples"

For example to compute the \s-1CRC\s0 of the audio and video frames in
_\s-1INPUT\s0_, converted to raw audio and video packets, and store it
in the file _out.crc_:

.Vb 1
        ffmpeg -i INPUT -f framecrc out.crc
.Ve

To print the information to stdout, use the command:

.Vb 1
        ffmpeg -i INPUT -f framecrc -
.Ve

With **ffmpeg**, you can select the output format to which the
audio and video frames are encoded before computing the \s-1CRC\s0 for each
packet by specifying the audio and video codec. For example, to
compute the \s-1CRC\s0 of each decoded input audio frame converted to \s-1PCM\s0
unsigned 8-bit and of each decoded input video frame converted to
\s-1MPEG-2\s0 video, use the command:

.Vb 1
        ffmpeg -i INPUT -c:a pcm_u8 -c:v mpeg2video -f framecrc -
.Ve

See also the **crc** muxer.

<a name="framehash"></a>

### framehash

.IX Subsection "framehash"
Per-packet hash testing format.

This muxer computes and prints a cryptographic hash for each audio
and video packet. This can be used for packet-by-packet equality
checks without having to individually do a binary comparison on each.

By default audio frames are converted to signed 16-bit raw audio and
video frames to raw video before computing the hash, but the output
of explicit conversions to other codecs can also be used. It uses the
\s-1SHA-256\s0 cryptographic hash function by default, but supports several
other algorithms.

The output of the muxer consists of a line for each audio and video
packet of the form:

.Vb 1
        &lt;stream_index&gt;, &lt;packet_dts&gt;, &lt;packet_pts&gt;, &lt;packet_duration&gt;, &lt;packet_size&gt;, &lt;hash&gt;
.Ve

_hash_ is a hexadecimal number representing the computed hash
for the packet.

* **hash** _algorithm_  
  .IX Item "hash algorithm"
  Use the cryptographic hash function specified by the string _algorithm_.
  Supported values include \f(CW`MD5\*(C', \f(CW\*(C\`murmur3\*(C', \f(CW\*(C\`RIPEMD128\*(C',
  \f(CW`RIPEMD160\*(C', \f(CW\*(C\`RIPEMD256\*(C', \f(CW\*(C\`RIPEMD320\*(C', \f(CW\*(C\`SHA160\*(C',
  \f(CW`SHA224\*(C', \f(CW\*(C\`SHA256\*(C' (default), \f(CW\*(C\`SHA512/224\*(C', \f(CW\*(C\`SHA512/256\*(C',
  \f(CW`SHA384\*(C', \f(CW\*(C\`SHA512\*(C', \f(CW\*(C\`CRC32\*(C' and \f(CW\*(C\`adler32\*(C'.

_Examples_
.IX Subsection "Examples"

To compute the \s-1SHA-256\s0 hash of the audio and video frames in _\s-1INPUT\s0_,
converted to raw audio and video packets, and store it in the file
_out.sha256_:

.Vb 1
        ffmpeg -i INPUT -f framehash out.sha256
.Ve

To print the information to stdout, using the \s-1MD5\s0 hash function, use
the command:

.Vb 1
        ffmpeg -i INPUT -f framehash -hash md5 -
.Ve

See also the **hash** muxer.

<a name="framemd5"></a>

### framemd5

.IX Subsection "framemd5"
Per-packet \s-1MD5\s0 testing format.

This is a variant of the **framehash** muxer. Unlike that muxer,
it defaults to using the \s-1MD5\s0 hash function.

_Examples_
.IX Subsection "Examples"

To compute the \s-1MD5\s0 hash of the audio and video frames in _\s-1INPUT\s0_,
converted to raw audio and video packets, and store it in the file
_out.md5_:

.Vb 1
        ffmpeg -i INPUT -f framemd5 out.md5
.Ve

To print the information to stdout, use the command:

.Vb 1
        ffmpeg -i INPUT -f framemd5 -
.Ve

See also the **framehash** and **md5** muxers.

<a name="gif"></a>

### gif

.IX Subsection "gif"
Animated \s-1GIF\s0 muxer.

It accepts the following options:

* **loop**  
  .IX Item "loop"
  Set the number of times to loop the output. Use \f(CW`-1\*(C' for no loop, \f(CW0
  for looping indefinitely (default).
* **final\_delay**  
  .IX Item "final_delay"
  Force the delay (expressed in centiseconds) after the last frame. Each frame
  ends with a delay until the next frame. The default is \f(CW`-1\*(C', which is a
  special value to tell the muxer to re-use the previous delay. In case of a
  loop, you might want to customize this value to mark a pause for instance.

For example, to encode a gif looping 10 times, with a 5 seconds delay between
the loops:

.Vb 1
        ffmpeg -i INPUT -loop 10 -final_delay 500 out.gif
.Ve

Note 1: if you wish to extract the frames into separate \s-1GIF\s0 files, you need to
force the **image2** muxer:

.Vb 1
        ffmpeg -i INPUT -c:v gif -f image2 "out%d.gif"
.Ve

Note 2: the \s-1GIF\s0 format has a very large time base: the delay between two frames
can therefore not be smaller than one centi second.

<a name="hash"></a>

### hash

.IX Subsection "hash"
Hash testing format.

This muxer computes and prints a cryptographic hash of all the input
audio and video frames. This can be used for equality checks without
having to do a complete binary comparison.

By default audio frames are converted to signed 16-bit raw audio and
video frames to raw video before computing the hash, but the output
of explicit conversions to other codecs can also be used. Timestamps
are ignored. It uses the \s-1SHA-256\s0 cryptographic hash function by default,
but supports several other algorithms.

The output of the muxer consists of a single line of the form:
_algo_=_hash_, where _algo_ is a short string representing
the hash function used, and _hash_ is a hexadecimal number
representing the computed hash.

* **hash** _algorithm_  
  .IX Item "hash algorithm"
  Use the cryptographic hash function specified by the string _algorithm_.
  Supported values include \f(CW`MD5\*(C', \f(CW\*(C\`murmur3\*(C', \f(CW\*(C\`RIPEMD128\*(C',
  \f(CW`RIPEMD160\*(C', \f(CW\*(C\`RIPEMD256\*(C', \f(CW\*(C\`RIPEMD320\*(C', \f(CW\*(C\`SHA160\*(C',
  \f(CW`SHA224\*(C', \f(CW\*(C\`SHA256\*(C' (default), \f(CW\*(C\`SHA512/224\*(C', \f(CW\*(C\`SHA512/256\*(C',
  \f(CW`SHA384\*(C', \f(CW\*(C\`SHA512\*(C', \f(CW\*(C\`CRC32\*(C' and \f(CW\*(C\`adler32\*(C'.

_Examples_
.IX Subsection "Examples"

To compute the \s-1SHA-256\s0 hash of the input converted to raw audio and
video, and store it in the file _out.sha256_:

.Vb 1
        ffmpeg -i INPUT -f hash out.sha256
.Ve

To print an \s-1MD5\s0 hash to stdout use the command:

.Vb 1
        ffmpeg -i INPUT -f hash -hash md5 -
.Ve

See also the **framehash** muxer.

<a name="hls"></a>

### hls

.IX Subsection "hls"
Apple \s-1HTTP\s0 Live Streaming muxer that segments MPEG-TS according to
the \s-1HTTP\s0 Live Streaming (\s-1HLS\s0) specification.

It creates a playlist file, and one or more segment files. The output filename
specifies the playlist filename.

By default, the muxer creates a file for each segment produced. These files
have the same name as the playlist, followed by a sequential number and a
.ts extension.

Make sure to require a closed \s-1GOP\s0 when encoding and to set the \s-1GOP\s0
size to fit your segment time constraint.

For example, to convert an input file with **ffmpeg**:

.Vb 1
        ffmpeg -i in.mkv -c:v h264 -flags +cgop -g 30 -hls_time 1 out.m3u8
.Ve

This example will produce the playlist, _out.m3u8_, and segment files:
_out0.ts_, _out1.ts_, _out2.ts_, etc.

See also the **segment** muxer, which provides a more generic and
flexible implementation of a segmenter, and can be used to perform \s-1HLS\s0
segmentation.

_Options_
.IX Subsection "Options"

This muxer supports the following options:

* **hls\_init\_time** _seconds_  
  .IX Item "hls_init_time seconds"
  Set the initial target segment length in seconds. Default value is _0_.
  Segment will be cut on the next key frame after this time has passed on the first m3u8 list.
  After the initial playlist is filled **ffmpeg** will cut segments
  at duration equal to \f(CW`hls\_time\*(C'
* **hls\_time** _seconds_  
  .IX Item "hls_time seconds"
  Set the target segment length in seconds. Default value is 2.
  Segment will be cut on the next key frame after this time has passed.
* **hls\_list\_size** _size_  
  .IX Item "hls_list_size size"
  Set the maximum number of playlist entries. If set to 0 the list file
  will contain all the segments. Default value is 5.
* **hls\_delete\_threshold** _size_  
  .IX Item "hls_delete_threshold size"
  Set the number of unreferenced segments to keep on disk before \f(CW`hls_flags delete\_segments\*(C'
  deletes them. Increase this to allow continue clients to download segments which
  were recently referenced in the playlist. Default value is 1, meaning segments older than
  \f(CW`hls\_list\_size+1\*(C' will be deleted.
* **hls\_ts\_options** _options\_list_  
  .IX Item "hls_ts_options options_list"
  Set output format options using a :-separated list of key=value
  parameters. Values containing \f(CW`:\*(C' special characters must be
  escaped.
* **hls\_wrap** _wrap_  
  .IX Item "hls_wrap wrap"
  This is a deprecated option, you can use \f(CW`hls\_list\_size\*(C'
  and \f(CW`hls_flags delete\_segments\*(C' instead it
  .Sp
  This option is useful to avoid to fill the disk with many segment
  files, and limits the maximum number of segment files written to disk
  to _wrap_.
* **hls\_start\_number\_source**  
  .IX Item "hls_start_number_source"
  Start the playlist sequence number (\f(CW`#EXT-X-MEDIA-SEQUENCE\*(C') according to the specified source.
  Unless \f(CW`hls_flags single\_file\*(C' is set, it also specifies source of starting sequence numbers of
  segment and subtitle filenames. In any case, if \f(CW`hls_flags append\_list\*(C'
  is set and read playlist sequence number is greater than the specified start sequence number,
  then that value will be used as start value.
  .Sp
  It accepts the following values:
    * **generic (default)**  
      .IX Item "generic (default)"
      Set the starting sequence numbers according to _start\_number_ option value.
    * **epoch**  
      .IX Item "epoch"
      The start number will be the seconds since epoch (1970-01-01 00:00:00)
    * **datetime**  
      .IX Item "datetime"
      The start number will be based on the current date/time as YYYYmmddHHMMSS. e.g. 20161231235759.
* **start\_number** _number_  
  .IX Item "start_number number"
  Start the playlist sequence number (\f(CW`#EXT-X-MEDIA-SEQUENCE\*(C') from the specified _number_
  when _hls\_start\_number\_source_ value is _generic_. (This is the default case.)
  Unless \f(CW`hls_flags single\_file\*(C' is set, it also specifies starting sequence numbers of segment and subtitle filenames.
  Default value is 0.
* **hls\_allow\_cache** _allowcache_  
  .IX Item "hls_allow_cache allowcache"
  Explicitly set whether the client \s-1MAY\s0 (1) or \s-1MUST NOT\s0 (0) cache media segments.
* **hls\_base\_url** _baseurl_  
  .IX Item "hls_base_url baseurl"
  Append _baseurl_ to every entry in the playlist.
  Useful to generate playlists with absolute paths.
  .Sp
  Note that the playlist sequence number must be unique for each segment
  and it is not to be confused with the segment filename sequence number
  which can be cyclic, for example if the **wrap** option is
  specified.
* **hls\_segment\_filename** _filename_  
  .IX Item "hls_segment_filename filename"
  Set the segment filename. Unless \f(CW`hls_flags single\_file\*(C' is set,
  _filename_ is used as a string format with the segment number:
  .Sp
  .Vb 1
          ffmpeg -i in.nut -hls_segment_filename file%03d.ts\*(Aq out.m3u8
  .Ve
  .Sp
  This example will produce the playlist, _out.m3u8_, and segment files:
  _file000.ts_, _file001.ts_, _file002.ts_, etc.
  .Sp
  _filename_ may contain full path or relative path specification,
  but only the file name part without any path info will be contained in the m3u8 segment list.
  Should a relative path be specified, the path of the created segment
  files will be relative to the current working directory.
  When strftime_mkdir is set, the whole expanded value of _filename_ will be written into the m3u8 segment list.
  .Sp
  When \f(CW`var\_stream\_map\*(C' is set with two or more variant streams, the
  _filename_ pattern must contain the string %v\*(R", this string specifies
  the position of variant stream index in the generated segment file names.
  .Sp
  .Vb 3
          ffmpeg -i in.ts -b:v:0 1000k -b:v:1 256k -b:a:0 64k -b:a:1 32k \e
            -map 0:v -map 0:a -map 0:v -map 0:a -f hls -var_stream_map "v:0,a:0 v:1,a:1" \e
            -hls_segment_filename file_%v_%03d.ts\*(Aq out_%v.m3u8
  .Ve
  .Sp
  This example will produce the playlists segment file sets:
  _file\_0\_000.ts_, _file\_0\_001.ts_, _file\_0\_002.ts_, etc. and
  _file\_1\_000.ts_, _file\_1\_001.ts_, _file\_1\_002.ts_, etc.
  .Sp
  The string %v\*(R" may be present in the filename or in the last directory name
  containing the file. If the string is present in the directory name, then
  sub-directories are created after expanding the directory name pattern. This
  enables creation of segments corresponding to different variant streams in
  subdirectories.
  .Sp
  .Vb 3
          ffmpeg -i in.ts -b:v:0 1000k -b:v:1 256k -b:a:0 64k -b:a:1 32k \e
            -map 0:v -map 0:a -map 0:v -map 0:a -f hls -var_stream_map "v:0,a:0 v:1,a:1" \e
            -hls_segment_filename vs%v/file_%03d.ts\*(Aq vs%v/out.m3u8
  .Ve
  .Sp
  This example will produce the playlists segment file sets:
  _vs0/file\_000.ts_, _vs0/file\_001.ts_, _vs0/file\_002.ts_, etc. and
  _vs1/file\_000.ts_, _vs1/file\_001.ts_, _vs1/file\_002.ts_, etc.
* **use\_localtime**  
  .IX Item "use_localtime"
  Same as strftime option, will be deprecated.
* **strftime**  
  .IX Item "strftime"
  Use **strftime()** on _filename_ to expand the segment filename with localtime.
  The segment number is also available in this mode, but to use it, you need to specify second_level_segment_index
  hls_flag and %%d will be the specifier.
  .Sp
  .Vb 1
          ffmpeg -i in.nut -strftime 1 -hls_segment_filename file-%Y%m%d-%s.ts\*(Aq out.m3u8
  .Ve
  .Sp
  This example will produce the playlist, _out.m3u8_, and segment files:
  _file-20160215-1455569023.ts_, _file-20160215-1455569024.ts_, etc.
  Note: On some systems/environments, the \f(CW%s specifier is not available. See
    \f(CW`strftime()\*(C' documentation.
  .Sp
  .Vb 1
          ffmpeg -i in.nut -strftime 1 -hls_flags second_level_segment_index -hls_segment_filename file-%Y%m%d-%%04d.ts\*(Aq out.m3u8
  .Ve
  .Sp
  This example will produce the playlist, _out.m3u8_, and segment files:
  _file-20160215-0001.ts_, _file-20160215-0002.ts_, etc.
* **use\_localtime\_mkdir**  
  .IX Item "use_localtime_mkdir"
  Same as strftime_mkdir option, will be deprecated .
* **strftime\_mkdir**  
  .IX Item "strftime_mkdir"
  Used together with -strftime_mkdir, it will create all subdirectories which
  is expanded in _filename_.
  .Sp
  .Vb 1
          ffmpeg -i in.nut -strftime 1 -strftime_mkdir 1 -hls_segment_filename %Y%m%d/file-%Y%m%d-%s.ts\*(Aq out.m3u8
  .Ve
  .Sp
  This example will create a directory 201560215 (if it does not exist), and then
  produce the playlist, _out.m3u8_, and segment files:
  _20160215/file-20160215-1455569023.ts_, _20160215/file-20160215-1455569024.ts_, etc.
  .Sp
  .Vb 1
          ffmpeg -i in.nut -strftime 1 -strftime_mkdir 1 -hls_segment_filename %Y/%m/%d/file-%Y%m%d-%s.ts\*(Aq out.m3u8
  .Ve
  .Sp
  This example will create a directory hierarchy 2016/02/15 (if any of them do not exist), and then
  produce the playlist, _out.m3u8_, and segment files:
  _2016/02/15/file-20160215-1455569023.ts_, _2016/02/15/file-20160215-1455569024.ts_, etc.
* **hls\_key\_info\_file** _key\_info\_file_  
  .IX Item "hls_key_info_file key_info_file"
  Use the information in _key\_info\_file_ for segment encryption. The first
  line of _key\_info\_file_ specifies the key \s-1URI\s0 written to the playlist. The
  key \s-1URL\s0 is used to access the encryption key during playback. The second line
  specifies the path to the key file used to obtain the key during the encryption
  process. The key file is read as a single packed array of 16 octets in binary
  format. The optional third line specifies the initialization vector (\s-1IV\s0) as a
  hexadecimal string to be used instead of the segment sequence number (default)
  for encryption. Changes to _key\_info\_file_ will result in segment
  encryption with the new key/IV and an entry in the playlist for the new key
  \s-1URI/IV\s0 if \f(CW`hls_flags periodic\_rekey\*(C' is enabled.
  .Sp
  Key info file format:
  .Sp
  .Vb 3
          &lt;key URI&gt;
          &lt;key file path&gt;
          &lt;IV&gt; (optional)
  .Ve
  .Sp
  Example key URIs:
  .Sp
  .Vb 3
          http://server/file.key
          /path/to/file.key
          file.key
  .Ve
  .Sp
  Example key file paths:
  .Sp
  .Vb 2
          file.key
          /path/to/file.key
  .Ve
  .Sp
  Example \s-1IV:\s0
  .Sp
  .Vb 1
          0123456789ABCDEF0123456789ABCDEF
  .Ve
  .Sp
  Key info file example:
  .Sp
  .Vb 3
          http://server/file.key
          /path/to/file.key
          0123456789ABCDEF0123456789ABCDEF
  .Ve
  .Sp
  Example shell script:
  .Sp
  .Vb 8
          #!/bin/sh
          BASE_URL=${1:-.\*(Aq}
          openssl rand 16 &gt; file.key
          echo $BASE_URL/file.key &gt; file.keyinfo
          echo file.key &gt;&gt; file.keyinfo
          echo $(openssl rand -hex 16) &gt;&gt; file.keyinfo
          ffmpeg -f lavfi -re -i testsrc -c:v h264 -hls_flags delete_segments \e
            -hls_key_info_file file.keyinfo out.m3u8
  .Ve
* **-hls\_enc** _enc_  
  .IX Item "-hls_enc enc"
  Enable (1) or disable (0) the \s-1AES128\s0 encryption.
  When enabled every segment generated is encrypted and the encryption key
  is saved as _playlist name_.key.
* **-hls\_enc\_key** _key_  
  .IX Item "-hls_enc_key key"
  Hex-coded 16byte key to encrypt the segments, by default it
  is randomly generated.
* **-hls\_enc\_key\_url** _keyurl_  
  .IX Item "-hls_enc_key_url keyurl"
  If set, _keyurl_ is prepended instead of _baseurl_ to the key filename
  in the playlist.
* **-hls\_enc\_iv** _iv_  
  .IX Item "-hls_enc_iv iv"
  Hex-coded 16byte initialization vector for every segment instead
  of the autogenerated ones.
* **hls\_segment\_type** _flags_  
  .IX Item "hls_segment_type flags"
  Possible values:
    * **mpegts**  
      .IX Item "mpegts"
      Output segment files in \s-1MPEG-2\s0 Transport Stream format. This is
      compatible with all \s-1HLS\s0 versions.
    * **fmp4**  
      .IX Item "fmp4"
      Output segment files in fragmented \s-1MP4\s0 format, similar to MPEG-DASH.
      fmp4 files may be used in \s-1HLS\s0 version 7 and above.
* **hls\_fmp4\_init\_filename** _filename_  
  .IX Item "hls_fmp4_init_filename filename"
  Set filename to the fragment files header file, default filename is _init.mp4_.
  .Sp
  When \f(CW`var\_stream\_map\*(C' is set with two or more variant streams, the
  _filename_ pattern must contain the string %v\*(R", this string specifies
  the position of variant stream index in the generated init file names.
  The string %v\*(R" may be present in the filename or in the last directory name
  containing the file. If the string is present in the directory name, then
  sub-directories are created after expanding the directory name pattern. This
  enables creation of init files corresponding to different variant streams in
  subdirectories.
* **hls\_flags** _flags_  
  .IX Item "hls_flags flags"
  Possible values:
    * **single\_file**  
      .IX Item "single_file"
      If this flag is set, the muxer will store all segments in a single MPEG-TS
      file, and will use byte ranges in the playlist. \s-1HLS\s0 playlists generated with
      this way will have the version number 4.
      For example:
      .Sp
      .Vb 1
              ffmpeg -i in.nut -hls_flags single_file out.m3u8
      .Ve
      .Sp
      Will produce the playlist, _out.m3u8_, and a single segment file,
      _out.ts_.
    * **delete\_segments**  
      .IX Item "delete_segments"
      Segment files removed from the playlist are deleted after a period of time
      equal to the duration of the segment plus the duration of the playlist.
    * **append\_list**  
      .IX Item "append_list"
      Append new segments into the end of old segment list,
      and remove the \f(CW`#EXT-X-ENDLIST\*(C' from the old segment list.
    * **round\_durations**  
      .IX Item "round_durations"
      Round the duration info in the playlist file segment info to integer
      values, instead of using floating point.
    * **discont\_start**  
      .IX Item "discont_start"
      Add the \f(CW`#EXT-X-DISCONTINUITY\*(C' tag to the playlist, before the
      first segment's information.
    * **omit\_endlist**  
      .IX Item "omit_endlist"
      Do not append the \f(CW`EXT-X-ENDLIST\*(C' tag at the end of the playlist.
    * **periodic\_rekey**  
      .IX Item "periodic_rekey"
      The file specified by \f(CW`hls\_key\_info\_file\*(C' will be checked periodically and
      detect updates to the encryption info. Be sure to replace this file atomically,
      including the file containing the \s-1AES\s0 encryption key.
    * **independent\_segments**  
      .IX Item "independent_segments"
      Add the \f(CW`#EXT-X-INDEPENDENT-SEGMENTS\*(C' to playlists that has video segments
      and when all the segments of that playlist are guaranteed to start with a Key frame.
    * **split\_by\_time**  
      .IX Item "split_by_time"
      Allow segments to start on frames other than keyframes. This improves
      behavior on some players when the time between keyframes is inconsistent,
      but may make things worse on others, and can cause some oddities during
      seeking. This flag should be used with the \f(CW`hls\_time\*(C' option.
    * **program\_date\_time**  
      .IX Item "program_date_time"
      Generate \f(CW`EXT-X-PROGRAM-DATE-TIME\*(C' tags.
    * **second\_level\_segment\_index**  
      .IX Item "second_level_segment_index"
      Makes it possible to use segment indexes as %%d in hls_segment_filename expression
      besides date/time values when strftime is on.
      To get fixed width numbers with trailing zeroes, %%0xd format is available where x is the required width.
    * **second\_level\_segment\_size**  
      .IX Item "second_level_segment_size"
      Makes it possible to use segment sizes (counted in bytes) as %%s in hls_segment_filename
      expression besides date/time values when strftime is on.
      To get fixed width numbers with trailing zeroes, %%0xs format is available where x is the required width.
    * **second\_level\_segment\_duration**  
      .IX Item "second_level_segment_duration"
      Makes it possible to use segment duration (calculated  in microseconds) as %%t in hls_segment_filename
      expression besides date/time values when strftime is on.
      To get fixed width numbers with trailing zeroes, %%0xt format is available where x is the required width.
      .Sp
      .Vb 4
              ffmpeg -i sample.mpeg \e
                 -f hls -hls_time 3 -hls_list_size 5 \e
                 -hls_flags second_level_segment_index+second_level_segment_size+second_level_segment_duration \e
                 -strftime 1 -strftime_mkdir 1 -hls_segment_filename "segment_%Y%m%d%H%M%S_%%04d_%%08s_%%013t.ts" stream.m3u8
      .Ve
      .Sp
      This will produce segments like this:
      _segment\_20170102194334\_0003\_00122200\_0000003000000.ts_, _segment\_20170102194334\_0004\_00120072\_0000003000000.ts_ etc.
    * **temp\_file**  
      .IX Item "temp_file"
      Write segment data to filename.tmp and rename to filename only once the segment is complete. A webserver
      serving up segments can be configured to reject requests to *.tmp to prevent access to in-progress segments
      before they have been added to the m3u8 playlist.
* **hls_playlist_type event**  
  .IX Item "hls_playlist_type event"
  Emit \f(CW`#EXT-X-PLAYLIST-TYPE:EVENT\*(C' in the m3u8 header. Forces
  **hls\_list\_size** to 0; the playlist can only be appended to.
* **hls_playlist_type vod**  
  .IX Item "hls_playlist_type vod"
  Emit \f(CW`#EXT-X-PLAYLIST-TYPE:VOD\*(C' in the m3u8 header. Forces
  **hls\_list\_size** to 0; the playlist must not change.
* **method**  
  .IX Item "method"
  Use the given \s-1HTTP\s0 method to create the hls files.
  .Sp
  .Vb 1
          ffmpeg -re -i in.ts -f hls -method PUT http://example.com/live/out.m3u8
  .Ve
  .Sp
  This example will upload all the mpegts segment files to the \s-1HTTP\s0
  server using the \s-1HTTP PUT\s0 method, and update the m3u8 files every
  \f(CW`refresh\*(C' times using the same method.
  Note that the \s-1HTTP\s0 server must support the given method for uploading
  files.
* **http\_user\_agent**  
  .IX Item "http_user_agent"
  Override User-Agent field in \s-1HTTP\s0 header. Applicable only for \s-1HTTP\s0 output.
* **var\_stream\_map**  
  .IX Item "var_stream_map"
  Map string which specifies how to group the audio, video and subtitle streams
  into different variant streams. The variant stream groups are separated
  by space.
  Expected string format is like this a:0,v:0 a:1,v:1 ....\*(R". Here a:, v:, s: are
  the keys to specify audio, video and subtitle streams respectively.
  Allowed values are 0 to 9 (limited just based on practical usage).
  .Sp
  When there are two or more variant streams, the output filename pattern must
  contain the string %v\*(R", this string specifies the position of variant stream
  index in the output media playlist filenames. The string %v\*(R" may be present in
  the filename or in the last directory name containing the file. If the string is
  present in the directory name, then sub-directories are created after expanding
  the directory name pattern. This enables creation of variant streams in
  subdirectories.
  .Sp
  .Vb 3
          ffmpeg -re -i in.ts -b:v:0 1000k -b:v:1 256k -b:a:0 64k -b:a:1 32k \e
            -map 0:v -map 0:a -map 0:v -map 0:a -f hls -var_stream_map "v:0,a:0 v:1,a:1" \e
            http://example.com/live/out_%v.m3u8
  .Ve
  .Sp
  This example creates two hls variant streams. The first variant stream will
  contain video stream of bitrate 1000k and audio stream of bitrate 64k and the
  second variant stream will contain video stream of bitrate 256k and audio
  stream of bitrate 32k. Here, two media playlist with file names out_0.m3u8 and
  out_1.m3u8 will be created.
  .Sp
  .Vb 3
          ffmpeg -re -i in.ts -b:v:0 1000k -b:v:1 256k -b:a:0 64k \e
            -map 0:v -map 0:a -map 0:v -f hls -var_stream_map "v:0 a:0 v:1" \e
            http://example.com/live/out_%v.m3u8
  .Ve
  .Sp
  This example creates three hls variant streams. The first variant stream will
  be a video only stream with video bitrate 1000k, the second variant stream will
  be an audio only stream with bitrate 64k and the third variant stream will be a
  video only stream with bitrate 256k. Here, three media playlist with file names
  out_0.m3u8, out_1.m3u8 and out_2.m3u8 will be created.
  .Sp
  .Vb 3
          ffmpeg -re -i in.ts -b:v:0 1000k -b:v:1 256k -b:a:0 64k -b:a:1 32k \e
            -map 0:v -map 0:a -map 0:v -map 0:a -f hls -var_stream_map "v:0,a:0 v:1,a:1" \e
            http://example.com/live/vs_%v/out.m3u8
  .Ve
  .Sp
  This example creates the variant streams in subdirectories. Here, the first
  media playlist is created at _http://example.com/live/vs\_0/out.m3u8_ and
  the second one at _http://example.com/live/vs\_1/out.m3u8_.
  .Sp
  .Vb 5
          ffmpeg -re -i in.ts -b:a:0 32k -b:a:1 64k -b:v:0 1000k -b:v:1 3000k  \e
            -map 0:a -map 0:a -map 0:v -map 0:v -f hls \e
            -var_stream_map "a:0,agroup:aud_low a:1,agroup:aud_high v:0,agroup:aud_low v:1,agroup:aud_high" \e
            -master_pl_name master.m3u8 \e
            http://example.com/live/out_%v.m3u8
  .Ve
  .Sp
  This example creates two audio only and two video only variant streams. In
  addition to the #EXT-X-STREAM-INF tag for each variant stream in the master
  playlist, #EXT-X-MEDIA tag is also added for the two audio only variant streams
  and they are mapped to the two video only variant streams with audio group names
  'aud_low' and 'aud_high'.
  .Sp
  By default, a single hls variant containing all the encoded streams is created.
* **cc\_stream\_map**  
  .IX Item "cc_stream_map"
  Map string which specifies different closed captions groups and their
  attributes. The closed captions stream groups are separated by space.
  Expected string format is like this
  ccgroup:&lt;group name&gt;,instreamid:&lt;\s-1INSTREAM-ID\s0&gt;,language:&lt;language code&gt; ....\*(R".
  'ccgroup' and 'instreamid' are mandatory attributes. 'language' is an optional
  attribute.
  The closed captions groups configured using this option are mapped to different
  variant streams by providing the same 'ccgroup' name in the
  \f(CW`var\_stream\_map\*(C' string. If \f(CW\*(C\`var\_stream\_map\*(C' is not set, then the
  first available ccgroup in \f(CW`cc\_stream\_map\*(C' is mapped to the output variant
  stream. The examples for these two use cases are given below.
  .Sp
  .Vb 4
          ffmpeg -re -i in.ts -b:v 1000k -b:a 64k -a53cc 1 -f hls \e
            -cc_stream_map "ccgroup:cc,instreamid:CC1,language:en" \e
            -master_pl_name master.m3u8 \e
            http://example.com/live/out.m3u8
  .Ve
  .Sp
  This example adds \f(CW`#EXT-X-MEDIA\*(C' tag with \f(CW\*(C\`TYPE=CLOSED-CAPTIONS\*(C' in
  the master playlist with group name 'cc', langauge 'en' (english) and
  INSTREAM-ID '\s-1CC1\s0'. Also, it adds \f(CW`CLOSED-CAPTIONS\*(C' attribute with group
  name 'cc' for the output variant stream.
  .Sp
  .Vb 7
          ffmpeg -re -i in.ts -b:v:0 1000k -b:v:1 256k -b:a:0 64k -b:a:1 32k \e
            -a53cc:0 1 -a53cc:1 1\e
            -map 0:v -map 0:a -map 0:v -map 0:a -f hls \e
            -cc_stream_map "ccgroup:cc,instreamid:CC1,language:en ccgroup:cc,instreamid:CC2,language:sp" \e
            -var_stream_map "v:0,a:0,ccgroup:cc v:1,a:1,ccgroup:cc" \e
            -master_pl_name master.m3u8 \e
            http://example.com/live/out_%v.m3u8
  .Ve
  .Sp
  This example adds two \f(CW`#EXT-X-MEDIA\*(C' tags with \f(CW\*(C\`TYPE=CLOSED-CAPTIONS\*(C' in
  the master playlist for the INSTREAM-IDs '\s-1CC1\s0' and '\s-1CC2\s0'. Also, it adds
  \f(CW`CLOSED-CAPTIONS\*(C' attribute with group name 'cc' for the two output variant
  streams.
* **master\_pl\_name**  
  .IX Item "master_pl_name"
  Create \s-1HLS\s0 master playlist with the given name.
  .Sp
  .Vb 1
          ffmpeg -re -i in.ts -f hls -master_pl_name master.m3u8 http://example.com/live/out.m3u8
  .Ve
  .Sp
  This example creates \s-1HLS\s0 master playlist with name master.m3u8 and it is
  published at http://example.com/live/
* **master\_pl\_publish\_rate**  
  .IX Item "master_pl_publish_rate"
  Publish master play list repeatedly every after specified number of segment intervals.
  .Sp
  .Vb 2
          ffmpeg -re -i in.ts -f hls -master_pl_name master.m3u8 \e
          -hls_time 2 -master_pl_publish_rate 30 http://example.com/live/out.m3u8
  .Ve
  .Sp
  This example creates \s-1HLS\s0 master playlist with name master.m3u8 and keep
  publishing it repeatedly every after 30 segments i.e. every after 60s.
* **http\_persistent**  
  .IX Item "http_persistent"
  Use persistent \s-1HTTP\s0 connections. Applicable only for \s-1HTTP\s0 output.
* **timeout**  
  .IX Item "timeout"
  Set timeout for socket I/O operations. Applicable only for \s-1HTTP\s0 output.

<a name="ico"></a>

### ico

.IX Subsection "ico"
\s-1ICO\s0 file muxer.

Microsoft's icon file format (\s-1ICO\s0) has some strict limitations that should be noted:

* ·  
  Size cannot exceed 256 pixels in any dimension
* ·  
  Only \s-1BMP\s0 and \s-1PNG\s0 images can be stored
* ·  
  If a \s-1BMP\s0 image is used, it must be one of the following pixel formats:
  .Sp
  .Vb 7
          BMP Bit Depth      FFmpeg Pixel Format
          1bit               pal8
          4bit               pal8
          8bit               pal8
          16bit              rgb555le
          24bit              bgr24
          32bit              bgra
  .Ve
* ·  
  If a \s-1BMP\s0 image is used, it must use the \s-1BITMAPINFOHEADER DIB\s0 header
* ·  
  If a \s-1PNG\s0 image is used, it must use the rgba pixel format

<a name="image2"></a>

### image2

.IX Subsection "image2"
Image file muxer.

The image file muxer writes video frames to image files.

The output filenames are specified by a pattern, which can be used to
produce sequentially numbered series of files.
The pattern may contain the string %d\*(R" or "%0_N_d\*(L", this string
specifies the position of the characters representing a numbering in
the filenames. If the form %0_N_d" is used, the string
representing the number in each filename is 0-padded to _N_
digits. The literal character '%' can be specified in the pattern with
the string %%\*(R".

If the pattern contains %d\*(R" or "%0_N_d", the first filename of
the file list specified will contain the number 1, all the following
numbers will be sequential.

The pattern may contain a suffix which is used to automatically
determine the format of the image files to write.

For example the pattern img-%03d.bmp\*(R" will specify a sequence of
filenames of the form _img-001.bmp_, _img-002.bmp_, ...,
_img-010.bmp_, etc.
The pattern img%%-%d.jpg\*(R" will specify a sequence of filenames of the
form _img%-1.jpg_, _img%-2.jpg_, ..., _img%-10.jpg_,
etc.

_Examples_
.IX Subsection "Examples"

The following example shows how to use **ffmpeg** for creating a
sequence of files _img-001.jpeg_, _img-002.jpeg_, ...,
taking one image every second from the input video:

.Vb 1
        ffmpeg -i in.avi -vsync cfr -r 1 -f image2 img-%03d.jpeg\*(Aq
.Ve

Note that with **ffmpeg**, if the format is not specified with the
\f(CW`-f\*(C' option and the output filename specifies an image file
format, the image2 muxer is automatically selected, so the previous
command can be written as:

.Vb 1
        ffmpeg -i in.avi -vsync cfr -r 1 img-%03d.jpeg\*(Aq
.Ve

Note also that the pattern must not necessarily contain %d\*(R" or
"%0_N_d", for example to create a single image file
_img.jpeg_ from the start of the input video you can employ the command:

.Vb 1
        ffmpeg -i in.avi -f image2 -frames:v 1 img.jpeg
.Ve

The **strftime** option allows you to expand the filename with
date and time information. Check the documentation of
the \f(CW`strftime()\*(C' function for the syntax.

For example to generate image files from the \f(CW`strftime()\*(C'
%Y-%m-%d_%H-%M-%S\*(R" pattern, the following **ffmpeg** command
can be used:

.Vb 1
        ffmpeg -f v4l2 -r 1 -i /dev/video0 -f image2 -strftime 1 "%Y-%m-%d_%H-%M-%S.jpg"
.Ve

You can set the file name with current frame's \s-1PTS:\s0

.Vb 1
        ffmpeg -f v4l2 -r 1 -i /dev/video0 -copyts -f image2 -frame_pts true %d.jpg"
.Ve

_Options_
.IX Subsection "Options"

* **frame\_pts**  
  .IX Item "frame_pts"
  If set to 1, expand the filename with pts from pkt-&gt;pts.
  Default value is 0.
* **start\_number**  
  .IX Item "start_number"
  Start the sequence from the specified number. Default value is 1.
* **update**  
  .IX Item "update"
  If set to 1, the filename will always be interpreted as just a
  filename, not a pattern, and the corresponding file will be continuously
  overwritten with new images. Default value is 0.
* **strftime**  
  .IX Item "strftime"
  If set to 1, expand the filename with date and time information from
  \f(CW`strftime()\*(C'. Default value is 0.

The image muxer supports the .Y.U.V image file format. This format is
special in that that each image frame consists of three files, for
each of the \s-1YUV420P\s0 components. To read or write this image file format,
specify the name of the '.Y' file. The muxer will automatically open the
'.U' and '.V' files as required.

<a name="matroska"></a>

### matroska

.IX Subsection "matroska"
Matroska container muxer.

This muxer implements the matroska and webm container specs.

_Metadata_
.IX Subsection "Metadata"

The recognized metadata settings in this muxer are:

* **title**  
  .IX Item "title"
  Set title name provided to a single track.
* **language**  
  .IX Item "language"
  Specify the language of the track in the Matroska languages form.
  .Sp
  The language can be either the 3 letters bibliographic \s-1ISO-639-2\s0 (\s-1ISO
  639-2/B\s0) form (like fre\*(R" for French), or a language code mixed with a
  country code for specialities in languages (like fre-ca\*(R" for Canadian
  French).
* **stereo\_mode**  
  .IX Item "stereo_mode"
  Set stereo 3D video layout of two views in a single video track.
  .Sp
  The following values are recognized:
    * **mono**  
      .IX Item "mono"
      video is not stereo
    * **left\_right**  
      .IX Item "left_right"
      Both views are arranged side by side, Left-eye view is on the left
    * **bottom\_top**  
      .IX Item "bottom_top"
      Both views are arranged in top-bottom orientation, Left-eye view is at bottom
    * **top\_bottom**  
      .IX Item "top_bottom"
      Both views are arranged in top-bottom orientation, Left-eye view is on top
    * **checkerboard\_rl**  
      .IX Item "checkerboard_rl"
      Each view is arranged in a checkerboard interleaved pattern, Left-eye view being first
    * **checkerboard\_lr**  
      .IX Item "checkerboard_lr"
      Each view is arranged in a checkerboard interleaved pattern, Right-eye view being first
    * **row\_interleaved\_rl**  
      .IX Item "row_interleaved_rl"
      Each view is constituted by a row based interleaving, Right-eye view is first row
    * **row\_interleaved\_lr**  
      .IX Item "row_interleaved_lr"
      Each view is constituted by a row based interleaving, Left-eye view is first row
    * **col\_interleaved\_rl**  
      .IX Item "col_interleaved_rl"
      Both views are arranged in a column based interleaving manner, Right-eye view is first column
    * **col\_interleaved\_lr**  
      .IX Item "col_interleaved_lr"
      Both views are arranged in a column based interleaving manner, Left-eye view is first column
    * **anaglyph\_cyan\_red**  
      .IX Item "anaglyph_cyan_red"
      All frames are in anaglyph format viewable through red-cyan filters
    * **right\_left**  
      .IX Item "right_left"
      Both views are arranged side by side, Right-eye view is on the left
    * **anaglyph\_green\_magenta**  
      .IX Item "anaglyph_green_magenta"
      All frames are in anaglyph format viewable through green-magenta filters
    * **block\_lr**  
      .IX Item "block_lr"
      Both eyes laced in one Block, Left-eye view is first
    * **block\_rl**  
      .IX Item "block_rl"
      Both eyes laced in one Block, Right-eye view is first

For example a 3D WebM clip can be created using the following command line:

.Vb 1
        ffmpeg -i sample_left_right_clip.mpg -an -c:v libvpx -metadata stereo_mode=left_right -y stereo_clip.webm
.Ve

_Options_
.IX Subsection "Options"

This muxer supports the following options:

* **reserve\_index\_space**  
  .IX Item "reserve_index_space"
  By default, this muxer writes the index for seeking (called cues in Matroska
  terms) at the end of the file, because it cannot know in advance how much space
  to leave for the index at the beginning of the file. However for some use cases
   e.g.  streaming where seeking is possible but slow \*(-- it is useful to put the
  index at the beginning of the file.
  .Sp
  If this option is set to a non-zero value, the muxer will reserve a given amount
  of space in the file header and then try to write the cues there when the muxing
  finishes. If the available space does not suffice, muxing will fail. A safe size
  for most use cases should be about 50kB per hour of video.
  .Sp
  Note that cues are only written if the output is seekable and this option will
  have no effect if it is not.

<a name="md5"></a>

### md5

.IX Subsection "md5"
\s-1MD5\s0 testing format.

This is a variant of the **hash** muxer. Unlike that muxer, it
defaults to using the \s-1MD5\s0 hash function.

_Examples_
.IX Subsection "Examples"

To compute the \s-1MD5\s0 hash of the input converted to raw
audio and video, and store it in the file _out.md5_:

.Vb 1
        ffmpeg -i INPUT -f md5 out.md5
.Ve

You can print the \s-1MD5\s0 to stdout with the command:

.Vb 1
        ffmpeg -i INPUT -f md5 -
.Ve

See also the **hash** and **framemd5** muxers.

<a name="mov-mp4-ismv"></a>

### mov, mp4, ismv

.IX Subsection "mov, mp4, ismv"
\s-1MOV/MP4/ISMV\s0 (Smooth Streaming) muxer.

The mov/mp4/ismv muxer supports fragmentation. Normally, a \s-1MOV/MP4\s0
file has all the metadata about all packets stored in one location
(written at the end of the file, it can be moved to the start for
better playback by adding _faststart_ to the _movflags_, or
using the **qt-faststart** tool). A fragmented
file consists of a number of fragments, where packets and metadata
about these packets are stored together. Writing a fragmented
file has the advantage that the file is decodable even if the
writing is interrupted (while a normal \s-1MOV/MP4\s0 is undecodable if
it is not properly finished), and it requires less memory when writing
very long files (since writing normal \s-1MOV/MP4\s0 files stores info about
every single packet in memory until the file is closed). The downside
is that it is less compatible with other applications.

_Options_
.IX Subsection "Options"

Fragmentation is enabled by setting one of the AVOptions that define
how to cut the file into fragments:

* **-moov\_size** _bytes_  
  .IX Item "-moov_size bytes"
  Reserves space for the moov atom at the beginning of the file instead of placing the
  moov atom at the end. If the space reserved is insufficient, muxing will fail.
* **-movflags frag\_keyframe**  
  .IX Item "-movflags frag_keyframe"
  Start a new fragment at each video keyframe.
* **-frag\_duration** _duration_  
  .IX Item "-frag_duration duration"
  Create fragments that are _duration_ microseconds long.
* **-frag\_size** _size_  
  .IX Item "-frag_size size"
  Create fragments that contain up to _size_ bytes of payload data.
* **-movflags frag\_custom**  
  .IX Item "-movflags frag_custom"
  Allow the caller to manually choose when to cut fragments, by
  calling \f(CW`av_write_frame(ctx, NULL)\*(C' to write a fragment with
  the packets written so far. (This is only useful with other
  applications integrating libavformat, not from **ffmpeg**.)
* **-min\_frag\_duration** _duration_  
  .IX Item "-min_frag_duration duration"
  Don't create fragments that are shorter than _duration_ microseconds long.

If more than one condition is specified, fragments are cut when
one of the specified conditions is fulfilled. The exception to this is
\f(CW`-min\_frag\_duration\*(C', which has to be fulfilled for any of the other
conditions to apply.

Additionally, the way the output file is written can be adjusted
through a few other options:

* **-movflags empty\_moov**  
  .IX Item "-movflags empty_moov"
  Write an initial moov atom directly at the start of the file, without
  describing any samples in it. Generally, an mdat/moov pair is written
  at the start of the file, as a normal \s-1MOV/MP4\s0 file, containing only
  a short portion of the file. With this option set, there is no initial
  mdat atom, and the moov atom only describes the tracks but has
  a zero duration.
  .Sp
  This option is implicitly set when writing ismv (Smooth Streaming) files.
* **-movflags separate\_moof**  
  .IX Item "-movflags separate_moof"
  Write a separate moof (movie fragment) atom for each track. Normally,
  packets for all tracks are written in a moof atom (which is slightly
  more efficient), but with this option set, the muxer writes one moof/mdat
  pair for each track, making it easier to separate tracks.
  .Sp
  This option is implicitly set when writing ismv (Smooth Streaming) files.
* **-movflags faststart**  
  .IX Item "-movflags faststart"
  Run a second pass moving the index (moov atom) to the beginning of the file.
  This operation can take a while, and will not work in various situations such
  as fragmented output, thus it is not enabled by default.
* **-movflags rtphint**  
  .IX Item "-movflags rtphint"
  Add \s-1RTP\s0 hinting tracks to the output file.
* **-movflags disable\_chpl**  
  .IX Item "-movflags disable_chpl"
  Disable Nero chapter markers (chpl atom).  Normally, both Nero chapters
  and a QuickTime chapter track are written to the file. With this option
  set, only the QuickTime chapter track will be written. Nero chapters can
  cause failures when the file is reprocessed with certain tagging programs, like
  mp3Tag 2.61a and iTunes 11.3, most likely other versions are affected as well.
* **-movflags omit\_tfhd\_offset**  
  .IX Item "-movflags omit_tfhd_offset"
  Do not write any absolute base_data_offset in tfhd atoms. This avoids
  tying fragments to absolute byte positions in the file/streams.
* **-movflags default\_base\_moof**  
  .IX Item "-movflags default_base_moof"
  Similarly to the omit_tfhd_offset, this flag avoids writing the
  absolute base_data_offset field in tfhd atoms, but does so by using
  the new default-base-is-moof flag instead. This flag is new from
  14496-12:2012. This may make the fragments easier to parse in certain
  circumstances (avoiding basing track fragment location calculations
  on the implicit end of the previous track fragment).
* **-write\_tmcd**  
  .IX Item "-write_tmcd"
  Specify \f(CW`on\*(C' to force writing a timecode track, \f(CW\*(C\`off\*(C' to disable it
  and \f(CW`auto\*(C' to write a timecode track only for mov and mp4 output (default).
* **-movflags negative\_cts\_offsets**  
  .IX Item "-movflags negative_cts_offsets"
  Enables utilization of version 1 of the \s-1CTTS\s0 box, in which the \s-1CTS\s0 offsets can
  be negative. This enables the initial sample to have \s-1DTS/CTS\s0 of zero, and
  reduces the need for edit lists for some cases such as video tracks with
  B-frames. Additionally, eases conformance with the DASH-IF interoperability
  guidelines.
  .Sp
  This option is implicitly set when writing ismv (Smooth Streaming) files.
* **-write\_prft**  
  .IX Item "-write_prft"
  Write producer time reference box (\s-1PRFT\s0) with a specified time source for the
  \s-1NTP\s0 field in the \s-1PRFT\s0 box. Set value as **wallclock** to specify timesource
  as wallclock time and **pts** to specify timesource as input packets' \s-1PTS\s0
  values.
  .Sp
  Setting value to **pts** is applicable only for a live encoding use case,
  where \s-1PTS\s0 values are set as as wallclock time at the source. For example, an
  encoding use case with decklink capture source where **video\_pts** and
  **audio\_pts** are set to **abs\_wallclock**.

_Example_
.IX Subsection "Example"

Smooth Streaming content can be pushed in real time to a publishing
point on \s-1IIS\s0 with this muxer. Example:

.Vb 1
        ffmpeg -re &lt;&lt;normal input/transcoding options&gt;&gt; -movflags isml+frag_keyframe -f ismv http://server/publishingpoint.isml/Streams(Encoder1)
.Ve

_Audible \s-1AAX\s0_
.IX Subsection "Audible AAX"

Audible \s-1AAX\s0 files are encrypted M4B files, and they can be decrypted by specifying a 4 byte activation secret.

.Vb 1
        ffmpeg -activation_bytes 1CEB00DA -i test.aax -vn -c:a copy output.mp4
.Ve

<a name="mp3"></a>

### mp3

.IX Subsection "mp3"
The \s-1MP3\s0 muxer writes a raw \s-1MP3\s0 stream with the following optional features:

* ·  
  An ID3v2 metadata header at the beginning (enabled by default). Versions 2.3 and
  2.4 are supported, the \f(CW`id3v2\_version\*(C' private option controls which one is
  used (3 or 4). Setting \f(CW`id3v2\_version\*(C' to 0 disables the ID3v2 header
  completely.
  .Sp
  The muxer supports writing attached pictures (\s-1APIC\s0 frames) to the ID3v2 header.
  The pictures are supplied to the muxer in form of a video stream with a single
  packet. There can be any number of those streams, each will correspond to a
  single \s-1APIC\s0 frame.  The stream metadata tags _title_ and _comment_ map
  to \s-1APIC\s0 _description_ and _picture type_ respectively. See
  &lt;**http://id3.org/id3v2.4.0-frames**&gt; for allowed picture types.
  .Sp
  Note that the \s-1APIC\s0 frames must be written at the beginning, so the muxer will
  buffer the audio frames until it gets all the pictures. It is therefore advised
  to provide the pictures as soon as possible to avoid excessive buffering.
* ·  
  A Xing/LAME frame right after the ID3v2 header (if present). It is enabled by
  default, but will be written only if the output is seekable. The
  \f(CW`write\_xing\*(C' private option can be used to disable it.  The frame contains
  various information that may be useful to the decoder, like the audio duration
  or encoder delay.
* ·  
  A legacy ID3v1 tag at the end of the file (disabled by default). It may be
  enabled with the \f(CW`write\_id3v1\*(C' private option, but as its capabilities are
  very limited, its usage is not recommended.

Examples:

Write an mp3 with an ID3v2.3 header and an ID3v1 footer:

.Vb 1
        ffmpeg -i INPUT -id3v2_version 3 -write_id3v1 1 out.mp3
.Ve

To attach a picture to an mp3 file select both the audio and the picture stream
with \f(CW`map\*(C':

.Vb 2
        ffmpeg -i input.mp3 -i cover.png -c copy -map 0 -map 1
        -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (Front)" out.mp3
.Ve

Write a clean\*(R" \s-1MP3\s0 without any extra features:

.Vb 1
        ffmpeg -i input.wav -write_xing 0 -id3v2_version 0 out.mp3
.Ve

<a name="mpegts"></a>

### mpegts

.IX Subsection "mpegts"
\s-1MPEG\s0 transport stream muxer.

This muxer implements \s-1ISO 13818-1\s0 and part of \s-1ETSI EN 300 468.\s0

The recognized metadata settings in mpegts muxer are \f(CW`service\_provider\*(C'
and \f(CW`service\_name\*(C'. If they are not set the default for
\f(CW`service\_provider\*(C' is **FFmpeg** and the default for
\f(CW`service\_name\*(C' is **Service01**.

_Options_
.IX Subsection "Options"

The muxer options are:

* **mpegts\_transport\_stream\_id** _integer_  
  .IX Item "mpegts_transport_stream_id integer"
  Set the **transport\_stream\_id**. This identifies a transponder in \s-1DVB.\s0
  Default is \f(CW0x0001.
* **mpegts\_original\_network\_id** _integer_  
  .IX Item "mpegts_original_network_id integer"
  Set the **original\_network\_id**. This is unique identifier of a
  network in \s-1DVB.\s0 Its main use is in the unique identification of a service
  through the path **Original_Network_ID, Transport\_Stream\_ID**. Default
  is \f(CW0x0001.
* **mpegts\_service\_id** _integer_  
  .IX Item "mpegts_service_id integer"
  Set the **service\_id**, also known as program in \s-1DVB.\s0 Default is
  \f(CW0x0001.
* **mpegts\_service\_type** _integer_  
  .IX Item "mpegts_service_type integer"
  Set the program **service\_type**. Default is \f(CW`digital\_tv\*(C'.
  Accepts the following options:
    * **hex\_value**  
      .IX Item "hex_value"
      Any hexdecimal value between \f(CW0x01 to \f(CW0xff as defined in
      \s-1ETSI 300 468.\s0
    * **digital\_tv**  
      .IX Item "digital_tv"
      Digital \s-1TV\s0 service.
    * **digital\_radio**  
      .IX Item "digital_radio"
      Digital Radio service.
    * **teletext**  
      .IX Item "teletext"
      Teletext service.
    * **advanced\_codec\_digital\_radio**  
      .IX Item "advanced_codec_digital_radio"
      Advanced Codec Digital Radio service.
    * **mpeg2\_digital\_hdtv**  
      .IX Item "mpeg2_digital_hdtv"
      \s-1MPEG2\s0 Digital \s-1HDTV\s0 service.
    * **advanced\_codec\_digital\_sdtv**  
      .IX Item "advanced_codec_digital_sdtv"
      Advanced Codec Digital \s-1SDTV\s0 service.
    * **advanced\_codec\_digital\_hdtv**  
      .IX Item "advanced_codec_digital_hdtv"
      Advanced Codec Digital \s-1HDTV\s0 service.
* **mpegts\_pmt\_start\_pid** _integer_  
  .IX Item "mpegts_pmt_start_pid integer"
  Set the first \s-1PID\s0 for \s-1PMT.\s0 Default is \f(CW0x1000. Max is \f(CW0x1f00.
* **mpegts\_start\_pid** _integer_  
  .IX Item "mpegts_start_pid integer"
  Set the first \s-1PID\s0 for data packets. Default is \f(CW0x0100. Max is
  \f(CW0x0f00.
* **mpegts\_m2ts\_mode** _boolean_  
  .IX Item "mpegts_m2ts_mode boolean"
  Enable m2ts mode if set to \f(CW1. Default value is \f(CW`-1\*(C' which
  disables m2ts mode.
* **muxrate** _integer_  
  .IX Item "muxrate integer"
  Set a constant muxrate. Default is \s-1VBR.\s0
* **pes\_payload\_size** _integer_  
  .IX Item "pes_payload_size integer"
  Set minimum \s-1PES\s0 packet payload in bytes. Default is \f(CW2930.
* **mpegts\_flags** _flags_  
  .IX Item "mpegts_flags flags"
  Set mpegts flags. Accepts the following options:
    * **resend\_headers**  
      .IX Item "resend_headers"
      Reemit \s-1PAT/PMT\s0 before writing the next packet.
    * **latm**  
      .IX Item "latm"
      Use \s-1LATM\s0 packetization for \s-1AAC.\s0
    * **pat\_pmt\_at\_frames**  
      .IX Item "pat_pmt_at_frames"
      Reemit \s-1PAT\s0 and \s-1PMT\s0 at each video frame.
    * **system\_b**  
      .IX Item "system_b"
      Conform to System B (\s-1DVB\s0) instead of System A (\s-1ATSC\s0).
    * **initial\_discontinuity**  
      .IX Item "initial_discontinuity"
      Mark the initial packet of each stream as discontinuity.
* **resend\_headers** _integer_  
  .IX Item "resend_headers integer"
  Reemit \s-1PAT/PMT\s0 before writing the next packet. This option is deprecated:
  use **mpegts\_flags** instead.
* **mpegts\_copyts** _boolean_  
  .IX Item "mpegts_copyts boolean"
  Preserve original timestamps, if value is set to \f(CW1. Default value
  is \f(CW`-1\*(C', which results in shifting timestamps so that they start from 0.
* **omit\_video\_pes\_length** _boolean_  
  .IX Item "omit_video_pes_length boolean"
  Omit the \s-1PES\s0 packet length for video packets. Default is \f(CW1 (true).
* **pcr\_period** _integer_  
  .IX Item "pcr_period integer"
  Override the default \s-1PCR\s0 retransmission time in milliseconds. Ignored if
  variable muxrate is selected. Default is \f(CW20.
* **pat\_period** _double_  
  .IX Item "pat_period double"
  Maximum time in seconds between \s-1PAT/PMT\s0 tables.
* **sdt\_period** _double_  
  .IX Item "sdt_period double"
  Maximum time in seconds between \s-1SDT\s0 tables.
* **tables\_version** _integer_  
  .IX Item "tables_version integer"
  Set \s-1PAT, PMT\s0 and \s-1SDT\s0 version (default \f(CW0, valid values are from 0 to 31, inclusively).
  This option allows updating stream structure so that standard consumer may
  detect the change. To do so, reopen output \f(CW`AVFormatContext\*(C' (in case of \s-1API\s0
  usage) or restart **ffmpeg** instance, cyclically changing
  **tables\_version** value:
  .Sp
  .Vb 7
          ffmpeg -i source1.ts -codec copy -f mpegts -tables_version 0 udp://1.1.1.1:1111
          ffmpeg -i source2.ts -codec copy -f mpegts -tables_version 1 udp://1.1.1.1:1111
          ...
          ffmpeg -i source3.ts -codec copy -f mpegts -tables_version 31 udp://1.1.1.1:1111
          ffmpeg -i source1.ts -codec copy -f mpegts -tables_version 0 udp://1.1.1.1:1111
          ffmpeg -i source2.ts -codec copy -f mpegts -tables_version 1 udp://1.1.1.1:1111
          ...
  .Ve

_Example_
.IX Subsection "Example"

.Vb 9
        ffmpeg -i file.mpg -c copy \e
             -mpegts_original_network_id 0x1122 \e
             -mpegts_transport_stream_id 0x3344 \e
             -mpegts_service_id 0x5566 \e
             -mpegts_pmt_start_pid 0x1500 \e
             -mpegts_start_pid 0x150 \e
             -metadata service_provider="Some provider" \e
             -metadata service_name="Some Channel" \e
             out.ts
.Ve

<a name="mxf-mxf_d10"></a>

### mxf, mxf_d10

.IX Subsection "mxf, mxf_d10"
\s-1MXF\s0 muxer.

_Options_
.IX Subsection "Options"

The muxer options are:

* **store\_user\_comments** _bool_  
  .IX Item "store_user_comments bool"
  Set if user comments should be stored if available or never.
  \s-1IRT D-10\s0 does not allow user comments. The default is thus to write them for
  mxf but not for mxf_d10

<a name="null"></a>

### null

.IX Subsection "null"
Null muxer.

This muxer does not generate any output file, it is mainly useful for
testing or benchmarking purposes.

For example to benchmark decoding with **ffmpeg** you can use the
command:

.Vb 1
        ffmpeg -benchmark -i INPUT -f null out.null
.Ve

Note that the above command does not read or write the _out.null_
file, but specifying the output file is required by the **ffmpeg**
syntax.

Alternatively you can write the command as:

.Vb 1
        ffmpeg -benchmark -i INPUT -f null -
.Ve

<a name="nut"></a>

### nut

.IX Subsection "nut"

* **-syncpoints** _flags_  
  .IX Item "-syncpoints flags"
  Change the syncpoint usage in nut:
    * _default_ **use the normal low-overhead seeking aids.**  
      .IX Item "default use the normal low-overhead seeking aids."
    * _none_ **do not use the syncpoints at all, reducing the overhead but making the stream non-seekable;**  
      .IX Item "none do not use the syncpoints at all, reducing the overhead but making the stream non-seekable;"
      .Vb 5
          Use of this option is not recommended, as the resulting files are very damage
          sensitive and seeking is not possible. Also in general the overhead from
          syncpoints is negligible. Note, -C&lt;write_index&gt; 0 can be used to disable
          all growing data tables, allowing to mux endless streams with limited memory
          and without these disadvantages.
      .Ve
    * _timestamped_ **extend the syncpoint with a wallclock field.**  
      .IX Item "timestamped extend the syncpoint with a wallclock field."
      .Sp
      The _none_ and _timestamped_ flags are experimental.
* **-write\_index** _bool_  
  .IX Item "-write_index bool"
  Write index at the end, the default is to write an index.

.Vb 1
        ffmpeg -i INPUT -f_strict experimental -syncpoints none - | processor
.Ve

<a name="ogg"></a>

### ogg

.IX Subsection "ogg"
Ogg container muxer.

* **-page\_duration** _duration_  
  .IX Item "-page_duration duration"
  Preferred page duration, in microseconds. The muxer will attempt to create
  pages that are approximately _duration_ microseconds long. This allows the
  user to compromise between seek granularity and container overhead. The default
  is 1 second. A value of 0 will fill all segments, making pages as large as
  possible. A value of 1 will effectively use 1 packet-per-page in most
  situations, giving a small seek granularity at the cost of additional container
  overhead.
* **-serial\_offset** _value_  
  .IX Item "-serial_offset value"
  Serial value from which to set the streams serial number.
  Setting it to different and sufficiently large values ensures that the produced
  ogg files can be safely chained.

<a name="segment-stream_segment-ssegment"></a>

### segment, stream_segment, ssegment

.IX Subsection "segment, stream_segment, ssegment"
Basic stream segmenter.

This muxer outputs streams to a number of separate files of nearly
fixed duration. Output filename pattern can be set in a fashion
similar to **image2**, or by using a \f(CW`strftime\*(C' template if
the **strftime** option is enabled.

\f(CW`stream\_segment\*(C' is a variant of the muxer used to write to
streaming output formats, i.e. which do not require global headers,
and is recommended for outputting e.g. to \s-1MPEG\s0 transport stream segments.
\f(CW`ssegment\*(C' is a shorter alias for \f(CW\*(C\`stream\_segment\*(C'.

Every segment starts with a keyframe of the selected reference stream,
which is set through the **reference\_stream** option.

Note that if you want accurate splitting for a video file, you need to
make the input key frames correspond to the exact splitting times
expected by the segmenter, or the segment muxer will start the new
segment with the key frame found next after the specified start
time.

The segment muxer works best with a single constant frame rate video.

Optionally it can generate a list of the created segments, by setting
the option _segment\_list_. The list type is specified by the
_segment\_list\_type_ option. The entry filenames in the segment
list are set by default to the basename of the corresponding segment
files.

See also the **hls** muxer, which provides a more specific
implementation for \s-1HLS\s0 segmentation.

_Options_
.IX Subsection "Options"

The segment muxer supports the following options:

* **increment\_tc** _1|0_  
  .IX Item "increment_tc 1|0"
  if set to \f(CW1, increment timecode between each segment
  If this is selected, the input need to have
  a timecode in the first video stream. Default value is
  \f(CW0.
* **reference\_stream** _specifier_  
  .IX Item "reference_stream specifier"
  Set the reference stream, as specified by the string _specifier_.
  If _specifier_ is set to \f(CW`auto\*(C', the reference is chosen
  automatically. Otherwise it must be a stream specifier (see the \`\`Stream
  specifiers'' chapter in the ffmpeg manual) which specifies the
  reference stream. The default value is \f(CW`auto\*(C'.
* **segment\_format** _format_  
  .IX Item "segment_format format"
  Override the inner container format, by default it is guessed by the filename
  extension.
* **segment\_format\_options** _options\_list_  
  .IX Item "segment_format_options options_list"
  Set output format options using a :-separated list of key=value
  parameters. Values containing the \f(CW`:\*(C' special character must be
  escaped.
* **segment\_list** _name_  
  .IX Item "segment_list name"
  Generate also a listfile named _name_. If not specified no
  listfile is generated.
* **segment\_list\_flags** _flags_  
  .IX Item "segment_list_flags flags"
  Set flags affecting the segment list generation.
  .Sp
  It currently supports the following flags:
    * **cache**  
      .IX Item "cache"
      Allow caching (only affects M3U8 list files).
    * **live**  
      .IX Item "live"
      Allow live-friendly file generation.
* **segment\_list\_size** _size_  
  .IX Item "segment_list_size size"
  Update the list file so that it contains at most _size_
  segments. If 0 the list file will contain all the segments. Default
  value is 0.
* **segment\_list\_entry\_prefix** _prefix_  
  .IX Item "segment_list_entry_prefix prefix"
  Prepend _prefix_ to each entry. Useful to generate absolute paths.
  By default no prefix is applied.
* **segment\_list\_type** _type_  
  .IX Item "segment_list_type type"
  Select the listing format.
  .Sp
  The following values are recognized:
    * **flat**  
      .IX Item "flat"
      Generate a flat list for the created segments, one segment per line.
    * **csv, ext**  
      .IX Item "csv, ext"
      Generate a list for the created segments, one segment per line,
      each line matching the format (comma-separated values):
      .Sp
      .Vb 1
              &lt;segment_filename&gt;,&lt;segment_start_time&gt;,&lt;segment_end_time&gt;
      .Ve
      .Sp
      _segment\_filename_ is the name of the output file generated by the
      muxer according to the provided pattern. \s-1CSV\s0 escaping (according to
      \s-1RFC4180\s0) is applied if required.
      .Sp
      _segment\_start\_time_ and _segment\_end\_time_ specify
      the segment start and end time expressed in seconds.
      .Sp
      A list file with the suffix \f(CW".csv" or \f(CW".ext" will
      auto-select this format.
      .Sp
      **ext** is deprecated in favor or **csv**.
    * **ffconcat**  
      .IX Item "ffconcat"
      Generate an ffconcat file for the created segments. The resulting file
      can be read using the FFmpeg **concat** demuxer.
      .Sp
      A list file with the suffix \f(CW".ffcat" or \f(CW".ffconcat" will
      auto-select this format.
    * **m3u8**  
      .IX Item "m3u8"
      Generate an extended M3U8 file, version 3, compliant with
      &lt;**http://tools.ietf.org/id/draft-pantos-http-live-streaming**&gt;.
      .Sp
      A list file with the suffix \f(CW".m3u8" will auto-select this format.
      .Sp
      If not specified the type is guessed from the list file name suffix.
* **segment\_time** _time_  
  .IX Item "segment_time time"
  Set segment duration to _time_, the value must be a duration
  specification. Default value is 2\*(R". See also the
  **segment\_times** option.
  .Sp
  Note that splitting may not be accurate, unless you force the
  reference stream key-frames at the given time. See the introductory
  notice and the examples below.
* **segment\_atclocktime** _1|0_  
  .IX Item "segment_atclocktime 1|0"
  If set to 1\*(R" split at regular clock time intervals starting from 00:00
  o'clock. The _time_ value specified in **segment\_time** is
  used for setting the length of the splitting interval.
  .Sp
  For example with **segment\_time** set to 900\*(R" this makes it possible
  to create files at 12:00 o'clock, 12:15, 12:30, etc.
  .Sp
  Default value is 0\*(R".
* **segment\_clocktime\_offset** _duration_  
  .IX Item "segment_clocktime_offset duration"
  Delay the segment splitting times with the specified duration when using
  **segment\_atclocktime**.
  .Sp
  For example with **segment\_time** set to 900\*(R" and
  **segment\_clocktime\_offset** set to 300\*(R" this makes it possible to
  create files at 12:05, 12:20, 12:35, etc.
  .Sp
  Default value is 0\*(R".
* **segment\_clocktime\_wrap\_duration** _duration_  
  .IX Item "segment_clocktime_wrap_duration duration"
  Force the segmenter to only start a new segment if a packet reaches the muxer
  within the specified duration after the segmenting clock time. This way you
  can make the segmenter more resilient to backward local time jumps, such as
  leap seconds or transition to standard time from daylight savings time.
  .Sp
  Default is the maximum possible duration which means starting a new segment
  regardless of the elapsed time since the last clock time.
* **segment\_time\_delta** _delta_  
  .IX Item "segment_time_delta delta"
  Specify the accuracy time when selecting the start time for a
  segment, expressed as a duration specification. Default value is 0\*(R".
  .Sp
  When delta is specified a key-frame will start a new segment if its
  \s-1PTS\s0 satisfies the relation:
  .Sp
  .Vb 1
          PTS &gt;= start_time - time_delta
  .Ve
  .Sp
  This option is useful when splitting video content, which is always
  split at \s-1GOP\s0 boundaries, in case a key frame is found just before the
  specified split time.
  .Sp
  In particular may be used in combination with the _ffmpeg_ option
  _force\_key\_frames_. The key frame times specified by
  _force\_key\_frames_ may not be set accurately because of rounding
  issues, with the consequence that a key frame time may result set just
  before the specified time. For constant frame rate videos a value of
  1/(2*_frame\_rate_) should address the worst case mismatch between
  the specified time and the time set by _force\_key\_frames_.
* **segment\_times** _times_  
  .IX Item "segment_times times"
  Specify a list of split points. _times_ contains a list of comma
  separated duration specifications, in increasing order. See also
  the **segment\_time** option.
* **segment\_frames** _frames_  
  .IX Item "segment_frames frames"
  Specify a list of split video frame numbers. _frames_ contains a
  list of comma separated integer numbers, in increasing order.
  .Sp
  This option specifies to start a new segment whenever a reference
  stream key frame is found and the sequential number (starting from 0)
  of the frame is greater or equal to the next value in the list.
* **segment\_wrap** _limit_  
  .IX Item "segment_wrap limit"
  Wrap around segment index once it reaches _limit_.
* **segment\_start\_number** _number_  
  .IX Item "segment_start_number number"
  Set the sequence number of the first segment. Defaults to \f(CW0.
* **strftime** _1|0_  
  .IX Item "strftime 1|0"
  Use the \f(CW`strftime\*(C' function to define the name of the new
  segments to write. If this is selected, the output segment name must
  contain a \f(CW`strftime\*(C' function template. Default value is
  \f(CW0.
* **break\_non\_keyframes** _1|0_  
  .IX Item "break_non_keyframes 1|0"
  If enabled, allow segments to start on frames other than keyframes. This
  improves behavior on some players when the time between keyframes is
  inconsistent, but may make things worse on others, and can cause some oddities
  during seeking. Defaults to \f(CW0.
* **reset\_timestamps** _1|0_  
  .IX Item "reset_timestamps 1|0"
  Reset timestamps at the beginning of each segment, so that each segment
  will start with near-zero timestamps. It is meant to ease the playback
  of the generated segments. May not work with some combinations of
  muxers/codecs. It is set to \f(CW0 by default.
* **initial\_offset** _offset_  
  .IX Item "initial_offset offset"
  Specify timestamp offset to apply to the output packet timestamps. The
  argument must be a time duration specification, and defaults to 0.
* **write\_empty\_segments** _1|0_  
  .IX Item "write_empty_segments 1|0"
  If enabled, write an empty segment if there are no packets during the period a
  segment would usually span. Otherwise, the segment will be filled with the next
  packet written. Defaults to \f(CW0.

Make sure to require a closed \s-1GOP\s0 when encoding and to set the \s-1GOP\s0
size to fit your segment time constraint.

_Examples_
.IX Subsection "Examples"

* ·  
  Remux the content of file _in.mkv_ to a list of segments
  _out-000.nut_, _out-001.nut_, etc., and write the list of
  generated segments to _out.list_:
  .Sp
  .Vb 1
          ffmpeg -i in.mkv -codec hevc -flags +cgop -g 60 -map 0 -f segment -segment_list out.list out%03d.nut
  .Ve
* ·  
  Segment input and set output format options for the output segments:
  .Sp
  .Vb 1
          ffmpeg -i in.mkv -f segment -segment_time 10 -segment_format_options movflags=+faststart out%03d.mp4
  .Ve
* ·  
  Segment the input file according to the split points specified by the
  _segment\_times_ option:
  .Sp
  .Vb 1
          ffmpeg -i in.mkv -codec copy -map 0 -f segment -segment_list out.csv -segment_times 1,2,3,5,8,13,21 out%03d.nut
  .Ve
* ·  
  Use the **ffmpeg** **force\_key\_frames**
  option to force key frames in the input at the specified location, together
  with the segment option **segment\_time\_delta** to account for
  possible roundings operated when setting key frame times.
  .Sp
  .Vb 2
          ffmpeg -i in.mkv -force_key_frames 1,2,3,5,8,13,21 -codec:v mpeg4 -codec:a pcm_s16le -map 0 \e
          -f segment -segment_list out.csv -segment_times 1,2,3,5,8,13,21 -segment_time_delta 0.05 out%03d.nut
  .Ve
  .Sp
  In order to force key frames on the input file, transcoding is
  required.
* ·  
  Segment the input file by splitting the input file according to the
  frame numbers sequence specified with the **segment\_frames** option:
  .Sp
  .Vb 1
          ffmpeg -i in.mkv -codec copy -map 0 -f segment -segment_list out.csv -segment_frames 100,200,300,500,800 out%03d.nut
  .Ve
* ·  
  Convert the _in.mkv_ to \s-1TS\s0 segments using the \f(CW`libx264\*(C'
  and \f(CW`aac\*(C' encoders:
  .Sp
  .Vb 1
          ffmpeg -i in.mkv -map 0 -codec:v libx264 -codec:a aac -f ssegment -segment_list out.list out%03d.ts
  .Ve
* ·  
  Segment the input file, and create an M3U8 live playlist (can be used
  as live \s-1HLS\s0 source):
  .Sp
  .Vb 2
          ffmpeg -re -i in.mkv -codec copy -map 0 -f segment -segment_list playlist.m3u8 \e
          -segment_list_flags +live -segment_time 10 out%03d.mkv
  .Ve

<a name="smoothstreaming"></a>

### smoothstreaming

.IX Subsection "smoothstreaming"
Smooth Streaming muxer generates a set of files (Manifest, chunks) suitable for serving with conventional web server.

* **window\_size**  
  .IX Item "window_size"
  Specify the number of fragments kept in the manifest. Default 0 (keep all).
* **extra\_window\_size**  
  .IX Item "extra_window_size"
  Specify the number of fragments kept outside of the manifest before removing from disk. Default 5.
* **lookahead\_count**  
  .IX Item "lookahead_count"
  Specify the number of lookahead fragments. Default 2.
* **min\_frag\_duration**  
  .IX Item "min_frag_duration"
  Specify the minimum fragment duration (in microseconds). Default 5000000.
* **remove\_at\_exit**  
  .IX Item "remove_at_exit"
  Specify whether to remove all fragments when finished. Default 0 (do not remove).

<a name="fifo"></a>

### fifo

.IX Subsection "fifo"
The fifo pseudo-muxer allows the separation of encoding and muxing by using
first-in-first-out queue and running the actual muxer in a separate thread. This
is especially useful in combination with the **tee** muxer and can be used to
send data to several destinations with different reliability/writing speed/latency.

\s-1API\s0 users should be aware that callback functions (interrupt_callback,
io_open and io_close) used within its AVFormatContext must be thread-safe.

The behavior of the fifo muxer if the queue fills up or if the output fails is
selectable,

* ·  
  output can be transparently restarted with configurable delay between retries
  based on real time or time of the processed stream.
* ·  
  encoding can be blocked during temporary failure, or continue transparently
  dropping packets in case fifo queue fills up.
* **fifo\_format**  
  .IX Item "fifo_format"
  Specify the format name. Useful if it cannot be guessed from the
  output name suffix.
* **queue\_size**  
  .IX Item "queue_size"
  Specify size of the queue (number of packets). Default value is 60.
* **format\_opts**  
  .IX Item "format_opts"
  Specify format options for the underlying muxer. Muxer options can be specified
  as a list of _key_=_value_ pairs separated by ':'.
* **drop\_pkts\_on\_overflow** _bool_  
  .IX Item "drop_pkts_on_overflow bool"
  If set to 1 (true), in case the fifo queue fills up, packets will be dropped
  rather than blocking the encoder. This makes it possible to continue streaming without
  delaying the input, at the cost of omitting part of the stream. By default
  this option is set to 0 (false), so in such cases the encoder will be blocked
  until the muxer processes some of the packets and none of them is lost.
* **attempt\_recovery** _bool_  
  .IX Item "attempt_recovery bool"
  If failure occurs, attempt to recover the output. This is especially useful
  when used with network output, since it makes it possible to restart streaming transparently.
  By default this option is set to 0 (false).
* **max\_recovery\_attempts**  
  .IX Item "max_recovery_attempts"
  Sets maximum number of successive unsuccessful recovery attempts after which
  the output fails permanently. By default this option is set to 0 (unlimited).
* **recovery\_wait\_time** _duration_  
  .IX Item "recovery_wait_time duration"
  Waiting time before the next recovery attempt after previous unsuccessful
  recovery attempt. Default value is 5 seconds.
* **recovery\_wait\_streamtime** _bool_  
  .IX Item "recovery_wait_streamtime bool"
  If set to 0 (false), the real time is used when waiting for the recovery
  attempt (i.e. the recovery will be attempted after at least
  recovery_wait_time seconds).
  If set to 1 (true), the time of the processed stream is taken into account
  instead (i.e. the recovery will be attempted after at least _recovery\_wait\_time_
  seconds of the stream is omitted).
  By default, this option is set to 0 (false).
* **recover\_any\_error** _bool_  
  .IX Item "recover_any_error bool"
  If set to 1 (true), recovery will be attempted regardless of type of the error
  causing the failure. By default this option is set to 0 (false) and in case of
  certain (usually permanent) errors the recovery is not attempted even when
  _attempt\_recovery_ is set to 1.
* **restart\_with\_keyframe** _bool_  
  .IX Item "restart_with_keyframe bool"
  Specify whether to wait for the keyframe after recovering from
  queue overflow or failure. This option is set to 0 (false) by default.

_Examples_
.IX Subsection "Examples"

* ·  
  Stream something to rtmp server, continue processing the stream at real-time
  rate even in case of temporary failure (network outage) and attempt to recover
  streaming every second indefinitely.
  .Sp
  .Vb 2
          ffmpeg -re -i ... -c:v libx264 -c:a aac -f fifo -fifo_format flv -map 0:v -map 0:a
            -drop_pkts_on_overflow 1 -attempt_recovery 1 -recovery_wait_time 1 rtmp://example.com/live/stream_name
  .Ve

<a name="tee"></a>

### tee

.IX Subsection "tee"
The tee muxer can be used to write the same data to several outputs, such as files or streams.
It can be used, for example, to stream a video over a network and save it to disk at the same time.

It is different from specifying several outputs to the **ffmpeg**
command-line tool. With the tee muxer, the audio and video data will be encoded only once.
With conventional multiple outputs, multiple encoding operations in parallel are initiated,
which can be a very expensive process. The tee muxer is not useful when using the libavformat \s-1API\s0
directly because it is then possible to feed the same packets to several muxers directly.

Since the tee muxer does not represent any particular output format, ffmpeg cannot auto-select
output streams. So all streams intended for output must be specified using \f(CW`-map\*(C'. See
the examples below.

Some encoders may need different options depending on the output format;
the auto-detection of this can not work with the tee muxer, so they need to be explicitly specified.
The main example is the **global\_header** flag.

The slave outputs are specified in the file name given to the muxer,
separated by '|'. If any of the slave name contains the '|' separator,
leading or trailing spaces or any special character, those must be
escaped (see the Quoting and escaping\*(R"
section in the **ffmpeg-utils\|(1) manual**).

_Options_
.IX Subsection "Options"

* **use\_fifo** _bool_  
  .IX Item "use_fifo bool"
  If set to 1, slave outputs will be processed in separate threads using the **fifo**
  muxer. This allows to compensate for different speed/latency/reliability of
  outputs and setup transparent recovery. By default this feature is turned off.
* **fifo\_options**  
  .IX Item "fifo_options"
  Options to pass to fifo pseudo-muxer instances. See **fifo**.

Muxer options can be specified for each slave by prepending them as a list of
_key_=_value_ pairs separated by ':', between square brackets. If
the options values contain a special character or the ':' separator, they
must be escaped; note that this is a second level escaping.

The following special options are also recognized:

* **f**  
  .IX Item "f"
  Specify the format name. Required if it cannot be guessed from the
  output \s-1URL.\s0
* **bsfs[/**_spec_**]**  
  .IX Item "bsfs[/spec]"
  Specify a list of bitstream filters to apply to the specified
  output.
  .Sp
  It is possible to specify to which streams a given bitstream filter
  applies, by appending a stream specifier to the option separated by
  \f(CW`/\*(C'. _spec_ must be a stream specifier (see Format
  stream specifiers).
  .Sp
  If the stream specifier is not specified, the bitstream filters will be
  applied to all streams in the output. This will cause that output operation
  to fail if the output contains streams to which the bitstream filter cannot
  be applied e.g. \f(CW`h264\_mp4toannexb\*(C' being applied to an output containing an audio stream.
  .Sp
  Options for a bitstream filter must be specified in the form of \f(CW`opt=value\*(C'.
  .Sp
  Several bitstream filters can be specified, separated by ,\*(R".
* **use\_fifo** _bool_  
  .IX Item "use_fifo bool"
  This allows to override tee muxer use_fifo option for individual slave muxer.
* **fifo\_options**  
  .IX Item "fifo_options"
  This allows to override tee muxer fifo_options for individual slave muxer.
  See **fifo**.
* **select**  
  .IX Item "select"
  Select the streams that should be mapped to the slave output,
  specified by a stream specifier. If not specified, this defaults to
  all the mapped streams. This will cause that output operation to fail
  if the output format does not accept all mapped streams.
  .Sp
  You may use multiple stream specifiers separated by commas (\f(CW`,\*(C') e.g.: \f(CW\*(C\`a:0,v\*(C'
* **onfail**  
  .IX Item "onfail"
  Specify behaviour on output failure. This can be set to either \f(CW`abort\*(C' (which is
  default) or \f(CW`ignore\*(C'. \f(CW\*(C\`abort\*(C' will cause whole process to fail in case of failure
  on this slave output. \f(CW`ignore\*(C' will ignore failure on this output, so other outputs
  will continue without being affected.

_Examples_
.IX Subsection "Examples"

* ·  
  Encode something and both archive it in a WebM file and stream it
  as MPEG-TS over \s-1UDP:\s0
  .Sp
  .Vb 2
          ffmpeg -i ... -c:v libx264 -c:a mp2 -f tee -map 0:v -map 0:a
            "archive-20121107.mkv|[f=mpegts]udp://10.0.1.255:1234/"
  .Ve
* ·  
  As above, but continue streaming even if output to local file fails
  (for example local drive fills up):
  .Sp
  .Vb 2
          ffmpeg -i ... -c:v libx264 -c:a mp2 -f tee -map 0:v -map 0:a
            "[onfail=ignore]archive-20121107.mkv|[f=mpegts]udp://10.0.1.255:1234/"
  .Ve
* ·  
  Use **ffmpeg** to encode the input, and send the output
  to three different destinations. The \f(CW`dump\_extra\*(C' bitstream
  filter is used to add extradata information to all the output video
  keyframes packets, as requested by the MPEG-TS format. The select
  option is applied to _out.aac_ in order to make it contain only
  audio packets.
  .Sp
  .Vb 2
          ffmpeg -i ... -map 0 -flags +global_header -c:v libx264 -c:a aac
                 -f tee "[bsfs/v=dump_extra=freq=keyframe]out.ts|[movflags=+faststart]out.mp4|[select=a]out.aac"
  .Ve
* ·  
  As above, but select only stream \f(CW`a:1\*(C' for the audio output. Note
  that a second level escaping must be performed, as :\*(R" is a special
  character used to separate options.
  .Sp
  .Vb 2
          ffmpeg -i ... -map 0 -flags +global_header -c:v libx264 -c:a aac
                 -f tee "[bsfs/v=dump_extra=freq=keyframe]out.ts|[movflags=+faststart]out.mp4|[select=\ea:1\e\*(Aq]out.aac"
  .Ve

<a name="webm_dash_manifest"></a>

### webm_dash_manifest

.IX Subsection "webm_dash_manifest"
WebM \s-1DASH\s0 Manifest muxer.

This muxer implements the WebM \s-1DASH\s0 Manifest specification to generate the \s-1DASH\s0
manifest \s-1XML.\s0 It also supports manifest generation for \s-1DASH\s0 live streams.

For more information see:

* ·  
  WebM \s-1DASH\s0 Specification: &lt;**https://sites.google.com/a/webmproject.org/wiki/adaptive-streaming/webm-dash-specification**&gt;
* ·  
  \s-1ISO DASH\s0 Specification: &lt;**http://standards.iso.org/ittf/PubliclyAvailableStandards/c065274\_ISO\_IEC\_23009-1\_2014.zip**&gt;

_Options_
.IX Subsection "Options"

This muxer supports the following options:

* **adaptation\_sets**  
  .IX Item "adaptation_sets"
  This option has the following syntax: id=x,streams=a,b,c id=y,streams=d,e\*(R" where x and y are the
  unique identifiers of the adaptation sets and a,b,c,d and e are the indices of the corresponding
  audio and video streams. Any number of adaptation sets can be added using this option.
* **live**  
  .IX Item "live"
  Set this to 1 to create a live stream \s-1DASH\s0 Manifest. Default: 0.
* **chunk\_start\_index**  
  .IX Item "chunk_start_index"
  Start index of the first chunk. This will go in the **startNumber** attribute
  of the **SegmentTemplate** element in the manifest. Default: 0.
* **chunk\_duration\_ms**  
  .IX Item "chunk_duration_ms"
  Duration of each chunk in milliseconds. This will go in the **duration**
  attribute of the **SegmentTemplate** element in the manifest. Default: 1000.
* **utc\_timing\_url**  
  .IX Item "utc_timing_url"
  \s-1URL\s0 of the page that will return the \s-1UTC\s0 timestamp in \s-1ISO\s0 format. This will go
  in the **value** attribute of the **UTCTiming** element in the manifest.
  Default: None.
* **time\_shift\_buffer\_depth**  
  .IX Item "time_shift_buffer_depth"
  Smallest time (in seconds) shifting buffer for which any Representation is
  guaranteed to be available. This will go in the **timeShiftBufferDepth**
  attribute of the **\s-1MPD\s0** element. Default: 60.
* **minimum\_update\_period**  
  .IX Item "minimum_update_period"
  Minimum update period (in seconds) of the manifest. This will go in the
  **minimumUpdatePeriod** attribute of the **\s-1MPD\s0** element. Default: 0.

_Example_
.IX Subsection "Example"

.Vb 9
        ffmpeg -f webm_dash_manifest -i video1.webm \e
               -f webm_dash_manifest -i video2.webm \e
               -f webm_dash_manifest -i audio1.webm \e
               -f webm_dash_manifest -i audio2.webm \e
               -map 0 -map 1 -map 2 -map 3 \e
               -c copy \e
               -f webm_dash_manifest \e
               -adaptation_sets "id=0,streams=0,1 id=1,streams=2,3" \e
               manifest.xml
.Ve

<a name="webm_chunk"></a>

### webm_chunk

.IX Subsection "webm_chunk"
WebM Live Chunk Muxer.

This muxer writes out WebM headers and chunks as separate files which can be
consumed by clients that support WebM Live streams via \s-1DASH.\s0

_Options_
.IX Subsection "Options"

This muxer supports the following options:

* **chunk\_start\_index**  
  .IX Item "chunk_start_index"
  Index of the first chunk (defaults to 0).
* **header**  
  .IX Item "header"
  Filename of the header where the initialization data will be written.
* **audio\_chunk\_duration**  
  .IX Item "audio_chunk_duration"
  Duration of each audio chunk in milliseconds (defaults to 5000).

_Example_
.IX Subsection "Example"

.Vb 10
        ffmpeg -f v4l2 -i /dev/video0 \e
               -f alsa -i hw:0 \e
               -map 0:0 \e
               -c:v libvpx-vp9 \e
               -s 640x360 -keyint_min 30 -g 30 \e
               -f webm_chunk \e
               -header webm_live_video_360.hdr \e
               -chunk_start_index 1 \e
               webm_live_video_360_%d.chk \e
               -map 1:0 \e
               -c:a libvorbis \e
               -b:a 128k \e
               -f webm_chunk \e
               -header webm_live_audio_128.hdr \e
               -chunk_start_index 1 \e
               -audio_chunk_duration 1000 \e
               webm_live_audio_128_%d.chk
.Ve

<a name="metadata"></a>

# Metadata

.IX Header "METADATA"
FFmpeg is able to dump metadata from media files into a simple UTF-8-encoded
INI-like text file and then load it back using the metadata muxer/demuxer.

The file format is as follows:

* 1.  
  A file consists of a header and a number of metadata tags divided into sections,
  each on its own line.
* 2.  
  The header is a **;FFMETADATA** string, followed by a version number (now 1).
* 3.  
  Metadata tags are of the form **key=value**
* 4.  
  Immediately after header follows global metadata
* 5.  
  After global metadata there may be sections with per-stream/per-chapter
  metadata.
* 6.  
  A section starts with the section name in uppercase (i.e. \s-1STREAM\s0 or \s-1CHAPTER\s0) in
  brackets (**[**, **]**) and ends with next section or end of file.
* 7.  
  At the beginning of a chapter section there may be an optional timebase to be
  used for start/end values. It must be in form
  **TIMEBASE=**_num_**/**_den_, where _num_ and _den_ are
  integers. If the timebase is missing then start/end times are assumed to
  be in milliseconds.
  .Sp
  Next a chapter section must contain chapter start and end times in form
  **START=**_num_, **END=**_num_, where _num_ is a positive
  integer.
* 8.  
  Empty lines and lines starting with **;** or **#** are ignored.
* 9.  
  Metadata keys or values containing special characters (**=**, **;**,
  **#**, **\e** and a newline) must be escaped with a backslash **\e**.
* 10.  
  Note that whitespace in metadata (e.g. **foo = bar**) is considered to be
  a part of the tag (in the example above key is **foo** , value is
   **bar**).

A ffmetadata file might look like this:

.Vb 4
        ;FFMETADATA1
        title=bike\e\eshed
        ;this is a comment
        artist=FFmpeg troll team
        
        [CHAPTER]
        TIMEBASE=1/1000
        START=0
        #chapter ends at 0:01:00
        END=60000
        title=chapter \e#1
        [STREAM]
        title=multi\e
        line
.Ve

By using the ffmetadata muxer and demuxer it is possible to extract
metadata from an input file to an ffmetadata file, and then transcode
the file into an output file with the edited ffmetadata file.

Extracting an ffmetadata file with _ffmpeg_ goes as follows:

.Vb 1
        ffmpeg -i INPUT -f ffmetadata FFMETADATAFILE
.Ve

Reinserting edited metadata information from the \s-1FFMETADATAFILE\s0 file can
be done as:

.Vb 1
        ffmpeg -i INPUT -i FFMETADATAFILE -map_metadata 1 -codec copy OUTPUT
.Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ffmpeg**\|(1), **ffplay**\|(1), **ffprobe**\|(1), **libavformat**\|(3)

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
