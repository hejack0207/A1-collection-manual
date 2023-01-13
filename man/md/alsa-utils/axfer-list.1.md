# axfer\-list(1) - dump lists of available sound devices and nodes to transfer audio

alsa\-utils, 28 November 2018

data frame.


<a name="synopsis"></a>

# Synopsis


```
axfer list direction target
</synopsis>

<synopsis>
direction = capture | playback
</synopsis>

<synopsis>
target = device | pcm
```


<a name="description"></a>

# Description

The
**list**
subcommand of
**axfer**
dumps lists of available nodes to
transfer audio data frame. At present, the subcommand is helpful just for
libasound backend of
**transfer**
subcommand.


<a name="options"></a>

# Options



<a name="direction"></a>

### Direction



* **capture**  
  Operates for capture transmission.
  
* **playback**  
  Operates for playback transmission.
  

<a name="target"></a>

### Target



* **device**  
  Dumps a list of all soundcards and digital audio devices available in
  _libasound_
  backend for
  _tranfer_
  subcommand.
  
* **pcm**  
  Dumps a list of all PCM nodes available in alsa-lib configuration space in
  _libasound_
  backend for
  _transfer_
  subcommand.
  

<a name="compatibility-to-aplay"></a>

# Compatibility to Aplay


Options of
_-l_
,
_--list-devices_
are handled as
_device_
operation. Options of
_-L_
,
_--list-pcms_
are handled as
_pcm_
operation.


<a name="see-also"></a>

# See Also

**axfer(1),**
**axfer-transfer(1),**
**alsamixer(1),**
**amixer(1)**


<a name="author"></a>

# Author

Takashi Sakamoto &lt;[o-takashi@sakamocchi.jp](mailto:o-takashi@sakamocchi.jp)&gt;
