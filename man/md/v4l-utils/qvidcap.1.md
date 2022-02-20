# qvidcap(1) - A v4l2 video capture viewer

v4l-utils 1.16.7, June 2016

```
qvidcap [<options>]
```

<a name="description"></a>

# Description

The qvidcap tool is used to test video4linux capture devices, either using a video device, a file,
or over network. This application can also serve as a generic video/TV viewer application.

It does not (yet) support compressed video streams other than MJPEG

<a name="options"></a>

# Options


* **-d**, **--device**=_&lt;dev&gt;_  
  Use device &lt;dev&gt; as the video device if &lt;dev&gt; is a number, then /dev/video&lt;dev&gt; is used
* **-f**, **--file**=_&lt;file&gt;_  
  Read from the file &lt;file&gt; for the raw frame data
* **-p**, **--port**_[=&lt;port&gt;]_  
  Listen for a network connection on the given port. The default port is 8362
* **-T**, **--tpg**  
  Use the test pattern generator. If neither -d, -f nor -T is specified then use /dev/video0.
* **-c**, **--count**=_&lt;cnt&gt;_  
  Stop after &lt;cnt&gt; captured frames
* **-b**, **--buffers**=_&lt;bufs&gt;_  
  Request &lt;bufs&gt; buffers (default 4) when streaming from a video device.
* **-s**, **--single-step**_[=&lt;frm&gt;]_  
  Starting with frame &lt;frm&gt; (default 1), pause after displaying each frame
  until Space is pressed.
* **-C**, **--colorspace**=_&lt;c&gt;_  
  Override colorspace. &lt;c&gt; can be one of the following colorspaces: smpte170m, smpte240m, rec709, 470m, 470bg, jpeg, srgb, oprgb, bt2020, dcip3
* **-X**, **--xfer-func**=_&lt;x&gt;_  
  Override transfer function. &lt;x&gt; can be one of the following transfer functions: default, 709, srgb, oprgb, smpte240m, smpte2084, dcip3, none
* **-Y**, **--ycbcr-enc**=_&lt;y&gt;_  
  Override Y'CbCr encoding. &lt;y&gt; can be one of the following Y'CbCr encodings: default, 601, 709, xv601, xv709, bt2020, bt2020c, smpte240m
* **-Q**, **--quant**=_&lt;q&gt;_  
  Override quantization. &lt;q&gt; can be one of the following quantization methods: default, full-range, lim-range
* **-P**, **--pixelformat**=_&lt;p&gt;_  
  For video devices: set the format to this pixel format.
  For reading from a file: interpret the data using this pixel format setting.
  Ignored for other modes.
  Use -l to see the list of supported pixel formats.
* **-l**, **--list-formats**  
  Display all supported formats
* **-h**, **--help**  
  Display this help message
* **-t**, **--timing**s  
  Report frame render timings
* **-v**, **--verbose**  
  Be more verbose
* **-R**, **--raw**  
  Open device in raw mode
* **--opengl**  
  Force openGL to display the video
* **--opengles**  
  Force openGL ES to display the video
* The following options are ignored when capturing from a video device:  
* **-W,--width**=_&lt;width&gt;_  
  Set width
* **-H,--height**=_&lt;height&gt;_  
  Set frame (not field!) height
* **--fps**=_&lt;fps&gt;_  
  Set frames-per-second (default is 30)
* The following option is only valid when reading from a file:  
* **-F**, **--field**=_&lt;f&gt;_  
  Override field setting. &lt;f&gt; can be one of the following field layouts: any, none, top, bottom, interlaced, seq_tb, seq_bt, alternate, interlaced_tb, interlaced_bt
* The following options are specific to the test pattern generator:  
* **--list-patterns**  
  List available patterns for use with --pattern
* **--pattern**=_&lt;pat&gt;_  
  Choose output test pattern, the default is 0
* **--square**  
  Show a square in the middle of the output test pattern
* **--border**  
  Show a border around the pillar/letterboxed video
* **--sav**  
  Insert an SAV code in every line
* **--eav**  
  Insert an EAV code in every line
