# ffmpeg-utils(1)

 ,  

.if n .ad l
.nh

<a name="name"></a>

# Name

ffmpeg-utils - FFmpeg utilities

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
This document describes some generic features and utilities provided
by the libavutil library.

<a name="syntax"></a>

# Syntax

```
.IX Header "SYNTAX" This section documents the syntax and formats employed by the FFmpeg libraries and tools.
</synopsis>

<a name="quoting-and-escaping"></a>

### Quoting and escaping

<synopsis>
.IX Subsection "Quoting and escaping" FFmpeg adopts the following quoting and escaping mechanism, unless explicitly specified. The following rules are applied: .IP "·" 4 ' and \e are special characters (respectively used for quoting and escaping). In addition to them, there might be other special characters depending on the specific syntax where the escaping and quoting are employed. .IP "·" 4 A special character is escaped by prefixing it with a \e. .IP "·" 4 All characters enclosed between '' are included literally in the parsed string. The quote character ' itself cannot be quoted, so you may need to close the quote and escape it. .IP "·" 4 Leading and trailing whitespaces, unless escaped or quoted, are removed from the parsed string. 
 Note that you may need to add a second level of escaping when using the command line or a script, which depends on the syntax of the adopted shell language. 
 The function \f(CW`av_get_token\*(C' defined in libavutil/avstring.h can be used to parse a token quoted or escaped according to the rules defined above. 
 The tool tools/ffescape in the FFmpeg source tree can be used to automatically quote or escape a string in a script. 
 Examples .IX Subsection "Examples" .IP "·" 4 Escape the string \f(CW`Crime d\*(AqAmour\*(C' containing the \f(CW\*(C\`\*(Aq\*(C' special character: .Sp .Vb 1         Crime d\eAmour .Ve .IP "·" 4 The string above contains a quote, so the \f(CW`\*(Aq\*(C' needs to be escaped when quoting it: .Sp .Vb 1         Crime d\*(Aq\e\*(Aq\*(AqAmour\*(Aq .Ve .IP "·" 4 Include leading or trailing whitespaces using quoting: .Sp .Vb 1           this string starts and ends with whitespaces  \*(Aq .Ve .IP "·" 4 Escaping and quoting can be mixed together: .Sp .Vb 1          The string \*(Aq\e\*(Aqstring\e\*(Aq\*(Aq is a string \*(Aq .Ve .IP "·" 4 To include a literal \e you can use either escaping or quoting: .Sp .Vb 1         c:\efoo\*(Aq can be written as c:\e\efoo .Ve
</synopsis>

<a name="date"></a>

### Date

<synopsis>
.IX Subsection "Date" The accepted syntax is: 
 .Vb 2         [(YYYY-MM-DD|YYYYMMDD)[T|t| ]]((HH:MM:SS[.m...]]])|(HHMMSS[.m...]]]))[Z]         now .Ve 
 If the value is now\*(R" it takes the current time. 
 Time is local time unless Z is appended, in which case it is interpreted as \s-1UTC.\s0 If the year-month-day part is not specified it takes the current year-month-day.
</synopsis>

<a name="time-duration"></a>

### Time duration

<synopsis>
.IX Subsection "Time duration" There are two accepted syntaxes for expressing time duration. 
 .Vb 1         [-][<HH>:]<MM>:<SS>[.<m>...] .Ve 
 \s-1HH\s0 expresses the number of hours, \s-1MM\s0 the number of minutes for a maximum of 2 digits, and \s-1SS\s0 the number of seconds for a maximum of 2 digits. The m at the end expresses decimal value for \s-1SS\s0. 
 or 
 .Vb 1         [-]<S>+[.<m>...] .Ve 
 S expresses the number of seconds, with the optional decimal part m. 
 In both expressions, the optional - indicates negative duration. 
 Examples .IX Subsection "Examples" 
 The following examples are all valid time duration: .IP "55" 4 .IX Item "55" 55 seconds .IP "12:03:45" 4 .IX Item "12:03:45" 12 hours, 03 minutes and 45 seconds .IP "23.189" 4 .IX Item "23.189" 23.189 seconds
</synopsis>

<a name="video-size"></a>

### Video size

<synopsis>
.IX Subsection "Video size" Specify the size of the sourced video, it may be a string of the form widthxheight, or the name of a size abbreviation. 
 The following abbreviations are recognized: .IP "ntsc" 4 .IX Item "ntsc" 720x480 .IP "pal" 4 .IX Item "pal" 720x576 .IP "qntsc" 4 .IX Item "qntsc" 352x240 .IP "qpal" 4 .IX Item "qpal" 352x288 .IP "sntsc" 4 .IX Item "sntsc" 640x480 .IP "spal" 4 .IX Item "spal" 768x576 .IP "film" 4 .IX Item "film" 352x240 .IP "ntsc-film" 4 .IX Item "ntsc-film" 352x240 .IP "sqcif" 4 .IX Item "sqcif" 128x96 .IP "qcif" 4 .IX Item "qcif" 176x144 .IP "cif" 4 .IX Item "cif" 352x288 .IP "4cif" 4 .IX Item "4cif" 704x576 .IP "16cif" 4 .IX Item "16cif" 1408x1152 .IP "qqvga" 4 .IX Item "qqvga" 160x120 .IP "qvga" 4 .IX Item "qvga" 320x240 .IP "vga" 4 .IX Item "vga" 640x480 .IP "svga" 4 .IX Item "svga" 800x600 .IP "xga" 4 .IX Item "xga" 1024x768 .IP "uxga" 4 .IX Item "uxga" 1600x1200 .IP "qxga" 4 .IX Item "qxga" 2048x1536 .IP "sxga" 4 .IX Item "sxga" 1280x1024 .IP "qsxga" 4 .IX Item "qsxga" 2560x2048 .IP "hsxga" 4 .IX Item "hsxga" 5120x4096 .IP "wvga" 4 .IX Item "wvga" 852x480 .IP "wxga" 4 .IX Item "wxga" 1366x768 .IP "wsxga" 4 .IX Item "wsxga" 1600x1024 .IP "wuxga" 4 .IX Item "wuxga" 1920x1200 .IP "woxga" 4 .IX Item "woxga" 2560x1600 .IP "wqsxga" 4 .IX Item "wqsxga" 3200x2048 .IP "wquxga" 4 .IX Item "wquxga" 3840x2400 .IP "whsxga" 4 .IX Item "whsxga" 6400x4096 .IP "whuxga" 4 .IX Item "whuxga" 7680x4800 .IP "cga" 4 .IX Item "cga" 320x200 .IP "ega" 4 .IX Item "ega" 640x350 .IP "hd480" 4 .IX Item "hd480" 852x480 .IP "hd720" 4 .IX Item "hd720" 1280x720 .IP "hd1080" 4 .IX Item "hd1080" 1920x1080 .IP "2k" 4 .IX Item "2k" 2048x1080 .IP "2kflat" 4 .IX Item "2kflat" 1998x1080 .IP "2kscope" 4 .IX Item "2kscope" 2048x858 .IP "4k" 4 .IX Item "4k" 4096x2160 .IP "4kflat" 4 .IX Item "4kflat" 3996x2160 .IP "4kscope" 4 .IX Item "4kscope" 4096x1716 .IP "nhd" 4 .IX Item "nhd" 640x360 .IP "hqvga" 4 .IX Item "hqvga" 240x160 .IP "wqvga" 4 .IX Item "wqvga" 400x240 .IP "fwqvga" 4 .IX Item "fwqvga" 432x240 .IP "hvga" 4 .IX Item "hvga" 480x320 .IP "qhd" 4 .IX Item "qhd" 960x540 .IP "2kdci" 4 .IX Item "2kdci" 2048x1080 .IP "4kdci" 4 .IX Item "4kdci" 4096x2160 .IP "uhd2160" 4 .IX Item "uhd2160" 3840x2160 .IP "uhd4320" 4 .IX Item "uhd4320" 7680x4320
</synopsis>

<a name="video-rate"></a>

### Video rate

<synopsis>
.IX Subsection "Video rate" Specify the frame rate of a video, expressed as the number of frames generated per second. It has to be a string in the format frame_rate_num/frame_rate_den, an integer number, a float number or a valid video frame rate abbreviation. 
 The following abbreviations are recognized: .IP "ntsc" 4 .IX Item "ntsc" 30000/1001 .IP "pal" 4 .IX Item "pal" 25/1 .IP "qntsc" 4 .IX Item "qntsc" 30000/1001 .IP "qpal" 4 .IX Item "qpal" 25/1 .IP "sntsc" 4 .IX Item "sntsc" 30000/1001 .IP "spal" 4 .IX Item "spal" 25/1 .IP "film" 4 .IX Item "film" 24/1 .IP "ntsc-film" 4 .IX Item "ntsc-film" 24000/1001
</synopsis>

<a name="ratio"></a>

### Ratio

<synopsis>
.IX Subsection "Ratio" A ratio can be expressed as an expression, or in the form numerator:denominator. 
 Note that a ratio with infinite (1/0) or negative value is considered valid, so you should check on the returned value if you want to exclude those values. 
 The undefined value can be expressed using the 0:0\*(R" string.
</synopsis>

<a name="color"></a>

### Color

<synopsis>
.IX Subsection "Color" It can be the name of a color as defined below (case insensitive match) or a \f(CW`[0x|#]RRGGBB[AA]\*(C' sequence, possibly followed by @ and a string representing the alpha component. 
 The alpha component may be a string composed by 0x\*(R" followed by an hexadecimal number or a decimal number between 0.0 and 1.0, which represents the opacity value (0x00 or 0.0 means completely transparent, 0xff or 1.0 completely opaque). If the alpha component is not specified then 0xff is assumed. 
 The string random will result in a random color. 
 The following names of colors are recognized: .IP "AliceBlue" 4 .IX Item "AliceBlue" 0xF0F8FF .IP "AntiqueWhite" 4 .IX Item "AntiqueWhite" 0xFAEBD7 .IP "Aqua" 4 .IX Item "Aqua" 0x00FFFF .IP "Aquamarine" 4 .IX Item "Aquamarine" 0x7FFFD4 .IP "Azure" 4 .IX Item "Azure" 0xF0FFFF .IP "Beige" 4 .IX Item "Beige" 0xF5F5DC .IP "Bisque" 4 .IX Item "Bisque" 0xFFE4C4 .IP "Black" 4 .IX Item "Black" 0x000000 .IP "BlanchedAlmond" 4 .IX Item "BlanchedAlmond" 0xFFEBCD .IP "Blue" 4 .IX Item "Blue" 0x0000FF .IP "BlueViolet" 4 .IX Item "BlueViolet" 0x8A2BE2 .IP "Brown" 4 .IX Item "Brown" 0xA52A2A .IP "BurlyWood" 4 .IX Item "BurlyWood" 0xDEB887 .IP "CadetBlue" 4 .IX Item "CadetBlue" 0x5F9EA0 .IP "Chartreuse" 4 .IX Item "Chartreuse" 0x7FFF00 .IP "Chocolate" 4 .IX Item "Chocolate" 0xD2691E .IP "Coral" 4 .IX Item "Coral" 0xFF7F50 .IP "CornflowerBlue" 4 .IX Item "CornflowerBlue" 0x6495ED .IP "Cornsilk" 4 .IX Item "Cornsilk" 0xFFF8DC .IP "Crimson" 4 .IX Item "Crimson" 0xDC143C .IP "Cyan" 4 .IX Item "Cyan" 0x00FFFF .IP "DarkBlue" 4 .IX Item "DarkBlue" 0x00008B .IP "DarkCyan" 4 .IX Item "DarkCyan" 0x008B8B .IP "DarkGoldenRod" 4 .IX Item "DarkGoldenRod" 0xB8860B .IP "DarkGray" 4 .IX Item "DarkGray" 0xA9A9A9 .IP "DarkGreen" 4 .IX Item "DarkGreen" 0x006400 .IP "DarkKhaki" 4 .IX Item "DarkKhaki" 0xBDB76B .IP "DarkMagenta" 4 .IX Item "DarkMagenta" 0x8B008B .IP "DarkOliveGreen" 4 .IX Item "DarkOliveGreen" 0x556B2F .IP "Darkorange" 4 .IX Item "Darkorange" 0xFF8C00 .IP "DarkOrchid" 4 .IX Item "DarkOrchid" 0x9932CC .IP "DarkRed" 4 .IX Item "DarkRed" 0x8B0000 .IP "DarkSalmon" 4 .IX Item "DarkSalmon" 0xE9967A .IP "DarkSeaGreen" 4 .IX Item "DarkSeaGreen" 0x8FBC8F .IP "DarkSlateBlue" 4 .IX Item "DarkSlateBlue" 0x483D8B .IP "DarkSlateGray" 4 .IX Item "DarkSlateGray" 0x2F4F4F .IP "DarkTurquoise" 4 .IX Item "DarkTurquoise" 0x00CED1 .IP "DarkViolet" 4 .IX Item "DarkViolet" 0x9400D3 .IP "DeepPink" 4 .IX Item "DeepPink" 0xFF1493 .IP "DeepSkyBlue" 4 .IX Item "DeepSkyBlue" 0x00BFFF .IP "DimGray" 4 .IX Item "DimGray" 0x696969 .IP "DodgerBlue" 4 .IX Item "DodgerBlue" 0x1E90FF .IP "FireBrick" 4 .IX Item "FireBrick" 0xB22222 .IP "FloralWhite" 4 .IX Item "FloralWhite" 0xFFFAF0 .IP "ForestGreen" 4 .IX Item "ForestGreen" 0x228B22 .IP "Fuchsia" 4 .IX Item "Fuchsia" 0xFF00FF .IP "Gainsboro" 4 .IX Item "Gainsboro" 0xDCDCDC .IP "GhostWhite" 4 .IX Item "GhostWhite" 0xF8F8FF .IP "Gold" 4 .IX Item "Gold" 0xFFD700 .IP "GoldenRod" 4 .IX Item "GoldenRod" 0xDAA520 .IP "Gray" 4 .IX Item "Gray" 0x808080 .IP "Green" 4 .IX Item "Green" 0x008000 .IP "GreenYellow" 4 .IX Item "GreenYellow" 0xADFF2F .IP "HoneyDew" 4 .IX Item "HoneyDew" 0xF0FFF0 .IP "HotPink" 4 .IX Item "HotPink" 0xFF69B4 .IP "IndianRed" 4 .IX Item "IndianRed" 0xCD5C5C .IP "Indigo" 4 .IX Item "Indigo" 0x4B0082 .IP "Ivory" 4 .IX Item "Ivory" 0xFFFFF0 .IP "Khaki" 4 .IX Item "Khaki" 0xF0E68C .IP "Lavender" 4 .IX Item "Lavender" 0xE6E6FA .IP "LavenderBlush" 4 .IX Item "LavenderBlush" 0xFFF0F5 .IP "LawnGreen" 4 .IX Item "LawnGreen" 0x7CFC00 .IP "LemonChiffon" 4 .IX Item "LemonChiffon" 0xFFFACD .IP "LightBlue" 4 .IX Item "LightBlue" 0xADD8E6 .IP "LightCoral" 4 .IX Item "LightCoral" 0xF08080 .IP "LightCyan" 4 .IX Item "LightCyan" 0xE0FFFF .IP "LightGoldenRodYellow" 4 .IX Item "LightGoldenRodYellow" 0xFAFAD2 .IP "LightGreen" 4 .IX Item "LightGreen" 0x90EE90 .IP "LightGrey" 4 .IX Item "LightGrey" 0xD3D3D3 .IP "LightPink" 4 .IX Item "LightPink" 0xFFB6C1 .IP "LightSalmon" 4 .IX Item "LightSalmon" 0xFFA07A .IP "LightSeaGreen" 4 .IX Item "LightSeaGreen" 0x20B2AA .IP "LightSkyBlue" 4 .IX Item "LightSkyBlue" 0x87CEFA .IP "LightSlateGray" 4 .IX Item "LightSlateGray" 0x778899 .IP "LightSteelBlue" 4 .IX Item "LightSteelBlue" 0xB0C4DE .IP "LightYellow" 4 .IX Item "LightYellow" 0xFFFFE0 .IP "Lime" 4 .IX Item "Lime" 0x00FF00 .IP "LimeGreen" 4 .IX Item "LimeGreen" 0x32CD32 .IP "Linen" 4 .IX Item "Linen" 0xFAF0E6 .IP "Magenta" 4 .IX Item "Magenta" 0xFF00FF .IP "Maroon" 4 .IX Item "Maroon" 0x800000 .IP "MediumAquaMarine" 4 .IX Item "MediumAquaMarine" 0x66CDAA .IP "MediumBlue" 4 .IX Item "MediumBlue" 0x0000CD .IP "MediumOrchid" 4 .IX Item "MediumOrchid" 0xBA55D3 .IP "MediumPurple" 4 .IX Item "MediumPurple" 0x9370D8 .IP "MediumSeaGreen" 4 .IX Item "MediumSeaGreen" 0x3CB371 .IP "MediumSlateBlue" 4 .IX Item "MediumSlateBlue" 0x7B68EE .IP "MediumSpringGreen" 4 .IX Item "MediumSpringGreen" 0x00FA9A .IP "MediumTurquoise" 4 .IX Item "MediumTurquoise" 0x48D1CC .IP "MediumVioletRed" 4 .IX Item "MediumVioletRed" 0xC71585 .IP "MidnightBlue" 4 .IX Item "MidnightBlue" 0x191970 .IP "MintCream" 4 .IX Item "MintCream" 0xF5FFFA .IP "MistyRose" 4 .IX Item "MistyRose" 0xFFE4E1 .IP "Moccasin" 4 .IX Item "Moccasin" 0xFFE4B5 .IP "NavajoWhite" 4 .IX Item "NavajoWhite" 0xFFDEAD .IP "Navy" 4 .IX Item "Navy" 0x000080 .IP "OldLace" 4 .IX Item "OldLace" 0xFDF5E6 .IP "Olive" 4 .IX Item "Olive" 0x808000 .IP "OliveDrab" 4 .IX Item "OliveDrab" 0x6B8E23 .IP "Orange" 4 .IX Item "Orange" 0xFFA500 .IP "OrangeRed" 4 .IX Item "OrangeRed" 0xFF4500 .IP "Orchid" 4 .IX Item "Orchid" 0xDA70D6 .IP "PaleGoldenRod" 4 .IX Item "PaleGoldenRod" 0xEEE8AA .IP "PaleGreen" 4 .IX Item "PaleGreen" 0x98FB98 .IP "PaleTurquoise" 4 .IX Item "PaleTurquoise" 0xAFEEEE .IP "PaleVioletRed" 4 .IX Item "PaleVioletRed" 0xD87093 .IP "PapayaWhip" 4 .IX Item "PapayaWhip" 0xFFEFD5 .IP "PeachPuff" 4 .IX Item "PeachPuff" 0xFFDAB9 .IP "Peru" 4 .IX Item "Peru" 0xCD853F .IP "Pink" 4 .IX Item "Pink" 0xFFC0CB .IP "Plum" 4 .IX Item "Plum" 0xDDA0DD .IP "PowderBlue" 4 .IX Item "PowderBlue" 0xB0E0E6 .IP "Purple" 4 .IX Item "Purple" 0x800080 .IP "Red" 4 .IX Item "Red" 0xFF0000 .IP "RosyBrown" 4 .IX Item "RosyBrown" 0xBC8F8F .IP "RoyalBlue" 4 .IX Item "RoyalBlue" 0x4169E1 .IP "SaddleBrown" 4 .IX Item "SaddleBrown" 0x8B4513 .IP "Salmon" 4 .IX Item "Salmon" 0xFA8072 .IP "SandyBrown" 4 .IX Item "SandyBrown" 0xF4A460 .IP "SeaGreen" 4 .IX Item "SeaGreen" 0x2E8B57 .IP "SeaShell" 4 .IX Item "SeaShell" 0xFFF5EE .IP "Sienna" 4 .IX Item "Sienna" 0xA0522D .IP "Silver" 4 .IX Item "Silver" 0xC0C0C0 .IP "SkyBlue" 4 .IX Item "SkyBlue" 0x87CEEB .IP "SlateBlue" 4 .IX Item "SlateBlue" 0x6A5ACD .IP "SlateGray" 4 .IX Item "SlateGray" 0x708090 .IP "Snow" 4 .IX Item "Snow" 0xFFFAFA .IP "SpringGreen" 4 .IX Item "SpringGreen" 0x00FF7F .IP "SteelBlue" 4 .IX Item "SteelBlue" 0x4682B4 .IP "Tan" 4 .IX Item "Tan" 0xD2B48C .IP "Teal" 4 .IX Item "Teal" 0x008080 .IP "Thistle" 4 .IX Item "Thistle" 0xD8BFD8 .IP "Tomato" 4 .IX Item "Tomato" 0xFF6347 .IP "Turquoise" 4 .IX Item "Turquoise" 0x40E0D0 .IP "Violet" 4 .IX Item "Violet" 0xEE82EE .IP "Wheat" 4 .IX Item "Wheat" 0xF5DEB3 .IP "White" 4 .IX Item "White" 0xFFFFFF .IP "WhiteSmoke" 4 .IX Item "WhiteSmoke" 0xF5F5F5 .IP "Yellow" 4 .IX Item "Yellow" 0xFFFF00 .IP "YellowGreen" 4 .IX Item "YellowGreen" 0x9ACD32
</synopsis>

<a name="channel-layout"></a>

### Channel Layout

<synopsis>
.IX Subsection "Channel Layout" A channel layout specifies the spatial disposition of the channels in a multi-channel audio stream. To specify a channel layout, FFmpeg makes use of a special syntax. 
 Individual channels are identified by an id, as given by the table below: .IP "\s-1FL\s0" 4 .IX Item "FL" front left .IP "\s-1FR\s0" 4 .IX Item "FR" front right .IP "\s-1FC\s0" 4 .IX Item "FC" front center .IP "\s-1LFE\s0" 4 .IX Item "LFE" low frequency .IP "\s-1BL\s0" 4 .IX Item "BL" back left .IP "\s-1BR\s0" 4 .IX Item "BR" back right .IP "\s-1FLC\s0" 4 .IX Item "FLC" front left-of-center .IP "\s-1FRC\s0" 4 .IX Item "FRC" front right-of-center .IP "\s-1BC\s0" 4 .IX Item "BC" back center .IP "\s-1SL\s0" 4 .IX Item "SL" side left .IP "\s-1SR\s0" 4 .IX Item "SR" side right .IP "\s-1TC\s0" 4 .IX Item "TC" top center .IP "\s-1TFL\s0" 4 .IX Item "TFL" top front left .IP "\s-1TFC\s0" 4 .IX Item "TFC" top front center .IP "\s-1TFR\s0" 4 .IX Item "TFR" top front right .IP "\s-1TBL\s0" 4 .IX Item "TBL" top back left .IP "\s-1TBC\s0" 4 .IX Item "TBC" top back center .IP "\s-1TBR\s0" 4 .IX Item "TBR" top back right .IP "\s-1DL\s0" 4 .IX Item "DL" downmix left .IP "\s-1DR\s0" 4 .IX Item "DR" downmix right .IP "\s-1WL\s0" 4 .IX Item "WL" wide left .IP "\s-1WR\s0" 4 .IX Item "WR" wide right .IP "\s-1SDL\s0" 4 .IX Item "SDL" surround direct left .IP "\s-1SDR\s0" 4 .IX Item "SDR" surround direct right .IP "\s-1LFE2\s0" 4 .IX Item "LFE2" low frequency 2 
 Standard channel layout compositions can be specified by using the following identifiers: .IP "mono" 4 .IX Item "mono" \s-1FC\s0 .IP "stereo" 4 .IX Item "stereo" \s-1FL+FR\s0 .IP "2.1" 4 .IX Item "2.1" \s-1FL+FR+LFE\s0 .IP "3.0" 4 .IX Item "3.0" \s-1FL+FR+FC\s0 .IP "3.0(back)" 4 .IX Item "3.0(back)" \s-1FL+FR+BC\s0 .IP "4.0" 4 .IX Item "4.0" \s-1FL+FR+FC+BC\s0 .IP "quad" 4 .IX Item "quad" \s-1FL+FR+BL+BR\s0 .IP "quad(side)" 4 .IX Item "quad(side)" \s-1FL+FR+SL+SR\s0 .IP "3.1" 4 .IX Item "3.1" \s-1FL+FR+FC+LFE\s0 .IP "5.0" 4 .IX Item "5.0" \s-1FL+FR+FC+BL+BR\s0 .IP "5.0(side)" 4 .IX Item "5.0(side)" \s-1FL+FR+FC+SL+SR\s0 .IP "4.1" 4 .IX Item "4.1" \s-1FL+FR+FC+LFE+BC\s0 .IP "5.1" 4 .IX Item "5.1" \s-1FL+FR+FC+LFE+BL+BR\s0 .IP "5.1(side)" 4 .IX Item "5.1(side)" \s-1FL+FR+FC+LFE+SL+SR\s0 .IP "6.0" 4 .IX Item "6.0" \s-1FL+FR+FC+BC+SL+SR\s0 .IP "6.0(front)" 4 .IX Item "6.0(front)" \s-1FL+FR+FLC+FRC+SL+SR\s0 .IP "hexagonal" 4 .IX Item "hexagonal" \s-1FL+FR+FC+BL+BR+BC\s0 .IP "6.1" 4 .IX Item "6.1" \s-1FL+FR+FC+LFE+BC+SL+SR\s0 .IP "6.1" 4 .IX Item "6.1" \s-1FL+FR+FC+LFE+BL+BR+BC\s0 .IP "6.1(front)" 4 .IX Item "6.1(front)" \s-1FL+FR+LFE+FLC+FRC+SL+SR\s0 .IP "7.0" 4 .IX Item "7.0" \s-1FL+FR+FC+BL+BR+SL+SR\s0 .IP "7.0(front)" 4 .IX Item "7.0(front)" \s-1FL+FR+FC+FLC+FRC+SL+SR\s0 .IP "7.1" 4 .IX Item "7.1" \s-1FL+FR+FC+LFE+BL+BR+SL+SR\s0 .IP "7.1(wide)" 4 .IX Item "7.1(wide)" \s-1FL+FR+FC+LFE+BL+BR+FLC+FRC\s0 .IP "7.1(wide-side)" 4 .IX Item "7.1(wide-side)" \s-1FL+FR+FC+LFE+FLC+FRC+SL+SR\s0 .IP "octagonal" 4 .IX Item "octagonal" \s-1FL+FR+FC+BL+BR+BC+SL+SR\s0 .IP "downmix" 4 .IX Item "downmix" \s-1DL+DR\s0 
 A custom channel layout can be specified as a sequence of terms, separated by '+' or '|'. Each term can be: .IP "·" 4 the name of a standard channel layout (e.g. mono, stereo, 4.0, quad, 5.0, etc.) .IP "·" 4 the name of a single channel (e.g. \s-1FL\s0, \s-1FR\s0, \s-1FC\s0, \s-1LFE\s0, etc.) .IP "·" 4 a number of channels, in decimal, followed by 'c', yielding the default channel layout for that number of channels (see the function \f(CW`av_get_default_channel_layout\*(C'). Note that not all channel counts have a default layout. .IP "·" 4 a number of channels, in decimal, followed by 'C', yielding an unknown channel layout with the specified number of channels. Note that not all channel layout specification strings support unknown channel layouts. .IP "·" 4 a channel layout mask, in hexadecimal starting with 0x\*(R" (see the \f(CW`AV_CH_*\*(C' macros in libavutil/channel_layout.h. 
 Before libavutil version 53 the trailing character c\*(R" to specify a number of channels was optional, but now it is required, while a channel layout mask can also be specified as a decimal number (if and only if not followed by c\*(R" or \*(L"C\*(R"). 
 See also the function \f(CW`av_get_channel_layout\*(C' defined in libavutil/channel_layout.h.
```

<a name="expression-evaluation"></a>

# Expression Evaluation

.IX Header "EXPRESSION EVALUATION"
When evaluating an arithmetic expression, FFmpeg uses an internal
formula evaluator, implemented through the _libavutil/eval.h_
interface.

An expression may contain unary, binary operators, constants, and
functions.

Two expressions _expr1_ and _expr2_ can be combined to form
another expression "_expr1_;_expr2_".
_expr1_ and _expr2_ are evaluated in turn, and the new
expression evaluates to the value of _expr2_.

The following binary operators are available: \f(CW`+\*(C', \f(CW\*(C\`-\*(C',
\f(CW`*\*(C', \f(CW\*(C\`/\*(C', \f(CW\*(C\`^\*(C'.

The following unary operators are available: \f(CW`+\*(C', \f(CW\*(C\`-\*(C'.

The following functions are available:

* **abs(x)**  
  .IX Item "abs(x)"
  Compute absolute value of _x_.
* **acos(x)**  
  .IX Item "acos(x)"
  Compute arccosine of _x_.
* **asin(x)**  
  .IX Item "asin(x)"
  Compute arcsine of _x_.
* **atan(x)**  
  .IX Item "atan(x)"
  Compute arctangent of _x_.
* **atan2(x, y)**  
  .IX Item "atan2(x, y)"
  Compute principal value of the arc tangent of _y_/_x_.
* **between(x, min, max)**  
  .IX Item "between(x, min, max)"
  Return 1 if _x_ is greater than or equal to _min_ and lesser than or
  equal to _max_, 0 otherwise.
* **bitand(x, y)**  
  .IX Item "bitand(x, y)"
* **bitor(x, y)**  
  .IX Item "bitor(x, y)"
  Compute bitwise and/or operation on _x_ and _y_.
  .Sp
  The results of the evaluation of _x_ and _y_ are converted to
  integers before executing the bitwise operation.
  .Sp
  Note that both the conversion to integer and the conversion back to
  floating point can lose precision. Beware of unexpected results for
  large numbers (usually 2^53 and larger).
* **ceil(expr)**  
  .IX Item "ceil(expr)"
  Round the value of expression _expr_ upwards to the nearest
  integer. For example, ceil(1.5)\*(R" is \*(L"2.0\*(R".
* **clip(x, min, max)**  
  .IX Item "clip(x, min, max)"
  Return the value of _x_ clipped between _min_ and _max_.
* **cos(x)**  
  .IX Item "cos(x)"
  Compute cosine of _x_.
* **cosh(x)**  
  .IX Item "cosh(x)"
  Compute hyperbolic cosine of _x_.
* **eq(x, y)**  
  .IX Item "eq(x, y)"
  Return 1 if _x_ and _y_ are equivalent, 0 otherwise.
* **exp(x)**  
  .IX Item "exp(x)"
  Compute exponential of _x_ (with base \f(CW`e\*(C', the Euler's number).
* **floor(expr)**  
  .IX Item "floor(expr)"
  Round the value of expression _expr_ downwards to the nearest
  integer. For example, floor(-1.5)\*(R" is \*(L"-2.0\*(R".
* **gauss(x)**  
  .IX Item "gauss(x)"
  Compute Gauss function of _x_, corresponding to
  \f(CW`exp(-x*x/2) / sqrt(2*PI)\*(C'.
* **gcd(x, y)**  
  .IX Item "gcd(x, y)"
  Return the greatest common divisor of _x_ and _y_. If both _x_ and
  _y_ are 0 or either or both are less than zero then behavior is undefined.
* **gt(x, y)**  
  .IX Item "gt(x, y)"
  Return 1 if _x_ is greater than _y_, 0 otherwise.
* **gte(x, y)**  
  .IX Item "gte(x, y)"
  Return 1 if _x_ is greater than or equal to _y_, 0 otherwise.
* **hypot(x, y)**  
  .IX Item "hypot(x, y)"
  This function is similar to the C function with the same name; it returns
  "sqrt(_x_*_x_ + _y_*_y_)", the length of the hypotenuse of a
  right triangle with sides of length _x_ and _y_, or the distance of the
  point (_x_, _y_) from the origin.
* **if(x, y)**  
  .IX Item "if(x, y)"
  Evaluate _x_, and if the result is non-zero return the result of
  the evaluation of _y_, return 0 otherwise.
* **if(x, y, z)**  
  .IX Item "if(x, y, z)"
  Evaluate _x_, and if the result is non-zero return the evaluation
  result of _y_, otherwise the evaluation result of _z_.
* **ifnot(x, y)**  
  .IX Item "ifnot(x, y)"
  Evaluate _x_, and if the result is zero return the result of the
  evaluation of _y_, return 0 otherwise.
* **ifnot(x, y, z)**  
  .IX Item "ifnot(x, y, z)"
  Evaluate _x_, and if the result is zero return the evaluation
  result of _y_, otherwise the evaluation result of _z_.
* **isinf(x)**  
  .IX Item "isinf(x)"
  Return 1.0 if _x_ is +/-INFINITY, 0.0 otherwise.
* **isnan(x)**  
  .IX Item "isnan(x)"
  Return 1.0 if _x_ is \s-1NAN, 0.0\s0 otherwise.
* **ld(var)**  
  .IX Item "ld(var)"
  Load the value of the internal variable with number
  _var_, which was previously stored with st(_var_, _expr_).
  The function returns the loaded value.
* **lerp(x, y, z)**  
  .IX Item "lerp(x, y, z)"
  Return linear interpolation between _x_ and _y_ by amount of _z_.
* **log(x)**  
  .IX Item "log(x)"
  Compute natural logarithm of _x_.
* **lt(x, y)**  
  .IX Item "lt(x, y)"
  Return 1 if _x_ is lesser than _y_, 0 otherwise.
* **lte(x, y)**  
  .IX Item "lte(x, y)"
  Return 1 if _x_ is lesser than or equal to _y_, 0 otherwise.
* **max(x, y)**  
  .IX Item "max(x, y)"
  Return the maximum between _x_ and _y_.
* **min(x, y)**  
  .IX Item "min(x, y)"
  Return the minimum between _x_ and _y_.
* **mod(x, y)**  
  .IX Item "mod(x, y)"
  Compute the remainder of division of _x_ by _y_.
* **not(expr)**  
  .IX Item "not(expr)"
  Return 1.0 if _expr_ is zero, 0.0 otherwise.
* **pow(x, y)**  
  .IX Item "pow(x, y)"
  Compute the power of _x_ elevated _y_, it is equivalent to
  "(_x_)^(_y_)".
* **print(t)**  
  .IX Item "print(t)"
* **print(t, l)**  
  .IX Item "print(t, l)"
  Print the value of expression _t_ with loglevel _l_. If
  _l_ is not specified then a default log level is used.
  Returns the value of the expression printed.
  .Sp
  Prints t with loglevel l
* **random(x)**  
  .IX Item "random(x)"
  Return a pseudo random value between 0.0 and 1.0. _x_ is the index of the
  internal variable which will be used to save the seed/state.
* **root(expr, max)**  
  .IX Item "root(expr, max)"
  Find an input value for which the function represented by _expr_
  with argument _\f(BIld\|(0)_ is 0 in the interval 0.._max_.
  .Sp
  The expression in _expr_ must denote a continuous function or the
  result is undefined.
  .Sp
  _\f(BIld\|(0)_ is used to represent the function input value, which means
  that the given expression will be evaluated multiple times with
  various input values that the expression can access through
  \f(CWld(0). When the expression evaluates to 0 then the
  corresponding input value will be returned.
* **round(expr)**  
  .IX Item "round(expr)"
  Round the value of expression _expr_ to the nearest integer. For example, round(1.5)\*(R" is \*(L"2.0\*(R".
* **sin(x)**  
  .IX Item "sin(x)"
  Compute sine of _x_.
* **sinh(x)**  
  .IX Item "sinh(x)"
  Compute hyperbolic sine of _x_.
* **sqrt(expr)**  
  .IX Item "sqrt(expr)"
  Compute the square root of _expr_. This is equivalent to
  "(_expr_)^.5".
* **squish(x)**  
  .IX Item "squish(x)"
  Compute expression \f(CW`1/(1 + exp(4*x))\*(C'.
* **st(var, expr)**  
  .IX Item "st(var, expr)"
  Store the value of the expression _expr_ in an internal
  variable. _var_ specifies the number of the variable where to
  store the value, and it is a value ranging from 0 to 9. The function
  returns the value stored in the internal variable.
  Note, Variables are currently not shared between expressions.
* **tan(x)**  
  .IX Item "tan(x)"
  Compute tangent of _x_.
* **tanh(x)**  
  .IX Item "tanh(x)"
  Compute hyperbolic tangent of _x_.
* **taylor(expr, x)**  
  .IX Item "taylor(expr, x)"
* **taylor(expr, x, id)**  
  .IX Item "taylor(expr, x, id)"
  Evaluate a Taylor series at _x_, given an expression representing
  the \f(CW`ld(id)\*(C'-th derivative of a function at 0.
  .Sp
  When the series does not converge the result is undefined.
  .Sp
  _ld(id)_ is used to represent the derivative order in _expr_,
  which means that the given expression will be evaluated multiple times
  with various input values that the expression can access through
  \f(CW`ld(id)\*(C'. If _id_ is not specified then 0 is assumed.
  .Sp
  Note, when you have the derivatives at y instead of 0,
  \f(CW`taylor(expr, x-y)\*(C' can be used.
* **time\|(0)**  
  .IX Item "time"
  Return the current (wallclock) time in seconds.
* **trunc(expr)**  
  .IX Item "trunc(expr)"
  Round the value of expression _expr_ towards zero to the nearest
  integer. For example, trunc(-1.5)\*(R" is \*(L"-1.0\*(R".
* **while(cond, expr)**  
  .IX Item "while(cond, expr)"
  Evaluate expression _expr_ while the expression _cond_ is
  non-zero, and returns the value of the last _expr_ evaluation, or
  \s-1NAN\s0 if _cond_ was always false.

The following constants are available:

* **\s-1PI\s0**  
  .IX Item "PI"
  area of the unit disc, approximately 3.14
* **E**  
  .IX Item "E"
  **exp**\|(1) (Euler's number), approximately 2.718
* **\s-1PHI\s0**  
  .IX Item "PHI"
  golden ratio (1+**sqrt**\|(5))/2, approximately 1.618

Assuming that an expression is considered true\*(R" if it has a non-zero
value, note that:

\f(CW`*\*(C' works like \s-1AND\s0

\f(CW`+\*(C' works like \s-1OR\s0

For example the construct:

.Vb 1
        if (A AND B) then C
.Ve

is equivalent to:

.Vb 1
        if(A*B, C)
.Ve

In your C code, you can extend the list of unary and binary functions,
and define recognized constants, so that they are available for your
expressions.

The evaluator also recognizes the International System unit prefixes.
If 'i' is appended after the prefix, binary prefixes are used, which
are based on powers of 1024 instead of powers of 1000.
The 'B' postfix multiplies the value by 8, and can be appended after a
unit prefix or used alone. This allows using for example '\s-1KB\s0', 'MiB',
'G' and 'B' as number postfix.

The list of available International System prefixes follows, with
indication of the corresponding powers of 10 and of 2.

* **y**  
  .IX Item "y"
  10^-24 / 2^-80
* **z**  
  .IX Item "z"
  10^-21 / 2^-70
* **a**  
  .IX Item "a"
  10^-18 / 2^-60
* **f**  
  .IX Item "f"
  10^-15 / 2^-50
* **p**  
  .IX Item "p"
  10^-12 / 2^-40
* **n**  
  .IX Item "n"
  10^-9 / 2^-30
* **u**  
  .IX Item "u"
  10^-6 / 2^-20
* **m**  
  .IX Item "m"
  10^-3 / 2^-10
* **c**  
  .IX Item "c"
  10^-2
* **d**  
  .IX Item "d"
  10^-1
* **h**  
  .IX Item "h"
  10^2
* **k**  
  .IX Item "k"
  10^3 / 2^10
* **K**  
  .IX Item "K"
  10^3 / 2^10
* **M**  
  .IX Item "M"
  10^6 / 2^20
* **G**  
  .IX Item "G"
  10^9 / 2^30
* **T**  
  .IX Item "T"
  10^12 / 2^40
* **P**  
  .IX Item "P"
  10^15 / 2^40
* **E**  
  .IX Item "E"
  10^18 / 2^50
* **Z**  
  .IX Item "Z"
  10^21 / 2^60
* **Y**  
  .IX Item "Y"
  10^24 / 2^70

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**ffmpeg**\|(1), **ffplay**\|(1), **ffprobe**\|(1), **libavutil**\|(3)

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
