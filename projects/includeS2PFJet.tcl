open_project top/top.xpr

set algo "hls_jet_clustering"
set version 0.1

set dir ../../src/fpga-clustering/FPGAClustering/FPGAClustering/impl/ip/
set modName ${algo}_0

set ipRepoDir user_ip_repo
file mkdir $ipRepoDir
set_property  ip_repo_paths  $ipRepoDir [current_project]
# Rebuild user ip_repo's index before adding any source files
update_ip_catalog -rebuild
update_ip_catalog -add_ip "$dir/cern-cms_hls_${algo}_[string map { . _ } ${version}].zip" -repo_path $ipRepoDir

create_ip -name ${algo} -vendor cern-cms -library hls -version ${version} -module_name ${modName}
generate_target {instantiation_template} [get_files top/top.srcs/sources_1/ip/${modName}/${modName}.xci]
generate_target all [get_files top/top.srcs/sources_1/ip/${modName}/${modName}.xci]
export_ip_user_files -of_objects [get_files top/top.srcs/sources_1/ip/${modName}/${modName}.xci] -no_script -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] top/top.srcs/sources_1/ip/${modName}/${modName}.xci]
launch_run -jobs 8 ${modName}_synth_1