* **--pixel-aspect**=_&lt;aspect&gt;_  
  Select a pixel aspect ratio, the default is to autodetect. &lt;aspect&gt; can be one of: square, ntsc, pal
* **--video-aspect**=_&lt;aspect&gt;_  
  Select a video aspect ratio, the default is to use the frame ratio. &lt;aspect&gt; can be one of: 4  x3, 14x9, 16x9, anamorphic
* **--alpha**=_&lt;alpha-value&gt;_  
  Value to use for the alpha component, range 0-255, the default is 0
* **--alpha-red-only**  
  Only use the --alpha value for the red colors, for all others use 0
* **--rgb-lim-range**  
  Encode RGB values as limited [16-235] instead of full range
* **--hor-speed**=_&lt;speed&gt;_  
  Choose speed for horizontal movement, the default is 0 and the range is [-3...3]
* **--vert-speed**=_&lt;speed&gt;_  
  Choose speed for vertical movement, the default is 0 and the range is [-3...3]
* **--perc-fill**=_&lt;percentage&gt;_  
  Percentage of the frame to actually fill. the default is 100%
* These options use the test pattern generator to test the OpenGL backend:  
* **--test**=_&lt;count&gt;_  
  Test all formats, each test generates &lt;count&gt; frames.
* **--test-mask**=_&lt;mask&gt;_  
  Mask which tests are performed. &lt;mask&gt; is a bit mask with these values:  
  0x01: Mask iterating over pixel formats  
  0x02: Mask iterating over fields  
  0x04: Mask iterating over colorspaces  
  0x08: Mask iterating over transfer functions  
  0x10: Mask iterating over Y'CbCr encodings  
  0x20: Mask iterating over quantization ranges

<a name="hotkeys"></a>

# Hotkeys


* _Q_  
  Quit application.
* _P_  
  Cycle forwards through all the supported pixel formats.
  With Shift pressed: cycle backwards.
  With Ctrl pressed: restore the original pixel format.
  Only available with --file.
* _I_  
  Cycle forwards through all the supported interlaced field settings.
  With Shift pressed: cycle backwards.
  With Ctrl pressed: restore the original interlaced field setting.
  Only available with --file.
* _C_  
  Cycle forwards through all the supported colorspaces.
  With Shift pressed: cycle backwards.
  With Ctrl pressed: restore the original colorspace.
* _X_  
  Cycle forwards through all the supported transfer functions.
  With Shift pressed: cycle backwards.
  With Ctrl pressed: restore the original transfer function.
* _Y_  
  Cycle forwards through all the supported Y'CbCr encodings.
  With Shift pressed: cycle backwards.
  With Ctrl pressed: restore the original Y'CbCr encoding.
* _H_  
  Cycle forwards through all the supported HSV encodings.
  With Shift pressed: cycle backwards.
  With Ctrl pressed: restore the original HSV encoding.
* _R_  
  Cycle forwards through all the supported quantization ranges.
  With Shift pressed: cycle backwards.
  With Ctrl pressed: restore the original quantization range.
* _Right-Click_  
  Open menu.
* _Double left-click_  
  Toggle fullscreen on and off.
* _F_  
  Toggle fullscreen on and off.
* _ESC_  
  Exit fullscreen.
* _Space_  
  When in test mode (**--test**) pressing Space will skip to the next test.
  When single-stepping, continue to the next frame.
* _Up_  
  Reduce the resolution by two pixels in height. Only available when "Override resolution" is enabled.
* _Down_  
  Increase the resolution by two pixels in height. Only available when "Override resolution" is enabled.
* _Left_  
  Reduce the resolution by two pixels in width. Only available when "Override resolution" is enabled.
* _Right_  
  Increase the resolution by two pixels in width. Only available when "Override resolution" is enabled.

<a name="exit-status"></a>

# Exit Status

On success, it returns 0. Otherwise, it will return the number of errors.

<a name="bugs"></a>

# Bugs

Report bugs to Hans Verkuil &lt;hverkuil@xs4all.nl&gt;
