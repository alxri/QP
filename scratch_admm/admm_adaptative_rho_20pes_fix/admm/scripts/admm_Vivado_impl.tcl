# Open the project we just created
open_project vivado_build/vivado_build.xpr
update_compile_order -fileset sources_1

# Step 14: Run synthesis, implementation, generate bitstream
launch_runs impl_1 -to_step write_bitstream -jobs 10
wait_on_run impl_1
quit
