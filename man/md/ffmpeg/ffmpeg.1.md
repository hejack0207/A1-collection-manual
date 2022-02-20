# ffmpeg(1)

 ,  

.if n .ad l
.nh

<a name="name"></a>

# Name

ffmpeg - ffmpeg video converter

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" ffmpeg [global_options] {[input_file_options] -i input_url} ... {[output_file_options] output_url} ...
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**ffmpeg** is a very fast video and audio converter that can also grab from
a live audio/video source. It can also convert between arbitrary sample
rates and resize video on the fly with a high quality polyphase filter.

**ffmpeg** reads from an arbitrary number of input files\*(R" (which can be regular
files, pipes, network streams, grabbing devices, etc.), specified by the
\f(CW`-i\*(C' option, and writes to an arbitrary number of output \*(L"files\*(R", which are
specified by a plain output url. Anything found on the command line which
cannot be interpreted as an option is considered to be an output url.

Each input or output url can, in principle, contain any number of streams of
different types (video/audio/subtitle/attachment/data). The allowed number and/or
types of streams may be limited by the container format. Selecting which
streams from which inputs will go into which output is either done automatically
or with the \f(CW`-map\*(C' option (see the Stream selection chapter).

To refer to input files in options, you must use their indices (0-based). E.g.
the first input file is \f(CW0, the second is \f(CW1, etc. Similarly, streams
within a file are referred to by their indices. E.g. \f(CW`2:3\*(C' refers to the
fourth stream in the third input file. Also see the Stream specifiers chapter.

As a general rule, options are applied to the next specified
file. Therefore, order is important, and you can have the same
option on the command line multiple times. Each occurrence is
then applied to the next input or output file.
Exceptions from this rule are the global options (e.g. verbosity level),
which should be specified first.

Do not mix input and output files  first specify all input files, then all
output files. Also do not mix options which belong to different files. All
options apply \s-1ONLY\s0 to the next input or output file and are reset between files.

* ·  
  To set the video bitrate of the output file to 64 kbit/s:
  .Sp
  .Vb 1
          ffmpeg -i input.avi -b:v 64k -bufsize 64k output.avi
  .Ve
* ·  
  To force the frame rate of the output file to 24 fps:
  .Sp
  .Vb 1
          ffmpeg -i input.avi -r 24 output.avi
  .Ve
* ·  
  To force the frame rate of the input file (valid for raw formats only)
  to 1 fps and the frame rate of the output file to 24 fps:
  .Sp
  .Vb 1
          ffmpeg -r 1 -i input.m2v -r 24 output.avi
  .Ve

The format option may be needed for raw input files.

<a name="detailed-description"></a>

# Detailed Description

.IX Header "DETAILED DESCRIPTION"
The transcoding process in **ffmpeg** for each output can be described by
the following diagram:

.Vb 10
         _\|_\|_\|_\|_\|_\|_              _\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_
        |       |            |              |
        | input |  demuxer   | encoded data |   decoder
        | file  | ---------&gt; | packets      | -----+
        |_\|_\|_\|_\|_\|_\|_|            |_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_|      |
                                                   v
                                               _\|_\|_\|_\|_\|_\|_\|_\|_
                                              |         |
                                              | decoded |
                                              | frames  |
                                              |_\|_\|_\|_\|_\|_\|_\|_\|_|
         _\|_\|_\|_\|_\|_\|_\|_             _\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_       |
        |        |           |              |      |
        | output | &lt;-------- | encoded data | &lt;----+
        | file   |   muxer   | packets      |   encoder
        |_\|_\|_\|_\|_\|_\|_\|_|           |_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_|
.Ve

**ffmpeg** calls the libavformat library (containing demuxers) to read
input files and get packets containing encoded data from them. When there are
multiple input files, **ffmpeg** tries to keep them synchronized by
tracking lowest timestamp on any active input stream.

Encoded packets are then passed to the decoder (unless streamcopy is selected
for the stream, see further for a description). The decoder produces
uncompressed frames (raw video/PCM audio/...) which can be processed further by
filtering (see next section). After filtering, the frames are passed to the
encoder, which encodes them and outputs encoded packets. Finally those are
passed to the muxer, which writes the encoded packets to the output file.

<a name="filtering"></a>

### Filtering

.IX Subsection "Filtering"
Before encoding, **ffmpeg** can process raw audio and video frames using
filters from the libavfilter library. Several chained filters form a filter
graph. **ffmpeg** distinguishes between two types of filtergraphs:
simple and complex.

_Simple filtergraphs_
.IX Subsection "Simple filtergraphs"

Simple filtergraphs are those that have exactly one input and output, both of
the same type. In the above diagram they can be represented by simply inserting
an additional step between decoding and encoding:

.Vb 10
         _\|_\|_\|_\|_\|_\|_\|_\|_                        _\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_
        |         |                      |              |
        | decoded |                      | encoded data |
        | frames  |\e                   _ | packets      |
        |_\|_\|_\|_\|_\|_\|_\|_\|_| \e                  /||_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_|
                     \e   _\|_\|_\|_\|_\|_\|_\|_\|_\|_   /
          simple     _\e||          | /  encoder
          filtergraph   | filtered |/
                        | frames   |
                        |_\|_\|_\|_\|_\|_\|_\|_\|_\|_|
.Ve

Simple filtergraphs are configured with the per-stream **-filter** option
(with **-vf** and **-af** aliases for video and audio respectively).
A simple filtergraph for video can look for example like this:

.Vb 4
         _\|_\|_\|_\|_\|_\|_        _\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_        _\|_\|_\|_\|_\|_\|_        _\|_\|_\|_\|_\|_\|_\|_
        |       |      |             |      |       |      |        |
        | input | ---&gt; | deinterlace | ---&gt; | scale | ---&gt; | output |
        |_\|_\|_\|_\|_\|_\|_|      |_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_|      |_\|_\|_\|_\|_\|_\|_|      |_\|_\|_\|_\|_\|_\|_\|_|
.Ve

Note that some filters change frame properties but not frame contents. E.g. the
\f(CW`fps\*(C' filter in the example above changes number of frames, but does not
touch the frame contents. Another example is the \f(CW`setpts\*(C' filter, which
only sets timestamps and otherwise passes the frames unchanged.

_Complex filtergraphs_
.IX Subsection "Complex filtergraphs"

Complex filtergraphs are those which cannot be described as simply a linear
processing chain applied to one stream. This is the case, for example, when the graph has
more than one input and/or output, or when output stream type is different from
input. They can be represented with the following diagram:

.Vb 10
         _\|_\|_\|_\|_\|_\|_\|_\|_
        |         |
        | input 0 |\e                    _\|_\|_\|_\|_\|_\|_\|_\|_\|_
        |_\|_\|_\|_\|_\|_\|_\|_\|_| \e                  |          |
                     \e   _\|_\|_\|_\|_\|_\|_\|_\|_    /| output 0 |
                      \e |         |  / |_\|_\|_\|_\|_\|_\|_\|_\|_\|_|
         _\|_\|_\|_\|_\|_\|_\|_\|_     \e| complex | /
        |         |     |         |/
        | input 1 |----&gt;| filter  |\e
        |_\|_\|_\|_\|_\|_\|_\|_\|_|     |         | \e   _\|_\|_\|_\|_\|_\|_\|_\|_\|_
                       /| graph   |  \e |          |
                      / |         |   \e| output 1 |
         _\|_\|_\|_\|_\|_\|_\|_\|_   /  |_\|_\|_\|_\|_\|_\|_\|_\|_|    |_\|_\|_\|_\|_\|_\|_\|_\|_\|_|
        |         | /
        | input 2 |/
        |_\|_\|_\|_\|_\|_\|_\|_\|_|
.Ve

Complex filtergraphs are configured with the **-filter\_complex** option.
Note that this option is global, since a complex filtergraph, by its nature,
cannot be unambiguously associated with a single stream or file.

The **-lavfi** option is equivalent to **-filter\_complex**.

A trivial example of a complex filtergraph is the \f(CW`overlay\*(C' filter, which
has two video inputs and one video output, containing one video overlaid on top
of the other. Its audio counterpart is the \f(CW`amix\*(C' filter.

<a name="stream-copy"></a>

### Stream copy

.IX Subsection "Stream copy"
Stream copy is a mode selected by supplying the \f(CW`copy\*(C' parameter to the
**-codec** option. It makes **ffmpeg** omit the decoding and encoding
step for the specified stream, so it does only demuxing and muxing. It is useful
for changing the container format or modifying container-level metadata. The
diagram above will, in this case, simplify to this:

.Vb 5
         _\|_\|_\|_\|_\|_\|_              _\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_            _\|_\|_\|_\|_\|_\|_\|_
        |       |            |              |          |        |
        | input |  demuxer   | encoded data |  muxer   | output |
        | file  | ---------&gt; | packets      | -------&gt; | file   |
        |_\|_\|_\|_\|_\|_\|_|            |_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_\|_|          |_\|_\|_\|_\|_\|_\|_\|_|
.Ve

Since there is no decoding or encoding, it is very fast and there is no quality
loss. However, it might not work in some cases because of many factors. Applying
filters is obviously also impossible, since filters work on uncompressed data.

<a name="stream-selection"></a>

# Stream Selection

.IX Header "STREAM SELECTION"
**ffmpeg** provides the \f(CW`-map\*(C' option for manual control of stream selection in each
output file. Users can skip \f(CW`-map\*(C' and let ffmpeg perform automatic stream selection as
described below. The \f(CW`-vn / -an / -sn / -dn\*(C' options can be used to skip inclusion of
video, audio, subtitle and data streams respectively, whether manually mapped or automatically
selected, except for those streams which are outputs of complex filtergraphs.

<a name="description"></a>

### Description

.IX Subsection "Description"
The sub-sections that follow describe the various rules that are involved in stream selection.
The examples that follow next show how these rules are applied in practice.

While every effort is made to accurately reflect the behavior of the program, FFmpeg is under
continuous development and the code may have changed since the time of this writing.

_Automatic stream selection_
.IX Subsection "Automatic stream selection"

In the absence of any map options for a particular output file, ffmpeg inspects the output
format to check which type of streams can be included in it, viz. video, audio and/or
subtitles. For each acceptable stream type, ffmpeg will pick one stream, when available,
from among all the inputs.

It will select that stream based upon the following criteria:

* ·  
  for video, it is the stream with the highest resolution,
* ·  
  for audio, it is the stream with the most channels,
* ·  
  for subtitles, it is the first subtitle stream found but there's a caveat.
  The output format's default subtitle encoder can be either text-based or image-based,
  and only a subtitle stream of the same type will be chosen.

In the case where several streams of the same type rate equally, the stream with the lowest
index is chosen.

Data or attachment streams are not automatically selected and can only be included
using \f(CW`-map\*(C'.

_Manual stream selection_
.IX Subsection "Manual stream selection"

When \f(CW`-map\*(C' is used, only user-mapped streams are included in that output file,
with one possible exception for filtergraph outputs described below.

_Complex filtergraphs_
.IX Subsection "Complex filtergraphs"

If there are any complex filtergraph output streams with unlabeled pads, they will be added
to the first output file. This will lead to a fatal error if the stream type is not supported
by the output format. In the absence of the map option, the inclusion of these streams leads
to the automatic stream selection of their types being skipped. If map options are present,
these filtergraph streams are included in addition to the mapped streams.

Complex filtergraph output streams with labeled pads must be mapped once and exactly once.

_Stream handling_
.IX Subsection "Stream handling"

Stream handling is independent of stream selection, with an exception for subtitles described
below. Stream handling is set via the \f(CW`-codec\*(C' option addressed to streams within a
specific _output_ file. In particular, codec options are applied by ffmpeg after the
stream selection process and thus do not influence the latter. If no \f(CW`-codec\*(C' option is
specified for a stream type, ffmpeg will select the default encoder registered by the output
file muxer.

An exception exists for subtitles. If a subtitle encoder is specified for an output file, the
first subtitle stream found of any type, text or image, will be included. ffmpeg does not validate
if the specified encoder can convert the selected stream or if the converted stream is acceptable
within the output format. This applies generally as well: when the user sets an encoder manually,
the stream selection process cannot check if the encoded stream can be muxed into the output file.
If it cannot, ffmpeg will abort and _all_ output files will fail to be processed.

<a name="examples"></a>

### Examples

.IX Subsection "Examples"
The following examples illustrate the behavior, quirks and limitations of ffmpeg's stream
selection methods.

They assume the following three input files.

.Vb 3
        input file A.avi\*(Aq
              stream 0: video 640x360
              stream 1: audio 2 channels
        
        input file B.mp4\*(Aq
              stream 0: video 1920x1080
              stream 1: audio 2 channels
              stream 2: subtitles (text)
              stream 3: audio 5.1 channels
              stream 4: subtitles (text)
        
        input file C.mkv\*(Aq
              stream 0: video 1280x720
              stream 1: audio 2 channels
              stream 2: subtitles (image)
.Ve

Example: automatic stream selection
.IX Subsection "Example: automatic stream selection"

.Vb 1
        ffmpeg -i A.avi -i B.mp4 out1.mkv out2.wav -map 1:a -c:a copy out3.mov
.Ve

There are three output files specified, and for the first two, no \f(CW`-map\*(C' options
are set, so ffmpeg will select streams for these two files automatically.

_out1.mkv_ is a Matroska container file and accepts video, audio and subtitle streams,
so ffmpeg will try to select one of each type.For video, it will select \f(CW`stream 0\*(C' from _B.mp4_, which has the highest
resolution among all the input video streams.For audio, it will select \f(CW`stream 3\*(C' from _B.mp4_, since it has the greatest
number of channels.For subtitles, it will select \f(CW`stream 2\*(C' from _B.mp4_, which is the first subtitle
stream from among _A.avi_ and _B.mp4_.

_out2.wav_ accepts only audio streams, so only \f(CW`stream 3\*(C' from _B.mp4_ is
selected.

For _out3.mov_, since a \f(CW`-map\*(C' option is set, no automatic stream selection will
occur. The \f(CW`-map 1:a\*(C' option will select all audio streams from the second input
_B.mp4_. No other streams will be included in this output file.

For the first two outputs, all included streams will be transcoded. The encoders chosen will
be the default ones registered by each output format, which may not match the codec of the
selected input streams.

For the third output, codec option for audio streams has been set
to \f(CW`copy\*(C', so no decoding-filtering-encoding operations will occur, or _can_ occur.
Packets of selected streams shall be conveyed from the input file and muxed within the output
file.

Example: automatic subtitles selection
.IX Subsection "Example: automatic subtitles selection"

.Vb 1
        ffmpeg -i C.mkv out1.mkv -c:s dvdsub -an out2.mkv
.Ve

Although _out1.mkv_ is a Matroska container file which accepts subtitle streams, only a
video and audio stream shall be selected. The subtitle stream of _C.mkv_ is image-based
and the default subtitle encoder of the Matroska muxer is text-based, so a transcode operation
for the subtitles is expected to fail and hence the stream isn't selected. However, in
_out2.mkv_, a subtitle encoder is specified in the command and so, the subtitle stream is
selected, in addition to the video stream. The presence of \f(CW`-an\*(C' disables audio stream
selection for _out2.mkv_.

Example: unlabeled filtergraph outputs
.IX Subsection "Example: unlabeled filtergraph outputs"

.Vb 1
        ffmpeg -i A.avi -i C.mkv -i B.mp4 -filter_complex "overlay" out1.mp4 out2.srt
.Ve

A filtergraph is setup here using the \f(CW`-filter\_complex\*(C' option and consists of a single
video filter. The \f(CW`overlay\*(C' filter requires exactly two video inputs, but none are
specified, so the first two available video streams are used, those of _A.avi_ and
_C.mkv_. The output pad of the filter has no label and so is sent to the first output file
_out1.mp4_. Due to this, automatic selection of the video stream is skipped, which would
have selected the stream in _B.mp4_. The audio stream with most channels viz. \f(CW`stream 3\*(C'
in _B.mp4_, is chosen automatically. No subtitle stream is chosen however, since the \s-1MP4\s0
format has no default subtitle encoder registered, and the user hasn't specified a subtitle encoder.

The 2nd output file, _out2.srt_, only accepts text-based subtitle streams. So, even though
the first subtitle stream available belongs to _C.mkv_, it is image-based and hence skipped.
The selected stream, \f(CW`stream 2\*(C' in _B.mp4_, is the first text-based subtitle stream.

Example: labeled filtergraph outputs
.IX Subsection "Example: labeled filtergraph outputs"

.Vb 4
        ffmpeg -i A.avi -i B.mp4 -i C.mkv -filter_complex "[1:v]hue=s=0[outv];overlay;aresample" \e
               -map [outv]\*(Aq -an        out1.mp4 \e
                                        out2.mkv \e
               -map [outv]\*(Aq -map 1:a:0 out3.mkv
.Ve

The above command will fail, as the output pad labelled \f(CW`[outv]\*(C' has been mapped twice.
None of the output files shall be processed.

.Vb 4
        ffmpeg -i A.avi -i B.mp4 -i C.mkv -filter_complex "[1:v]hue=s=0[outv];overlay;aresample" \e
               -an        out1.mp4 \e
                          out2.mkv \e
               -map 1:a:0 out3.mkv
.Ve

This command above will also fail as the hue filter output has a label, \f(CW`[outv]\*(C',
and hasn't been mapped anywhere.

The command should be modified as follows,

.Vb 4
        ffmpeg -i A.avi -i B.mp4 -i C.mkv -filter_complex "[1:v]hue=s=0,split=2[outv1][outv2];overlay;aresample" \e
                -map [outv1]\*(Aq -an        out1.mp4 \e
                                          out2.mkv \e
                -map [outv2]\*(Aq -map 1:a:0 out3.mkv
.Ve

The video stream from _B.mp4_ is sent to the hue filter, whose output is cloned once using
the split filter, and both outputs labelled. Then a copy each is mapped to the first and third
output files.

The overlay filter, requiring two video inputs, uses the first two unused video streams. Those
are the streams from _A.avi_ and _C.mkv_. The overlay output isn't labelled, so it is
sent to the first output file _out1.mp4_, regardless of the presence of the \f(CW`-map\*(C' option.

The aresample filter is sent the first unused audio stream, that of _A.avi_. Since this filter
output is also unlabelled, it too is mapped to the first output file. The presence of \f(CW`-an\*(C'
only suppresses automatic or manual stream selection of audio streams, not outputs sent from
filtergraphs. Both these mapped streams shall be ordered before the mapped stream in _out1.mp4_.

The video, audio and subtitle streams mapped to \f(CW`out2.mkv\*(C' are entirely determined by
automatic stream selection.

_out3.mkv_ consists of the cloned video output from the hue filter and the first audio
stream from _B.mp4_.

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

* **-f** _fmt_ **(**_input/output_**)**  
  .IX Item "-f fmt (input/output)"
  Force input or output file format. The format is normally auto detected for input
  files and guessed from the file extension for output files, so this option is not
  needed in most cases.
* **-i** _url_ **(**_input_**)**  
  .IX Item "-i url (input)"
  input file url
* **-y (**_global_**)**  
  .IX Item "-y (global)"
  Overwrite output files without asking.
* **-n (**_global_**)**  
  .IX Item "-n (global)"
  Do not overwrite output files, and exit immediately if a specified
  output file already exists.
* **-stream\_loop** _number_ **(**_input_**)**  
  .IX Item "-stream_loop number (input)"
  Set number of times input stream shall be looped. Loop 0 means no loop,
  loop -1 means infinite loop.
* **-c[:**_stream\_specifier_**]** _codec_ **(**_input/output,per-stream_**)**  
  .IX Item "-c[:stream_specifier] codec (input/output,per-stream)"
* **-codec[:**_stream\_specifier_**]** _codec_ **(**_input/output,per-stream_**)**  
  .IX Item "-codec[:stream_specifier] codec (input/output,per-stream)"
  Select an encoder (when used before an output file) or a decoder (when used
  before an input file) for one or more streams. _codec_ is the name of a
  decoder/encoder or a special value \f(CW`copy\*(C' (output only) to indicate that
  the stream is not to be re-encoded.
  .Sp
  For example
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map 0 -c:v libx264 -c:a copy OUTPUT
  .Ve
  .Sp
  encodes all video streams with libx264 and copies all audio streams.
  .Sp
  For each stream, the last matching \f(CW`c\*(C' option is applied, so
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map 0 -c copy -c:v:1 libx264 -c:a:137 libvorbis OUTPUT
  .Ve
  .Sp
  will copy all the streams except the second video, which will be encoded with
  libx264, and the 138th audio, which will be encoded with libvorbis.
* **-t** _duration_ **(**_input/output_**)**  
  .IX Item "-t duration (input/output)"
  When used as an input option (before \f(CW`-i\*(C'), limit the _duration_ of
  data read from the input file.
  .Sp
  When used as an output option (before an output url), stop writing the
  output after its duration reaches _duration_.
  .Sp
  _duration_ must be a time duration specification,
  see **the Time duration section in the ffmpeg-utils\|(1) manual**.
  .Sp
  -to and -t are mutually exclusive and -t has priority.
* **-to** _position_ **(**_input/output_**)**  
  .IX Item "-to position (input/output)"
  Stop writing the output or reading the input at _position_.
  _position_ must be a time duration specification,
  see **the Time duration section in the ffmpeg-utils\|(1) manual**.
  .Sp
  -to and -t are mutually exclusive and -t has priority.
* **-fs** _limit\_size_ **(**_output_**)**  
  .IX Item "-fs limit_size (output)"
  Set the file size limit, expressed in bytes. No further chunk of bytes is written
  after the limit is exceeded. The size of the output file is slightly more than the
  requested file size.
* **-ss** _position_ **(**_input/output_**)**  
  .IX Item "-ss position (input/output)"
  When used as an input option (before \f(CW`-i\*(C'), seeks in this input file to
  _position_. Note that in most formats it is not possible to seek exactly,
  so **ffmpeg** will seek to the closest seek point before _position_.
  When transcoding and **-accurate\_seek** is enabled (the default), this
  extra segment between the seek point and _position_ will be decoded and
  discarded. When doing stream copy or when **-noaccurate\_seek** is used, it
  will be preserved.
  .Sp
  When used as an output option (before an output url), decodes but discards
  input until the timestamps reach _position_.
  .Sp
  _position_ must be a time duration specification,
  see **the Time duration section in the ffmpeg-utils\|(1) manual**.
* **-sseof** _position_ **(**_input_**)**  
  .IX Item "-sseof position (input)"
  Like the \f(CW`-ss\*(C' option but relative to the \*(L"end of file\*(R". That is negative
  values are earlier in the file, 0 is at \s-1EOF.\s0
* **-itsoffset** _offset_ **(**_input_**)**  
  .IX Item "-itsoffset offset (input)"
  Set the input time offset.
  .Sp
  _offset_ must be a time duration specification,
  see **the Time duration section in the ffmpeg-utils\|(1) manual**.
  .Sp
  The offset is added to the timestamps of the input files. Specifying
  a positive offset means that the corresponding streams are delayed by
  the time duration specified in _offset_.
* **-timestamp** _date_ **(**_output_**)**  
  .IX Item "-timestamp date (output)"
  Set the recording timestamp in the container.
  .Sp
  _date_ must be a date specification,
  see **the Date section in the ffmpeg-utils\|(1) manual**.
* **-metadata[:metadata\_specifier]** _key_**=**_value_ **(**_output,per-metadata_**)**  
  .IX Item "-metadata[:metadata_specifier] key=value (output,per-metadata)"
  Set a metadata key/value pair.
  .Sp
  An optional _metadata\_specifier_ may be given to set metadata
  on streams, chapters or programs. See \f(CW`-map\_metadata\*(C'
  documentation for details.
  .Sp
  This option overrides metadata set with \f(CW`-map\_metadata\*(C'. It is
  also possible to delete metadata by using an empty value.
  .Sp
  For example, for setting the title in the output file:
  .Sp
  .Vb 1
          ffmpeg -i in.avi -metadata title="my title" out.flv
  .Ve
  .Sp
  To set the language of the first audio stream:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -metadata:s:a:0 language=eng OUTPUT
  .Ve
* **-disposition[:stream\_specifier]** _value_ **(**_output,per-stream_**)**  
  .IX Item "-disposition[:stream_specifier] value (output,per-stream)"
  Sets the disposition for a stream.
  .Sp
  This option overrides the disposition copied from the input stream. It is also
  possible to delete the disposition by setting it to 0.
  .Sp
  The following dispositions are recognized:
    * **default**  
      .IX Item "default"
    * **dub**  
      .IX Item "dub"
    * **original**  
      .IX Item "original"
    * **comment**  
      .IX Item "comment"
    * **lyrics**  
      .IX Item "lyrics"
    * **karaoke**  
      .IX Item "karaoke"
    * **forced**  
      .IX Item "forced"
    * **hearing\_impaired**  
      .IX Item "hearing_impaired"
    * **visual\_impaired**  
      .IX Item "visual_impaired"
    * **clean\_effects**  
      .IX Item "clean_effects"
    * **attached\_pic**  
      .IX Item "attached_pic"
    * **captions**  
      .IX Item "captions"
    * **descriptions**  
      .IX Item "descriptions"
    * **dependent**  
      .IX Item "dependent"
    * **metadata**  
      .IX Item "metadata"
      .Sp
      For example, to make the second audio stream the default stream:
      .Sp
      .Vb 1
              ffmpeg -i in.mkv -c copy -disposition:a:1 default out.mkv
      .Ve
      .Sp
      To make the second subtitle stream the default stream and remove the default
      disposition from the first subtitle stream:
      .Sp
      .Vb 1
              ffmpeg -i in.mkv -c copy -disposition:s:0 0 -disposition:s:1 default out.mkv
      .Ve
      .Sp
      To add an embedded cover/thumbnail:
      .Sp
      .Vb 1
              ffmpeg -i in.mp4 -i IMAGE -map 0 -map 1 -c copy -c:v:1 png -disposition:v:1 attached_pic out.mp4
      .Ve
      .Sp
      Not all muxers support embedded thumbnails, and those who do, only support a few formats, like \s-1JPEG\s0 or \s-1PNG.\s0
* **-program [title=**_title_**:][program\_num=**_program\_num_**:]st=**_stream_**[:st=**_stream_**...] (**_output_**)**  
  .IX Item "-program [title=title:][program_num=program_num:]st=stream[:st=stream...] (output)"
  Creates a program with the specified _title_, _program\_num_ and adds the specified
  _stream_(s) to it.
* **-target** _type_ **(**_output_**)**  
  .IX Item "-target type (output)"
  Specify target file type (\f(CW`vcd\*(C', \f(CW\*(C\`svcd\*(C', \f(CW\*(C\`dvd\*(C', \f(CW\*(C\`dv\*(C',
  \f(CW`dv50\*(C'). _type_ may be prefixed with \f(CW\*(C\`pal-\*(C', \f(CW\*(C\`ntsc-\*(C' or
  \f(CW`film-\*(C' to use the corresponding standard. All the format options
  (bitrate, codecs, buffer sizes) are then set automatically. You can just type:
  .Sp
  .Vb 1
          ffmpeg -i myfile.avi -target vcd /tmp/vcd.mpg
  .Ve
  .Sp
  Nevertheless you can specify additional options as long as you know
  they do not conflict with the standard, as in:
  .Sp
  .Vb 1
          ffmpeg -i myfile.avi -target vcd -bf 2 /tmp/vcd.mpg
  .Ve
* **-dn (**_output_**)**  
  .IX Item "-dn (output)"
  Disable data recording. For full manual control see the \f(CW`-map\*(C'
  option.
* **-dframes** _number_ **(**_output_**)**  
  .IX Item "-dframes number (output)"
  Set the number of data frames to output. This is an obsolete alias for
  \f(CW`-frames:d\*(C', which you should use instead.
* **-frames[:**_stream\_specifier_**]** _framecount_ **(**_output,per-stream_**)**  
  .IX Item "-frames[:stream_specifier] framecount (output,per-stream)"
  Stop writing to the stream after _framecount_ frames.
* **-q[:**_stream\_specifier_**]** _q_ **(**_output,per-stream_**)**  
  .IX Item "-q[:stream_specifier] q (output,per-stream)"
* **-qscale[:**_stream\_specifier_**]** _q_ **(**_output,per-stream_**)**  
  .IX Item "-qscale[:stream_specifier] q (output,per-stream)"
  Use fixed quality scale (\s-1VBR\s0). The meaning of _q_/_qscale_ is
  codec-dependent.
  If _qscale_ is used without a _stream\_specifier_ then it applies only
  to the video stream, this is to maintain compatibility with previous behavior
  and as specifying the same codec specific value to 2 different codecs that is
  audio and video generally is not what is intended when no stream_specifier is
  used.
* **-filter[:**_stream\_specifier_**]** _filtergraph_ **(**_output,per-stream_**)**  
  .IX Item "-filter[:stream_specifier] filtergraph (output,per-stream)"
  Create the filtergraph specified by _filtergraph_ and use it to
  filter the stream.
  .Sp
  _filtergraph_ is a description of the filtergraph to apply to
  the stream, and must have a single input and a single output of the
  same type of the stream. In the filtergraph, the input is associated
  to the label \f(CW`in\*(C', and the output to the label \f(CW\*(C\`out\*(C'. See
  the ffmpeg-filters manual for more information about the filtergraph
  syntax.
  .Sp
  See the **-filter_complex option** if you
  want to create filtergraphs with multiple inputs and/or outputs.
* **-filter\_script[:**_stream\_specifier_**]** _filename_ **(**_output,per-stream_**)**  
  .IX Item "-filter_script[:stream_specifier] filename (output,per-stream)"
  This option is similar to **-filter**, the only difference is that its
  argument is the name of the file from which a filtergraph description is to be
  read.
* **-filter\_threads** _nb\_threads_ **(**_global_**)**  
  .IX Item "-filter_threads nb_threads (global)"
  Defines how many threads are used to process a filter pipeline. Each pipeline
  will produce a thread pool with this many threads available for parallel processing.
  The default is the number of available CPUs.
* **-pre[:**_stream\_specifier_**]** _preset\_name_ **(**_output,per-stream_**)**  
  .IX Item "-pre[:stream_specifier] preset_name (output,per-stream)"
  Specify the preset for matching stream(s).
* **-stats (**_global_**)**  
  .IX Item "-stats (global)"
  Print encoding progress/statistics. It is on by default, to explicitly
  disable it you need to specify \f(CW`-nostats\*(C'.
* **-progress** _url_ **(**_global_**)**  
  .IX Item "-progress url (global)"
  Send program-friendly progress information to _url_.
  .Sp
  Progress information is written approximately every second and at the end of
  the encoding process. It is made of "_key_=_value_" lines. _key_
  consists of only alphanumeric characters. The last key of a sequence of
  progress information is always progress\*(R".
* **-stdin**  
  .IX Item "-stdin"
  Enable interaction on standard input. On by default unless standard input is
  used as an input. To explicitly disable interaction you need to specify
  \f(CW`-nostdin\*(C'.
  .Sp
  Disabling interaction on standard input is useful, for example, if
  ffmpeg is in the background process group. Roughly the same result can
  be achieved with \f(CW`ffmpeg ... &lt; /dev/null\*(C' but it requires a
  shell.
* **-debug_ts (**_global_**)**  
  .IX Item "-debug_ts (global)"
  Print timestamp information. It is off by default. This option is
  mostly useful for testing and debugging purposes, and the output
  format may change from one version to another, so it should not be
  employed by portable scripts.
  .Sp
  See also the option \f(CW`-fdebug ts\*(C'.
* **-attach** _filename_ **(**_output_**)**  
  .IX Item "-attach filename (output)"
  Add an attachment to the output file. This is supported by a few formats
  like Matroska for e.g. fonts used in rendering subtitles. Attachments
  are implemented as a specific type of stream, so this option will add
  a new stream to the file. It is then possible to use per-stream options
  on this stream in the usual way. Attachment streams created with this
  option will be created after all the other streams (i.e. those created
  with \f(CW`-map\*(C' or automatic mappings).
  .Sp
  Note that for Matroska you also have to set the mimetype metadata tag:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -attach DejaVuSans.ttf -metadata:s:2 mimetype=application/x-truetype-font out.mkv
  .Ve
  .Sp
  (assuming that the attachment stream will be third in the output file).
* **-dump\_attachment[:**_stream\_specifier_**]** _filename_ **(**_input,per-stream_**)**  
  .IX Item "-dump_attachment[:stream_specifier] filename (input,per-stream)"
  Extract the matching attachment stream into a file named _filename_. If
  _filename_ is empty, then the value of the \f(CW`filename\*(C' metadata tag
  will be used.
  .Sp
  E.g. to extract the first attachment to a file named 'out.ttf':
  .Sp
  .Vb 1
          ffmpeg -dump_attachment:t:0 out.ttf -i INPUT
  .Ve
  .Sp
  To extract all attachments to files determined by the \f(CW`filename\*(C' tag:
  .Sp
  .Vb 1
          ffmpeg -dump_attachment:t "" -i INPUT
  .Ve
  .Sp
  Technical note  attachments are implemented as codec extradata, so this
  option can actually be used to extract extradata from any stream, not just
  attachments.
* **-noautorotate**  
  .IX Item "-noautorotate"
  Disable automatically rotating video based on file metadata.

<a name="video-options"></a>

### Video Options

.IX Subsection "Video Options"

* **-vframes** _number_ **(**_output_**)**  
  .IX Item "-vframes number (output)"
  Set the number of video frames to output. This is an obsolete alias for
  \f(CW`-frames:v\*(C', which you should use instead.
* **-r[:**_stream\_specifier_**]** _fps_ **(**_input/output,per-stream_**)**  
  .IX Item "-r[:stream_specifier] fps (input/output,per-stream)"
  Set frame rate (Hz value, fraction or abbreviation).
  .Sp
  As an input option, ignore any timestamps stored in the file and instead
  generate timestamps assuming constant frame rate _fps_.
  This is not the same as the **-framerate** option used for some input formats
  like image2 or v4l2 (it used to be the same in older versions of FFmpeg).
  If in doubt use **-framerate** instead of the input option **-r**.
  .Sp
  As an output option, duplicate or drop input frames to achieve constant output
  frame rate _fps_.
* **-s[:**_stream\_specifier_**]** _size_ **(**_input/output,per-stream_**)**  
  .IX Item "-s[:stream_specifier] size (input/output,per-stream)"
  Set frame size.
  .Sp
  As an input option, this is a shortcut for the **video\_size** private
  option, recognized by some demuxers for which the frame size is either not
  stored in the file or is configurable  e.g. raw video or video grabbers.
  .Sp
  As an output option, this inserts the \f(CW`scale\*(C' video filter to the
  _end_ of the corresponding filtergraph. Please use the \f(CW`scale\*(C' filter
  directly to insert it at the beginning or some other place.
  .Sp
  The format is **wxh** (default - same as source).
* **-aspect[:**_stream\_specifier_**]** _aspect_ **(**_output,per-stream_**)**  
  .IX Item "-aspect[:stream_specifier] aspect (output,per-stream)"
  Set the video display aspect ratio specified by _aspect_.
  .Sp
  _aspect_ can be a floating point number string, or a string of the
  form _num_:_den_, where _num_ and _den_ are the
  numerator and denominator of the aspect ratio. For example 4:3\*(R",
  16:9\*(R", \*(L"1.3333\*(R", and \*(L"1.7777\*(R" are valid argument values.
  .Sp
  If used together with **-vcodec copy**, it will affect the aspect ratio
  stored at container level, but not the aspect ratio stored in encoded
  frames, if it exists.
* **-vn (**_output_**)**  
  .IX Item "-vn (output)"
  Disable video recording. For full manual control see the \f(CW`-map\*(C'
  option.
* **-vcodec** _codec_ **(**_output_**)**  
  .IX Item "-vcodec codec (output)"
  Set the video codec. This is an alias for \f(CW`-codec:v\*(C'.
* **-pass[:**_stream\_specifier_**]** _n_ **(**_output,per-stream_**)**  
  .IX Item "-pass[:stream_specifier] n (output,per-stream)"
  Select the pass number (1 or 2). It is used to do two-pass
  video encoding. The statistics of the video are recorded in the first
  pass into a log file (see also the option -passlogfile),
  and in the second pass that log file is used to generate the video
  at the exact requested bitrate.
  On pass 1, you may just deactivate audio and set output to null,
  examples for Windows and Unix:
  .Sp
  .Vb 2
          ffmpeg -i foo.mov -c:v libxvid -pass 1 -an -f rawvideo -y NUL
          ffmpeg -i foo.mov -c:v libxvid -pass 1 -an -f rawvideo -y /dev/null
  .Ve
* **-passlogfile[:**_stream\_specifier_**]** _prefix_ **(**_output,per-stream_**)**  
  .IX Item "-passlogfile[:stream_specifier] prefix (output,per-stream)"
  Set two-pass log file name prefix to _prefix_, the default file name
  prefix is \`\`ffmpeg2pass''. The complete file name will be
  _\s-1PREFIX-N\s0.log_, where N is a number specific to the output
  stream
* **-vf** _filtergraph_ **(**_output_**)**  
  .IX Item "-vf filtergraph (output)"
  Create the filtergraph specified by _filtergraph_ and use it to
  filter the stream.
  .Sp
  This is an alias for \f(CW`-filter:v\*(C', see the **-filter option**.

<a name="advanced-video-options"></a>

### Advanced Video options

.IX Subsection "Advanced Video options"

* **-pix\_fmt[:**_stream\_specifier_**]** _format_ **(**_input/output,per-stream_**)**  
  .IX Item "-pix_fmt[:stream_specifier] format (input/output,per-stream)"
  Set pixel format. Use \f(CW`-pix\_fmts\*(C' to show all the supported
  pixel formats.
  If the selected pixel format can not be selected, ffmpeg will print a
  warning and select the best pixel format supported by the encoder.
  If _pix\_fmt_ is prefixed by a \f(CW`+\*(C', ffmpeg will exit with an error
  if the requested pixel format can not be selected, and automatic conversions
  inside filtergraphs are disabled.
  If _pix\_fmt_ is a single \f(CW`+\*(C', ffmpeg selects the same pixel format
  as the input (or graph output) and automatic conversions are disabled.
* **-sws\_flags** _flags_ **(**_input/output_**)**  
  .IX Item "-sws_flags flags (input/output)"
  Set SwScaler flags.
* **-rc\_override[:**_stream\_specifier_**]** _override_ **(**_output,per-stream_**)**  
  .IX Item "-rc_override[:stream_specifier] override (output,per-stream)"
  Rate control override for specific intervals, formatted as int,int,int\*(R"
  list separated with slashes. Two first values are the beginning and
  end frame numbers, last one is quantizer to use if positive, or quality
  factor if negative.
* **-ilme**  
  .IX Item "-ilme"
  Force interlacing support in encoder (\s-1MPEG-2\s0 and \s-1MPEG-4\s0 only).
  Use this option if your input file is interlaced and you want
  to keep the interlaced format for minimum losses.
  The alternative is to deinterlace the input stream with
  **-deinterlace**, but deinterlacing introduces losses.
* **-psnr**  
  .IX Item "-psnr"
  Calculate \s-1PSNR\s0 of compressed frames.
* **-vstats**  
  .IX Item "-vstats"
  Dump video coding statistics to _vstats\_HHMMSS.log_.
* **-vstats\_file** _file_  
  .IX Item "-vstats_file file"
  Dump video coding statistics to _file_.
* **-vstats\_version** _file_  
  .IX Item "-vstats_version file"
  Specifies which version of the vstats format to use. Default is 2.
  .Sp
  version = 1 :
  .Sp
  \f(CW`frame= %5d q= %2.1f PSNR= %6.2f f_size= %6d s_size= %8.0fkB time= %0.3f br= %7.1fkbits/s avg_br= %7.1fkbits/s\*(C'
  .Sp
  version &gt; 1:
  .Sp
  \f(CW`out= %2d st= %2d frame= %5d q= %2.1f PSNR= %6.2f f_size= %6d s_size= %8.0fkB time= %0.3f br= %7.1fkbits/s avg_br= %7.1fkbits/s\*(C'
* **-top[:**_stream\_specifier_**]** _n_ **(**_output,per-stream_**)**  
  .IX Item "-top[:stream_specifier] n (output,per-stream)"
  top=1/bottom=0/auto=-1 field first
* **-dc** _precision_  
  .IX Item "-dc precision"
  Intra_dc_precision.
* **-vtag** _fourcc/tag_ **(**_output_**)**  
  .IX Item "-vtag fourcc/tag (output)"
  Force video tag/fourcc. This is an alias for \f(CW`-tag:v\*(C'.
* **-qphist (**_global_**)**  
  .IX Item "-qphist (global)"
  Show \s-1QP\s0 histogram
* **-vbsf** _bitstream\_filter_  
  .IX Item "-vbsf bitstream_filter"
  Deprecated see -bsf
* **-force\_key\_frames[:**_stream\_specifier_**]** _time_**[,**_time_**...] (**_output,per-stream_**)**  
  .IX Item "-force_key_frames[:stream_specifier] time[,time...] (output,per-stream)"
* **-force\_key\_frames[:**_stream\_specifier_**] expr:**_expr_ **(**_output,per-stream_**)**  
  .IX Item "-force_key_frames[:stream_specifier] expr:expr (output,per-stream)"
  Force key frames at the specified timestamps, more precisely at the first
  frames after each specified time.
  .Sp
  If the argument is prefixed with \f(CW`expr:\*(C', the string _expr_
  is interpreted like an expression and is evaluated for each frame. A
  key frame is forced in case the evaluation is non-zero.
  .Sp
  If one of the times is "\f(CW`chapters\*(C'[_delta_]", it is expanded into
  the time of the beginning of all chapters in the file, shifted by
  _delta_, expressed as a time in seconds.
  This option can be useful to ensure that a seek point is present at a
  chapter mark or any other designated place in the output file.
  .Sp
  For example, to insert a key frame at 5 minutes, plus key frames 0.1 second
  before the beginning of every chapter:
  .Sp
  .Vb 1
          -force_key_frames 0:05:00,chapters-0.1
  .Ve
  .Sp
  The expression in _expr_ can contain the following constants:
    * **n**  
      .IX Item "n"
      the number of current processed frame, starting from 0
    * **n\_forced**  
      .IX Item "n_forced"
      the number of forced frames
    * **prev\_forced\_n**  
      .IX Item "prev_forced_n"
      the number of the previous forced frame, it is \f(CW`NAN\*(C' when no
      keyframe was forced yet
    * **prev\_forced\_t**  
      .IX Item "prev_forced_t"
      the time of the previous forced frame, it is \f(CW`NAN\*(C' when no
      keyframe was forced yet
    * **t**  
      .IX Item "t"
      the time of the current processed frame
      .Sp
      For example to force a key frame every 5 seconds, you can specify:
      .Sp
      .Vb 1
              -force_key_frames expr:gte(t,n_forced*5)
      .Ve
      .Sp
      To force a key frame 5 seconds after the time of the last forced one,
      starting from second 13:
      .Sp
      .Vb 1
              -force_key_frames expr:if(isnan(prev_forced_t),gte(t,13),gte(t,prev_forced_t+5))
      .Ve
      .Sp
      Note that forcing too many keyframes is very harmful for the lookahead
      algorithms of certain encoders: using fixed-GOP options or similar
      would be more efficient.
* **-copyinkf[:**_stream\_specifier_**] (**_output,per-stream_**)**  
  .IX Item "-copyinkf[:stream_specifier] (output,per-stream)"
  When doing stream copy, copy also non-key frames found at the
  beginning.
* **-init\_hw\_device** _type_**[=**_name_**][:**_device_**[,**_key=value_**...]]**  
  .IX Item "-init_hw_device type[=name][:device[,key=value...]]"
  Initialise a new hardware device of type _type_ called _name_, using the
  given device parameters.
  If no name is specified it will receive a default name of the form "_type_\f(CW%d".
  .Sp
  The meaning of _device_ and the following arguments depends on the
  device type:
    * **cuda**  
      .IX Item "cuda"
      _device_ is the number of the \s-1CUDA\s0 device.
    * **dxva2**  
      .IX Item "dxva2"
      _device_ is the number of the Direct3D 9 display adapter.
    * **vaapi**  
      .IX Item "vaapi"
      _device_ is either an X11 display name or a \s-1DRM\s0 render node.
      If not specified, it will attempt to open the default X11 display (_\f(CI$DISPLAY_)
      and then the first \s-1DRM\s0 render node (_/dev/dri/renderD128_).
    * **vdpau**  
      .IX Item "vdpau"
      _device_ is an X11 display name.
      If not specified, it will attempt to open the default X11 display (_\f(CI$DISPLAY_).
    * **qsv**  
      .IX Item "qsv"
      _device_ selects a value in **MFX\_IMPL\_***. Allowed values are:
        * **auto**  
          .IX Item "auto"
        * **sw**  
          .IX Item "sw"
        * **hw**  
          .IX Item "hw"
        * **auto\_any**  
          .IX Item "auto_any"
        * **hw\_any**  
          .IX Item "hw_any"
        * **hw2**  
          .IX Item "hw2"
        * **hw3**  
          .IX Item "hw3"
        * **hw4**  
          .IX Item "hw4"
          .Sp
          If not specified, **auto\_any** is used.
          (Note that it may be easier to achieve the desired result for \s-1QSV\s0 by creating the
          platform-appropriate subdevice (**dxva2** or **vaapi**) and then deriving a
          \s-1QSV\s0 device from that.)
    * **opencl**  
      .IX Item "opencl"
      _device_ selects the platform and device as _platform\_index.device\_index_.
      .Sp
      The set of devices can also be filtered using the key-value pairs to find only
      devices matching particular platform or device strings.
      .Sp
      The strings usable as filters are:
        * **platform\_profile**  
          .IX Item "platform_profile"
        * **platform\_version**  
          .IX Item "platform_version"
        * **platform\_name**  
          .IX Item "platform_name"
        * **platform\_vendor**  
          .IX Item "platform_vendor"
        * **platform\_extensions**  
          .IX Item "platform_extensions"
        * **device\_name**  
          .IX Item "device_name"
        * **device\_vendor**  
          .IX Item "device_vendor"
        * **driver\_version**  
          .IX Item "driver_version"
        * **device\_version**  
          .IX Item "device_version"
        * **device\_profile**  
          .IX Item "device_profile"
        * **device\_extensions**  
          .IX Item "device_extensions"
        * **device\_type**  
          .IX Item "device_type"
          .Sp
          The indices and filters must together uniquely select a device.
          .Sp
          Examples:
        * _-init_hw_device opencl:0.1_  
          .IX Item "-init_hw_device opencl:0.1"
          Choose the second device on the first platform.
        * _-init_hw_device opencl:,device\_name=Foo9000_  
          .IX Item "-init_hw_device opencl:,device_name=Foo9000"
          Choose the device with a name containing the string _Foo9000_.
        * _-init_hw_device opencl:1,device\_type=gpu,device\_extensions=cl\_khr\_fp16_  
          .IX Item "-init_hw_device opencl:1,device_type=gpu,device_extensions=cl_khr_fp16"
          Choose the \s-1GPU\s0 device on the second platform supporting the _cl\_khr\_fp16_
          extension.
* **-init\_hw\_device** _type_**[=**_name_**]@**_source_  
  .IX Item "-init_hw_device type[=name]@source"
  Initialise a new hardware device of type _type_ called _name_,
  deriving it from the existing device with the name _source_.
* **-init_hw_device list**  
  .IX Item "-init_hw_device list"
  List all hardware device types supported in this build of ffmpeg.
* **-filter\_hw\_device** _name_  
  .IX Item "-filter_hw_device name"
  Pass the hardware device called _name_ to all filters in any filter graph.
  This can be used to set the device to upload to with the \f(CW`hwupload\*(C' filter,
  or the device to map to with the \f(CW`hwmap\*(C' filter.  Other filters may also
  make use of this parameter when they require a hardware device.  Note that this
  is typically only required when the input is not already in hardware frames -
  when it is, filters will derive the device they require from the context of the
  frames they receive as input.
  .Sp
  This is a global setting, so all filters will receive the same device.
* **-hwaccel[:**_stream\_specifier_**]** _hwaccel_ **(**_input,per-stream_**)**  
  .IX Item "-hwaccel[:stream_specifier] hwaccel (input,per-stream)"
  Use hardware acceleration to decode the matching stream(s). The allowed values
  of _hwaccel_ are:
    * **none**  
      .IX Item "none"
      Do not use any hardware acceleration (the default).
    * **auto**  
      .IX Item "auto"
      Automatically select the hardware acceleration method.
    * **vdpau**  
      .IX Item "vdpau"
      Use \s-1VDPAU\s0 (Video Decode and Presentation \s-1API\s0 for Unix) hardware acceleration.
    * **dxva2**  
      .IX Item "dxva2"
      Use \s-1DXVA2\s0 (DirectX Video Acceleration) hardware acceleration.
    * **vaapi**  
      .IX Item "vaapi"
      Use \s-1VAAPI\s0 (Video Acceleration \s-1API\s0) hardware acceleration.
    * **qsv**  
      .IX Item "qsv"
      Use the Intel QuickSync Video acceleration for video transcoding.
      .Sp
      Unlike most other values, this option does not enable accelerated decoding (that
      is used automatically whenever a qsv decoder is selected), but accelerated
      transcoding, without copying the frames into the system memory.
      .Sp
      For it to work, both the decoder and the encoder must support \s-1QSV\s0 acceleration
      and no filters must be used.
      .Sp
      This option has no effect if the selected hwaccel is not available or not
      supported by the chosen decoder.
      .Sp
      Note that most acceleration methods are intended for playback and will not be
      faster than software decoding on modern CPUs. Additionally, **ffmpeg**
      will usually need to copy the decoded frames from the \s-1GPU\s0 memory into the system
      memory, resulting in further performance loss. This option is thus mainly
      useful for testing.
* **-hwaccel\_device[:**_stream\_specifier_**]** _hwaccel\_device_ **(**_input,per-stream_**)**  
  .IX Item "-hwaccel_device[:stream_specifier] hwaccel_device (input,per-stream)"
  Select a device to use for hardware acceleration.
  .Sp
  This option only makes sense when the **-hwaccel** option is also specified.
  It can either refer to an existing device created with **-init\_hw\_device**
  by name, or it can create a new device as if
  **-init\_hw\_device** _type_:_hwaccel\_device_
  were called immediately before.
* **-hwaccels**  
  .IX Item "-hwaccels"
  List all hardware acceleration methods supported in this build of ffmpeg.

<a name="audio-options"></a>

### Audio Options

.IX Subsection "Audio Options"

* **-aframes** _number_ **(**_output_**)**  
  .IX Item "-aframes number (output)"
  Set the number of audio frames to output. This is an obsolete alias for
  \f(CW`-frames:a\*(C', which you should use instead.
* **-ar[:**_stream\_specifier_**]** _freq_ **(**_input/output,per-stream_**)**  
  .IX Item "-ar[:stream_specifier] freq (input/output,per-stream)"
  Set the audio sampling frequency. For output streams it is set by
  default to the frequency of the corresponding input stream. For input
  streams this option only makes sense for audio grabbing devices and raw
  demuxers and is mapped to the corresponding demuxer options.
* **-aq** _q_ **(**_output_**)**  
  .IX Item "-aq q (output)"
  Set the audio quality (codec-specific, \s-1VBR\s0). This is an alias for -q:a.
* **-ac[:**_stream\_specifier_**]** _channels_ **(**_input/output,per-stream_**)**  
  .IX Item "-ac[:stream_specifier] channels (input/output,per-stream)"
  Set the number of audio channels. For output streams it is set by
  default to the number of input audio channels. For input streams
  this option only makes sense for audio grabbing devices and raw demuxers
  and is mapped to the corresponding demuxer options.
* **-an (**_output_**)**  
  .IX Item "-an (output)"
  Disable audio recording. For full manual control see the \f(CW`-map\*(C'
  option.
* **-acodec** _codec_ **(**_input/output_**)**  
  .IX Item "-acodec codec (input/output)"
  Set the audio codec. This is an alias for \f(CW`-codec:a\*(C'.
* **-sample\_fmt[:**_stream\_specifier_**]** _sample\_fmt_ **(**_output,per-stream_**)**  
  .IX Item "-sample_fmt[:stream_specifier] sample_fmt (output,per-stream)"
  Set the audio sample format. Use \f(CW`-sample\_fmts\*(C' to get a list
  of supported sample formats.
* **-af** _filtergraph_ **(**_output_**)**  
  .IX Item "-af filtergraph (output)"
  Create the filtergraph specified by _filtergraph_ and use it to
  filter the stream.
  .Sp
  This is an alias for \f(CW`-filter:a\*(C', see the **-filter option**.

<a name="advanced-audio-options"></a>

### Advanced Audio options

.IX Subsection "Advanced Audio options"

* **-atag** _fourcc/tag_ **(**_output_**)**  
  .IX Item "-atag fourcc/tag (output)"
  Force audio tag/fourcc. This is an alias for \f(CW`-tag:a\*(C'.
* **-absf** _bitstream\_filter_  
  .IX Item "-absf bitstream_filter"
  Deprecated, see -bsf
* **-guess\_layout\_max** _channels_ **(**_input,per-stream_**)**  
  .IX Item "-guess_layout_max channels (input,per-stream)"
  If some input channel layout is not known, try to guess only if it
  corresponds to at most the specified number of channels. For example, 2
  tells to **ffmpeg** to recognize 1 channel as mono and 2 channels as
  stereo but not 6 channels as 5.1. The default is to always try to guess. Use
  0 to disable all guessing.

<a name="subtitle-options"></a>

### Subtitle options

.IX Subsection "Subtitle options"

* **-scodec** _codec_ **(**_input/output_**)**  
  .IX Item "-scodec codec (input/output)"
  Set the subtitle codec. This is an alias for \f(CW`-codec:s\*(C'.
* **-sn (**_output_**)**  
  .IX Item "-sn (output)"
  Disable subtitle recording. For full manual control see the \f(CW`-map\*(C'
  option.
* **-sbsf** _bitstream\_filter_  
  .IX Item "-sbsf bitstream_filter"
  Deprecated, see -bsf

<a name="advanced-subtitle-options"></a>

### Advanced Subtitle options

.IX Subsection "Advanced Subtitle options"

* **-fix\_sub\_duration**  
  .IX Item "-fix_sub_duration"
  Fix subtitles durations. For each subtitle, wait for the next packet in the
  same stream and adjust the duration of the first to avoid overlap. This is
  necessary with some subtitles codecs, especially \s-1DVB\s0 subtitles, because the
  duration in the original packet is only a rough estimate and the end is
  actually marked by an empty subtitle frame. Failing to use this option when
  necessary can result in exaggerated durations or muxing failures due to
  non-monotonic timestamps.
  .Sp
  Note that this option will delay the output of all data until the next
  subtitle packet is decoded: it may increase memory consumption and latency a
  lot.
* **-canvas\_size** _size_  
  .IX Item "-canvas_size size"
  Set the size of the canvas used to render subtitles.

<a name="advanced-options"></a>

### Advanced options

.IX Subsection "Advanced options"

* **-map [-]**_input\_file\_id_**[:**_stream\_specifier_**][?][,**_sync\_file\_id_**[:**_stream\_specifier_**]] |** _[linklabel]_ **(**_output_**)**  
  .IX Item "-map [-]input_file_id[:stream_specifier][?][,sync_file_id[:stream_specifier]] | [linklabel] (output)"
  Designate one or more input streams as a source for the output file. Each input
  stream is identified by the input file index _input\_file\_id_ and
  the input stream index _input\_stream\_id_ within the input
  file. Both indices start at 0. If specified,
  _sync\_file\_id_:_stream\_specifier_ sets which input stream
  is used as a presentation sync reference.
  .Sp
  The first \f(CW`-map\*(C' option on the command line specifies the
  source for output stream 0, the second \f(CW`-map\*(C' option specifies
  the source for output stream 1, etc.
  .Sp
  A \f(CW`-\*(C' character before the stream identifier creates a \*(L"negative\*(R" mapping.
  It disables matching streams from already created mappings.
  .Sp
  A trailing \f(CW`?\*(C' after the stream index will allow the map to be
  optional: if the map matches no streams the map will be ignored instead
  of failing. Note the map will still fail if an invalid input file index
  is used; such as if the map refers to a non-existent input.
  .Sp
  An alternative _[linklabel]_ form will map outputs from complex filter
  graphs (see the **-filter\_complex** option) to the output file.
  _linklabel_ must correspond to a defined output link label in the graph.
  .Sp
  For example, to map \s-1ALL\s0 streams from the first input file to output
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map 0 output
  .Ve
  .Sp
  For example, if you have two audio streams in the first input file,
  these streams are identified by 0:0\*(R" and \*(L"0:1\*(R". You can use
  \f(CW`-map\*(C' to select which streams to place in an output file. For
  example:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map 0:1 out.wav
  .Ve
  .Sp
  will map the input stream in _\s-1INPUT\s0_ identified by 0:1\*(R" to
  the (single) output stream in _out.wav_.
  .Sp
  For example, to select the stream with index 2 from input file
  _a.mov_ (specified by the identifier 0:2\*(R"), and stream with
  index 6 from input _b.mov_ (specified by the identifier 1:6\*(R"),
  and copy them to the output file _out.mov_:
  .Sp
  .Vb 1
          ffmpeg -i a.mov -i b.mov -c copy -map 0:2 -map 1:6 out.mov
  .Ve
  .Sp
  To select all video and the third audio stream from an input file:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map 0:v -map 0:a:2 OUTPUT
  .Ve
  .Sp
  To map all the streams except the second audio, use negative mappings
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map 0 -map -0:a:1 OUTPUT
  .Ve
  .Sp
  To map the video and audio streams from the first input, and using the
  trailing \f(CW`?\*(C', ignore the audio mapping if no audio streams exist in
  the first input:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map 0:v -map 0:a? OUTPUT
  .Ve
  .Sp
  To pick the English audio stream:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map 0:m:language:eng OUTPUT
  .Ve
  .Sp
  Note that using this option disables the default mappings for this output file.
* **-ignore\_unknown**  
  .IX Item "-ignore_unknown"
  Ignore input streams with unknown type instead of failing if copying
  such streams is attempted.
* **-copy\_unknown**  
  .IX Item "-copy_unknown"
  Allow input streams with unknown type to be copied instead of failing if copying
  such streams is attempted.
* **-map_channel [**_input\_file\_id_**.**_stream\_specifier_**.**_channel\_id_**|-1][?][:**_output\_file\_id_**.**_stream\_specifier_**]**  
  .IX Item "-map_channel [input_file_id.stream_specifier.channel_id|-1][?][:output_file_id.stream_specifier]"
  Map an audio channel from a given input to an output. If
  _output\_file\_id_._stream\_specifier_ is not set, the audio channel will
  be mapped on all the audio streams.
  .Sp
  Using -1\*(R" instead of
  _input\_file\_id_._stream\_specifier_._channel\_id_ will map a muted
  channel.
  .Sp
  A trailing \f(CW`?\*(C' will allow the map_channel to be
  optional: if the map_channel matches no channel the map_channel will be ignored instead
  of failing.
  .Sp
  For example, assuming _\s-1INPUT\s0_ is a stereo audio file, you can switch the
  two audio channels with the following command:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map_channel 0.0.1 -map_channel 0.0.0 OUTPUT
  .Ve
  .Sp
  If you want to mute the first channel and keep the second:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map_channel -1 -map_channel 0.0.1 OUTPUT
  .Ve
  .Sp
  The order of the -map_channel\*(R" option specifies the order of the channels in
  the output stream. The output channel layout is guessed from the number of
  channels mapped (mono if one -map_channel\*(R", stereo if two, etc.). Using \*(L"-ac\*(R"
  in combination of -map_channel\*(R" makes the channel gain levels to be updated if
  input and output channel layouts don't match (for instance two -map_channel\*(R"
  options and -ac 6\*(R").
  .Sp
  You can also extract each channel of an input to specific outputs; the following
  command extracts two channels of the _\s-1INPUT\s0_ audio stream (file 0, stream 0)
  to the respective _\s-1OUTPUT\_CH0\s0_ and _\s-1OUTPUT\_CH1\s0_ outputs:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map_channel 0.0.0 OUTPUT_CH0 -map_channel 0.0.1 OUTPUT_CH1
  .Ve
  .Sp
  The following example splits the channels of a stereo input into two separate
  streams, which are put into the same output file:
  .Sp
  .Vb 1
          ffmpeg -i stereo.wav -map 0:0 -map 0:0 -map_channel 0.0.0:0.0 -map_channel 0.0.1:0.1 -y out.ogg
  .Ve
  .Sp
  Note that currently each output stream can only contain channels from a single
  input stream; you can't for example use -map_channel\*(R" to pick multiple input
  audio channels contained in different streams (from the same or different files)
  and merge them into a single output stream. It is therefore not currently
  possible, for example, to turn two separate mono streams into a single stereo
  stream. However splitting a stereo stream into two single channel mono streams
  is possible.
  .Sp
  If you need this feature, a possible workaround is to use the _amerge_
  filter. For example, if you need to merge a media (here _input.mkv_) with 2
  mono audio streams into one single stereo channel audio stream (and keep the
  video stream), you can use the following command:
  .Sp
  .Vb 1
          ffmpeg -i input.mkv -filter_complex "[0:1] [0:2] amerge" -c:a pcm_s16le -c:v copy output.mkv
  .Ve
  .Sp
  To map the first two audio channels from the first input, and using the
  trailing \f(CW`?\*(C', ignore the audio channel mapping if the first input is
  mono instead of stereo:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -map_channel 0.0.0 -map_channel 0.0.1? OUTPUT
  .Ve
* **-map\_metadata[:**_metadata\_spec\_out_**]** _infile_**[:**_metadata\_spec\_in_**] (**_output,per-metadata_**)**  
  .IX Item "-map_metadata[:metadata_spec_out] infile[:metadata_spec_in] (output,per-metadata)"
  Set metadata information of the next output file from _infile_. Note that
  those are file indices (zero-based), not filenames.
  Optional _metadata\_spec\_in/out_ parameters specify, which metadata to copy.
  A metadata specifier can have the following forms:
    * _g_  
      .IX Item "g"
      global metadata, i.e. metadata that applies to the whole file
    * _s_**[:**_stream\_spec_**]**  
      .IX Item "s[:stream_spec]"
      per-stream metadata. _stream\_spec_ is a stream specifier as described
      in the **Stream specifiers** chapter. In an input metadata specifier, the first
      matching stream is copied from. In an output metadata specifier, all matching
      streams are copied to.
    * _c_**:**_chapter\_index_  
      .IX Item "c:chapter_index"
      per-chapter metadata. _chapter\_index_ is the zero-based chapter index.
    * _p_**:**_program\_index_  
      .IX Item "p:program_index"
      per-program metadata. _program\_index_ is the zero-based program index.
      .Sp
      If metadata specifier is omitted, it defaults to global.
      .Sp
      By default, global metadata is copied from the first input file,
      per-stream and per-chapter metadata is copied along with streams/chapters. These
      default mappings are disabled by creating any mapping of the relevant type. A negative
      file index can be used to create a dummy mapping that just disables automatic copying.
      .Sp
      For example to copy metadata from the first stream of the input file to global metadata
      of the output file:
      .Sp
      .Vb 1
              ffmpeg -i in.ogg -map_metadata 0:s:0 out.mp3
      .Ve
      .Sp
      To do the reverse, i.e. copy global metadata to all audio streams:
      .Sp
      .Vb 1
              ffmpeg -i in.mkv -map_metadata:s:a 0:g out.mkv
      .Ve
      .Sp
      Note that simple \f(CW0 would work as well in this example, since global
      metadata is assumed by default.
* **-map\_chapters** _input\_file\_index_ **(**_output_**)**  
  .IX Item "-map_chapters input_file_index (output)"
  Copy chapters from input file with index _input\_file\_index_ to the next
  output file. If no chapter mapping is specified, then chapters are copied from
  the first input file with at least one chapter. Use a negative file index to
  disable any chapter copying.
* **-benchmark (**_global_**)**  
  .IX Item "-benchmark (global)"
  Show benchmarking information at the end of an encode.
  Shows real, system and user time used and maximum memory consumption.
  Maximum memory consumption is not supported on all systems,
  it will usually display as 0 if not supported.
* **-benchmark_all (**_global_**)**  
  .IX Item "-benchmark_all (global)"
  Show benchmarking information during the encode.
  Shows real, system and user time used in various steps (audio/video encode/decode).
* **-timelimit** _duration_ **(**_global_**)**  
  .IX Item "-timelimit duration (global)"
  Exit after ffmpeg has been running for _duration_ seconds.
* **-dump (**_global_**)**  
  .IX Item "-dump (global)"
  Dump each input packet to stderr.
* **-hex (**_global_**)**  
  .IX Item "-hex (global)"
  When dumping packets, also dump the payload.
* **-re (**_input_**)**  
  .IX Item "-re (input)"
  Read input at native frame rate. Mainly used to simulate a grab device,
  or live input stream (e.g. when reading from a file). Should not be used
  with actual grab devices or live input streams (where it can cause packet
  loss).
  By default **ffmpeg** attempts to read the input(s) as fast as possible.
  This option will slow down the reading of the input(s) to the native frame rate
  of the input(s). It is useful for real-time output (e.g. live streaming).
* **-loop\_output** _number\_of\_times_  
  .IX Item "-loop_output number_of_times"
  Repeatedly loop output for formats that support looping such as animated \s-1GIF\s0
  (0 will loop the output infinitely).
  This option is deprecated, use -loop.
* **-vsync** _parameter_  
  .IX Item "-vsync parameter"
  Video sync method.
  For compatibility reasons old values can be specified as numbers.
  Newly added values will have to be specified as strings always.
    * **0, passthrough**  
      .IX Item "0, passthrough"
      Each frame is passed with its timestamp from the demuxer to the muxer.
    * **1, cfr**  
      .IX Item "1, cfr"
      Frames will be duplicated and dropped to achieve exactly the requested
      constant frame rate.
    * **2, vfr**  
      .IX Item "2, vfr"
      Frames are passed through with their timestamp or dropped so as to
      prevent 2 frames from having the same timestamp.
    * **drop**  
      .IX Item "drop"
      As passthrough but destroys all timestamps, making the muxer generate
      fresh timestamps based on frame-rate.
    * **-1, auto**  
      .IX Item "-1, auto"
      Chooses between 1 and 2 depending on muxer capabilities. This is the
      default method.
      .Sp
      Note that the timestamps may be further modified by the muxer, after this.
      For example, in the case that the format option **avoid\_negative\_ts**
      is enabled.
      .Sp
      With -map you can select from which stream the timestamps should be
      taken. You can leave either video or audio unchanged and sync the
      remaining stream(s) to the unchanged one.
* **-frame\_drop\_threshold** _parameter_  
  .IX Item "-frame_drop_threshold parameter"
  Frame drop threshold, which specifies how much behind video frames can
  be before they are dropped. In frame rate units, so 1.0 is one frame.
  The default is -1.1. One possible usecase is to avoid framedrops in case
  of noisy timestamps or to increase frame drop precision in case of exact
  timestamps.
* **-async** _samples\_per\_second_  
  .IX Item "-async samples_per_second"
  Audio sync method. Stretches/squeezes\*(R" the audio stream to match the timestamps,
  the parameter is the maximum samples per second by which the audio is changed.
  -async 1 is a special case where only the start of the audio stream is corrected
  without any later correction.
  .Sp
  Note that the timestamps may be further modified by the muxer, after this.
  For example, in the case that the format option **avoid\_negative\_ts**
  is enabled.
  .Sp
  This option has been deprecated. Use the \f(CW`aresample\*(C' audio filter instead.
* **-copyts**  
  .IX Item "-copyts"
  Do not process input timestamps, but keep their values without trying
  to sanitize them. In particular, do not remove the initial start time
  offset value.
  .Sp
  Note that, depending on the **vsync** option or on specific muxer
  processing (e.g. in case the format option **avoid\_negative\_ts**
  is enabled) the output timestamps may mismatch with the input
  timestamps even when this option is selected.
* **-start\_at\_zero**  
  .IX Item "-start_at_zero"
  When used with **copyts**, shift input timestamps so they start at zero.
  .Sp
  This means that using e.g. \f(CW`-ss 50\*(C' will make output timestamps start at
  50 seconds, regardless of what timestamp the input file started at.
* **-copytb** _mode_  
  .IX Item "-copytb mode"
  Specify how to set the encoder timebase when stream copying.  _mode_ is an
  integer numeric value, and can assume one of the following values:
    * **1**  
      .IX Item "1"
      Use the demuxer timebase.
      .Sp
      The time base is copied to the output encoder from the corresponding input
      demuxer. This is sometimes required to avoid non monotonically increasing
      timestamps when copying video streams with variable frame rate.
    * **0**  
      .IX Item "0"
      Use the decoder timebase.
      .Sp
      The time base is copied to the output encoder from the corresponding input
      decoder.
    * **-1**  
      .IX Item "-1"
      Try to make the choice automatically, in order to generate a sane output.
      .Sp
      Default value is -1.
* **-enc\_time\_base[:**_stream\_specifier_**]** _timebase_ **(**_output,per-stream_**)**  
  .IX Item "-enc_time_base[:stream_specifier] timebase (output,per-stream)"
  Set the encoder timebase. _timebase_ is a floating point number,
  and can assume one of the following values:
    * **0**  
      .IX Item "0"
      Assign a default value according to the media type.
      .Sp
      For video - use 1/framerate, for audio - use 1/samplerate.
    * **-1**  
      .IX Item "-1"
      Use the input stream timebase when possible.
      .Sp
      If an input stream is not available, the default timebase will be used.
    * **&gt;0**  
      .IX Item "&gt;0"
      Use the provided number as the timebase.
      .Sp
      This field can be provided as a ratio of two integers (e.g. 1:24, 1:48000)
      or as a floating point number (e.g. 0.04166, 2.0833e-5)
      .Sp
      Default value is 0.
* **-bitexact (**_input/output_**)**  
  .IX Item "-bitexact (input/output)"
  Enable bitexact mode for (de)muxer and (de/en)coder
* **-shortest (**_output_**)**  
  .IX Item "-shortest (output)"
  Finish encoding when the shortest input stream ends.
* **-dts\_delta\_threshold**  
  .IX Item "-dts_delta_threshold"
  Timestamp discontinuity delta threshold.
* **-muxdelay** _seconds_ **(**_input_**)**  
  .IX Item "-muxdelay seconds (input)"
  Set the maximum demux-decode delay.
* **-muxpreload** _seconds_ **(**_input_**)**  
  .IX Item "-muxpreload seconds (input)"
  Set the initial demux-decode delay.
* **-streamid** _output-stream-index_**:**_new-value_ **(**_output_**)**  
  .IX Item "-streamid output-stream-index:new-value (output)"
  Assign a new stream-id value to an output stream. This option should be
  specified prior to the output filename to which it applies.
  For the situation where multiple output files exist, a streamid
  may be reassigned to a different value.
  .Sp
  For example, to set the stream 0 \s-1PID\s0 to 33 and the stream 1 \s-1PID\s0 to 36 for
  an output mpegts file:
  .Sp
  .Vb 1
          ffmpeg -i inurl -streamid 0:33 -streamid 1:36 out.ts
  .Ve
* **-bsf[:**_stream\_specifier_**]** _bitstream\_filters_ **(**_output,per-stream_**)**  
  .IX Item "-bsf[:stream_specifier] bitstream_filters (output,per-stream)"
  Set bitstream filters for matching streams. _bitstream\_filters_ is
  a comma-separated list of bitstream filters. Use the \f(CW`-bsfs\*(C' option
  to get the list of bitstream filters.
  .Sp
  .Vb 1
          ffmpeg -i h264.mp4 -c:v copy -bsf:v h264_mp4toannexb -an out.h264
  
          
          ffmpeg -i file.mov -an -vn -bsf:s mov2textsub -c:s copy -f rawvideo sub.txt
  .Ve
* **-tag[:**_stream\_specifier_**]** _codec\_tag_ **(**_input/output,per-stream_**)**  
  .IX Item "-tag[:stream_specifier] codec_tag (input/output,per-stream)"
  Force a tag/fourcc for matching streams.
* **-timecode** _hh_**:**_mm_**:**_ss_**\s-1SEP\s0**_ff_  
  .IX Item "-timecode hh:mm:ssSEPff"
  Specify Timecode for writing. _\s-1SEP\s0_ is ':' for non drop timecode and ';'
  (or '.') for drop.
  .Sp
  .Vb 1
          ffmpeg -i input.mpg -timecode 01:02:03.04 -r 30000/1001 -s ntsc output.mpg
  .Ve
* **-filter\_complex** _filtergraph_ **(**_global_**)**  
  .IX Item "-filter_complex filtergraph (global)"
  Define a complex filtergraph, i.e. one with arbitrary number of inputs and/or
  outputs. For simple graphs  those with one input and one output of the same
  type  see the **-filter** options. _filtergraph_ is a description of
  the filtergraph, as described in the \`\`Filtergraph syntax'' section of the
  ffmpeg-filters manual.
  .Sp
  Input link labels must refer to input streams using the
  \f(CW`[file\_index:stream\_specifier]\*(C' syntax (i.e. the same as **-map**
  uses). If _stream\_specifier_ matches multiple streams, the first one will be
  used. An unlabeled input will be connected to the first unused input stream of
  the matching type.
  .Sp
  Output link labels are referred to with **-map**. Unlabeled outputs are
  added to the first output file.
  .Sp
  Note that with this option it is possible to use only lavfi sources without
  normal input files.
  .Sp
  For example, to overlay an image over video
  .Sp
  .Vb 2
          ffmpeg -i video.mkv -i image.png -filter_complex [0:v][1:v]overlay[out]\*(Aq -map
          [out]\*(Aq out.mkv
  .Ve
  .Sp
  Here \f(CW`[0:v]\*(C' refers to the first video stream in the first input file,
  which is linked to the first (main) input of the overlay filter. Similarly the
  first video stream in the second input is linked to the second (overlay) input
  of overlay.
  .Sp
  Assuming there is only one video stream in each input file, we can omit input
  labels, so the above is equivalent to
  .Sp
  .Vb 2
          ffmpeg -i video.mkv -i image.png -filter_complex overlay[out]\*(Aq -map
          [out]\*(Aq out.mkv
  .Ve
  .Sp
  Furthermore we can omit the output label and the single output from the filter
  graph will be added to the output file automatically, so we can simply write
  .Sp
  .Vb 1
          ffmpeg -i video.mkv -i image.png -filter_complex overlay\*(Aq out.mkv
  .Ve
  .Sp
  To generate 5 seconds of pure red video using lavfi \f(CW`color\*(C' source:
  .Sp
  .Vb 1
          ffmpeg -filter_complex color=c=red\*(Aq -t 5 out.mkv
  .Ve
* **-filter\_complex\_threads** _nb\_threads_ **(**_global_**)**  
  .IX Item "-filter_complex_threads nb_threads (global)"
  Defines how many threads are used to process a filter_complex graph.
  Similar to filter_threads but used for \f(CW`-filter\_complex\*(C' graphs only.
  The default is the number of available CPUs.
* **-lavfi** _filtergraph_ **(**_global_**)**  
  .IX Item "-lavfi filtergraph (global)"
  Define a complex filtergraph, i.e. one with arbitrary number of inputs and/or
  outputs. Equivalent to **-filter\_complex**.
* **-filter\_complex\_script** _filename_ **(**_global_**)**  
  .IX Item "-filter_complex_script filename (global)"
  This option is similar to **-filter\_complex**, the only difference is that
  its argument is the name of the file from which a complex filtergraph
  description is to be read.
* **-accurate_seek (**_input_**)**  
  .IX Item "-accurate_seek (input)"
  This option enables or disables accurate seeking in input files with the
  **-ss** option. It is enabled by default, so seeking is accurate when
  transcoding. Use **-noaccurate\_seek** to disable it, which may be useful
  e.g. when copying some streams and transcoding the others.
* **-seek_timestamp (**_input_**)**  
  .IX Item "-seek_timestamp (input)"
  This option enables or disables seeking by timestamp in input files with the
  **-ss** option. It is disabled by default. If enabled, the argument
  to the **-ss** option is considered an actual timestamp, and is not
  offset by the start time of the file. This matters only for files which do
  not start from timestamp 0, such as transport streams.
* **-thread\_queue\_size** _size_ **(**_input_**)**  
  .IX Item "-thread_queue_size size (input)"
  This option sets the maximum number of queued packets when reading from the
  file or device. With low latency / high rate live streams, packets may be
  discarded if they are not read in a timely manner; raising this value can
  avoid it.
* **-sdp\_file** _file_ **(**_global_**)**  
  .IX Item "-sdp_file file (global)"
  Print sdp information for an output stream to _file_.
  This allows dumping sdp information when at least one output isn't an
  rtp stream. (Requires at least one of the output formats to be rtp).
* **-discard (**_input_**)**  
  .IX Item "-discard (input)"
  Allows discarding specific streams or frames of streams at the demuxer.
  Not all demuxers support this.
    * **none**  
      .IX Item "none"
      Discard no frame.
    * **default**  
      .IX Item "default"
      Default, which discards no frames.
    * **noref**  
      .IX Item "noref"
      Discard all non-reference frames.
    * **bidir**  
      .IX Item "bidir"
      Discard all bidirectional frames.
    * **nokey**  
      .IX Item "nokey"
      Discard all frames excepts keyframes.
    * **all**  
      .IX Item "all"
      Discard all frames.
* **-abort\_on** _flags_ **(**_global_**)**  
  .IX Item "-abort_on flags (global)"
  Stop and abort on various conditions. The following flags are available:
    * **empty\_output**  
      .IX Item "empty_output"
      No packets were passed to the muxer, the output is empty.
* **-xerror (**_global_**)**  
  .IX Item "-xerror (global)"
  Stop and exit on error
* **-max\_muxing\_queue\_size** _packets_ **(**_output,per-stream_**)**  
  .IX Item "-max_muxing_queue_size packets (output,per-stream)"
  When transcoding audio and/or video streams, ffmpeg will not begin writing into
  the output until it has one packet for each such stream. While waiting for that
  to happen, packets for other streams are buffered. This option sets the size of
  this buffer, in packets, for the matching output stream.
  .Sp
  The default value of this option should be high enough for most uses, so only
  touch this option if you are sure that you need it.

As a special exception, you can use a bitmap subtitle stream as input: it
will be converted into a video with the same size as the largest video in
the file, or 720x576 if no video is present. Note that this is an
experimental and temporary solution. It will be removed once libavfilter has
proper support for subtitles.

For example, to hardcode subtitles on top of a DVB-T recording stored in
MPEG-TS format, delaying the subtitles by 1 second:

.Vb 3
        ffmpeg -i input.ts -filter_complex \e
          [#0x2ef] setpts=PTS+1/TB [sub] ; [#0x2d0] [sub] overlay\*(Aq \e
          -sn -map #0x2dc\*(Aq output.mkv
.Ve

(0x2d0, 0x2dc and 0x2ef are the MPEG-TS PIDs of respectively the video,
audio and subtitles streams; 0:0, 0:3 and 0:7 would have worked too)

<a name="preset-files"></a>

### Preset files

.IX Subsection "Preset files"
A preset file contains a sequence of _option_=_value_ pairs,
one for each line, specifying a sequence of options which would be
awkward to specify on the command line. Lines starting with the hash
('#') character are ignored and are used to provide comments. Check
the _presets_ directory in the FFmpeg source tree for examples.

There are two types of preset files: ffpreset and avpreset files.

_ffpreset files_
.IX Subsection "ffpreset files"

ffpreset files are specified with the \f(CW`vpre\*(C', \f(CW\*(C\`apre\*(C',
\f(CW`spre\*(C', and \f(CW\*(C\`fpre\*(C' options. The \f(CW\*(C\`fpre\*(C' option takes the
filename of the preset instead of a preset name as input and can be
used for any kind of codec. For the \f(CW`vpre\*(C', \f(CW\*(C\`apre\*(C', and
\f(CW`spre\*(C' options, the options specified in a preset file are
applied to the currently selected codec of the same type as the preset
option.

The argument passed to the \f(CW`vpre\*(C', \f(CW\*(C\`apre\*(C', and \f(CW\*(C\`spre\*(C'
preset options identifies the preset file to use according to the
following rules:

First ffmpeg searches for a file named _arg_.ffpreset in the
directories _\f(CI$FFMPEG\_DATADIR_ (if set), and _\f(CI$HOME/.ffmpeg_, and in
the datadir defined at configuration time (usually _PREFIX/share/ffmpeg_)
or in a _ffpresets_ folder along the executable on win32,
in that order. For example, if the argument is \f(CW`libvpx-1080p\*(C', it will
search for the file _libvpx-1080p.ffpreset_.

If no such file is found, then ffmpeg will search for a file named
_codec\_name_-_arg_.ffpreset in the above-mentioned
directories, where _codec\_name_ is the name of the codec to which
the preset file options will be applied. For example, if you select
the video codec with \f(CW`-vcodec libvpx\*(C' and use \f(CW\*(C\`-vpre 1080p\*(C',
then it will search for the file _libvpx-1080p.ffpreset_.

_avpreset files_
.IX Subsection "avpreset files"

avpreset files are specified with the \f(CW`pre\*(C' option. They work similar to
ffpreset files, but they only allow encoder- specific options. Therefore, an
_option_=_value_ pair specifying an encoder cannot be used.

When the \f(CW`pre\*(C' option is specified, ffmpeg will look for files with the
suffix .avpreset in the directories _\f(CI$AVCONV\_DATADIR_ (if set), and
_\f(CI$HOME/.avconv_, and in the datadir defined at configuration time (usually
_PREFIX/share/ffmpeg_), in that order.

First ffmpeg searches for a file named _codec\_name_-_arg_.avpreset in
the above-mentioned directories, where _codec\_name_ is the name of the codec
to which the preset file options will be applied. For example, if you select the
video codec with \f(CW`-vcodec libvpx\*(C' and use \f(CW\*(C\`-pre 1080p\*(C', then it will
search for the file _libvpx-1080p.avpreset_.

If no such file is found, then ffmpeg will search for a file named
_arg_.avpreset in the same directories.

<a name="examples"></a>

# Examples

.IX Header "EXAMPLES"

<a name="video-and-audio-grabbing"></a>

### Video and Audio grabbing

.IX Subsection "Video and Audio grabbing"
If you specify the input format and device then ffmpeg can grab video
and audio directly.

.Vb 1
        ffmpeg -f oss -i /dev/dsp -f video4linux2 -i /dev/video0 /tmp/out.mpg
.Ve

Or with an \s-1ALSA\s0 audio source (mono input, card id 1) instead of \s-1OSS:\s0

.Vb 1
        ffmpeg -f alsa -ac 1 -i hw:1 -f video4linux2 -i /dev/video0 /tmp/out.mpg
.Ve

Note that you must activate the right video source and channel before
launching ffmpeg with any \s-1TV\s0 viewer such as
&lt;**http://linux.bytesex.org/xawtv/**&gt; by Gerd Knorr. You also
have to set the audio recording levels correctly with a
standard mixer.

<a name="x11-grabbing"></a>

### X11 grabbing

.IX Subsection "X11 grabbing"
Grab the X11 display with ffmpeg via

.Vb 1
        ffmpeg -f x11grab -video_size cif -framerate 25 -i :0.0 /tmp/out.mpg
.Ve

0.0 is display.screen number of your X11 server, same as
the \s-1DISPLAY\s0 environment variable.

.Vb 1
        ffmpeg -f x11grab -video_size cif -framerate 25 -i :0.0+10,20 /tmp/out.mpg
.Ve

0.0 is display.screen number of your X11 server, same as the \s-1DISPLAY\s0 environment
variable. 10 is the x-offset and 20 the y-offset for the grabbing.

<a name="video-and-audio-file-format-conversion"></a>

### Video and Audio file format conversion

.IX Subsection "Video and Audio file format conversion"
Any supported file format and protocol can serve as input to ffmpeg:

Examples:

* ·  
  You can use \s-1YUV\s0 files as input:
  .Sp
  .Vb 1
          ffmpeg -i /tmp/test%d.Y /tmp/out.mpg
  .Ve
  .Sp
  It will use the files:
  .Sp
  .Vb 2
          /tmp/test0.Y, /tmp/test0.U, /tmp/test0.V,
          /tmp/test1.Y, /tmp/test1.U, /tmp/test1.V, etc...
  .Ve
  .Sp
  The Y files use twice the resolution of the U and V files. They are
  raw files, without header. They can be generated by all decent video
  decoders. You must specify the size of the image with the **-s** option
  if ffmpeg cannot guess it.
* ·  
  You can input from a raw \s-1YUV420P\s0 file:
  .Sp
  .Vb 1
          ffmpeg -i /tmp/test.yuv /tmp/out.avi
  .Ve
  .Sp
  test.yuv is a file containing raw \s-1YUV\s0 planar data. Each frame is composed
  of the Y plane followed by the U and V planes at half vertical and
  horizontal resolution.
* ·  
  You can output to a raw \s-1YUV420P\s0 file:
  .Sp
  .Vb 1
          ffmpeg -i mydivx.avi hugefile.yuv
  .Ve
* ·  
  You can set several input files and output files:
  .Sp
  .Vb 1
          ffmpeg -i /tmp/a.wav -s 640x480 -i /tmp/a.yuv /tmp/a.mpg
  .Ve
  .Sp
  Converts the audio file a.wav and the raw \s-1YUV\s0 video file a.yuv
  to \s-1MPEG\s0 file a.mpg.
* ·  
  You can also do audio and video conversions at the same time:
  .Sp
  .Vb 1
          ffmpeg -i /tmp/a.wav -ar 22050 /tmp/a.mp2
  .Ve
  .Sp
  Converts a.wav to \s-1MPEG\s0 audio at 22050 Hz sample rate.
* ·  
  You can encode to several formats at the same time and define a
  mapping from input stream to output streams:
  .Sp
  .Vb 1
          ffmpeg -i /tmp/a.wav -map 0:a -b:a 64k /tmp/a.mp2 -map 0:a -b:a 128k /tmp/b.mp2
  .Ve
  .Sp
  Converts a.wav to a.mp2 at 64 kbits and to b.mp2 at 128 kbits. '-map
  file:index' specifies which input stream is used for each output
  stream, in the order of the definition of output streams.
* ·  
  You can transcode decrypted VOBs:
  .Sp
  .Vb 1
          ffmpeg -i snatch_1.vob -f avi -c:v mpeg4 -b:v 800k -g 300 -bf 2 -c:a libmp3lame -b:a 128k snatch.avi
  .Ve
  .Sp
  This is a typical \s-1DVD\s0 ripping example; the input is a \s-1VOB\s0 file, the
  output an \s-1AVI\s0 file with \s-1MPEG-4\s0 video and \s-1MP3\s0 audio. Note that in this
  command we use B-frames so the \s-1MPEG-4\s0 stream is DivX5 compatible, and
  \s-1GOP\s0 size is 300 which means one intra frame every 10 seconds for 29.97fps
  input video. Furthermore, the audio stream is MP3-encoded so you need
  to enable \s-1LAME\s0 support by passing \f(CW`--enable-libmp3lame\*(C' to configure.
  The mapping is particularly useful for \s-1DVD\s0 transcoding
  to get the desired audio language.
  .Sp
  \s-1NOTE:\s0 To see the supported input formats, use \f(CW`ffmpeg -demuxers\*(C'.
* ·  
  You can extract images from a video, or create a video from many images:
  .Sp
  For extracting images from a video:
  .Sp
  .Vb 1
          ffmpeg -i foo.avi -r 1 -s WxH -f image2 foo-%03d.jpeg
  .Ve
  .Sp
  This will extract one video frame per second from the video and will
  output them in files named _foo-001.jpeg_, _foo-002.jpeg_,
  etc. Images will be rescaled to fit the new WxH values.
  .Sp
  If you want to extract just a limited number of frames, you can use the
  above command in combination with the \f(CW`-frames:v\*(C' or \f(CW\*(C\`-t\*(C' option,
  or in combination with -ss to start extracting from a certain point in time.
  .Sp
  For creating a video from many images:
  .Sp
  .Vb 1
          ffmpeg -f image2 -framerate 12 -i foo-%03d.jpeg -s WxH foo.avi
  .Ve
  .Sp
  The syntax \f(CW`foo-%03d.jpeg\*(C' specifies to use a decimal number
  composed of three digits padded with zeroes to express the sequence
  number. It is the same syntax supported by the C printf function, but
  only formats accepting a normal integer are suitable.
  .Sp
  When importing an image sequence, -i also supports expanding
  shell-like wildcard patterns (globbing) internally, by selecting the
  image2-specific \f(CW`-pattern_type glob\*(C' option.
  .Sp
  For example, for creating a video from filenames matching the glob pattern
  \f(CW`foo-*.jpeg\*(C':
  .Sp
  .Vb 1
          ffmpeg -f image2 -pattern_type glob -framerate 12 -i foo-*.jpeg\*(Aq -s WxH foo.avi
  .Ve
* ·  
  You can put many streams of the same type in the output:
  .Sp
  .Vb 1
          ffmpeg -i test1.avi -i test2.avi -map 1:1 -map 1:0 -map 0:1 -map 0:0 -c copy -y test12.nut
  .Ve
  .Sp
  The resulting output file _test12.nut_ will contain the first four streams
  from the input files in reverse order.
* ·  
  To force \s-1CBR\s0 video output:
  .Sp
  .Vb 1
          ffmpeg -i myfile.avi -b 4000k -minrate 4000k -maxrate 4000k -bufsize 1835k out.m2v
  .Ve
* ·  
  The four options lmin, lmax, mblmin and mblmax use 'lambda' units,
  but you may use the \s-1QP2LAMBDA\s0 constant to easily convert from 'q' units:
  .Sp
  .Vb 1
          ffmpeg -i src.ext -lmax 21*QP2LAMBDA dst.ext
  .Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ffmpeg-all**\|(1),
**ffplay**\|(1), **ffprobe**\|(1),
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
