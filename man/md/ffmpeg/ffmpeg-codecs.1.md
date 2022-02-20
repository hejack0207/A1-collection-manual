# ffmpeg-codecs(1)

 ,  

.if n .ad l
.nh

<a name="name"></a>

# Name

ffmpeg-codecs - FFmpeg codecs

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This document describes the codecs (decoders and encoders) provided by
the libavcodec library.

<a name="codec-options"></a>

# Codec Options

.IX Header "CODEC OPTIONS"
libavcodec provides some generic global options, which can be set on
all the encoders and decoders. In addition each codec may support
so-called private options, which are specific for a given codec.

Sometimes, a global option may only affect a specific kind of codec,
and may be nonsensical or ignored by another, so you need to be aware
of the meaning of the specified options. Also some options are
meant only for decoding or encoding.

Options may be set by specifying -_option_ _value_ in the
FFmpeg tools, or by setting the value explicitly in the
\f(CW`AVCodecContext\*(C' options or using the _libavutil/opt.h_ \s-1API\s0
for programmatic use.

The list of supported options follow:

* **b** _integer_ **(**_encoding,audio,video_**)**  
  .IX Item "b integer (encoding,audio,video)"
  Set bitrate in bits/s. Default value is 200K.
* **ab** _integer_ **(**_encoding,audio_**)**  
  .IX Item "ab integer (encoding,audio)"
  Set audio bitrate (in bits/s). Default value is 128K.
* **bt** _integer_ **(**_encoding,video_**)**  
  .IX Item "bt integer (encoding,video)"
  Set video bitrate tolerance (in bits/s). In 1-pass mode, bitrate
  tolerance specifies how far ratecontrol is willing to deviate from the
  target average bitrate value. This is not related to min/max
  bitrate. Lowering tolerance too much has an adverse effect on quality.
* **flags** _flags_ **(**_decoding/encoding,audio,video,subtitles_**)**  
  .IX Item "flags flags (decoding/encoding,audio,video,subtitles)"
  Set generic flags.
  .Sp
  Possible values:
    * **mv4**  
      .IX Item "mv4"
      Use four motion vector by macroblock (mpeg4).
    * **qpel**  
      .IX Item "qpel"
      Use 1/4 pel motion compensation.
    * **loop**  
      .IX Item "loop"
      Use loop filter.
    * **qscale**  
      .IX Item "qscale"
      Use fixed qscale.
    * **pass1**  
      .IX Item "pass1"
      Use internal 2pass ratecontrol in first pass mode.
    * **pass2**  
      .IX Item "pass2"
      Use internal 2pass ratecontrol in second pass mode.
    * **gray**  
      .IX Item "gray"
      Only decode/encode grayscale.
    * **emu\_edge**  
      .IX Item "emu_edge"
      Do not draw edges.
    * **psnr**  
      .IX Item "psnr"
      Set error[?] variables during encoding.
    * **truncated**  
      .IX Item "truncated"
    * **ildct**  
      .IX Item "ildct"
      Use interlaced \s-1DCT.\s0
    * **low\_delay**  
      .IX Item "low_delay"
      Force low delay.
    * **global\_header**  
      .IX Item "global_header"
      Place global headers in extradata instead of every keyframe.
    * **bitexact**  
      .IX Item "bitexact"
      Only write platform-, build- and time-independent data. (except (I)DCT).
      This ensures that file and data checksums are reproducible and match between
      platforms. Its primary use is for regression testing.
    * **aic**  
      .IX Item "aic"
      Apply H263 advanced intra coding / mpeg4 ac prediction.
    * **cbp**  
      .IX Item "cbp"
      Deprecated, use mpegvideo private options instead.
    * **qprd**  
      .IX Item "qprd"
      Deprecated, use mpegvideo private options instead.
    * **ilme**  
      .IX Item "ilme"
      Apply interlaced motion estimation.
    * **cgop**  
      .IX Item "cgop"
      Use closed gop.
* **me\_method** _integer_ **(**_encoding,video_**)**  
  .IX Item "me_method integer (encoding,video)"
  Set motion estimation method.
  .Sp
  Possible values:
    * **zero**  
      .IX Item "zero"
      zero motion estimation (fastest)
    * **full**  
      .IX Item "full"
      full motion estimation (slowest)
    * **epzs**  
      .IX Item "epzs"
      \s-1EPZS\s0 motion estimation (default)
    * **esa**  
      .IX Item "esa"
      esa motion estimation (alias for full)
    * **tesa**  
      .IX Item "tesa"
      tesa motion estimation
    * **dia**  
      .IX Item "dia"
      dia motion estimation (alias for epzs)
    * **log**  
      .IX Item "log"
      log motion estimation
    * **phods**  
      .IX Item "phods"
      phods motion estimation
    * **x1**  
      .IX Item "x1"
      X1 motion estimation
    * **hex**  
      .IX Item "hex"
      hex motion estimation
    * **umh**  
      .IX Item "umh"
      umh motion estimation
    * **iter**  
      .IX Item "iter"
      iter motion estimation
* **extradata\_size** _integer_  
  .IX Item "extradata_size integer"
  Set extradata size.
* **time\_base** _rational number_  
  .IX Item "time_base rational number"
  Set codec time base.
  .Sp
  It is the fundamental unit of time (in seconds) in terms of which
  frame timestamps are represented. For fixed-fps content, timebase
  should be \f(CW`1 / frame\_rate\*(C' and timestamp increments should be
  identically 1.
* **g** _integer_ **(**_encoding,video_**)**  
  .IX Item "g integer (encoding,video)"
  Set the group of picture (\s-1GOP\s0) size. Default value is 12.
* **ar** _integer_ **(**_decoding/encoding,audio_**)**  
  .IX Item "ar integer (decoding/encoding,audio)"
  Set audio sampling rate (in Hz).
* **ac** _integer_ **(**_decoding/encoding,audio_**)**  
  .IX Item "ac integer (decoding/encoding,audio)"
  Set number of audio channels.
* **cutoff** _integer_ **(**_encoding,audio_**)**  
  .IX Item "cutoff integer (encoding,audio)"
  Set cutoff bandwidth. (Supported only by selected encoders, see
  their respective documentation sections.)
* **frame\_size** _integer_ **(**_encoding,audio_**)**  
  .IX Item "frame_size integer (encoding,audio)"
  Set audio frame size.
  .Sp
  Each submitted frame except the last must contain exactly frame_size
  samples per channel. May be 0 when the codec has
  \s-1CODEC_CAP_VARIABLE_FRAME_SIZE\s0 set, in that case the frame size is not
  restricted. It is set by some decoders to indicate constant frame
  size.
* **frame\_number** _integer_  
  .IX Item "frame_number integer"
  Set the frame number.
* **delay** _integer_  
  .IX Item "delay integer"
* **qcomp** _float_ **(**_encoding,video_**)**  
  .IX Item "qcomp float (encoding,video)"
  Set video quantizer scale compression (\s-1VBR\s0). It is used as a constant
  in the ratecontrol equation. Recommended range for default rc_eq:
  0.0-1.0.
* **qblur** _float_ **(**_encoding,video_**)**  
  .IX Item "qblur float (encoding,video)"
  Set video quantizer scale blur (\s-1VBR\s0).
* **qmin** _integer_ **(**_encoding,video_**)**  
  .IX Item "qmin integer (encoding,video)"
  Set min video quantizer scale (\s-1VBR\s0). Must be included between -1 and
  69, default value is 2.
* **qmax** _integer_ **(**_encoding,video_**)**  
  .IX Item "qmax integer (encoding,video)"
  Set max video quantizer scale (\s-1VBR\s0). Must be included between -1 and
  1024, default value is 31.
* **qdiff** _integer_ **(**_encoding,video_**)**  
  .IX Item "qdiff integer (encoding,video)"
  Set max difference between the quantizer scale (\s-1VBR\s0).
* **bf** _integer_ **(**_encoding,video_**)**  
  .IX Item "bf integer (encoding,video)"
  Set max number of B frames between non-B-frames.
  .Sp
  Must be an integer between -1 and 16. 0 means that B-frames are
  disabled. If a value of -1 is used, it will choose an automatic value
  depending on the encoder.
  .Sp
  Default value is 0.
* **b\_qfactor** _float_ **(**_encoding,video_**)**  
  .IX Item "b_qfactor float (encoding,video)"
  Set qp factor between P and B frames.
* **rc\_strategy** _integer_ **(**_encoding,video_**)**  
  .IX Item "rc_strategy integer (encoding,video)"
  Set ratecontrol method.
* **b\_strategy** _integer_ **(**_encoding,video_**)**  
  .IX Item "b_strategy integer (encoding,video)"
  Set strategy to choose between I/P/B-frames.
* **ps** _integer_ **(**_encoding,video_**)**  
  .IX Item "ps integer (encoding,video)"
  Set \s-1RTP\s0 payload size in bytes.
* **mv\_bits** _integer_  
  .IX Item "mv_bits integer"
* **header\_bits** _integer_  
  .IX Item "header_bits integer"
* **i\_tex\_bits** _integer_  
  .IX Item "i_tex_bits integer"
* **p\_tex\_bits** _integer_  
  .IX Item "p_tex_bits integer"
* **i\_count** _integer_  
  .IX Item "i_count integer"
* **p\_count** _integer_  
  .IX Item "p_count integer"
* **skip\_count** _integer_  
  .IX Item "skip_count integer"
* **misc\_bits** _integer_  
  .IX Item "misc_bits integer"
* **frame\_bits** _integer_  
  .IX Item "frame_bits integer"
* **codec\_tag** _integer_  
  .IX Item "codec_tag integer"
* **bug** _flags_ **(**_decoding,video_**)**  
  .IX Item "bug flags (decoding,video)"
  Workaround not auto detected encoder bugs.
  .Sp
  Possible values:
    * **autodetect**  
      .IX Item "autodetect"
    * **old\_msmpeg4**  
      .IX Item "old_msmpeg4"
      some old lavc generated msmpeg4v3 files (no autodetection)
    * **xvid\_ilace**  
      .IX Item "xvid_ilace"
      Xvid interlacing bug (autodetected if fourcc==XVIX)
    * **ump4**  
      .IX Item "ump4"
      (autodetected if fourcc==UMP4)
    * **no\_padding**  
      .IX Item "no_padding"
      padding bug (autodetected)
    * **amv**  
      .IX Item "amv"
    * **ac\_vlc**  
      .IX Item "ac_vlc"
      illegal vlc bug (autodetected per fourcc)
    * **qpel\_chroma**  
      .IX Item "qpel_chroma"
    * **std\_qpel**  
      .IX Item "std_qpel"
      old standard qpel (autodetected per fourcc/version)
    * **qpel\_chroma2**  
      .IX Item "qpel_chroma2"
    * **direct\_blocksize**  
      .IX Item "direct_blocksize"
      direct-qpel-blocksize bug (autodetected per fourcc/version)
    * **edge**  
      .IX Item "edge"
      edge padding bug (autodetected per fourcc/version)
    * **hpel\_chroma**  
      .IX Item "hpel_chroma"
    * **dc\_clip**  
      .IX Item "dc_clip"
    * **ms**  
      .IX Item "ms"
      Workaround various bugs in microsoft broken decoders.
    * **trunc**  
      .IX Item "trunc"
      trancated frames
* **lelim** _integer_ **(**_encoding,video_**)**  
  .IX Item "lelim integer (encoding,video)"
  Set single coefficient elimination threshold for luminance (negative
  values also consider \s-1DC\s0 coefficient).
* **celim** _integer_ **(**_encoding,video_**)**  
  .IX Item "celim integer (encoding,video)"
  Set single coefficient elimination threshold for chrominance (negative
  values also consider dc coefficient)
* **strict** _integer_ **(**_decoding/encoding,audio,video_**)**  
  .IX Item "strict integer (decoding/encoding,audio,video)"
  Specify how strictly to follow the standards.
  .Sp
  Possible values:
    * **very**  
      .IX Item "very"
      strictly conform to an older more strict version of the spec or reference software
    * **strict**  
      .IX Item "strict"
      strictly conform to all the things in the spec no matter what consequences
    * **normal**  
      .IX Item "normal"
    * **unofficial**  
      .IX Item "unofficial"
      allow unofficial extensions
    * **experimental**  
      .IX Item "experimental"
      allow non standardized experimental things, experimental
      (unfinished/work in progress/not well tested) decoders and encoders.
      Note: experimental decoders can pose a security risk, do not use this for
      decoding untrusted input.
* **b\_qoffset** _float_ **(**_encoding,video_**)**  
  .IX Item "b_qoffset float (encoding,video)"
  Set \s-1QP\s0 offset between P and B frames.
* **err\_detect** _flags_ **(**_decoding,audio,video_**)**  
  .IX Item "err_detect flags (decoding,audio,video)"
  Set error detection flags.
  .Sp
  Possible values:
    * **crccheck**  
      .IX Item "crccheck"
      verify embedded CRCs
    * **bitstream**  
      .IX Item "bitstream"
      detect bitstream specification deviations
    * **buffer**  
      .IX Item "buffer"
      detect improper bitstream length
    * **explode**  
      .IX Item "explode"
      abort decoding on minor error detection
    * **ignore\_err**  
      .IX Item "ignore_err"
      ignore decoding errors, and continue decoding.
      This is useful if you want to analyze the content of a video and thus want
      everything to be decoded no matter what. This option will not result in a video
      that is pleasing to watch in case of errors.
    * **careful**  
      .IX Item "careful"
      consider things that violate the spec and have not been seen in the wild as errors
    * **compliant**  
      .IX Item "compliant"
      consider all spec non compliancies as errors
    * **aggressive**  
      .IX Item "aggressive"
      consider things that a sane encoder should not do as an error
* **has\_b\_frames** _integer_  
  .IX Item "has_b_frames integer"
* **block\_align** _integer_  
  .IX Item "block_align integer"
* **mpeg\_quant** _integer_ **(**_encoding,video_**)**  
  .IX Item "mpeg_quant integer (encoding,video)"
  Use \s-1MPEG\s0 quantizers instead of H.263.
* **qsquish** _float_ **(**_encoding,video_**)**  
  .IX Item "qsquish float (encoding,video)"
  How to keep quantizer between qmin and qmax (0 = clip, 1 = use
  differentiable function).
* **rc\_qmod\_amp** _float_ **(**_encoding,video_**)**  
  .IX Item "rc_qmod_amp float (encoding,video)"
  Set experimental quantizer modulation.
* **rc\_qmod\_freq** _integer_ **(**_encoding,video_**)**  
  .IX Item "rc_qmod_freq integer (encoding,video)"
  Set experimental quantizer modulation.
* **rc\_override\_count** _integer_  
  .IX Item "rc_override_count integer"
* **rc\_eq** _string_ **(**_encoding,video_**)**  
  .IX Item "rc_eq string (encoding,video)"
  Set rate control equation. When computing the expression, besides the
  standard functions defined in the section 'Expression Evaluation', the
  following functions are available: bits2qp(bits), qp2bits(qp). Also
  the following constants are available: iTex pTex tex mv fCode iCount
  mcVar var isI isP isB avgQP qComp avgIITex avgPITex avgPPTex avgBPTex
  avgTex.
* **maxrate** _integer_ **(**_encoding,audio,video_**)**  
  .IX Item "maxrate integer (encoding,audio,video)"
  Set max bitrate tolerance (in bits/s). Requires bufsize to be set.
* **minrate** _integer_ **(**_encoding,audio,video_**)**  
  .IX Item "minrate integer (encoding,audio,video)"
  Set min bitrate tolerance (in bits/s). Most useful in setting up a \s-1CBR\s0
  encode. It is of little use elsewise.
* **bufsize** _integer_ **(**_encoding,audio,video_**)**  
  .IX Item "bufsize integer (encoding,audio,video)"
  Set ratecontrol buffer size (in bits).
* **rc\_buf\_aggressivity** _float_ **(**_encoding,video_**)**  
  .IX Item "rc_buf_aggressivity float (encoding,video)"
  Currently useless.
* **i\_qfactor** _float_ **(**_encoding,video_**)**  
  .IX Item "i_qfactor float (encoding,video)"
  Set \s-1QP\s0 factor between P and I frames.
* **i\_qoffset** _float_ **(**_encoding,video_**)**  
  .IX Item "i_qoffset float (encoding,video)"
  Set \s-1QP\s0 offset between P and I frames.
* **rc\_init\_cplx** _float_ **(**_encoding,video_**)**  
  .IX Item "rc_init_cplx float (encoding,video)"
  Set initial complexity for 1-pass encoding.
* **dct** _integer_ **(**_encoding,video_**)**  
  .IX Item "dct integer (encoding,video)"
  Set \s-1DCT\s0 algorithm.
  .Sp
  Possible values:
    * **auto**  
      .IX Item "auto"
      autoselect a good one (default)
    * **fastint**  
      .IX Item "fastint"
      fast integer
    * **int**  
      .IX Item "int"
      accurate integer
    * **mmx**  
      .IX Item "mmx"
    * **altivec**  
      .IX Item "altivec"
    * **faan**  
      .IX Item "faan"
      floating point \s-1AAN DCT\s0
* **lumi\_mask** _float_ **(**_encoding,video_**)**  
  .IX Item "lumi_mask float (encoding,video)"
  Compress bright areas stronger than medium ones.
* **tcplx\_mask** _float_ **(**_encoding,video_**)**  
  .IX Item "tcplx_mask float (encoding,video)"
  Set temporal complexity masking.
* **scplx\_mask** _float_ **(**_encoding,video_**)**  
  .IX Item "scplx_mask float (encoding,video)"
  Set spatial complexity masking.
* **p\_mask** _float_ **(**_encoding,video_**)**  
  .IX Item "p_mask float (encoding,video)"
  Set inter masking.
* **dark\_mask** _float_ **(**_encoding,video_**)**  
  .IX Item "dark_mask float (encoding,video)"
  Compress dark areas stronger than medium ones.
* **idct** _integer_ **(**_decoding/encoding,video_**)**  
  .IX Item "idct integer (decoding/encoding,video)"
  Select \s-1IDCT\s0 implementation.
  .Sp
  Possible values:
    * **auto**  
      .IX Item "auto"
    * **int**  
      .IX Item "int"
    * **simple**  
      .IX Item "simple"
    * **simplemmx**  
      .IX Item "simplemmx"
    * **simpleauto**  
      .IX Item "simpleauto"
      Automatically pick a \s-1IDCT\s0 compatible with the simple one
    * **arm**  
      .IX Item "arm"
    * **altivec**  
      .IX Item "altivec"
    * **sh4**  
      .IX Item "sh4"
    * **simplearm**  
      .IX Item "simplearm"
    * **simplearmv5te**  
      .IX Item "simplearmv5te"
    * **simplearmv6**  
      .IX Item "simplearmv6"
    * **simpleneon**  
      .IX Item "simpleneon"
    * **simplealpha**  
      .IX Item "simplealpha"
    * **ipp**  
      .IX Item "ipp"
    * **xvidmmx**  
      .IX Item "xvidmmx"
    * **faani**  
      .IX Item "faani"
      floating point \s-1AAN IDCT\s0
* **slice\_count** _integer_  
  .IX Item "slice_count integer"
* **ec** _flags_ **(**_decoding,video_**)**  
  .IX Item "ec flags (decoding,video)"
  Set error concealment strategy.
  .Sp
  Possible values:
    * **guess\_mvs**  
      .IX Item "guess_mvs"
      iterative motion vector (\s-1MV\s0) search (slow)
    * **deblock**  
      .IX Item "deblock"
      use strong deblock filter for damaged MBs
    * **favor\_inter**  
      .IX Item "favor_inter"
      favor predicting from the previous frame instead of the current
* **bits\_per\_coded\_sample** _integer_  
  .IX Item "bits_per_coded_sample integer"
* **pred** _integer_ **(**_encoding,video_**)**  
  .IX Item "pred integer (encoding,video)"
  Set prediction method.
  .Sp
  Possible values:
    * **left**  
      .IX Item "left"
    * **plane**  
      .IX Item "plane"
    * **median**  
      .IX Item "median"
* **aspect** _rational number_ **(**_encoding,video_**)**  
  .IX Item "aspect rational number (encoding,video)"
  Set sample aspect ratio.
* **sar** _rational number_ **(**_encoding,video_**)**  
  .IX Item "sar rational number (encoding,video)"
  Set sample aspect ratio. Alias to _aspect_.
* **debug** _flags_ **(**_decoding/encoding,audio,video,subtitles_**)**  
  .IX Item "debug flags (decoding/encoding,audio,video,subtitles)"
  Print specific debug info.
  .Sp
  Possible values:
    * **pict**  
      .IX Item "pict"
      picture info
    * **rc**  
      .IX Item "rc"
      rate control
    * **bitstream**  
      .IX Item "bitstream"
    * **mb\_type**  
      .IX Item "mb_type"
      macroblock (\s-1MB\s0) type
    * **qp**  
      .IX Item "qp"
      per-block quantization parameter (\s-1QP\s0)
    * **dct\_coeff**  
      .IX Item "dct_coeff"
    * **green\_metadata**  
      .IX Item "green_metadata"
      display complexity metadata for the upcoming frame, GoP or for a given duration.
    * **skip**  
      .IX Item "skip"
    * **startcode**  
      .IX Item "startcode"
    * **er**  
      .IX Item "er"
      error recognition
    * **mmco**  
      .IX Item "mmco"
      memory management control operations (H.264)
    * **bugs**  
      .IX Item "bugs"
    * **buffers**  
      .IX Item "buffers"
      picture buffer allocations
    * **thread\_ops**  
      .IX Item "thread_ops"
      threading operations
    * **nomc**  
      .IX Item "nomc"
      skip motion compensation
* **cmp** _integer_ **(**_encoding,video_**)**  
  .IX Item "cmp integer (encoding,video)"
  Set full pel me compare function.
  .Sp
  Possible values:
    * **sad**  
      .IX Item "sad"
      sum of absolute differences, fast (default)
    * **sse**  
      .IX Item "sse"
      sum of squared errors
    * **satd**  
      .IX Item "satd"
      sum of absolute Hadamard transformed differences
    * **dct**  
      .IX Item "dct"
      sum of absolute \s-1DCT\s0 transformed differences
    * **psnr**  
      .IX Item "psnr"
      sum of squared quantization errors (avoid, low quality)
    * **bit**  
      .IX Item "bit"
      number of bits needed for the block
    * **rd**  
      .IX Item "rd"
      rate distortion optimal, slow
    * **zero**  
      .IX Item "zero"
      0
    * **vsad**  
      .IX Item "vsad"
      sum of absolute vertical differences
    * **vsse**  
      .IX Item "vsse"
      sum of squared vertical differences
    * **nsse**  
      .IX Item "nsse"
      noise preserving sum of squared differences
    * **w53**  
      .IX Item "w53"
      5/3 wavelet, only used in snow
    * **w97**  
      .IX Item "w97"
      9/7 wavelet, only used in snow
    * **dctmax**  
      .IX Item "dctmax"
    * **chroma**  
      .IX Item "chroma"
* **subcmp** _integer_ **(**_encoding,video_**)**  
  .IX Item "subcmp integer (encoding,video)"
  Set sub pel me compare function.
  .Sp
  Possible values:
    * **sad**  
      .IX Item "sad"
      sum of absolute differences, fast (default)
    * **sse**  
      .IX Item "sse"
      sum of squared errors
    * **satd**  
      .IX Item "satd"
      sum of absolute Hadamard transformed differences
    * **dct**  
      .IX Item "dct"
      sum of absolute \s-1DCT\s0 transformed differences
    * **psnr**  
      .IX Item "psnr"
      sum of squared quantization errors (avoid, low quality)
    * **bit**  
      .IX Item "bit"
      number of bits needed for the block
    * **rd**  
      .IX Item "rd"
      rate distortion optimal, slow
    * **zero**  
      .IX Item "zero"
      0
    * **vsad**  
      .IX Item "vsad"
      sum of absolute vertical differences
    * **vsse**  
      .IX Item "vsse"
      sum of squared vertical differences
    * **nsse**  
      .IX Item "nsse"
      noise preserving sum of squared differences
    * **w53**  
      .IX Item "w53"
      5/3 wavelet, only used in snow
    * **w97**  
      .IX Item "w97"
      9/7 wavelet, only used in snow
    * **dctmax**  
      .IX Item "dctmax"
    * **chroma**  
      .IX Item "chroma"
* **mbcmp** _integer_ **(**_encoding,video_**)**  
  .IX Item "mbcmp integer (encoding,video)"
  Set macroblock compare function.
  .Sp
  Possible values:
    * **sad**  
      .IX Item "sad"
      sum of absolute differences, fast (default)
    * **sse**  
      .IX Item "sse"
      sum of squared errors
    * **satd**  
      .IX Item "satd"
      sum of absolute Hadamard transformed differences
    * **dct**  
      .IX Item "dct"
      sum of absolute \s-1DCT\s0 transformed differences
    * **psnr**  
      .IX Item "psnr"
      sum of squared quantization errors (avoid, low quality)
    * **bit**  
      .IX Item "bit"
      number of bits needed for the block
    * **rd**  
      .IX Item "rd"
      rate distortion optimal, slow
    * **zero**  
      .IX Item "zero"
      0
    * **vsad**  
      .IX Item "vsad"
      sum of absolute vertical differences
    * **vsse**  
      .IX Item "vsse"
      sum of squared vertical differences
    * **nsse**  
      .IX Item "nsse"
      noise preserving sum of squared differences
    * **w53**  
      .IX Item "w53"
      5/3 wavelet, only used in snow
    * **w97**  
      .IX Item "w97"
      9/7 wavelet, only used in snow
    * **dctmax**  
      .IX Item "dctmax"
    * **chroma**  
      .IX Item "chroma"
* **ildctcmp** _integer_ **(**_encoding,video_**)**  
  .IX Item "ildctcmp integer (encoding,video)"
  Set interlaced dct compare function.
  .Sp
  Possible values:
    * **sad**  
      .IX Item "sad"
      sum of absolute differences, fast (default)
    * **sse**  
      .IX Item "sse"
      sum of squared errors
    * **satd**  
      .IX Item "satd"
      sum of absolute Hadamard transformed differences
    * **dct**  
      .IX Item "dct"
      sum of absolute \s-1DCT\s0 transformed differences
    * **psnr**  
      .IX Item "psnr"
      sum of squared quantization errors (avoid, low quality)
    * **bit**  
      .IX Item "bit"
      number of bits needed for the block
    * **rd**  
      .IX Item "rd"
      rate distortion optimal, slow
    * **zero**  
      .IX Item "zero"
      0
    * **vsad**  
      .IX Item "vsad"
      sum of absolute vertical differences
    * **vsse**  
      .IX Item "vsse"
      sum of squared vertical differences
    * **nsse**  
      .IX Item "nsse"
      noise preserving sum of squared differences
    * **w53**  
      .IX Item "w53"
      5/3 wavelet, only used in snow
    * **w97**  
      .IX Item "w97"
      9/7 wavelet, only used in snow
    * **dctmax**  
      .IX Item "dctmax"
    * **chroma**  
      .IX Item "chroma"
* **dia\_size** _integer_ **(**_encoding,video_**)**  
  .IX Item "dia_size integer (encoding,video)"
  Set diamond type & size for motion estimation.
* **last\_pred** _integer_ **(**_encoding,video_**)**  
  .IX Item "last_pred integer (encoding,video)"
  Set amount of motion predictors from the previous frame.
* **preme** _integer_ **(**_encoding,video_**)**  
  .IX Item "preme integer (encoding,video)"
  Set pre motion estimation.
* **precmp** _integer_ **(**_encoding,video_**)**  
  .IX Item "precmp integer (encoding,video)"
  Set pre motion estimation compare function.
  .Sp
  Possible values:
    * **sad**  
      .IX Item "sad"
      sum of absolute differences, fast (default)
    * **sse**  
      .IX Item "sse"
      sum of squared errors
    * **satd**  
      .IX Item "satd"
      sum of absolute Hadamard transformed differences
    * **dct**  
      .IX Item "dct"
      sum of absolute \s-1DCT\s0 transformed differences
    * **psnr**  
      .IX Item "psnr"
      sum of squared quantization errors (avoid, low quality)
    * **bit**  
      .IX Item "bit"
      number of bits needed for the block
    * **rd**  
      .IX Item "rd"
      rate distortion optimal, slow
    * **zero**  
      .IX Item "zero"
      0
    * **vsad**  
      .IX Item "vsad"
      sum of absolute vertical differences
    * **vsse**  
      .IX Item "vsse"
      sum of squared vertical differences
    * **nsse**  
      .IX Item "nsse"
      noise preserving sum of squared differences
    * **w53**  
      .IX Item "w53"
      5/3 wavelet, only used in snow
    * **w97**  
      .IX Item "w97"
      9/7 wavelet, only used in snow
    * **dctmax**  
      .IX Item "dctmax"
    * **chroma**  
      .IX Item "chroma"
* **pre\_dia\_size** _integer_ **(**_encoding,video_**)**  
  .IX Item "pre_dia_size integer (encoding,video)"
  Set diamond type & size for motion estimation pre-pass.
* **subq** _integer_ **(**_encoding,video_**)**  
  .IX Item "subq integer (encoding,video)"
  Set sub pel motion estimation quality.
* **dtg\_active\_format** _integer_  
  .IX Item "dtg_active_format integer"
* **me\_range** _integer_ **(**_encoding,video_**)**  
  .IX Item "me_range integer (encoding,video)"
  Set limit motion vectors range (1023 for DivX player).
* **ibias** _integer_ **(**_encoding,video_**)**  
  .IX Item "ibias integer (encoding,video)"
  Set intra quant bias.
* **pbias** _integer_ **(**_encoding,video_**)**  
  .IX Item "pbias integer (encoding,video)"
  Set inter quant bias.
* **color\_table\_id** _integer_  
  .IX Item "color_table_id integer"
* **global\_quality** _integer_ **(**_encoding,audio,video_**)**  
  .IX Item "global_quality integer (encoding,audio,video)"
* **coder** _integer_ **(**_encoding,video_**)**  
  .IX Item "coder integer (encoding,video)"
  Possible values:
    * **vlc**  
      .IX Item "vlc"
      variable length coder / huffman coder
    * **ac**  
      .IX Item "ac"
      arithmetic coder
    * **raw**  
      .IX Item "raw"
      raw (no encoding)
    * **rle**  
      .IX Item "rle"
      run-length coder
    * **deflate**  
      .IX Item "deflate"
      deflate-based coder
* **context** _integer_ **(**_encoding,video_**)**  
  .IX Item "context integer (encoding,video)"
  Set context model.
* **slice\_flags** _integer_  
  .IX Item "slice_flags integer"
* **mbd** _integer_ **(**_encoding,video_**)**  
  .IX Item "mbd integer (encoding,video)"
  Set macroblock decision algorithm (high quality mode).
  .Sp
  Possible values:
    * **simple**  
      .IX Item "simple"
      use mbcmp (default)
    * **bits**  
      .IX Item "bits"
      use fewest bits
    * **rd**  
      .IX Item "rd"
      use best rate distortion
* **stream\_codec\_tag** _integer_  
  .IX Item "stream_codec_tag integer"
* **sc\_threshold** _integer_ **(**_encoding,video_**)**  
  .IX Item "sc_threshold integer (encoding,video)"
  Set scene change threshold.
* **lmin** _integer_ **(**_encoding,video_**)**  
  .IX Item "lmin integer (encoding,video)"
  Set min lagrange factor (\s-1VBR\s0).
* **lmax** _integer_ **(**_encoding,video_**)**  
  .IX Item "lmax integer (encoding,video)"
  Set max lagrange factor (\s-1VBR\s0).
* **nr** _integer_ **(**_encoding,video_**)**  
  .IX Item "nr integer (encoding,video)"
  Set noise reduction.
* **rc\_init\_occupancy** _integer_ **(**_encoding,video_**)**  
  .IX Item "rc_init_occupancy integer (encoding,video)"
  Set number of bits which should be loaded into the rc buffer before
  decoding starts.
* **flags2** _flags_ **(**_decoding/encoding,audio,video_**)**  
  .IX Item "flags2 flags (decoding/encoding,audio,video)"
  Possible values:
    * **fast**  
      .IX Item "fast"
      Allow non spec compliant speedup tricks.
    * **sgop**  
      .IX Item "sgop"
      Deprecated, use mpegvideo private options instead.
    * **noout**  
      .IX Item "noout"
      Skip bitstream encoding.
    * **ignorecrop**  
      .IX Item "ignorecrop"
      Ignore cropping information from sps.
    * **local\_header**  
      .IX Item "local_header"
      Place global headers at every keyframe instead of in extradata.
    * **chunks**  
      .IX Item "chunks"
      Frame data might be split into multiple chunks.
    * **showall**  
      .IX Item "showall"
      Show all frames before the first keyframe.
    * **skiprd**  
      .IX Item "skiprd"
      Deprecated, use mpegvideo private options instead.
    * **export\_mvs**  
      .IX Item "export_mvs"
      Export motion vectors into frame side-data (see \f(CW`AV\_FRAME\_DATA\_MOTION\_VECTORS\*(C')
      for codecs that support it. See also _doc/examples/export\_mvs.c_.
* **error** _integer_ **(**_encoding,video_**)**  
  .IX Item "error integer (encoding,video)"
* **qns** _integer_ **(**_encoding,video_**)**  
  .IX Item "qns integer (encoding,video)"
  Deprecated, use mpegvideo private options instead.
* **threads** _integer_ **(**_decoding/encoding,video_**)**  
  .IX Item "threads integer (decoding/encoding,video)"
  Set the number of threads to be used, in case the selected codec
  implementation supports multi-threading.
  .Sp
  Possible values:
    * **auto, 0**  
      .IX Item "auto, 0"
      automatically select the number of threads to set
      .Sp
      Default value is **auto**.
* **me\_threshold** _integer_ **(**_encoding,video_**)**  
  .IX Item "me_threshold integer (encoding,video)"
  Set motion estimation threshold.
* **mb\_threshold** _integer_ **(**_encoding,video_**)**  
  .IX Item "mb_threshold integer (encoding,video)"
  Set macroblock threshold.
* **dc** _integer_ **(**_encoding,video_**)**  
  .IX Item "dc integer (encoding,video)"
  Set intra_dc_precision.
* **nssew** _integer_ **(**_encoding,video_**)**  
  .IX Item "nssew integer (encoding,video)"
  Set nsse weight.
* **skip\_top** _integer_ **(**_decoding,video_**)**  
  .IX Item "skip_top integer (decoding,video)"
  Set number of macroblock rows at the top which are skipped.
* **skip\_bottom** _integer_ **(**_decoding,video_**)**  
  .IX Item "skip_bottom integer (decoding,video)"
  Set number of macroblock rows at the bottom which are skipped.
* **profile** _integer_ **(**_encoding,audio,video_**)**  
  .IX Item "profile integer (encoding,audio,video)"
  Possible values:
    * **unknown**  
      .IX Item "unknown"
    * **aac\_main**  
      .IX Item "aac_main"
    * **aac\_low**  
      .IX Item "aac_low"
    * **aac\_ssr**  
      .IX Item "aac_ssr"
    * **aac\_ltp**  
      .IX Item "aac_ltp"
    * **aac\_he**  
      .IX Item "aac_he"
    * **aac\_he\_v2**  
      .IX Item "aac_he_v2"
    * **aac\_ld**  
      .IX Item "aac_ld"
    * **aac\_eld**  
      .IX Item "aac_eld"
    * **mpeg2\_aac\_low**  
      .IX Item "mpeg2_aac_low"
    * **mpeg2\_aac\_he**  
      .IX Item "mpeg2_aac_he"
    * **mpeg4\_sp**  
      .IX Item "mpeg4_sp"
    * **mpeg4\_core**  
      .IX Item "mpeg4_core"
    * **mpeg4\_main**  
      .IX Item "mpeg4_main"
    * **mpeg4\_asp**  
      .IX Item "mpeg4_asp"
    * **dts**  
      .IX Item "dts"
    * **dts\_es**  
      .IX Item "dts_es"
    * **dts\_96\_24**  
      .IX Item "dts_96_24"
    * **dts\_hd\_hra**  
      .IX Item "dts_hd_hra"
    * **dts\_hd\_ma**  
      .IX Item "dts_hd_ma"
* **level** _integer_ **(**_encoding,audio,video_**)**  
  .IX Item "level integer (encoding,audio,video)"
  Possible values:
    * **unknown**  
      .IX Item "unknown"
* **lowres** _integer_ **(**_decoding,audio,video_**)**  
  .IX Item "lowres integer (decoding,audio,video)"
  Decode at 1= 1/2, 2=1/4, 3=1/8 resolutions.
* **skip\_threshold** _integer_ **(**_encoding,video_**)**  
  .IX Item "skip_threshold integer (encoding,video)"
  Set frame skip threshold.
* **skip\_factor** _integer_ **(**_encoding,video_**)**  
  .IX Item "skip_factor integer (encoding,video)"
  Set frame skip factor.
* **skip\_exp** _integer_ **(**_encoding,video_**)**  
  .IX Item "skip_exp integer (encoding,video)"
  Set frame skip exponent.
  Negative values behave identical to the corresponding positive ones, except
  that the score is normalized.
  Positive values exist primarily for compatibility reasons and are not so useful.
* **skipcmp** _integer_ **(**_encoding,video_**)**  
  .IX Item "skipcmp integer (encoding,video)"
  Set frame skip compare function.
  .Sp
  Possible values:
    * **sad**  
      .IX Item "sad"
      sum of absolute differences, fast (default)
    * **sse**  
      .IX Item "sse"
      sum of squared errors
    * **satd**  
      .IX Item "satd"
      sum of absolute Hadamard transformed differences
    * **dct**  
      .IX Item "dct"
      sum of absolute \s-1DCT\s0 transformed differences
    * **psnr**  
      .IX Item "psnr"
      sum of squared quantization errors (avoid, low quality)
    * **bit**  
      .IX Item "bit"
      number of bits needed for the block
    * **rd**  
      .IX Item "rd"
      rate distortion optimal, slow
    * **zero**  
      .IX Item "zero"
      0
    * **vsad**  
      .IX Item "vsad"
      sum of absolute vertical differences
    * **vsse**  
      .IX Item "vsse"
      sum of squared vertical differences
    * **nsse**  
      .IX Item "nsse"
      noise preserving sum of squared differences
    * **w53**  
      .IX Item "w53"
      5/3 wavelet, only used in snow
    * **w97**  
      .IX Item "w97"
      9/7 wavelet, only used in snow
    * **dctmax**  
      .IX Item "dctmax"
    * **chroma**  
      .IX Item "chroma"
* **border\_mask** _float_ **(**_encoding,video_**)**  
  .IX Item "border_mask float (encoding,video)"
  Increase the quantizer for macroblocks close to borders.
* **mblmin** _integer_ **(**_encoding,video_**)**  
  .IX Item "mblmin integer (encoding,video)"
  Set min macroblock lagrange factor (\s-1VBR\s0).
* **mblmax** _integer_ **(**_encoding,video_**)**  
  .IX Item "mblmax integer (encoding,video)"
  Set max macroblock lagrange factor (\s-1VBR\s0).
* **mepc** _integer_ **(**_encoding,video_**)**  
  .IX Item "mepc integer (encoding,video)"
  Set motion estimation bitrate penalty compensation (1.0 = 256).
* **skip\_loop\_filter** _integer_ **(**_decoding,video_**)**  
  .IX Item "skip_loop_filter integer (decoding,video)"
* **skip\_idct**        _integer_ **(**_decoding,video_**)**  
  .IX Item "skip_idct integer (decoding,video)"
* **skip\_frame**       _integer_ **(**_decoding,video_**)**  
  .IX Item "skip_frame integer (decoding,video)"
  Make decoder discard processing depending on the frame type selected
  by the option value.
  .Sp
  **skip\_loop\_filter** skips frame loop filtering, **skip\_idct**
  skips frame IDCT/dequantization, **skip\_frame** skips decoding.
  .Sp
  Possible values:
    * **none**  
      .IX Item "none"
      Discard no frame.
    * **default**  
      .IX Item "default"
      Discard useless frames like 0-sized frames.
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
      .Sp
      Default value is **default**.
* **bidir\_refine** _integer_ **(**_encoding,video_**)**  
  .IX Item "bidir_refine integer (encoding,video)"
  Refine the two motion vectors used in bidirectional macroblocks.
* **brd\_scale** _integer_ **(**_encoding,video_**)**  
  .IX Item "brd_scale integer (encoding,video)"
  Downscale frames for dynamic B-frame decision.
* **keyint\_min** _integer_ **(**_encoding,video_**)**  
  .IX Item "keyint_min integer (encoding,video)"
  Set minimum interval between IDR-frames.
* **refs** _integer_ **(**_encoding,video_**)**  
  .IX Item "refs integer (encoding,video)"
  Set reference frames to consider for motion compensation.
* **chromaoffset** _integer_ **(**_encoding,video_**)**  
  .IX Item "chromaoffset integer (encoding,video)"
  Set chroma qp offset from luma.
* **trellis** _integer_ **(**_encoding,audio,video_**)**  
  .IX Item "trellis integer (encoding,audio,video)"
  Set rate-distortion optimal quantization.
* **mv0\_threshold** _integer_ **(**_encoding,video_**)**  
  .IX Item "mv0_threshold integer (encoding,video)"
* **b\_sensitivity** _integer_ **(**_encoding,video_**)**  
  .IX Item "b_sensitivity integer (encoding,video)"
  Adjust sensitivity of b_frame_strategy 1.
* **compression\_level** _integer_ **(**_encoding,audio,video_**)**  
  .IX Item "compression_level integer (encoding,audio,video)"
* **min\_prediction\_order** _integer_ **(**_encoding,audio_**)**  
  .IX Item "min_prediction_order integer (encoding,audio)"
* **max\_prediction\_order** _integer_ **(**_encoding,audio_**)**  
  .IX Item "max_prediction_order integer (encoding,audio)"
* **timecode\_frame\_start** _integer_ **(**_encoding,video_**)**  
  .IX Item "timecode_frame_start integer (encoding,video)"
  Set \s-1GOP\s0 timecode frame start number, in non drop frame format.
* **request\_channels** _integer_ **(**_decoding,audio_**)**  
  .IX Item "request_channels integer (decoding,audio)"
  Set desired number of audio channels.
* **bits\_per\_raw\_sample** _integer_  
  .IX Item "bits_per_raw_sample integer"
* **channel\_layout** _integer_ **(**_decoding/encoding,audio_**)**  
  .IX Item "channel_layout integer (decoding/encoding,audio)"
  Possible values:
* **request\_channel\_layout** _integer_ **(**_decoding,audio_**)**  
  .IX Item "request_channel_layout integer (decoding,audio)"
  Possible values:
* **rc\_max\_vbv\_use** _float_ **(**_encoding,video_**)**  
  .IX Item "rc_max_vbv_use float (encoding,video)"
* **rc\_min\_vbv\_use** _float_ **(**_encoding,video_**)**  
  .IX Item "rc_min_vbv_use float (encoding,video)"
* **ticks\_per\_frame** _integer_ **(**_decoding/encoding,audio,video_**)**  
  .IX Item "ticks_per_frame integer (decoding/encoding,audio,video)"
* **color\_primaries** _integer_ **(**_decoding/encoding,video_**)**  
  .IX Item "color_primaries integer (decoding/encoding,video)"
  Possible values:
    * **bt709**  
      .IX Item "bt709"
      \s-1BT.709\s0
    * **bt470m**  
      .IX Item "bt470m"
      \s-1BT.470 M\s0
    * **bt470bg**  
      .IX Item "bt470bg"
      \s-1BT.470 BG\s0
    * **smpte170m**  
      .IX Item "smpte170m"
      \s-1SMPTE 170 M\s0
    * **smpte240m**  
      .IX Item "smpte240m"
      \s-1SMPTE 240 M\s0
    * **film**  
      .IX Item "film"
      Film
    * **bt2020**  
      .IX Item "bt2020"
      \s-1BT.2020\s0
    * **smpte428**  
      .IX Item "smpte428"
    * **smpte428\_1**  
      .IX Item "smpte428_1"
      \s-1SMPTE ST 428-1\s0
    * **smpte431**  
      .IX Item "smpte431"
      \s-1SMPTE 431-2\s0
    * **smpte432**  
      .IX Item "smpte432"
      \s-1SMPTE 432-1\s0
    * **jedec-p22**  
      .IX Item "jedec-p22"
      \s-1JEDEC P22\s0
* **color\_trc** _integer_ **(**_decoding/encoding,video_**)**  
  .IX Item "color_trc integer (decoding/encoding,video)"
  Possible values:
    * **bt709**  
      .IX Item "bt709"
      \s-1BT.709\s0
    * **gamma22**  
      .IX Item "gamma22"
      \s-1BT.470 M\s0
    * **gamma28**  
      .IX Item "gamma28"
      \s-1BT.470 BG\s0
    * **smpte170m**  
      .IX Item "smpte170m"
      \s-1SMPTE 170 M\s0
    * **smpte240m**  
      .IX Item "smpte240m"
      \s-1SMPTE 240 M\s0
    * **linear**  
      .IX Item "linear"
      Linear
    * **log**  
      .IX Item "log"
    * **log100**  
      .IX Item "log100"
      Log
    * **log\_sqrt**  
      .IX Item "log_sqrt"
    * **log316**  
      .IX Item "log316"
      Log square root
    * **iec61966\_2\_4**  
      .IX Item "iec61966_2_4"
    * **iec61966-2-4**  
      .IX Item "iec61966-2-4"
      \s-1IEC 61966-2-4\s0
    * **bt1361**  
      .IX Item "bt1361"
    * **bt1361e**  
      .IX Item "bt1361e"
      \s-1BT.1361\s0
    * **iec61966\_2\_1**  
      .IX Item "iec61966_2_1"
    * **iec61966-2-1**  
      .IX Item "iec61966-2-1"
      \s-1IEC 61966-2-1\s0
    * **bt2020\_10**  
      .IX Item "bt2020_10"
    * **bt2020\_10bit**  
      .IX Item "bt2020_10bit"
      \s-1BT.2020\s0 - 10 bit
    * **bt2020\_12**  
      .IX Item "bt2020_12"
    * **bt2020\_12bit**  
      .IX Item "bt2020_12bit"
      \s-1BT.2020\s0 - 12 bit
    * **smpte2084**  
      .IX Item "smpte2084"
      \s-1SMPTE ST 2084\s0
    * **smpte428**  
      .IX Item "smpte428"
    * **smpte428\_1**  
      .IX Item "smpte428_1"
      \s-1SMPTE ST 428-1\s0
    * **arib-std-b67**  
      .IX Item "arib-std-b67"
      \s-1ARIB STD-B67\s0
* **colorspace** _integer_ **(**_decoding/encoding,video_**)**  
  .IX Item "colorspace integer (decoding/encoding,video)"
  Possible values:
    * **rgb**  
      .IX Item "rgb"
      \s-1RGB\s0
    * **bt709**  
      .IX Item "bt709"
      \s-1BT.709\s0
    * **fcc**  
      .IX Item "fcc"
      \s-1FCC\s0
    * **bt470bg**  
      .IX Item "bt470bg"
      \s-1BT.470 BG\s0
    * **smpte170m**  
      .IX Item "smpte170m"
      \s-1SMPTE 170 M\s0
    * **smpte240m**  
      .IX Item "smpte240m"
      \s-1SMPTE 240 M\s0
    * **ycocg**  
      .IX Item "ycocg"
      \s-1YCOCG\s0
    * **bt2020nc**  
      .IX Item "bt2020nc"
    * **bt2020\_ncl**  
      .IX Item "bt2020_ncl"
      \s-1BT.2020 NCL\s0
    * **bt2020c**  
      .IX Item "bt2020c"
    * **bt2020\_cl**  
      .IX Item "bt2020_cl"
      \s-1BT.2020 CL\s0
    * **smpte2085**  
      .IX Item "smpte2085"
      \s-1SMPTE 2085\s0
* **color\_range** _integer_ **(**_decoding/encoding,video_**)**  
  .IX Item "color_range integer (decoding/encoding,video)"
  If used as input parameter, it serves as a hint to the decoder, which
  color_range the input has.
  Possible values:
    * **tv**  
      .IX Item "tv"
    * **mpeg**  
      .IX Item "mpeg"
      \s-1MPEG\s0 (219*2^(n-8))
    * **pc**  
      .IX Item "pc"
    * **jpeg**  
      .IX Item "jpeg"
      \s-1JPEG\s0 (2^n-1)
* **chroma\_sample\_location** _integer_ **(**_decoding/encoding,video_**)**  
  .IX Item "chroma_sample_location integer (decoding/encoding,video)"
  Possible values:
    * **left**  
      .IX Item "left"
    * **center**  
      .IX Item "center"
    * **topleft**  
      .IX Item "topleft"
    * **top**  
      .IX Item "top"
    * **bottomleft**  
      .IX Item "bottomleft"
    * **bottom**  
      .IX Item "bottom"
* **log\_level\_offset** _integer_  
  .IX Item "log_level_offset integer"
  Set the log level offset.
* **slices** _integer_ **(**_encoding,video_**)**  
  .IX Item "slices integer (encoding,video)"
  Number of slices, used in parallelized encoding.
* **thread\_type** _flags_ **(**_decoding/encoding,video_**)**  
  .IX Item "thread_type flags (decoding/encoding,video)"
  Select which multithreading methods to use.
  .Sp
  Use of **frame** will increase decoding delay by one frame per
  thread, so clients which cannot provide future frames should not use
  it.
  .Sp
  Possible values:
    * **slice**  
      .IX Item "slice"
      Decode more than one part of a single frame at once.
      .Sp
      Multithreading using slices works only when the video was encoded with
      slices.
    * **frame**  
      .IX Item "frame"
      Decode more than one frame at once.
      .Sp
      Default value is **slice+frame**.
* **audio\_service\_type** _integer_ **(**_encoding,audio_**)**  
  .IX Item "audio_service_type integer (encoding,audio)"
  Set audio service type.
  .Sp
  Possible values:
    * **ma**  
      .IX Item "ma"
      Main Audio Service
    * **ef**  
      .IX Item "ef"
      Effects
    * **vi**  
      .IX Item "vi"
      Visually Impaired
    * **hi**  
      .IX Item "hi"
      Hearing Impaired
    * **di**  
      .IX Item "di"
      Dialogue
    * **co**  
      .IX Item "co"
      Commentary
    * **em**  
      .IX Item "em"
      Emergency
    * **vo**  
      .IX Item "vo"
      Voice Over
    * **ka**  
      .IX Item "ka"
      Karaoke
* **request\_sample\_fmt** _sample\_fmt_ **(**_decoding,audio_**)**  
  .IX Item "request_sample_fmt sample_fmt (decoding,audio)"
  Set sample format audio decoders should prefer. Default value is
  \f(CW`none\*(C'.
* **pkt\_timebase** _rational number_  
  .IX Item "pkt_timebase rational number"
* **sub\_charenc** _encoding_ **(**_decoding,subtitles_**)**  
  .IX Item "sub_charenc encoding (decoding,subtitles)"
  Set the input subtitles character encoding.
* **field\_order**  _field\_order_ **(**_video_**)**  
  .IX Item "field_order field_order (video)"
  Set/override the field order of the video.
  Possible values:
    * **progressive**  
      .IX Item "progressive"
      Progressive video
    * **tt**  
      .IX Item "tt"
      Interlaced video, top field coded and displayed first
    * **bb**  
      .IX Item "bb"
      Interlaced video, bottom field coded and displayed first
    * **tb**  
      .IX Item "tb"
      Interlaced video, top coded first, bottom displayed first
    * **bt**  
      .IX Item "bt"
      Interlaced video, bottom coded first, top displayed first
* **skip\_alpha** _bool_ **(**_decoding,video_**)**  
  .IX Item "skip_alpha bool (decoding,video)"
  Set to 1 to disable processing alpha (transparency). This works like the
  **gray** flag in the **flags** option which skips chroma information
  instead of alpha. Default is 0.
* **codec\_whitelist** _list_ **(**_input_**)**  
  .IX Item "codec_whitelist list (input)"
  ,\*(R" separated list of allowed decoders. By default all are allowed.
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
* **max\_pixels** _integer_ **(**_decoding/encoding,video_**)**  
  .IX Item "max_pixels integer (decoding/encoding,video)"
  Maximum number of pixels per image. This value can be used to avoid out of
  memory failures due to large images.
* **apply\_cropping** _bool_ **(**_decoding,video_**)**  
  .IX Item "apply_cropping bool (decoding,video)"
  Enable cropping if cropping parameters are multiples of the required
  alignment for the left and top parameters. If the alignment is not met the
  cropping will be partially applied to maintain alignment.
  Default is 1 (enabled).
  Note: The required alignment depends on if \f(CW`AV\_CODEC\_FLAG\_UNALIGNED\*(C' is set and the
  \s-1CPU.\s0 \f(CW`AV\_CODEC\_FLAG\_UNALIGNED\*(C' cannot be changed from the command line. Also hardware
  decoders will not apply left/top Cropping.

<a name="decoders"></a>

# Decoders

.IX Header "DECODERS"
Decoders are configured elements in FFmpeg which allow the decoding of
multimedia streams.

When you configure your FFmpeg build, all the supported native decoders
are enabled by default. Decoders requiring an external library must be enabled
manually via the corresponding \f(CW`--enable-lib\*(C' option. You can list all
available decoders using the configure option \f(CW`--list-decoders\*(C'.

You can disable all the decoders with the configure option
\f(CW`--disable-decoders\*(C' and selectively enable / disable single decoders
with the options \f(CW`--enable-decoder=\f(CIDECODER\f(CW\*(C' /
\f(CW`--disable-decoder=\f(CIDECODER\f(CW\*(C'.

The option \f(CW`-decoders\*(C' of the ff* tools will display the list of
enabled decoders.

<a name="video-decoders"></a>

# Video Decoders

.IX Header "VIDEO DECODERS"
A description of some of the currently available video decoders
follows.

<a name="rawvideo"></a>

### rawvideo

.IX Subsection "rawvideo"
Raw video decoder.

This decoder decodes rawvideo streams.

_Options_
.IX Subsection "Options"

* **top** _top\_field\_first_  
  .IX Item "top top_field_first"
  Specify the assumed field type of the input video.
    * **-1**  
      .IX Item "-1"
      the video is assumed to be progressive (default)
    * **0**  
      .IX Item "0"
      bottom-field-first is assumed
    * **1**  
      .IX Item "1"
      top-field-first is assumed

<a name="libdavs2"></a>

### libdavs2

.IX Subsection "libdavs2"
\s-1AVS2-P2/IEEE1857.4\s0 video decoder wrapper.

This decoder allows libavcodec to decode \s-1AVS2\s0 streams with davs2 library.

<a name="audio-decoders"></a>

# Audio Decoders

.IX Header "AUDIO DECODERS"
A description of some of the currently available audio decoders
follows.

<a name="ac3"></a>

### ac3

.IX Subsection "ac3"
\s-1AC-3\s0 audio decoder.

This decoder implements part of \s-1ATSC A/52:2010\s0 and \s-1ETSI TS 102 366,\s0 as well as
the undocumented RealAudio 3 (a.k.a. dnet).

_\s-1AC-3\s0 Decoder Options_
.IX Subsection "AC-3 Decoder Options"

* **-drc\_scale** _value_  
  .IX Item "-drc_scale value"
  Dynamic Range Scale Factor. The factor to apply to dynamic range values
  from the \s-1AC-3\s0 stream. This factor is applied exponentially.
  There are 3 notable scale factor ranges:
    * **drc_scale == 0**  
      .IX Item "drc_scale == 0"
      \s-1DRC\s0 disabled. Produces full range audio.
    * **0 &lt; drc_scale &lt;= 1**  
      .IX Item "0 &lt; drc_scale &lt;= 1"
      \s-1DRC\s0 enabled.  Applies a fraction of the stream \s-1DRC\s0 value.
      Audio reproduction is between full range and full compression.
    * **drc_scale &gt; 1**  
      .IX Item "drc_scale &gt; 1"
      \s-1DRC\s0 enabled. Applies drc_scale asymmetrically.
      Loud sounds are fully compressed.  Soft sounds are enhanced.

<a name="flac"></a>

### flac

.IX Subsection "flac"
\s-1FLAC\s0 audio decoder.

This decoder aims to implement the complete \s-1FLAC\s0 specification from Xiph.

_\s-1FLAC\s0 Decoder options_
.IX Subsection "FLAC Decoder options"

* **-use\_buggy\_lpc**  
  .IX Item "-use_buggy_lpc"
  The lavc \s-1FLAC\s0 encoder used to produce buggy streams with high lpc values
  (like the default value). This option makes it possible to decode such streams
  correctly by using lavc's old buggy lpc logic for decoding.

<a name="ffwavesynth"></a>

### ffwavesynth

.IX Subsection "ffwavesynth"
Internal wave synthesizer.

This decoder generates wave patterns according to predefined sequences. Its
use is purely internal and the format of the data it accepts is not publicly
documented.

<a name="libcelt"></a>

### libcelt

.IX Subsection "libcelt"
libcelt decoder wrapper.

libcelt allows libavcodec to decode the Xiph \s-1CELT\s0 ultra-low delay audio codec.
Requires the presence of the libcelt headers and library during configuration.
You need to explicitly configure the build with \f(CW`--enable-libcelt\*(C'.

<a name="libgsm"></a>

### libgsm

.IX Subsection "libgsm"
libgsm decoder wrapper.

libgsm allows libavcodec to decode the \s-1GSM\s0 full rate audio codec. Requires
the presence of the libgsm headers and library during configuration. You need
to explicitly configure the build with \f(CW`--enable-libgsm\*(C'.

This decoder supports both the ordinary \s-1GSM\s0 and the Microsoft variant.

<a name="libilbc"></a>

### libilbc

.IX Subsection "libilbc"
libilbc decoder wrapper.

libilbc allows libavcodec to decode the Internet Low Bitrate Codec (iLBC)
audio codec. Requires the presence of the libilbc headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libilbc\*(C'.

_Options_
.IX Subsection "Options"

The following option is supported by the libilbc wrapper.

* **enhance**  
  .IX Item "enhance"
  Enable the enhancement of the decoded audio when set to 1. The default
  value is 0 (disabled).

<a name="libopencore-amrnb"></a>

### libopencore-amrnb

.IX Subsection "libopencore-amrnb"
libopencore-amrnb decoder wrapper.

libopencore-amrnb allows libavcodec to decode the Adaptive Multi-Rate
Narrowband audio codec. Using it requires the presence of the
libopencore-amrnb headers and library during configuration. You need to
explicitly configure the build with \f(CW`--enable-libopencore-amrnb\*(C'.

An FFmpeg native decoder for AMR-NB exists, so users can decode AMR-NB
without this library.

<a name="libopencore-amrwb"></a>

### libopencore-amrwb

.IX Subsection "libopencore-amrwb"
libopencore-amrwb decoder wrapper.

libopencore-amrwb allows libavcodec to decode the Adaptive Multi-Rate
Wideband audio codec. Using it requires the presence of the
libopencore-amrwb headers and library during configuration. You need to
explicitly configure the build with \f(CW`--enable-libopencore-amrwb\*(C'.

An FFmpeg native decoder for AMR-WB exists, so users can decode AMR-WB
without this library.

<a name="libopus"></a>

### libopus

.IX Subsection "libopus"
libopus decoder wrapper.

libopus allows libavcodec to decode the Opus Interactive Audio Codec.
Requires the presence of the libopus headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libopus\*(C'.

An FFmpeg native decoder for Opus exists, so users can decode Opus
without this library.

<a name="subtitles-decoders"></a>

# Subtitles Decoders

.IX Header "SUBTITLES DECODERS"

<a name="dvbsub"></a>

### dvbsub

.IX Subsection "dvbsub"
_Options_
.IX Subsection "Options"

* **compute\_clut**  
  .IX Item "compute_clut"
    * **-1**  
      .IX Item "-1"
      Compute clut if no matching \s-1CLUT\s0 is in the stream.
    * **0**  
      .IX Item "0"
      Never compute \s-1CLUT\s0
    * **1**  
      .IX Item "1"
      Always compute \s-1CLUT\s0 and override the one provided in the stream.
* **dvb\_substream**  
  .IX Item "dvb_substream"
  Selects the dvb substream, or all substreams if -1 which is default.

<a name="dvdsub"></a>

### dvdsub

.IX Subsection "dvdsub"
This codec decodes the bitmap subtitles used in DVDs; the same subtitles can
also be found in VobSub file pairs and in some Matroska files.

_Options_
.IX Subsection "Options"

* **palette**  
  .IX Item "palette"
  Specify the global palette used by the bitmaps. When stored in VobSub, the
  palette is normally specified in the index file; in Matroska, the palette is
  stored in the codec extra-data in the same format as in VobSub. In DVDs, the
  palette is stored in the \s-1IFO\s0 file, and therefore not available when reading
  from dumped \s-1VOB\s0 files.
  .Sp
  The format for this option is a string containing 16 24-bits hexadecimal
  numbers (without 0x prefix) separated by comas, for example \f(CW`0d00ee,
  ee450d, 101010, eaeaea, 0ce60b, ec14ed, ebff0b, 0d617a, 7b7b7b, d1d1d1,
  7b2a0e, 0d950c, 0f007b, cf0dec, cfa80c, 7c127b.
* **ifo\_palette**  
  .IX Item "ifo_palette"
  Specify the \s-1IFO\s0 file from which the global palette is obtained.
  (experimental)
* **forced\_subs\_only**  
  .IX Item "forced_subs_only"
  Only decode subtitle entries marked as forced. Some titles have forced
  and non-forced subtitles in the same track. Setting this flag to \f(CW1
  will only keep the forced subtitles. Default value is \f(CW0.

<a name="libzvbi-teletext"></a>

### libzvbi-teletext

.IX Subsection "libzvbi-teletext"
Libzvbi allows libavcodec to decode \s-1DVB\s0 teletext pages and \s-1DVB\s0 teletext
subtitles. Requires the presence of the libzvbi headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libzvbi\*(C'.

_Options_
.IX Subsection "Options"

* **txt\_page**  
  .IX Item "txt_page"
  List of teletext page numbers to decode. Pages that do not match the specified
  list are dropped. You may use the special \f(CW`*\*(C' string to match all pages,
  or \f(CW`subtitle\*(C' to match all subtitle pages.
  Default value is *.
* **txt\_chop\_top**  
  .IX Item "txt_chop_top"
  Discards the top teletext line. Default value is 1.
* **txt\_format**  
  .IX Item "txt_format"
  Specifies the format of the decoded subtitles.
    * **bitmap**  
      .IX Item "bitmap"
      The default format, you should use this for teletext pages, because certain
      graphics and colors cannot be expressed in simple text or even \s-1ASS.\s0
    * **text**  
      .IX Item "text"
      Simple text based output without formatting.
    * **ass**  
      .IX Item "ass"
      Formatted \s-1ASS\s0 output, subtitle pages and teletext pages are returned in
      different styles, subtitle pages are stripped down to text, but an effort is
      made to keep the text alignment and the formatting.
* **txt\_left**  
  .IX Item "txt_left"
  X offset of generated bitmaps, default is 0.
* **txt\_top**  
  .IX Item "txt_top"
  Y offset of generated bitmaps, default is 0.
* **txt\_chop\_spaces**  
  .IX Item "txt_chop_spaces"
  Chops leading and trailing spaces and removes empty lines from the generated
  text. This option is useful for teletext based subtitles where empty spaces may
  be present at the start or at the end of the lines or empty lines may be
  present between the subtitle lines because of double-sized teletext characters.
  Default value is 1.
* **txt\_duration**  
  .IX Item "txt_duration"
  Sets the display duration of the decoded teletext pages or subtitles in
  milliseconds. Default value is -1 which means infinity or until the next
  subtitle event comes.
* **txt\_transparent**  
  .IX Item "txt_transparent"
  Force transparent background of the generated teletext bitmaps. Default value
  is 0 which means an opaque background.
* **txt\_opacity**  
  .IX Item "txt_opacity"
  Sets the opacity (0-255) of the teletext background. If
  **txt\_transparent** is not set, it only affects characters between a start
  box and an end box, typically subtitles. Default value is 0 if
  **txt\_transparent** is set, 255 otherwise.

<a name="encoders"></a>

# Encoders

.IX Header "ENCODERS"
Encoders are configured elements in FFmpeg which allow the encoding of
multimedia streams.

When you configure your FFmpeg build, all the supported native encoders
are enabled by default. Encoders requiring an external library must be enabled
manually via the corresponding \f(CW`--enable-lib\*(C' option. You can list all
available encoders using the configure option \f(CW`--list-encoders\*(C'.

You can disable all the encoders with the configure option
\f(CW`--disable-encoders\*(C' and selectively enable / disable single encoders
with the options \f(CW`--enable-encoder=\f(CIENCODER\f(CW\*(C' /
\f(CW`--disable-encoder=\f(CIENCODER\f(CW\*(C'.

The option \f(CW`-encoders\*(C' of the ff* tools will display the list of
enabled encoders.

<a name="audio-encoders"></a>

# Audio Encoders

.IX Header "AUDIO ENCODERS"
A description of some of the currently available audio encoders
follows.

<a name="aac"></a>

### aac

.IX Subsection "aac"
Advanced Audio Coding (\s-1AAC\s0) encoder.

This encoder is the default \s-1AAC\s0 encoder, natively implemented into FFmpeg. Its
quality is on par or better than libfdk_aac at the default bitrate of 128kbps.
This encoder also implements more options, profiles and samplerates than
other encoders (with only the AAC-HE profile pending to be implemented) so this
encoder has become the default and is the recommended choice.

_Options_
.IX Subsection "Options"

* **b**  
  .IX Item "b"
  Set bit rate in bits/s. Setting this automatically activates constant bit rate
  (\s-1CBR\s0) mode. If this option is unspecified it is set to 128kbps.
* **q**  
  .IX Item "q"
  Set quality for variable bit rate (\s-1VBR\s0) mode. This option is valid only using
  the **ffmpeg** command-line tool. For library interface users, use
  **global\_quality**.
* **cutoff**  
  .IX Item "cutoff"
  Set cutoff frequency. If unspecified will allow the encoder to dynamically
  adjust the cutoff to improve clarity on low bitrates.
* **aac\_coder**  
  .IX Item "aac_coder"
  Set \s-1AAC\s0 encoder coding method. Possible values:
    * **twoloop**  
      .IX Item "twoloop"
      Two loop searching (\s-1TLS\s0) method.
      .Sp
      This method first sets quantizers depending on band thresholds and then tries
      to find an optimal combination by adding or subtracting a specific value from
      all quantizers and adjusting some individual quantizer a little.  Will tune
      itself based on whether **aac\_is**, **aac\_ms** and **aac\_pns**
      are enabled.
    * **anmr**  
      .IX Item "anmr"
      Average noise to mask ratio (\s-1ANMR\s0) trellis-based solution.
      .Sp
      This is an experimental coder which currently produces a lower quality, is more
      unstable and is slower than the default twoloop coder but has potential.
      Currently has no support for the **aac\_is** or **aac\_pns** options.
      Not currently recommended.
    * **fast**  
      .IX Item "fast"
      Constant quantizer method.
      .Sp
      Uses a cheaper version of twoloop algorithm that doesn't try to do as many
      clever adjustments. Worse with low bitrates (less than 64kbps), but is better
      and much faster at higher bitrates.
      This is the default choice for a coder
* **aac\_ms**  
  .IX Item "aac_ms"
  Sets mid/side coding mode. The default value of auto\*(R" will automatically use
  M/S with bands which will benefit from such coding. Can be forced for all bands
  using the value enable\*(R", which is mainly useful for debugging or disabled using
  disable\*(R".
* **aac\_is**  
  .IX Item "aac_is"
  Sets intensity stereo coding tool usage. By default, it's enabled and will
  automatically toggle \s-1IS\s0 for similar pairs of stereo bands if it's beneficial.
  Can be disabled for debugging by setting the value to disable\*(R".
* **aac\_pns**  
  .IX Item "aac_pns"
  Uses perceptual noise substitution to replace low entropy high frequency bands
  with imperceptible white noise during the decoding process. By default, it's
  enabled, but can be disabled for debugging purposes by using disable\*(R".
* **aac\_tns**  
  .IX Item "aac_tns"
  Enables the use of a multitap \s-1FIR\s0 filter which spans through the high frequency
  bands to hide quantization noise during the encoding process and is reverted
  by the decoder. As well as decreasing unpleasant artifacts in the high range
  this also reduces the entropy in the high bands and allows for more bits to
  be used by the mid-low bands. By default it's enabled but can be disabled for
  debugging by setting the option to disable\*(R".
* **aac\_ltp**  
  .IX Item "aac_ltp"
  Enables the use of the long term prediction extension which increases coding
  efficiency in very low bandwidth situations such as encoding of voice or
  solo piano music by extending constant harmonic peaks in bands throughout
  frames. This option is implied by profile:a aac_low and is incompatible with
  aac_pred. Use in conjunction with **-ar** to decrease the samplerate.
* **aac\_pred**  
  .IX Item "aac_pred"
  Enables the use of a more traditional style of prediction where the spectral
  coefficients transmitted are replaced by the difference of the current
  coefficients minus the previous predicted\*(R" coefficients. In theory and sometimes
  in practice this can improve quality for low to mid bitrate audio.
  This option implies the aac_main profile and is incompatible with aac_ltp.
* **profile**  
  .IX Item "profile"
  Sets the encoding profile, possible values:
    * **aac\_low**  
      .IX Item "aac_low"
      The default, \s-1AAC\s0 Low-complexity\*(R" profile. Is the most compatible and produces
      decent quality.
    * **mpeg2\_aac\_low**  
      .IX Item "mpeg2_aac_low"
      Equivalent to \f(CW`-profile:a aac_low -aac_pns 0\*(C'. \s-1PNS\s0 was introduced with the
      \s-1MPEG4\s0 specifications.
    * **aac\_ltp**  
      .IX Item "aac_ltp"
      Long term prediction profile, is enabled by and will enable the **aac\_ltp**
      option. Introduced in \s-1MPEG4.\s0
    * **aac\_main**  
      .IX Item "aac_main"
      Main-type prediction profile, is enabled by and will enable the **aac\_pred**
      option. Introduced in \s-1MPEG2.\s0
      .Sp
      If this option is unspecified it is set to **aac\_low**.

<a name="ac3-and-ac3_fixed"></a>

### ac3 and ac3_fixed

.IX Subsection "ac3 and ac3_fixed"
\s-1AC-3\s0 audio encoders.

These encoders implement part of \s-1ATSC A/52:2010\s0 and \s-1ETSI TS 102 366,\s0 as well as
the undocumented RealAudio 3 (a.k.a. dnet).

The _ac3_ encoder uses floating-point math, while the _ac3\_fixed_
encoder only uses fixed-point integer math. This does not mean that one is
always faster, just that one or the other may be better suited to a
particular system. The floating-point encoder will generally produce better
quality audio for a given bitrate. The _ac3\_fixed_ encoder is not the
default codec for any of the output formats, so it must be specified explicitly
using the option \f(CW`-acodec ac3\_fixed\*(C' in order to use it.

_\s-1AC-3\s0 Metadata_
.IX Subsection "AC-3 Metadata"

The \s-1AC-3\s0 metadata options are used to set parameters that describe the audio,
but in most cases do not affect the audio encoding itself. Some of the options
do directly affect or influence the decoding and playback of the resulting
bitstream, while others are just for informational purposes. A few of the
options will add bits to the output stream that could otherwise be used for
audio data, and will thus affect the quality of the output. Those will be
indicated accordingly with a note in the option list below.

These parameters are described in detail in several publicly-available
documents.

* *&lt;&lt;**http://www.atsc.org/cms/standards/a\_52-2010.pdf**&gt;&gt;  
  .IX Item "*&lt;&lt;http://www.atsc.org/cms/standards/a_52-2010.pdf&gt;&gt;"
* *&lt;&lt;**http://www.atsc.org/cms/standards/a\_54a\_with\_corr\_1.pdf**&gt;&gt;  
  .IX Item "*&lt;&lt;http://www.atsc.org/cms/standards/a_54a_with_corr_1.pdf&gt;&gt;"
* *&lt;&lt;**http://www.dolby.com/uploadedFiles/zz-\_Shared\_Assets/English\_PDFs/Professional/18\_Metadata.Guide.pdf**&gt;&gt;  
  .IX Item "*&lt;&lt;http://www.dolby.com/uploadedFiles/zz-_Shared_Assets/English_PDFs/Professional/18_Metadata.Guide.pdf&gt;&gt;"
* *&lt;&lt;**http://www.dolby.com/uploadedFiles/zz-\_Shared\_Assets/English\_PDFs/Professional/46\_DDEncodingGuidelines.pdf**&gt;&gt;  
  .IX Item "*&lt;&lt;http://www.dolby.com/uploadedFiles/zz-_Shared_Assets/English_PDFs/Professional/46_DDEncodingGuidelines.pdf&gt;&gt;"

Metadata Control Options
.IX Subsection "Metadata Control Options"

* **-per\_frame\_metadata** _boolean_  
  .IX Item "-per_frame_metadata boolean"
  Allow Per-Frame Metadata. Specifies if the encoder should check for changing
  metadata for each frame.
    * **0**  
      .IX Item "0"
      The metadata values set at initialization will be used for every frame in the
      stream. (default)
    * **1**  
      .IX Item "1"
      Metadata values can be changed before encoding each frame.

Downmix Levels
.IX Subsection "Downmix Levels"

* **-center\_mixlev** _level_  
  .IX Item "-center_mixlev level"
  Center Mix Level. The amount of gain the decoder should apply to the center
  channel when downmixing to stereo. This field will only be written to the
  bitstream if a center channel is present. The value is specified as a scale
  factor. There are 3 valid values:
    * **0.707**  
      .IX Item "0.707"
      Apply -3dB gain
    * **0.595**  
      .IX Item "0.595"
      Apply -4.5dB gain (default)
    * **0.500**  
      .IX Item "0.500"
      Apply -6dB gain
* **-surround\_mixlev** _level_  
  .IX Item "-surround_mixlev level"
  Surround Mix Level. The amount of gain the decoder should apply to the surround
  channel(s) when downmixing to stereo. This field will only be written to the
  bitstream if one or more surround channels are present. The value is specified
  as a scale factor.  There are 3 valid values:
    * **0.707**  
      .IX Item "0.707"
      Apply -3dB gain
    * **0.500**  
      .IX Item "0.500"
      Apply -6dB gain (default)
    * **0.000**  
      .IX Item "0.000"
      Silence Surround Channel(s)

Audio Production Information
.IX Subsection "Audio Production Information"

Audio Production Information is optional information describing the mixing
environment.  Either none or both of the fields are written to the bitstream.

* **-mixing\_level** _number_  
  .IX Item "-mixing_level number"
  Mixing Level. Specifies peak sound pressure level (\s-1SPL\s0) in the production
  environment when the mix was mastered. Valid values are 80 to 111, or -1 for
  unknown or not indicated. The default value is -1, but that value cannot be
  used if the Audio Production Information is written to the bitstream. Therefore,
  if the \f(CW`room\_type\*(C' option is not the default value, the \f(CW\*(C\`mixing\_level\*(C'
  option must not be -1.
* **-room\_type** _type_  
  .IX Item "-room_type type"
  Room Type. Describes the equalization used during the final mixing session at
  the studio or on the dubbing stage. A large room is a dubbing stage with the
  industry standard X-curve equalization; a small room has flat equalization.
  This field will not be written to the bitstream if both the \f(CW`mixing\_level\*(C'
  option and the \f(CW`room\_type\*(C' option have the default values.
    * **0**  
      .IX Item "0"
    * **notindicated**  
      .IX Item "notindicated"
      Not Indicated (default)
    * **1**  
      .IX Item "1"
    * **large**  
      .IX Item "large"
      Large Room
    * **2**  
      .IX Item "2"
    * **small**  
      .IX Item "small"
      Small Room

Other Metadata Options
.IX Subsection "Other Metadata Options"

* **-copyright** _boolean_  
  .IX Item "-copyright boolean"
  Copyright Indicator. Specifies whether a copyright exists for this audio.
    * **0**  
      .IX Item "0"
    * **off**  
      .IX Item "off"
      No Copyright Exists (default)
    * **1**  
      .IX Item "1"
    * **on**  
      .IX Item "on"
      Copyright Exists
* **-dialnorm** _value_  
  .IX Item "-dialnorm value"
  Dialogue Normalization. Indicates how far the average dialogue level of the
  program is below digital 100% full scale (0 dBFS). This parameter determines a
  level shift during audio reproduction that sets the average volume of the
  dialogue to a preset level. The goal is to match volume level between program
  sources. A value of -31dB will result in no volume level change, relative to
  the source volume, during audio reproduction. Valid values are whole numbers in
  the range -31 to -1, with -31 being the default.
* **-dsur\_mode** _mode_  
  .IX Item "-dsur_mode mode"
  Dolby Surround Mode. Specifies whether the stereo signal uses Dolby Surround
  (Pro Logic). This field will only be written to the bitstream if the audio
  stream is stereo. Using this option does **\s-1NOT\s0** mean the encoder will actually
  apply Dolby Surround processing.
    * **0**  
      .IX Item "0"
    * **notindicated**  
      .IX Item "notindicated"
      Not Indicated (default)
    * **1**  
      .IX Item "1"
    * **off**  
      .IX Item "off"
      Not Dolby Surround Encoded
    * **2**  
      .IX Item "2"
    * **on**  
      .IX Item "on"
      Dolby Surround Encoded
* **-original** _boolean_  
  .IX Item "-original boolean"
  Original Bit Stream Indicator. Specifies whether this audio is from the
  original source and not a copy.
    * **0**  
      .IX Item "0"
    * **off**  
      .IX Item "off"
      Not Original Source
    * **1**  
      .IX Item "1"
    * **on**  
      .IX Item "on"
      Original Source (default)

_Extended Bitstream Information_
.IX Subsection "Extended Bitstream Information"

The extended bitstream options are part of the Alternate Bit Stream Syntax as
specified in Annex D of the A/52:2010 standard. It is grouped into 2 parts.
If any one parameter in a group is specified, all values in that group will be
written to the bitstream.  Default values are used for those that are written
but have not been specified.  If the mixing levels are written, the decoder
will use these values instead of the ones specified in the \f(CW`center\_mixlev\*(C'
and \f(CW`surround\_mixlev\*(C' options if it supports the Alternate Bit Stream
Syntax.

Extended Bitstream Information - Part 1
.IX Subsection "Extended Bitstream Information - Part 1"

* **-dmix\_mode** _mode_  
  .IX Item "-dmix_mode mode"
  Preferred Stereo Downmix Mode. Allows the user to select either Lt/Rt
  (Dolby Surround) or Lo/Ro (normal stereo) as the preferred stereo downmix mode.
    * **0**  
      .IX Item "0"
    * **notindicated**  
      .IX Item "notindicated"
      Not Indicated (default)
    * **1**  
      .IX Item "1"
    * **ltrt**  
      .IX Item "ltrt"
      Lt/Rt Downmix Preferred
    * **2**  
      .IX Item "2"
    * **loro**  
      .IX Item "loro"
      Lo/Ro Downmix Preferred
* **-ltrt\_cmixlev** _level_  
  .IX Item "-ltrt_cmixlev level"
  Lt/Rt Center Mix Level. The amount of gain the decoder should apply to the
  center channel when downmixing to stereo in Lt/Rt mode.
    * **1.414**  
      .IX Item "1.414"
      Apply +3dB gain
    * **1.189**  
      .IX Item "1.189"
      Apply +1.5dB gain
    * **1.000**  
      .IX Item "1.000"
      Apply 0dB gain
    * **0.841**  
      .IX Item "0.841"
      Apply -1.5dB gain
    * **0.707**  
      .IX Item "0.707"
      Apply -3.0dB gain
    * **0.595**  
      .IX Item "0.595"
      Apply -4.5dB gain (default)
    * **0.500**  
      .IX Item "0.500"
      Apply -6.0dB gain
    * **0.000**  
      .IX Item "0.000"
      Silence Center Channel
* **-ltrt\_surmixlev** _level_  
  .IX Item "-ltrt_surmixlev level"
  Lt/Rt Surround Mix Level. The amount of gain the decoder should apply to the
  surround channel(s) when downmixing to stereo in Lt/Rt mode.
    * **0.841**  
      .IX Item "0.841"
      Apply -1.5dB gain
    * **0.707**  
      .IX Item "0.707"
      Apply -3.0dB gain
    * **0.595**  
      .IX Item "0.595"
      Apply -4.5dB gain
    * **0.500**  
      .IX Item "0.500"
      Apply -6.0dB gain (default)
    * **0.000**  
      .IX Item "0.000"
      Silence Surround Channel(s)
* **-loro\_cmixlev** _level_  
  .IX Item "-loro_cmixlev level"
  Lo/Ro Center Mix Level. The amount of gain the decoder should apply to the
  center channel when downmixing to stereo in Lo/Ro mode.
    * **1.414**  
      .IX Item "1.414"
      Apply +3dB gain
    * **1.189**  
      .IX Item "1.189"
      Apply +1.5dB gain
    * **1.000**  
      .IX Item "1.000"
      Apply 0dB gain
    * **0.841**  
      .IX Item "0.841"
      Apply -1.5dB gain
    * **0.707**  
      .IX Item "0.707"
      Apply -3.0dB gain
    * **0.595**  
      .IX Item "0.595"
      Apply -4.5dB gain (default)
    * **0.500**  
      .IX Item "0.500"
      Apply -6.0dB gain
    * **0.000**  
      .IX Item "0.000"
      Silence Center Channel
* **-loro\_surmixlev** _level_  
  .IX Item "-loro_surmixlev level"
  Lo/Ro Surround Mix Level. The amount of gain the decoder should apply to the
  surround channel(s) when downmixing to stereo in Lo/Ro mode.
    * **0.841**  
      .IX Item "0.841"
      Apply -1.5dB gain
    * **0.707**  
      .IX Item "0.707"
      Apply -3.0dB gain
    * **0.595**  
      .IX Item "0.595"
      Apply -4.5dB gain
    * **0.500**  
      .IX Item "0.500"
      Apply -6.0dB gain (default)
    * **0.000**  
      .IX Item "0.000"
      Silence Surround Channel(s)

Extended Bitstream Information - Part 2
.IX Subsection "Extended Bitstream Information - Part 2"

* **-dsurex\_mode** _mode_  
  .IX Item "-dsurex_mode mode"
  Dolby Surround \s-1EX\s0 Mode. Indicates whether the stream uses Dolby Surround \s-1EX\s0
  (7.1 matrixed to 5.1). Using this option does **\s-1NOT\s0** mean the encoder will actually
  apply Dolby Surround \s-1EX\s0 processing.
    * **0**  
      .IX Item "0"
    * **notindicated**  
      .IX Item "notindicated"
      Not Indicated (default)
    * **1**  
      .IX Item "1"
    * **on**  
      .IX Item "on"
      Dolby Surround \s-1EX\s0 Off
    * **2**  
      .IX Item "2"
    * **off**  
      .IX Item "off"
      Dolby Surround \s-1EX\s0 On
* **-dheadphone\_mode** _mode_  
  .IX Item "-dheadphone_mode mode"
  Dolby Headphone Mode. Indicates whether the stream uses Dolby Headphone
  encoding (multi-channel matrixed to 2.0 for use with headphones). Using this
  option does **\s-1NOT\s0** mean the encoder will actually apply Dolby Headphone
  processing.
    * **0**  
      .IX Item "0"
    * **notindicated**  
      .IX Item "notindicated"
      Not Indicated (default)
    * **1**  
      .IX Item "1"
    * **on**  
      .IX Item "on"
      Dolby Headphone Off
    * **2**  
      .IX Item "2"
    * **off**  
      .IX Item "off"
      Dolby Headphone On
* **-ad\_conv\_type** _type_  
  .IX Item "-ad_conv_type type"
  A/D Converter Type. Indicates whether the audio has passed through \s-1HDCD A/D\s0
  conversion.
    * **0**  
      .IX Item "0"
    * **standard**  
      .IX Item "standard"
      Standard A/D Converter (default)
    * **1**  
      .IX Item "1"
    * **hdcd**  
      .IX Item "hdcd"
      \s-1HDCD A/D\s0 Converter

_Other \s-1AC-3\s0 Encoding Options_
.IX Subsection "Other AC-3 Encoding Options"

* **-stereo\_rematrixing** _boolean_  
  .IX Item "-stereo_rematrixing boolean"
  Stereo Rematrixing. Enables/Disables use of rematrixing for stereo input. This
  is an optional \s-1AC-3\s0 feature that increases quality by selectively encoding
  the left/right channels as mid/side. This option is enabled by default, and it
  is highly recommended that it be left as enabled except for testing purposes.
* **cutoff** _frequency_  
  .IX Item "cutoff frequency"
  Set lowpass cutoff frequency. If unspecified, the encoder selects a default
  determined by various other encoding parameters.

_Floating-Point-Only \s-1AC-3\s0 Encoding Options_
.IX Subsection "Floating-Point-Only AC-3 Encoding Options"

These options are only valid for the floating-point encoder and do not exist
for the fixed-point encoder due to the corresponding features not being
implemented in fixed-point.

* **-channel\_coupling** _boolean_  
  .IX Item "-channel_coupling boolean"
  Enables/Disables use of channel coupling, which is an optional \s-1AC-3\s0 feature
  that increases quality by combining high frequency information from multiple
  channels into a single channel. The per-channel high frequency information is
  sent with less accuracy in both the frequency and time domains. This allows
  more bits to be used for lower frequencies while preserving enough information
  to reconstruct the high frequencies. This option is enabled by default for the
  floating-point encoder and should generally be left as enabled except for
  testing purposes or to increase encoding speed.
    * **-1**  
      .IX Item "-1"
    * **auto**  
      .IX Item "auto"
      Selected by Encoder (default)
    * **0**  
      .IX Item "0"
    * **off**  
      .IX Item "off"
      Disable Channel Coupling
    * **1**  
      .IX Item "1"
    * **on**  
      .IX Item "on"
      Enable Channel Coupling
* **-cpl\_start\_band** _number_  
  .IX Item "-cpl_start_band number"
  Coupling Start Band. Sets the channel coupling start band, from 1 to 15. If a
  value higher than the bandwidth is used, it will be reduced to 1 less than the
  coupling end band. If _auto_ is used, the start band will be determined by
  the encoder based on the bit rate, sample rate, and channel layout. This option
  has no effect if channel coupling is disabled.
    * **-1**  
      .IX Item "-1"
    * **auto**  
      .IX Item "auto"
      Selected by Encoder (default)

<a name="flac"></a>

### flac

.IX Subsection "flac"
\s-1FLAC\s0 (Free Lossless Audio Codec) Encoder

_Options_
.IX Subsection "Options"

The following options are supported by FFmpeg's flac encoder.

* **compression\_level**  
  .IX Item "compression_level"
  Sets the compression level, which chooses defaults for many other options
  if they are not set explicitly. Valid values are from 0 to 12, 5 is the
  default.
* **frame\_size**  
  .IX Item "frame_size"
  Sets the size of the frames in samples per channel.
* **lpc\_coeff\_precision**  
  .IX Item "lpc_coeff_precision"
  Sets the \s-1LPC\s0 coefficient precision, valid values are from 1 to 15, 15 is the
  default.
* **lpc\_type**  
  .IX Item "lpc_type"
  Sets the first stage \s-1LPC\s0 algorithm
    * **none**  
      .IX Item "none"
      \s-1LPC\s0 is not used
    * **fixed**  
      .IX Item "fixed"
      fixed \s-1LPC\s0 coefficients
    * **levinson**  
      .IX Item "levinson"
    * **cholesky**  
      .IX Item "cholesky"
* **lpc\_passes**  
  .IX Item "lpc_passes"
  Number of passes to use for Cholesky factorization during \s-1LPC\s0 analysis
* **min\_partition\_order**  
  .IX Item "min_partition_order"
  The minimum partition order
* **max\_partition\_order**  
  .IX Item "max_partition_order"
  The maximum partition order
* **prediction\_order\_method**  
  .IX Item "prediction_order_method"
    * **estimation**  
      .IX Item "estimation"
    * **2level**  
      .IX Item "2level"
    * **4level**  
      .IX Item "4level"
    * **8level**  
      .IX Item "8level"
    * **search**  
      .IX Item "search"
      Bruteforce search
    * **log**  
      .IX Item "log"
* **ch\_mode**  
  .IX Item "ch_mode"
  Channel mode
    * **auto**  
      .IX Item "auto"
      The mode is chosen automatically for each frame
    * **indep**  
      .IX Item "indep"
      Channels are independently coded
    * **left\_side**  
      .IX Item "left_side"
    * **right\_side**  
      .IX Item "right_side"
    * **mid\_side**  
      .IX Item "mid_side"
* **exact\_rice\_parameters**  
  .IX Item "exact_rice_parameters"
  Chooses if rice parameters are calculated exactly or approximately.
  if set to 1 then they are chosen exactly, which slows the code down slightly and
  improves compression slightly.
* **multi\_dim\_quant**  
  .IX Item "multi_dim_quant"
  Multi Dimensional Quantization. If set to 1 then a 2nd stage \s-1LPC\s0 algorithm is
  applied after the first stage to finetune the coefficients. This is quite slow
  and slightly improves compression.

<a name="opus"></a>

### opus

.IX Subsection "opus"
Opus encoder.

This is a native FFmpeg encoder for the Opus format. Currently its in development and
only implements the \s-1CELT\s0 part of the codec. Its quality is usually worse and at best
is equal to the libopus encoder.

_Options_
.IX Subsection "Options"

* **b**  
  .IX Item "b"
  Set bit rate in bits/s. If unspecified it uses the number of channels and the layout
  to make a good guess.
* **opus\_delay**  
  .IX Item "opus_delay"
  Sets the maximum delay in milliseconds. Lower delays than 20ms will very quickly
  decrease quality.

<a name="libfdk_aac"></a>

### libfdk_aac

.IX Subsection "libfdk_aac"
libfdk-aac \s-1AAC\s0 (Advanced Audio Coding) encoder wrapper.

The libfdk-aac library is based on the Fraunhofer \s-1FDK AAC\s0 code from
the Android project.

Requires the presence of the libfdk-aac headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libfdk-aac\*(C'. The library is also incompatible with \s-1GPL,\s0
so if you allow the use of \s-1GPL,\s0 you should configure with
\f(CW`--enable-gpl --enable-nonfree --enable-libfdk-aac\*(C'.

This encoder is considered to produce output on par or worse at 128kbps to the
**the native FFmpeg \s-1AAC\s0 encoder** but can often produce better
sounding audio at identical or lower bitrates and has support for the
AAC-HE profiles.

\s-1VBR\s0 encoding, enabled through the **vbr** or flags
+qscale options, is experimental and only works with some
combinations of parameters.

Support for encoding 7.1 audio is only available with libfdk-aac 0.1.3 or
higher.

For more information see the fdk-aac project at
&lt;**http://sourceforge.net/p/opencore-amr/fdk-aac/**&gt;.

_Options_
.IX Subsection "Options"

The following options are mapped on the shared FFmpeg codec options.

* **b**  
  .IX Item "b"
  Set bit rate in bits/s. If the bitrate is not explicitly specified, it
  is automatically set to a suitable value depending on the selected
  profile.
  .Sp
  In case \s-1VBR\s0 mode is enabled the option is ignored.
* **ar**  
  .IX Item "ar"
  Set audio sampling rate (in Hz).
* **channels**  
  .IX Item "channels"
  Set the number of audio channels.
* **flags +qscale**  
  .IX Item "flags +qscale"
  Enable fixed quality, \s-1VBR\s0 (Variable Bit Rate) mode.
  Note that \s-1VBR\s0 is implicitly enabled when the **vbr** value is
  positive.
* **cutoff**  
  .IX Item "cutoff"
  Set cutoff frequency. If not specified (or explicitly set to 0) it
  will use a value automatically computed by the library. Default value
  is 0.
* **profile**  
  .IX Item "profile"
  Set audio profile.
  .Sp
  The following profiles are recognized:
    * **aac\_low**  
      .IX Item "aac_low"
      Low Complexity \s-1AAC\s0 (\s-1LC\s0)
    * **aac\_he**  
      .IX Item "aac_he"
      High Efficiency \s-1AAC\s0 (HE-AAC)
    * **aac\_he\_v2**  
      .IX Item "aac_he_v2"
      High Efficiency \s-1AAC\s0 version 2 (HE-AACv2)
    * **aac\_ld**  
      .IX Item "aac_ld"
      Low Delay \s-1AAC\s0 (\s-1LD\s0)
    * **aac\_eld**  
      .IX Item "aac_eld"
      Enhanced Low Delay \s-1AAC\s0 (\s-1ELD\s0)
      .Sp
      If not specified it is set to **aac\_low**.

The following are private options of the libfdk_aac encoder.

* **afterburner**  
  .IX Item "afterburner"
  Enable afterburner feature if set to 1, disabled if set to 0. This
  improves the quality but also the required processing power.
  .Sp
  Default value is 1.
* **eld\_sbr**  
  .IX Item "eld_sbr"
  Enable \s-1SBR\s0 (Spectral Band Replication) for \s-1ELD\s0 if set to 1, disabled
  if set to 0.
  .Sp
  Default value is 0.
* **signaling**  
  .IX Item "signaling"
  Set \s-1SBR/PS\s0 signaling style.
  .Sp
  It can assume one of the following values:
    * **default**  
      .IX Item "default"
      choose signaling implicitly (explicit hierarchical by default,
      implicit if global header is disabled)
    * **implicit**  
      .IX Item "implicit"
      implicit backwards compatible signaling
    * **explicit\_sbr**  
      .IX Item "explicit_sbr"
      explicit \s-1SBR,\s0 implicit \s-1PS\s0 signaling
    * **explicit\_hierarchical**  
      .IX Item "explicit_hierarchical"
      explicit hierarchical signaling
      .Sp
      Default value is **default**.
* **latm**  
  .IX Item "latm"
  Output \s-1LATM/LOAS\s0 encapsulated data if set to 1, disabled if set to 0.
  .Sp
  Default value is 0.
* **header\_period**  
  .IX Item "header_period"
  Set StreamMuxConfig and \s-1PCE\s0 repetition period (in frames) for sending
  in-band configuration buffers within \s-1LATM/LOAS\s0 transport layer.
  .Sp
  Must be a 16-bits non-negative integer.
  .Sp
  Default value is 0.
* **vbr**  
  .IX Item "vbr"
  Set \s-1VBR\s0 mode, from 1 to 5. 1 is lowest quality (though still pretty
  good) and 5 is highest quality. A value of 0 will disable \s-1VBR,\s0 and \s-1CBR\s0
  (Constant Bit Rate) is enabled.
  .Sp
  Currently only the **aac\_low** profile supports \s-1VBR\s0 encoding.
  .Sp
  \s-1VBR\s0 modes 1-5 correspond to roughly the following average bit rates:
    * **1**  
      .IX Item "1"
      32 kbps/channel
    * **2**  
      .IX Item "2"
      40 kbps/channel
    * **3**  
      .IX Item "3"
      48-56 kbps/channel
    * **4**  
      .IX Item "4"
      64 kbps/channel
    * **5**  
      .IX Item "5"
      about 80-96 kbps/channel
      .Sp
      Default value is 0.

_Examples_
.IX Subsection "Examples"

* ·  
  Use **ffmpeg** to convert an audio file to \s-1VBR AAC\s0 in an M4A (\s-1MP4\s0)
  container:
  .Sp
  .Vb 1
          ffmpeg -i input.wav -codec:a libfdk_aac -vbr 3 output.m4a
  .Ve
* ·  
  Use **ffmpeg** to convert an audio file to \s-1CBR\s0 64k kbps \s-1AAC,\s0 using the
  High-Efficiency \s-1AAC\s0 profile:
  .Sp
  .Vb 1
          ffmpeg -i input.wav -c:a libfdk_aac -profile:a aac_he -b:a 64k output.m4a
  .Ve

<a name="libmp3lame"></a>

### libmp3lame

.IX Subsection "libmp3lame"
\s-1LAME\s0 (Lame Ain't an \s-1MP3\s0 Encoder) \s-1MP3\s0 encoder wrapper.

Requires the presence of the libmp3lame headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libmp3lame\*(C'.

See **libshine** for a fixed-point \s-1MP3\s0 encoder, although with a
lower quality.

_Options_
.IX Subsection "Options"

The following options are supported by the libmp3lame wrapper. The
**lame**-equivalent of the options are listed in parentheses.

* **b (**_-b_**)**  
  .IX Item "b (-b)"
  Set bitrate expressed in bits/s for \s-1CBR\s0 or \s-1ABR. LAME\s0 \f(CW`bitrate\*(C' is
  expressed in kilobits/s.
* **q (**_-V_**)**  
  .IX Item "q (-V)"
  Set constant quality setting for \s-1VBR.\s0 This option is valid only
  using the **ffmpeg** command-line tool. For library interface
  users, use **global\_quality**.
* **compression_level (**_-q_**)**  
  .IX Item "compression_level (-q)"
  Set algorithm quality. Valid arguments are integers in the 0-9 range,
  with 0 meaning highest quality but slowest, and 9 meaning fastest
  while producing the worst quality.
* **cutoff (**_--lowpass_**)**  
  .IX Item "cutoff (--lowpass)"
  Set lowpass cutoff frequency. If unspecified, the encoder dynamically
  adjusts the cutoff.
* **reservoir**  
  .IX Item "reservoir"
  Enable use of bit reservoir when set to 1. Default value is 1. \s-1LAME\s0
  has this enabled by default, but can be overridden by use
  **--nores** option.
* **joint_stereo (**_-m j_**)**  
  .IX Item "joint_stereo (-m j)"
  Enable the encoder to use (on a frame by frame basis) either L/R
  stereo or mid/side stereo. Default value is 1.
* **abr (**_--abr_**)**  
  .IX Item "abr (--abr)"
  Enable the encoder to use \s-1ABR\s0 when set to 1. The **lame**
  **--abr** sets the target bitrate, while this options only
  tells FFmpeg to use \s-1ABR\s0 still relies on **b** to set bitrate.

<a name="libopencore-amrnb"></a>

### libopencore-amrnb

.IX Subsection "libopencore-amrnb"
OpenCORE Adaptive Multi-Rate Narrowband encoder.

Requires the presence of the libopencore-amrnb headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libopencore-amrnb --enable-version3\*(C'.

This is a mono-only encoder. Officially it only supports 8000Hz sample rate,
but you can override it by setting **strict** to **unofficial** or
lower.

_Options_
.IX Subsection "Options"

* **b**  
  .IX Item "b"
  Set bitrate in bits per second. Only the following bitrates are supported,
  otherwise libavcodec will round to the nearest valid bitrate.
    * **4750**  
      .IX Item "4750"
    * **5150**  
      .IX Item "5150"
    * **5900**  
      .IX Item "5900"
    * **6700**  
      .IX Item "6700"
    * **7400**  
      .IX Item "7400"
    * **7950**  
      .IX Item "7950"
    * **10200**  
      .IX Item "10200"
    * **12200**  
      .IX Item "12200"
* **dtx**  
  .IX Item "dtx"
  Allow discontinuous transmission (generate comfort noise) when set to 1. The
  default value is 0 (disabled).

<a name="libopus"></a>

### libopus

.IX Subsection "libopus"
libopus Opus Interactive Audio Codec encoder wrapper.

Requires the presence of the libopus headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libopus\*(C'.

_Option Mapping_
.IX Subsection "Option Mapping"

Most libopus options are modelled after the **opusenc** utility from
opus-tools. The following is an option mapping chart describing options
supported by the libopus wrapper, and their **opusenc**-equivalent
in parentheses.

* **b (**_bitrate_**)**  
  .IX Item "b (bitrate)"
  Set the bit rate in bits/s.  FFmpeg's **b** option is
  expressed in bits/s, while **opusenc**'s **bitrate** in
  kilobits/s.
* **vbr (**_vbr_**,** _hard-cbr_**, and** _cvbr_**)**  
  .IX Item "vbr (vbr, hard-cbr, and cvbr)"
  Set \s-1VBR\s0 mode. The FFmpeg **vbr** option has the following
  valid arguments, with the **opusenc** equivalent options
  in parentheses:
    * **off (**_hard-cbr_**)**  
      .IX Item "off (hard-cbr)"
      Use constant bit rate encoding.
    * **on (**_vbr_**)**  
      .IX Item "on (vbr)"
      Use variable bit rate encoding (the default).
    * **constrained (**_cvbr_**)**  
      .IX Item "constrained (cvbr)"
      Use constrained variable bit rate encoding.
* **compression_level (**_comp_**)**  
  .IX Item "compression_level (comp)"
  Set encoding algorithm complexity. Valid options are integers in
  the 0-10 range. 0 gives the fastest encodes but lower quality, while 10
  gives the highest quality but slowest encoding. The default is 10.
* **frame_duration (**_framesize_**)**  
  .IX Item "frame_duration (framesize)"
  Set maximum frame size, or duration of a frame in milliseconds. The
  argument must be exactly the following: 2.5, 5, 10, 20, 40, 60. Smaller
  frame sizes achieve lower latency but less quality at a given bitrate.
  Sizes greater than 20ms are only interesting at fairly low bitrates.
  The default is 20ms.
* **packet_loss (**_expect-loss_**)**  
  .IX Item "packet_loss (expect-loss)"
  Set expected packet loss percentage. The default is 0.
* **application (N.A.)**  
  .IX Item "application (N.A.)"
  Set intended application type. Valid options are listed below:
    * **voip**  
      .IX Item "voip"
      Favor improved speech intelligibility.
    * **audio**  
      .IX Item "audio"
      Favor faithfulness to the input (the default).
    * **lowdelay**  
      .IX Item "lowdelay"
      Restrict to only the lowest delay modes.
* **cutoff (N.A.)**  
  .IX Item "cutoff (N.A.)"
  Set cutoff bandwidth in Hz. The argument must be exactly one of the
  following: 4000, 6000, 8000, 12000, or 20000, corresponding to
  narrowband, mediumband, wideband, super wideband, and fullband
  respectively. The default is 0 (cutoff disabled).
* **mapping_family (**_mapping\_family_**)**  
  .IX Item "mapping_family (mapping_family)"
  Set channel mapping family to be used by the encoder. The default value of -1
  uses mapping family 0 for mono and stereo inputs, and mapping family 1
  otherwise. The default also disables the surround masking and \s-1LFE\s0 bandwidth
  optimzations in libopus, and requires that the input contains 8 channels or
  fewer.
  .Sp
  Other values include 0 for mono and stereo, 1 for surround sound with masking
  and \s-1LFE\s0 bandwidth optimizations, and 255 for independent streams with an
  unspecified channel layout.
* **apply_phase_inv (N.A.) (requires libopus &gt;= 1.2)**  
  .IX Item "apply_phase_inv (N.A.) (requires libopus &gt;= 1.2)"
  If set to 0, disables the use of phase inversion for intensity stereo,
  improving the quality of mono downmixes, but slightly reducing normal stereo
  quality. The default is 1 (phase inversion enabled).

<a name="libshine"></a>

### libshine

.IX Subsection "libshine"
Shine Fixed-Point \s-1MP3\s0 encoder wrapper.

Shine is a fixed-point \s-1MP3\s0 encoder. It has a far better performance on
platforms without an \s-1FPU,\s0 e.g. armel CPUs, and some phones and tablets.
However, as it is more targeted on performance than quality, it is not on par
with \s-1LAME\s0 and other production-grade encoders quality-wise. Also, according to
the project's homepage, this encoder may not be free of bugs as the code was
written a long time ago and the project was dead for at least 5 years.

This encoder only supports stereo and mono input. This is also CBR-only.

The original project (last updated in early 2007) is at
&lt;**http://sourceforge.net/projects/libshine-fxp/**&gt;. We only support the
updated fork by the Savonet/Liquidsoap project at &lt;**https://github.com/savonet/shine**&gt;.

Requires the presence of the libshine headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libshine\*(C'.

See also **libmp3lame**.

_Options_
.IX Subsection "Options"

The following options are supported by the libshine wrapper. The
**shineenc**-equivalent of the options are listed in parentheses.

* **b (**_-b_**)**  
  .IX Item "b (-b)"
  Set bitrate expressed in bits/s for \s-1CBR.\s0 **shineenc** **-b** option
  is expressed in kilobits/s.

<a name="libtwolame"></a>

### libtwolame

.IX Subsection "libtwolame"
TwoLAME \s-1MP2\s0 encoder wrapper.

Requires the presence of the libtwolame headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libtwolame\*(C'.

_Options_
.IX Subsection "Options"

The following options are supported by the libtwolame wrapper. The
**twolame**-equivalent options follow the FFmpeg ones and are in
parentheses.

* **b (**_-b_**)**  
  .IX Item "b (-b)"
  Set bitrate expressed in bits/s for \s-1CBR.\s0 **twolame** **b**
  option is expressed in kilobits/s. Default value is 128k.
* **q (**_-V_**)**  
  .IX Item "q (-V)"
  Set quality for experimental \s-1VBR\s0 support. Maximum value range is
  from -50 to 50, useful range is from -10 to 10. The higher the
  value, the better the quality. This option is valid only using the
  **ffmpeg** command-line tool. For library interface users,
  use **global\_quality**.
* **mode (**_--mode_**)**  
  .IX Item "mode (--mode)"
  Set the mode of the resulting audio. Possible values:
    * **auto**  
      .IX Item "auto"
      Choose mode automatically based on the input. This is the default.
    * **stereo**  
      .IX Item "stereo"
      Stereo
    * **joint\_stereo**  
      .IX Item "joint_stereo"
      Joint stereo
    * **dual\_channel**  
      .IX Item "dual_channel"
      Dual channel
    * **mono**  
      .IX Item "mono"
      Mono
* **psymodel (**_--psyc-mode_**)**  
  .IX Item "psymodel (--psyc-mode)"
  Set psychoacoustic model to use in encoding. The argument must be
  an integer between -1 and 4, inclusive. The higher the value, the
  better the quality. The default value is 3.
* **energy_levels (**_--energy_**)**  
  .IX Item "energy_levels (--energy)"
  Enable energy levels extensions when set to 1. The default value is
  0 (disabled).
* **error_protection (**_--protect_**)**  
  .IX Item "error_protection (--protect)"
  Enable \s-1CRC\s0 error protection when set to 1. The default value is 0
  (disabled).
* **copyright (**_--copyright_**)**  
  .IX Item "copyright (--copyright)"
  Set \s-1MPEG\s0 audio copyright flag when set to 1. The default value is 0
  (disabled).
* **original (**_--original_**)**  
  .IX Item "original (--original)"
  Set \s-1MPEG\s0 audio original flag when set to 1. The default value is 0
  (disabled).

<a name="libvo-amrwbenc"></a>

### libvo-amrwbenc

.IX Subsection "libvo-amrwbenc"
VisualOn Adaptive Multi-Rate Wideband encoder.

Requires the presence of the libvo-amrwbenc headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libvo-amrwbenc --enable-version3\*(C'.

This is a mono-only encoder. Officially it only supports 16000Hz sample
rate, but you can override it by setting **strict** to
**unofficial** or lower.

_Options_
.IX Subsection "Options"

* **b**  
  .IX Item "b"
  Set bitrate in bits/s. Only the following bitrates are supported, otherwise
  libavcodec will round to the nearest valid bitrate.
    * **6600**  
      .IX Item "6600"
    * **8850**  
      .IX Item "8850"
    * **12650**  
      .IX Item "12650"
    * **14250**  
      .IX Item "14250"
    * **15850**  
      .IX Item "15850"
    * **18250**  
      .IX Item "18250"
    * **19850**  
      .IX Item "19850"
    * **23050**  
      .IX Item "23050"
    * **23850**  
      .IX Item "23850"
* **dtx**  
  .IX Item "dtx"
  Allow discontinuous transmission (generate comfort noise) when set to 1. The
  default value is 0 (disabled).

<a name="libvorbis"></a>

### libvorbis

.IX Subsection "libvorbis"
libvorbis encoder wrapper.

Requires the presence of the libvorbisenc headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libvorbis\*(C'.

_Options_
.IX Subsection "Options"

The following options are supported by the libvorbis wrapper. The
**oggenc**-equivalent of the options are listed in parentheses.

To get a more accurate and extensive documentation of the libvorbis
options, consult the libvorbisenc's and **oggenc**'s documentations.
See &lt;**http://xiph.org/vorbis/**&gt;,
&lt;**http://wiki.xiph.org/Vorbis-tools**&gt;, and **oggenc**\|(1).

* **b (**_-b_**)**  
  .IX Item "b (-b)"
  Set bitrate expressed in bits/s for \s-1ABR.\s0 **oggenc** **-b** is
  expressed in kilobits/s.
* **q (**_-q_**)**  
  .IX Item "q (-q)"
  Set constant quality setting for \s-1VBR.\s0 The value should be a float
  number in the range of -1.0 to 10.0. The higher the value, the better
  the quality. The default value is **3.0**.
  .Sp
  This option is valid only using the **ffmpeg** command-line tool.
  For library interface users, use **global\_quality**.
* **cutoff (**_--advanced-encode-option lowpass\_frequency=N_**)**  
  .IX Item "cutoff (--advanced-encode-option lowpass_frequency=N)"
  Set cutoff bandwidth in Hz, a value of 0 disables cutoff. **oggenc**'s
  related option is expressed in kHz. The default value is **0** (cutoff
  disabled).
* **minrate (**_-m_**)**  
  .IX Item "minrate (-m)"
  Set minimum bitrate expressed in bits/s. **oggenc** **-m** is
  expressed in kilobits/s.
* **maxrate (**_-M_**)**  
  .IX Item "maxrate (-M)"
  Set maximum bitrate expressed in bits/s. **oggenc** **-M** is
  expressed in kilobits/s. This only has effect on \s-1ABR\s0 mode.
* **iblock (**_--advanced-encode-option impulse\_noisetune=N_**)**  
  .IX Item "iblock (--advanced-encode-option impulse_noisetune=N)"
  Set noise floor bias for impulse blocks. The value is a float number from
  -15.0 to 0.0. A negative bias instructs the encoder to pay special attention
  to the crispness of transients in the encoded audio. The tradeoff for better
  transient response is a higher bitrate.

<a name="libwavpack"></a>

### libwavpack

.IX Subsection "libwavpack"
A wrapper providing WavPack encoding through libwavpack.

Only lossless mode using 32-bit integer samples is supported currently.

Requires the presence of the libwavpack headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libwavpack\*(C'.

Note that a libavcodec-native encoder for the WavPack codec exists so users can
encode audios with this codec without using this encoder. See **wavpackenc**.

_Options_
.IX Subsection "Options"

**wavpack** command line utility's corresponding options are listed in
parentheses, if any.

* **frame_size (**_--blocksize_**)**  
  .IX Item "frame_size (--blocksize)"
  Default is 32768.
* **compression\_level**  
  .IX Item "compression_level"
  Set speed vs. compression tradeoff. Acceptable arguments are listed below:
    * **0 (**_-f_**)**  
      .IX Item "0 (-f)"
      Fast mode.
    * **1**  
      .IX Item "1"
      Normal (default) settings.
    * **2 (**_-h_**)**  
      .IX Item "2 (-h)"
      High quality.
    * **3 (**_-hh_**)**  
      .IX Item "3 (-hh)"
      Very high quality.
    * **4-8 (**_-hh -x__\s-1EXTRAPROC\s0_**)**  
      .IX Item "4-8 (-hh -xEXTRAPROC)"
      Same as **3**, but with extra processing enabled.
      .Sp
      **4** is the same as **-x2** and **8** is the same as **-x6**.

<a name="mjpeg"></a>

### mjpeg

.IX Subsection "mjpeg"
Motion \s-1JPEG\s0 encoder.

_Options_
.IX Subsection "Options"

* **huffman**  
  .IX Item "huffman"
  Set the huffman encoding strategy. Possible values:
    * **default**  
      .IX Item "default"
      Use the default huffman tables. This is the default strategy.
    * **optimal**  
      .IX Item "optimal"
      Compute and use optimal huffman tables.

<a name="wavpack"></a>

### wavpack

.IX Subsection "wavpack"
WavPack lossless audio encoder.

This is a libavcodec-native WavPack encoder. There is also an encoder based on
libwavpack, but there is virtually no reason to use that encoder.

See also **libwavpack**.

_Options_
.IX Subsection "Options"

The equivalent options for **wavpack** command line utility are listed in
parentheses.

Shared options
.IX Subsection "Shared options"

The following shared options are effective for this encoder. Only special notes
about this particular encoder will be documented here. For the general meaning
of the options, see **the Codec Options chapter**.

* **frame_size (**_--blocksize_**)**  
  .IX Item "frame_size (--blocksize)"
  For this encoder, the range for this option is between 128 and 131072. Default
  is automatically decided based on sample rate and number of channel.
  .Sp
  For the complete formula of calculating default, see
  _libavcodec/wavpackenc.c_.
* **compression_level (**_-f_**,** _-h_**,** _-hh_**, and** _-x_**)**  
  .IX Item "compression_level (-f, -h, -hh, and -x)"
  This option's syntax is consistent with **libwavpack**'s.

Private options
.IX Subsection "Private options"

* **joint_stereo (**_-j_**)**  
  .IX Item "joint_stereo (-j)"
  Set whether to enable joint stereo. Valid values are:
    * **on (**_1_**)**  
      .IX Item "on (1)"
      Force mid/side audio encoding.
    * **off (**_0_**)**  
      .IX Item "off (0)"
      Force left/right audio encoding.
    * **auto**  
      .IX Item "auto"
      Let the encoder decide automatically.
* **optimize\_mono**  
  .IX Item "optimize_mono"
  Set whether to enable optimization for mono. This option is only effective for
  non-mono streams. Available values:
    * **on**  
      .IX Item "on"
      enabled
    * **off**  
      .IX Item "off"
      disabled

<a name="video-encoders"></a>

# Video Encoders

.IX Header "VIDEO ENCODERS"
A description of some of the currently available video encoders
follows.

<a name="hap"></a>

### Hap

.IX Subsection "Hap"
Vidvox Hap video encoder.

_Options_
.IX Subsection "Options"

* **format** _integer_  
  .IX Item "format integer"
  Specifies the Hap format to encode.
    * **hap**  
      .IX Item "hap"
    * **hap\_alpha**  
      .IX Item "hap_alpha"
    * **hap\_q**  
      .IX Item "hap_q"
      .Sp
      Default value is **hap**.
* **chunks** _integer_  
  .IX Item "chunks integer"
  Specifies the number of chunks to split frames into, between 1 and 64. This
  permits multithreaded decoding of large frames, potentially at the cost of
  data-rate. The encoder may modify this value to divide frames evenly.
  .Sp
  Default value is _1_.
* **compressor** _integer_  
  .IX Item "compressor integer"
  Specifies the second-stage compressor to use. If set to **none**,
  **chunks** will be limited to 1, as chunked uncompressed frames offer no
  benefit.
    * **none**  
      .IX Item "none"
    * **snappy**  
      .IX Item "snappy"
      .Sp
      Default value is **snappy**.

<a name="jpeg2000"></a>

### jpeg2000

.IX Subsection "jpeg2000"
The native jpeg 2000 encoder is lossy by default, the \f(CW`-q:v\*(C'
option can be used to set the encoding quality. Lossless encoding
can be selected with \f(CW`-pred 1\*(C'.

_Options_
.IX Subsection "Options"

* **format**  
  .IX Item "format"
  Can be set to either \f(CW`j2k\*(C' or \f(CW\*(C\`jp2\*(C' (the default) that
  makes it possible to store non-rgb pix_fmts.

<a name="libkvazaar"></a>

### libkvazaar

.IX Subsection "libkvazaar"
Kvazaar H.265/HEVC encoder.

Requires the presence of the libkvazaar headers and library during
configuration. You need to explicitly configure the build with
**--enable-libkvazaar**.

_Options_
.IX Subsection "Options"

* **b**  
  .IX Item "b"
  Set target video bitrate in bit/s and enable rate control.
* **kvazaar-params**  
  .IX Item "kvazaar-params"
  Set kvazaar parameters as a list of _name_=_value_ pairs separated
  by commas (,). See kvazaar documentation for a list of options.

<a name="libopenh264"></a>

### libopenh264

.IX Subsection "libopenh264"
Cisco libopenh264 H.264/MPEG-4 \s-1AVC\s0 encoder wrapper.

This encoder requires the presence of the libopenh264 headers and
library during configuration. You need to explicitly configure the
build with \f(CW`--enable-libopenh264\*(C'. The library is detected using
**pkg-config**.

For more information about the library see
&lt;**http://www.openh264.org**&gt;.

_Options_
.IX Subsection "Options"

The following FFmpeg global options affect the configurations of the
libopenh264 encoder.

* **b**  
  .IX Item "b"
  Set the bitrate (as a number of bits per second).
* **g**  
  .IX Item "g"
  Set the \s-1GOP\s0 size.
* **maxrate**  
  .IX Item "maxrate"
  Set the max bitrate (as a number of bits per second).
* **flags +global\_header**  
  .IX Item "flags +global_header"
  Set global header in the bitstream.
* **slices**  
  .IX Item "slices"
  Set the number of slices, used in parallelized encoding. Default value
  is 0. This is only used when **slice\_mode** is set to
  **fixed**.
* **slice\_mode**  
  .IX Item "slice_mode"
  Set slice mode. Can assume one of the following possible values:
    * **fixed**  
      .IX Item "fixed"
      a fixed number of slices
    * **rowmb**  
      .IX Item "rowmb"
      one slice per row of macroblocks
    * **auto**  
      .IX Item "auto"
      automatic number of slices according to number of threads
    * **dyn**  
      .IX Item "dyn"
      dynamic slicing
      .Sp
      Default value is **auto**.
* **loopfilter**  
  .IX Item "loopfilter"
  Enable loop filter, if set to 1 (automatically enabled). To disable
  set a value of 0.
* **profile**  
  .IX Item "profile"
  Set profile restrictions. If set to the value of **main** enable
  \s-1CABAC\s0 (set the \f(CW`SEncParamExt.iEntropyCodingModeFlag\*(C' flag to 1).
* **max\_nal\_size**  
  .IX Item "max_nal_size"
  Set maximum \s-1NAL\s0 size in bytes.
* **allow\_skip\_frames**  
  .IX Item "allow_skip_frames"
  Allow skipping frames to hit the target bitrate if set to 1.

<a name="libtheora"></a>

### libtheora

.IX Subsection "libtheora"
libtheora Theora encoder wrapper.

Requires the presence of the libtheora headers and library during
configuration. You need to explicitly configure the build with
\f(CW`--enable-libtheora\*(C'.

For more information about the libtheora project see
&lt;**http://www.theora.org/**&gt;.

_Options_
.IX Subsection "Options"

The following global options are mapped to internal libtheora options
which affect the quality and the bitrate of the encoded stream.

* **b**  
  .IX Item "b"
  Set the video bitrate in bit/s for \s-1CBR\s0 (Constant Bit Rate) mode.  In
  case \s-1VBR\s0 (Variable Bit Rate) mode is enabled this option is ignored.
* **flags**  
  .IX Item "flags"
  Used to enable constant quality mode (\s-1VBR\s0) encoding through the
  **qscale** flag, and to enable the \f(CW`pass1\*(C' and \f(CW\*(C\`pass2\*(C'
  modes.
* **g**  
  .IX Item "g"
  Set the \s-1GOP\s0 size.
* **global\_quality**  
  .IX Item "global_quality"
  Set the global quality as an integer in lambda units.
  .Sp
  Only relevant when \s-1VBR\s0 mode is enabled with \f(CW`flags +qscale\*(C'. The
  value is converted to \s-1QP\s0 units by dividing it by \f(CW`FF\_QP2LAMBDA\*(C',
  clipped in the [0 - 10] range, and then multiplied by 6.3 to get a
  value in the native libtheora range [0-63]. A higher value corresponds
  to a higher quality.
* **q**  
  .IX Item "q"
  Enable \s-1VBR\s0 mode when set to a non-negative value, and set constant
  quality value as a double floating point value in \s-1QP\s0 units.
  .Sp
  The value is clipped in the [0-10] range, and then multiplied by 6.3
  to get a value in the native libtheora range [0-63].
  .Sp
  This option is valid only using the **ffmpeg** command-line
  tool. For library interface users, use **global\_quality**.

_Examples_
.IX Subsection "Examples"

* ·  
  Set maximum constant quality (\s-1VBR\s0) encoding with **ffmpeg**:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -codec:v libtheora -q:v 10 OUTPUT.ogg
  .Ve
* ·  
  Use **ffmpeg** to convert a \s-1CBR 1000\s0 kbps Theora video stream:
  .Sp
  .Vb 1
          ffmpeg -i INPUT -codec:v libtheora -b:v 1000k OUTPUT.ogg
  .Ve

<a name="libvpx"></a>

### libvpx

.IX Subsection "libvpx"
\s-1VP8/VP9\s0 format supported through libvpx.

Requires the presence of the libvpx headers and library during configuration.
You need to explicitly configure the build with \f(CW`--enable-libvpx\*(C'.

_Options_
.IX Subsection "Options"

The following options are supported by the libvpx wrapper. The
**vpxenc**-equivalent options or values are listed in parentheses
for easy migration.

To reduce the duplication of documentation, only the private options
and some others requiring special attention are documented here. For
the documentation of the undocumented generic options, see
**the Codec Options chapter**.

To get more documentation of the libvpx options, invoke the command
**ffmpeg -h encoder=libvpx**, **ffmpeg -h encoder=libvpx-vp9** or
**vpxenc --help**. Further information is available in the libvpx \s-1API\s0
documentation.

* **b (**_target-bitrate_**)**  
  .IX Item "b (target-bitrate)"
  Set bitrate in bits/s. Note that FFmpeg's **b** option is
  expressed in bits/s, while **vpxenc**'s **target-bitrate** is in
  kilobits/s.
* **g (**_kf-max-dist_**)**  
  .IX Item "g (kf-max-dist)"
* **keyint_min (**_kf-min-dist_**)**  
  .IX Item "keyint_min (kf-min-dist)"
* **qmin (**_min-q_**)**  
  .IX Item "qmin (min-q)"
* **qmax (**_max-q_**)**  
  .IX Item "qmax (max-q)"
* **bufsize (**_buf-sz_**,** _buf-optimal-sz_**)**  
  .IX Item "bufsize (buf-sz, buf-optimal-sz)"
  Set ratecontrol buffer size (in bits). Note **vpxenc**'s options are
  specified in milliseconds, the libvpx wrapper converts this value as follows:
  \f(CW`buf-sz = bufsize * 1000 / bitrate\*(C',
  \f(CW`buf-optimal-sz = bufsize * 1000 / bitrate * 5 / 6\*(C'.
* **rc_init_occupancy (**_buf-initial-sz_**)**  
  .IX Item "rc_init_occupancy (buf-initial-sz)"
  Set number of bits which should be loaded into the rc buffer before decoding
  starts. Note **vpxenc**'s option is specified in milliseconds, the libvpx
  wrapper converts this value as follows:
  \f(CW`rc_init_occupancy * 1000 / bitrate\*(C'.
* **undershoot-pct**  
  .IX Item "undershoot-pct"
  Set datarate undershoot (min) percentage of the target bitrate.
* **overshoot-pct**  
  .IX Item "overshoot-pct"
  Set datarate overshoot (max) percentage of the target bitrate.
* **skip_threshold (**_drop-frame_**)**  
  .IX Item "skip_threshold (drop-frame)"
* **qcomp (**_bias-pct_**)**  
  .IX Item "qcomp (bias-pct)"
* **maxrate (**_maxsection-pct_**)**  
  .IX Item "maxrate (maxsection-pct)"
  Set \s-1GOP\s0 max bitrate in bits/s. Note **vpxenc**'s option is specified as a
  percentage of the target bitrate, the libvpx wrapper converts this value as
  follows: \f(CW`(maxrate * 100 / bitrate)\*(C'.
* **minrate (**_minsection-pct_**)**  
  .IX Item "minrate (minsection-pct)"
  Set \s-1GOP\s0 min bitrate in bits/s. Note **vpxenc**'s option is specified as a
  percentage of the target bitrate, the libvpx wrapper converts this value as
  follows: \f(CW`(minrate * 100 / bitrate)\*(C'.
* **minrate, maxrate, b** _end-usage=cbr_  
  .IX Item "minrate, maxrate, b end-usage=cbr"
  \f(CW`(minrate == maxrate == bitrate)\*(C'.
* **crf (**_end-usage=cq_**,** _cq-level_**)**  
  .IX Item "crf (end-usage=cq, cq-level)"
* **tune (**_tune_**)**  
  .IX Item "tune (tune)"
    * **psnr (**_psnr_**)**  
      .IX Item "psnr (psnr)"
    * **ssim (**_ssim_**)**  
      .IX Item "ssim (ssim)"
* **quality, deadline (**_deadline_**)**  
  .IX Item "quality, deadline (deadline)"
    * **best**  
      .IX Item "best"
      Use best quality deadline. Poorly named and quite slow, this option should be
      avoided as it may give worse quality output than good.
    * **good**  
      .IX Item "good"
      Use good quality deadline. This is a good trade-off between speed and quality
      when used with the **cpu-used** option.
    * **realtime**  
      .IX Item "realtime"
      Use realtime quality deadline.
* **speed, cpu-used (**_cpu-used_**)**  
  .IX Item "speed, cpu-used (cpu-used)"
  Set quality/speed ratio modifier. Higher values speed up the encode at the cost
  of quality.
* **nr (**_noise-sensitivity_**)**  
  .IX Item "nr (noise-sensitivity)"
* **static-thresh**  
  .IX Item "static-thresh"
  Set a change threshold on blocks below which they will be skipped by the
  encoder.
* **slices (**_token-parts_**)**  
  .IX Item "slices (token-parts)"
  Note that FFmpeg's **slices** option gives the total number of partitions,
  while **vpxenc**'s **token-parts** is given as
  \f(CW`log2(partitions)\*(C'.
* **max-intra-rate**  
  .IX Item "max-intra-rate"
  Set maximum I-frame bitrate as a percentage of the target bitrate. A value of 0
  means unlimited.
* **force\_key\_frames**  
  .IX Item "force_key_frames"
  \f(CW`VPX\_EFLAG\_FORCE\_KF\*(C'
* **Alternate reference frame related**  
  .IX Item "Alternate reference frame related"
    * **auto-alt-ref**  
      .IX Item "auto-alt-ref"
      Enable use of alternate reference frames (2-pass only).
    * **arnr-max-frames**  
      .IX Item "arnr-max-frames"
      Set altref noise reduction max frame count.
    * **arnr-type**  
      .IX Item "arnr-type"
      Set altref noise reduction filter type: backward, forward, centered.
    * **arnr-strength**  
      .IX Item "arnr-strength"
      Set altref noise reduction filter strength.
    * **rc-lookahead, lag-in-frames (**_lag-in-frames_**)**  
      .IX Item "rc-lookahead, lag-in-frames (lag-in-frames)"
      Set number of frames to look ahead for frametype and ratecontrol.
* **error-resilient**  
  .IX Item "error-resilient"
  Enable error resiliency features.
* **VP9-specific options**  
  .IX Item "VP9-specific options"
    * **lossless**  
      .IX Item "lossless"
      Enable lossless mode.
    * **tile-columns**  
      .IX Item "tile-columns"
      Set number of tile columns to use. Note this is given as
      \f(CW`log2(tile\_columns)\*(C'. For example, 8 tile columns would be requested by
      setting the **tile-columns** option to 3.
    * **tile-rows**  
      .IX Item "tile-rows"
      Set number of tile rows to use. Note this is given as \f(CW`log2(tile\_rows)\*(C'.
      For example, 4 tile rows would be requested by setting the **tile-rows**
      option to 2.
    * **frame-parallel**  
      .IX Item "frame-parallel"
      Enable frame parallel decodability features.
    * **aq-mode**  
      .IX Item "aq-mode"
      Set adaptive quantization mode (0: off (default), 1: variance 2: complexity, 3:
      cyclic refresh, 4: equator360).
    * **colorspace** _color-space_  
      .IX Item "colorspace color-space"
      Set input color space. The \s-1VP9\s0 bitstream supports signaling the following
      colorspaces:
        * **rgb \f(BIsRGB**  
          .IX Item "rgb sRGB"
        * **bt709 \f(BIbt709**  
          .IX Item "bt709 bt709"
        * **unspecified \f(BIunknown**  
          .IX Item "unspecified unknown"
        * **bt470bg \f(BIbt601**  
          .IX Item "bt470bg bt601"
        * **smpte170m \f(BIsmpte170**  
          .IX Item "smpte170m smpte170"
        * **smpte240m \f(BIsmpte240**  
          .IX Item "smpte240m smpte240"
        * **bt2020_ncl \f(BIbt2020**  
          .IX Item "bt2020_ncl bt2020"
    * **row-mt** _boolean_  
      .IX Item "row-mt boolean"
      Enable row based multi-threading.
    * **tune-content**  
      .IX Item "tune-content"
      Set content type: default (0), screen (1), film (2).
    * **corpus-complexity**  
      .IX Item "corpus-complexity"
      Corpus \s-1VBR\s0 mode is a variant of standard \s-1VBR\s0 where the complexity distribution
      midpoint is passed in rather than calculated for a specific clip or chunk.
      .Sp
      The valid range is [0, 10000]. 0 (default) uses standard \s-1VBR.\s0

For more information about libvpx see:
&lt;**http://www.webmproject.org/**&gt;

<a name="libwebp"></a>

### libwebp

.IX Subsection "libwebp"
libwebp WebP Image encoder wrapper

libwebp is Google's official encoder for WebP images. It can encode in either
lossy or lossless mode. Lossy images are essentially a wrapper around a \s-1VP8\s0
frame. Lossless images are a separate codec developed by Google.

_Pixel Format_
.IX Subsection "Pixel Format"

Currently, libwebp only supports \s-1YUV420\s0 for lossy and \s-1RGB\s0 for lossless due
to limitations of the format and libwebp. Alpha is supported for either mode.
Because of \s-1API\s0 limitations, if \s-1RGB\s0 is passed in when encoding lossy or \s-1YUV\s0 is
passed in for encoding lossless, the pixel format will automatically be
converted using functions from libwebp. This is not ideal and is done only for
convenience.

_Options_
.IX Subsection "Options"

* **-lossless** _boolean_  
  .IX Item "-lossless boolean"
  Enables/Disables use of lossless mode. Default is 0.
* **-compression\_level** _integer_  
  .IX Item "-compression_level integer"
  For lossy, this is a quality/speed tradeoff. Higher values give better quality
  for a given size at the cost of increased encoding time. For lossless, this is
  a size/speed tradeoff. Higher values give smaller size at the cost of increased
  encoding time. More specifically, it controls the number of extra algorithms
  and compression tools used, and varies the combination of these tools. This
  maps to the _method_ option in libwebp. The valid range is 0 to 6.
  Default is 4.
* **-qscale** _float_  
  .IX Item "-qscale float"
  For lossy encoding, this controls image quality, 0 to 100. For lossless
  encoding, this controls the effort and time spent at compressing more. The
  default value is 75. Note that for usage via libavcodec, this option is called
  _global\_quality_ and must be multiplied by _\s-1FF\_QP2LAMBDA\s0_.
* **-preset** _type_  
  .IX Item "-preset type"
  Configuration preset. This does some automatic settings based on the general
  type of the image.
    * **none**  
      .IX Item "none"
      Do not use a preset.
    * **default**  
      .IX Item "default"
      Use the encoder default.
    * **picture**  
      .IX Item "picture"
      Digital picture, like portrait, inner shot
    * **photo**  
      .IX Item "photo"
      Outdoor photograph, with natural lighting
    * **drawing**  
      .IX Item "drawing"
      Hand or line drawing, with high-contrast details
    * **icon**  
      .IX Item "icon"
      Small-sized colorful images
    * **text**  
      .IX Item "text"
      Text-like

<a name="libx264-libx264rgb"></a>

### libx264, libx264rgb

.IX Subsection "libx264, libx264rgb"
x264 H.264/MPEG-4 \s-1AVC\s0 encoder wrapper.

This encoder requires the presence of the libx264 headers and library
during configuration. You need to explicitly configure the build with
\f(CW`--enable-libx264\*(C'.

libx264 supports an impressive number of features, including 8x8 and
4x4 adaptive spatial transform, adaptive B-frame placement, \s-1CAVLC/CABAC\s0
entropy coding, interlacing (\s-1MBAFF\s0), lossless mode, psy optimizations
for detail retention (adaptive quantization, psy-RD, psy-trellis).

Many libx264 encoder options are mapped to FFmpeg global codec
options, while unique encoder options are provided through private
options. Additionally the **x264opts** and **x264-params**
private options allows one to pass a list of key=value tuples as accepted
by the libx264 \f(CW`x264\_param\_parse\*(C' function.

The x264 project website is at
&lt;**http://www.videolan.org/developers/x264.html**&gt;.

The libx264rgb encoder is the same as libx264, except it accepts packed \s-1RGB\s0
pixel formats as input instead of \s-1YUV.\s0

_Supported Pixel Formats_
.IX Subsection "Supported Pixel Formats"

x264 supports 8- to 10-bit color spaces. The exact bit depth is controlled at
x264's configure time. FFmpeg only supports one bit depth in one particular
build. In other words, it is not possible to build one FFmpeg with multiple
versions of x264 with different bit depths.

_Options_
.IX Subsection "Options"

The following options are supported by the libx264 wrapper. The
**x264**-equivalent options or values are listed in parentheses
for easy migration.

To reduce the duplication of documentation, only the private options
and some others requiring special attention are documented here. For
the documentation of the undocumented generic options, see
**the Codec Options chapter**.

To get a more accurate and extensive documentation of the libx264
options, invoke the command **x264 --fullhelp** or consult
the libx264 documentation.

* **b (**_bitrate_**)**  
  .IX Item "b (bitrate)"
  Set bitrate in bits/s. Note that FFmpeg's **b** option is
  expressed in bits/s, while **x264**'s **bitrate** is in
  kilobits/s.
* **bf (**_bframes_**)**  
  .IX Item "bf (bframes)"
* **g (**_keyint_**)**  
  .IX Item "g (keyint)"
* **qmin (**_qpmin_**)**  
  .IX Item "qmin (qpmin)"
  Minimum quantizer scale.
* **qmax (**_qpmax_**)**  
  .IX Item "qmax (qpmax)"
  Maximum quantizer scale.
* **qdiff (**_qpstep_**)**  
  .IX Item "qdiff (qpstep)"
  Maximum difference between quantizer scales.
* **qblur (**_qblur_**)**  
  .IX Item "qblur (qblur)"
  Quantizer curve blur
* **qcomp (**_qcomp_**)**  
  .IX Item "qcomp (qcomp)"
  Quantizer curve compression factor
* **refs (**_ref_**)**  
  .IX Item "refs (ref)"
  Number of reference frames each P-frame can use. The range is from _0-16_.
* **sc_threshold (**_scenecut_**)**  
  .IX Item "sc_threshold (scenecut)"
  Sets the threshold for the scene change detection.
* **trellis (**_trellis_**)**  
  .IX Item "trellis (trellis)"
  Performs Trellis quantization to increase efficiency. Enabled by default.
* **nr  (**_nr_**)**  
  .IX Item "nr (nr)"
* **me_range (**_merange_**)**  
  .IX Item "me_range (merange)"
  Maximum range of the motion search in pixels.
* **me_method (**_me_**)**  
  .IX Item "me_method (me)"
  Set motion estimation method. Possible values in the decreasing order
  of speed:
    * **dia (**_dia_**)**  
      .IX Item "dia (dia)"
    * **epzs (**_dia_**)**  
      .IX Item "epzs (dia)"
      Diamond search with radius 1 (fastest). **epzs** is an alias for
      **dia**.
    * **hex (**_hex_**)**  
      .IX Item "hex (hex)"
      Hexagonal search with radius 2.
    * **umh (**_umh_**)**  
      .IX Item "umh (umh)"
      Uneven multi-hexagon search.
    * **esa (**_esa_**)**  
      .IX Item "esa (esa)"
      Exhaustive search.
    * **tesa (**_tesa_**)**  
      .IX Item "tesa (tesa)"
      Hadamard exhaustive search (slowest).
* **forced-idr**  
  .IX Item "forced-idr"
  Normally, when forcing a I-frame type, the encoder can select any type
  of I-frame. This option forces it to choose an IDR-frame.
* **subq (**_subme_**)**  
  .IX Item "subq (subme)"
  Sub-pixel motion estimation method.
* **b_strategy (**_b-adapt_**)**  
  .IX Item "b_strategy (b-adapt)"
  Adaptive B-frame placement decision algorithm. Use only on first-pass.
* **keyint_min (**_min-keyint_**)**  
  .IX Item "keyint_min (min-keyint)"
  Minimum \s-1GOP\s0 size.
* **coder**  
  .IX Item "coder"
  Set entropy encoder. Possible values:
    * **ac**  
      .IX Item "ac"
      Enable \s-1CABAC.\s0
    * **vlc**  
      .IX Item "vlc"
      Enable \s-1CAVLC\s0 and disable \s-1CABAC.\s0 It generates the same effect as
      **x264**'s **--no-cabac** option.
* **cmp**  
  .IX Item "cmp"
  Set full pixel motion estimation comparison algorithm. Possible values:
    * **chroma**  
      .IX Item "chroma"
      Enable chroma in motion estimation.
    * **sad**  
      .IX Item "sad"
      Ignore chroma in motion estimation. It generates the same effect as
      **x264**'s **--no-chroma-me** option.
* **threads (**_threads_**)**  
  .IX Item "threads (threads)"
  Number of encoding threads.
* **thread\_type**  
  .IX Item "thread_type"
  Set multithreading technique. Possible values:
    * **slice**  
      .IX Item "slice"
      Slice-based multithreading. It generates the same effect as
      **x264**'s **--sliced-threads** option.
    * **frame**  
      .IX Item "frame"
      Frame-based multithreading.
* **flags**  
  .IX Item "flags"
  Set encoding flags. It can be used to disable closed \s-1GOP\s0 and enable
  open \s-1GOP\s0 by setting it to \f(CW`-cgop\*(C'. The result is similar to
  the behavior of **x264**'s **--open-gop** option.
* **rc_init_occupancy (**_vbv-init_**)**  
  .IX Item "rc_init_occupancy (vbv-init)"
* **preset (**_preset_**)**  
  .IX Item "preset (preset)"
  Set the encoding preset.
* **tune (**_tune_**)**  
  .IX Item "tune (tune)"
  Set tuning of the encoding params.
* **profile (**_profile_**)**  
  .IX Item "profile (profile)"
  Set profile restrictions.
* **fastfirstpass**  
  .IX Item "fastfirstpass"
  Enable fast settings when encoding first pass, when set to 1. When set
  to 0, it has the same effect of **x264**'s
  **--slow-firstpass** option.
* **crf (**_crf_**)**  
  .IX Item "crf (crf)"
  Set the quality for constant quality mode.
* **crf_max (**_crf-max_**)**  
  .IX Item "crf_max (crf-max)"
  In \s-1CRF\s0 mode, prevents \s-1VBV\s0 from lowering quality beyond this point.
* **qp (**_qp_**)**  
  .IX Item "qp (qp)"
  Set constant quantization rate control method parameter.
* **aq-mode (**_aq-mode_**)**  
  .IX Item "aq-mode (aq-mode)"
  Set \s-1AQ\s0 method. Possible values:
    * **none (**_0_**)**  
      .IX Item "none (0)"
      Disabled.
    * **variance (**_1_**)**  
      .IX Item "variance (1)"
      Variance \s-1AQ\s0 (complexity mask).
    * **autovariance (**_2_**)**  
      .IX Item "autovariance (2)"
      Auto-variance \s-1AQ\s0 (experimental).
* **aq-strength (**_aq-strength_**)**  
  .IX Item "aq-strength (aq-strength)"
  Set \s-1AQ\s0 strength, reduce blocking and blurring in flat and textured areas.
* **psy**  
  .IX Item "psy"
  Use psychovisual optimizations when set to 1. When set to 0, it has the
  same effect as **x264**'s **--no-psy** option.
* **psy-rd  (**_psy-rd_**)**  
  .IX Item "psy-rd (psy-rd)"
  Set strength of psychovisual optimization, in
  _psy-rd_:_psy-trellis_ format.
* **rc-lookahead (**_rc-lookahead_**)**  
  .IX Item "rc-lookahead (rc-lookahead)"
  Set number of frames to look ahead for frametype and ratecontrol.
* **weightb**  
  .IX Item "weightb"
  Enable weighted prediction for B-frames when set to 1. When set to 0,
  it has the same effect as **x264**'s **--no-weightb** option.
* **weightp (**_weightp_**)**  
  .IX Item "weightp (weightp)"
  Set weighted prediction method for P-frames. Possible values:
    * **none (**_0_**)**  
      .IX Item "none (0)"
      Disabled
    * **simple (**_1_**)**  
      .IX Item "simple (1)"
      Enable only weighted refs
    * **smart (**_2_**)**  
      .IX Item "smart (2)"
      Enable both weighted refs and duplicates
* **ssim (**_ssim_**)**  
  .IX Item "ssim (ssim)"
  Enable calculation and printing \s-1SSIM\s0 stats after the encoding.
* **intra-refresh (**_intra-refresh_**)**  
  .IX Item "intra-refresh (intra-refresh)"
  Enable the use of Periodic Intra Refresh instead of \s-1IDR\s0 frames when set
  to 1.
* **avcintra-class (**_class_**)**  
  .IX Item "avcintra-class (class)"
  Configure the encoder to generate AVC-Intra.
  Valid values are 50,100 and 200
* **bluray-compat (**_bluray-compat_**)**  
  .IX Item "bluray-compat (bluray-compat)"
  Configure the encoder to be compatible with the bluray standard.
  It is a shorthand for setting bluray-compat=1 force-cfr=1\*(R".
* **b-bias (**_b-bias_**)**  
  .IX Item "b-bias (b-bias)"
  Set the influence on how often B-frames are used.
* **b-pyramid (**_b-pyramid_**)**  
  .IX Item "b-pyramid (b-pyramid)"
  Set method for keeping of some B-frames as references. Possible values:
    * **none (**_none_**)**  
      .IX Item "none (none)"
      Disabled.
    * **strict (**_strict_**)**  
      .IX Item "strict (strict)"
      Strictly hierarchical pyramid.
    * **normal (**_normal_**)**  
      .IX Item "normal (normal)"
      Non-strict (not Blu-ray compatible).
* **mixed-refs**  
  .IX Item "mixed-refs"
  Enable the use of one reference per partition, as opposed to one
  reference per macroblock when set to 1. When set to 0, it has the
  same effect as **x264**'s **--no-mixed-refs** option.
* **8x8dct**  
  .IX Item "8x8dct"
  Enable adaptive spatial transform (high profile 8x8 transform)
  when set to 1. When set to 0, it has the same effect as
  **x264**'s **--no-8x8dct** option.
* **fast-pskip**  
  .IX Item "fast-pskip"
  Enable early \s-1SKIP\s0 detection on P-frames when set to 1. When set
  to 0, it has the same effect as **x264**'s
  **--no-fast-pskip** option.
* **aud (**_aud_**)**  
  .IX Item "aud (aud)"
  Enable use of access unit delimiters when set to 1.
* **mbtree**  
  .IX Item "mbtree"
  Enable use macroblock tree ratecontrol when set to 1. When set
  to 0, it has the same effect as **x264**'s
  **--no-mbtree** option.
* **deblock (**_deblock_**)**  
  .IX Item "deblock (deblock)"
  Set loop filter parameters, in _alpha_:_beta_ form.
* **cplxblur (**_cplxblur_**)**  
  .IX Item "cplxblur (cplxblur)"
  Set fluctuations reduction in \s-1QP\s0 (before curve compression).
* **partitions (**_partitions_**)**  
  .IX Item "partitions (partitions)"
  Set partitions to consider as a comma-separated list of. Possible
  values in the list:
    * **p8x8**  
      .IX Item "p8x8"
      8x8 P-frame partition.
    * **p4x4**  
      .IX Item "p4x4"
      4x4 P-frame partition.
    * **b8x8**  
      .IX Item "b8x8"
      4x4 B-frame partition.
    * **i8x8**  
      .IX Item "i8x8"
      8x8 I-frame partition.
    * **i4x4**  
      .IX Item "i4x4"
      4x4 I-frame partition.
      (Enabling **p4x4** requires **p8x8** to be enabled. Enabling
      **i8x8** requires adaptive spatial transform (**8x8dct**
      option) to be enabled.)
    * **none (**_none_**)**  
      .IX Item "none (none)"
      Do not consider any partitions.
    * **all (**_all_**)**  
      .IX Item "all (all)"
      Consider every partition.
* **direct-pred (**_direct_**)**  
  .IX Item "direct-pred (direct)"
  Set direct \s-1MV\s0 prediction mode. Possible values:
    * **none (**_none_**)**  
      .IX Item "none (none)"
      Disable \s-1MV\s0 prediction.
    * **spatial (**_spatial_**)**  
      .IX Item "spatial (spatial)"
      Enable spatial predicting.
    * **temporal (**_temporal_**)**  
      .IX Item "temporal (temporal)"
      Enable temporal predicting.
    * **auto (**_auto_**)**  
      .IX Item "auto (auto)"
      Automatically decided.
* **slice-max-size (**_slice-max-size_**)**  
  .IX Item "slice-max-size (slice-max-size)"
  Set the limit of the size of each slice in bytes. If not specified
  but \s-1RTP\s0 payload size (**ps**) is specified, that is used.
* **stats (**_stats_**)**  
  .IX Item "stats (stats)"
  Set the file name for multi-pass stats.
* **nal-hrd (**_nal-hrd_**)**  
  .IX Item "nal-hrd (nal-hrd)"
  Set signal \s-1HRD\s0 information (requires **vbv-bufsize** to be set).
  Possible values:
    * **none (**_none_**)**  
      .IX Item "none (none)"
      Disable \s-1HRD\s0 information signaling.
    * **vbr (**_vbr_**)**  
      .IX Item "vbr (vbr)"
      Variable bit rate.
    * **cbr (**_cbr_**)**  
      .IX Item "cbr (cbr)"
      Constant bit rate (not allowed in \s-1MP4\s0 container).
* **x264opts (N.A.)**  
  .IX Item "x264opts (N.A.)"
  Set any x264 option, see **x264 --fullhelp** for a list.
  .Sp
  Argument is a list of _key_=_value_ couples separated by
  :\*(R". In _filter_ and _psy-rd_ options that use \*(L":\*(R" as a separator
  themselves, use ,\*(R" instead. They accept it as well since long ago but this
  is kept undocumented for some reason.
  .Sp
  For example to specify libx264 encoding options with **ffmpeg**:
  .Sp
  .Vb 1
          ffmpeg -i foo.mpg -c:v libx264 -x264opts keyint=123:min-keyint=20 -an out.mkv
  .Ve
* **a53cc** _boolean_  
  .IX Item "a53cc boolean"
  Import closed captions (which must be \s-1ATSC\s0 compatible format) into output.
  Only the mpeg2 and h264 decoders provide these. Default is 1 (on).
* **x264-params (N.A.)**  
  .IX Item "x264-params (N.A.)"
  Override the x264 configuration using a :-separated list of key=value
  parameters.
  .Sp
  This option is functionally the same as the **x264opts**, but is
  duplicated for compatibility with the Libav fork.
  .Sp
  For example to specify libx264 encoding options with **ffmpeg**:
  .Sp
  .Vb 3
          ffmpeg -i INPUT -c:v libx264 -x264-params level=30:bframes=0:weightp=0:\e
          cabac=0:ref=1:vbv-maxrate=768:vbv-bufsize=2000:analyse=all:me=umh:\e
          no-fast-pskip=1:subq=6:8x8dct=0:trellis=0 OUTPUT
  .Ve

Encoding ffpresets for common usages are provided so they can be used with the
general presets system (e.g. passing the **pre** option).

<a name="libx265"></a>

### libx265

.IX Subsection "libx265"
x265 H.265/HEVC encoder wrapper.

This encoder requires the presence of the libx265 headers and library
during configuration. You need to explicitly configure the build with
**--enable-libx265**.

_Options_
.IX Subsection "Options"

* **preset**  
  .IX Item "preset"
  Set the x265 preset.
* **tune**  
  .IX Item "tune"
  Set the x265 tune parameter.
* **profile**  
  .IX Item "profile"
  Set profile restrictions.
* **crf**  
  .IX Item "crf"
  Set the quality for constant quality mode.
* **forced-idr**  
  .IX Item "forced-idr"
  Normally, when forcing a I-frame type, the encoder can select any type
  of I-frame. This option forces it to choose an IDR-frame.
* **x265-params**  
  .IX Item "x265-params"
  Set x265 options using a list of _key_=_value_ couples separated
  by :\*(R". See **x265 --help** for a list of options.
  .Sp
  For example to specify libx265 encoding options with **-x265-params**:
  .Sp
  .Vb 1
          ffmpeg -i input -c:v libx265 -x265-params crf=26:psy-rd=1 output.mp4
  .Ve

<a name="libxvid"></a>

### libxvid

.IX Subsection "libxvid"
Xvid \s-1MPEG-4\s0 Part 2 encoder wrapper.

This encoder requires the presence of the libxvidcore headers and library
during configuration. You need to explicitly configure the build with
\f(CW`--enable-libxvid --enable-gpl\*(C'.

The native \f(CW`mpeg4\*(C' encoder supports the \s-1MPEG-4\s0 Part 2 format, so
users can encode to this format without this library.

_Options_
.IX Subsection "Options"

The following options are supported by the libxvid wrapper. Some of
the following options are listed but are not documented, and
correspond to shared codec options. See the Codec
Options chapter for their documentation. The other shared options
which are not listed have no effect for the libxvid encoder.

* **b**  
  .IX Item "b"
* **g**  
  .IX Item "g"
* **qmin**  
  .IX Item "qmin"
* **qmax**  
  .IX Item "qmax"
* **mpeg\_quant**  
  .IX Item "mpeg_quant"
* **threads**  
  .IX Item "threads"
* **bf**  
  .IX Item "bf"
* **b\_qfactor**  
  .IX Item "b_qfactor"
* **b\_qoffset**  
  .IX Item "b_qoffset"
* **flags**  
  .IX Item "flags"
  Set specific encoding flags. Possible values:
    * **mv4**  
      .IX Item "mv4"
      Use four motion vector by macroblock.
    * **aic**  
      .IX Item "aic"
      Enable high quality \s-1AC\s0 prediction.
    * **gray**  
      .IX Item "gray"
      Only encode grayscale.
    * **gmc**  
      .IX Item "gmc"
      Enable the use of global motion compensation (\s-1GMC\s0).
    * **qpel**  
      .IX Item "qpel"
      Enable quarter-pixel motion compensation.
    * **cgop**  
      .IX Item "cgop"
      Enable closed \s-1GOP.\s0
    * **global\_header**  
      .IX Item "global_header"
      Place global headers in extradata instead of every keyframe.
* **trellis**  
  .IX Item "trellis"
* **me\_method**  
  .IX Item "me_method"
  Set motion estimation method. Possible values in decreasing order of
  speed and increasing order of quality:
    * **zero**  
      .IX Item "zero"
      Use no motion estimation (default).
    * **phods**  
      .IX Item "phods"
    * **x1**  
      .IX Item "x1"
    * **log**  
      .IX Item "log"
      Enable advanced diamond zonal search for 16x16 blocks and half-pixel
      refinement for 16x16 blocks. **x1** and **log** are aliases for
      **phods**.
    * **epzs**  
      .IX Item "epzs"
      Enable all of the things described above, plus advanced diamond zonal
      search for 8x8 blocks, half-pixel refinement for 8x8 blocks, and motion
      estimation on chroma planes.
    * **full**  
      .IX Item "full"
      Enable all of the things described above, plus extended 16x16 and 8x8
      blocks search.
* **mbd**  
  .IX Item "mbd"
  Set macroblock decision algorithm. Possible values in the increasing
  order of quality:
    * **simple**  
      .IX Item "simple"
      Use macroblock comparing function algorithm (default).
    * **bits**  
      .IX Item "bits"
      Enable rate distortion-based half pixel and quarter pixel refinement for
      16x16 blocks.
    * **rd**  
      .IX Item "rd"
      Enable all of the things described above, plus rate distortion-based
      half pixel and quarter pixel refinement for 8x8 blocks, and rate
      distortion-based search using square pattern.
* **lumi\_aq**  
  .IX Item "lumi_aq"
  Enable lumi masking adaptive quantization when set to 1. Default is 0
  (disabled).
* **variance\_aq**  
  .IX Item "variance_aq"
  Enable variance adaptive quantization when set to 1. Default is 0
  (disabled).
  .Sp
  When combined with **lumi\_aq**, the resulting quality will not
  be better than any of the two specified individually. In other
  words, the resulting quality will be the worse one of the two
  effects.
* **ssim**  
  .IX Item "ssim"
  Set structural similarity (\s-1SSIM\s0) displaying method. Possible values:
    * **off**  
      .IX Item "off"
      Disable displaying of \s-1SSIM\s0 information.
    * **avg**  
      .IX Item "avg"
      Output average \s-1SSIM\s0 at the end of encoding to stdout. The format of
      showing the average \s-1SSIM\s0 is:
      .Sp
      .Vb 1
              Average SSIM: %f
      .Ve
      .Sp
      For users who are not familiar with C, \f(CW%f means a float number, or
      a decimal (e.g. 0.939232).
    * **frame**  
      .IX Item "frame"
      Output both per-frame \s-1SSIM\s0 data during encoding and average \s-1SSIM\s0 at
      the end of encoding to stdout. The format of per-frame information
      is:
      .Sp
      .Vb 1
                     SSIM: avg: %1.3f min: %1.3f max: %1.3f
      .Ve
      .Sp
      For users who are not familiar with C, \f(CW%1.3f means a float number
      rounded to 3 digits after the dot (e.g. 0.932).
* **ssim\_acc**  
  .IX Item "ssim_acc"
  Set \s-1SSIM\s0 accuracy. Valid options are integers within the range of
  0-4, while 0 gives the most accurate result and 4 computes the
  fastest.

<a name="mpeg2"></a>

### mpeg2

.IX Subsection "mpeg2"
\s-1MPEG-2\s0 video encoder.

_Options_
.IX Subsection "Options"

* **seq\_disp\_ext** _integer_  
  .IX Item "seq_disp_ext integer"
  Specifies if the encoder should write a sequence_display_extension to the
  output.
    * **-1**  
      .IX Item "-1"
    * **auto**  
      .IX Item "auto"
      Decide automatically to write it or not (this is the default) by checking if
      the data to be written is different from the default or unspecified values.
    * **0**  
      .IX Item "0"
    * **never**  
      .IX Item "never"
      Never write it.
    * **1**  
      .IX Item "1"
    * **always**  
      .IX Item "always"
      Always write it.
* **video\_format** _integer_  
  .IX Item "video_format integer"
  Specifies the video_format written into the sequence display extension
  indicating the source of the video pictures. The default is **unspecified**,
  can be **component**, **pal**, **ntsc**, **secam** or **mac**.
  For maximum compatibility, use **component**.

<a name="png"></a>

### png

.IX Subsection "png"
\s-1PNG\s0 image encoder.

_Private options_
.IX Subsection "Private options"

* **dpi** _integer_  
  .IX Item "dpi integer"
  Set physical density of pixels, in dots per inch, unset by default
* **dpm** _integer_  
  .IX Item "dpm integer"
  Set physical density of pixels, in dots per meter, unset by default

<a name="prores"></a>

### ProRes

.IX Subsection "ProRes"
Apple ProRes encoder.

FFmpeg contains 2 ProRes encoders, the prores-aw and prores-ks encoder.
The used encoder can be chosen with the \f(CW`-vcodec\*(C' option.

_Private Options for prores-ks_
.IX Subsection "Private Options for prores-ks"

* **profile** _integer_  
  .IX Item "profile integer"
  Select the ProRes profile to encode
    * **proxy**  
      .IX Item "proxy"
    * **lt**  
      .IX Item "lt"
    * **standard**  
      .IX Item "standard"
    * **hq**  
      .IX Item "hq"
    * **4444**  
      .IX Item "4444"
    * **4444xq**  
      .IX Item "4444xq"
* **quant\_mat** _integer_  
  .IX Item "quant_mat integer"
  Select quantization matrix.
    * **auto**  
      .IX Item "auto"
    * **default**  
      .IX Item "default"
    * **proxy**  
      .IX Item "proxy"
    * **lt**  
      .IX Item "lt"
    * **standard**  
      .IX Item "standard"
    * **hq**  
      .IX Item "hq"
      .Sp
      If set to _auto_, the matrix matching the profile will be picked.
      If not set, the matrix providing the highest quality, _default_, will be
      picked.
* **bits\_per\_mb** _integer_  
  .IX Item "bits_per_mb integer"
  How many bits to allot for coding one macroblock. Different profiles use
  between 200 and 2400 bits per macroblock, the maximum is 8000.
* **mbs\_per\_slice** _integer_  
  .IX Item "mbs_per_slice integer"
  Number of macroblocks in each slice (1-8); the default value (8)
  should be good in almost all situations.
* **vendor** _string_  
  .IX Item "vendor string"
  Override the 4-byte vendor \s-1ID.
  A\s0 custom vendor \s-1ID\s0 like _apl0_ would claim the stream was produced by
  the Apple encoder.
* **alpha\_bits** _integer_  
  .IX Item "alpha_bits integer"
  Specify number of bits for alpha component.
  Possible values are _0_, _8_ and _16_.
  Use _0_ to disable alpha plane coding.

_Speed considerations_
.IX Subsection "Speed considerations"

In the default mode of operation the encoder has to honor frame constraints
(i.e. not produce frames with size bigger than requested) while still making
output picture as good as possible.
A frame containing a lot of small details is harder to compress and the encoder
would spend more time searching for appropriate quantizers for each slice.

Setting a higher **bits\_per\_mb** limit will improve the speed.

For the fastest encoding speed set the **qscale** parameter (4 is the
recommended value) and do not set a size constraint.

<a name="s-1qsvs0-encoders"></a>

### \s-1QSV\s0 encoders

.IX Subsection "QSV encoders"
The family of Intel QuickSync Video encoders (\s-1MPEG-2, H.264\s0 and \s-1HEVC\s0)

The ratecontrol method is selected as follows:

* ·  
  When **global\_quality** is specified, a quality-based mode is used.
  Specifically this means either
    * _\s-1CQP\s0_ - constant quantizer scale, when the **qscale** codec flag is
      also set (the **-qscale** ffmpeg option).
    * _\s-1LA\_ICQ\s0_ - intelligent constant quality with lookahead, when the
      **look\_ahead** option is also set.
    * _\s-1ICQ\s0_  intelligent constant quality otherwise.
* ·  
  Otherwise, a bitrate-based mode is used. For all of those, you should specify at
  least the desired average bitrate with the **b** option.
    * _\s-1LA\s0_ - \s-1VBR\s0 with lookahead, when the **look\_ahead** option is specified.
    * _\s-1VCM\s0_ - video conferencing mode, when the **vcm** option is set.
    * _\s-1CBR\s0_ - constant bitrate, when **maxrate** is specified and equal to
      the average bitrate.
    * _\s-1VBR\s0_ - variable bitrate, when **maxrate** is specified, but is higher
      than the average bitrate.
    * _\s-1AVBR\s0_ - average \s-1VBR\s0 mode, when **maxrate** is not specified. This mode
      is further configured by the **avbr\_accuracy** and
      **avbr\_convergence** options.

Note that depending on your system, a different mode than the one you specified
may be selected by the encoder. Set the verbosity level to _verbose_ or
higher to see the actual settings used by the \s-1QSV\s0 runtime.

Additional libavcodec global options are mapped to \s-1MSDK\s0 options as follows:

* ·  
  **g/gop\_size** -&gt; **GopPicSize**
* ·  
  **bf/max\_b\_frames**+1 -&gt; **GopRefDist**
* ·  
  **rc\_init\_occupancy/rc\_initial\_buffer\_occupancy** -&gt;
  **InitialDelayInKB**
* ·  
  **slices** -&gt; **NumSlice**
* ·  
  **refs** -&gt; **NumRefFrame**
* ·  
  **b\_strategy/b\_frame\_strategy** -&gt; **BRefType**
* ·  
  **cgop/CLOSED\_GOP** codec flag -&gt; **GopOptFlag**
* ·  
  For the _\s-1CQP\s0_ mode, the **i\_qfactor/i\_qoffset** and
  **b\_qfactor/b\_qoffset** set the difference between _\s-1QPP\s0_ and _\s-1QPI\s0_,
  and _\s-1QPP\s0_ and _\s-1QPB\s0_ respectively.
* ·  
  Setting the **coder** option to the value _vlc_ will make the H.264
  encoder use \s-1CAVLC\s0 instead of \s-1CABAC.\s0

<a name="snow"></a>

### snow

.IX Subsection "snow"
_Options_
.IX Subsection "Options"

* **iterative\_dia\_size**  
  .IX Item "iterative_dia_size"
  dia size for the iterative motion estimation

<a name="s-1vaapis0-encoders"></a>

### \s-1VAAPI\s0 encoders

.IX Subsection "VAAPI encoders"
Wrappers for hardware encoders accessible via \s-1VAAPI.\s0

These encoders only accept input in \s-1VAAPI\s0 hardware surfaces.  If you have input
in software frames, use the **hwupload** filter to upload them to the \s-1GPU.\s0

The following standard libavcodec options are used:

* ·  
  **g** / **gop\_size**
* ·  
  **bf** / **max\_b\_frames**
* ·  
  **profile**
  .Sp
  If not set, this will be determined automatically from the format of the input
  frames and the profiles supported by the driver.
* ·  
  **level**
* ·  
  **b** / **bit\_rate**
* ·  
  **maxrate** / **rc\_max\_rate**
* ·  
  **bufsize** / **rc\_buffer\_size**
* ·  
  **rc\_init\_occupancy** / **rc\_initial\_buffer\_occupancy**
* ·  
  **compression\_level**
  .Sp
  Speed / quality tradeoff: higher values are faster / worse quality.
* ·  
  **q** / **global\_quality**
  .Sp
  Size / quality tradeoff: higher values are smaller / worse quality.
* ·  
  **qmin**
* ·  
  **qmax**
* ·  
  **i\_qfactor** / **i\_quant\_factor**
* ·  
  **i\_qoffset** / **i\_quant\_offset**
* ·  
  **b\_qfactor** / **b\_quant\_factor**
* ·  
  **b\_qoffset** / **b\_quant\_offset**
* ·  
  **slices**

All encoders support the following options:

* ·  
  **low\_power**
  .Sp
  Some drivers/platforms offer a second encoder for some codecs intended to use
  less power than the default encoder; setting this option will attempt to use
  that encoder.  Note that it may support a reduced feature set, so some other
  options may not be available in this mode.

Each encoder also has its own specific options:

* **h264\_vaapi**  
  .IX Item "h264_vaapi"
  **profile** sets the value of _profile\_idc_ and the _constraint\_set*\_flag_s.
  **level** sets the value of _level\_idc_.
    * **coder**  
      .IX Item "coder"
      Set entropy encoder (default is _cabac_).  Possible values:
        * **ac**  
          .IX Item "ac"
        * **cabac**  
          .IX Item "cabac"
          Use \s-1CABAC.\s0
        * **vlc**  
          .IX Item "vlc"
        * **cavlc**  
          .IX Item "cavlc"
          Use \s-1CAVLC.\s0
    * **aud**  
      .IX Item "aud"
      Include access unit delimiters in the stream (not included by default).
    * **sei**  
      .IX Item "sei"
      Set \s-1SEI\s0 message types to include.
      Some combination of the following values:
        * **identifier**  
          .IX Item "identifier"
          Include a _user\_data\_unregistered_ message containing information about
          the encoder.
        * **timing**  
          .IX Item "timing"
          Include picture timing parameters (_buffering\_period_ and
          _pic\_timing_ messages).
        * **recovery\_point**  
          .IX Item "recovery_point"
          Include recovery points where appropriate (_recovery\_point_ messages).
* **hevc\_vaapi**  
  .IX Item "hevc_vaapi"
  **profile** and **level** set the values of
  _general\_profile\_idc_ and _general\_level\_idc_ respectively.
    * **aud**  
      .IX Item "aud"
      Include access unit delimiters in the stream (not included by default).
    * **tier**  
      .IX Item "tier"
      Set _general\_tier\_flag_.  This may affect the level chosen for the stream
      if it is not explicitly specified.
    * **sei**  
      .IX Item "sei"
      Set \s-1SEI\s0 message types to include.
      Some combination of the following values:
        * **hdr**  
          .IX Item "hdr"
          Include \s-1HDR\s0 metadata if the input frames have it
          (_mastering\_display\_colour\_volume_ and _content\_light\_level_
          messages).
* **mjpeg\_vaapi**  
  .IX Item "mjpeg_vaapi"
  Only baseline \s-1DCT\s0 encoding is supported.  The encoder always uses the standard
  quantisation and huffman tables - **global\_quality** scales the standard
  quantisation table (range 1-100).
  .Sp
  For \s-1YUV, 4:2:0, 4:2:2\s0 and 4:4:4 subsampling modes are supported.  \s-1RGB\s0 is also
  supported, and will create an \s-1RGB JPEG.\s0
    * **jfif**  
      .IX Item "jfif"
      Include \s-1JFIF\s0 header in each frame (not included by default).
    * **huffman**  
      .IX Item "huffman"
      Include standard huffman tables (on by default).  Turning this off will save
      a few hundred bytes in each output frame, but may lose compatibility with some
      \s-1JPEG\s0 decoders which don't fully handle \s-1MJPEG.\s0
* **mpeg2\_vaapi**  
  .IX Item "mpeg2_vaapi"
  **profile** and **level** set the value of _profile\_and\_level\_indication_.
* **vp8\_vaapi**  
  .IX Item "vp8_vaapi"
  B-frames are not supported.
  .Sp
  **global\_quality** sets the _q\_idx_ used for non-key frames (range 0-127).
    * **loop\_filter\_level**  
      .IX Item "loop_filter_level"
    * **loop\_filter\_sharpness**  
      .IX Item "loop_filter_sharpness"
      Manually set the loop filter parameters.
* **vp9\_vaapi**  
  .IX Item "vp9_vaapi"
  **global\_quality** sets the _q\_idx_ used for P-frames (range 0-255).
    * **loop\_filter\_level**  
      .IX Item "loop_filter_level"
    * **loop\_filter\_sharpness**  
      .IX Item "loop_filter_sharpness"
      Manually set the loop filter parameters.
      .Sp
      B-frames are supported, but the output stream is always in encode order rather than display
      order.  If B-frames are enabled, it may be necessary to use the **vp9\_raw\_reorder**
      bitstream filter to modify the output stream to display frames in the correct order.
      .Sp
      Only normal frames are produced - the **vp9\_superframe** bitstream filter may be
      required to produce a stream usable with all decoders.

<a name="vc2"></a>

### vc2

.IX Subsection "vc2"
\s-1SMPTE VC-2\s0 (previously \s-1BBC\s0 Dirac Pro). This codec was primarily aimed at
professional broadcasting but since it supports yuv420, yuv422 and yuv444 at
8 (limited range or full range), 10 or 12 bits, this makes it suitable for
other tasks which require low overhead and low compression (like screen
recording).

_Options_
.IX Subsection "Options"

* **b**  
  .IX Item "b"
  Sets target video bitrate. Usually that's around 1:6 of the uncompressed
  video bitrate (e.g. for 1920x1080 50fps yuv422p10 that's around 400Mbps). Higher
  values (close to the uncompressed bitrate) turn on lossless compression mode.
* **field\_order**  
  .IX Item "field_order"
  Enables field coding when set (e.g. to tt - top field first) for interlaced
  inputs. Should increase compression with interlaced content as it splits the
  fields and encodes each separately.
* **wavelet\_depth**  
  .IX Item "wavelet_depth"
  Sets the total amount of wavelet transforms to apply, between 1 and 5 (default).
  Lower values reduce compression and quality. Less capable decoders may not be
  able to handle values of **wavelet\_depth** over 3.
* **wavelet\_type**  
  .IX Item "wavelet_type"
  Sets the transform type. Currently only _5\_3_ (LeGall) and _9\_7_
  (Deslauriers-Dubuc)
  are implemented, with 9_7 being the one with better compression and thus
  is the default.
* **slice\_width**  
  .IX Item "slice_width"
* **slice\_height**  
  .IX Item "slice_height"
  Sets the slice size for each slice. Larger values result in better compression.
  For compatibility with other more limited decoders use **slice\_width** of
  32 and **slice\_height** of 8.
* **tolerance**  
  .IX Item "tolerance"
  Sets the undershoot tolerance of the rate control system in percent. This is
  to prevent an expensive search from being run.
* **qm**  
  .IX Item "qm"
  Sets the quantization matrix preset to use by default or when **wavelet\_depth**
  is set to 5
    * _default_
      Uses the default quantization matrix from the specifications, extended with
      values for the fifth level. This provides a good balance between keeping detail
      and omitting artifacts.
    * _flat_
      Use a completely zeroed out quantization matrix. This increases \s-1PSNR\s0 but might
      reduce perception. Use in bogus benchmarks.
    * _color_
      Reduces detail but attempts to preserve color at extremely low bitrates.

<a name="libxavs2"></a>

### libxavs2

.IX Subsection "libxavs2"
xavs2 \s-1AVS2-P2/IEEE1857.4\s0 encoder wrapper.

This encoder requires the presence of the libxavs2 headers and library
during configuration. You need to explicitly configure the build with
**--enable-libxavs2**.

_Options_
.IX Subsection "Options"

* **lcu\_row\_threads**  
  .IX Item "lcu_row_threads"
  Set the number of parallel threads for rows from 1 to 8 (default 5).
* **initial\_qp**  
  .IX Item "initial_qp"
  Set the xavs2 quantization parameter from 1 to 63 (default 34). This is
  used to set the initial qp for the first frame.
* **qp**  
  .IX Item "qp"
  Set the xavs2 quantization parameter from 1 to 63 (default 34). This is
  used to set the qp value under constant-QP mode.
* **max\_qp**  
  .IX Item "max_qp"
  Set the max qp for rate control from 1 to 63 (default 55).
* **min\_qp**  
  .IX Item "min_qp"
  Set the min qp for rate control from 1 to 63 (default 20).
* **speed\_level**  
  .IX Item "speed_level"
  Set the Speed level from 0 to 9 (default 0). Higher is better but slower.
* **log\_level**  
  .IX Item "log_level"
  Set the log level from -1 to 3 (default 0). -1: none, 0: error,
  1: warning, 2: info, 3: debug.
* **xavs2-params**  
  .IX Item "xavs2-params"
  Set xavs2 options using a list of _key_=_value_ couples separated
  by :\*(R".
  .Sp
  For example to specify libxavs2 encoding options with **-xavs2-params**:
  .Sp
  .Vb 1
          ffmpeg -i input -c:v libxavs2 -xavs2-params preset_level=5 output.avs2
  .Ve

<a name="subtitles-encoders"></a>

# Subtitles Encoders

.IX Header "SUBTITLES ENCODERS"

<a name="dvdsub"></a>

### dvdsub

.IX Subsection "dvdsub"
This codec encodes the bitmap subtitle format that is used in DVDs.
Typically they are stored in \s-1VOBSUB\s0 file pairs (*.idx + *.sub),
and they can also be used in Matroska files.

_Options_
.IX Subsection "Options"

* **even\_rows\_fix**  
  .IX Item "even_rows_fix"
  When set to 1, enable a work-around that makes the number of pixel rows
  even in all subtitles.  This fixes a problem with some players that
  cut off the bottom row if the number is odd.  The work-around just adds
  a fully transparent row if needed.  The overhead is low, typically
  one byte per subtitle on average.
  .Sp
  By default, this work-around is disabled.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ffmpeg**\|(1), **ffplay**\|(1), **ffprobe**\|(1), **libavcodec**\|(3)

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
