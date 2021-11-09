# function::json_add_a(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::json_add_array_string_metric - Add a string metric to an array

<a name="synopsis"></a>

# Synopsis

```


```
        json_add_array_string_metric:long(array_name:string,metric_name:string,metric_description:string)

<a name="arguments"></a>

# Arguments


_array\_name_
The name of the array the string metric should be added to.

_metric\_name_
The name of the string metric.

_metric\_description_
Metric description. An empty string can be used.

<a name="description"></a>

# Description


This function adds a string metric to an array, setting up everything needed.

<a name="see-alson-"></a>

# See Also\N 

_tapset::json_(3stap)
