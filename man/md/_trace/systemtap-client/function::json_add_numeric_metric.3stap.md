# function::json_add_n(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::json_add_numeric_metric - Add a numeric metric

<a name="synopsis"></a>

# Synopsis

```


```
        json_add_numeric_metric:long(name:string,description:string,units:string)

<a name="arguments"></a>

# Arguments


_name_
The name of the numeric metric.

_description_
Metric description. An empty string can be used.

_units_
Metic units. An empty string can be used.

<a name="description"></a>

# Description


This function adds a numeric metric, setting up everything needed.

<a name="see-alson-"></a>

# See Also\N 

_tapset::json_(3stap)
