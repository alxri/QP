set ModuleHierarchy {[{
"Name" : "spmv_csc","ID" : "0","Type" : "sequential",
"SubInsts" : [
	{"Name" : "grp_spmv_csc_dataflow_fu_220","ID" : "1","Type" : "dataflow",
		"SubInsts" : [
		{"Name" : "read_col_info_U0","ID" : "2","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_read_col_info_Pipeline_VITIS_LOOP_46_1_fu_149","ID" : "3","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_46_1","ID" : "4","Type" : "pipeline"},]},]},
		{"Name" : "read_nnz_packed_U0","ID" : "5","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_read_nnz_packed_Pipeline_VITIS_LOOP_89_1_fu_114","ID" : "6","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_89_1","ID" : "7","Type" : "pipeline"},]},]},
		{"Name" : "distribute_to_pe_U0","ID" : "8","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_172_1_fu_72","ID" : "9","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_172_1","ID" : "10","Type" : "pipeline"},]},
			{"Name" : "grp_distribute_to_pe_Pipeline_VITIS_LOOP_230_3_fu_113","ID" : "11","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_230_3","ID" : "12","Type" : "pipeline"},]},]},
		{"Name" : "entry_proc_U0","ID" : "13","Type" : "sequential"},
		{"Name" : "compute_pe_U0","ID" : "14","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "15","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "16","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "17","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "18","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_1_U0","ID" : "19","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_1_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "20","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "21","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_1_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "22","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "23","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_2_U0","ID" : "24","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_2_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "25","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "26","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_2_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "27","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "28","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_3_U0","ID" : "29","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_3_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "30","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "31","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_3_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "32","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "33","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_4_U0","ID" : "34","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_4_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "35","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "36","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_4_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "37","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "38","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_5_U0","ID" : "39","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_5_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "40","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "41","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_5_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "42","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "43","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_6_U0","ID" : "44","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_6_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "45","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "46","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_6_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "47","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "48","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_7_U0","ID" : "49","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_7_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "50","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "51","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_7_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "52","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "53","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_8_U0","ID" : "54","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_8_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "55","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "56","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_8_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "57","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "58","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_9_U0","ID" : "59","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_9_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "60","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "61","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_9_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "62","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "63","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_10_U0","ID" : "64","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_10_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "65","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "66","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_10_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "67","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "68","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_11_U0","ID" : "69","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_11_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "70","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "71","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_11_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "72","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "73","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_12_U0","ID" : "74","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_12_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "75","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "76","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_12_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "77","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "78","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_13_U0","ID" : "79","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_13_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "80","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "81","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_13_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "82","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "83","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_14_U0","ID" : "84","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_14_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "85","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "86","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_14_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "87","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "88","Type" : "pipeline"},]},]},
		{"Name" : "compute_pe_15_U0","ID" : "89","Type" : "sequential",
			"SubInsts" : [
			{"Name" : "grp_compute_pe_15_Pipeline_VITIS_LOOP_245_1_fu_48","ID" : "90","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_245_1","ID" : "91","Type" : "pipeline"},]},
			{"Name" : "grp_compute_pe_15_Pipeline_VITIS_LOOP_251_2_fu_55","ID" : "92","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_251_2","ID" : "93","Type" : "pipeline"},]},]},]},
	{"Name" : "grp_reduce_and_write_packed_fu_255","ID" : "94","Type" : "sequential",
		"SubInsts" : [
		{"Name" : "grp_reduce_and_write_packed_Pipeline_VITIS_LOOP_273_1_VITIS_LOOP_277_2_fu_121","ID" : "95","Type" : "sequential",
			"SubLoops" : [
			{"Name" : "VITIS_LOOP_273_1_VITIS_LOOP_277_2","ID" : "96","Type" : "pipeline"},]},]},]
}]}