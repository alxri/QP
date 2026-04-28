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
nnz { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 32
	offset_end 39
}
A_row_idx { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 40
	offset_end 51
}
A_col_ptr { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 52
	offset_end 63
}
A_values { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 64
	offset_end 75
}
x { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 76
	offset_end 87
}
y { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 88
	offset_end 99
}
ap_start { }
ap_done { }
ap_ready { }
ap_idle { }
interrupt {
}
}
dict set axilite_register_dict control $port_control


