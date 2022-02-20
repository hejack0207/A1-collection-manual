# ffmpeg-devices(1)

 ,  

.if n .ad l
.nh

<a name="name"></a>

# Name

ffmpeg-devices - FFmpeg devices

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This document describes the input and output devices provided by the
libavdevice library.

<a name="device-options"></a>

# Device Options

.IX Header "DEVICE OPTIONS"
The libavdevice library provides the same interface as
libavformat. Namely, an input device is considered like a demuxer, and
an output device like a muxer, and the interface and generic device
options are the same provided by libavformat (see the ffmpeg-formats
manual).

In addition each input or output device may support so-called private
options, which are specific for that component.

Options may be set by specifying -_option_ _value_ in the
FFmpeg tools, or by setting the value explicitly in the device
\f(CW`AVFormatContext\*(C' options or using the _libavutil/opt.h_ \s-1API\s0
for programmatic use.

<a name="input-devices"></a>

# Input Devices

.IX Header "INPUT DEVICES"
Input devices are configured elements in FFmpeg which enable accessing
the data coming from a multimedia device attached to your system.

When you configure your FFmpeg build, all the supported input devices
are enabled by default. You can list all available ones using the
configure option --list-indevs\*(R".

You can disable all the input devices using the configure option
--disable-indevs\*(R", and selectively enable an input device using the
option "--enable-indev=_\s-1INDEV\s0_, or you can disable a particular
input device using the option --disable-indev=_\s-1INDEV\s0_".

The option -devices\*(R" of the ff* tools will display the list of
supported input devices.

A description of the currently available input devices follows.

<a name="alsa"></a>

### alsa

.IX Subsection "alsa"
\s-1ALSA\s0 (Advanced Linux Sound Architecture) input device.

To enable this input device during configuration you need libasound
installed on your system.

This device allows capturing from an \s-1ALSA\s0 device. The name of the
device to capture has to be an \s-1ALSA\s0 card identifier.

An \s-1ALSA\s0 identifier has the syntax:

.Vb 1
        hw:&lt;CARD&gt;[,&lt;DEV&gt;[,&lt;SUBDEV&gt;]]
.Ve

where the _\s-1DEV\s0_ and _\s-1SUBDEV\s0_ components are optional.

The three arguments (in order: _\s-1CARD\s0_,_\s-1DEV\s0_,_\s-1SUBDEV\s0_)
specify card number or identifier, device number and subdevice number
(-1 means any).

To see the list of cards currently recognized by your system check the
files _/proc/asound/cards_ and _/proc/asound/devices_.

For example to capture with **ffmpeg** from an \s-1ALSA\s0 device with
card id 0, you may run the command:

.Vb 1
        ffmpeg -f alsa -i hw:0 alsaout.wav
.Ve

For more information see:
&lt;**http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html**&gt;

_Options_
.IX Subsection "Options"

* **sample\_rate**  
  .IX Item "sample_rate"
  Set the sample rate in Hz. Default is 48000.
* **channels**  
  .IX Item "channels"
  Set the number of channels. Default is 2.

<a name="android_camera"></a>

### android_camera

.IX Subsection "android_camera"
Android camera input device.

This input devices uses the Android Camera2 \s-1NDK API\s0 which is
available on devices with \s-1API\s0 level 24+. The availability of
android_camera is autodetected during configuration.

This device allows capturing from all cameras on an Android device,
which are integrated into the Camera2 \s-1NDK API.\s0

The available cameras are enumerated internally and can be selected
with the _camera\_index_ parameter. The input file string is
discarded.

Generally the back facing camera has index 0 while the front facing
camera has index 1.

_Options_
.IX Subsection "Options"

* **video\_size**  
  .IX Item "video_size"
  Set the video size given as a string such as 640x480 or hd720.
  Falls back to the first available configuration reported by
  Android if requested video size is not available or by default.
* **framerate**  
  .IX Item "framerate"
  Set the video framerate.
  Falls back to the first available configuration reported by
  Android if requested framerate is not available or by default (-1).
* **camera\_index**  
  .IX Item "camera_index"
  Set the index of the camera to use. Default is 0.
* **input\_queue\_size**  
  .IX Item "input_queue_size"
  Set the maximum number of frames to buffer. Default is 5.

<a name="avfoundation"></a>

### avfoundation

.IX Subsection "avfoundation"
AVFoundation input device.

AVFoundation is the currently recommended framework by Apple for streamgrabbing on \s-1OSX\s0 &gt;= 10.7 as well as on iOS.

The input filename has to be given in the following syntax:

.Vb 1
        -i "[[VIDEO]:[AUDIO]]"
.Ve

The first entry selects the video input while the latter selects the audio input.
The stream has to be specified by the device name or the device index as shown by the device list.
Alternatively, the video and/or audio input device can be chosen by index using the

.Vb 1
    B&lt;-video_device_index E&lt;lt&gt;INDEXE&lt;gt&gt;&gt;
.Ve

and/or

.Vb 1
    B&lt;-audio_device_index E&lt;lt&gt;INDEXE&lt;gt&gt;&gt;
.Ve

, overriding any
device name or index given in the input filename.

All available devices can be enumerated by using **-list_devices true**, listing
all device names and corresponding indices.

There are two device name aliases:
.ie n .IP """default""" 4
.el .IP "\f(CWdefault" 4
.IX Item "default"
Select the AVFoundation default device of the corresponding type.
.ie n .IP """none""" 4
.el .IP "\f(CWnone" 4
.IX Item "none"
Do not record the corresponding media type.
This is equivalent to specifying an empty device name or index.

_Options_
.IX Subsection "Options"

AVFoundation supports the following options:

* **-list_devices &lt;TRUE|FALSE&gt;**  
  .IX Item "-list_devices &lt;TRUE|FALSE&gt;"
  If set to true, a list of all available input devices is given showing all
  device names and indices.
* **-video_device_index &lt;\s-1INDEX\s0&gt;**  
  .IX Item "-video_device_index &lt;INDEX&gt;"
  Specify the video device by its index. Overrides anything given in the input filename.
* **-audio_device_index &lt;\s-1INDEX\s0&gt;**  
  .IX Item "-audio_device_index &lt;INDEX&gt;"
  Specify the audio device by its index. Overrides anything given in the input filename.
* **-pixel_format &lt;\s-1FORMAT\s0&gt;**  
  .IX Item "-pixel_format &lt;FORMAT&gt;"
  Request the video device to use a specific pixel format.
  If the specified format is not supported, a list of available formats is given
  and the first one in this list is used instead. Available pixel formats are:
  \f(CW`monob, rgb555be, rgb555le, rgb565be, rgb565le, rgb24, bgr24, 0rgb, bgr0, 0bgr, rgb0,
   bgr48be, uyvy422, yuva444p, yuva444p16le, yuv444p, yuv422p16, yuv422p10, yuv444p10,
   yuv420p, nv12, yuyv422, gray
* **-framerate**  
  .IX Item "-framerate"
  Set the grabbing frame rate. Default is \f(CW`ntsc\*(C', corresponding to a
  frame rate of \f(CW`30000/1001\*(C'.
* **-video\_size**  
  .IX Item "-video_size"
  Set the video frame size.
* **-capture\_cursor**  
  .IX Item "-capture_cursor"
  Capture the mouse pointer. Default is 0.
* **-capture\_mouse\_clicks**  
  .IX Item "-capture_mouse_clicks"
  Capture the screen mouse clicks. Default is 0.

_Examples_
.IX Subsection "Examples"

* ·  
  Print the list of AVFoundation supported devices and exit:
  .Sp
  .Vb 1
          $ ffmpeg -f avfoundation -list_devices true -i ""
  .Ve
* ·  
  Record video from video device 0 and audio from audio device 0 into out.avi:
  .Sp
  .Vb 1
          $ ffmpeg -f avfoundation -i "0:0" out.avi
  .Ve
* ·  
  Record video from video device 2 and audio from audio device 1 into out.avi:
  .Sp
  .Vb 1
          $ ffmpeg -f avfoundation -video_device_index 2 -i ":1" out.avi
  .Ve
* ·  
  Record video from the system default video device using the pixel format bgr0 and do not record any audio into out.avi:
  .Sp
  .Vb 1
          $ ffmpeg -f avfoundation -pixel_format bgr0 -i "default:none" out.avi
  .Ve

<a name="bktr"></a>

### bktr

.IX Subsection "bktr"
\s-1BSD\s0 video input device.

_Options_
.IX Subsection "Options"

* **framerate**  
  .IX Item "framerate"
  Set the frame rate.
* **video\_size**  
  .IX Item "video_size"
  Set the video frame size. Default is \f(CW`vga\*(C'.
* **standard**  
  .IX Item "standard"
  Available values are:
    * **pal**  
      .IX Item "pal"
    * **ntsc**  
      .IX Item "ntsc"
    * **secam**  
      .IX Item "secam"
    * **paln**  
      .IX Item "paln"
    * **palm**  
      .IX Item "palm"
    * **ntscj**  
      .IX Item "ntscj"

<a name="decklink"></a>

### decklink

.IX Subsection "decklink"
The decklink input device provides capture capabilities for Blackmagic
DeckLink devices.

To enable this input device, you need the Blackmagic DeckLink \s-1SDK\s0 and you
need to configure with the appropriate \f(CW`--extra-cflags\*(C'
and \f(CW`--extra-ldflags\*(C'.
On Windows, you need to run the \s-1IDL\s0 files through **widl**.

DeckLink is very picky about the formats it supports. Pixel format of the
input can be set with **raw\_format**.
Framerate and video size must be determined for your device with
**-list_formats 1**. Audio sample rate is always 48 kHz and the number
of channels can be 2, 8 or 16. Note that all audio channels are bundled in one single
audio track.

_Options_
.IX Subsection "Options"

* **list\_devices**  
  .IX Item "list_devices"
  If set to **true**, print a list of devices and exit.
  Defaults to **false**. Alternatively you can use the \f(CW`-sources\*(C'
  option of ffmpeg to list the available input devices.
* **list\_formats**  
  .IX Item "list_formats"
  If set to **true**, print a list of supported formats and exit.
  Defaults to **false**.
* **format_code &lt;FourCC&gt;**  
  .IX Item "format_code &lt;FourCC&gt;"
  This sets the input video format to the format given by the FourCC. To see
  the supported values of your device(s) use **list\_formats**.
  Note that there is a FourCC **'pal '** that can also be used
  as **pal** (3 letters).
  Default behavior is autodetection of the input video format, if the hardware
  supports it.
* **bm\_v210**  
  .IX Item "bm_v210"
  This is a deprecated option, you can use **raw\_format** instead.
  If set to **1**, video is captured in 10 bit v210 instead
  of uyvy422. Not all Blackmagic devices support this option.
* **raw\_format**  
  .IX Item "raw_format"
  Set the pixel format of the captured video.
  Available values are:
    * **uyvy422**  
      .IX Item "uyvy422"
    * **yuv422p10**  
      .IX Item "yuv422p10"
    * **argb**  
      .IX Item "argb"
    * **bgra**  
      .IX Item "bgra"
    * **rgb10**  
      .IX Item "rgb10"
* **teletext\_lines**  
  .IX Item "teletext_lines"
  If set to nonzero, an additional teletext stream will be captured from the
  vertical ancillary data. Both \s-1SD PAL\s0 (576i) and \s-1HD\s0 (1080i or 1080p)
  sources are supported. In case of \s-1HD\s0 sources, \s-1OP47\s0 packets are decoded.
  .Sp
  This option is a bitmask of the \s-1SD PAL VBI\s0 lines captured, specifically lines 6
  to 22, and lines 318 to 335. Line 6 is the \s-1LSB\s0 in the mask. Selected lines
  which do not contain teletext information will be ignored. You can use the
  special **all** constant to select all possible lines, or
  **standard** to skip lines 6, 318 and 319, which are not compatible with
  all receivers.
  .Sp
  For \s-1SD\s0 sources, ffmpeg needs to be compiled with \f(CW`--enable-libzvbi\*(C'. For
  \s-1HD\s0 sources, on older (pre-4K) DeckLink card models you have to capture in 10
  bit mode.
* **channels**  
  .IX Item "channels"
  Defines number of audio channels to capture. Must be **2**, **8** or **16**.
  Defaults to **2**.
* **duplex\_mode**  
  .IX Item "duplex_mode"
  Sets the decklink device duplex mode. Must be **unset**, **half** or **full**.
  Defaults to **unset**.
* **timecode\_format**  
  .IX Item "timecode_format"
  Timecode type to include in the frame and video stream metadata. Must be
  **none**, **rp188vitc**, **rp188vitc2**, **rp188ltc**,
  **rp188any**, **vitc**, **vitc2**, or **serial**. Defaults to
  **none** (not included).
* **video\_input**  
  .IX Item "video_input"
  Sets the video input source. Must be **unset**, **sdi**, **hdmi**,
  **optical\_sdi**, **component**, **composite** or **s\_video**.
  Defaults to **unset**.
* **audio\_input**  
  .IX Item "audio_input"
  Sets the audio input source. Must be **unset**, **embedded**,
  **aes\_ebu**, **analog**, **analog\_xlr**, **analog\_rca** or
  **microphone**. Defaults to **unset**.
* **video\_pts**  
  .IX Item "video_pts"
  Sets the video packet timestamp source. Must be **video**, **audio**,
  **reference**, **wallclock** or **abs\_wallclock**.
  Defaults to **video**.
* **audio\_pts**  
  .IX Item "audio_pts"
  Sets the audio packet timestamp source. Must be **video**, **audio**,
  **reference**, **wallclock** or **abs\_wallclock**.
  Defaults to **audio**.
* **draw\_bars**  
  .IX Item "draw_bars"
  If set to **true**, color bars are drawn in the event of a signal loss.
  Defaults to **true**.
* **queue\_size**  
  .IX Item "queue_size"
  Sets maximum input buffer size in bytes. If the buffering reaches this value,
  incoming frames will be dropped.
  Defaults to **1073741824**.
* **audio\_depth**  
  .IX Item "audio_depth"
  Sets the audio sample bit depth. Must be **16** or **32**.
  Defaults to **16**.
* **decklink\_copyts**  
  .IX Item "decklink_copyts"
  If set to **true**, timestamps are forwarded as they are without removing
  the initial offset.
  Defaults to **false**.
* **timestamp\_align**  
  .IX Item "timestamp_align"
  Capture start time alignment in seconds. If set to nonzero, input frames are
  dropped till the system timestamp aligns with configured value.
  Alignment difference of up to one frame duration is tolerated.
  This is useful for maintaining input synchronization across N different
  hardware devices deployed for 'N-way' redundancy. The system time of different
  hardware devices should be synchronized with protocols such as \s-1NTP\s0 or \s-1PTP,\s0
  before using this option.
  Note that this method is not foolproof. In some border cases input
  synchronization may not happen due to thread scheduling jitters in the \s-1OS.\s0
  Either sync could go wrong by 1 frame or in a rarer case
  **timestamp\_align** seconds.
  Defaults to **0**.

_Examples_
.IX Subsection "Examples"

* ·  
  List input devices:
  .Sp
  .Vb 1
          ffmpeg -f decklink -list_devices 1 -i dummy
  .Ve
* ·  
  List supported formats:
  .Sp
  .Vb 1
          ffmpeg -f decklink -list_formats 1 -i Intensity Pro\*(Aq
  .Ve
* ·  
  Capture video clip at 1080i50:
  .Sp
  .Vb 1
          ffmpeg -format_code Hi50 -f decklink -i Intensity Pro\*(Aq -c:a copy -c:v copy output.avi
  .Ve
* ·  
  Capture video clip at 1080i50 10 bit:
  .Sp
  .Vb 1
          ffmpeg -bm_v210 1 -format_code Hi50 -f decklink -i UltraStudio Mini Recorder\*(Aq -c:a copy -c:v copy output.avi
  .Ve
* ·  
  Capture video clip at 1080i50 with 16 audio channels:
  .Sp
  .Vb 1
          ffmpeg -channels 16 -format_code Hi50 -f decklink -i UltraStudio Mini Recorder\*(Aq -c:a copy -c:v copy output.avi
  .Ve

<a name="dshow"></a>

### dshow

.IX Subsection "dshow"
Windows DirectShow input device.

DirectShow support is enabled when FFmpeg is built with the mingw-w64 project.
Currently only audio and video devices are supported.

Multiple devices may be opened as separate inputs, but they may also be
opened on the same input, which should improve synchronism between them.

The input name should be in the format:

.Vb 1
        &lt;TYPE&gt;=&lt;NAME&gt;[:&lt;TYPE&gt;=&lt;NAME&gt;]
.Ve

where _\s-1TYPE\s0_ can be either _audio_ or _video_,
and _\s-1NAME\s0_ is the device's name or alternative name..

_Options_
.IX Subsection "Options"

If no options are specified, the device's defaults are used.
If the device does not support the requested options, it will
fail to open.

* **video\_size**  
  .IX Item "video_size"
  Set the video size in the captured video.
* **framerate**  
  .IX Item "framerate"
  Set the frame rate in the captured video.
* **sample\_rate**  
  .IX Item "sample_rate"
  Set the sample rate (in Hz) of the captured audio.
* **sample\_size**  
  .IX Item "sample_size"
  Set the sample size (in bits) of the captured audio.
* **channels**  
  .IX Item "channels"
  Set the number of channels in the captured audio.
* **list\_devices**  
  .IX Item "list_devices"
  If set to **true**, print a list of devices and exit.
* **list\_options**  
  .IX Item "list_options"
  If set to **true**, print a list of selected device's options
  and exit.
* **video\_device\_number**  
  .IX Item "video_device_number"
  Set video device number for devices with the same name (starts at 0,
  defaults to 0).
* **audio\_device\_number**  
  .IX Item "audio_device_number"
  Set audio device number for devices with the same name (starts at 0,
  defaults to 0).
* **pixel\_format**  
  .IX Item "pixel_format"
  Select pixel format to be used by DirectShow. This may only be set when
  the video codec is not set or set to rawvideo.
* **audio\_buffer\_size**  
  .IX Item "audio_buffer_size"
  Set audio device buffer size in milliseconds (which can directly
  impact latency, depending on the device).
  Defaults to using the audio device's
  default buffer size (typically some multiple of 500ms).
  Setting this value too low can degrade performance.
  See also
  &lt;**http://msdn.microsoft.com/en-us/library/windows/desktop/dd377582(v=vs.85).aspx**&gt;
* **video\_pin\_name**  
  .IX Item "video_pin_name"
  Select video capture pin to use by name or alternative name.
* **audio\_pin\_name**  
  .IX Item "audio_pin_name"
  Select audio capture pin to use by name or alternative name.
* **crossbar\_video\_input\_pin\_number**  
  .IX Item "crossbar_video_input_pin_number"
  Select video input pin number for crossbar device. This will be
  routed to the crossbar device's Video Decoder output pin.
  Note that changing this value can affect future invocations
  (sets a new default) until system reboot occurs.
* **crossbar\_audio\_input\_pin\_number**  
  .IX Item "crossbar_audio_input_pin_number"
  Select audio input pin number for crossbar device. This will be
  routed to the crossbar device's Audio Decoder output pin.
  Note that changing this value can affect future invocations
  (sets a new default) until system reboot occurs.
* **show\_video\_device\_dialog**  
  .IX Item "show_video_device_dialog"
  If set to **true**, before capture starts, popup a display dialog
  to the end user, allowing them to change video filter properties
  and configurations manually.
  Note that for crossbar devices, adjusting values in this dialog
  may be needed at times to toggle between \s-1PAL\s0 (25 fps) and \s-1NTSC\s0 (29.97)
  input frame rates, sizes, interlacing, etc.  Changing these values can
  enable different scan rates/frame rates and avoiding green bars at
  the bottom, flickering scan lines, etc.
  Note that with some devices, changing these properties can also affect future
  invocations (sets new defaults) until system reboot occurs.
* **show\_audio\_device\_dialog**  
  .IX Item "show_audio_device_dialog"
  If set to **true**, before capture starts, popup a display dialog
  to the end user, allowing them to change audio filter properties
  and configurations manually.
* **show\_video\_crossbar\_connection\_dialog**  
  .IX Item "show_video_crossbar_connection_dialog"
  If set to **true**, before capture starts, popup a display
  dialog to the end user, allowing them to manually
  modify crossbar pin routings, when it opens a video device.
* **show\_audio\_crossbar\_connection\_dialog**  
  .IX Item "show_audio_crossbar_connection_dialog"
  If set to **true**, before capture starts, popup a display
  dialog to the end user, allowing them to manually
  modify crossbar pin routings, when it opens an audio device.
* **show\_analog\_tv\_tuner\_dialog**  
  .IX Item "show_analog_tv_tuner_dialog"
  If set to **true**, before capture starts, popup a display
  dialog to the end user, allowing them to manually
  modify \s-1TV\s0 channels and frequencies.
* **show\_analog\_tv\_tuner\_audio\_dialog**  
  .IX Item "show_analog_tv_tuner_audio_dialog"
  If set to **true**, before capture starts, popup a display
  dialog to the end user, allowing them to manually
  modify \s-1TV\s0 audio (like mono vs. stereo, Language A,B or C).
* **audio\_device\_load**  
  .IX Item "audio_device_load"
  Load an audio capture filter device from file instead of searching
  it by name. It may load additional parameters too, if the filter
  supports the serialization of its properties to.
  To use this an audio capture source has to be specified, but it can
  be anything even fake one.
* **audio\_device\_save**  
  .IX Item "audio_device_save"
  Save the currently used audio capture filter device and its
  parameters (if the filter supports it) to a file.
  If a file with the same name exists it will be overwritten.
* **video\_device\_load**  
  .IX Item "video_device_load"
  Load a video capture filter device from file instead of searching
  it by name. It may load additional parameters too, if the filter
  supports the serialization of its properties to.
  To use this a video capture source has to be specified, but it can
  be anything even fake one.
* **video\_device\_save**  
  .IX Item "video_device_save"
  Save the currently used video capture filter device and its
  parameters (if the filter supports it) to a file.
  If a file with the same name exists it will be overwritten.

_Examples_
.IX Subsection "Examples"

* ·  
  Print the list of DirectShow supported devices and exit:
  .Sp
  .Vb 1
          $ ffmpeg -list_devices true -f dshow -i dummy
  .Ve
* ·  
  Open video device _Camera_:
  .Sp
  .Vb 1
          $ ffmpeg -f dshow -i video="Camera"
  .Ve
* ·  
  Open second video device with name _Camera_:
  .Sp
  .Vb 1
          $ ffmpeg -f dshow -video_device_number 1 -i video="Camera"
  .Ve
* ·  
  Open video device _Camera_ and audio device _Microphone_:
  .Sp
  .Vb 1
          $ ffmpeg -f dshow -i video="Camera":audio="Microphone"
  .Ve
* ·  
  Print the list of supported options in selected device and exit:
  .Sp
  .Vb 1
          $ ffmpeg -list_options true -f dshow -i video="Camera"
  .Ve
* ·  
  Specify pin names to capture by name or alternative name, specify alternative device name:
  .Sp
  .Vb 1
          $ ffmpeg -f dshow -audio_pin_name "Audio Out" -video_pin_name 2 -i video=video="@device_pnp_\e\e?\epci#ven_1a0a&dev_6200&subsys_62021461&rev_01#4&e2c7dd6&0&00e1#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\e{ca465100-deb0-4d59-818f-8c477184adf6}":audio="Microphone"
  .Ve
* ·  
  Configure a crossbar device, specifying crossbar pins, allow user to adjust video capture properties at startup:
  .Sp
  .Vb 2
          $ ffmpeg -f dshow -show_video_device_dialog true -crossbar_video_input_pin_number 0
               -crossbar_audio_input_pin_number 3 -i video="AVerMedia BDA Analog Capture":audio="AVerMedia BDA Analog Capture"
  .Ve

<a name="fbdev"></a>

### fbdev

.IX Subsection "fbdev"
Linux framebuffer input device.

The Linux framebuffer is a graphic hardware-independent abstraction
layer to show graphics on a computer monitor, typically on the
console. It is accessed through a file device node, usually
_/dev/fb0_.

For more detailed information read the file
Documentation/fb/framebuffer.txt included in the Linux source tree.

See also &lt;**http://linux-fbdev.sourceforge.net/**&gt;, and **fbset**\|(1).

To record from the framebuffer device _/dev/fb0_ with
**ffmpeg**:

.Vb 1
        ffmpeg -f fbdev -framerate 10 -i /dev/fb0 out.avi
.Ve

You can take a single screenshot image with the command:

.Vb 1
        ffmpeg -f fbdev -framerate 1 -i /dev/fb0 -frames:v 1 screenshot.jpeg
.Ve

_Options_
.IX Subsection "Options"

* **framerate**  
  .IX Item "framerate"
  Set the frame rate. Default is 25.

<a name="gdigrab"></a>

### gdigrab

.IX Subsection "gdigrab"
Win32 GDI-based screen capture device.

This device allows you to capture a region of the display on Windows.

There are two options for the input filename:

.Vb 1
        desktop
.Ve

or

.Vb 1
        title=&lt;window_title&gt;
.Ve

The first option will capture the entire desktop, or a fixed region of the
desktop. The second option will instead capture the contents of a single
window, regardless of its position on the screen.

For example, to grab the entire desktop using **ffmpeg**:

.Vb 1
        ffmpeg -f gdigrab -framerate 6 -i desktop out.mpg
.Ve

Grab a 640x480 region at position \f(CW`10,20\*(C':

.Vb 1
        ffmpeg -f gdigrab -framerate 6 -offset_x 10 -offset_y 20 -video_size vga -i desktop out.mpg
.Ve

Grab the contents of the window named Calculator\*(R"

.Vb 1
        ffmpeg -f gdigrab -framerate 6 -i title=Calculator out.mpg
.Ve

_Options_
.IX Subsection "Options"

* **draw\_mouse**  
  .IX Item "draw_mouse"
  Specify whether to draw the mouse pointer. Use the value \f(CW0 to
  not draw the pointer. Default value is \f(CW1.
* **framerate**  
  .IX Item "framerate"
  Set the grabbing frame rate. Default value is \f(CW`ntsc\*(C',
  corresponding to a frame rate of \f(CW`30000/1001\*(C'.
* **show\_region**  
  .IX Item "show_region"
  Show grabbed region on screen.
  .Sp
  If _show\_region_ is specified with \f(CW1, then the grabbing
  region will be indicated on screen. With this option, it is easy to
  know what is being grabbed if only a portion of the screen is grabbed.
  .Sp
  Note that _show\_region_ is incompatible with grabbing the contents
  of a single window.
  .Sp
  For example:
  .Sp
  .Vb 1
          ffmpeg -f gdigrab -show_region 1 -framerate 6 -video_size cif -offset_x 10 -offset_y 20 -i desktop out.mpg
  .Ve
* **video\_size**  
  .IX Item "video_size"
  Set the video frame size. The default is to capture the full screen if _desktop_ is selected, or the full window size if _title=window\_title_ is selected.
* **offset\_x**  
  .IX Item "offset_x"
  When capturing a region with _video\_size_, set the distance from the left edge of the screen or desktop.
  .Sp
  Note that the offset calculation is from the top left corner of the primary monitor on Windows. If you have a monitor positioned to the left of your primary monitor, you will need to use a negative _offset\_x_ value to move the region to that monitor.
* **offset\_y**  
  .IX Item "offset_y"
  When capturing a region with _video\_size_, set the distance from the top edge of the screen or desktop.
  .Sp
  Note that the offset calculation is from the top left corner of the primary monitor on Windows. If you have a monitor positioned above your primary monitor, you will need to use a negative _offset\_y_ value to move the region to that monitor.

<a name="iec61883"></a>

### iec61883

.IX Subsection "iec61883"
FireWire \s-1DV/HDV\s0 input device using libiec61883.

To enable this input device, you need libiec61883, libraw1394 and
libavc1394 installed on your system. Use the configure option
\f(CW`--enable-libiec61883\*(C' to compile with the device enabled.

The iec61883 capture device supports capturing from a video device
connected via \s-1IEEE1394\s0 (FireWire), using libiec61883 and the new Linux
FireWire stack (juju). This is the default \s-1DV/HDV\s0 input method in Linux
Kernel 2.6.37 and later, since the old FireWire stack was removed.

Specify the FireWire port to be used as input file, or auto\*(R"
to choose the first port connected.

_Options_
.IX Subsection "Options"

* **dvtype**  
  .IX Item "dvtype"
  Override autodetection of \s-1DV/HDV.\s0 This should only be used if auto
  detection does not work, or if usage of a different device type
  should be prohibited. Treating a \s-1DV\s0 device as \s-1HDV\s0 (or vice versa) will
  not work and result in undefined behavior.
  The values **auto**, **dv** and **hdv** are supported.
* **dvbuffer**  
  .IX Item "dvbuffer"
  Set maximum size of buffer for incoming data, in frames. For \s-1DV,\s0 this
  is an exact value. For \s-1HDV,\s0 it is not frame exact, since \s-1HDV\s0 does
  not have a fixed frame size.
* **dvguid**  
  .IX Item "dvguid"
  Select the capture device by specifying its \s-1GUID.\s0 Capturing will only
  be performed from the specified device and fails if no device with the
  given \s-1GUID\s0 is found. This is useful to select the input if multiple
  devices are connected at the same time.
  Look at /sys/bus/firewire/devices to find out the GUIDs.

_Examples_
.IX Subsection "Examples"

* ·  
  Grab and show the input of a FireWire \s-1DV/HDV\s0 device.
  .Sp
  .Vb 1
          ffplay -f iec61883 -i auto
  .Ve
* ·  
  Grab and record the input of a FireWire \s-1DV/HDV\s0 device,
  using a packet buffer of 100000 packets if the source is \s-1HDV.\s0
  .Sp
  .Vb 1
          ffmpeg -f iec61883 -i auto -hdvbuffer 100000 out.mpg
  .Ve

<a name="jack"></a>

### jack

.IX Subsection "jack"
\s-1JACK\s0 input device.

To enable this input device during configuration you need libjack
installed on your system.

A \s-1JACK\s0 input device creates one or more \s-1JACK\s0 writable clients, one for
each audio channel, with name _client\_name_:input\__N_, where
_client\_name_ is the name provided by the application, and _N_
is a number which identifies the channel.
Each writable client will send the acquired data to the FFmpeg input
device.

Once you have created one or more \s-1JACK\s0 readable clients, you need to
connect them to one or more \s-1JACK\s0 writable clients.

To connect or disconnect \s-1JACK\s0 clients you can use the **jack\_connect**
and **jack\_disconnect** programs, or do it through a graphical interface,
for example with **qjackctl**.

To list the \s-1JACK\s0 clients and their properties you can invoke the command
**jack\_lsp**.

Follows an example which shows how to capture a \s-1JACK\s0 readable client
with **ffmpeg**.

.Vb 2
        # Create a JACK writable client with name "ffmpeg".
        $ ffmpeg -f jack -i ffmpeg -y out.wav
        
        # Start the sample jack_metro readable client.
        $ jack_metro -b 120 -d 0.2 -f 4000
        
        # List the current JACK clients.
        $ jack_lsp -c
        system:capture_1
        system:capture_2
        system:playback_1
        system:playback_2
        ffmpeg:input_1
        metro:120_bpm
        
        # Connect metro to the ffmpeg writable client.
        $ jack_connect metro:120_bpm ffmpeg:input_1
.Ve

For more information read:
&lt;**http://jackaudio.org/**&gt;

_Options_
.IX Subsection "Options"

* **channels**  
  .IX Item "channels"
  Set the number of channels. Default is 2.

<a name="kmsgrab"></a>

### kmsgrab

.IX Subsection "kmsgrab"
\s-1KMS\s0 video input device.

Captures the \s-1KMS\s0 scanout framebuffer associated with a specified \s-1CRTC\s0 or plane as a
\s-1DRM\s0 object that can be passed to other hardware functions.

Requires either \s-1DRM\s0 master or \s-1CAP_SYS_ADMIN\s0 to run.

If you don't understand what all of that means, you probably don't want this.  Look at
**x11grab** instead.

_Options_
.IX Subsection "Options"

* **device**  
  .IX Item "device"
  \s-1DRM\s0 device to capture on.  Defaults to **/dev/dri/card0**.
* **format**  
  .IX Item "format"
  Pixel format of the framebuffer.  Defaults to **bgr0**.
* **format\_modifier**  
  .IX Item "format_modifier"
  Format modifier to signal on output frames.  This is necessary to import correctly into
  some APIs, but can't be autodetected.  See the libdrm documentation for possible values.
* **crtc\_id**  
  .IX Item "crtc_id"
  \s-1KMS CRTC ID\s0 to define the capture source.  The first active plane on the given \s-1CRTC\s0
  will be used.
* **plane\_id**  
  .IX Item "plane_id"
  \s-1KMS\s0 plane \s-1ID\s0 to define the capture source.  Defaults to the first active plane found if
  neither **crtc\_id** nor **plane\_id** are specified.
* **framerate**  
  .IX Item "framerate"
  Framerate to capture at.  This is not synchronised to any page flipping or framebuffer
  changes - it just defines the interval at which the framebuffer is sampled.  Sampling
  faster than the framebuffer update rate will generate independent frames with the same
  content.  Defaults to \f(CW30.

_Examples_
.IX Subsection "Examples"

* ·  
  Capture from the first active plane, download the result to normal frames and encode.
  This will only work if the framebuffer is both linear and mappable - if not, the result
  may be scrambled or fail to download.
  .Sp
  .Vb 1
          ffmpeg -f kmsgrab -i - -vf hwdownload,format=bgr0\*(Aq output.mp4
  .Ve
* ·  
  Capture from \s-1CRTC ID 42\s0 at 60fps, map the result to \s-1VAAPI,\s0 convert to \s-1NV12\s0 and encode as H.264.
  .Sp
  .Vb 1
          ffmpeg -crtc_id 42 -framerate 60 -f kmsgrab -i - -vf hwmap=derive_device=vaapi,scale_vaapi=w=1920:h=1080:format=nv12\*(Aq -c:v h264_vaapi output.mp4
  .Ve

<a name="lavfi"></a>

### lavfi

.IX Subsection "lavfi"
Libavfilter input virtual device.

This input device reads data from the open output pads of a libavfilter
filtergraph.

For each filtergraph open output, the input device will create a
corresponding stream which is mapped to the generated output. Currently
only video data is supported. The filtergraph is specified through the
option **graph**.

_Options_
.IX Subsection "Options"

* **graph**  
  .IX Item "graph"
  Specify the filtergraph to use as input. Each video open output must be
  labelled by a unique string of the form "out_N_", where _N_ is a
  number starting from 0 corresponding to the mapped input stream
  generated by the device.
  The first unlabelled output is automatically assigned to the out0\*(R"
  label, but all the others need to be specified explicitly.
  .Sp
  The suffix +subcc\*(R" can be appended to the output label to create an extra
  stream with the closed captions packets attached to that output
  (experimental; only for \s-1EIA-608 / CEA-708\s0 for now).
  The subcc streams are created after all the normal streams, in the order of
  the corresponding stream.
  For example, if there is out19+subcc\*(R", \*(L"out7+subcc\*(R" and up to \*(L"out42\*(R", the
  stream #43 is subcc for stream #7 and stream #44 is subcc for stream #19.
  .Sp
  If not specified defaults to the filename specified for the input
  device.
* **graph\_file**  
  .IX Item "graph_file"
  Set the filename of the filtergraph to be read and sent to the other
  filters. Syntax of the filtergraph is the same as the one specified by
  the option _graph_.
* **dumpgraph**  
  .IX Item "dumpgraph"
  Dump graph to stderr.

_Examples_
.IX Subsection "Examples"

* ·  
  Create a color video stream and play it back with **ffplay**:
  .Sp
  .Vb 1
          ffplay -f lavfi -graph "color=c=pink [out0]" dummy
  .Ve
* ·  
  As the previous example, but use filename for specifying the graph
  description, and omit the out0\*(R" label:
  .Sp
  .Vb 1
          ffplay -f lavfi color=c=pink
  .Ve
* ·  
  Create three different video test filtered sources and play them:
  .Sp
  .Vb 1
          ffplay -f lavfi -graph "testsrc [out0]; testsrc,hflip [out1]; testsrc,negate [out2]" test3
  .Ve
* ·  
  Read an audio stream from a file using the amovie source and play it
  back with **ffplay**:
  .Sp
  .Vb 1
          ffplay -f lavfi "amovie=test.wav"
  .Ve
* ·  
  Read an audio stream and a video stream and play it back with
  **ffplay**:
  .Sp
  .Vb 1
          ffplay -f lavfi "movie=test.avi[out0];amovie=test.wav[out1]"
  .Ve
* ·  
  Dump decoded frames to images and closed captions to a file (experimental):
  .Sp
  .Vb 1
          ffmpeg -f lavfi -i "movie=test.ts[out0+subcc]" -map v frame%08d.png -map s -c copy -f rawvideo subcc.bin
  .Ve

<a name="libcdio"></a>

### libcdio

.IX Subsection "libcdio"
Audio-CD input device based on libcdio.

To enable this input device during configuration you need libcdio
installed on your system. It requires the configure option
\f(CW`--enable-libcdio\*(C'.

This device allows playing and grabbing from an Audio-CD.

For example to copy with **ffmpeg** the entire Audio-CD in _/dev/sr0_,
you may run the command:

.Vb 1
        ffmpeg -f libcdio -i /dev/sr0 cd.wav
.Ve

_Options_
.IX Subsection "Options"

* **speed**  
  .IX Item "speed"
  Set drive reading speed. Default value is 0.
  .Sp
  The speed is specified CD-ROM speed units. The speed is set through
  the libcdio \f(CW`cdio\_cddap\_speed\_set\*(C' function. On many CD-ROM
  drives, specifying a value too large will result in using the fastest
  speed.
* **paranoia\_mode**  
  .IX Item "paranoia_mode"
  Set paranoia recovery mode flags. It accepts one of the following values:
    * **disable**  
      .IX Item "disable"
    * **verify**  
      .IX Item "verify"
    * **overlap**  
      .IX Item "overlap"
    * **neverskip**  
      .IX Item "neverskip"
    * **full**  
      .IX Item "full"
      .Sp
      Default value is **disable**.
      .Sp
      For more information about the available recovery modes, consult the
      paranoia project documentation.

<a name="libdc1394"></a>

### libdc1394

.IX Subsection "libdc1394"
\s-1IIDC1394\s0 input device, based on libdc1394 and libraw1394.

Requires the configure option \f(CW`--enable-libdc1394\*(C'.

<a name="libndi_newtek"></a>

### libndi_newtek

.IX Subsection "libndi_newtek"
The libndi_newtek input device provides capture capabilities for using \s-1NDI\s0 (Network
Device Interface, standard created by NewTek).

Input filename is a \s-1NDI\s0 source name that could be found by sending -find_sources 1
to command line - it has no specific syntax but human-readable formatted.

To enable this input device, you need the \s-1NDI SDK\s0 and you
need to configure with the appropriate \f(CW`--extra-cflags\*(C'
and \f(CW`--extra-ldflags\*(C'.

_Options_
.IX Subsection "Options"

* **find\_sources**  
  .IX Item "find_sources"
  If set to **true**, print a list of found/available \s-1NDI\s0 sources and exit.
  Defaults to **false**.
* **wait\_sources**  
  .IX Item "wait_sources"
  Override time to wait until the number of online sources have changed.
  Defaults to **0.5**.
* **allow\_video\_fields**  
  .IX Item "allow_video_fields"
  When this flag is **false**, all video that you receive will be progressive.
  Defaults to **true**.
* **extra\_ips**  
  .IX Item "extra_ips"
  If is set to list of comma separated ip addresses, scan for sources not only
  using mDNS but also use unicast ip addresses specified by this list.

_Examples_
.IX Subsection "Examples"

* ·  
  List input devices:
  .Sp
  .Vb 1
          ffmpeg -f libndi_newtek -find_sources 1 -i dummy
  .Ve
* ·  
  List local and remote input devices:
  .Sp
  .Vb 1
          ffmpeg -f libndi_newtek -extra_ips "192.168.10.10" -find_sources 1 -i dummy
  .Ve
* ·  
  Restream to \s-1NDI:\s0
  .Sp
  .Vb 1
          ffmpeg -f libndi_newtek -i "DEV-5.INTERNAL.M1STEREO.TV (NDI_SOURCE_NAME_1)" -f libndi_newtek -y NDI_SOURCE_NAME_2
  .Ve
* ·  
  Restream remote \s-1NDI\s0 to local \s-1NDI:\s0
  .Sp
  .Vb 1
          ffmpeg -f libndi_newtek -extra_ips "192.168.10.10" -i "DEV-5.REMOTE.M1STEREO.TV (NDI_SOURCE_NAME_1)" -f libndi_newtek -y NDI_SOURCE_NAME_2
  .Ve

<a name="openal"></a>

### openal

.IX Subsection "openal"
The OpenAL input device provides audio capture on all systems with a
working OpenAL 1.1 implementation.

To enable this input device during configuration, you need OpenAL
headers and libraries installed on your system, and need to configure
FFmpeg with \f(CW`--enable-openal\*(C'.

OpenAL headers and libraries should be provided as part of your OpenAL
implementation, or as an additional download (an \s-1SDK\s0). Depending on your
installation you may need to specify additional flags via the
\f(CW`--extra-cflags\*(C' and \f(CW\*(C\`--extra-ldflags\*(C' for allowing the build
system to locate the OpenAL headers and libraries.

An incomplete list of OpenAL implementations follows:

* **Creative**  
  .IX Item "Creative"
  The official Windows implementation, providing hardware acceleration
  with supported devices and software fallback.
  See &lt;**http://openal.org/**&gt;.
* **OpenAL Soft**  
  .IX Item "OpenAL Soft"
  Portable, open source (\s-1LGPL\s0) software implementation. Includes
  backends for the most common sound APIs on the Windows, Linux,
  Solaris, and \s-1BSD\s0 operating systems.
  See &lt;**http://kcat.strangesoft.net/openal.html**&gt;.
* **Apple**  
  .IX Item "Apple"
  OpenAL is part of Core Audio, the official Mac \s-1OS X\s0 Audio interface.
  See &lt;**http://developer.apple.com/technologies/mac/audio-and-video.html**&gt;

This device allows one to capture from an audio input device handled
through OpenAL.

You need to specify the name of the device to capture in the provided
filename. If the empty string is provided, the device will
automatically select the default device. You can get the list of the
supported devices by using the option _list\_devices_.

_Options_
.IX Subsection "Options"

* **channels**  
  .IX Item "channels"
  Set the number of channels in the captured audio. Only the values
  **1** (monaural) and **2** (stereo) are currently supported.
  Defaults to **2**.
* **sample\_size**  
  .IX Item "sample_size"
  Set the sample size (in bits) of the captured audio. Only the values
  **8** and **16** are currently supported. Defaults to
  **16**.
* **sample\_rate**  
  .IX Item "sample_rate"
  Set the sample rate (in Hz) of the captured audio.
  Defaults to **44.1k**.
* **list\_devices**  
  .IX Item "list_devices"
  If set to **true**, print a list of devices and exit.
  Defaults to **false**.

_Examples_
.IX Subsection "Examples"

Print the list of OpenAL supported devices and exit:

.Vb 1
        $ ffmpeg -list_devices true -f openal -i dummy out.ogg
.Ve

Capture from the OpenAL device _\s-1DR-BT101\s0 via PulseAudio_:

.Vb 1
        $ ffmpeg -f openal -i DR-BT101 via PulseAudio\*(Aq out.ogg
.Ve

Capture from the default device (note the empty string '' as filename):

.Vb 1
        $ ffmpeg -f openal -i \*(Aq out.ogg
.Ve

Capture from two devices simultaneously, writing to two different files,
within the same **ffmpeg** command:

.Vb 1
        $ ffmpeg -f openal -i DR-BT101 via PulseAudio\*(Aq out1.ogg -f openal -i \*(AqALSA Default\*(Aq out2.ogg
.Ve

Note: not all OpenAL implementations support multiple simultaneous capture -
try the latest OpenAL Soft if the above does not work.

<a name="oss"></a>

### oss

.IX Subsection "oss"
Open Sound System input device.

The filename to provide to the input device is the device node
representing the \s-1OSS\s0 input device, and is usually set to
_/dev/dsp_.

For example to grab from _/dev/dsp_ using **ffmpeg** use the
command:

.Vb 1
        ffmpeg -f oss -i /dev/dsp /tmp/oss.wav
.Ve

For more information about \s-1OSS\s0 see:
&lt;**http://manuals.opensound.com/usersguide/dsp.html**&gt;

_Options_
.IX Subsection "Options"

* **sample\_rate**  
  .IX Item "sample_rate"
  Set the sample rate in Hz. Default is 48000.
* **channels**  
  .IX Item "channels"
  Set the number of channels. Default is 2.

<a name="pulse"></a>

### pulse

.IX Subsection "pulse"
PulseAudio input device.

To enable this output device you need to configure FFmpeg with \f(CW`--enable-libpulse\*(C'.

The filename to provide to the input device is a source device or the
string default\*(R"

To list the PulseAudio source devices and their properties you can invoke
the command **pactl list sources**.

More information about PulseAudio can be found on &lt;**http://www.pulseaudio.org**&gt;.

_Options_
.IX Subsection "Options"

* **server**  
  .IX Item "server"
  Connect to a specific PulseAudio server, specified by an \s-1IP\s0 address.
  Default server is used when not provided.
* **name**  
  .IX Item "name"
  Specify the application name PulseAudio will use when showing active clients,
  by default it is the \f(CW`LIBAVFORMAT\_IDENT\*(C' string.
* **stream\_name**  
  .IX Item "stream_name"
  Specify the stream name PulseAudio will use when showing active streams,
  by default it is record\*(R".
* **sample\_rate**  
  .IX Item "sample_rate"
  Specify the samplerate in Hz, by default 48kHz is used.
* **channels**  
  .IX Item "channels"
  Specify the channels in use, by default 2 (stereo) is set.
* **frame\_size**  
  .IX Item "frame_size"
  Specify the number of bytes per frame, by default it is set to 1024.
* **fragment\_size**  
  .IX Item "fragment_size"
  Specify the minimal buffering fragment in PulseAudio, it will affect the
  audio latency. By default it is unset.
* **wallclock**  
  .IX Item "wallclock"
  Set the initial \s-1PTS\s0 using the current time. Default is 1.

_Examples_
.IX Subsection "Examples"

Record a stream from default device:

.Vb 1
        ffmpeg -f pulse -i default /tmp/pulse.wav
.Ve

<a name="sndio"></a>

### sndio

.IX Subsection "sndio"
sndio input device.

To enable this input device during configuration you need libsndio
installed on your system.

The filename to provide to the input device is the device node
representing the sndio input device, and is usually set to
_/dev/audio0_.

For example to grab from _/dev/audio0_ using **ffmpeg** use the
command:

.Vb 1
        ffmpeg -f sndio -i /dev/audio0 /tmp/oss.wav
.Ve

_Options_
.IX Subsection "Options"

* **sample\_rate**  
  .IX Item "sample_rate"
  Set the sample rate in Hz. Default is 48000.
* **channels**  
  .IX Item "channels"
  Set the number of channels. Default is 2.

<a name="video4linux2-v4l2"></a>

### video4linux2, v4l2

.IX Subsection "video4linux2, v4l2"
Video4Linux2 input video device.

v4l2\*(R" can be used as alias for \*(L"video4linux2\*(R".

If FFmpeg is built with v4l-utils support (by using the
\f(CW`--enable-libv4l2\*(C' configure option), it is possible to use it with the
\f(CW`-use\_libv4l2\*(C' input device option.

The name of the device to grab is a file device node, usually Linux
systems tend to automatically create such nodes when the device
(e.g. an \s-1USB\s0 webcam) is plugged into the system, and has a name of the
kind _/dev/videoN_, where _N_ is a number associated to
the device.

Video4Linux2 devices usually support a limited set of
_width_x_height_ sizes and frame rates. You can check which are
supported using **-list_formats all** for Video4Linux2 devices.
Some devices, like \s-1TV\s0 cards, support one or more standards. It is possible
to list all the supported standards using **-list_standards all**.

The time base for the timestamps is 1 microsecond. Depending on the kernel
version and configuration, the timestamps may be derived from the real time
clock (origin at the Unix Epoch) or the monotonic clock (origin usually at
boot time, unaffected by \s-1NTP\s0 or manual changes to the clock). The
**-timestamps abs** or **-ts abs** option can be used to force
conversion into the real time clock.

Some usage examples of the video4linux2 device with **ffmpeg**
and **ffplay**:

* ·  
  List supported formats for a video4linux2 device:
  .Sp
  .Vb 1
          ffplay -f video4linux2 -list_formats all /dev/video0
  .Ve
* ·  
  Grab and show the input of a video4linux2 device:
  .Sp
  .Vb 1
          ffplay -f video4linux2 -framerate 30 -video_size hd720 /dev/video0
  .Ve
* ·  
  Grab and record the input of a video4linux2 device, leave the
  frame rate and size as previously set:
  .Sp
  .Vb 1
          ffmpeg -f video4linux2 -input_format mjpeg -i /dev/video0 out.mpeg
  .Ve

For more information about Video4Linux, check &lt;**http://linuxtv.org/**&gt;.

_Options_
.IX Subsection "Options"

* **standard**  
  .IX Item "standard"
  Set the standard. Must be the name of a supported standard. To get a
  list of the supported standards, use the **list\_standards**
  option.
* **channel**  
  .IX Item "channel"
  Set the input channel number. Default to -1, which means using the
  previously selected channel.
* **video\_size**  
  .IX Item "video_size"
  Set the video frame size. The argument must be a string in the form
  _\s-1WIDTH\s0_x_\s-1HEIGHT\s0_ or a valid size abbreviation.
* **pixel\_format**  
  .IX Item "pixel_format"
  Select the pixel format (only valid for raw video input).
* **input\_format**  
  .IX Item "input_format"
  Set the preferred pixel format (for raw video) or a codec name.
  This option allows one to select the input format, when several are
  available.
* **framerate**  
  .IX Item "framerate"
  Set the preferred video frame rate.
* **list\_formats**  
  .IX Item "list_formats"
  List available formats (supported pixel formats, codecs, and frame
  sizes) and exit.
  .Sp
  Available values are:
    * **all**  
      .IX Item "all"
      Show all available (compressed and non-compressed) formats.
    * **raw**  
      .IX Item "raw"
      Show only raw video (non-compressed) formats.
    * **compressed**  
      .IX Item "compressed"
      Show only compressed formats.
* **list\_standards**  
  .IX Item "list_standards"
  List supported standards and exit.
  .Sp
  Available values are:
    * **all**  
      .IX Item "all"
      Show all supported standards.
* **timestamps, ts**  
  .IX Item "timestamps, ts"
  Set type of timestamps for grabbed frames.
  .Sp
  Available values are:
    * **default**  
      .IX Item "default"
      Use timestamps from the kernel.
    * **abs**  
      .IX Item "abs"
      Use absolute timestamps (wall clock).
    * **mono2abs**  
      .IX Item "mono2abs"
      Force conversion from monotonic to absolute timestamps.
      .Sp
      Default value is \f(CW`default\*(C'.
* **use\_libv4l2**  
  .IX Item "use_libv4l2"
  Use libv4l2 (v4l-utils) conversion functions. Default is 0.

<a name="vfwcap"></a>

### vfwcap

.IX Subsection "vfwcap"
VfW (Video for Windows) capture input device.

The filename passed as input is the capture driver number, ranging from
0 to 9. You may use list\*(R" as filename to print a list of drivers. Any
other filename will be interpreted as device number 0.

_Options_
.IX Subsection "Options"

* **video\_size**  
  .IX Item "video_size"
  Set the video frame size.
* **framerate**  
  .IX Item "framerate"
  Set the grabbing frame rate. Default value is \f(CW`ntsc\*(C',
  corresponding to a frame rate of \f(CW`30000/1001\*(C'.

<a name="x11grab"></a>

### x11grab

.IX Subsection "x11grab"
X11 video input device.

To enable this input device during configuration you need libxcb
installed on your system. It will be automatically detected during
configuration.

This device allows one to capture a region of an X11 display.

The filename passed as input has the syntax:

.Vb 1
        [&lt;hostname&gt;]:&lt;display_number&gt;.&lt;screen_number&gt;[+&lt;x_offset&gt;,&lt;y_offset&gt;]
.Ve

_hostname_:_display\_number_._screen\_number_ specifies the
X11 display name of the screen to grab from. _hostname_ can be
omitted, and defaults to localhost\*(R". The environment variable
**\s-1DISPLAY\s0** contains the default display name.

_x\_offset_ and _y\_offset_ specify the offsets of the grabbed
area with respect to the top-left border of the X11 screen. They
default to 0.

Check the X11 documentation (e.g. **man X**) for more detailed
information.

Use the **xdpyinfo** program for getting basic information about
the properties of your X11 display (e.g. grep for name\*(R" or
dimensions\*(R").

For example to grab from _:0.0_ using **ffmpeg**:

.Vb 1
        ffmpeg -f x11grab -framerate 25 -video_size cif -i :0.0 out.mpg
.Ve

Grab at position \f(CW`10,20\*(C':

.Vb 1
        ffmpeg -f x11grab -framerate 25 -video_size cif -i :0.0+10,20 out.mpg
.Ve

_Options_
.IX Subsection "Options"

* **draw\_mouse**  
  .IX Item "draw_mouse"
  Specify whether to draw the mouse pointer. A value of \f(CW0 specifies
  not to draw the pointer. Default value is \f(CW1.
* **follow\_mouse**  
  .IX Item "follow_mouse"
  Make the grabbed area follow the mouse. The argument can be
  \f(CW`centered\*(C' or a number of pixels _\s-1PIXELS\s0_.
  .Sp
  When it is specified with centered\*(R", the grabbing region follows the mouse
  pointer and keeps the pointer at the center of region; otherwise, the region
  follows only when the mouse pointer reaches within _\s-1PIXELS\s0_ (greater than
  zero) to the edge of region.
  .Sp
  For example:
  .Sp
  .Vb 1
          ffmpeg -f x11grab -follow_mouse centered -framerate 25 -video_size cif -i :0.0 out.mpg
  .Ve
  .Sp
  To follow only when the mouse pointer reaches within 100 pixels to edge:
  .Sp
  .Vb 1
          ffmpeg -f x11grab -follow_mouse 100 -framerate 25 -video_size cif -i :0.0 out.mpg
  .Ve
* **framerate**  
  .IX Item "framerate"
  Set the grabbing frame rate. Default value is \f(CW`ntsc\*(C',
  corresponding to a frame rate of \f(CW`30000/1001\*(C'.
* **show\_region**  
  .IX Item "show_region"
  Show grabbed region on screen.
  .Sp
  If _show\_region_ is specified with \f(CW1, then the grabbing
  region will be indicated on screen. With this option, it is easy to
  know what is being grabbed if only a portion of the screen is grabbed.
* **region\_border**  
  .IX Item "region_border"
  Set the region border thickness if **-show_region 1** is used.
  Range is 1 to 128 and default is 3 (XCB-based x11grab only).
  .Sp
  For example:
  .Sp
  .Vb 1
          ffmpeg -f x11grab -show_region 1 -framerate 25 -video_size cif -i :0.0+10,20 out.mpg
  .Ve
  .Sp
  With _follow\_mouse_:
  .Sp
  .Vb 1
          ffmpeg -f x11grab -follow_mouse centered -show_region 1 -framerate 25 -video_size cif -i :0.0 out.mpg
  .Ve
* **video\_size**  
  .IX Item "video_size"
  Set the video frame size. Default value is \f(CW`vga\*(C'.
* **grab\_x**  
  .IX Item "grab_x"
* **grab\_y**  
  .IX Item "grab_y"
  Set the grabbing region coordinates. They are expressed as offset from
  the top left corner of the X11 window and correspond to the
  _x\_offset_ and _y\_offset_ parameters in the device name. The
  default value for both options is 0.

<a name="output-devices"></a>

# Output Devices

.IX Header "OUTPUT DEVICES"
Output devices are configured elements in FFmpeg that can write
multimedia data to an output device attached to your system.

When you configure your FFmpeg build, all the supported output devices
are enabled by default. You can list all available ones using the
configure option --list-outdevs\*(R".

You can disable all the output devices using the configure option
--disable-outdevs\*(R", and selectively enable an output device using the
option "--enable-outdev=_\s-1OUTDEV\s0_, or you can disable a particular
input device using the option --disable-outdev=_\s-1OUTDEV\s0_".

The option -devices\*(R" of the ff* tools will display the list of
enabled output devices.

A description of the currently available output devices follows.

<a name="alsa"></a>

### alsa

.IX Subsection "alsa"
\s-1ALSA\s0 (Advanced Linux Sound Architecture) output device.

_Examples_
.IX Subsection "Examples"

* ·  
  Play a file on default \s-1ALSA\s0 device:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -f alsa default
  .Ve
* ·  
  Play a file on soundcard 1, audio device 7:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -f alsa hw:1,7
  .Ve

<a name="caca"></a>

### caca

.IX Subsection "caca"
\s-1CACA\s0 output device.

This output device allows one to show a video stream in \s-1CACA\s0 window.
Only one \s-1CACA\s0 window is allowed per application, so you can
have only one instance of this output device in an application.

To enable this output device you need to configure FFmpeg with
\f(CW`--enable-libcaca\*(C'.
libcaca is a graphics library that outputs text instead of pixels.

For more information about libcaca, check:
&lt;**http://caca.zoy.org/wiki/libcaca**&gt;

_Options_
.IX Subsection "Options"

* **window\_title**  
  .IX Item "window_title"
  Set the \s-1CACA\s0 window title, if not specified default to the filename
  specified for the output device.
* **window\_size**  
  .IX Item "window_size"
  Set the \s-1CACA\s0 window size, can be a string of the form
  _width_x_height_ or a video size abbreviation.
  If not specified it defaults to the size of the input video.
* **driver**  
  .IX Item "driver"
  Set display driver.
* **algorithm**  
  .IX Item "algorithm"
  Set dithering algorithm. Dithering is necessary
  because the picture being rendered has usually far more colours than
  the available palette.
  The accepted values are listed with \f(CW`-list_dither algorithms\*(C'.
* **antialias**  
  .IX Item "antialias"
  Set antialias method. Antialiasing smoothens the rendered
  image and avoids the commonly seen staircase effect.
  The accepted values are listed with \f(CW`-list_dither antialiases\*(C'.
* **charset**  
  .IX Item "charset"
  Set which characters are going to be used when rendering text.
  The accepted values are listed with \f(CW`-list_dither charsets\*(C'.
* **color**  
  .IX Item "color"
  Set color to be used when rendering text.
  The accepted values are listed with \f(CW`-list_dither colors\*(C'.
* **list\_drivers**  
  .IX Item "list_drivers"
  If set to **true**, print a list of available drivers and exit.
* **list\_dither**  
  .IX Item "list_dither"
  List available dither options related to the argument.
  The argument must be one of \f(CW`algorithms\*(C', \f(CW\*(C\`antialiases\*(C',
  \f(CW`charsets\*(C', \f(CW\*(C\`colors\*(C'.

_Examples_
.IX Subsection "Examples"

* ·  
  The following command shows the **ffmpeg** output is an
  \s-1CACA\s0 window, forcing its size to 80x25:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -c:v rawvideo -pix_fmt rgb24 -window_size 80x25 -f caca -
  .Ve
* ·  
  Show the list of available drivers and exit:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -pix_fmt rgb24 -f caca -list_drivers true -
  .Ve
* ·  
  Show the list of available dither colors and exit:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -pix_fmt rgb24 -f caca -list_dither colors -
  .Ve

<a name="decklink"></a>

### decklink

.IX Subsection "decklink"
The decklink output device provides playback capabilities for Blackmagic
DeckLink devices.

To enable this output device, you need the Blackmagic DeckLink \s-1SDK\s0 and you
need to configure with the appropriate \f(CW`--extra-cflags\*(C'
and \f(CW`--extra-ldflags\*(C'.
On Windows, you need to run the \s-1IDL\s0 files through **widl**.

DeckLink is very picky about the formats it supports. Pixel format is always
uyvy422, framerate, field order and video size must be determined for your
device with **-list_formats 1**. Audio sample rate is always 48 kHz.

_Options_
.IX Subsection "Options"

* **list\_devices**  
  .IX Item "list_devices"
  If set to **true**, print a list of devices and exit.
  Defaults to **false**. Alternatively you can use the \f(CW`-sinks\*(C'
  option of ffmpeg to list the available output devices.
* **list\_formats**  
  .IX Item "list_formats"
  If set to **true**, print a list of supported formats and exit.
  Defaults to **false**.
* **preroll**  
  .IX Item "preroll"
  Amount of time to preroll video in seconds.
  Defaults to **0.5**.
* **duplex\_mode**  
  .IX Item "duplex_mode"
  Sets the decklink device duplex mode. Must be **unset**, **half** or **full**.
  Defaults to **unset**.

_Examples_
.IX Subsection "Examples"

* ·  
  List output devices:
  .Sp
  .Vb 1
          ffmpeg -i test.avi -f decklink -list_devices 1 dummy
  .Ve
* ·  
  List supported formats:
  .Sp
  .Vb 1
          ffmpeg -i test.avi -f decklink -list_formats 1 DeckLink Mini Monitor\*(Aq
  .Ve
* ·  
  Play video clip:
  .Sp
  .Vb 1
          ffmpeg -i test.avi -f decklink -pix_fmt uyvy422 DeckLink Mini Monitor\*(Aq
  .Ve
* ·  
  Play video clip with non-standard framerate or video size:
  .Sp
  .Vb 1
          ffmpeg -i test.avi -f decklink -pix_fmt uyvy422 -s 720x486 -r 24000/1001 DeckLink Mini Monitor\*(Aq
  .Ve

<a name="fbdev"></a>

### fbdev

.IX Subsection "fbdev"
Linux framebuffer output device.

The Linux framebuffer is a graphic hardware-independent abstraction
layer to show graphics on a computer monitor, typically on the
console. It is accessed through a file device node, usually
_/dev/fb0_.

For more detailed information read the file
_Documentation/fb/framebuffer.txt_ included in the Linux source tree.

_Options_
.IX Subsection "Options"

* **xoffset**  
  .IX Item "xoffset"
* **yoffset**  
  .IX Item "yoffset"
  Set x/y coordinate of top left corner. Default is 0.

_Examples_
.IX Subsection "Examples"

Play a file on framebuffer device _/dev/fb0_.
Required pixel format depends on current framebuffer settings.

.Vb 1
        ffmpeg -re -i INPUT -c:v rawvideo -pix_fmt bgra -f fbdev /dev/fb0
.Ve

See also &lt;**http://linux-fbdev.sourceforge.net/**&gt;, and **fbset**\|(1).

<a name="libndi_newtek"></a>

### libndi_newtek

.IX Subsection "libndi_newtek"
The libndi_newtek output device provides playback capabilities for using \s-1NDI\s0 (Network
Device Interface, standard created by NewTek).

Output filename is a \s-1NDI\s0 name.

To enable this output device, you need the \s-1NDI SDK\s0 and you
need to configure with the appropriate \f(CW`--extra-cflags\*(C'
and \f(CW`--extra-ldflags\*(C'.

\s-1NDI\s0 uses uyvy422 pixel format natively, but also supports bgra, bgr0, rgba and
rgb0.

_Options_
.IX Subsection "Options"

* **reference\_level**  
  .IX Item "reference_level"
  The audio reference level in dB. This specifies how many dB above the
  reference level (+4dBU) is the full range of 16 bit audio.
  Defaults to **0**.
* **clock\_video**  
  .IX Item "clock_video"
  These specify whether video clock\*(R" themselves.
  Defaults to **false**.
* **clock\_audio**  
  .IX Item "clock_audio"
  These specify whether audio clock\*(R" themselves.
  Defaults to **false**.

_Examples_
.IX Subsection "Examples"

* ·  
  Play video clip:
  .Sp
  .Vb 1
          ffmpeg -i "udp://@239.1.1.1:10480?fifo_size=1000000&overrun_nonfatal=1" -vf "scale=720:576,fps=fps=25,setdar=dar=16/9,format=pix_fmts=uyvy422" -f libndi_newtek NEW_NDI1
  .Ve

<a name="opengl"></a>

### opengl

.IX Subsection "opengl"
OpenGL output device.

To enable this output device you need to configure FFmpeg with \f(CW`--enable-opengl\*(C'.

This output device allows one to render to OpenGL context.
Context may be provided by application or default \s-1SDL\s0 window is created.

When device renders to external context, application must implement handlers for following messages:
\f(CW`AV\_DEV\_TO\_APP\_CREATE\_WINDOW\_BUFFER\*(C' - create OpenGL context on current thread.
\f(CW`AV\_DEV\_TO\_APP\_PREPARE\_WINDOW\_BUFFER\*(C' - make OpenGL context current.
\f(CW`AV\_DEV\_TO\_APP\_DISPLAY\_WINDOW\_BUFFER\*(C' - swap buffers.
\f(CW`AV\_DEV\_TO\_APP\_DESTROY\_WINDOW\_BUFFER\*(C' - destroy OpenGL context.
Application is also required to inform a device about current resolution by sending \f(CW`AV\_APP\_TO\_DEV\_WINDOW\_SIZE\*(C' message.

_Options_
.IX Subsection "Options"

* **background**  
  .IX Item "background"
  Set background color. Black is a default.
* **no\_window**  
  .IX Item "no_window"
  Disables default \s-1SDL\s0 window when set to non-zero value.
  Application must provide OpenGL context and both \f(CW`window\_size\_cb\*(C' and \f(CW\*(C\`window\_swap\_buffers\_cb\*(C' callbacks when set.
* **window\_title**  
  .IX Item "window_title"
  Set the \s-1SDL\s0 window title, if not specified default to the filename specified for the output device.
  Ignored when **no\_window** is set.
* **window\_size**  
  .IX Item "window_size"
  Set preferred window size, can be a string of the form widthxheight or a video size abbreviation.
  If not specified it defaults to the size of the input video, downscaled according to the aspect ratio.
  Mostly usable when **no\_window** is not set.

_Examples_
.IX Subsection "Examples"

Play a file on \s-1SDL\s0 window using OpenGL rendering:

.Vb 1
        ffmpeg  -i INPUT -f opengl "window title"
.Ve

<a name="oss"></a>

### oss

.IX Subsection "oss"
\s-1OSS\s0 (Open Sound System) output device.

<a name="pulse"></a>

### pulse

.IX Subsection "pulse"
PulseAudio output device.

To enable this output device you need to configure FFmpeg with \f(CW`--enable-libpulse\*(C'.

More information about PulseAudio can be found on &lt;**http://www.pulseaudio.org**&gt;

_Options_
.IX Subsection "Options"

* **server**  
  .IX Item "server"
  Connect to a specific PulseAudio server, specified by an \s-1IP\s0 address.
  Default server is used when not provided.
* **name**  
  .IX Item "name"
  Specify the application name PulseAudio will use when showing active clients,
  by default it is the \f(CW`LIBAVFORMAT\_IDENT\*(C' string.
* **stream\_name**  
  .IX Item "stream_name"
  Specify the stream name PulseAudio will use when showing active streams,
  by default it is set to the specified output name.
* **device**  
  .IX Item "device"
  Specify the device to use. Default device is used when not provided.
  List of output devices can be obtained with command **pactl list sinks**.
* **buffer\_size**  
  .IX Item "buffer_size"
* **buffer\_duration**  
  .IX Item "buffer_duration"
  Control the size and duration of the PulseAudio buffer. A small buffer
  gives more control, but requires more frequent updates.
  .Sp
  **buffer\_size** specifies size in bytes while
  **buffer\_duration** specifies duration in milliseconds.
  .Sp
  When both options are provided then the highest value is used
  (duration is recalculated to bytes using stream parameters). If they
  are set to 0 (which is default), the device will use the default
  PulseAudio duration value. By default PulseAudio set buffer duration
  to around 2 seconds.
* **prebuf**  
  .IX Item "prebuf"
  Specify pre-buffering size in bytes. The server does not start with
  playback before at least **prebuf** bytes are available in the
  buffer. By default this option is initialized to the same value as
  **buffer\_size** or **buffer\_duration** (whichever is bigger).
* **minreq**  
  .IX Item "minreq"
  Specify minimum request size in bytes. The server does not request less
  than **minreq** bytes from the client, instead waits until the buffer
  is free enough to request more bytes at once. It is recommended to not set
  this option, which will initialize this to a value that is deemed sensible
  by the server.

_Examples_
.IX Subsection "Examples"

Play a file on default device on default server:

.Vb 1
        ffmpeg  -i INPUT -f pulse "stream name"
.Ve

<a name="sdl"></a>

### sdl

.IX Subsection "sdl"
\s-1SDL\s0 (Simple DirectMedia Layer) output device.

This output device allows one to show a video stream in an \s-1SDL\s0
window. Only one \s-1SDL\s0 window is allowed per application, so you can
have only one instance of this output device in an application.

To enable this output device you need libsdl installed on your system
when configuring your build.

For more information about \s-1SDL,\s0 check:
&lt;**http://www.libsdl.org/**&gt;

_Options_
.IX Subsection "Options"

* **window\_title**  
  .IX Item "window_title"
  Set the \s-1SDL\s0 window title, if not specified default to the filename
  specified for the output device.
* **icon\_title**  
  .IX Item "icon_title"
  Set the name of the iconified \s-1SDL\s0 window, if not specified it is set
  to the same value of _window\_title_.
* **window\_size**  
  .IX Item "window_size"
  Set the \s-1SDL\s0 window size, can be a string of the form
  _width_x_height_ or a video size abbreviation.
  If not specified it defaults to the size of the input video,
  downscaled according to the aspect ratio.
* **window\_x**  
  .IX Item "window_x"
* **window\_y**  
  .IX Item "window_y"
  Set the position of the window on the screen.
* **window\_fullscreen**  
  .IX Item "window_fullscreen"
  Set fullscreen mode when non-zero value is provided.
  Default value is zero.
* **window\_enable\_quit**  
  .IX Item "window_enable_quit"
  Enable quit action (using window button or keyboard key)
  when non-zero value is provided.
  Default value is 1 (enable quit action)

_Interactive commands_
.IX Subsection "Interactive commands"

The window created by the device can be controlled through the
following interactive commands.

* **q, \s-1ESC\s0**  
  .IX Item "q, ESC"
  Quit the device immediately.

_Examples_
.IX Subsection "Examples"

The following command shows the **ffmpeg** output is an
\s-1SDL\s0 window, forcing its size to the qcif format:

.Vb 1
        ffmpeg -i INPUT -c:v rawvideo -pix_fmt yuv420p -window_size qcif -f sdl "SDL output"
.Ve

<a name="sndio"></a>

### sndio

.IX Subsection "sndio"
sndio audio output device.

<a name="v4l2"></a>

### v4l2

.IX Subsection "v4l2"
Video4Linux2 output device.

<a name="xv"></a>

### xv

.IX Subsection "xv"
\s-1XV\s0 (XVideo) output device.

This output device allows one to show a video stream in a X Window System
window.

_Options_
.IX Subsection "Options"

* **display\_name**  
  .IX Item "display_name"
  Specify the hardware display name, which determines the display and
  communications domain to be used.
  .Sp
  The display name or \s-1DISPLAY\s0 environment variable can be a string in
  the format _hostname_[:_number_[._screen\_number_]].
  .Sp
  _hostname_ specifies the name of the host machine on which the
  display is physically attached. _number_ specifies the number of
  the display server on that host machine. _screen\_number_ specifies
  the screen to be used on that server.
  .Sp
  If unspecified, it defaults to the value of the \s-1DISPLAY\s0 environment
  variable.
  .Sp
  For example, \f(CW`dual-headed:0.1\*(C' would specify screen 1 of display
  0 on the machine named \`\`dual-headed''.
  .Sp
  Check the X11 specification for more detailed information about the
  display name format.
* **window\_id**  
  .IX Item "window_id"
  When set to non-zero value then device doesn't create new window,
  but uses existing one with provided _window\_id_. By default
  this options is set to zero and device creates its own window.
* **window\_size**  
  .IX Item "window_size"
  Set the created window size, can be a string of the form
  _width_x_height_ or a video size abbreviation. If not
  specified it defaults to the size of the input video.
  Ignored when _window\_id_ is set.
* **window\_x**  
  .IX Item "window_x"
* **window\_y**  
  .IX Item "window_y"
  Set the X and Y window offsets for the created window. They are both
  set to 0 by default. The values may be ignored by the window manager.
  Ignored when _window\_id_ is set.
* **window\_title**  
  .IX Item "window_title"
  Set the window title, if not specified default to the filename
  specified for the output device. Ignored when _window\_id_ is set.

For more information about XVideo see &lt;**http://www.x.org/**&gt;.

_Examples_
.IX Subsection "Examples"

* ·  
  Decode, display and encode video input with **ffmpeg** at the
  same time:
  .Sp
  .Vb 1
          ffmpeg -i INPUT OUTPUT -f xv display
  .Ve
* ·  
  Decode and display the input video to multiple X11 windows:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -f xv normal -vf negate -f xv negated
  .Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ffmpeg**\|(1), **ffplay**\|(1), **ffprobe**\|(1), **libavdevice**\|(3)

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
