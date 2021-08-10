# report_event\&.conf(5)

LIBREPORT 2\&.14\&.0, 09/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

report_event.conf - configuration file for libreport.

<a name="description"></a>

# Description


This configuration file specifies which programs should be run when the specified event occurs in problem directory lifetime.

It consists of directives and rules.

Directives start with a reserved word. Currently, there is only one directive, "include".

include _FILE_
This directive causes files which match FILE to be read and parsed as if they are inserted textually where this directive occurs. FILE can use shell pattern metacharacters (*,?,etc) to specify multiple files. Relative paths are interpreted relative to current file.

Rule starts with a line with non-space leading character. All subsequent lines which start with space or tab form one rule. Note that separating newline is retained.

Rules may be commented out with #. One # is sufficient to comment out even a multi-line rule (no need to comment out every line).

Rules specify which programs to run on the problem directory. Each rule may have conditions to be checked before the program is run.

Conditions have form VAR=VAL or VAL~=REGEX, where VAR is either word "EVENT" or a name of problem directory element to be checked (for example, "executable", "package", hostname" etc).

If all conditions match, the remaining part of the rule (the "program" part) is run in the shell. All shell language constructs are valid. All stdout and stderr output is captured and passed to ABRT and possibly to ABRT’s frontends and shown to the user.

If the program terminates with nonzero exit code, the event processing is considered unsuccessful and is stopped. Last captured output line, if any, is considered to be the error message indicating the reason of the failure, and may be used by abrt as such.

If the program terminates successfully, next rule is read and processed. This process is repeated until the end of this file.

<a name="event-xml-configuration"></a>

### Event XML configuration


These configuration files provides event meta data.

Each file has XML formatting with the following DTD:

.if n \{.RS 4
.\}
    <!ELEMENT event            (name+,description+,requires-items?,exclude-items-by-default?,exclude-items-always?,exclude-binary-items?,include-items-by-default?,minimal-rating?,gui-review-elements?,options?)>
    <!ELEMENT name             (#PCDATA)>
    <!ATTLIST name             xml:lang CDATA #IMPLIED>
    <!ELEMENT description      (#PCDATA)>
    <!ATTLIST description      xml:lang CDATA #IMPLIED>
    <!ELEMENT requires-items           (#PCDATA)>
    <!ELEMENT exclude-items-by-default (#PCDATA)>
    <!ELEMENT include-items-by-default (#PCDATA)>
    <!ELEMENT exclude-items-always     (#PCDATA)>
    <!ELEMENT exclude-binary-items     ("yes"|"no")>
    <!ELEMENT minimal-rating           ("0"|"1"|"2"|"3"|"4")>
    <!ELEMENT gui-review-elements      ("yes"|"no")>
    <!ELEMENT support-restricted-access ("yes"|"no")>
    <!ATTLIST support-restricted-access optionname CDATA #IMPLIED>
    <!ELEMENT options          (option*,advanced-options)>
    <!ELEMENT advanced-options (option)*>
    <!ELEMENT option           (label+,description+,note-html+,allow-empty?,default-value?)>
    <!ATTLIST option           type (text|bool|password|number|hint-html) #REQUIRED
                               name CDATA #REQUIRED>
    <!ELEMENT label            (#PCDATA)>
    <!ATTLIST label            xml:lang CDATA #IMPLIED>
    <!ELEMENT note-html        (#PCDATA)>
    <!ATTLIST note-html        xml:lang CDATA #IMPLIED>
    <!ELEMENT allow-empty      ("yes"|"no")>
    <!ELEMENT default-value    (#PCDATA)>
    <!ELEMENT requires-details ("yes"|"no")>
.if n \{.RE
.\}

name
User visible name of event

description
User visible description

exclude-items-by-default
Comma separated names of excluded problem elements. User can include any of these elements if he wishes it.

include-items-by-default
Comma separated names of included problem elements. User can exclude any of these elements if he wishes it.

exclude-items-always
Comma separated names of included problem elements. User cannot include any of these elements.

exclude-binary-items
If "yes" then all binary problem elements are excluded. User can include them if he wishes it.

minimal-rating
Minimal backtrace rating required for executing the event. Backtrace rating is a measure of backtrace usability and understandability. With an increasing number of unresolved frames the backtrace rating gets lower values.

gui-review-elements
If "yes", user must explicitly approve that all included problem elements can be published. If "no", the event is executed automatically. If not provided, "yes" is expected.

support-restricted-access
If "yes", the UI tools will offer the users to enter the new report with restricted access. If "no", the UI tools will never offer the users to enter the report with restricted access. "no" is the default value. The element should have one argument named
_optionname_
which defines name of an option holding configuration of the restricted access feature. The option must of
_bool_
type.

advanced-options
List of options which are hidden in the default view.

label
Event option label

note-html
Event option HTML formatted description

allow-empty
Determines if user can leave the option empty

default-value
A value which is used by default

option:name
Name of exported environment variable name. libreport tools communicate through Environment Variables.

requires-details
If "yes", the UI tools will offer the users to fill "comment", "reproducer" and "reproducible" during a reporting. If "no", only "comment" will be offered to fill.

<a name="examples"></a>

# Examples


.if n \{.RS 4
.\}
    EVENT=post-create analyzer=Python   abrt-action-analyze-python
    
    EVENT=post-create
            getent passwd "`cat uid`" | cut -d: -f1 >username
.if n \{.RE
.\}

<a name="see-also"></a>

# See Also


abrtd(8)

<a name="author"></a>

# Author


Manual page written by Denys Vlasenko &lt;\m[blue]**[dvlasenk@redhat.com](mailto:dvlasenk@redhat.com)**\m[]\s-2\u[1]\d\s+2&gt;.

<a name="notes"></a>

# Notes


*  1.  
  dvlasenk@redhat.com
      mailto:dvlasenk@redhat.com
