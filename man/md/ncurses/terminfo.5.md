# terminfo(5)

"", ""

.ie \n(.g .ds \`\` “
.el       .ds \`\` \`\`
.ie \n(.g .ds '' ”
.el       .ds '' ''

<a name="name"></a>

# Name

terminfo - terminal capability data base

<a name="synopsis"></a>

# Synopsis

```
/usr/share/terminfo/*/*
```

<a name="description"></a>

# Description

_Terminfo_
is a data base describing terminals, used by screen-oriented programs such as
**nvi**(1),
**rogue**(1)
and libraries such as
**curses**(3X).
_Terminfo_
describes terminals by giving a set of capabilities which they
have, by specifying how to perform screen operations, and by
specifying padding requirements and initialization sequences.
This describes **ncurses**
version 6.1 (patch 20180923).

<a name="terminfo-entry-syntax"></a>

### Terminfo Entry Syntax


Entries in
_terminfo_
consist of a sequence of fields:
.bP
Each field ends with a comma \`,\*('' 
(embedded commas may be
escaped with a backslash or written as \`\\054\*('').
.bP
White space between fields is ignored.
.bP
The first field in a _terminfo_ entry begins in the first column.
.bP
Newlines and leading whitespace (spaces or tabs)
may be used for formatting entries for readability.
These are removed from parsed entries.

* The **infocmp** **-f** and **-W** options rely on this to
  format if-then-else expressions,
  or to enforce maximum line-width.
  The resulting formatted terminal description can be read by **tic**.
  .bP
  The first field for each terminal gives the names which are known for the
  terminal, separated by \`|\*('' characters.
* The first name given is the most common abbreviation for the terminal
  (its primary name),
  the last name given should be a long name fully identifying the terminal
  (see **longname**(3X)),
  and all others are treated as synonyms (aliases) for the primary terminal name.
* X/Open Curses advises that all names but the last should be in lower case
  and contain no blanks;
  the last name may well contain upper case and blanks for readability.
* This implementation is not so strict;
  it allows mixed case in the primary name and aliases.
  If the last name has no embedded blanks,
  it allows that to be both an alias and a verbose name
  (but will warn about this ambiguity).
  .bP
  Lines beginning with a \`#\*('' in the first column are treated as comments.
* While comment lines are legal at any point, the output of **captoinfo**
  and **infotocap** (aliases for **tic**)
  will move comments so they occur only between entries.

Terminal names (except for the last, verbose entry) should
be chosen using the following conventions.
The particular piece of hardware making up the terminal should
have a root name, thus \`hp2621\*(''.
This name should not contain hyphens.
Modes that the hardware can be in, or user preferences, should
be indicated by appending a hyphen and a mode suffix.
Thus, a vt100 in 132 column mode would be vt100-w.
The following suffixes should be used where possible:

.TS
center ;
l c l
l l l.
**Suffix	Meaning	Example**
-_nn_	Number of lines on the screen	aaa-60
-_n_p	Number of pages of memory	c100-4p
-am	With automargins (usually the default)	vt100-am
-m	Mono mode; suppress color       	ansi-m
-mc	Magic cookie; spaces when highlighting	wy30-mc
-na	No arrow keys (leave them in local)	c100-na
-nam	Without automatic margins       	vt100-nam
-nl	No status line                  	att4415-nl
-ns	No status line                  	hp2626-ns
-rv	Reverse video                   	c100-rv
-s	Enable status line              	vt100-s
-vb	Use visible bell instead of beep	wy370-vb
-w	Wide mode (&gt; 80 columns, usually 132)	vt100-w
.TE

For more on terminal naming conventions, see the **term**(7) manual page.

<a name="terminfo-capabilities-syntax"></a>

### Terminfo Capabilities Syntax


The terminfo entry consists of several _capabilities_,
i.e., features that the terminal has,
or methods for exercising the terminal's features.

After the first field (giving the name(s) of the terminal entry),
there should be one or more _capability_ fields.
These are boolean, numeric or string names with corresponding values:
.bP
Boolean capabilities are true when present, false when absent.
There is no explicit value for boolean capabilities.
.bP
Numeric capabilities have a \`#\*('' following the name,
then an unsigned decimal integer value.
.bP
String capabilities have a \`=\*('' following the name,
then an string of characters making up the capability value.

* String capabilities can be split into multiple lines,
  just as the fields comprising a terminal entry can be
  split into multiple lines.
  While blanks between fields are ignored,
  blanks embedded within a string value are retained,
  except for leading blanks on a line.

Any capability can be _canceled_,
i.e., suppressed from the terminal entry,
by following its name with \`@\*(''
rather than a capability value.

<a name="similar-terminals"></a>

### Similar Terminals


If there are two very similar terminals, one (the variant) can be defined as
being just like the other (the base) with certain exceptions.
In the
definition of the variant, the string capability **use** can be given with
the name of the base terminal:
.bP
The capabilities given before
**use**
override those in the base type named by
**use**.
.bP
If there are multiple **use** capabilities, they are merged in reverse order.
That is, the rightmost **use** reference is processed first, then the one to
its left, and so forth.
.bP
Capabilities given explicitly in the entry override
those brought in by **use** references.

A capability can be canceled by placing **xx@** to the left of the
use reference that imports it, where _xx_ is the capability.
For example, the entry

2621-nl, smkx@, rmkx@, use=2621,

defines a 2621-nl that does not have the **smkx** or **rmkx** capabilities,
and hence does not turn on the function key labels when in visual mode.
This is useful for different modes for a terminal, or for different
user preferences.

An entry included via **use** can contain canceled capabilities,
which have the same effect as if those cancels were inline in the
using terminal entry.

<a name="predefined-capabilities"></a>

### Predefined Capabilities


.ps -1
The following is a complete table of the capabilities included in a
terminfo description block and available to terminfo-using code.  In each
line of the table,

The **variable** is the name by which the programmer (at the terminfo level)
accesses the capability.

The **capname** is the short name used in the text of the database,
and is used by a person updating the database.
Whenever possible, capnames are chosen to be the same as or similar to
the ANSI X3.64-1979 standard (now superseded by ECMA-48, which uses
identical or very similar names).  Semantics are also intended to match
those of the specification.

The termcap code is the old
**termcap**
capability name (some capabilities are new, and have names which termcap
did not originate).

Capability names have no hard length limit, but an informal limit of 5
characters has been adopted to keep them short and to allow the tabs in
the source file
**Caps**
to line up nicely.

Finally, the description field attempts to convey the semantics of the
capability.  You may find some codes in the description field:

* (P)  
  indicates that padding may be specified
* #[1-9]  
  in the description field indicates that the string is passed through tparm with
  parms as given (#_i_).
* (P*)  
  indicates that padding may vary in proportion to the number of
  lines affected
* (#\d_i_\u)  
  indicates the _i_\uth\d parameter.
  

These are the boolean capabilities:

.na
.TS H
center;
c l l c
c l l c
lw25 lw7 lw2 lw20.
**Variable	Cap-	TCap	Description**
**Booleans	name	Code**
auto_left_margin	bw	bw	T{
cub1 wraps from column 0 to last column
T}
auto_right_margin	am	am	T{
terminal has automatic margins
T}
back_color_erase	bce	ut	T{
screen erased with background color
T}
can_change	ccc	cc	T{
terminal can re-define existing colors
T}
ceol_standout_glitch	xhp	xs	T{
standout not erased by overwriting (hp)
T}
col_addr_glitch	xhpa	YA	T{
only positive motion for hpa/mhpa caps
T}
cpi_changes_res	cpix	YF	T{
changing character pitch changes resolution
T}
cr_cancels_micro_mode	crxm	YB	T{
using cr turns off micro mode
T}
dest_tabs_magic_smso	xt	xt	T{
tabs destructive, magic so char (t1061)
T}
eat_newline_glitch	xenl	xn	T{
newline ignored after 80 cols (concept)
T}
erase_overstrike	eo	eo	T{
can erase overstrikes with a blank
T}
generic_type	gn	gn	T{
generic line type
T}
hard_copy	hc	hc	T{
hardcopy terminal
T}
hard_cursor	chts	HC	T{
cursor is hard to see
T}
has_meta_key	km	km	T{
Has a meta key (i.e., sets 8th-bit)
T}
has_print_wheel	daisy	YC	T{
printer needs operator to change character set
T}
has_status_line	hs	hs	T{
has extra status line
T}
hue_lightness_saturation	hls	hl	T{
terminal uses only HLS color notation (Tektronix)
T}
insert_null_glitch	in	in	T{
insert mode distinguishes nulls
T}
lpi_changes_res	lpix	YG	T{
changing line pitch changes resolution
T}
memory_above	da	da	T{
display may be retained above the screen
T}
memory_below	db	db	T{
display may be retained below the screen
T}
move_insert_mode	mir	mi	T{
safe to move while in insert mode
T}
move_standout_mode	msgr	ms	T{
safe to move while in standout mode
T}
needs_xon_xoff	nxon	nx	T{
padding will not work, xon/xoff required
T}
no_esc_ctlc	xsb	xb	T{
beehive (f1=escape, f2=ctrl C)
T}
no_pad_char	npc	NP	T{
pad character does not exist
T}
non_dest_scroll_region	ndscr	ND	T{
scrolling region is non-destructive
T}
non_rev_rmcup	nrrmc	NR	T{
smcup does not reverse rmcup
T}
over_strike	os	os	T{
terminal can overstrike
T}
prtr_silent	mc5i	5i	T{
printer will not echo on screen
T}
row_addr_glitch	xvpa	YD	T{
only positive motion for vpa/mvpa caps
T}
semi_auto_right_margin	sam	YE	T{
printing in last column causes cr
T}
status_line_esc_ok	eslok	es	T{
escape can be used on the status line
T}
tilde_glitch	hz	hz	T{
cannot print ~'s (Hazeltine)
T}
transparent_underline	ul	ul	T{
underline character overstrikes
T}
xon_xoff	xon	xo	T{
terminal uses xon/xoff handshaking
T}
.TE

These are the numeric capabilities:

.na
.TS H
center;
c l l c
c l l c
lw25 lw7 lw2 lw20.
**Variable	Cap-	TCap	Description**
**Numeric	name	Code**
columns	cols	co	T{
number of columns in a line
T}
init_tabs	it	it	T{
tabs initially every # spaces
T}
label_height	lh	lh	T{
rows in each label
T}
label_width	lw	lw	T{
columns in each label
T}
lines	lines	li	T{
number of lines on screen or page
T}
lines_of_memory	lm	lm	T{
lines of memory if &gt; line. 0 means varies
T}
magic_cookie_glitch	xmc	sg	T{
number of blank characters left by smso or rmso
T}
max_attributes	ma	ma	T{
maximum combined attributes terminal can handle
T}
max_colors	colors	Co	T{
maximum number of colors on screen
T}
max_pairs	pairs	pa	T{
maximum number of color-pairs on the screen
T}
maximum_windows	wnum	MW	T{
maximum number of definable windows
T}
no_color_video	ncv	NC	T{
video attributes that cannot be used with colors
T}
num_labels	nlab	Nl	T{
number of labels on screen
T}
padding_baud_rate	pb	pb	T{
lowest baud rate where padding needed
T}
virtual_terminal	vt	vt	T{
virtual terminal number (CB/unix)
T}
width_status_line	wsl	ws	T{
number of columns in status line
T}
.TE

The following numeric capabilities are present in the SVr4.0 term structure,
but are not yet documented in the man page.  They came in with SVr4's
printer support.

.na
.TS H
center;
c l l c
c l l c
lw25 lw7 lw2 lw20.
**Variable	Cap-	TCap	Description**
**Numeric	name	Code**
bit_image_entwining	bitwin	Yo	T{
number of passes for each bit-image row
T}
bit_image_type	bitype	Yp	T{
type of bit-image device
T}
buffer_capacity	bufsz	Ya	T{
numbers of bytes buffered before printing
T}
buttons	btns	BT	T{
number of buttons on mouse
T}
dot_horz_spacing	spinh	Yc	T{
spacing of dots horizontally in dots per inch
T}
dot_vert_spacing	spinv	Yb	T{
spacing of pins vertically in pins per inch
T}
max_micro_address	maddr	Yd	T{
maximum value in micro_..._address
T}
max_micro_jump	mjump	Ye	T{
maximum value in parm_..._micro
T}
micro_col_size	mcs	Yf	T{
character step size when in micro mode
T}
micro_line_size	mls	Yg	T{
line step size when in micro mode
T}
number_of_pins	npins	Yh	T{
numbers of pins in print-head
T}
output_res_char	orc	Yi	T{
horizontal resolution in units per line
T}
output_res_horz_inch	orhi	Yk	T{
horizontal resolution in units per inch
T}
output_res_line	orl	Yj	T{
vertical resolution in units per line
T}
output_res_vert_inch	orvi	Yl	T{
vertical resolution in units per inch
T}
print_rate	cps	Ym	T{
print rate in characters per second
T}
wide_char_size	widcs	Yn	T{
character step size when in double wide mode
T}
.TE

These are the string capabilities:

.na
.TS H
center;
c l l c
c l l c
lw25 lw7 lw2 lw20.
**Variable	Cap-	TCap	Description**
**String	name	Code**
acs_chars	acsc	ac	T{
graphics charset pairs, based on vt100
T}
back_tab	cbt	bt	T{
back tab (P)
T}
bell	bel	bl	T{
audible signal (bell) (P)
T}
carriage_return	cr	cr	T{
carriage return (P*) (P*)
T}
change_char_pitch	cpi	ZA	T{
Change number of characters per inch to #1
T}
change_line_pitch	lpi	ZB	T{
Change number of lines per inch to #1
T}
change_res_horz	chr	ZC	T{
Change horizontal resolution to #1
T}
change_res_vert	cvr	ZD	T{
Change vertical resolution to #1
T}
change_scroll_region	csr	cs	T{
change region to line #1 to line #2 (P)
T}
char_padding	rmp	rP	T{
like ip but when in insert mode
T}
clear_all_tabs	tbc	ct	T{
clear all tab stops (P)
T}
clear_margins	mgc	MC	T{
clear right and left soft margins
T}
clear_screen	clear	cl	T{
clear screen and home cursor (P*)
T}
clr_bol	el1	cb	T{
Clear to beginning of line
T}
clr_eol	el	ce	T{
clear to end of line (P)
T}
clr_eos	ed	cd	T{
clear to end of screen (P*)
T}
column_address	hpa	ch	T{
horizontal position #1, absolute (P)
T}
command_character	cmdch	CC	T{
terminal settable cmd character in prototype !?
T}
create_window	cwin	CW	T{
define a window #1 from #2,#3 to #4,#5
T}
cursor_address	cup	cm	T{
move to row #1 columns #2
T}
cursor_down	cud1	do	T{
down one line
T}
cursor_home	home	ho	T{
home cursor (if no cup)
T}
cursor_invisible	civis	vi	T{
make cursor invisible
T}
cursor_left	cub1	le	T{
move left one space
T}
cursor_mem_address	mrcup	CM	T{
memory relative cursor addressing, move to row #1 columns #2
T}
cursor_normal	cnorm	ve	T{
make cursor appear normal (undo civis/cvvis)
T}
cursor_right	cuf1	nd	T{
non-destructive space (move right one space)
T}
cursor_to_ll	ll	ll	T{
last line, first column (if no cup)
T}
cursor_up	cuu1	up	T{
up one line
T}
cursor_visible	cvvis	vs	T{
make cursor very visible
T}
define_char	defc	ZE	T{
Define a character #1, #2 dots wide, descender #3
T}
delete_character	dch1	dc	T{
delete character (P*)
T}
delete_line	dl1	dl	T{
delete line (P*)
T}
dial_phone	dial	DI	T{
dial number #1
T}
dis_status_line	dsl	ds	T{
disable status line
T}
display_clock	dclk	DK	T{
display clock
T}
down_half_line	hd	hd	T{
half a line down
T}
ena_acs	enacs	eA	T{
enable alternate char set
T}
enter_alt_charset_mode	smacs	as	T{
start alternate character set (P)
T}
enter_am_mode	smam	SA	T{
turn on automatic margins
T}
enter_blink_mode	blink	mb	T{
turn on blinking
T}
enter_bold_mode	bold	md	T{
turn on bold (extra bright) mode
T}
enter_ca_mode	smcup	ti	T{
string to start programs using cup
T}
enter_delete_mode	smdc	dm	T{
enter delete mode
T}
enter_dim_mode	dim	mh	T{
turn on half-bright mode
T}
enter_doublewide_mode	swidm	ZF	T{
Enter double-wide mode
T}
enter_draft_quality	sdrfq	ZG	T{
Enter draft-quality mode
T}
enter_insert_mode	smir	im	T{
enter insert mode
T}
enter_italics_mode	sitm	ZH	T{
Enter italic mode
T}
enter_leftward_mode	slm	ZI	T{
Start leftward carriage motion
T}
enter_micro_mode	smicm	ZJ	T{
Start micro-motion mode
T}
enter_near_letter_quality	snlq	ZK	T{
Enter NLQ mode
T}
enter_normal_quality	snrmq	ZL	T{
Enter normal-quality mode
T}
enter_protected_mode	prot	mp	T{
turn on protected mode
T}
enter_reverse_mode	rev	mr	T{
turn on reverse video mode
T}
enter_secure_mode	invis	mk	T{
turn on blank mode (characters invisible)
T}
enter_shadow_mode	sshm	ZM	T{
Enter shadow-print mode
T}
enter_standout_mode	smso	so	T{
begin standout mode
T}
enter_subscript_mode	ssubm	ZN	T{
Enter subscript mode
T}
enter_superscript_mode	ssupm	ZO	T{
Enter superscript mode
T}
enter_underline_mode	smul	us	T{
begin underline mode
T}
enter_upward_mode	sum	ZP	T{
Start upward carriage motion
T}
enter_xon_mode	smxon	SX	T{
turn on xon/xoff handshaking
T}
erase_chars	ech	ec	T{
erase #1 characters (P)
T}
exit_alt_charset_mode	rmacs	ae	T{
end alternate character set (P)
T}
exit_am_mode	rmam	RA	T{
turn off automatic margins
T}
exit_attribute_mode	sgr0	me	T{
turn off all attributes
T}
exit_ca_mode	rmcup	te	T{
strings to end programs using cup
T}
exit_delete_mode	rmdc	ed	T{
end delete mode
T}
exit_doublewide_mode	rwidm	ZQ	T{
End double-wide mode
T}
exit_insert_mode	rmir	ei	T{
exit insert mode
T}
exit_italics_mode	ritm	ZR	T{
End italic mode
T}
exit_leftward_mode	rlm	ZS	T{
End left-motion mode
T}
exit_micro_mode	rmicm	ZT	T{
End micro-motion mode
T}
exit_shadow_mode	rshm	ZU	T{
End shadow-print mode
T}
exit_standout_mode	rmso	se	T{
exit standout mode
T}
exit_subscript_mode	rsubm	ZV	T{
End subscript mode
T}
exit_superscript_mode	rsupm	ZW	T{
End superscript mode
T}
exit_underline_mode	rmul	ue	T{
exit underline mode
T}
exit_upward_mode	rum	ZX	T{
End reverse character motion
T}
exit_xon_mode	rmxon	RX	T{
turn off xon/xoff handshaking
T}
fixed_pause	pause	PA	T{
pause for 2-3 seconds
T}
flash_hook	hook	fh	T{
flash switch hook
T}
flash_screen	flash	vb	T{
visible bell (may not move cursor)
T}
form_feed	ff	ff	T{
hardcopy terminal page eject (P*)
T}
from_status_line	fsl	fs	T{
return from status line
T}
goto_window	wingo	WG	T{
go to window #1
T}
hangup	hup	HU	T{
hang-up phone
T}
init_1string	is1	i1	T{
initialization string
T}
init_2string	is2	is	T{
initialization string
T}
init_3string	is3	i3	T{
initialization string
T}
init_file	if	if	T{
name of initialization file
T}
init_prog	iprog	iP	T{
path name of program for initialization
T}
initialize_color	initc	Ic	T{
initialize color #1 to (#2,#3,#4)
T}
initialize_pair	initp	Ip	T{
Initialize color pair #1 to fg=(#2,#3,#4), bg=(#5,#6,#7)
T}
insert_character	ich1	ic	T{
insert character (P)
T}
insert_line	il1	al	T{
insert line (P*)
T}
insert_padding	ip	ip	T{
insert padding after inserted character
T}
key_a1	ka1	K1	T{
upper left of keypad
T}
key_a3	ka3	K3	T{
upper right of keypad
T}
key_b2	kb2	K2	T{
center of keypad
T}
key_backspace	kbs	kb	T{
backspace key
T}
key_beg	kbeg	@1	T{
begin key
T}
key_btab	kcbt	kB	T{
back-tab key
T}
key_c1	kc1	K4	T{
lower left of keypad
T}
key_c3	kc3	K5	T{
lower right of keypad
T}
key_cancel	kcan	@2	T{
cancel key
T}
key_catab	ktbc	ka	T{
clear-all-tabs key
T}
key_clear	kclr	kC	T{
clear-screen or erase key
T}
key_close	kclo	@3	T{
close key
T}
key_command	kcmd	@4	T{
command key
T}
key_copy	kcpy	@5	T{
copy key
T}
key_create	kcrt	@6	T{
create key
T}
key_ctab	kctab	kt	T{
clear-tab key
T}
key_dc	kdch1	kD	T{
delete-character key
T}
key_dl	kdl1	kL	T{
delete-line key
T}
key_down	kcud1	kd	T{
down-arrow key
T}
key_eic	krmir	kM	T{
sent by rmir or smir in insert mode
T}
key_end	kend	@7	T{
end key
T}
key_enter	kent	@8	T{
enter/send key
T}
key_eol	kel	kE	T{
clear-to-end-of-line key
T}
key_eos	ked	kS	T{
clear-to-end-of-screen key
T}
key_exit	kext	@9	T{
exit key
T}
key_f0	kf0	k0	T{
F0 function key
T}
key_f1	kf1	k1	T{
F1 function key
T}
key_f10	kf10	k;	T{
F10 function key
T}
key_f11	kf11	F1	T{
F11 function key
T}
key_f12	kf12	F2	T{
F12 function key
T}
key_f13	kf13	F3	T{
F13 function key
T}
key_f14	kf14	F4	T{
F14 function key
T}
key_f15	kf15	F5	T{
F15 function key
T}
key_f16	kf16	F6	T{
F16 function key
T}
key_f17	kf17	F7	T{
F17 function key
T}
key_f18	kf18	F8	T{
F18 function key
T}
key_f19	kf19	F9	T{
F19 function key
T}
key_f2	kf2	k2	T{
F2 function key
T}
key_f20	kf20	FA	T{
F20 function key
T}
key_f21	kf21	FB	T{
F21 function key
T}
key_f22	kf22	FC	T{
F22 function key
T}
key_f23	kf23	FD	T{
F23 function key
T}
key_f24	kf24	FE	T{
F24 function key
T}
key_f25	kf25	FF	T{
F25 function key
T}
key_f26	kf26	FG	T{
F26 function key
T}
key_f27	kf27	FH	T{
F27 function key
T}
key_f28	kf28	FI	T{
F28 function key
T}
key_f29	kf29	FJ	T{
F29 function key
T}
key_f3	kf3	k3	T{
F3 function key
T}
key_f30	kf30	FK	T{
F30 function key
T}
key_f31	kf31	FL	T{
F31 function key
T}
key_f32	kf32	FM	T{
F32 function key
T}
key_f33	kf33	FN	T{
F33 function key
T}
key_f34	kf34	FO	T{
F34 function key
T}
key_f35	kf35	FP	T{
F35 function key
T}
key_f36	kf36	FQ	T{
F36 function key
T}
key_f37	kf37	FR	T{
F37 function key
T}
key_f38	kf38	FS	T{
F38 function key
T}
key_f39	kf39	FT	T{
F39 function key
T}
key_f4	kf4	k4	T{
F4 function key
T}
key_f40	kf40	FU	T{
F40 function key
T}
key_f41	kf41	FV	T{
F41 function key
T}
key_f42	kf42	FW	T{
F42 function key
T}
key_f43	kf43	FX	T{
F43 function key
T}
key_f44	kf44	FY	T{
F44 function key
T}
key_f45	kf45	FZ	T{
F45 function key
T}
key_f46	kf46	Fa	T{
F46 function key
T}
key_f47	kf47	Fb	T{
F47 function key
T}
key_f48	kf48	Fc	T{
F48 function key
T}
key_f49	kf49	Fd	T{
F49 function key
T}
key_f5	kf5	k5	T{
F5 function key
T}
key_f50	kf50	Fe	T{
F50 function key
T}
key_f51	kf51	Ff	T{
F51 function key
T}
key_f52	kf52	Fg	T{
F52 function key
T}
key_f53	kf53	Fh	T{
F53 function key
T}
key_f54	kf54	Fi	T{
F54 function key
T}
key_f55	kf55	Fj	T{
F55 function key
T}
key_f56	kf56	Fk	T{
F56 function key
T}
key_f57	kf57	Fl	T{
F57 function key
T}
key_f58	kf58	Fm	T{
F58 function key
T}
key_f59	kf59	Fn	T{
F59 function key
T}
key_f6	kf6	k6	T{
F6 function key
T}
key_f60	kf60	Fo	T{
F60 function key
T}
key_f61	kf61	Fp	T{
F61 function key
T}
key_f62	kf62	Fq	T{
F62 function key
T}
key_f63	kf63	Fr	T{
F63 function key
T}
key_f7	kf7	k7	T{
F7 function key
T}
key_f8	kf8	k8	T{
F8 function key
T}
key_f9	kf9	k9	T{
F9 function key
T}
key_find	kfnd	@0	T{
find key
T}
key_help	khlp	%1	T{
help key
T}
key_home	khome	kh	T{
home key
T}
key_ic	kich1	kI	T{
insert-character key
T}
key_il	kil1	kA	T{
insert-line key
T}
key_left	kcub1	kl	T{
left-arrow key
T}
key_ll	kll	kH	T{
lower-left key (home down)
T}
key_mark	kmrk	%2	T{
mark key
T}
key_message	kmsg	%3	T{
message key
T}
key_move	kmov	%4	T{
move key
T}
key_next	knxt	%5	T{
next key
T}
key_npage	knp	kN	T{
next-page key
T}
key_open	kopn	%6	T{
open key
T}
key_options	kopt	%7	T{
options key
T}
key_ppage	kpp	kP	T{
previous-page key
T}
key_previous	kprv	%8	T{
previous key
T}
key_print	kprt	%9	T{
print key
T}
key_redo	krdo	%0	T{
redo key
T}
key_reference	kref	&1	T{
reference key
T}
key_refresh	krfr	&2	T{
refresh key
T}
key_replace	krpl	&3	T{
replace key
T}
key_restart	krst	&4	T{
restart key
T}
key_resume	kres	&5	T{
resume key
T}
key_right	kcuf1	kr	T{
right-arrow key
T}
key_save	ksav	&6	T{
save key
T}
key_sbeg	kBEG	&9	T{
shifted begin key
T}
key_scancel	kCAN	&0	T{
shifted cancel key
T}
key_scommand	kCMD	*1	T{
shifted command key
T}
key_scopy	kCPY	*2	T{
shifted copy key
T}
key_screate	kCRT	*3	T{
shifted create key
T}
key_sdc	kDC	*4	T{
shifted delete-character key
T}
key_sdl	kDL	*5	T{
shifted delete-line key
T}
key_select	kslt	*6	T{
select key
T}
key_send	kEND	*7	T{
shifted end key
T}
key_seol	kEOL	*8	T{
shifted clear-to-end-of-line key
T}
key_sexit	kEXT	*9	T{
shifted exit key
T}
key_sf	kind	kF	T{
scroll-forward key
T}
key_sfind	kFND	*0	T{
shifted find key
T}
key_shelp	kHLP	#1	T{
shifted help key
T}
key_shome	kHOM	#2	T{
shifted home key
T}
key_sic	kIC	#3	T{
shifted insert-character key
T}
key_sleft	kLFT	#4	T{
shifted left-arrow key
T}
key_smessage	kMSG	%a	T{
shifted message key
T}
key_smove	kMOV	%b	T{
shifted move key
T}
key_snext	kNXT	%c	T{
shifted next key
T}
key_soptions	kOPT	%d	T{
shifted options key
T}
key_sprevious	kPRV	%e	T{
shifted previous key
T}
key_sprint	kPRT	%f	T{
shifted print key
T}
key_sr	kri	kR	T{
scroll-backward key
T}
key_sredo	kRDO	%g	T{
shifted redo key
T}
key_sreplace	kRPL	%h	T{
shifted replace key
T}
key_sright	kRIT	%i	T{
shifted right-arrow key
T}
key_srsume	kRES	%j	T{
shifted resume key
T}
key_ssave	kSAV	!1	T{
shifted save key
T}
key_ssuspend	kSPD	!2	T{
shifted suspend key
T}
key_stab	khts	kT	T{
set-tab key
T}
key_sundo	kUND	!3	T{
shifted undo key
T}
key_suspend	kspd	&7	T{
suspend key
T}
key_undo	kund	&8	T{
undo key
T}
key_up	kcuu1	ku	T{
up-arrow key
T}
keypad_local	rmkx	ke	T{
leave 'keyboard_transmit' mode
T}
keypad_xmit	smkx	ks	T{
enter 'keyboard_transmit' mode
T}
lab_f0	lf0	l0	T{
label on function key f0 if not f0
T}
lab_f1	lf1	l1	T{
label on function key f1 if not f1
T}
lab_f10	lf10	la	T{
label on function key f10 if not f10
T}
lab_f2	lf2	l2	T{
label on function key f2 if not f2
T}
lab_f3	lf3	l3	T{
label on function key f3 if not f3
T}
lab_f4	lf4	l4	T{
label on function key f4 if not f4
T}
lab_f5	lf5	l5	T{
label on function key f5 if not f5
T}
lab_f6	lf6	l6	T{
label on function key f6 if not f6
T}
lab_f7	lf7	l7	T{
label on function key f7 if not f7
T}
lab_f8	lf8	l8	T{
label on function key f8 if not f8
T}
lab_f9	lf9	l9	T{
label on function key f9 if not f9
T}
label_format	fln	Lf	T{
label format
T}
label_off	rmln	LF	T{
turn off soft labels
T}
label_on	smln	LO	T{
turn on soft labels
T}
meta_off	rmm	mo	T{
turn off meta mode
T}
meta_on	smm	mm	T{
turn on meta mode (8th-bit on)
T}
micro_column_address	mhpa	ZY	T{
Like column_address in micro mode
T}
micro_down	mcud1	ZZ	T{
Like cursor_down in micro mode
T}
micro_left	mcub1	Za	T{
Like cursor_left in micro mode
T}
micro_right	mcuf1	Zb	T{
Like cursor_right in micro mode
T}
micro_row_address	mvpa	Zc	T{
Like row_address #1 in micro mode
T}
micro_up	mcuu1	Zd	T{
Like cursor_up in micro mode
T}
newline	nel	nw	T{
newline (behave like cr followed by lf)
T}
order_of_pins	porder	Ze	T{
Match software bits to print-head pins
T}
orig_colors	oc	oc	T{
Set all color pairs to the original ones
T}
orig_pair	op	op	T{
Set default pair to its original value
T}
pad_char	pad	pc	T{
padding char (instead of null)
T}
parm_dch	dch	DC	T{
delete #1 characters (P*)
T}
parm_delete_line	dl	DL	T{
delete #1 lines (P*)
T}
parm_down_cursor	cud	DO	T{
down #1 lines (P*)
T}
parm_down_micro	mcud	Zf	T{
Like parm_down_cursor in micro mode
T}
parm_ich	ich	IC	T{
insert #1 characters (P*)
T}
parm_index	indn	SF	T{
scroll forward #1 lines (P)
T}
parm_insert_line	il	AL	T{
insert #1 lines (P*)
T}
parm_left_cursor	cub	LE	T{
move #1 characters to the left (P)
T}
parm_left_micro	mcub	Zg	T{
Like parm_left_cursor in micro mode
T}
parm_right_cursor	cuf	RI	T{
move #1 characters to the right (P*)
T}
parm_right_micro	mcuf	Zh	T{
Like parm_right_cursor in micro mode
T}
parm_rindex	rin	SR	T{
scroll back #1 lines (P)
T}
parm_up_cursor	cuu	UP	T{
up #1 lines (P*)
T}
parm_up_micro	mcuu	Zi	T{
Like parm_up_cursor in micro mode
T}
pkey_key	pfkey	pk	T{
program function key #1 to type string #2
T}
pkey_local	pfloc	pl	T{
program function key #1 to execute string #2
T}
pkey_xmit	pfx	px	T{
program function key #1 to transmit string #2
T}
plab_norm	pln	pn	T{
program label #1 to show string #2
T}
print_screen	mc0	ps	T{
print contents of screen
T}
prtr_non	mc5p	pO	T{
turn on printer for #1 bytes
T}
prtr_off	mc4	pf	T{
turn off printer
T}
prtr_on	mc5	po	T{
turn on printer
T}
pulse	pulse	PU	T{
select pulse dialing
T}
quick_dial	qdial	QD	T{
dial number #1 without checking
T}
remove_clock	rmclk	RC	T{
remove clock
T}
repeat_char	rep	rp	T{
repeat char #1 #2 times (P*)
T}
req_for_input	rfi	RF	T{
send next input char (for ptys)
T}
reset_1string	rs1	r1	T{
reset string
T}
reset_2string	rs2	r2	T{
reset string
T}
reset_3string	rs3	r3	T{
reset string
T}
reset_file	rf	rf	T{
name of reset file
T}
restore_cursor	rc	rc	T{
restore cursor to position of last save_cursor
T}
row_address	vpa	cv	T{
vertical position #1 absolute (P)
T}
save_cursor	sc	sc	T{
save current cursor position (P)
T}
scroll_forward	ind	sf	T{
scroll text up (P)
T}
scroll_reverse	ri	sr	T{
scroll text down (P)
T}
select_char_set	scs	Zj	T{
Select character set, #1
T}
set_attributes	sgr	sa	T{
define video attributes #1-#9 (PG9)
T}
set_background	setb	Sb	T{
Set background color #1
T}
set_bottom_margin	smgb	Zk	T{
Set bottom margin at current line
T}
set_bottom_margin_parm	smgbp	Zl	T{
Set bottom margin at line #1 or (if smgtp is not given) #2 lines from bottom
T}
set_clock	sclk	SC	T{
set clock, #1 hrs #2 mins #3 secs
T}
set_color_pair	scp	sp	T{
Set current color pair to #1
T}
set_foreground	setf	Sf	T{
Set foreground color #1
T}
set_left_margin	smgl	ML	T{
set left soft margin at current column.	 See smgl. (ML is not in BSD termcap).
T}
set_left_margin_parm	smglp	Zm	T{
Set left (right) margin at column #1
T}
set_right_margin	smgr	MR	T{
set right soft margin at current column
T}
set_right_margin_parm	smgrp	Zn	T{
Set right margin at column #1
T}
set_tab	hts	st	T{
set a tab in every row, current columns
T}
set_top_margin	smgt	Zo	T{
Set top margin at current line
T}
set_top_margin_parm	smgtp	Zp	T{
Set top (bottom) margin at row #1
T}
set_window	wind	wi	T{
current window is lines #1-#2 cols #3-#4
T}
start_bit_image	sbim	Zq	T{
Start printing bit image graphics
T}
start_char_set_def	scsd	Zr	T{
Start character set definition #1, with #2 characters in the set
T}
stop_bit_image	rbim	Zs	T{
Stop printing bit image graphics
T}
stop_char_set_def	rcsd	Zt	T{
End definition of character set #1
T}
subscript_characters	subcs	Zu	T{
List of subscriptable characters
T}
superscript_characters	supcs	Zv	T{
List of superscriptable characters
T}
tab	ht	ta	T{
tab to next 8-space hardware tab stop
T}
these_cause_cr	docr	Zw	T{
Printing any of these characters causes CR
T}
to_status_line	tsl	ts	T{
move to status line, column #1
T}
tone	tone	TO	T{
select touch tone dialing
T}
underline_char	uc	uc	T{
underline char and move past it
T}
up_half_line	hu	hu	T{
half a line up
T}
user0	u0	u0	T{
User string #0
T}
user1	u1	u1	T{
User string #1
T}
user2	u2	u2	T{
User string #2
T}
user3	u3	u3	T{
User string #3
T}
user4	u4	u4	T{
User string #4
T}
user5	u5	u5	T{
User string #5
T}
user6	u6	u6	T{
User string #6
T}
user7	u7	u7	T{
User string #7
T}
user8	u8	u8	T{
User string #8
T}
user9	u9	u9	T{
User string #9
T}
wait_tone	wait	WA	T{
wait for dial-tone
T}
xoff_character	xoffc	XF	T{
XOFF character
T}
xon_character	xonc	XN	T{
XON character
T}
zero_motion	zerom	Zx	T{
No motion for subsequent character
T}
.TE

The following string capabilities are present in the SVr4.0 term structure,
but were originally not documented in the man page.

.na
.TS H
center;
c l l c
c l l c
lw25 lw7 lw2 lw18.
**Variable	Cap-	TCap	Description**
**String	name	Code**
alt_scancode_esc	scesa	S8	T{
Alternate escape for scancode emulation
T}
bit_image_carriage_return	bicr	Yv	T{
Move to beginning of same row
T}
bit_image_newline	binel	Zz	T{
Move to next row of the bit image
T}
bit_image_repeat	birep	Xy	T{
Repeat bit image cell #1 #2 times
T}
char_set_names	csnm	Zy	T{
Produce #1'th item from list of character set names
T}
code_set_init	csin	ci	T{
Init sequence for multiple codesets
T}
color_names	colornm	Yw	T{
Give name for color #1
T}
define_bit_image_region	defbi	Yx	T{
Define rectangular bit image region
T}
device_type	devt	dv	T{
Indicate language/codeset support
T}
display_pc_char	dispc	S1	T{
Display PC character #1
T}
end_bit_image_region	endbi	Yy	T{
End a bit-image region
T}
enter_pc_charset_mode	smpch	S2	T{
Enter PC character display mode
T}
enter_scancode_mode	smsc	S4	T{
Enter PC scancode mode
T}
exit_pc_charset_mode	rmpch	S3	T{
Exit PC character display mode
T}
exit_scancode_mode	rmsc	S5	T{
Exit PC scancode mode
T}
get_mouse	getm	Gm	T{
Curses should get button events, parameter #1 not documented.
T}
key_mouse	kmous	Km	T{
Mouse event has occurred
T}
mouse_info	minfo	Mi	T{
Mouse status information
T}
pc_term_options	pctrm	S6	T{
PC terminal options
T}
pkey_plab	pfxl	xl	T{
Program function key #1 to type string #2 and show string #3
T}
req_mouse_pos	reqmp	RQ	T{
Request mouse position
T}
scancode_escape	scesc	S7	T{
Escape for scancode emulation
T}
set0_des_seq	s0ds	s0	T{
Shift to codeset 0 (EUC set 0, ASCII)
T}
set1_des_seq	s1ds	s1	T{
Shift to codeset 1
T}
set2_des_seq	s2ds	s2	T{
Shift to codeset 2
T}
set3_des_seq	s3ds	s3	T{
Shift to codeset 3
T}
set_a_background	setab	AB	T{
Set background color to #1, using ANSI escape
T}
set_a_foreground	setaf	AF	T{
Set foreground color to #1, using ANSI escape
T}
set_color_band	setcolor	Yz	T{
Change to ribbon color #1
T}
set_lr_margin	smglr	ML	T{
Set both left and right margins to #1, #2.  (ML is not in BSD termcap).
T}
set_page_length	slines	YZ	T{
Set page length to #1 lines
T}
set_tb_margin	smgtb	MT	T{
Sets both top and bottom margins to #1, #2
T}
.TE

.in .8i
The XSI Curses standard added these hardcopy capabilities.
They were used in some post-4.1 versions of System V curses,
e.g., Solaris 2.5 and IRIX 6.x.
Except for **YI**, the **ncurses** termcap names for them are invented.
According to the XSI Curses standard, they have no termcap names.
If your compiled terminfo entries use these,
they may not be binary-compatible with System V terminfo
entries after SVr4.1; beware!

.na
.TS H
center;
c l l c
c l l c
lw25 lw7 lw2 lw20.
**Variable	Cap-	TCap	Description**
**String	name	Code**
enter_horizontal_hl_mode	ehhlm	Xh	T{
Enter horizontal highlight mode
T}
enter_left_hl_mode	elhlm	Xl	T{
Enter left highlight mode
T}
enter_low_hl_mode	elohlm	Xo	T{
Enter low highlight mode
T}
enter_right_hl_mode	erhlm	Xr	T{
Enter right highlight mode
T}
enter_top_hl_mode	ethlm	Xt	T{
Enter top highlight mode
T}
enter_vertical_hl_mode	evhlm	Xv	T{
Enter vertical highlight mode
T}
set_a_attributes	sgr1	sA	T{
Define second set of video attributes #1-#6
T}
set_pglen_inch	slength	YI	T{
Set page length to #1 hundredth of an inch (some implementations use sL for termcap).
T}
.TE




.ps +1

<a name="user-defined-capabilities"></a>

### User-Defined Capabilities

The preceding section listed the _predefined_ capabilities.
They deal with some special features for terminals no longer
(or possibly never) produced.
Occasionally there are special features of newer terminals which
are awkward or impossible to represent by reusing the predefined
capabilities.

**ncurses** addresses this limitation by allowing user-defined capabilities.
The **tic** and **infocmp** programs provide
the **-x** option for this purpose.
When **-x** is set,
**tic** treats unknown capabilities as user-defined.
That is, if **tic** encounters a capability name
which it does not recognize,
it infers its type (boolean, number or string) from the syntax
and makes an extended table entry for that capability.
The **use\_extended\_names**(3X) function makes this information
conditionally available to applications.
The ncurses library provides the data leaving most of the behavior
to applications:
.bP
User-defined capability strings whose name begins
with \`k\*('' are treated as function keys.
.bP
The types (boolean, number, string) determined by **tic**
can be inferred by successful calls on **tigetflag**, etc.
.bP
If the capability name happens to be two characters,
the capability is also available through the termcap interface.

While termcap is said to be extensible because it does not use a predefined set
of capabilities,
in practice it has been limited to the capabilities defined by
terminfo implementations.
As a rule,
user-defined capabilities intended for use by termcap applications should
be limited to booleans and numbers to avoid running past the 1023 byte
limit assumed by termcap implementations and their applications.
In particular, providing extended sets of function keys (past the 60
numbered keys and the handful of special named keys) is best done using
the longer names available using terminfo.

<a name="a-sample-entry"></a>

### A Sample Entry

The following entry, describing an ANSI-standard terminal, is representative
of what a **terminfo** entry for a modern terminal typically looks like.

    .ft CW
    s-2ansi|ansi/pc-term compatible with color,
            am, mc5i, mir, msgr,
            colors#8, cols#80, it#8, lines#24, ncv#3, pairs#64,
            acsc=+\020\021-\030.^Y0\333`\004a\261f\370g\361h\260
                 j\331k\277l\332m\300n\305o~p\304q\304r\304s_t\303
                 u\264v\301w\302x\263y\363z\362{\343|\330}\234~\376,
            bel=^G, blink=\E[5m, bold=\E[1m, cbt=\E[Z, clear=\E[H\E[J,
            cr=^M, cub=\E[%p1%dD, cub1=\E[D, cud=\E[%p1%dB, cud1=\E[B,
            cuf=\E[%p1%dC, cuf1=\E[C, cup=\E[%i%p1%d;%p2%dH,
            cuu=\E[%p1%dA, cuu1=\E[A, dch=\E[%p1%dP, dch1=\E[P,
            dl=\E[%p1%dM, dl1=\E[M, ech=\E[%p1%dX, ed=\E[J, el=\E[K,
            el1=\E[1K, home=\E[H, hpa=\E[%i%p1%dG, ht=\E[I, hts=\EH,
            ich=\E[%p1%d@, il=\E[%p1%dL, il1=\E[L, ind=^J,
            indn=\E[%p1%dS, invis=\E[8m, kbs=^H, kcbt=\E[Z, kcub1=\E[D,
            kcud1=\E[B, kcuf1=\E[C, kcuu1=\E[A, khome=\E[H, kich1=\E[L,
            mc4=\E[4i, mc5=\E[5i, nel=\r\E[S, op=\E[39;49m,
            rep=%p1%c\E[%p2%{1}%-%db, rev=\E[7m, rin=\E[%p1%dT,
            rmacs=\E[10m, rmpch=\E[10m, rmso=\E[m, rmul=\E[m,
            s0ds=\E(B, s1ds=\E)B, s2ds=\E*B, s3ds=\E+B,
            setab=\E[4%p1%dm, setaf=\E[3%p1%dm,
            sgr=\E[0;10%?%p1%t;7%;
                       %?%p2%t;4%;
                       %?%p3%t;7%;
                       %?%p4%t;5%;
                       %?%p6%t;1%;
                       %?%p7%t;8%;
                       %?%p9%t;11%;m,
            sgr0=\E[0;10m, smacs=\E[11m, smpch=\E[11m, smso=\E[7m,
            smul=\E[4m, tbc=\E[3g, u6=\E[%i%d;%dR, u7=\E[6n,
            u8=\E[?%[;0123456789]c, u9=\E[c, vpa=\E[%i%p1%dd,

Entries may continue onto multiple lines by placing white space at
the beginning of each line except the first.
Comments may be included on lines beginning with \`#\*(''.
Capabilities in
_terminfo_
are of three types:
.bP
Boolean capabilities which indicate that the terminal has
some particular feature,
.bP
numeric capabilities giving the size of the terminal
or the size of particular delays, and
.bP
string
capabilities, which give a sequence which can be used to perform particular
terminal operations.


<a name="types-of-capabilities"></a>

### Types of Capabilities


All capabilities have names.
For instance, the fact that
ANSI-standard terminals have
_automatic margins_
(i.e., an automatic return and line-feed
when the end of a line is reached) is indicated by the capability **am**.
Hence the description of ansi includes **am**.
Numeric capabilities are followed by the character \`#\*('' and then a positive value.
Thus **cols**, which indicates the number of columns the terminal has,
gives the value \`80\*('' for ansi.
Values for numeric capabilities may be specified in decimal, octal or hexadecimal,
using the C programming language conventions (e.g., 255, 0377 and 0xff or 0xFF).

Finally, string valued capabilities, such as **el** (clear to end of line
sequence) are given by the two-character code, an \`=\*('', and then a string
ending at the next following \`,\*(''.

A number of escape sequences are provided in the string valued capabilities
for easy encoding of characters there:
.bP
Both **\eE** and **\ee**
map to an \s-1ESCAPE\s0 character,
.bP
**^x** maps to a control-x for any appropriate _x_, and
.bP
the sequences

**\en**, **\el**, **\er**, **\et**, **\eb**, **\ef**, and **\es**

* produce

_newline_, _line-feed_, _return_, _tab_, _backspace_, _form-feed_, and _space_,

* respectively.

X/Open Curses does not say what \`appropriate _x_\*('' might be.
In practice, that is a printable ASCII graphic character.
The special case \`^?\*('' is interpreted as DEL (127).
In all other cases, the character value is AND'd with 0x1f,
mapping to ASCII control codes in the range 0 through 31.

Other escapes include
.bP
**\e^** for **^**,
.bP
**\e\e** for **\e**,
.bP
**\e**, for comma,
.bP
**\e:** for **:**,
.bP
and **\e0** for null.

* **\e0** will produce \e200, which does not terminate a string but behaves
  as a null character on most terminals, providing CS7 is specified.
  See **stty**(1).
* The reason for this quirk is to maintain binary compatibility of the
  compiled terminfo files with other implementations,
  e.g., the SVr4 systems, which document this.
  Compiled terminfo files use null-terminated strings, with no lengths.
  Modifying this would require a new binary format, 
  which would not work with other implementations.

Finally, characters may be given as three octal digits after a **\e**.

A delay in milliseconds may appear anywhere in a string capability, enclosed in
$&lt;..&gt; brackets, as in **el**=\eEK$&lt;5&gt;,
and padding characters are supplied by **tputs**(3X)
to provide this delay.
.bP
The delay must be a number with at most one decimal
place of precision; it may be followed by suffixes \`*\*('' or \*(\`\`/\*('' or both.
.bP
A \`*\*(''
indicates that the padding required is proportional to the number of lines
affected by the operation, and the amount given is the per-affected-unit
padding required.
(In the case of insert character, the factor is still the
number of _lines_ affected.)

* Normally, padding is advisory if the device has the **xon**
  capability; it is used for cost computation but does not trigger delays.
  .bP
  A \`/\*(''
  suffix indicates that the padding is mandatory and forces a delay of the given
  number of milliseconds even on devices for which **xon** is present to
  indicate flow control.

Sometimes individual capabilities must be commented out.
To do this, put a period before the capability name.
For example, see the second
**ind**
in the example above.  
.ne 5


<a name="fetching-compiled-descriptions"></a>

### Fetching Compiled Descriptions


The **ncurses** library searches for terminal descriptions in several places.
It uses only the first description found.
The library has a compiled-in list of places to search
which can be overridden by environment variables.
Before starting to search,
**ncurses** eliminates duplicates in its search list.
.bP
If the environment variable TERMINFO is set, it is interpreted as the pathname
of a directory containing the compiled description you are working on.
Only that directory is searched.
.bP
If TERMINFO is not set,
**ncurses** will instead look in the directory **$HOME/.terminfo**
for a compiled description.
.bP
Next, if the environment variable TERMINFO_DIRS is set,
**ncurses** will interpret the contents of that variable
as a list of colon-separated directories (or database files) to be searched.

* An empty directory name (i.e., if the variable begins or ends
  with a colon, or contains adjacent colons)
  is interpreted as the system location _/usr/share/terminfo_.
  .bP
  Finally, **ncurses** searches these compiled-in locations:
      .bP
      a list of directories (no default value), and
      .bP
      the system terminfo directory, _/usr/share/terminfo_ (the compiled-in default).

<a name="preparing-descriptions"></a>

### Preparing Descriptions


We now outline how to prepare descriptions of terminals.
The most effective way to prepare a terminal description is by imitating
the description of a similar terminal in
_terminfo_
and to build up a description gradually, using partial descriptions
with
_vi_
or some other screen-oriented program to check that they are correct.
Be aware that a very unusual terminal may expose deficiencies in
the ability of the
_terminfo_
file to describe it
or bugs in the screen-handling code of the test program.

To get the padding for insert line right (if the terminal manufacturer
did not document it) a severe test is to edit a large file at 9600 baud,
delete 16 or so lines from the middle of the screen, then hit the \`u\*(''
key several times quickly.
If the terminal messes up, more padding is usually needed.
A similar test can be used for insert character.


<a name="basic-capabilities"></a>

### Basic Capabilities


The number of columns on each line for the terminal is given by the
**cols** numeric capability.
If the terminal is a \s-1CRT\s0, then the
number of lines on the screen is given by the **lines** capability.
If the terminal wraps around to the beginning of the next line when
it reaches the right margin, then it should have the **am** capability.
If the terminal can clear its screen, leaving the cursor in the home
position, then this is given by the **clear** string capability.
If the terminal overstrikes
(rather than clearing a position when a character is struck over)
then it should have the **os** capability.
If the terminal is a printing terminal, with no soft copy unit,
give it both
**hc**
and
**os**.
(**os**
applies to storage scope terminals, such as \s-1TEKTRONIX\s+1 4010
series, as well as hard copy and APL terminals.)
If there is a code to move the cursor to the left edge of the current
row, give this as
**cr**.
(Normally this will be carriage return, control M.)
If there is a code to produce an audible signal (bell, beep, etc)
give this as
**bel**.

If there is a code to move the cursor one position to the left
(such as backspace) that capability should be given as
**cub1**.
Similarly, codes to move to the right, up, and down should be
given as
**cuf1**,
**cuu1**,
and
**cud1**.
These local cursor motions should not alter the text they pass over,
for example, you would not normally use \`**cuf1**=&nbsp;\*('' because the
space would erase the character moved over.

A very important point here is that the local cursor motions encoded
in
_terminfo_
are undefined at the left and top edges of a \s-1CRT\s0 terminal.
Programs should never attempt to backspace around the left edge,
unless
**bw**
is given,
and never attempt to go up locally off the top.
In order to scroll text up, a program will go to the bottom left corner
of the screen and send the
**ind**
(index) string.

To scroll text down, a program goes to the top left corner
of the screen and sends the
**ri**
(reverse index) string.
The strings
**ind**
and
**ri**
are undefined when not on their respective corners of the screen.

Parameterized versions of the scrolling sequences are
**indn**
and
**rin**
which have the same semantics as
**ind**
and
**ri**
except that they take one parameter, and scroll that many lines.
They are also undefined except at the appropriate edge of the screen.

The **am** capability tells whether the cursor sticks at the right
edge of the screen when text is output, but this does not necessarily
apply to a
**cuf1**
from the last column.
The only local motion which is defined from the left edge is if
**bw**
is given, then a
**cub1**
from the left edge will move to the right edge of the previous row.
If
**bw**
is not given, the effect is undefined.
This is useful for drawing a box around the edge of the screen, for example.
If the terminal has switch selectable automatic margins,
the
_terminfo_
file usually assumes that this is on; i.e., **am**.
If the terminal has a command which moves to the first column of the next
line, that command can be given as
**nel**
(newline).
It does not matter if the command clears the remainder of the current line,
so if the terminal has no
**cr**
and
**lf**
it may still be possible to craft a working
**nel**
out of one or both of them.

These capabilities suffice to describe hard-copy and \`glass-tty\*('' terminals.
Thus the model 33 teletype is described as

.DT
    .ft CW
    
    s-133|||tty33|||tty|||model 33 teletype,
            bel=^G, cols#72, cr=^M, cud1=^J, hc, ind=^J, os,s+1
    
    .ft R

while the Lear Siegler \s-1ADM-3\s0 is described as

.DT
    .ft CW
    
    s-1adm3|||3|||lsi adm3,
            am, bel=^G, clear=^Z, cols#80, cr=^M, cub1=^H, cud1=^J,
            ind=^J, lines#24,s+1
    
    .ft R


<a name="parameterized-strings"></a>

### Parameterized Strings


Cursor addressing and other strings requiring parameters
in the terminal are described by a
parameterized string capability,
with _printf_-like escapes such as _%x_ in it.
For example, to address the cursor, the
**cup**
capability is given, using two parameters:
the row and column to address to.
(Rows and columns are numbered from zero and refer to the
physical screen visible to the user, not to any unseen memory.)
If the terminal has memory relative cursor addressing,
that can be indicated by
**mrcup**.

The parameter mechanism uses a stack and special **%** codes
to manipulate it.
Typically a sequence will push one of the
parameters onto the stack and then print it in some format.
Print (e.g., "%d") is a special case.
Other operations, including "%t" pop their operand from the stack.
It is noted that more complex operations are often necessary,
e.g., in the **sgr** string.

The **%** encodings have the following meanings:


* **%%**  
  outputs \`%\*(''
* **%**_[[_:_]flags][width[.precision]][_**doxXs**_]_  
  as in **printf**, flags are _[-+#]_ and _space_.
  Use a \`:\*('' to allow the next character to be a \*(\`\`-\*('' flag,
  avoiding interpreting "%-" as an operator.
* \f(CW%c  
  print _pop()_ like %c in **printf**
* **%s**  
  print _pop()_ like %s in **printf**
* **%p**_[1-9]_  
  push _i_'th parameter
* **%P**_[a-z]_  
  set dynamic variable _[a-z]_ to _pop()_
* **%g**_[a-z]/_  
  get dynamic variable _[a-z]_ and push it
* **%P**_[A-Z]_  
  set static variable _[a-z]_ to _pop()_
* **%g**_[A-Z]_  
  get static variable _[a-z]_ and push it
* The terms "static" and "dynamic" are misleading.
  Historically, these are simply two different sets of variables,
  whose values are not reset between calls to **tparm**(3X).
  However, that fact is not documented in other implementations.
  Relying on it will adversely impact portability to other implementations.
* **%'**_c_**'**  
  char constant _c_
* **%{**_nn_**}**  
  integer constant _nn_
* **%l**  
  push strlen(pop)
* **%+**, **%-**, **%***, **%/**, **%m**  
  arithmetic (%m is _mod_): _push(pop() op pop())_
* **%&**, **%|**, **%^**  
  bit operations (AND, OR and exclusive-OR): _push(pop() op pop())_
* **%=**, **%&gt;**, **%&lt;**  
  logical operations: _push(pop() op pop())_
* **%A**, **%O**  
  logical AND and OR operations (for conditionals)
* **%!**, **%~**  
  unary operations (logical and bit complement): _push(op pop())_
* **%i**  
  add 1 to first two parameters (for ANSI terminals)
* **%?** _expr_ **%t** _thenpart_ **%e** _elsepart_ **%;**  
  This forms an if-then-else.
  The **%e** _elsepart_ is optional.
  Usually the **%?** _expr_ part pushes a value onto the stack,
  and **%t** pops it from the stack, testing if it is nonzero (true).
  If it is zero (false), control passes to the **%e** (else) part.
* It is possible to form else-if's a la Algol 68:
      **%?** c\d1\u **%t** b\d1\u **%e** c\d2\u **%t** b\d2\u **%e** c\d3\u **%t** b\d3\u **%e** c\d4\u **%t** b\d4\u **%e** **%;**
* where c\di\u are conditions, b\di\u are bodies.
* Use the **-f** option of **tic** or **infocmp** to see
  the structure of if-then-else's.
  Some strings, e.g., **sgr** can be very complicated when written
  on one line.
  The **-f** option splits the string into lines with the parts indented.

Binary operations are in postfix form with the operands in the usual order.
That is, to get x-5 one would use "%gx%{5}%-".
**%P** and **%g** variables are
persistent across escape-string evaluations.

Consider the HP2645, which, to get to row 3 and column 12, needs
to be sent \eE&a12c03Y padded for 6 milliseconds.
Note that the order
of the rows and columns is inverted here, and that the row and column
are printed as two digits.
Thus its **cup** capability is \`cup=6\eE&%p2%2dc%p1%2dY\*(''.

The Microterm \s-1ACT-IV\s0 needs the current row and column sent
preceded by a **^T**, with the row and column simply encoded in binary,
\`cup=^T%p1%c%p2%c\*(''.
Terminals which use \`%c\*('' need to be able to
backspace the cursor (**cub1**),
and to move the cursor up one line on the screen (**cuu1**).
This is necessary because it is not always safe to transmit **\en**
**^D** and **\er**, as the system may change or discard them.
(The library routines dealing with terminfo set tty modes so that
tabs are never expanded, so \et is safe to send.
This turns out to be essential for the Ann Arbor 4080.)

A final example is the \s-1LSI ADM\s0-3a, which uses row and column
offset by a blank character, thus \`cup=\eE=%p1%' '%+%c%p2%' '%+%c\*(''.
After sending \`\eE=\*('', this pushes the first parameter, pushes the
ASCII value for a space (32), adds them (pushing the sum on the stack
in place of the two previous values) and outputs that value as a character.
Then the same is done for the second parameter.
More complex arithmetic is possible using the stack.


<a name="cursor-motions"></a>

### Cursor Motions


If the terminal has a fast way to home the cursor
(to very upper left corner of screen) then this can be given as
**home**; similarly a fast way of getting to the lower left-hand corner
can be given as **ll**; this may involve going up with **cuu1**
from the home position,
but a program should never do this itself (unless **ll** does) because it
can make no assumption about the effect of moving up from the home position.
Note that the home position is the same as addressing to (0,0):
to the top left corner of the screen, not of memory.
(Thus, the \eEH sequence on HP terminals cannot be used for
**home**.)

If the terminal has row or column absolute cursor addressing,
these can be given as single parameter capabilities
**hpa**
(horizontal position absolute)
and
**vpa**
(vertical position absolute).
Sometimes these are shorter than the more general two parameter
sequence (as with the hp2645) and can be used in preference to
**cup**.
If there are parameterized local motions (e.g., move
_n_
spaces to the right) these can be given as
**cud**,
**cub**,
**cuf**,
and
**cuu**
with a single parameter indicating how many spaces to move.
These are primarily useful if the terminal does not have
**cup**,
such as the \s-1TEKTRONIX\s+1 4025.

If the terminal needs to be in a special mode when running
a program that uses these capabilities,
the codes to enter and exit this mode can be given as **smcup** and **rmcup**.
This arises, for example, from terminals like the Concept with more than
one page of memory.
If the terminal has only memory relative cursor addressing and not screen
relative cursor addressing, a one screen-sized window must be fixed into
the terminal for cursor addressing to work properly.
This is also used for the \s-1TEKTRONIX\s+1 4025,
where
**smcup**
sets the command character to be the one used by terminfo.
If the **smcup** sequence will not restore the screen after an
**rmcup** sequence is output (to the state prior to outputting
**rmcup**), specify **nrrmc**.


<a name="area-clears"></a>

### Area Clears


If the terminal can clear from the current position to the end of the
line, leaving the cursor where it is, this should be given as **el**.
If the terminal can clear from the beginning of the line to the current
position inclusive, leaving
the cursor where it is, this should be given as **el1**.
If the terminal can clear from the current position to the end of the
display, then this should be given as **ed**.
**Ed** is only defined from the first column of a line.
(Thus, it can be simulated by a request to delete a large number of lines,
if a true
**ed**
is not available.)


<a name="insertdelete-line-and-vertical-motions"></a>

### Insert/delete line and vertical motions


If the terminal can open a new blank line before the line where the cursor
is, this should be given as **il1**; this is done only from the first
position of a line.
The cursor must then appear on the newly blank line.
If the terminal can delete the line which the cursor is on, then this
should be given as **dl1**; this is done only from the first position on
the line to be deleted.
Versions of
**il1**
and
**dl1**
which take a single parameter and insert or delete that many lines can
be given as
**il**
and
**dl**.

If the terminal has a settable scrolling region (like the vt100)
the command to set this can be described with the
**csr**
capability, which takes two parameters:
the top and bottom lines of the scrolling region.
The cursor position is, alas, undefined after using this command.

It is possible to get the effect of insert or delete line using
**csr**
on a properly chosen region; the
**sc**
and
**rc**
(save and restore cursor) commands may be useful for ensuring that
your synthesized insert/delete string does not move the cursor.
(Note that the **ncurses**(3X) library does this synthesis
automatically, so you need not compose insert/delete strings for
an entry with **csr**).

Yet another way to construct insert and delete might be to use a combination of
index with the memory-lock feature found on some terminals (like the HP-700/90
series, which however also has insert/delete).

Inserting lines at the top or bottom of the screen can also be
done using
**ri**
or
**ind**
on many terminals without a true insert/delete line,
and is often faster even on terminals with those features.

The boolean **non\_dest\_scroll\_region** should be set if each scrolling
window is effectively a view port on a screen-sized canvas.
To test for
this capability, create a scrolling region in the middle of the screen,
write something to the bottom line, move the cursor to the top of the region,
and do **ri** followed by **dl1** or **ind**.
If the data scrolled
off the bottom of the region by the **ri** re-appears, then scrolling
is non-destructive.
System V and XSI Curses expect that **ind**, **ri**,
**indn**, and **rin** will simulate destructive scrolling; their
documentation cautions you not to define **csr** unless this is true.
This **curses** implementation is more liberal and will do explicit erases
after scrolling if **ndsrc** is defined.

If the terminal has the ability to define a window as part of
memory, which all commands affect,
it should be given as the parameterized string
**wind**.
The four parameters are the starting and ending lines in memory
and the starting and ending columns in memory, in that order.

If the terminal can retain display memory above, then the
**da** capability should be given; if display memory can be retained
below, then **db** should be given.
These indicate
that deleting a line or scrolling may bring non-blank lines up from below
or that scrolling back with **ri** may bring down non-blank lines.


<a name="insertdelete-character"></a>

### Insert/Delete Character


There are two basic kinds of intelligent terminals with respect to
insert/delete character which can be described using
_terminfo._
The most common insert/delete character operations affect only the characters
on the current line and shift characters off the end of the line rigidly.
Other terminals, such as the Concept 100 and the Perkin Elmer Owl, make
a distinction between typed and untyped blanks on the screen, shifting
upon an insert or delete only to an untyped blank on the screen which is
either eliminated, or expanded to two untyped blanks.

You can determine the
kind of terminal you have by clearing the screen and then typing
text separated by cursor motions.
Type \`abc&nbsp;&nbsp;&nbsp;&nbsp;def\*('' using local
cursor motions (not spaces) between the \`abc\*('' and the \*(\`\`def\*(''.
Then position the cursor before the \`abc\*('' and put the terminal in insert
mode.
If typing characters causes the rest of the line to shift
rigidly and characters to fall off the end, then your terminal does
not distinguish between blanks and untyped positions.
If the \`abc\*(''
shifts over to the \`def\*('' which then move together around the end of the
current line and onto the next as you insert, you have the second type of
terminal, and should give the capability **in**, which stands for
\`insert null\*(''.

While these are two logically separate attributes (one line versus multi-line
insert mode, and special treatment of untyped spaces) we have seen no
terminals whose insert mode cannot be described with the single attribute.

Terminfo can describe both terminals which have an insert mode, and terminals
which send a simple sequence to open a blank position on the current line.
Give as **smir** the sequence to get into insert mode.
Give as **rmir** the sequence to leave insert mode.
Now give as **ich1** any sequence needed to be sent just before sending
the character to be inserted.
Most terminals with a true insert mode
will not give **ich1**; terminals which send a sequence to open a screen
position should give it here.

If your terminal has both, insert mode is usually preferable to **ich1**.
Technically, you should not give both unless the terminal actually requires
both to be used in combination.
Accordingly, some non-curses applications get
confused if both are present; the symptom is doubled characters in an update
using insert.
This requirement is now rare; most **ich** sequences do not
require previous smir, and most smir insert modes do not require **ich1**
before each character.
Therefore, the new **curses** actually assumes this
is the case and uses either **rmir**/**smir** or **ich**/**ich1** as
appropriate (but not both).
If you have to write an entry to be used under
new curses for a terminal old enough to need both, include the
**rmir**/**smir** sequences in **ich1**.

If post insert padding is needed, give this as a number of milliseconds
in **ip** (a string option).
Any other sequence which may need to be
sent after an insert of a single character may also be given in **ip**.
If your terminal needs both to be placed into an \`insert mode\*('' and
a special code to precede each inserted character, then both
**smir**/**rmir**
and
**ich1**
can be given, and both will be used.
The
**ich**
capability, with one parameter,
_n_,
will repeat the effects of
**ich1**
_n_
times.

If padding is necessary between characters typed while not
in insert mode, give this as a number of milliseconds padding in **rmp**.

It is occasionally necessary to move around while in insert mode
to delete characters on the same line (e.g., if there is a tab after
the insertion position).
If your terminal allows motion while in
insert mode you can give the capability **mir** to speed up inserting
in this case.
Omitting **mir** will affect only speed.
Some terminals
(notably Datamedia's) must not have **mir** because of the way their
insert mode works.

Finally, you can specify
**dch1**
to delete a single character,
**dch**
with one parameter,
_n_,
to delete
_n characters,_
and delete mode by giving **smdc** and **rmdc**
to enter and exit delete mode (any mode the terminal needs to be placed
in for
**dch1**
to work).

A command to erase
_n_
characters (equivalent to outputting
_n_
blanks without moving the cursor)
can be given as
**ech**
with one parameter.


<a name="highlighting-underlining-and-visible-bells"></a>

### Highlighting, Underlining, and Visible Bells


If your terminal has one or more kinds of display attributes,
these can be represented in a number of different ways.
You should choose one display form as
_standout mode_,
representing a good, high contrast, easy-on-the-eyes,
format for highlighting error messages and other attention getters.
(If you have a choice, reverse video plus half-bright is good,
or reverse video alone.)
The sequences to enter and exit standout mode
are given as **smso** and **rmso**, respectively.
If the code to change into or out of standout
mode leaves one or even two blank spaces on the screen,
as the TVI 912 and Teleray 1061 do,
then **xmc** should be given to tell how many spaces are left.

Codes to begin underlining and end underlining can be given as **smul**
and **rmul** respectively.
If the terminal has a code to underline the current character and move
the cursor one space to the right,
such as the Microterm Mime,
this can be given as **uc**.

Other capabilities to enter various highlighting modes include
**blink**
(blinking)
**bold**
(bold or extra bright)
**dim**
(dim or half-bright)
**invis**
(blanking or invisible text)
**prot**
(protected)
**rev**
(reverse video)
**sgr0**
(turn off
_all_
attribute modes)
**smacs**
(enter alternate character set mode)
and
**rmacs**
(exit alternate character set mode).
Turning on any of these modes singly may or may not turn off other modes.

If there is a sequence to set arbitrary combinations of modes,
this should be given as
**sgr**
(set attributes),
taking 9 parameters.
Each parameter is either 0 or nonzero, as the corresponding attribute is on or off.
The 9 parameters are, in order:
standout, underline, reverse, blink, dim, bold, blank, protect, alternate
character set.
Not all modes need be supported by
**sgr**,
only those for which corresponding separate attribute commands exist.

For example, the DEC vt220 supports most of the modes:

.TS
center;
l l l
l l l
lw18 lw14 l.
**tparm parameter	attribute	escape sequence**

none	none	\\E[0m
p1	standout	\\E[0;1;7m
p2	underline	\\E[0;4m
p3	reverse	\\E[0;7m
p4	blink	\\E[0;5m
p5	dim	not available
p6	bold	\\E[0;1m
p7	invis	\\E[0;8m
p8	protect	not used
p9	altcharset	^O (off) ^N (on)
.TE

We begin each escape sequence by turning off any existing modes, since
there is no quick way to determine whether they are active.
Standout is set up to be the combination of reverse and bold.
The vt220 terminal has a protect mode,
though it is not commonly used in sgr
because it protects characters on the screen from the host's erasures.
The altcharset mode also is different in that it is either ^O or ^N,
depending on whether it is off or on.
If all modes are turned on, the resulting sequence is \\E[0;1;4;5;7;8m^N.

Some sequences are common to different modes.
For example, ;7 is output when either p1 or p3 is true, that is, if
either standout or reverse modes are turned on.

Writing out the above sequences, along with their dependencies yields

.ne 11
.TS
center;
l l l
l l l
lw18 lw14 l.
**sequence	when to output	terminfo translation**

\\E[0	always	\\E[0
;1	if p1 or p6	%?%p1%p6%|%t;1%;
;4	if p2	%?%p2%|%t;4%;
;5	if p4	%?%p4%|%t;5%;
;7	if p1 or p3	%?%p1%p3%|%t;7%;
;8	if p7	%?%p7%|%t;8%;
m	always	m
^N or ^O	if p9 ^N, else ^O	%?%p9%t^N%e^O%;
.TE

Putting this all together into the sgr sequence gives:

        sgr=\E[0%?%p1%p6%|%t;1%;%?%p2%t;4%;%?%p4%t;5%;
            %?%p1%p3%|%t;7%;%?%p7%t;8%;m%?%p9%t\016%e\017%;,

Remember that if you specify sgr, you must also specify sgr0.
Also, some implementations rely on sgr being given if sgr0 is,
Not all terminfo entries necessarily have an sgr string, however.
Many terminfo entries are derived from termcap entries
which have no sgr string.
The only drawback to adding an sgr string is that termcap also
assumes that sgr0 does not exit alternate character set mode.

Terminals with the \`magic cookie\*('' glitch
(**xmc**)
deposit special \`cookies\*('' when they receive mode-setting sequences,
which affect the display algorithm rather than having extra bits for
each character.
Some terminals, such as the HP 2621, automatically leave standout
mode when they move to a new line or the cursor is addressed.
Programs using standout mode should exit standout mode before
moving the cursor or sending a newline,
unless the
**msgr**
capability, asserting that it is safe to move in standout mode, is present.

If the terminal has
a way of flashing the screen to indicate an error quietly (a bell replacement)
then this can be given as **flash**; it must not move the cursor.

If the cursor needs to be made more visible than normal when it is
not on the bottom line (to make, for example, a non-blinking underline into an
easier to find block or blinking underline)
give this sequence as
**cvvis**.
If there is a way to make the cursor completely invisible, give that as
**civis**.
The capability
**cnorm**
should be given which undoes the effects of both of these modes.

If your terminal correctly generates underlined characters
(with no special codes needed)
even though it does not overstrike,
then you should give the capability **ul**.
If a character overstriking another leaves both characters on the screen,
specify the capability **os**.
If overstrikes are erasable with a blank,
then this should be indicated by giving **eo**.


<a name="keypad-and-function-keys"></a>

### Keypad and Function Keys


If the terminal has a keypad that transmits codes when the keys are pressed,
this information can be given.
Note that it is not possible to handle
terminals where the keypad only works in local (this applies, for example,
to the unshifted HP 2621 keys).
If the keypad can be set to transmit or not transmit,
give these codes as **smkx** and **rmkx**.
Otherwise the keypad is assumed to always transmit.

The codes sent by the left arrow, right arrow, up arrow, down arrow,
and home keys can be given as
**kcub1, kcuf1, kcuu1, kcud1, **and** khome** respectively.
If there are function keys such as f0, f1, ..., f10, the codes they send
can be given as **kf0, kf1, ..., kf10**.
If these keys have labels other than the default f0 through f10, the labels
can be given as **lf0, lf1, ..., lf10**.

The codes transmitted by certain other special keys can be given:
.bP
**kll**
(home down),
.bP
**kbs**
(backspace),
.bP
**ktbc**
(clear all tabs),
.bP
**kctab**
(clear the tab stop in this column),
.bP
**kclr**
(clear screen or erase key),
.bP
**kdch1**
(delete character),
.bP
**kdl1**
(delete line),
.bP
**krmir**
(exit insert mode),
.bP
**kel**
(clear to end of line),
.bP
**ked**
(clear to end of screen),
.bP
**kich1**
(insert character or enter insert mode),
.bP
**kil1**
(insert line),
.bP
**knp**
(next page),
.bP
**kpp**
(previous page),
.bP
**kind**
(scroll forward/down),
.bP
**kri**
(scroll backward/up),
.bP
**khts**
(set a tab stop in this column).

In addition, if the keypad has a 3 by 3 array of keys including the four
arrow keys, the other five keys can be given as
**ka1**,
**ka3**,
**kb2**,
**kc1**,
and
**kc3**.
These keys are useful when the effects of a 3 by 3 directional pad are needed.

Strings to program function keys can be given as
**pfkey**,
**pfloc**,
and
**pfx**.
A string to program screen labels should be specified as **pln**.
Each of these strings takes two parameters: the function key number to
program (from 0 to 10) and the string to program it with.
Function key numbers out of this range may program undefined keys in
a terminal dependent manner.
The difference between the capabilities is that
**pfkey**
causes pressing the given key to be the same as the user typing the
given string;
**pfloc**
causes the string to be executed by the terminal in local; and
**pfx**
causes the string to be transmitted to the computer.

The capabilities **nlab**, **lw** and **lh**
define the number of programmable
screen labels and their width and height.
If there are commands to turn the labels on and off,
give them in **smln** and **rmln**.
**smln** is normally output after one or more pln
sequences to make sure that the change becomes visible.


<a name="tabs-and-initialization"></a>

### Tabs and Initialization


If the terminal has hardware tabs, the command to advance to the next
tab stop can be given as
**ht**
(usually control I).
A \`back-tab\*('' command which moves leftward to the preceding tab stop can
be given as
**cbt**.
By convention, if the teletype modes indicate that tabs are being
expanded by the computer rather than being sent to the terminal,
programs should not use
**ht**
or
**cbt**
even if they are present, since the user may not have the tab stops
properly set.
If the terminal has hardware tabs which are initially set every
_n_
spaces when the terminal is powered up,
the numeric parameter
**it**
is given, showing the number of spaces the tabs are set to.
This is normally used by the **tset**
command to determine whether to set the mode for hardware tab expansion,
and whether to set the tab stops.
If the terminal has tab stops that can be saved in non-volatile memory,
the terminfo description can assume that they are properly set.

Other capabilities
include
**is1**,
**is2**,
and
**is3**,
initialization strings for the terminal,
**iprog**,
the path name of a program to be run to initialize the terminal,
and **if**, the name of a file containing long initialization strings.
These strings are expected to set the terminal into modes consistent
with the rest of the terminfo description.
They are normally sent to the terminal, by the
_init_
option of the **tput** program, each time the user logs in.
They will be printed in the following order:

* run the program  
  **iprog**
* output  
  **is1**
  **is2**
* set the margins using  
  **mgc**,
  **smgl**
  and
  **smgr**
* set tabs using  
  **tbc**
  and
  **hts**
* print the file  
  **if**
* and finally  
  output
  **is3**.

Most initialization is done with
**is2**.
Special terminal modes can be set up without duplicating strings
by putting the common sequences in
**is2**
and special cases in
**is1**
and
**is3**.

A set of sequences that does a harder reset from a totally unknown state
can be given as
**rs1**,
**rs2**,
**rf**
and
**rs3**,
analogous to
**is1 ,**
**is2 ,**
**if**
and
**is3**
respectively.
These strings are output by the **reset** program,
which is used when the terminal gets into a wedged state.
Commands are normally placed in
**rs1**,
**rs2**
**rs3**
and
**rf**
only if they produce annoying effects on the screen and are not
necessary when logging in.
For example, the command to set the vt100 into 80-column mode would
normally be part of
**is2**,
but it causes an annoying glitch of the screen and is not normally
needed since the terminal is usually already in 80 column mode.

The **reset** program writes strings including
**iprog**,
etc., in the same order as the
_init_
program, using 
**rs1**,
etc., instead of
**is1**,
etc.
If any of
**rs1**,
**rs2**,
**rs3**,
or
**rf**
reset capability strings are missing, the **reset** 
program falls back upon the corresponding initialization capability string.

If there are commands to set and clear tab stops, they can be given as
**tbc**
(clear all tab stops)
and
**hts**
(set a tab stop in the current column of every row).
If a more complex sequence is needed to set the tabs than can be
described by this, the sequence can be placed in
**is2**
or
**if**.

<a name="delays-and-padding"></a>

### Delays and Padding


Many older and slower terminals do not support either XON/XOFF or DTR
handshaking, including hard copy terminals and some very archaic CRTs
(including, for example, DEC VT100s).
These may require padding characters
after certain cursor motions and screen changes.

If the terminal uses xon/xoff handshaking for flow control (that is,
it automatically emits ^S back to the host when its input buffers are
close to full), set
**xon**.
This capability suppresses the emission of padding.
You can also set it
for memory-mapped console devices effectively that do not have a speed limit.
Padding information should still be included so that routines can
make better decisions about relative costs, but actual pad characters will
not be transmitted.

If **pb** (padding baud rate) is given, padding is suppressed at baud rates
below the value of **pb**.
If the entry has no padding baud rate, then
whether padding is emitted or not is completely controlled by **xon**.

If the terminal requires other than a null (zero) character as a pad,
then this can be given as **pad**.
Only the first character of the
**pad**
string is used.


<a name="status-lines"></a>

### Status Lines

Some terminals have an extra \`status line\*('' which is not normally used by
software (and thus not counted in the terminal's **lines** capability).

The simplest case is a status line which is cursor-addressable but not
part of the main scrolling region on the screen; the Heathkit H19 has
a status line of this kind, as would a 24-line VT100 with a 23-line
scrolling region set up on initialization.
This situation is indicated
by the **hs** capability.

Some terminals with status lines need special sequences to access the
status line.
These may be expressed as a string with single parameter
**tsl** which takes the cursor to a given zero-origin column on the
status line.
The capability **fsl** must return to the main-screen
cursor positions before the last **tsl**.
You may need to embed the
string values of **sc** (save cursor) and **rc** (restore cursor)
in **tsl** and **fsl** to accomplish this.

The status line is normally assumed to be the same width as the width
of the terminal.
If this is untrue, you can specify it with the numeric
capability **wsl**.

A command to erase or blank the status line may be specified as **dsl**.

The boolean capability **eslok** specifies that escape sequences, tabs,
etc., work ordinarily in the status line.

The **ncurses** implementation does not yet use any of these capabilities.
They are documented here in case they ever become important.


<a name="line-graphics"></a>

### Line Graphics


Many terminals have alternate character sets useful for forms-drawing.
Terminfo and **curses** have built-in support
for most of the drawing characters
supported by the VT100, with some characters from the AT&T 4410v1 added.
This alternate character set may be specified by the **acsc** capability.

.TS H
center;
l l l l l
l l l l l
_ _ _ _ _
lw25 lw10 lw6 lw6 l.

**Glyph	ACS	Ascii	acsc	acsc**
**Name	Name	Default	Char	Value**
arrow pointing right	ACS_RARROW	&gt;	+	0x2b
arrow pointing left	ACS_LARROW	&lt;	,	0x2c
arrow pointing up	ACS_UARROW	^	-	0x2d
arrow pointing down	ACS_DARROW	v	.	0x2e
solid square block	ACS_BLOCK	#	0	0x30
diamond         	ACS_DIAMOND	+	\`	0x60
checker board (stipple)	ACS_CKBOARD	:	a	0x61
degree symbol   	ACS_DEGREE	\e	f	0x66
plus/minus      	ACS_PLMINUS	#	g	0x67
board of squares	ACS_BOARD	#	h	0x68
lantern symbol  	ACS_LANTERN	#	i	0x69
lower right corner	ACS_LRCORNER	+	j	0x6a
upper right corner	ACS_URCORNER	+	k	0x6b
upper left corner	ACS_ULCORNER	+	l	0x6c
lower left corner	ACS_LLCORNER	+	m	0x6d
large plus or crossover	ACS_PLUS	+	n	0x6e
scan line 1     	ACS_S1  	~	o	0x6f
scan line 3     	ACS_S3  	-	p	0x70
horizontal line 	ACS_HLINE	-	q	0x71
scan line 7     	ACS_S7  	-	r	0x72
scan line 9     	ACS_S9  	_	s	0x73
tee pointing right	ACS_LTEE	+	t	0x74
tee pointing left	ACS_RTEE	+	u	0x75
tee pointing up 	ACS_BTEE	+	v	0x76
tee pointing down	ACS_TTEE	+	w	0x77
vertical line   	ACS_VLINE	|	x	0x78
less-than-or-equal-to	ACS_LEQUAL	&lt;	y	0x79
greater-than-or-equal-to	ACS_GEQUAL	&gt;	z	0x7a
greek pi        	ACS_PI	*	{	0x7b
not-equal       	ACS_NEQUAL	!	|	0x7c
UK pound sign        	ACS_STERLING	f	}	0x7d
bullet          	ACS_BULLET	o	~	0x7e
.TE

A few notes apply to the table itself:
.bP
X/Open Curses incorrectly states that the mapping for _lantern_ is
uppercase \`I\*('' although Unix implementations use the
lowercase \`i\*('' mapping.
.bP
The DEC VT100 implemented graphics using the alternate character set
feature, temporarily switching _modes_ and sending characters
in the range 0x60 (96) to 0x7e (126)
(the **acsc Value** column in the table).
.bP
The AT&T terminal added graphics characters outside that range.

* Some of the characters within the range do not match the VT100;
  presumably they were used in the AT&T terminal:
  _board of squares_ replaces the VT100 _newline_ symbol, while
  _lantern symbol_ replaces the VT100 _vertical tab_ symbol.
  The other VT100 symbols for control characters (_horizontal tab_,
  _carriage return_ and _line-feed_) are not (re)used in curses.

The best way to define a new device's graphics set is to add a column
to a copy of this table for your terminal, giving the character which
(when emitted between **smacs**/**rmacs** switches) will be rendered
as the corresponding graphic.
Then read off the VT100/your terminal
character pairs right to left in sequence; these become the ACSC string.


<a name="color-handling"></a>

### Color Handling


The curses library functions **init\_pair** and **init\_color**
manipulate the _color pairs_ and _color values_ discussed in this
section
(see **curs\_color**(3X) for details on these and related functions).

Most color terminals are either \`Tektronix-like\*('' or \*(\`\`HP-like\*('':
.bP
Tektronix-like
terminals have a predefined set of _N_ colors
(where _N_ is usually 8),
and can set
character-cell foreground and background characters independently, mixing them
into _N_&nbsp;*&nbsp;_N_ color-pairs.
.bP
On HP-like terminals, the user must set each color
pair up separately (foreground and background are not independently settable).
Up to _M_ color-pairs may be set up from 2*_M_ different colors.
ANSI-compatible terminals are Tektronix-like.

Some basic color capabilities are independent of the color method.
The numeric
capabilities **colors** and **pairs** specify the maximum numbers of colors
and color-pairs that can be displayed simultaneously.
The **op** (original
pair) string resets foreground and background colors to their default values
for the terminal.
The **oc** string resets all colors or color-pairs to
their default values for the terminal.
Some terminals (including many PC
terminal emulators) erase screen areas with the current background color rather
than the power-up default background; these should have the boolean capability
**bce**.

While the curses library works with _color pairs_
(reflecting the inability of some devices to set foreground
and background colors independently),
there are separate capabilities for setting these features:
.bP
To change the current foreground or background color on a Tektronix-type
terminal, use **setaf** (set ANSI foreground) and **setab** (set ANSI
background) or **setf** (set foreground) and **setb** (set background).
These take one parameter, the color number.
The SVr4 documentation describes
only **setaf**/**setab**; the XPG4 draft says that "If the terminal
supports ANSI escape sequences to set background and foreground, they should
be coded as **setaf** and **setab**, respectively.
.bP
If the terminal
supports other escape sequences to set background and foreground, they should
be coded as **setf** and **setb**, respectively.
The **vidputs** and the **refresh**(3X) functions
use the **setaf** and **setab** capabilities if they are defined.

The **setaf**/**setab** and **setf**/**setb** capabilities take a
single numeric argument each.
Argument values 0-7 of **setaf**/**setab** are portably defined as
follows (the middle column is the symbolic #define available in the header for
the **curses** or **ncurses** libraries).
The terminal hardware is free to
map these as it likes, but the RGB values indicate normal locations in color
space.

.TS H
center;
l c c c
l l n l.
**Color	#define 	Value	RGB**
black	**COLOR\_BLACK**	0	0, 0, 0
red	**COLOR_RED&nbsp;**	1	max,0,0
green	**COLOR\_GREEN**	2	0,max,0
yellow	**COLOR\_YELLOW**	3	max,max,0
blue	**COLOR\_BLUE**	4	0,0,max
magenta	**COLOR\_MAGENTA**	5	max,0,max
cyan	**COLOR\_CYAN**	6	0,max,max
white	**COLOR\_WHITE**	7	max,max,max
.TE

The argument values of **setf**/**setb** historically correspond to
a different mapping, i.e.,
.TS H
center;
l c c c
l l n l.
**Color	#define 	Value	RGB**
black	**COLOR\_BLACK**	0	0, 0, 0
blue	**COLOR\_BLUE**	1	0,0,max
green	**COLOR\_GREEN**	2	0,max,0
cyan	**COLOR\_CYAN**	3	0,max,max
red	**COLOR_RED&nbsp;**	4	max,0,0
magenta	**COLOR\_MAGENTA**	5	max,0,max
yellow	**COLOR\_YELLOW**	6	max,max,0
white	**COLOR\_WHITE**	7	max,max,max
.TE

It is important to not confuse the two sets of color capabilities;
otherwise red/blue will be interchanged on the display.

On an HP-like terminal, use **scp** with a color-pair number parameter to set
which color pair is current.

Some terminals allow the _color values_ to be modified:
.bP
On a Tektronix-like terminal, the capability **ccc** may be present to
indicate that colors can be modified.
If so, the **initc** capability will
take a color number (0 to **colors** - 1)and three more parameters which
describe the color.
These three parameters default to being interpreted as RGB
(Red, Green, Blue) values.
If the boolean capability **hls** is present,
they are instead as HLS (Hue, Lightness, Saturation) indices.
The ranges are
terminal-dependent.
.bP
On an HP-like terminal, **initp** may give a capability for changing a
color-pair value.
It will take seven parameters; a color-pair number (0 to
**max\_pairs** - 1), and two triples describing first background and then
foreground colors.
These parameters must be (Red, Green, Blue) or
(Hue, Lightness, Saturation) depending on **hls**.

On some color terminals, colors collide with highlights.
You can register
these collisions with the **ncv** capability.
This is a bit-mask of
attributes not to be used when colors are enabled.
The correspondence with the
attributes understood by **curses** is as follows:

.TS
center;
l l l l
lw20 lw2 lw10 l.
**Attribute	Bit	Decimal	Set by**
A_STANDOUT	0	1	sgr
A_UNDERLINE	1	2	sgr
A_REVERSE	2	4	sgr
A_BLINK   	3	8	sgr
A_DIM      	4	16	sgr
A_BOLD    	5	32	sgr
A_INVIS   	6	64	sgr
A_PROTECT	7	128	sgr
A_ALTCHARSET	8	256	sgr
A_HORIZONTAL	9	512	sgr1
A_LEFT	10	1024	sgr1
A_LOW	11	2048	sgr1
A_RIGHT	12	4096	sgr1
A_TOP	13	8192	sgr1
A_VERTICAL	14	16384	sgr1
A_ITALIC	15	32768	sitm
.TE

For example, on many IBM PC consoles, the underline attribute collides with the
foreground color blue and is not available in color mode.
These should have
an **ncv** capability of 2.

SVr4 curses does nothing with **ncv**, ncurses recognizes it and optimizes
the output in favor of colors.


<a name="miscellaneous"></a>

### Miscellaneous

If the terminal requires other than a null (zero) character as a pad, then this
can be given as pad.
Only the first character of the pad string is used.
If the terminal does not have a pad character, specify npc.
Note that ncurses implements the termcap-compatible **PC** variable;
though the application may set this value to something other than
a null, ncurses will test **npc** first and use napms if the terminal
has no pad character.

If the terminal can move up or down half a line,
this can be indicated with
**hu**
(half-line up)
and
**hd**
(half-line down).
This is primarily useful for superscripts and subscripts on hard-copy terminals.
If a hard-copy terminal can eject to the next page (form feed), give this as
**ff**
(usually control L).

If there is a command to repeat a given character a given number of
times (to save time transmitting a large number of identical characters)
this can be indicated with the parameterized string
**rep**.
The first parameter is the character to be repeated and the second
is the number of times to repeat it.
Thus, tparm(repeat_char, 'x', 10) is the same as \`xxxxxxxxxx\*(''.

If the terminal has a settable command character, such as the \s-1TEKTRONIX\s+1 4025,
this can be indicated with
**cmdch**.
A prototype command character is chosen which is used in all capabilities.
This character is given in the
**cmdch**
capability to identify it.
The following convention is supported on some UNIX systems:
The environment is to be searched for a
**CC**
variable, and if found, all
occurrences of the prototype character are replaced with the character
in the environment variable.

Terminal descriptions that do not represent a specific kind of known
terminal, such as
_switch_,
_dialup_,
_patch_,
and
_network_,
should include the
**gn**
(generic) capability so that programs can complain that they do not know
how to talk to the terminal.
(This capability does not apply to
_virtual_
terminal descriptions for which the escape sequences are known.)

If the terminal has a \`meta key\*('' which acts as a shift key,
setting the 8th bit of any character transmitted, this fact can
be indicated with
**km**.
Otherwise, software will assume that the 8th bit is parity and it
will usually be cleared.
If strings exist to turn this \`meta mode\*('' on and off, they
can be given as
**smm**
and
**rmm**.

If the terminal has more lines of memory than will fit on the screen
at once, the number of lines of memory can be indicated with
**lm**.
A value of
**lm**#0
indicates that the number of lines is not fixed,
but that there is still more memory than fits on the screen.

If the terminal is one of those supported by the \s-1UNIX\s+1 virtual
terminal protocol, the terminal number can be given as
**vt**.

Media copy
strings which control an auxiliary printer connected to the terminal
can be given as
**mc0**:
print the contents of the screen,
**mc4**:
turn off the printer, and
**mc5**:
turn on the printer.
When the printer is on, all text sent to the terminal will be sent
to the printer.
It is undefined whether the text is also displayed on the terminal screen
when the printer is on.
A variation
**mc5p**
takes one parameter, and leaves the printer on for as many characters
as the value of the parameter, then turns the printer off.
The parameter should not exceed 255.
All text, including
**mc4**,
is transparently passed to the printer while an
**mc5p**
is in effect.


<a name="glitches-and-braindamage"></a>

### Glitches and Braindamage


Hazeltine terminals, which do not allow \`~\*('' characters to be displayed should
indicate **hz**.

Terminals which ignore a line-feed immediately after an **am** wrap,
such as the Concept and vt100,
should indicate **xenl**.

If
**el**
is required to get rid of standout
(instead of merely writing normal text on top of it),
**xhp** should be given.

Teleray terminals, where tabs turn all characters moved over to blanks,
should indicate **xt** (destructive tabs).
Note: the variable indicating this is now \`dest_tabs_magic_smso\*(''; in
older versions, it was teleray_glitch.
This glitch is also taken to mean that it is not possible to position
the cursor on top of a \`magic cookie\*('',
that to erase standout mode it is instead necessary to use
delete and insert line.
The ncurses implementation ignores this glitch.

The Beehive Superbee, which is unable to correctly transmit the escape
or control C characters, has
**xsb**,
indicating that the f1 key is used for escape and f2 for control C.
(Only certain Superbees have this problem, depending on the ROM.)
Note that in older terminfo versions, this capability was called
\`beehive_glitch\*(''; it is now \*(\`\`no_esc_ctl_c\*(''.

Other specific terminal problems may be corrected by adding more
capabilities of the form **x**_x_.


<a name="pitfalls-of-long-entries"></a>

### Pitfalls of Long Entries


Long terminfo entries are unlikely to be a problem; to date, no entry has even
approached terminfo's 4096-byte string-table maximum.
Unfortunately, the termcap
translations are much more strictly limited (to 1023 bytes), thus termcap translations
of long terminfo entries can cause problems.

The man pages for 4.3BSD and older versions of **tgetent** instruct the user to
allocate a 1024-byte buffer for the termcap entry.
The entry gets null-terminated by
the termcap library, so that makes the maximum safe length for a termcap entry
1k-1 (1023) bytes.
Depending on what the application and the termcap library
being used does, and where in the termcap file the terminal type that **tgetent**
is searching for is, several bad things can happen.

Some termcap libraries print a warning message or exit if they find an
entry that's longer than 1023 bytes; others do not; others truncate the
entries to 1023 bytes.
Some application programs allocate more than
the recommended 1K for the termcap entry; others do not.

Each termcap entry has two important sizes associated with it: before
"tc" expansion, and after "tc" expansion.
"tc" is the capability that
tacks on another termcap entry to the end of the current one, to add
on its capabilities.
If a termcap entry does not use the "tc"
capability, then of course the two lengths are the same.

The "before tc expansion" length is the most important one, because it
affects more than just users of that particular terminal.
This is the
length of the entry as it exists in /etc/termcap, minus the
backslash-newline pairs, which **tgetent** strips out while reading it.
Some termcap libraries strip off the final newline, too (GNU termcap does not).
Now suppose:
.bP
a termcap entry before expansion is more than 1023 bytes long,
.bP
and the application has only allocated a 1k buffer,
.bP
and the termcap library (like the one in BSD/OS 1.1 and GNU) reads
the whole entry into the buffer, no matter what its length, to see
if it is the entry it wants,
.bP
and **tgetent** is searching for a terminal type that either is the
long entry, appears in the termcap file after the long entry, or
does not appear in the file at all (so that **tgetent** has to search
the whole termcap file).

Then **tgetent** will overwrite memory, perhaps its stack, and probably core dump
the program.
Programs like telnet are particularly vulnerable; modern telnets
pass along values like the terminal type automatically.
The results are almost
as undesirable with a termcap library, like SunOS 4.1.3 and Ultrix 4.4, that
prints warning messages when it reads an overly long termcap entry.
If a
termcap library truncates long entries, like OSF/1 3.0, it is immune to dying
here but will return incorrect data for the terminal.

The "after tc expansion" length will have a similar effect to the
above, but only for people who actually set TERM to that terminal
type, since **tgetent** only does "tc" expansion once it is found the
terminal type it was looking for, not while searching.

In summary, a termcap entry that is longer than 1023 bytes can cause,
on various combinations of termcap libraries and applications, a core
dump, warnings, or incorrect operation.
If it is too long even before
"tc" expansion, it will have this effect even for users of some other
terminal types and users whose TERM variable does not have a termcap
entry.

When in -C (translate to termcap) mode, the **ncurses** implementation of
**tic**(1M) issues warning messages when the pre-tc length of a termcap
translation is too long.
The -c (check) option also checks resolved (after tc
expansion) lengths.

<a name="binary-compatibility"></a>

### Binary Compatibility

It is not wise to count on portability of binary terminfo entries between
commercial UNIX versions.
The problem is that there are at least two versions
of terminfo (under HP-UX and AIX) which diverged from System V terminfo after
SVr1, and have added extension capabilities to the string table that (in the
binary format) collide with System V and XSI Curses extensions.

<a name="extensions"></a>

# Extensions


Searching for terminal descriptions in
**$HOME/.terminfo** and TERMINFO_DIRS 
is not supported by older implementations.

Some SVr4 **curses** implementations, and all previous to SVr4, do not
interpret the %A and %O operators in parameter strings.

SVr4/XPG4 do not specify whether **msgr** licenses movement while in
an alternate-character-set mode (such modes may, among other things, map
CR and NL to characters that do not trigger local motions).
The **ncurses** implementation ignores **msgr** in **ALTCHARSET**
mode.
This raises the possibility that an XPG4
implementation making the opposite interpretation may need terminfo
entries made for **ncurses** to have **msgr** turned off.

The **ncurses** library handles insert-character and insert-character modes
in a slightly non-standard way to get better update efficiency.
See
the **Insert/Delete Character** subsection above.

The parameter substitutions for **set\_clock** and **display\_clock** are
not documented in SVr4 or the XSI Curses standard.
They are deduced from the
documentation for the AT&T 505 terminal.

Be careful assigning the **kmous** capability.
The **ncurses** library wants to interpret it as **KEY\_MOUSE**,
for use by terminals and emulators like xterm
that can return mouse-tracking information in the keyboard-input stream.

X/Open Curses does not mention italics.
Portable applications must assume that numeric capabilities are
signed 16-bit values.
This includes the _no\_color\_video_ (ncv) capability.
The 32768 mask value used for italics with ncv can be confused with
an absent or cancelled ncv.
If italics should work with colors,
then the ncv value must be specified, even if it is zero.

Different commercial ports of terminfo and curses support different subsets of
the XSI Curses standard and (in some cases) different extension sets.
Here
is a summary, accurate as of October 1995:
.bP
**SVR4, Solaris, ncurses** --
These support all SVr4 capabilities.
.bP
**SGI** --
Supports the SVr4 set, adds one undocumented extended string
capability (**set\_pglen**).
.bP
**SVr1, Ultrix** --
These support a restricted subset of terminfo capabilities.
The booleans end with **xon\_xoff**;
the numerics with **width\_status\_line**;
and the strings with **prtr\_non**.
.bP
**HP/UX** --
Supports the SVr1 subset, plus the SVr[234] numerics **num\_labels**,
**label\_height**, **label\_width**, plus function keys 11 through 63, plus
**plab\_norm**, **label\_on**, and **label\_off**, plus some incompatible
extensions in the string table.
.bP
**AIX** --
Supports the SVr1 subset, plus function keys 11 through 63, plus a number
of incompatible string table extensions.
.bP
**OSF** --
Supports both the SVr4 set and the AIX extensions.

<a name="files"></a>

# Files


* /usr/share/terminfo/?/*  
  files containing terminal descriptions

<a name="see-also"></a>

# See Also

**tic**(1M),
**infocmp**(1M),
**curses**(3X),
**curs\_color**(3X),
**printf**(3),
**term**(5).
**term\_variables**(3X).
**user\_caps**(5).

<a name="authors"></a>

# Authors

Zeyd M. Ben-Halim, Eric S. Raymond, Thomas E. Dickey.
Based on pcurses by Pavel Curtis.
