set ModuleHierarchy {[{
"Name" : "mv","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_mv_Pipeline_x_buff_fu_248","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "x_buff","ID" : "2","Type" : "pipeline"},]},],
"SubLoops" : [
	{"Name" : "row_loop","ID" : "3","Type" : "no",
	"SubInsts" : [
	{"Name" : "grp_mv_Pipeline_col_loop_fu_264","ID" : "4","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "col_loop","ID" : "5","Type" : "pipeline"},]},
	{"Name" : "grp_mv_Pipeline_mac_loop_fu_280","ID" : "6","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "mac_loop","ID" : "7","Type" : "pipeline"},]},]},]
}]}