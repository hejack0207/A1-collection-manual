# nvme\-wdc\-vs\-smart(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-wdc-vs-smart-add-log - Send NVMe WDC vs-smart-add-log Vendor Unique Command, return result

<a name="synopsis"></a>

# Synopsis

```


```
    nvme wdc vs-smart-add-log <device> [--interval=<NUM>, -i <NUM>] [--output-format=<normal|json> -o <normal|json>]

<a name="description"></a>

# Description


For the NVMe device given, send a Vendor Unique WDC vs-smart-add-log command and provide the additional smart log. The --interval option will return performance statistics from the specified reporting interval.

The &lt;device&gt; parameter is mandatory and may be either the NVMe character device (ex: /dev/nvme0).

This will only work on WDC devices supporting this feature. Results for any other device are undefined.

On success it returns 0, error code otherwise.

<a name="options"></a>

# Options


-i &lt;NUM&gt;, --interval=&lt;NUM&gt;
Return the statistics from specific interval, defaults to 14

-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_, or
_json_. Only one output format can be used at a time. Default is normal.

Valid Interval values and description :-
.TS
allbox tab(:);
ltB ltB.
T{
Value
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

**1**
T}:T{

Most recent five (5) minute accumulated set.
T}
T{

**2-12**
T}:T{

Previous five (5) minute accumulated sets.
T}
T{

**13**
T}:T{

The accumulated total of sets 1 through 12 that contain the previous hour of accumulated statistics.
T}
T{

**14**
T}:T{

The statistical set accumulated since power-up.
T}
T{

**15**
T}:T{

The statistical set accumulated during the entire lifetime of the device.
T}
.TE


<a name="ca-log-page-data-output-explanation"></a>

# Ca Log Page Data Output Explanation

.TS
allbox tab(:);
ltB ltB.
T{
Field
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

**Physical NAND bytes written.**
T}:T{

The number of bytes written to NAND. 16 bytes - hi/lo
T}
T{

**Physical NAND bytes read**
T}:T{

The number of bytes read from NAND. 16 bytes - hi/lo
T}
T{

**Bad NAND Block Count**
T}:T{

Raw and normalized count of the number of NAND blocks that have been retired after the drives manufacturing tests (i.e. grown back blocks). 2 bytes normalized, 6 bytes raw count
T}
T{

**Uncorrectable Read Error Count**
T}:T{

Total count of NAND reads that were not correctable by read retries, all levels of ECC, or XOR (as applicable). 8 bytes
T}
T{

**Soft ECC Error Count**
T}:T{

Total count of NAND reads that were not correctable by read retries, or first-level ECC. 8 bytes
T}
T{

**SSD End to End Detection Count**
T}:T{

A count of the detected errors by the SSD end to end error correction which includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not NAND ECC). 4 bytes
T}
T{

**SSD End to End Correction Count**
T}:T{

A count of the corrected errors by the SSD end to end error correction which includes DRAM, SRAM, or other storage element ECC/CRC protection mechanism (not NAND ECC). 4 bytes
T}
T{

**System Data % Used**
T}:T{

A normalized cumulative count of the number of erase cycles per block since leaving the factory for the system (FW and metadata) area. Starts at 0 and increments. 100 indicates that the estimated endurance has been consumed.
T}
T{

**User Data Max Erase Count**
T}:T{

The maximum erase count across all NAND blocks in the drive. 4 bytes
T}
T{

**User Data Min Erase Count**
T}:T{

The minimum erase count across all NAND blocks in the drive. 4 bytes
T}
T{

**Refresh Count**
T}:T{

A count of the number of blocks that have been re-allocated due to background operations only. 8 bytes
T}
T{

**Program Fail Count**
T}:T{

Raw and normalized count of total program failures. Normalized count starts at 100 and shows the percent of remaining allowable failures. 2 bytes normalized, 6 bytes raw count
T}
T{

**User Data Erase Fail Count**
T}:T{

Raw and normalized count of total erase failures in the user area. Normalized count starts at 100 and shows the percent of remaining allowable failures. 2 bytes normalized, 6 bytes raw count
T}
T{

**System Area Erase Fail Count**
T}:T{

Raw and normalized count of total erase failures in the system area. Normalized count starts at 100 and shows the percent of remaining allowable failures. 2 bytes normalized, 6 bytes raw count
T}
T{

**Thermal Throttling Status**
T}:T{

The current status of thermal throttling (enabled or disabled). 2 bytes
T}
T{

**Thermal Throttling Count**
T}:T{

A count of the number of thermal throttling events. 2 bytes
T}
T{

**PCIe Correctable Error Count**
T}:T{

Summation counter of all PCIe correctable errors (Bad TLP, Bad DLLP, Receiver error, Replay timeouts, Replay rollovers). 8 bytes
T}
.TE


<a name="c1-log-page-data-output-explanation"></a>

# C1 Log Page Data Output Explanation

