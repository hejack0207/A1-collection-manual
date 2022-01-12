# macro::json_output_a(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

macro::json_output_array_numeric_value - Output a numeric value for metric in an array.

<a name="synopsis"></a>

# Synopsis

```


```
        @json_output_array_numeric_value(array_name,array_index,metric_name,value)

<a name="arguments"></a>

# Arguments


_array\_name_
The name of the array.

_array\_index_
The array index (as a string) indicating where to store the numeric value.

_metric\_name_
The name of the numeric metric.

_value_
The numeric value to output.

<a name="description"></a>

# Description


The json_output_array_numeric_value macro is designed to be called from the json_data\*(Aq probe in the user\*(Aqs script to output a metric\*(Aqs numeric value that is in an array. This metric should have been added with
**json\_add\_array\_numeric\_metric**.

<a name="see-alson-"></a>

# See Also\N 

_tapset::json_(3stap)
