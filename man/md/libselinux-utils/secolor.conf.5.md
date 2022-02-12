# secolor.conf(5) - The SELinux color configuration file

SELinux API documentation, 08 April 2011


<a name="description"></a>

# Description

This optional file controls the color to be associated to the context components associated to the 
_raw_
context passed by 
**selinux_raw_context_to_color**(3),
when context related information is to be displayed in color by an SELinux-aware application. 

**selinux_raw_context_to_color**(3)
obtains this color information from the active policy 
**secolor.conf**
file as returned by 
**selinux_colors_path**(3).

<a name="file-format"></a>

# File Format

The file format is as follows:
**color**
_color_name_
**= #**_color_mask_  
[...]

_context_component string_
**=**
_fg_color_name bg_color_name_  
[...]


Where:  
**color**
The color keyword. Each color entry is on a new line.
_color_name_
A single word name for the color (e.g. red).
_color_mask_
A color mask starting with a hash (#) that describes the hexadecimal RGB colors with black being #000000 and white being #ffffff.
_context_component_
The context component name that must be one of the following:  
user, role, type or range 
Each
_context_component_ _string_ ...
entry is on a new line.
_string_
This is the 
_context_component_
string that will be matched with the 
_raw_
context component passed by
**selinux_raw_context_to_color**(3).  
A wildcard '*' may be used to match any undefined string for the user, role and type 
_context_component_
entries only.

_fg_color_name_
The color_name string that will be used as the foreground color.
A 
_color_mask_
may also be used.
_bg_color_name_
The color_name string that will be used as the background color.
A 
_color_mask_
may also be used.

<a name="examples"></a>

# Examples

Example 1 entries are:
color black  = #000000  
color green  = #008000  
color yellow = #ffff00  
color blue   = #0000ff  
color white  = #ffffff  
color red    = #ff0000  
color orange = #ffa500  
color tan    = #D2B48C

user * = black white  
role * = white black  
type * = tan orange  
range s0-s0:c0.c1023 = black green  
range s1-s1:c0.c1023 = white green  
range s3-s3:c0.c1023 = black tan  
range s5-s5:c0.c1023 = white blue  
range s7-s7:c0.c1023 = black red  
range s9-s9:c0.c1023 = black orange  
range s15:c0.c1023   = black yellow


Example 2 entries are:
color black  = #000000  
color green  = #008000  
color yellow = #ffff00  
color blue   = #0000ff  
color white  = #ffffff  
color red    = #ff0000  
color orange = #ffa500  
color tan    = #d2b48c

user unconfined_u = #ff0000 green  
role unconfined_r = red #ffffff  
type unconfined_t = red orange  
user user_u       = black green  
role user_r       = white black  
type user_t       = tan red  
user xguest_u     = black yellow  
role xguest_r     = black red  
type xguest_t     = black green  
user sysadm_u     = white black  
range s0:c0.c1023 = black white  
user *            = black white  
role *            = black white  
type *            = black white

<a name="see-also"></a>

# See Also

**selinux**(8), **selinux_raw_context_to_color**(3), **selinux_colors_path**(3)
