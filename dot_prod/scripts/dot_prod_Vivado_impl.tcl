# Open the project we just created
open_project vivado_build/spmv_bd/spmv_bd.xpr
update_compile_order -fileset sources_1

# Step 14: Run synthesis, implementation, generate bitstream
launch_runs impl_1 -to_step write_bitstream -jobs 2
wait_on_run impl_1
quit
