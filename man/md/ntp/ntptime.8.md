# ntptime(8) - read and set kernel time variables


<a name="-"></a>

# \ 



<a name="synopsis"></a>

# Synopsis

```
ntptime [ -chr ] [ -e est_error ] [ -f frequency ] [ -m max_error ] [ -o offset ] [ -s status ] [ -t time_constant] 
```


<a name="description"></a>

# Description


This program is useful only with special kernels described in the A Kernel Model for Precision Timekeeping page. It reads and displays time-related kernel variables using the **ntp\_gettime()** system call. A similar display can be obtained using the **ntpdc** program and **kerninfo** command.


<a name="options"></a>

# Options



* **-c**  
  Display the execution time of **ntptime** itself.
* **-e est\_error**  
  Specify estimated error, in microseconds.
* **-f frequency**  
  Specify frequency offset, in parts per million.
* **-h**  
  Display help information.
* **-m max\_error**  
  Specify max possible errors, in microseconds.
* **-o offset**  
  Specify clock offset, in microseconds.
* **-r**  
  Display Unix and NTP times in raw format.
* **-s status**  
  Specify clock status. Better know what you are doing.
* **-t time\_constant**  
  Specify time constant, an integer in the range 0-10. 


<a name="see-also"></a>

# See Also


ntpd(8), ntpdate(8)

The official HTML documentation.

This file was automatically generated from HTML source.

