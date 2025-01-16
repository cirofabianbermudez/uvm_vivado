##
## A first example Tcl simulation script for the Xilinx XSim simulator.
##

# Profiling
set tclStart [clock seconds]

# Dump all waveforms into XSim Waveform Database (WDB)
log_wave -recursive /*

# Add all top-level signals to the Wave window
add_wave /*

# Run the simulation until a $stop or $finish statement is found in the code
run all

# Print the overall simulation time on XSim console
puts "\nSimulation finished at [current_time]\n"

# Report CPU time
set tclStop [clock seconds]
set seconds [expr ${tclStop} - ${tclStart} ]

puts "\nTotal elapsed-time for [info script]: [format "%.2f" [expr ${seconds}/60.]] minutes\n"
