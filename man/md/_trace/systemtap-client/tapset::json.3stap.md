# tapset::json(3stap) - systemtap json tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 The JSON tapset provides probes, functions, and macros to generate
 a JSON metadata and data file. The JSON metadata file is located in
 /proc/systemtap/MODULE/metadata.json. The JSON data file is located
 in /proc/systemtap/MODULE/data.json. The JSON data file is updated
 with current data every time the file is read.


* 

* **json_set_prefix**  
  Set the metric prefix.
* See 
  _function::json_set_prefix_(3stap)
   for details.


* **json_add_numeric_metric**  
  Add a numeric metric
* See 
  _function::json_add_numeric_metric_(3stap)
   for details.


* **json_add_string_metric**  
  Add a string metric
* See 
  _function::json_add_string_metric_(3stap)
   for details.


* **json_add_array**  
  Add an array
* See 
  _function::json_add_array_(3stap)
   for details.


* **json_add_array_numeric_metric**  
  Add a numeric metric to an array
* See 
  _function::json_add_array_numeric_metric_(3stap)
   for details.


* **json_add_array_string_metric**  
  Add a string metric to an array
* See 
  _function::json_add_array_string_metric_(3stap)
   for details.


* **json_data**  
  Fires whenever JSON data is wanted by a reader.
*  See 
  _probe::json_data_(3stap)
   for details.


* **@json_output_data_start**  
  Start the json output.
*  See 
  _macro::json_output_data_start_(3stap)
   for details.


* **@json_output_string_value**  
  Output a string value.
*  See 
  _macro::json_output_string_value_(3stap)
   for details.


* **@json_output_numeric_value**  
  Output a numeric value.
*  See 
  _macro::json_output_numeric_value_(3stap)
   for details.


* **@json_output_array_string_value**  
  Output a string value for metric in an array.
*  See 
  _macro::json_output_array_string_value_(3stap)
   for details.


* **@json_output_array_numeric_value**  
  Output a numeric value for metric in an array.
*  See 
  _macro::json_output_array_numeric_value_(3stap)
   for details.


* **@json_output_data_end**  
  End the json output.
*  See 
  _macro::json_output_data_end_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::json_set_prefix_(3stap),  
_function::json_add_numeric_metric_(3stap),  
_function::json_add_string_metric_(3stap),  
_function::json_add_array_(3stap),  
_function::json_add_array_numeric_metric_(3stap),  
_function::json_add_array_string_metric_(3stap),  
_probe::json_data_(3stap),  
_macro::json_output_data_start_(3stap),  
_macro::json_output_string_value_(3stap),  
_macro::json_output_numeric_value_(3stap),  
_macro::json_output_array_string_value_(3stap),  
_macro::json_output_array_numeric_value_(3stap),  
_macro::json_output_data_end_(3stap),  
_stap_(1),
_stapprobes_(3stap)
