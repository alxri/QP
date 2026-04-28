open_project dot_prod_HW_HLS
open_solution "solution1"
# Export the IP (Synthesis must have been run in this project folder)
export_design -rtl vhdl -format ip_catalog -output ./IP-catalog/dot_prod_HW_HLS.zip
quit