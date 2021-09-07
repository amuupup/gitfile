//add rtl path



../reg_model/ral_reg_mode.sv
%for i in seq_item:
../${i}_agent/${i}_agent_pkg.sv
%endfor
../${env_name}_env/${env_name}_env_pkg.sv
../${env_name}_sequences/${env_name}_seqs_pkg.sv
../${env_name}_virtual_seqs/${env_name}_vseqs_pkg.sv
../${env_name}_testcases/${env_name}_testcases_pkg.sv
../${env_name}_test_top/${env_name}_test_top.sv