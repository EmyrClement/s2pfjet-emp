set algo "jet_trigger_chain_wrapper"
set version 1.0

set dir ../../src/
set modName ${algo}_0

set ipRepoDir user_ip_repo
file mkdir $ipRepoDir
set_property  ip_repo_paths  $ipRepoDir [current_project]
# Rebuild user ip_repo's index before adding any source files
update_ip_catalog -rebuild
update_ip_catalog -add_ip "$dir/phase-2-jet-trigger-chain/IPs_KU15P/jet_trigger_chain/cern-cms_hls_jet_trigger_chain_wrapper_1.0.zip" -repo_path $ipRepoDir
create_ip -name ${algo} -vendor cern-cms -library hls -version ${version} -module_name ${modName}
generate_target {instantiation_template} [get_files s2PFJetClust/s2PFJetClust.srcs/sources_1/ip/${modName}/${modName}.xci]
generate_target all [get_files s2PFJetClust/s2PFJetClust.srcs/sources_1/ip/${modName}/${modName}.xci]
export_ip_user_files -of_objects [get_files s2PFJetClust/s2PFJetClust.srcs/sources_1/ip/${modName}/${modName}.xci] -no_script -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] s2PFJetClust/s2PFJetClust.srcs/sources_1/ip/${modName}/${modName}.xci]
launch_run -jobs 8 ${modName}_synth_1
