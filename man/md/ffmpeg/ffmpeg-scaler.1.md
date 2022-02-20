# ffmpeg-scaler(1)

 ,  

.if n .ad l
.nh

<a name="name"></a>

# Name

ffmpeg-scaler - FFmpeg video scaling and pixel format converter

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The FFmpeg rescaler provides a high-level interface to the libswscale
library image conversion utilities. In particular it allows one to perform
image rescaling and pixel format conversion.

<a name="scaler-options"></a>

# Scaler Options

.IX Header "SCALER OPTIONS"
The video scaler supports the following named options.

Options may be set by specifying -_option_ _value_ in the
FFmpeg tools. For programmatic use, they can be set explicitly in the
\f(CW`SwsContext\*(C' options or through the _libavutil/opt.h_ \s-1API.\s0

* **sws\_flags**  
  .IX Item "sws_flags"
  Set the scaler flags. This is also used to set the scaling
  algorithm. Only a single algorithm should be selected. Default
  value is **bicubic**.
  .Sp
  It accepts the following values:
    * **fast\_bilinear**  
      .IX Item "fast_bilinear"
      Select fast bilinear scaling algorithm.
    * **bilinear**  
      .IX Item "bilinear"
      Select bilinear scaling algorithm.
    * **bicubic**  
      .IX Item "bicubic"
      Select bicubic scaling algorithm.
    * **experimental**  
      .IX Item "experimental"
      Select experimental scaling algorithm.
    * **neighbor**  
      .IX Item "neighbor"
      Select nearest neighbor rescaling algorithm.
    * **area**  
      .IX Item "area"
      Select averaging area rescaling algorithm.
    * **bicublin**  
      .IX Item "bicublin"
      Select bicubic scaling algorithm for the luma component, bilinear for
      chroma components.
    * **gauss**  
      .IX Item "gauss"
      Select Gaussian rescaling algorithm.
    * **sinc**  
      .IX Item "sinc"
      Select sinc rescaling algorithm.
    * **lanczos**  
      .IX Item "lanczos"
      Select Lanczos rescaling algorithm.
    * **spline**  
      .IX Item "spline"
      Select natural bicubic spline rescaling algorithm.
    * **print\_info**  
      .IX Item "print_info"
      Enable printing/debug logging.
    * **accurate\_rnd**  
      .IX Item "accurate_rnd"
      Enable accurate rounding.
    * **full\_chroma\_int**  
      .IX Item "full_chroma_int"
      Enable full chroma interpolation.
    * **full\_chroma\_inp**  
      .IX Item "full_chroma_inp"
      Select full chroma input.
    * **bitexact**  
      .IX Item "bitexact"
      Enable bitexact output.
* **srcw**  
  .IX Item "srcw"
  Set source width.
* **srch**  
  .IX Item "srch"
  Set source height.
* **dstw**  
  .IX Item "dstw"
  Set destination width.
* **dsth**  
  .IX Item "dsth"
  Set destination height.
* **src\_format**  
  .IX Item "src_format"
  Set source pixel format (must be expressed as an integer).
* **dst\_format**  
  .IX Item "dst_format"
  Set destination pixel format (must be expressed as an integer).
* **src\_range**  
  .IX Item "src_range"
  Select source range.
* **dst\_range**  
  .IX Item "dst_range"
  Select destination range.
* **param0, param1**  
  .IX Item "param0, param1"
  Set scaling algorithm parameters. The specified values are specific of
  some scaling algorithms and ignored by others. The specified values
  are floating point number values.
* **sws\_dither**  
  .IX Item "sws_dither"
  Set the dithering algorithm. Accepts one of the following
  values. Default value is **auto**.
    * **auto**  
      .IX Item "auto"
      automatic choice
    * **none**  
      .IX Item "none"
      no dithering
    * **bayer**  
      .IX Item "bayer"
      bayer dither
    * **ed**  
      .IX Item "ed"
      error diffusion dither
    * **a\_dither**  
      .IX Item "a_dither"
      arithmetic dither, based using addition
    * **x\_dither**  
      .IX Item "x_dither"
      arithmetic dither, based using xor (more random/less apparent patterning that
      a_dither).
* **alphablend**  
  .IX Item "alphablend"
  Set the alpha blending to use when the input has alpha but the output does not.
  Default value is **none**.
    * **uniform\_color**  
      .IX Item "uniform_color"
      Blend onto a uniform background color
    * **checkerboard**  
      .IX Item "checkerboard"
      Blend onto a checkerboard
    * **none**  
      .IX Item "none"
      No blending

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ffmpeg**\|(1), **ffplay**\|(1), **ffprobe**\|(1), **libswscale**\|(3)

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
