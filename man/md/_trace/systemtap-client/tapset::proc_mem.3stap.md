# tapset::proc_mem(3stap) - systemtap proc_mem tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


 Process memory query and utility functions provide information about
 the memory usage of the current application. These functions provide
 information about the full size, resident, shared, code and data used
 by the current process. And provide utility functions to query the
 page size of the current architecture and create human readable string
 representations of bytes and pages used.


* 

* **proc_mem_size**  
  Total program virtual memory size in pages
* See 
  _function::proc_mem_size_(3stap)
   for details.


* **proc_mem_size**  
  Total program virtual memory size in pages
* See 
  _function::proc_mem_size_(3stap)
   for details.


* **proc_mem_rss**  
  Program resident set size in pages
* See 
  _function::proc_mem_rss_(3stap)
   for details.


* **proc_mem_rss**  
  Program resident set size in pages
* See 
  _function::proc_mem_rss_(3stap)
   for details.


* **proc_mem_shr**  
  Program shared pages (from shared mappings)
* See 
  _function::proc_mem_shr_(3stap)
   for details.


* **proc_mem_shr**  
  Program shared pages (from shared mappings)
* See 
  _function::proc_mem_shr_(3stap)
   for details.


* **proc_mem_txt**  
  Program text (code) size in pages
* See 
  _function::proc_mem_txt_(3stap)
   for details.


* **proc_mem_txt**  
  Program text (code) size in pages
* See 
  _function::proc_mem_txt_(3stap)
   for details.


* **proc_mem_data**  
  Program data size (data + stack) in pages
* See 
  _function::proc_mem_data_(3stap)
   for details.


* **proc_mem_data**  
  Program data size (data + stack) in pages
* See 
  _function::proc_mem_data_(3stap)
   for details.


* **mem_page_size**  
  Number of bytes in a page for this architecture
* See 
  _function::mem_page_size_(3stap)
   for details.


* **bytes_to_string**  
  Human readable string for given bytes
* See 
  _function::bytes_to_string_(3stap)
   for details.


* **pages_to_string**  
  Turns pages into a human readable string
* See 
  _function::pages_to_string_(3stap)
   for details.


* **proc_mem_string**  
  Human readable string of process memory usage
* See 
  _function::proc_mem_string_(3stap)
   for details.


* **proc_mem_string**  
  Human readable string of process memory usage
* See 
  _function::proc_mem_string_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::proc_mem_size_(3stap),  
_function::proc_mem_rss_(3stap),  
_function::proc_mem_shr_(3stap),  
_function::proc_mem_txt_(3stap),  
_function::proc_mem_data_(3stap),  
_function::mem_page_size_(3stap),  
_function::bytes_to_string_(3stap),  
_function::pages_to_string_(3stap),  
_function::proc_mem_string_(3stap),  
_stap_(1),
_stapprobes_(3stap)
