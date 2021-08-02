# cpupower\-info(1) - Shows processor power related kernel or hardware configurations

"", 22/02/2011

```
cpupower info [ -b ]
```


<a name="description"></a>

# Description

**cpupower info ** shows kernel configurations or processor hardware
registers affecting processor power saving policies.

Some options are platform wide, some affect single cores. By default values
of core zero are displayed only. cpupower --cpu all cpuinfo will show the
settings of all cores, see cpupower(1) how to choose specific cores.


<a name="see-also"></a>

# See Also

Options are described in detail in:

cpupower(1), cpupower-set(1)
