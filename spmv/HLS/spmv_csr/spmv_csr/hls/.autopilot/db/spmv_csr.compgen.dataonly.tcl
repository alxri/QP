# This script segment is generated automatically by AutoPilot

set axilite_register_dict [dict create]
set port_control {
num_rows { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 16
	offset_end 23
}
num_cols { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 24
	offset_end 31
}
A_row_index { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 32
	offset_end 43
}
A_col_index { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 44
	offset_end 55
}
A_values { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 56
	offset_end 67
}
x { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 68
	offset_end 79
}
y { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 80
	offset_end 91
}
ap_start { }
ap_done { }
ap_ready { }
ap_idle { }
interrupt {
}
}
dict set axilite_register_dict control $port_control


