set ModuleHierarchy {[{
"Name" : "spmv_csr","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_spmv_csr_Pipeline_READ_X_fu_225","ID" : "1","Type" : "sequential",
		"SubLoops" : [
		{"Name" : "READ_X","ID" : "2","Type" : "pipeline"},]},],
"SubLoops" : [
	{"Name" : "L1","ID" : "3","Type" : "no",
	"SubInsts" : [
	{"Name" : "grp_spmv_csr_Pipeline_L2_fu_234","ID" : "4","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "L2","ID" : "5","Type" : "pipeline"},]},]},]
}]}