.TS
allbox tab(:);
ltB ltB.
T{
Field
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

**Host Read Commands**
T}:T{

Number of host read commands received during the reporting period.
T}
T{

**Host Read Blocks**
T}:T{

Number of 512-byte blocks requested during the reporting period.
T}
T{

**Average Read Size**
T}:T{

Average Read size is calculated using (Host Read Blocks/Host Read Commands).
T}
T{

**Host Read Cache Hit Commands**
T}:T{

Number of host read commands that serviced entirely from the on-board read cache during the reporting period. No access to the NAND flash memory was required. This count is only updated if the entire command was serviced from the cache memory.
T}
T{

**Host Read Cache Hit Percentage**
T}:T{

Percentage of host read commands satisfied from the cache.
T}
T{

**Host Read Cache Hit Blocks**
T}:T{

Number of 512-byte blocks of data that have been returned for Host Read Cache Hit Commands during the reporting period. This count is only updated with the blocks returned for host read commands that were serviced entirely from cache memory.
T}
T{

**Average Read Cache Hit Size**
T}:T{

Average size of read commands satisfied from the cache.
T}
T{

**Host Read Commands Stalled**
T}:T{

Number of host read commands that were stalled due to a lack of resources within the SSD during the reporting period (NAND flash command queue full, low cache page count, cache page contention, etc.). Commands are not considered stalled if the only reason for the delay was waiting for the data to be physically read from the NAND flash. It is normal to expect this count to equal zero on heavily utilized systems.
T}
T{

**Host Read Commands Stalled Percentage**
T}:T{

Percentage of read commands that were stalled. If the figure is consistently high, then consideration should be given to spreading the data across multiple SSDs.
T}
T{

**Host Write Commands**
T}:T{

Number of host write commands received during the reporting period.
T}
T{

**Host Write Blocks**
T}:T{

Number of 512-byte blocks written during the reporting period.
T}
T{

**Average Write Size**
T}:T{

Average Write size calculated using (Host Write Blocks/Host Write Commands).
T}
T{

**Host Write Odd Start Commands**
T}:T{

Number of host write commands that started on a non-aligned boundary during the reporting period. The size of the boundary alignment is normally 4K; therefore this returns the number of commands that started on a non-4K aligned boundary. The SSD requires slightly more time to process non-aligned write commands than it does to process aligned write commands.
T}
T{

**Host Write Odd Start Commands Percentage**
T}:T{

Percentage of host write commands that started on a non-aligned boundary. If this figure is equal to or near 100%, and the NAND Read Before Write value is also high, then the user should investigate the possibility of offsetting the file system. For Microsoft Windows systems, the user can use Diskpart. For Unix-based operating systems, there is normally a method whereby file system partitions can be placed where required.
T}
T{

**Host Write Odd End Commands**
T}:T{

Number of host write commands that ended on a non-aligned boundary during the reporting period. The size of the boundary alignment is normally 4K; therefore this returns the number of commands that ended on a non-4K aligned boundary.
T}
T{

**Host Write Odd End Commands Percentage**
T}:T{

Percentage of host write commands that ended on a non-aligned boundary.
T}
T{

**Host Write Commands Stalled**
T}:T{

Number of host write commands that were stalled due to a lack of resources within the SSD during the reporting period. The most likely cause is that the write data was being received faster than it could be saved to the NAND flash memory. If there was a large volume of read commands being processed simultaneously, then other causes might include the NAND flash command queue being full, low cache page count, or cache page contention, etc. It is normal to expect this count to be non-zero on heavily utilized systems.
T}
T{

**Host Write Commands Stalled Percentage**
T}:T{

Percentage of write commands that were stalled. If the figure is consistently high, then consideration should be given to spreading the data across multiple SSDs.
T}
T{

**NAND Read Commands**
T}:T{

Number of read commands issued to the NAND devices during the reporting period. This figure will normally be much higher than the host read commands figure, as the data needed to satisfy a single host read command may be spread across several NAND flash devices.
T}
T{

**NAND Read Blocks**
T}:T{

Number of 512-byte blocks requested from NAND flash devices during the reporting period. This figure would normally be about the same as the host read blocks figure
T}
T{

**Average NAND Read Size**
T}:T{

Average size of NAND read commands.
T}
T{

**NAND Write Commands**
T}:T{

Number of write commands issued to the NAND devices during the reporting period. There is no real correlation between the number of host write commands issued and the number of NAND Write Commands.
T}
T{

**NAND Write Blocks**
T}:T{

Number of 512-byte blocks written to the NAND flash devices during the reporting period. This figure would normally be about the same as the host write blocks figure.
T}
T{

**Average NAND Write Size**
T}:T{

Average size of NAND write commands. This figure should never be greater than 128K, as this is the maximum size write that is ever issued to a NAND device.
T}
T{

**NAND Read Before Write**
T}:T{

This is the number of read before write operations that were required to process non-aligned host write commands during the reporting period. See Host Write Odd Start Commands and Host Write Odd End Commands. NAND Read Before Write operations have a detrimental effect on the overall performance of the device.
T}
.TE


<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Has the program issue WDC vs-smart-add-log Vendor Unique Command with default interval (14) :

.if n \{.RS 4
.\}
    # nvme wdc vs-smart-add-log /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
