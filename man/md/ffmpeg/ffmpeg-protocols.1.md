# ffmpeg-protocols(1)

 ,  

.if n .ad l
.nh

<a name="name"></a>

# Name

ffmpeg-protocols - FFmpeg protocols

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This document describes the input and output protocols provided by the
libavformat library.

<a name="protocol-options"></a>

# Protocol Options

.IX Header "PROTOCOL OPTIONS"
The libavformat library provides some generic global options, which
can be set on all the protocols. In addition each protocol may support
so-called private options, which are specific for that component.

Options may be set by specifying -_option_ _value_ in the
FFmpeg tools, or by setting the value explicitly in the
\f(CW`AVFormatContext\*(C' options or using the _libavutil/opt.h_ \s-1API\s0
for programmatic use.

The list of supported options follows:

* **protocol\_whitelist** _list_ **(**_input_**)**  
  .IX Item "protocol_whitelist list (input)"
  Set a ,\*(R"-separated list of allowed protocols. \*(L"\s-1ALL\*(R"\s0 matches all protocols. Protocols
  prefixed by -\*(R" are disabled.
  All protocols are allowed by default but protocols used by an another
  protocol (nested protocols) are restricted to a per protocol subset.

<a name="protocols"></a>

# Protocols

.IX Header "PROTOCOLS"
Protocols are configured elements in FFmpeg that enable access to
resources that require specific protocols.

When you configure your FFmpeg build, all the supported protocols are
enabled by default. You can list all available ones using the
configure option --list-protocols\*(R".

You can disable all the protocols using the configure option
--disable-protocols\*(R", and selectively enable a protocol using the
option "--enable-protocol=_\s-1PROTOCOL\s0_, or you can disable a
particular protocol using the option
--disable-protocol=_\s-1PROTOCOL\s0_".

The option -protocols\*(R" of the ff* tools will display the list of
supported protocols.

All protocols accept the following options:

* **rw\_timeout**  
  .IX Item "rw_timeout"
  Maximum time to wait for (network) read/write operations to complete,
  in microseconds.

A description of the currently available protocols follows.

<a name="async"></a>

### async

.IX Subsection "async"
Asynchronous data filling wrapper for input stream.

Fill data in a background thread, to decouple I/O operation from demux thread.

.Vb 3
        async:&lt;URL&gt;
        async:http://host/resource
        async:cache:http://host/resource
.Ve

<a name="bluray"></a>

### bluray

.IX Subsection "bluray"
Read BluRay playlist.

The accepted options are:

* **angle**  
  .IX Item "angle"
  BluRay angle
* **chapter**  
  .IX Item "chapter"
  Start chapter (1...N)
* **playlist**  
  .IX Item "playlist"
  Playlist to read (\s-1BDMV/PLAYLIST/\s0?????.mpls)

Examples:

Read longest playlist from BluRay mounted to /mnt/bluray:

.Vb 1
        bluray:/mnt/bluray
.Ve

Read angle 2 of playlist 4 from BluRay mounted to /mnt/bluray, start from chapter 2:

.Vb 1
        -playlist 4 -angle 2 -chapter 2 bluray:/mnt/bluray
.Ve

<a name="cache"></a>

### cache

.IX Subsection "cache"
Caching wrapper for input stream.

Cache the input stream to temporary file. It brings seeking capability to live streams.

.Vb 1
        cache:&lt;URL&gt;
.Ve

<a name="concat"></a>

### concat

.IX Subsection "concat"
Physical concatenation protocol.

Read and seek from many resources in sequence as if they were
a unique resource.

A \s-1URL\s0 accepted by this protocol has the syntax:

.Vb 1
        concat:&lt;URL1&gt;|&lt;URL2&gt;|...|&lt;URLN&gt;
.Ve

where _\s-1URL1\s0_, _\s-1URL2\s0_, ..., _\s-1URLN\s0_ are the urls of the
resource to be concatenated, each one possibly specifying a distinct
protocol.

For example to read a sequence of files _split1.mpeg_,
_split2.mpeg_, _split3.mpeg_ with **ffplay** use the
command:

.Vb 1
        ffplay concat:split1.mpeg\e|split2.mpeg\e|split3.mpeg
.Ve

Note that you may need to escape the character |\*(R" which is special for
many shells.

<a name="crypto"></a>

### crypto

.IX Subsection "crypto"
AES-encrypted stream reading protocol.

The accepted options are:

* **key**  
  .IX Item "key"
  Set the \s-1AES\s0 decryption key binary block from given hexadecimal representation.
* **iv**  
  .IX Item "iv"
  Set the \s-1AES\s0 decryption initialization vector binary block from given hexadecimal representation.

Accepted \s-1URL\s0 formats:

.Vb 2
        crypto:&lt;URL&gt;
        crypto+&lt;URL&gt;
.Ve

<a name="data"></a>

### data

.IX Subsection "data"
Data in-line in the \s-1URI.\s0 See &lt;**http://en.wikipedia.org/wiki/Data\_URI\_scheme**&gt;.

For example, to convert a \s-1GIF\s0 file given inline with **ffmpeg**:

.Vb 1
        ffmpeg -i "data:image/gif;base64,R0lGODdhCAAIAMIEAAAAAAAA//8AAP//AP///////////////ywAAAAACAAIAAADF0gEDLojDgdGiJdJqUX02iB4E8Q9jUMkADs=" smiley.png
.Ve

<a name="file"></a>

### file

.IX Subsection "file"
File access protocol.

Read from or write to a file.

A file \s-1URL\s0 can have the form:

.Vb 1
        file:&lt;filename&gt;
.Ve

where _filename_ is the path of the file to read.

An \s-1URL\s0 that does not have a protocol prefix will be assumed to be a
file \s-1URL.\s0 Depending on the build, an \s-1URL\s0 that looks like a Windows
path with the drive letter at the beginning will also be assumed to be
a file \s-1URL\s0 (usually not the case in builds for unix-like systems).

For example to read from a file _input.mpeg_ with **ffmpeg**
use the command:

.Vb 1
        ffmpeg -i file:input.mpeg output.mpeg
.Ve

This protocol accepts the following options:

* **truncate**  
  .IX Item "truncate"
  Truncate existing files on write, if set to 1. A value of 0 prevents
  truncating. Default value is 1.
* **blocksize**  
  .IX Item "blocksize"
  Set I/O operation maximum block size, in bytes. Default value is
  \f(CW`INT\_MAX\*(C', which results in not limiting the requested block size.
  Setting this value reasonably low improves user termination request reaction
  time, which is valuable for files on slow medium.

<a name="ftp"></a>

### ftp

.IX Subsection "ftp"
\s-1FTP\s0 (File Transfer Protocol).

Read from or write to remote resources using \s-1FTP\s0 protocol.

Following syntax is required.

.Vb 1
        ftp://[user[:password]@]server[:port]/path/to/remote/resource.mpeg
.Ve

This protocol accepts the following options.

* **timeout**  
  .IX Item "timeout"
  Set timeout in microseconds of socket I/O operations used by the underlying low level
  operation. By default it is set to -1, which means that the timeout is
  not specified.
* **ftp-anonymous-password**  
  .IX Item "ftp-anonymous-password"
  Password used when login as anonymous user. Typically an e-mail address
  should be used.
* **ftp-write-seekable**  
  .IX Item "ftp-write-seekable"
  Control seekability of connection during encoding. If set to 1 the
  resource is supposed to be seekable, if set to 0 it is assumed not
  to be seekable. Default value is 0.

\s-1NOTE:\s0 Protocol can be used as output, but it is recommended to not do
it, unless special care is taken (tests, customized server configuration
etc.). Different \s-1FTP\s0 servers behave in different way during seek
operation. ff* tools may produce incomplete content due to server limitations.

This protocol accepts the following options:

* **follow**  
  .IX Item "follow"
  If set to 1, the protocol will retry reading at the end of the file, allowing
  reading files that still are being written. In order for this to terminate,
  you either need to use the rw_timeout option, or use the interrupt callback
  (for \s-1API\s0 users).

<a name="gopher"></a>

### gopher

.IX Subsection "gopher"
Gopher protocol.

<a name="hls"></a>

### hls

.IX Subsection "hls"
Read Apple \s-1HTTP\s0 Live Streaming compliant segmented stream as
a uniform one. The M3U8 playlists describing the segments can be
remote \s-1HTTP\s0 resources or local files, accessed using the standard
file protocol.
The nested protocol is declared by specifying
"+_proto_" after the hls \s-1URI\s0 scheme name, where _proto_
is either file\*(R" or \*(L"http\*(R".

.Vb 2
        hls+http://host/path/to/remote/resource.m3u8
        hls+file://path/to/local/resource.m3u8
.Ve

Using this protocol is discouraged - the hls demuxer should work
just as well (if not, please report the issues) and is more complete.
To use the hls demuxer instead, simply use the direct URLs to the
m3u8 files.

<a name="http"></a>

### http

.IX Subsection "http"
\s-1HTTP\s0 (Hyper Text Transfer Protocol).

This protocol accepts the following options:

* **seekable**  
  .IX Item "seekable"
  Control seekability of connection. If set to 1 the resource is
  supposed to be seekable, if set to 0 it is assumed not to be seekable,
  if set to -1 it will try to autodetect if it is seekable. Default
  value is -1.
* **chunked\_post**  
  .IX Item "chunked_post"
  If set to 1 use chunked Transfer-Encoding for posts, default is 1.
* **content\_type**  
  .IX Item "content_type"
  Set a specific content type for the \s-1POST\s0 messages or for listen mode.
* **http\_proxy**  
  .IX Item "http_proxy"
  set \s-1HTTP\s0 proxy to tunnel through e.g. http://example.com:1234
* **headers**  
  .IX Item "headers"
  Set custom \s-1HTTP\s0 headers, can override built in default headers. The
  value must be a string encoding the headers.
* **multiple\_requests**  
  .IX Item "multiple_requests"
  Use persistent connections if set to 1, default is 0.
* **post\_data**  
  .IX Item "post_data"
  Set custom \s-1HTTP\s0 post data.
* **referer**  
  .IX Item "referer"
  Set the Referer header. Include 'Referer: \s-1URL\s0' header in \s-1HTTP\s0 request.
* **user\_agent**  
  .IX Item "user_agent"
  Override the User-Agent header. If not specified the protocol will use a
  string describing the libavformat build. (Lavf/&lt;version&gt;\*(R")
* **user-agent**  
  .IX Item "user-agent"
  This is a deprecated option, you can use user_agent instead it.
* **timeout**  
  .IX Item "timeout"
  Set timeout in microseconds of socket I/O operations used by the underlying low level
  operation. By default it is set to -1, which means that the timeout is
  not specified.
* **reconnect\_at\_eof**  
  .IX Item "reconnect_at_eof"
  If set then eof is treated like an error and causes reconnection, this is useful
  for live / endless streams.
* **reconnect\_streamed**  
  .IX Item "reconnect_streamed"
  If set then even streamed/non seekable streams will be reconnected on errors.
* **reconnect\_delay\_max**  
  .IX Item "reconnect_delay_max"
  Sets the maximum delay in seconds after which to give up reconnecting
* **mime\_type**  
  .IX Item "mime_type"
  Export the \s-1MIME\s0 type.
* **http\_version**  
  .IX Item "http_version"
  Exports the \s-1HTTP\s0 response version number. Usually 1.0\*(R" or \*(L"1.1\*(R".
* **icy**  
  .IX Item "icy"
  If set to 1 request \s-1ICY\s0 (SHOUTcast) metadata from the server. If the server
  supports this, the metadata has to be retrieved by the application by reading
  the **icy\_metadata\_headers** and **icy\_metadata\_packet** options.
  The default is 1.
* **icy\_metadata\_headers**  
  .IX Item "icy_metadata_headers"
  If the server supports \s-1ICY\s0 metadata, this contains the ICY-specific \s-1HTTP\s0 reply
  headers, separated by newline characters.
* **icy\_metadata\_packet**  
  .IX Item "icy_metadata_packet"
  If the server supports \s-1ICY\s0 metadata, and **icy** was set to 1, this
  contains the last non-empty metadata packet sent by the server. It should be
  polled in regular intervals by applications interested in mid-stream metadata
  updates.
* **cookies**  
  .IX Item "cookies"
  Set the cookies to be sent in future requests. The format of each cookie is the
  same as the value of a Set-Cookie \s-1HTTP\s0 response field. Multiple cookies can be
  delimited by a newline character.
* **offset**  
  .IX Item "offset"
  Set initial byte offset.
* **end\_offset**  
  .IX Item "end_offset"
  Try to limit the request to bytes preceding this offset.
* **method**  
  .IX Item "method"
  When used as a client option it sets the \s-1HTTP\s0 method for the request.
  .Sp
  When used as a server option it sets the \s-1HTTP\s0 method that is going to be
  expected from the client(s).
  If the expected and the received \s-1HTTP\s0 method do not match the client will
  be given a Bad Request response.
  When unset the \s-1HTTP\s0 method is not checked for now. This will be replaced by
  autodetection in the future.
* **listen**  
  .IX Item "listen"
  If set to 1 enables experimental \s-1HTTP\s0 server. This can be used to send data when
  used as an output option, or read data from a client with \s-1HTTP POST\s0 when used as
  an input option.
  If set to 2 enables experimental multi-client \s-1HTTP\s0 server. This is not yet implemented
  in ffmpeg.c and thus must not be used as a command line option.
  .Sp
  .Vb 2
          # Server side (sending):
          ffmpeg -i somefile.ogg -c copy -listen 1 -f ogg http://&lt;server&gt;:&lt;port&gt;
          
          # Client side (receiving):
          ffmpeg -i http://&lt;server&gt;:&lt;port&gt; -c copy somefile.ogg
          
          # Client can also be done with wget:
          wget http://&lt;server&gt;:&lt;port&gt; -O somefile.ogg
          
          # Server side (receiving):
          ffmpeg -listen 1 -i http://&lt;server&gt;:&lt;port&gt; -c copy somefile.ogg
          
          # Client side (sending):
          ffmpeg -i somefile.ogg -chunked_post 0 -c copy -f ogg http://&lt;server&gt;:&lt;port&gt;
          
          # Client can also be done with wget:
          wget --post-file=somefile.ogg http://&lt;server&gt;:&lt;port&gt;
  .Ve

_\s-1HTTP\s0 Cookies_
.IX Subsection "HTTP Cookies"

Some \s-1HTTP\s0 requests will be denied unless cookie values are passed in with the
request. The **cookies** option allows these cookies to be specified. At
the very least, each cookie must specify a value along with a path and domain.
\s-1HTTP\s0 requests that match both the domain and path will automatically include the
cookie value in the \s-1HTTP\s0 Cookie header field. Multiple cookies can be delimited
by a newline.

The required syntax to play a stream specifying a cookie is:

.Vb 1
        ffplay -cookies "nlqptid=nltid=tsn; path=/; domain=somedomain.com;" http://somedomain.com/somestream.m3u8
.Ve

<a name="icecast"></a>

### Icecast

.IX Subsection "Icecast"
Icecast protocol (stream to Icecast servers)

This protocol accepts the following options:

* **ice\_genre**  
  .IX Item "ice_genre"
  Set the stream genre.
* **ice\_name**  
  .IX Item "ice_name"
  Set the stream name.
* **ice\_description**  
  .IX Item "ice_description"
  Set the stream description.
* **ice\_url**  
  .IX Item "ice_url"
  Set the stream website \s-1URL.\s0
* **ice\_public**  
  .IX Item "ice_public"
  Set if the stream should be public.
  The default is 0 (not public).
* **user\_agent**  
  .IX Item "user_agent"
  Override the User-Agent header. If not specified a string of the form
  Lavf/&lt;version&gt;\*(R" will be used.
* **password**  
  .IX Item "password"
  Set the Icecast mountpoint password.
* **content\_type**  
  .IX Item "content_type"
  Set the stream content type. This must be set if it is different from
  audio/mpeg.
* **legacy\_icecast**  
  .IX Item "legacy_icecast"
  This enables support for Icecast versions &lt; 2.4.0, that do not support the
  \s-1HTTP PUT\s0 method but the \s-1SOURCE\s0 method.

.Vb 1
        icecast://[&lt;username&gt;[:&lt;password&gt;]@]&lt;server&gt;:&lt;port&gt;/&lt;mountpoint&gt;
.Ve

<a name="mmst"></a>

### mmst

.IX Subsection "mmst"
\s-1MMS\s0 (Microsoft Media Server) protocol over \s-1TCP.\s0

<a name="mmsh"></a>

### mmsh

.IX Subsection "mmsh"
\s-1MMS\s0 (Microsoft Media Server) protocol over \s-1HTTP.\s0

The required syntax is:

.Vb 1
        mmsh://&lt;server&gt;[:&lt;port&gt;][/&lt;app&gt;][/&lt;playpath&gt;]
.Ve

<a name="md5"></a>

### md5

.IX Subsection "md5"
\s-1MD5\s0 output protocol.

Computes the \s-1MD5\s0 hash of the data to be written, and on close writes
this to the designated output or stdout if none is specified. It can
be used to test muxers without writing an actual file.

Some examples follow.

.Vb 2
        # Write the MD5 hash of the encoded AVI file to the file output.avi.md5.
        ffmpeg -i input.flv -f avi -y md5:output.avi.md5
        
        # Write the MD5 hash of the encoded AVI file to stdout.
        ffmpeg -i input.flv -f avi -y md5:
.Ve

Note that some formats (typically \s-1MOV\s0) require the output protocol to
be seekable, so they will fail with the \s-1MD5\s0 output protocol.

<a name="pipe"></a>

### pipe

.IX Subsection "pipe"
\s-1UNIX\s0 pipe access protocol.

Read and write from \s-1UNIX\s0 pipes.

The accepted syntax is:

.Vb 1
        pipe:[&lt;number&gt;]
.Ve

_number_ is the number corresponding to the file descriptor of the
pipe (e.g. 0 for stdin, 1 for stdout, 2 for stderr).  If _number_
is not specified, by default the stdout file descriptor will be used
for writing, stdin for reading.

For example to read from stdin with **ffmpeg**:

.Vb 3
        cat test.wav | ffmpeg -i pipe:0
        # ...this is the same as...
        cat test.wav | ffmpeg -i pipe:
.Ve

For writing to stdout with **ffmpeg**:

.Vb 3
        ffmpeg -i test.wav -f avi pipe:1 | cat &gt; test.avi
        # ...this is the same as...
        ffmpeg -i test.wav -f avi pipe: | cat &gt; test.avi
.Ve

This protocol accepts the following options:

* **blocksize**  
  .IX Item "blocksize"
  Set I/O operation maximum block size, in bytes. Default value is
  \f(CW`INT\_MAX\*(C', which results in not limiting the requested block size.
  Setting this value reasonably low improves user termination request reaction
  time, which is valuable if data transmission is slow.

Note that some formats (typically \s-1MOV\s0), require the output protocol to
be seekable, so they will fail with the pipe output protocol.

<a name="prompeg"></a>

### prompeg

.IX Subsection "prompeg"
Pro-MPEG Code of Practice #3 Release 2 \s-1FEC\s0 protocol.

The Pro-MPEG CoP#3 \s-1FEC\s0 is a 2D parity-check forward error correction mechanism
for \s-1MPEG-2\s0 Transport Streams sent over \s-1RTP.\s0

This protocol must be used in conjunction with the \f(CW`rtp\_mpegts\*(C' muxer and
the \f(CW`rtp\*(C' protocol.

The required syntax is:

.Vb 1
        -f rtp_mpegts -fec prompeg=&lt;option&gt;=&lt;val&gt;... rtp://&lt;hostname&gt;:&lt;port&gt;
.Ve

The destination \s-1UDP\s0 ports are \f(CW`port + 2\*(C' for the column \s-1FEC\s0 stream
and \f(CW`port + 4\*(C' for the row \s-1FEC\s0 stream.

This protocol accepts the following options:

* **l=**_n_  
  .IX Item "l=n"
  The number of columns (4-20, LxD &lt;= 100)
* **d=**_n_  
  .IX Item "d=n"
  The number of rows (4-20, LxD &lt;= 100)

Example usage:

.Vb 1
        -f rtp_mpegts -fec prompeg=l=8:d=4 rtp://&lt;hostname&gt;:&lt;port&gt;
.Ve

<a name="rtmp"></a>

### rtmp

.IX Subsection "rtmp"
Real-Time Messaging Protocol.

The Real-Time Messaging Protocol (\s-1RTMP\s0) is used for streaming multimedia
content across a \s-1TCP/IP\s0 network.

The required syntax is:

.Vb 1
        rtmp://[&lt;username&gt;:&lt;password&gt;@]&lt;server&gt;[:&lt;port&gt;][/&lt;app&gt;][/&lt;instance&gt;][/&lt;playpath&gt;]
.Ve

The accepted parameters are:

* **username**  
  .IX Item "username"
  An optional username (mostly for publishing).
* **password**  
  .IX Item "password"
  An optional password (mostly for publishing).
* **server**  
  .IX Item "server"
  The address of the \s-1RTMP\s0 server.
* **port**  
  .IX Item "port"
  The number of the \s-1TCP\s0 port to use (by default is 1935).
* **app**  
  .IX Item "app"
  It is the name of the application to access. It usually corresponds to
  the path where the application is installed on the \s-1RTMP\s0 server
  (e.g. _/ondemand/_, _/flash/live/_, etc.). You can override
  the value parsed from the \s-1URI\s0 through the \f(CW`rtmp\_app\*(C' option, too.
* **playpath**  
  .IX Item "playpath"
  It is the path or name of the resource to play with reference to the
  application specified in _app_, may be prefixed by mp4:\*(R". You
  can override the value parsed from the \s-1URI\s0 through the \f(CW`rtmp\_playpath\*(C'
  option, too.
* **listen**  
  .IX Item "listen"
  Act as a server, listening for an incoming connection.
* **timeout**  
  .IX Item "timeout"
  Maximum time to wait for the incoming connection. Implies listen.

Additionally, the following parameters can be set via command line options
(or in code via \f(CW`AVOption\*(C's):

* **rtmp\_app**  
  .IX Item "rtmp_app"
  Name of application to connect on the \s-1RTMP\s0 server. This option
  overrides the parameter specified in the \s-1URI.\s0
* **rtmp\_buffer**  
  .IX Item "rtmp_buffer"
  Set the client buffer time in milliseconds. The default is 3000.
* **rtmp\_conn**  
  .IX Item "rtmp_conn"
  Extra arbitrary \s-1AMF\s0 connection parameters, parsed from a string,
  e.g. like \f(CW`B:1 S:authMe O:1 NN:code:1.23 NS:flag:ok O:0\*(C'.
  Each value is prefixed by a single character denoting the type,
  B for Boolean, N for number, S for string, O for object, or Z for null,
  followed by a colon. For Booleans the data must be either 0 or 1 for
  \s-1FALSE\s0 or \s-1TRUE,\s0 respectively.  Likewise for Objects the data must be 0 or
  1 to end or begin an object, respectively. Data items in subobjects may
  be named, by prefixing the type with 'N' and specifying the name before
  the value (i.e. \f(CW`NB:myFlag:1\*(C'). This option may be used multiple
  times to construct arbitrary \s-1AMF\s0 sequences.
* **rtmp\_flashver**  
  .IX Item "rtmp_flashver"
  Version of the Flash plugin used to run the \s-1SWF\s0 player. The default
  is \s-1LNX 9,0,124,2.\s0 (When publishing, the default is \s-1FMLE/3.0\s0 (compatible;
  &lt;libavformat version&gt;).)
* **rtmp\_flush\_interval**  
  .IX Item "rtmp_flush_interval"
  Number of packets flushed in the same request (\s-1RTMPT\s0 only). The default
  is 10.
* **rtmp\_live**  
  .IX Item "rtmp_live"
  Specify that the media is a live stream. No resuming or seeking in
  live streams is possible. The default value is \f(CW`any\*(C', which means the
  subscriber first tries to play the live stream specified in the
  playpath. If a live stream of that name is not found, it plays the
  recorded stream. The other possible values are \f(CW`live\*(C' and
  \f(CW`recorded\*(C'.
* **rtmp\_pageurl**  
  .IX Item "rtmp_pageurl"
  \s-1URL\s0 of the web page in which the media was embedded. By default no
  value will be sent.
* **rtmp\_playpath**  
  .IX Item "rtmp_playpath"
  Stream identifier to play or to publish. This option overrides the
  parameter specified in the \s-1URI.\s0
* **rtmp\_subscribe**  
  .IX Item "rtmp_subscribe"
  Name of live stream to subscribe to. By default no value will be sent.
  It is only sent if the option is specified or if rtmp_live
  is set to live.
* **rtmp\_swfhash**  
  .IX Item "rtmp_swfhash"
  \s-1SHA256\s0 hash of the decompressed \s-1SWF\s0 file (32 bytes).
* **rtmp\_swfsize**  
  .IX Item "rtmp_swfsize"
  Size of the decompressed \s-1SWF\s0 file, required for SWFVerification.
* **rtmp\_swfurl**  
  .IX Item "rtmp_swfurl"
  \s-1URL\s0 of the \s-1SWF\s0 player for the media. By default no value will be sent.
* **rtmp\_swfverify**  
  .IX Item "rtmp_swfverify"
  \s-1URL\s0 to player swf file, compute hash/size automatically.
* **rtmp\_tcurl**  
  .IX Item "rtmp_tcurl"
  \s-1URL\s0 of the target stream. Defaults to proto://host[:port]/app.

For example to read with **ffplay** a multimedia resource named
sample\*(R" from the application \*(L"vod\*(R" from an \s-1RTMP\s0 server \*(L"myserver\*(R":

.Vb 1
        ffplay rtmp://myserver/vod/sample
.Ve

To publish to a password protected server, passing the playpath and
app names separately:

.Vb 1
        ffmpeg -re -i &lt;input&gt; -f flv -rtmp_playpath some/long/path -rtmp_app long/app/name rtmp://username:password@myserver/
.Ve

<a name="rtmpe"></a>

### rtmpe

.IX Subsection "rtmpe"
Encrypted Real-Time Messaging Protocol.

The Encrypted Real-Time Messaging Protocol (\s-1RTMPE\s0) is used for
streaming multimedia content within standard cryptographic primitives,
consisting of Diffie-Hellman key exchange and \s-1HMACSHA256,\s0 generating
a pair of \s-1RC4\s0 keys.

<a name="rtmps"></a>

### rtmps

.IX Subsection "rtmps"
Real-Time Messaging Protocol over a secure \s-1SSL\s0 connection.

The Real-Time Messaging Protocol (\s-1RTMPS\s0) is used for streaming
multimedia content across an encrypted connection.

<a name="rtmpt"></a>

### rtmpt

.IX Subsection "rtmpt"
Real-Time Messaging Protocol tunneled through \s-1HTTP.\s0

The Real-Time Messaging Protocol tunneled through \s-1HTTP\s0 (\s-1RTMPT\s0) is used
for streaming multimedia content within \s-1HTTP\s0 requests to traverse
firewalls.

<a name="rtmpte"></a>

### rtmpte

.IX Subsection "rtmpte"
Encrypted Real-Time Messaging Protocol tunneled through \s-1HTTP.\s0

The Encrypted Real-Time Messaging Protocol tunneled through \s-1HTTP\s0 (\s-1RTMPTE\s0)
is used for streaming multimedia content within \s-1HTTP\s0 requests to traverse
firewalls.

<a name="rtmpts"></a>

### rtmpts

.IX Subsection "rtmpts"
Real-Time Messaging Protocol tunneled through \s-1HTTPS.\s0

The Real-Time Messaging Protocol tunneled through \s-1HTTPS\s0 (\s-1RTMPTS\s0) is used
for streaming multimedia content within \s-1HTTPS\s0 requests to traverse
firewalls.

<a name="libsmbclient"></a>

### libsmbclient

.IX Subsection "libsmbclient"
libsmbclient permits one to manipulate \s-1CIFS/SMB\s0 network resources.

Following syntax is required.

.Vb 1
        smb://[[domain:]user[:password@]]server[/share[/path[/file]]]
.Ve

This protocol accepts the following options.

* **timeout**  
  .IX Item "timeout"
  Set timeout in milliseconds of socket I/O operations used by the underlying
  low level operation. By default it is set to -1, which means that the timeout
  is not specified.
* **truncate**  
  .IX Item "truncate"
  Truncate existing files on write, if set to 1. A value of 0 prevents
  truncating. Default value is 1.
* **workgroup**  
  .IX Item "workgroup"
  Set the workgroup used for making connections. By default workgroup is not specified.

For more information see: &lt;**http://www.samba.org/**&gt;.

<a name="libssh"></a>

### libssh

.IX Subsection "libssh"
Secure File Transfer Protocol via libssh

Read from or write to remote resources using \s-1SFTP\s0 protocol.

Following syntax is required.

.Vb 1
        sftp://[user[:password]@]server[:port]/path/to/remote/resource.mpeg
.Ve

This protocol accepts the following options.

* **timeout**  
  .IX Item "timeout"
  Set timeout of socket I/O operations used by the underlying low level
  operation. By default it is set to -1, which means that the timeout
  is not specified.
* **truncate**  
  .IX Item "truncate"
  Truncate existing files on write, if set to 1. A value of 0 prevents
  truncating. Default value is 1.
* **private\_key**  
  .IX Item "private_key"
  Specify the path of the file containing private key to use during authorization.
  By default libssh searches for keys in the _~/.ssh/_ directory.

Example: Play a file stored on remote server.

.Vb 1
        ffplay sftp://user:password@server_address:22/home/user/resource.mpeg
.Ve

<a name="librtmp-rtmp-rtmpe-rtmps-rtmpt-rtmpte"></a>

### librtmp rtmp, rtmpe, rtmps, rtmpt, rtmpte

.IX Subsection "librtmp rtmp, rtmpe, rtmps, rtmpt, rtmpte"
Real-Time Messaging Protocol and its variants supported through
librtmp.

Requires the presence of the librtmp headers and library during
configuration. You need to explicitly configure the build with
--enable-librtmp\*(R". If enabled this will replace the native \s-1RTMP\s0
protocol.

This protocol provides most client functions and a few server
functions needed to support \s-1RTMP, RTMP\s0 tunneled in \s-1HTTP\s0 (\s-1RTMPT\s0),
encrypted \s-1RTMP\s0 (\s-1RTMPE\s0), \s-1RTMP\s0 over \s-1SSL/TLS\s0 (\s-1RTMPS\s0) and tunneled
variants of these encrypted types (\s-1RTMPTE, RTMPTS\s0).

The required syntax is:

.Vb 1
        &lt;rtmp_proto&gt;://&lt;server&gt;[:&lt;port&gt;][/&lt;app&gt;][/&lt;playpath&gt;] &lt;options&gt;
.Ve

where _rtmp\_proto_ is one of the strings rtmp\*(R", \*(L"rtmpt\*(R", \*(L"rtmpe\*(R",
rtmps\*(R", \*(L"rtmpte\*(R", \*(L"rtmpts\*(R" corresponding to each \s-1RTMP\s0 variant, and
_server_, _port_, _app_ and _playpath_ have the same
meaning as specified for the \s-1RTMP\s0 native protocol.
_options_ contains a list of space-separated options of the form
_key_=_val_.

See the librtmp manual page (man 3 librtmp) for more information.

For example, to stream a file in real-time to an \s-1RTMP\s0 server using
**ffmpeg**:

.Vb 1
        ffmpeg -re -i myfile -f flv rtmp://myserver/live/mystream
.Ve

To play the same stream using **ffplay**:

.Vb 1
        ffplay "rtmp://myserver/live/mystream live=1"
.Ve

<a name="rtp"></a>

### rtp

.IX Subsection "rtp"
Real-time Transport Protocol.

The required syntax for an \s-1RTP URL\s0 is:
rtp://_hostname_[:_port_][?_option_=_val_...]

_port_ specifies the \s-1RTP\s0 port to use.

The following \s-1URL\s0 options are supported:

* **ttl=**_n_  
  .IX Item "ttl=n"
  Set the \s-1TTL\s0 (Time-To-Live) value (for multicast only).
* **rtcpport=**_n_  
  .IX Item "rtcpport=n"
  Set the remote \s-1RTCP\s0 port to _n_.
* **localrtpport=**_n_  
  .IX Item "localrtpport=n"
  Set the local \s-1RTP\s0 port to _n_.
* **localrtcpport=**_n_**'**  
  .IX Item "localrtcpport=n'"
  Set the local \s-1RTCP\s0 port to _n_.
* **pkt\_size=**_n_  
  .IX Item "pkt_size=n"
  Set max packet size (in bytes) to _n_.
* **connect=0|1**  
  .IX Item "connect=0|1"
  Do a \f(CW`connect()\*(C' on the \s-1UDP\s0 socket (if set to 1) or not (if set
  to 0).
* **sources=**_ip_**[,**_ip_**]**  
  .IX Item "sources=ip[,ip]"
  List allowed source \s-1IP\s0 addresses.
* **block=**_ip_**[,**_ip_**]**  
  .IX Item "block=ip[,ip]"
  List disallowed (blocked) source \s-1IP\s0 addresses.
* **write\_to\_source=0|1**  
  .IX Item "write_to_source=0|1"
  Send packets to the source address of the latest received packet (if
  set to 1) or to a default remote address (if set to 0).
* **localport=**_n_  
  .IX Item "localport=n"
  Set the local \s-1RTP\s0 port to _n_.
  .Sp
  This is a deprecated option. Instead, **localrtpport** should be
  used.

Important notes:

* 1.  
  If **rtcpport** is not set the \s-1RTCP\s0 port will be set to the \s-1RTP\s0
  port value plus 1.
* 2.  
  If **localrtpport** (the local \s-1RTP\s0 port) is not set any available
  port will be used for the local \s-1RTP\s0 and \s-1RTCP\s0 ports.
* 3.  
  If **localrtcpport** (the local \s-1RTCP\s0 port) is not set it will be
  set to the local \s-1RTP\s0 port value plus 1.

<a name="rtsp"></a>

### rtsp

.IX Subsection "rtsp"
Real-Time Streaming Protocol.

\s-1RTSP\s0 is not technically a protocol handler in libavformat, it is a demuxer
and muxer. The demuxer supports both normal \s-1RTSP\s0 (with data transferred
over \s-1RTP\s0; this is used by e.g. Apple and Microsoft) and Real-RTSP (with
data transferred over \s-1RDT\s0).

The muxer can be used to send a stream using \s-1RTSP ANNOUNCE\s0 to a server
supporting it (currently Darwin Streaming Server and Mischa Spiegelmock's
&lt;**https://github.com/revmischa/rtsp-server**&gt;).

The required syntax for a \s-1RTSP\s0 url is:

.Vb 1
        rtsp://&lt;hostname&gt;[:&lt;port&gt;]/&lt;path&gt;
.Ve

Options can be set on the **ffmpeg**/**ffplay** command
line, or set in code via \f(CW`AVOption\*(C's or in
\f(CW`avformat\_open\_input\*(C'.

The following options are supported.

* **initial\_pause**  
  .IX Item "initial_pause"
  Do not start playing the stream immediately if set to 1. Default value
  is 0.
* **rtsp\_transport**  
  .IX Item "rtsp_transport"
  Set \s-1RTSP\s0 transport protocols.
  .Sp
  It accepts the following values:
    * **udp**  
      .IX Item "udp"
      Use \s-1UDP\s0 as lower transport protocol.
    * **tcp**  
      .IX Item "tcp"
      Use \s-1TCP\s0 (interleaving within the \s-1RTSP\s0 control channel) as lower
      transport protocol.
    * **udp\_multicast**  
      .IX Item "udp_multicast"
      Use \s-1UDP\s0 multicast as lower transport protocol.
    * **http**  
      .IX Item "http"
      Use \s-1HTTP\s0 tunneling as lower transport protocol, which is useful for
      passing proxies.
      .Sp
      Multiple lower transport protocols may be specified, in that case they are
      tried one at a time (if the setup of one fails, the next one is tried).
      For the muxer, only the **tcp** and **udp** options are supported.
* **rtsp\_flags**  
  .IX Item "rtsp_flags"
  Set \s-1RTSP\s0 flags.
  .Sp
  The following values are accepted:
    * **filter\_src**  
      .IX Item "filter_src"
      Accept packets only from negotiated peer address and port.
    * **listen**  
      .IX Item "listen"
      Act as a server, listening for an incoming connection.
    * **prefer\_tcp**  
      .IX Item "prefer_tcp"
      Try \s-1TCP\s0 for \s-1RTP\s0 transport first, if \s-1TCP\s0 is available as \s-1RTSP RTP\s0 transport.
      .Sp
      Default value is **none**.
* **allowed\_media\_types**  
  .IX Item "allowed_media_types"
  Set media types to accept from the server.
  .Sp
  The following flags are accepted:
    * **video**  
      .IX Item "video"
    * **audio**  
      .IX Item "audio"
    * **data**  
      .IX Item "data"
      .Sp
      By default it accepts all media types.
* **min\_port**  
  .IX Item "min_port"
  Set minimum local \s-1UDP\s0 port. Default value is 5000.
* **max\_port**  
  .IX Item "max_port"
  Set maximum local \s-1UDP\s0 port. Default value is 65000.
* **timeout**  
  .IX Item "timeout"
  Set maximum timeout (in seconds) to wait for incoming connections.
  .Sp
  A value of -1 means infinite (default). This option implies the
  **rtsp\_flags** set to **listen**.
* **reorder\_queue\_size**  
  .IX Item "reorder_queue_size"
  Set number of packets to buffer for handling of reordered packets.
* **stimeout**  
  .IX Item "stimeout"
  Set socket \s-1TCP I/O\s0 timeout in microseconds.
* **user-agent**  
  .IX Item "user-agent"
  Override User-Agent header. If not specified, it defaults to the
  libavformat identifier string.

When receiving data over \s-1UDP,\s0 the demuxer tries to reorder received packets
(since they may arrive out of order, or packets may get lost totally). This
can be disabled by setting the maximum demuxing delay to zero (via
the \f(CW`max\_delay\*(C' field of AVFormatContext).

When watching multi-bitrate Real-RTSP streams with **ffplay**, the
streams to display can be chosen with \f(CW`-vst\*(C' _n_ and
\f(CW`-ast\*(C' _n_ for video and audio respectively, and can be switched
on the fly by pressing \f(CW`v\*(C' and \f(CW\*(C\`a\*(C'.

_Examples_
.IX Subsection "Examples"

The following examples all make use of the **ffplay** and
**ffmpeg** tools.

* ·  
  Watch a stream over \s-1UDP,\s0 with a max reordering delay of 0.5 seconds:
  .Sp
  .Vb 1
          ffplay -max_delay 500000 -rtsp_transport udp rtsp://server/video.mp4
  .Ve
* ·  
  Watch a stream tunneled over \s-1HTTP:\s0
  .Sp
  .Vb 1
          ffplay -rtsp_transport http rtsp://server/video.mp4
  .Ve
* ·  
  Send a stream in realtime to a \s-1RTSP\s0 server, for others to watch:
  .Sp
  .Vb 1
          ffmpeg -re -i &lt;input&gt; -f rtsp -muxdelay 0.1 rtsp://server/live.sdp
  .Ve
* ·  
  Receive a stream in realtime:
  .Sp
  .Vb 1
          ffmpeg -rtsp_flags listen -i rtsp://ownaddress/live.sdp &lt;output&gt;
  .Ve

<a name="sap"></a>

### sap

.IX Subsection "sap"
Session Announcement Protocol (\s-1RFC 2974\s0). This is not technically a
protocol handler in libavformat, it is a muxer and demuxer.
It is used for signalling of \s-1RTP\s0 streams, by announcing the \s-1SDP\s0 for the
streams regularly on a separate port.

_Muxer_
.IX Subsection "Muxer"

The syntax for a \s-1SAP\s0 url given to the muxer is:

.Vb 1
        sap://&lt;destination&gt;[:&lt;port&gt;][?&lt;options&gt;]
.Ve

The \s-1RTP\s0 packets are sent to _destination_ on port _port_,
or to port 5004 if no port is specified.
_options_ is a \f(CW`&\*(C'-separated list. The following options
are supported:

* **announce\_addr=**_address_  
  .IX Item "announce_addr=address"
  Specify the destination \s-1IP\s0 address for sending the announcements to.
  If omitted, the announcements are sent to the commonly used \s-1SAP\s0
  announcement multicast address 224.2.127.254 (sap.mcast.net), or
  ff0e::2:7ffe if _destination_ is an IPv6 address.
* **announce\_port=**_port_  
  .IX Item "announce_port=port"
  Specify the port to send the announcements on, defaults to
  9875 if not specified.
* **ttl=**_ttl_  
  .IX Item "ttl=ttl"
  Specify the time to live value for the announcements and \s-1RTP\s0 packets,
  defaults to 255.
* **same\_port=**_0|1_  
  .IX Item "same_port=0|1"
  If set to 1, send all \s-1RTP\s0 streams on the same port pair. If zero (the
  default), all streams are sent on unique ports, with each stream on a
  port 2 numbers higher than the previous.
  VLC/Live555 requires this to be set to 1, to be able to receive the stream.
  The \s-1RTP\s0 stack in libavformat for receiving requires all streams to be sent
  on unique ports.

Example command lines follow.

To broadcast a stream on the local subnet, for watching in \s-1VLC:\s0

.Vb 1
        ffmpeg -re -i &lt;input&gt; -f sap sap://224.0.0.255?same_port=1
.Ve

Similarly, for watching in **ffplay**:

.Vb 1
        ffmpeg -re -i &lt;input&gt; -f sap sap://224.0.0.255
.Ve

And for watching in **ffplay**, over IPv6:

.Vb 1
        ffmpeg -re -i &lt;input&gt; -f sap sap://[ff0e::1:2:3:4]
.Ve

_Demuxer_
.IX Subsection "Demuxer"

The syntax for a \s-1SAP\s0 url given to the demuxer is:

.Vb 1
        sap://[&lt;address&gt;][:&lt;port&gt;]
.Ve

_address_ is the multicast address to listen for announcements on,
if omitted, the default 224.2.127.254 (sap.mcast.net) is used. _port_
is the port that is listened on, 9875 if omitted.

The demuxers listens for announcements on the given address and port.
Once an announcement is received, it tries to receive that particular stream.

Example command lines follow.

To play back the first stream announced on the normal \s-1SAP\s0 multicast address:

.Vb 1
        ffplay sap://
.Ve

To play back the first stream announced on one the default IPv6 \s-1SAP\s0 multicast address:

.Vb 1
        ffplay sap://[ff0e::2:7ffe]
.Ve

<a name="sctp"></a>

### sctp

.IX Subsection "sctp"
Stream Control Transmission Protocol.

The accepted \s-1URL\s0 syntax is:

.Vb 1
        sctp://&lt;host&gt;:&lt;port&gt;[?&lt;options&gt;]
.Ve

The protocol accepts the following options:

* **listen**  
  .IX Item "listen"
  If set to any value, listen for an incoming connection. Outgoing connection is done by default.
* **max\_streams**  
  .IX Item "max_streams"
  Set the maximum number of streams. By default no limit is set.

<a name="srt"></a>

### srt

.IX Subsection "srt"
Haivision Secure Reliable Transport Protocol via libsrt.

The supported syntax for a \s-1SRT URL\s0 is:

.Vb 1
        srt://&lt;hostname&gt;:&lt;port&gt;[?&lt;options&gt;]
.Ve

_options_ contains a list of &-separated options of the form
_key_=_val_.

or

.Vb 1
        &lt;options&gt; srt://&lt;hostname&gt;:&lt;port&gt;
.Ve

_options_ contains a list of '-_key_ _val_'
options.

This protocol accepts the following options.

* **connect\_timeout**  
  .IX Item "connect_timeout"
  Connection timeout; \s-1SRT\s0 cannot connect for \s-1RTT\s0 &gt; 1500 msec
  (2 handshake exchanges) with the default connect timeout of
  3 seconds. This option applies to the caller and rendezvous
  connection modes. The connect timeout is 10 times the value
  set for the rendezvous mode (which can be used as a
  workaround for this connection problem with earlier versions).
* **ffs=**_bytes_  
  .IX Item "ffs=bytes"
  Flight Flag Size (Window Size), in bytes. \s-1FFS\s0 is actually an
  internal parameter and you should set it to not less than
  **recv\_buffer\_size** and **mss**. The default value
  is relatively large, therefore unless you set a very large receiver buffer,
  you do not need to change this option. Default value is 25600.
* **inputbw=**_bytes/seconds_  
  .IX Item "inputbw=bytes/seconds"
  Sender nominal input rate, in bytes per seconds. Used along with
  **oheadbw**, when **maxbw** is set to relative (0), to
  calculate maximum sending rate when recovery packets are sent
  along with the main media stream:
  **inputbw** * (100 + **oheadbw**) / 100
  if **inputbw** is not set while **maxbw** is set to
  relative (0), the actual input rate is evaluated inside
  the library. Default value is 0.
* **iptos=**_tos_  
  .IX Item "iptos=tos"
  \s-1IP\s0 Type of Service. Applies to sender only. Default value is 0xB8.
* **ipttl=**_ttl_  
  .IX Item "ipttl=ttl"
  \s-1IP\s0 Time To Live. Applies to sender only. Default value is 64.
* **latency**  
  .IX Item "latency"
  Timestamp-based Packet Delivery Delay.
  Used to absorb bursts of missed packet retransmissions.
  This flag sets both **rcvlatency** and **peerlatency**
  to the same value. Note that prior to version 1.3.0
  this is the only flag to set the latency, however
  this is effectively equivalent to setting **peerlatency**,
  when side is sender and **rcvlatency**
  when side is receiver, and the bidirectional stream
  sending is not supported.
* **listen\_timeout**  
  .IX Item "listen_timeout"
  Set socket listen timeout.
* **maxbw=**_bytes/seconds_  
  .IX Item "maxbw=bytes/seconds"
  Maximum sending bandwidth, in bytes per seconds.
  -1 infinite (\s-1CSRTCC\s0 limit is 30mbps)
  0 relative to input rate (see **inputbw**)
  &gt;0 absolute limit value
  Default value is 0 (relative)
* **mode=**_caller|listener|rendezvous_  
  .IX Item "mode=caller|listener|rendezvous"
  Connection mode.
  **caller** opens client connection.
  **listener** starts server to listen for incoming connections.
  **rendezvous** use Rendez-Vous connection mode.
  Default value is caller.
* **mss=**_bytes_  
  .IX Item "mss=bytes"
  Maximum Segment Size, in bytes. Used for buffer allocation
  and rate calculation using a packet counter assuming fully
  filled packets. The smallest \s-1MSS\s0 between the peers is
  used. This is 1500 by default in the overall internet.
  This is the maximum size of the \s-1UDP\s0 packet and can be
  only decreased, unless you have some unusual dedicated
  network settings. Default value is 1500.
* **nakreport=**_1|0_  
  .IX Item "nakreport=1|0"
  If set to 1, Receiver will send \`UMSG_LOSSREPORT\` messages
  periodically until a lost packet is retransmitted or
  intentionally dropped. Default value is 1.
* **oheadbw=**_percents_  
  .IX Item "oheadbw=percents"
  Recovery bandwidth overhead above input rate, in percents.
  See **inputbw**. Default value is 25%.
* **passphrase=**_string_  
  .IX Item "passphrase=string"
  HaiCrypt Encryption/Decryption Passphrase string, length
  from 10 to 79 characters. The passphrase is the shared
  secret between the sender and the receiver. It is used
  to generate the Key Encrypting Key using \s-1PBKDF2\s0
  (Password-Based Key Derivation Function). It is used
  only if **pbkeylen** is non-zero. It is used on
  the receiver only if the received data is encrypted.
  The configured passphrase cannot be recovered (write-only).
* **payload\_size=**_bytes_  
  .IX Item "payload_size=bytes"
  Sets the maximum declared size of a packet transferred
  during the single call to the sending function in Live
  mode. Use 0 if this value isn't used (which is default in
  file mode).
  Default is -1 (automatic), which typically means MPEG-TS;
  if you are going to use \s-1SRT\s0
  to send any different kind of payload, such as, for example,
  wrapping a live stream in very small frames, then you can
  use a bigger maximum frame size, though not greater than
  1456 bytes.
* **pkt\_size=**_bytes_  
  .IX Item "pkt_size=bytes"
  Alias for **payload\_size**.
* **peerlatency**  
  .IX Item "peerlatency"
  The latency value (as described in **rcvlatency**) that is
  set by the sender side as a minimum value for the receiver.
* **pbkeylen=**_bytes_  
  .IX Item "pbkeylen=bytes"
  Sender encryption key length, in bytes.
  Only can be set to 0, 16, 24 and 32.
  Enable sender encryption if not 0.
  Not required on receiver (set to 0),
  key size obtained from sender in HaiCrypt handshake.
  Default value is 0.
* **rcvlatency**  
  .IX Item "rcvlatency"
  The time that should elapse since the moment when the
  packet was sent and the moment when it's delivered to
  the receiver application in the receiving function.
  This time should be a buffer time large enough to cover
  the time spent for sending, unexpectedly extended \s-1RTT\s0
  time, and the time needed to retransmit the lost \s-1UDP\s0
  packet. The effective latency value will be the maximum
  of this options' value and the value of **peerlatency**
  set by the peer side. Before version 1.3.0 this option
  is only available as **latency**.
* **recv\_buffer\_size=**_bytes_  
  .IX Item "recv_buffer_size=bytes"
  Set \s-1UDP\s0 receive buffer size, expressed in bytes.
* **send\_buffer\_size=**_bytes_  
  .IX Item "send_buffer_size=bytes"
  Set \s-1UDP\s0 send buffer size, expressed in bytes.
* **rw\_timeout**  
  .IX Item "rw_timeout"
  Set raise error timeout for read/write optations.
  .Sp
  This option is only relevant in read mode:
  if no data arrived in more than this time
  interval, raise error.
* **tlpktdrop=**_1|0_  
  .IX Item "tlpktdrop=1|0"
  Too-late Packet Drop. When enabled on receiver, it skips
  missing packets that have not been delivered in time and
  delivers the following packets to the application when
  their time-to-play has come. It also sends a fake \s-1ACK\s0 to
  the sender. When enabled on sender and enabled on the
  receiving peer, the sender drops the older packets that
  have no chance of being delivered in time. It was
  automatically enabled in the sender if the receiver
  supports it.
* **sndbuf=**_bytes_  
  .IX Item "sndbuf=bytes"
  Set send buffer size, expressed in bytes.
* **rcvbuf=**_bytes_  
  .IX Item "rcvbuf=bytes"
  Set receive buffer size, expressed in bytes.
  .Sp
  Receive buffer must not be greater than **ffs**.
* **lossmaxttl=**_packets_  
  .IX Item "lossmaxttl=packets"
  The value up to which the Reorder Tolerance may grow. When
  Reorder Tolerance is &gt; 0, then packet loss report is delayed
  until that number of packets come in. Reorder Tolerance
  increases every time a belated\*(R" packet has come, but it
  wasn't due to retransmission (that is, when \s-1UDP\s0 packets tend
  to come out of order), with the difference between the latest
  sequence and this packet's sequence, and not more than the
  value of this option. By default it's 0, which means that this
  mechanism is turned off, and the loss report is always sent
  immediately upon experiencing a gap\*(R" in sequences.
* **minversion**  
  .IX Item "minversion"
  The minimum \s-1SRT\s0 version that is required from the peer. A connection
  to a peer that does not satisfy the minimum version requirement
  will be rejected.
  .Sp
  The version format in hex is 0xXXYYZZ for x.y.z in human readable
  form.
* **streamid=**_string_  
  .IX Item "streamid=string"
  A string limited to 512 characters that can be set on the socket prior
  to connecting. This stream \s-1ID\s0 will be able to be retrieved by the
  listener side from the socket that is returned from srt_accept and
  was connected by a socket with that set stream \s-1ID. SRT\s0 does not enforce
  any special interpretation of the contents of this string.
  This option doesnXt make sense in Rendezvous connection; the result
  might be that simply one side will override the value from the other
  side and itXs the matter of luck which one would win
* **smoother=**_live|file_  
  .IX Item "smoother=live|file"
  The type of Smoother used for the transmission for that socket, which
  is responsible for the transmission and congestion control. The Smoother
  type must be exactly the same on both connecting parties, otherwise
  the connection is rejected.
* **messageapi=**_1|0_  
  .IX Item "messageapi=1|0"
  When set, this socket uses the Message \s-1API,\s0 otherwise it uses Buffer
  \s-1API.\s0 Note that in live mode (see **transtype**) thereXs only
  message \s-1API\s0 available. In File mode you can chose to use one of two modes:
  .Sp
  Stream \s-1API\s0 (default, when this option is false). In this mode you may
  send as many data as you wish with one sending instruction, or even use
  dedicated functions that read directly from a file. The internal facility
  will take care of any speed and congestion control. When receiving, you
  can also receive as many data as desired, the data not extracted will be
  waiting for the next call. There is no boundary between data portions in
  the Stream mode.
  .Sp
  Message \s-1API.\s0 In this mode your single sending instruction passes exactly
  one piece of data that has boundaries (a message). Contrary to Live mode,
  this message may span across multiple \s-1UDP\s0 packets and the only size
  limitation is that it shall fit as a whole in the sending buffer. The
  receiver shall use as large buffer as necessary to receive the message,
  otherwise the message will not be given up. When the message is not
  complete (not all packets received or there was a packet loss) it will
  not be given up.
* **transtype=**_live|file_  
  .IX Item "transtype=live|file"
  Sets the transmission type for the socket, in particular, setting this
  option sets multiple other parameters to their default values as required
  for a particular transmission type.
  .Sp
  live: Set options as for live transmission. In this mode, you should
  send by one sending instruction only so many data that fit in one \s-1UDP\s0 packet,
  and limited to the value defined first in **payload\_size** (1316 is
  default in this mode). There is no speed control in this mode, only the
  bandwidth control, if configured, in order to not exceed the bandwidth with
  the overhead transmission (retransmitted and control packets).
  .Sp
  file: Set options as for non-live transmission. See **messageapi**
  for further explanations

For more information see: &lt;**https://github.com/Haivision/srt**&gt;.

<a name="srtp"></a>

### srtp

.IX Subsection "srtp"
Secure Real-time Transport Protocol.

The accepted options are:

* **srtp\_in\_suite**  
  .IX Item "srtp_in_suite"
* **srtp\_out\_suite**  
  .IX Item "srtp_out_suite"
  Select input and output encoding suites.
  .Sp
  Supported values:
    * **\s-1AES\_CM\_128\_HMAC\_SHA1\_80\s0**  
      .IX Item "AES_CM_128_HMAC_SHA1_80"
    * **\s-1SRTP\_AES128\_CM\_HMAC\_SHA1\_80\s0**  
      .IX Item "SRTP_AES128_CM_HMAC_SHA1_80"
    * **\s-1AES\_CM\_128\_HMAC\_SHA1\_32\s0**  
      .IX Item "AES_CM_128_HMAC_SHA1_32"
    * **\s-1SRTP\_AES128\_CM\_HMAC\_SHA1\_32\s0**  
      .IX Item "SRTP_AES128_CM_HMAC_SHA1_32"
* **srtp\_in\_params**  
  .IX Item "srtp_in_params"
* **srtp\_out\_params**  
  .IX Item "srtp_out_params"
  Set input and output encoding parameters, which are expressed by a
  base64-encoded representation of a binary block. The first 16 bytes of
  this binary block are used as master key, the following 14 bytes are
  used as master salt.

<a name="subfile"></a>

### subfile

.IX Subsection "subfile"
Virtually extract a segment of a file or another stream.
The underlying stream must be seekable.

Accepted options:

* **start**  
  .IX Item "start"
  Start offset of the extracted segment, in bytes.
* **end**  
  .IX Item "end"
  End offset of the extracted segment, in bytes.
  If set to 0, extract till end of file.

Examples:

Extract a chapter from a \s-1DVD VOB\s0 file (start and end sectors obtained
externally and multiplied by 2048):

.Vb 1
        subfile,,start,153391104,end,268142592,,:/media/dvd/VIDEO_TS/VTS_08_1.VOB
.Ve

Play an \s-1AVI\s0 file directly from a \s-1TAR\s0 archive:

.Vb 1
        subfile,,start,183241728,end,366490624,,:archive.tar
.Ve

Play a MPEG-TS file from start offset till end:

.Vb 1
        subfile,,start,32815239,end,0,,:video.ts
.Ve

<a name="tee"></a>

### tee

.IX Subsection "tee"
Writes the output to multiple protocols. The individual outputs are separated
by |

.Vb 1
        tee:file://path/to/local/this.avi|file://path/to/local/that.avi
.Ve

<a name="tcp"></a>

### tcp

.IX Subsection "tcp"
Transmission Control Protocol.

The required syntax for a \s-1TCP\s0 url is:

.Vb 1
        tcp://&lt;hostname&gt;:&lt;port&gt;[?&lt;options&gt;]
.Ve

_options_ contains a list of &-separated options of the form
_key_=_val_.

The list of supported options follows.

* **listen=**_1|0_  
  .IX Item "listen=1|0"
  Listen for an incoming connection. Default value is 0.
* **timeout=**_microseconds_  
  .IX Item "timeout=microseconds"
  Set raise error timeout, expressed in microseconds.
  .Sp
  This option is only relevant in read mode: if no data arrived in more
  than this time interval, raise error.
* **listen\_timeout=**_milliseconds_  
  .IX Item "listen_timeout=milliseconds"
  Set listen timeout, expressed in milliseconds.
* **recv\_buffer\_size=**_bytes_  
  .IX Item "recv_buffer_size=bytes"
  Set receive buffer size, expressed bytes.
* **send\_buffer\_size=**_bytes_  
  .IX Item "send_buffer_size=bytes"
  Set send buffer size, expressed bytes.
* **tcp\_nodelay=**_1|0_  
  .IX Item "tcp_nodelay=1|0"
  Set \s-1TCP_NODELAY\s0 to disable Nagle's algorithm. Default value is 0.
* **tcp\_mss=**_bytes_  
  .IX Item "tcp_mss=bytes"
  Set maximum segment size for outgoing \s-1TCP\s0 packets, expressed in bytes.

The following example shows how to setup a listening \s-1TCP\s0 connection
with **ffmpeg**, which is then accessed with **ffplay**:

.Vb 2
        ffmpeg -i &lt;input&gt; -f &lt;format&gt; tcp://&lt;hostname&gt;:&lt;port&gt;?listen
        ffplay tcp://&lt;hostname&gt;:&lt;port&gt;
.Ve

<a name="tls"></a>

### tls

.IX Subsection "tls"
Transport Layer Security (\s-1TLS\s0) / Secure Sockets Layer (\s-1SSL\s0)

The required syntax for a \s-1TLS/SSL\s0 url is:

.Vb 1
        tls://&lt;hostname&gt;:&lt;port&gt;[?&lt;options&gt;]
.Ve

The following parameters can be set via command line options
(or in code via \f(CW`AVOption\*(C's):

* **ca_file, cafile=**_filename_  
  .IX Item "ca_file, cafile=filename"
  A file containing certificate authority (\s-1CA\s0) root certificates to treat
  as trusted. If the linked \s-1TLS\s0 library contains a default this might not
  need to be specified for verification to work, but not all libraries and
  setups have defaults built in.
  The file must be in OpenSSL \s-1PEM\s0 format.
* **tls\_verify=**_1|0_  
  .IX Item "tls_verify=1|0"
  If enabled, try to verify the peer that we are communicating with.
  Note, if using OpenSSL, this currently only makes sure that the
  peer certificate is signed by one of the root certificates in the \s-1CA\s0
  database, but it does not validate that the certificate actually
  matches the host name we are trying to connect to. (With other backends,
  the host name is validated as well.)
  .Sp
  This is disabled by default since it requires a \s-1CA\s0 database to be
  provided by the caller in many cases.
* **cert_file, cert=**_filename_  
  .IX Item "cert_file, cert=filename"
  A file containing a certificate to use in the handshake with the peer.
  (When operating as server, in listen mode, this is more often required
  by the peer, while client certificates only are mandated in certain
  setups.)
* **key_file, key=**_filename_  
  .IX Item "key_file, key=filename"
  A file containing the private key for the certificate.
* **listen=**_1|0_  
  .IX Item "listen=1|0"
  If enabled, listen for connections on the provided port, and assume
  the server role in the handshake instead of the client role.

Example command lines:

To create a \s-1TLS/SSL\s0 server that serves an input stream.

.Vb 1
        ffmpeg -i &lt;input&gt; -f &lt;format&gt; tls://&lt;hostname&gt;:&lt;port&gt;?listen&cert=&lt;server.crt&gt;&key=&lt;server.key&gt;
.Ve

To play back a stream from the \s-1TLS/SSL\s0 server using **ffplay**:

.Vb 1
        ffplay tls://&lt;hostname&gt;:&lt;port&gt;
.Ve

<a name="udp"></a>

### udp

.IX Subsection "udp"
User Datagram Protocol.

The required syntax for an \s-1UDP URL\s0 is:

.Vb 1
        udp://&lt;hostname&gt;:&lt;port&gt;[?&lt;options&gt;]
.Ve

_options_ contains a list of &-separated options of the form _key_=_val_.

In case threading is enabled on the system, a circular buffer is used
to store the incoming data, which allows one to reduce loss of data due to
\s-1UDP\s0 socket buffer overruns. The _fifo\_size_ and
_overrun\_nonfatal_ options are related to this buffer.

The list of supported options follows.

* **buffer\_size=**_size_  
  .IX Item "buffer_size=size"
  Set the \s-1UDP\s0 maximum socket buffer size in bytes. This is used to set either
  the receive or send buffer size, depending on what the socket is used for.
  Default is 64KB.  See also _fifo\_size_.
* **bitrate=**_bitrate_  
  .IX Item "bitrate=bitrate"
  If set to nonzero, the output will have the specified constant bitrate if the
  input has enough packets to sustain it.
* **burst\_bits=**_bits_  
  .IX Item "burst_bits=bits"
  When using _bitrate_ this specifies the maximum number of bits in
  packet bursts.
* **localport=**_port_  
  .IX Item "localport=port"
  Override the local \s-1UDP\s0 port to bind with.
* **localaddr=**_addr_  
  .IX Item "localaddr=addr"
  Local \s-1IP\s0 address of a network interface used for sending packets or joining
  multicast groups.
* **pkt\_size=**_size_  
  .IX Item "pkt_size=size"
  Set the size in bytes of \s-1UDP\s0 packets.
* **reuse=**_1|0_  
  .IX Item "reuse=1|0"
  Explicitly allow or disallow reusing \s-1UDP\s0 sockets.
* **ttl=**_ttl_  
  .IX Item "ttl=ttl"
  Set the time to live value (for multicast only).
* **connect=**_1|0_  
  .IX Item "connect=1|0"
  Initialize the \s-1UDP\s0 socket with \f(CW`connect()\*(C'. In this case, the
  destination address can't be changed with ff_udp_set_remote_url later.
  If the destination address isn't known at the start, this option can
  be specified in ff_udp_set_remote_url, too.
  This allows finding out the source address for the packets with getsockname,
  and makes writes return with \s-1AVERROR\s0(\s-1ECONNREFUSED\s0) if destination
  unreachable is received.
  For receiving, this gives the benefit of only receiving packets from
  the specified peer address/port.
* **sources=**_address_**[,**_address_**]**  
  .IX Item "sources=address[,address]"
  Only receive packets sent from the specified addresses. In case of multicast,
  also subscribe to multicast traffic coming from these addresses only.
* **block=**_address_**[,**_address_**]**  
  .IX Item "block=address[,address]"
  Ignore packets sent from the specified addresses. In case of multicast, also
  exclude the source addresses in the multicast subscription.
* **fifo\_size=**_units_  
  .IX Item "fifo_size=units"
  Set the \s-1UDP\s0 receiving circular buffer size, expressed as a number of
  packets with size of 188 bytes. If not specified defaults to 7*4096.
* **overrun\_nonfatal=**_1|0_  
  .IX Item "overrun_nonfatal=1|0"
  Survive in case of \s-1UDP\s0 receiving circular buffer overrun. Default
  value is 0.
* **timeout=**_microseconds_  
  .IX Item "timeout=microseconds"
  Set raise error timeout, expressed in microseconds.
  .Sp
  This option is only relevant in read mode: if no data arrived in more
  than this time interval, raise error.
* **broadcast=**_1|0_  
  .IX Item "broadcast=1|0"
  Explicitly allow or disallow \s-1UDP\s0 broadcasting.
  .Sp
  Note that broadcasting may not work properly on networks having
  a broadcast storm protection.

_Examples_
.IX Subsection "Examples"

* ·  
  Use **ffmpeg** to stream over \s-1UDP\s0 to a remote endpoint:
  .Sp
  .Vb 1
          ffmpeg -i &lt;input&gt; -f &lt;format&gt; udp://&lt;hostname&gt;:&lt;port&gt;
  .Ve
* ·  
  Use **ffmpeg** to stream in mpegts format over \s-1UDP\s0 using 188
  sized \s-1UDP\s0 packets, using a large input buffer:
  .Sp
  .Vb 1
          ffmpeg -i &lt;input&gt; -f mpegts udp://&lt;hostname&gt;:&lt;port&gt;?pkt_size=188&buffer_size=65535
  .Ve
* ·  
  Use **ffmpeg** to receive over \s-1UDP\s0 from a remote endpoint:
  .Sp
  .Vb 1
          ffmpeg -i udp://[&lt;multicast-address&gt;]:&lt;port&gt; ...
  .Ve

<a name="unix"></a>

### unix

.IX Subsection "unix"
Unix local socket

The required syntax for a Unix socket \s-1URL\s0 is:

.Vb 1
        unix://&lt;filepath&gt;
.Ve

The following parameters can be set via command line options
(or in code via \f(CW`AVOption\*(C's):

* **timeout**  
  .IX Item "timeout"
  Timeout in ms.
* **listen**  
  .IX Item "listen"
  Create the Unix socket in listening mode.

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
