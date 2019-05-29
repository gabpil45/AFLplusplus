#!/bin/sh
echo This reconfigures the system to have a better fuzzing performance
sysctl -w kernel.core_pattern=core
sysctl -w kernel.randomize_va_space=0
sysctl -w kernel.sched_child_runs_first=1
sysctl -w kernel.sched_autogroup_enabled=1
sysctl -w kernel.sched_migration_cost_ns=50000000
sysctl -w kernel.sched_latency_ns=250000000
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
echo
echo It is recommended to boot the kernel with lots of security off - if you are running a machine that is in a secured network - so set this:
echo '/etc/default/grub:GRUB_CMDLINE_LINUX_DEFAULT="ibpb=off ibrs=off kpti=off l1tf=off mds=off mitigations=off no_stf_barrier noibpb noibrs nopcid nopti nospec_store_bypass_disable nospectre_v1 nospectre_v2 pcid=off pti=off spec_store_bypass_disable=off spectre_v2=off stf_barrier=off"'
echo
echo Also use AFL_TMPDIR to use a tmpfs for the input file
