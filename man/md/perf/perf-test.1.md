# perf\-test(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-test - Runs sanity tests.

<a name="synopsis"></a>

# Synopsis

```


```
    perf test [<options>] [{list <test-name-fragment>|[<test-name-fragments>|<test-numbers>]}]

<a name="description"></a>

# Description


This command does assorted sanity tests, initially through linked routines but also will look for a directory with more tests in the form of scripts.

To get a list of available tests use _perf test list_, specifying a test name fragment will show all tests that have it.

To run just specific tests, inform test name fragments or the numbers obtained from _perf test list_.

<a name="options"></a>

# Options


-s, --skip
Tests to skip (comma separated numeric list).

-v, --verbose
Be more verbose.

-F, --dont-fork
Do not fork child for each test, run all tests within single process.
