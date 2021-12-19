# macro::json_output_s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

macro::json_output_string_value - Output a string value.

<a name="synopsis"></a>

# Synopsis

```


```
        @json_output_string_value(name,value)

<a name="arguments"></a>

# Arguments


_name_
The name of the string metric.

_value_
The string value to output.

<a name="description"></a>

# Description


The json_output_string_value macro is designed to be called from the json_data\*(Aq probe in the user\*(Aqs script to output a metric\*(Aqs string value. This metric should have been added with
**json\_add\_string\_metric**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::json_(3stap)
