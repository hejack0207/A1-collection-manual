# ffmpeg-resampler(1)

 ,  

.if n .ad l
.nh

<a name="name"></a>

# Name

ffmpeg-resampler - FFmpeg Resampler

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The FFmpeg resampler provides a high-level interface to the
libswresample library audio resampling utilities. In particular it
allows one to perform audio resampling, audio channel layout rematrixing,
and convert audio format and packing layout.

<a name="resampler-options"></a>

# Resampler Options

.IX Header "RESAMPLER OPTIONS"
The audio resampler supports the following named options.

Options may be set by specifying -_option_ _value_ in the
FFmpeg tools, _option_=_value_ for the aresample filter,
by setting the value explicitly in the
\f(CW`SwrContext\*(C' options or using the _libavutil/opt.h_ \s-1API\s0 for
programmatic use.

* **ich, in\_channel\_count**  
  .IX Item "ich, in_channel_count"
  Set the number of input channels. Default value is 0. Setting this
  value is not mandatory if the corresponding channel layout
  **in\_channel\_layout** is set.
* **och, out\_channel\_count**  
  .IX Item "och, out_channel_count"
  Set the number of output channels. Default value is 0. Setting this
  value is not mandatory if the corresponding channel layout
  **out\_channel\_layout** is set.
* **uch, used\_channel\_count**  
  .IX Item "uch, used_channel_count"
  Set the number of used input channels. Default value is 0. This option is
  only used for special remapping.
* **isr, in\_sample\_rate**  
  .IX Item "isr, in_sample_rate"
  Set the input sample rate. Default value is 0.
* **osr, out\_sample\_rate**  
  .IX Item "osr, out_sample_rate"
  Set the output sample rate. Default value is 0.
* **isf, in\_sample\_fmt**  
  .IX Item "isf, in_sample_fmt"
  Specify the input sample format. It is set by default to \f(CW`none\*(C'.
* **osf, out\_sample\_fmt**  
  .IX Item "osf, out_sample_fmt"
  Specify the output sample format. It is set by default to \f(CW`none\*(C'.
* **tsf, internal\_sample\_fmt**  
  .IX Item "tsf, internal_sample_fmt"
  Set the internal sample format. Default value is \f(CW`none\*(C'.
  This will automatically be chosen when it is not explicitly set.
* **icl, in\_channel\_layout**  
  .IX Item "icl, in_channel_layout"
* **ocl, out\_channel\_layout**  
  .IX Item "ocl, out_channel_layout"
  Set the input/output channel layout.
  .Sp
  See **the Channel Layout section in the ffmpeg-utils\|(1) manual**
  for the required syntax.
* **clev, center\_mix\_level**  
  .IX Item "clev, center_mix_level"
  Set the center mix level. It is a value expressed in deciBel, and must be
  in the interval [-32,32].
* **slev, surround\_mix\_level**  
  .IX Item "slev, surround_mix_level"
  Set the surround mix level. It is a value expressed in deciBel, and must
  be in the interval [-32,32].
* **lfe\_mix\_level**  
  .IX Item "lfe_mix_level"
  Set \s-1LFE\s0 mix into non \s-1LFE\s0 level. It is used when there is a \s-1LFE\s0 input but no
  \s-1LFE\s0 output. It is a value expressed in deciBel, and must
  be in the interval [-32,32].
* **rmvol, rematrix\_volume**  
  .IX Item "rmvol, rematrix_volume"
  Set rematrix volume. Default value is 1.0.
* **rematrix\_maxval**  
  .IX Item "rematrix_maxval"
  Set maximum output value for rematrixing.
  This can be used to prevent clipping vs. preventing volume reduction.
  A value of 1.0 prevents clipping.
* **flags, swr\_flags**  
  .IX Item "flags, swr_flags"
  Set flags used by the converter. Default value is 0.
  .Sp
  It supports the following individual flags:
    * **res**  
      .IX Item "res"
      force resampling, this flag forces resampling to be used even when the
      input and output sample rates match.
* **dither\_scale**  
  .IX Item "dither_scale"
  Set the dither scale. Default value is 1.
* **dither\_method**  
  .IX Item "dither_method"
  Set dither method. Default value is 0.
  .Sp
  Supported values:
    * **rectangular**  
      .IX Item "rectangular"
      select rectangular dither
    * **triangular**  
      .IX Item "triangular"
      select triangular dither
    * **triangular\_hp**  
      .IX Item "triangular_hp"
      select triangular dither with high pass
    * **lipshitz**  
      .IX Item "lipshitz"
      select Lipshitz noise shaping dither.
    * **shibata**  
      .IX Item "shibata"
      select Shibata noise shaping dither.
    * **low\_shibata**  
      .IX Item "low_shibata"
      select low Shibata noise shaping dither.
    * **high\_shibata**  
      .IX Item "high_shibata"
      select high Shibata noise shaping dither.
    * **f\_weighted**  
      .IX Item "f_weighted"
      select f-weighted noise shaping dither
    * **modified\_e\_weighted**  
      .IX Item "modified_e_weighted"
      select modified-e-weighted noise shaping dither
    * **improved\_e\_weighted**  
      .IX Item "improved_e_weighted"
      select improved-e-weighted noise shaping dither
* **resampler**  
  .IX Item "resampler"
  Set resampling engine. Default value is swr.
  .Sp
  Supported values:
    * **swr**  
      .IX Item "swr"
      select the native \s-1SW\s0 Resampler; filter options precision and cheby are not
      applicable in this case.
    * **soxr**  
      .IX Item "soxr"
      select the SoX Resampler (where available); compensation, and filter options
      filter_size, phase_shift, exact_rational, filter_type & kaiser_beta, are not
      applicable in this case.
* **filter\_size**  
  .IX Item "filter_size"
  For swr only, set resampling filter size, default value is 32.
* **phase\_shift**  
  .IX Item "phase_shift"
  For swr only, set resampling phase shift, default value is 10, and must be in
  the interval [0,30].
* **linear\_interp**  
  .IX Item "linear_interp"
  Use linear interpolation when enabled (the default). Disable it if you want
  to preserve speed instead of quality when exact_rational fails.
* **exact\_rational**  
  .IX Item "exact_rational"
  For swr only, when enabled, try to use exact phase_count based on input and
  output sample rate. However, if it is larger than \f(CW`1 &lt;&lt; phase\_shift\*(C',
  the phase_count will be \f(CW`1 &lt;&lt; phase\_shift\*(C' as fallback. Default is enabled.
* **cutoff**  
  .IX Item "cutoff"
  Set cutoff frequency (swr: 6dB point; soxr: 0dB point) ratio; must be a float
  value between 0 and 1.  Default value is 0.97 with swr, and 0.91 with soxr
  (which, with a sample-rate of 44100, preserves the entire audio band to 20kHz).
* **precision**  
  .IX Item "precision"
  For soxr only, the precision in bits to which the resampled signal will be
  calculated.  The default value of 20 (which, with suitable dithering, is
  appropriate for a destination bit-depth of 16) gives SoX's 'High Quality'; a
  value of 28 gives SoX's 'Very High Quality'.
* **cheby**  
  .IX Item "cheby"
  For soxr only, selects passband rolloff none (Chebyshev) & higher-precision
  approximation for 'irrational' ratios. Default value is 0.
* **async**  
  .IX Item "async"
  For swr only, simple 1 parameter audio sync to timestamps using stretching,
  squeezing, filling and trimming. Setting this to 1 will enable filling and
  trimming, larger values represent the maximum amount in samples that the data
  may be stretched or squeezed for each second.
  Default value is 0, thus no compensation is applied to make the samples match
  the audio timestamps.
* **first\_pts**  
  .IX Item "first_pts"
  For swr only, assume the first pts should be this value. The time unit is 1 / sample rate.
  This allows for padding/trimming at the start of stream. By default, no
  assumption is made about the first frame's expected pts, so no padding or
  trimming is done. For example, this could be set to 0 to pad the beginning with
  silence if an audio stream starts after the video stream or to trim any samples
  with a negative pts due to encoder delay.
* **min\_comp**  
  .IX Item "min_comp"
  For swr only, set the minimum difference between timestamps and audio data (in
  seconds) to trigger stretching/squeezing/filling or trimming of the
  data to make it match the timestamps. The default is that
  stretching/squeezing/filling and trimming is disabled
  (**min\_comp** = \f(CW`FLT\_MAX\*(C').
* **min\_hard\_comp**  
  .IX Item "min_hard_comp"
  For swr only, set the minimum difference between timestamps and audio data (in
  seconds) to trigger adding/dropping samples to make it match the
  timestamps.  This option effectively is a threshold to select between
  hard (trim/fill) and soft (squeeze/stretch) compensation. Note that
  all compensation is by default disabled through **min\_comp**.
  The default is 0.1.
* **comp\_duration**  
  .IX Item "comp_duration"
  For swr only, set duration (in seconds) over which data is stretched/squeezed
  to make it match the timestamps. Must be a non-negative double float value,
  default value is 1.0.
* **max\_soft\_comp**  
  .IX Item "max_soft_comp"
  For swr only, set maximum factor by which data is stretched/squeezed to make it
  match the timestamps. Must be a non-negative double float value, default value
  is 0.
* **matrix\_encoding**  
  .IX Item "matrix_encoding"
  Select matrixed stereo encoding.
  .Sp
  It accepts the following values:
    * **none**  
      .IX Item "none"
      select none
    * **dolby**  
      .IX Item "dolby"
      select Dolby
    * **dplii**  
      .IX Item "dplii"
      select Dolby Pro Logic \s-1II\s0
      .Sp
      Default value is \f(CW`none\*(C'.
* **filter\_type**  
  .IX Item "filter_type"
  For swr only, select resampling filter type. This only affects resampling
  operations.
  .Sp
  It accepts the following values:
    * **cubic**  
      .IX Item "cubic"
      select cubic
    * **blackman\_nuttall**  
      .IX Item "blackman_nuttall"
      select Blackman Nuttall windowed sinc
    * **kaiser**  
      .IX Item "kaiser"
      select Kaiser windowed sinc
* **kaiser\_beta**  
  .IX Item "kaiser_beta"
  For swr only, set Kaiser window beta value. Must be a double float value in the
  interval [2,16], default value is 9.
* **output\_sample\_bits**  
  .IX Item "output_sample_bits"
  For swr only, set number of used output sample bits for dithering. Must be an integer in the
  interval [0,64], default value is 0, which means it's not used.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ffmpeg**\|(1), **ffplay**\|(1), **ffprobe**\|(1), **libswresample**\|(3)

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
