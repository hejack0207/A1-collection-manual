# halog(1) - HAProxy log statistics reporter

halog, July 2013

```
halog [-h|--help]
halog [options] <LOGFILE
```

<a name="description"></a>

# Description

**halog**
reads HAProxy log data from stdin and extracts and displays lines matching
user-specified criteria.

<a name="options"></a>

# Options


<a name="input-filters-frseveral-filters-may-be-combined"></a>

### Input filters \fR(several filters may be combined)


* **-H**  
  Only match lines containing HTTP logs (ignore TCP)
* **-E**  
  Only match lines without any error (no 5xx status)
* **-e**  
  Only match lines with errors (status 5xx or negative)
* **-rt**|**-RT** &lt;time&gt;  
  Only match response times larger|smaller than &lt;time&gt;
* **-Q**|**-QS**  
  Only match queued requests (any queue|server queue)
* **-tcn**|**-TCN** &lt;code&gt;  
  Only match requests with/without termination code &lt;code&gt;
* **-hs**|**-HS** &lt;[min][:][max]&gt;  
  Only match requests with HTTP status codes within/not within min..max. Any of
  them may be omitted. Exact code is checked for if no ':' is specified.
  .SS
  Modifiers
* **-v**  
  Invert the input filtering condition
* **-q**  
  Don't report errors/warnings
* **-m** &lt;lines&gt;  
  Limit output to the first &lt;lines&gt; lines
  .SS
  Output filters - only one may be used at a time
* **-c**  
  Only report the number of lines that would have been printed
* **-pct**  
  Output connect and response times percentiles
* **-st**  
  Output number of requests per HTTP status code
* **-cc**  
  Output number of requests per cookie code (2 chars)
* **-tc**  
  Output number of requests per termination code (2 chars)
* **-srv**  
  Output statistics per server (time, requests, errors)
* **-u***  
  Output statistics per URL (time, requests, errors)  
  Additional characters indicate the output sorting key:
    * **-u**  
      URL
    * **-uc**  
      Request count
    * **-ue**  
      Error count
    * **-ua**  
      Average response time
    * **-ut**  
      Average total time
    * **-uao**, **-uto**  
      Average times computed on valid ('OK') requests
    * **-uba**  
      Average bytes returned
    * **-ubt**  
      Total bytes returned

<a name="see-also"></a>

# See Also

**haproxy**(1)

<a name="author"></a>

# Author


**halog** was written by Willy Tarreau &lt;[w@1wt.eu](mailto:w@1wt.eu)&gt; and is part of **haproxy**(1).

This  manual page was written by Apollon Oikonomopoulos &lt;[apoikos@gmail.com](mailto:apoikos@gmail.com)&gt; for the Debian project (but may
be used by others).

