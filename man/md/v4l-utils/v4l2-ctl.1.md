# v4l2-ctl(1) - An application to control video4linux drivers

v4l-utils 1.16.7, March 2015

```
v4l2-ctl [-h] [-d <dev>] [many other options]
```

<a name="description"></a>

# Description

The v4l2-ctl tool is used to control video4linux devices, either video, vbi, radio
or swradio, both input and output. It is able to control almost any aspect of such
devices covering the full V4L2 API.


<a name="options"></a>

# Options


* **-d**, **--device** _&lt;dev&gt;_  
  Use device &lt;dev&gt; as the V4L2 device. If &lt;dev&gt; is a number, then /dev/video&lt;dev&gt; is used.
* **-v**, **--verbose**  
  Turn on verbose reporting.
* **-w**, **--wrapper**  
  Use the libv4l2 wrapper library for all V4L2 device accesses. By default v4l2-ctl will
  directly access the V4L2 device, but with this option all access will go via this
  wrapper library.
* **-h**, **--help**  
  Prints the help message.
* **--help-io**  
  Prints the help message for all options that get/set/list inputs and outputs, both
  video and audio.
* **--help-misc**  
  Prints the help message for miscellaneous options.
* **--help-overlay**  
  Prints the help message for all options that get/set/list overlay and framebuffer
  formats.
* **--help-sdr**  
  Prints the help message for all options that get/set/list software defined radio
  formats.
* **--help-selection**  
  Prints the help message for all options that deal with selections (cropping and
  composing).
* **--help-stds**  
  Prints the help message for all options that deal with SDTV standards and Digital
  Video timings.
* **--help-streaming**  
  Prints the help message for all options that deal with streaming.
* **--help-subdev**  
  Prints the help message for all options that deal with v4l-subdevX devices.
* **--help-tuner**  
  Prints the help message for all options that deal with tuners and modulators.
* **--help-vbi**  
  Prints the help message for all options that get/set/list VBI formats.
* **--help-vidcap**  
  Prints the help message for all options that get/set/list video capture formats.
* **--help-vidout**  
  Prints the help message for all options that get/set/list video output formats.
* **--help-edid**  
  Prints the help message for all options that get/set EDIDs.
* **--help-all**  
  Prints the help message for all options.
* **--all**  
  Display all information available.
* **-C**, **--get-ctrl** _&lt;ctrl&gt;_[,_&lt;ctrl&gt;_...]  
  Get the value of the controls [VIDIOC_G_EXT_CTRLS].
* **-c**, **--set-ctrl** _&lt;ctrl&gt;_=_&lt;val&gt;_[,_&lt;ctrl&gt;_=_&lt;val&gt;_...]  
  Set the value of the controls [VIDIOC_S_EXT_CTRLS].
* **-D**, **--info**  
  Show driver info [VIDIOC_QUERYCAP].
* **-e**, **--out-device** _&lt;dev&gt;_  
  Use device _&lt;dev&gt;_ for output streams instead of the
  default device as set with --device. If _&lt;dev&gt;_ starts
  with a digit, then /dev/video_&lt;dev&gt;_ is used.
* **-k**, **--concise**  
  Be more concise if possible.
* **-l**, **--list-ctrls**  
  Display all controls and their values [VIDIOC_QUERYCTRL].
* **-L**, **--list-ctrls-menus**  
  Display all controls and their menus [VIDIOC_QUERYMENU].
* **-r**, **--subset** _&lt;ctrl&gt;_[,_&lt;offset&gt;_,_&lt;size&gt;_]+  
  The subset of the N-dimensional array to get/set for control _&lt;ctrl&gt;_,
  for every dimension an (_&lt;offset&gt;_, _&lt;size&gt;_) tuple is given.
* **--list-devices**  
  List all v4l devices.
* **--log-status**  
  Log the board status in the kernel log [VIDIOC_LOG_STATUS].
* **--get-priority**  
  Query the current access priority [VIDIOC_G_PRIORITY].
* **--set-priority** _&lt;prio&gt;_  
  Set the new access priority [VIDIOC_S_PRIORITY].
  _&lt;prio&gt;_ is 1 (background), 2 (interactive) or 3 (record).
* **--silent**  
  Only set the result code, do not print any messages.
* **--sleep** _&lt;secs&gt;_  
  Sleep _&lt;secs&gt;_, call QUERYCAP and close the file handle.

<a name="exit-status"></a>

# Exit Status

On success, it returns 0. Otherwise, it will return the error code.

<a name="bugs"></a>

# Bugs

This manual page is a work in progress.

Bug reports or questions about this utility should be sent to the linux-media@vger.kernel.org
mailinglist.
