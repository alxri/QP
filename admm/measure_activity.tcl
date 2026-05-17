# Open waveform database
open_wave_database admm_HW_HLS/solution1/sim/verilog/admm.wdb

# Target signal
set sig "/apatb_admm_top/AESL_inst_admm/grp_spmv_csc_fu_808/grp_spmv_csc_fu_808_activity"

# Get waveform object
set wobj [get_waves $sig]

# Extract transition list
set tv_list [get_value -time_range all $wobj]

# Accumulator
set total_high 0

# Previous state/time
set prev_time 0
set prev_val 0

foreach tv $tv_list {

    # Each entry format:
    # {time value}

    set t [lindex $tv 0]
    set v [lindex $tv 1]

    # If previous value was 1, accumulate interval
    if {$prev_val == 1} {
        set dt [expr {$t - $prev_time}]
        set total_high [expr {$total_high + $dt}]
    }

    set prev_time $t
    set prev_val $v
}

puts "======================================="
puts "Signal: $sig"
puts "Total HIGH time: $total_high"
puts "======================================="
