# tuned_profiles(7) - description of basic TuneD profiles

Fedora Power Management SIG, 30 Mar 2017


<a name="description"></a>

# Description

These are the base profiles which are mostly shipped in the base tuned
package. They are targeted to various goals. Mostly they provide
performance optimizations but there are also profiles targeted to
low power consumption, low latency and others. You can mostly deduce the
purpose of the profile by its name or you can see full description below.

The profiles are stored in subdirectories below _/usr/lib/tuned_. If you
need to customize the profiles, you can copy them to _/etc/tuned_ and modify
them as you need. When loading profiles with the same name, the /etc/tuned takes
precedence. In such case you will not lose your customized profiles between
TuneD updates.

The power saving profiles contain settings that are typically not enabled by
default as they will noticeably impact the latency/performance of your system
as opposed to the power saving mechanisms that are enabled by default. On the
other hand the performance profiles disable the additional power saving
mechanisms of TuneD as they would negatively impact throughput or latency.


<a name="profiles"></a>

# Profiles

At the moment we're providing the following pre-defined profiles:


* **balanced**  
  It is the default profile. It provides balanced power saving and performance.
  At the moment it enables CPU and disk plugins of TuneD and it makes sure the
  conservative governor is active (if supported by the current cpufreq driver).
  It enables ALPM power saving for SATA host adapters and sets the link power
  management policy to medium_power. It also sets the CPU energy performance
  bias to normal. It also enables AC97 audio power saving or (it depends on
  your system) HDA-Intel power savings with 10 seconds timeout. In case your
  system contains supported Radeon graphics card (with enabled KMS) it
  configures it to automatic power saving.
  
* **powersave**  
  Maximal power saving, at the moment it enables USB autosuspend (in case
  environment variable USB_AUTOSUSPEND is set to 1), enables ALPM power saving
  for SATA host adapters and sets the link power management policy to min_power.
  It also enables WiFi power saving and makes sure the ondemand governor is active
  (if supported by the current cpufreq driver). It sets the CPU energy performance
  bias to powersave. It also enables AC97 audio power saving or (it depends on
  your system) HDA-Intel power savings (with 10 seconds timeout). In case your
  system contains supported Radeon graphics card (with enabled KMS) it
  configures it to automatic power saving. On Asus Eee PCs dynamic Super
  Hybrid Engine is enabled.
  
* **throughput-performance**  
  Profile for typical throughput performance tuning. Disables power saving
  mechanisms and enables sysctl settings that improve the throughput performance
  of your disk and network IO. CPU governor is set to performance and CPU energy
  performance bias is set to performance. Disk readahead values are increased.
  
* **accelerator-performance**  
  This profile contains the same tuning as the throughput-performance profile.
  Additionally, it locks the CPU to low C states so that the latency is less than
  100us. This improves the performance of certain accelerators, such as GPUs.
  
* **latency-performance**  
  Profile for low latency performance tuning. Disables power saving mechanisms.
  CPU governor is set to performance and locked to the low C states (by PM QoS).
  CPU energy performance bias to performance.
  
* **network-throughput**  
  Profile for throughput network tuning. It is based on the throughput-performance
  profile. It additionally increases kernel network buffers.
  
* **network-latency**  
  Profile for low latency network tuning. It is based on the latency-performance
  profile. It additionally disables transparent hugepages, NUMA balancing and
  tunes several other network related sysctl parameters.
  
* **desktop**  
  Profile optimized for desktops based on balanced profile. It additionally
  enables scheduler autogroups for better response of interactive applications.
  
* **hpc-compute**  
  Profile optimized for high-performance computing. It is based on the
  latency-performance profile.
  
* **virtual-guest**  
  Profile optimized for virtual guests based on throughput-performance profile.
  It additionally decreases virtual memory swappiness and increases dirty_ratio
  settings.
  
* **virtual-host**  
  Profile optimized for virtual hosts based on throughput-performance profile.
  It additionally enables more aggressive writeback of dirty pages.
  
* **intel-sst**  
  Profile optimized for systems with user-defined Intel Speed Select Technology
  configurations. This profile is intended to be used as an overlay on other
  profiles (e.g. cpu-partitioning profile), example:
  **tuned-adm profile cpu-partitioning intel-sst**
  
* **optimize-serial-console**  
  Profile which tunes down I/O activity to the serial console by reducing the
  printk value. This should make the serial console more responsive.
  This profile is intended to be used as an overlay on other
  profiles (e.g. throughput-performance profile), example:
  **tuned-adm profile throughput-performance optimize-serial-console**
  

<a name="files"></a>

# Files

    /etc/tuned/*
    /usr/lib/tuned/*
    

<a name="see-also"></a>

# See Also

**tuned**(8)
**tuned-adm**(8)
**tuned-profiles-atomic**(7)
**tuned-profiles-sap**(7)
**tuned-profiles-sap-hana**(7)
**tuned-profiles-oracle**(7)
**tuned-profiles-realtime**(7)
**tuned-profiles-nfv-host**(7)
**tuned-profiles-nfv-guest**(7)
**tuned-profiles-cpu-partitioning**(7)
**tuned-profiles-compat**(7)
**tuned-profiles-postgresql**(7)

<a name="author"></a>

# Author

    Jaroslav Škarvada <jskarvad@redhat.com>
    Jan Kaluža <jkaluza@redhat.com>
    Jan Včelák <jvcelak@redhat.com>
    Marcela Mašláňová <mmaslano@redhat.com>
    Phil Knirsch <pknirsch@redhat.com>
