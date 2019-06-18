runCmd() {
    printf "\n\n\n $1 \n\n\n"; read -n 1 -s -r -p $'\x0a Hit any key to continue \x0a \x0a'; eval $1
}

# Setup ipbb env and initialize project
source ~/ipbb-0.4.2/env.sh
ipbb init s2PFJet
cd s2PFJet

runCmd 'ipbb add git https://:@gitlab.cern.ch:8443/p2-xware/firmware/emp-fwk.git -b v0.2.3'
runCmd 'ipbb add git https://:@gitlab.cern.ch:8443/cms-cactus/firmware/mp7.git -b ephemeral/phase2-vC'
runCmd 'ipbb add git https://github.com/ipbus/ipbus-firmware -b v1.3'


# Checkout HLS algo and synthesize
runCmd 'ipbb add git https://gitlab.cern.ch/sbologna/fpga-clustering.git -b line_data'
cd src/fpga-clustering
runCmd 'vivado_hls FPGAClustering_ExportIP_KU115.tcl'
cd ../../

# Checkout emp-fwk vivado project
runCmd 'ipbb add git https://gitlab.cern.ch/bundocka/s2pfjet-emp.git'
runCmd 'ipbb proj create vivado s2PFJetClust s2pfjet-emp:projects/ku115dc_s2pfjet  -t top.dep'
cd proj/s2PFJetClust


# Build project
runCmd 'ipbb vivado project'

cp ../../src/s2pfjet-emp/projects/includeS2PFJet.tcl ./
runCmd 'vivado -mode batch -source includeS2PFJet.tcl'

runCmd 'ipbb vivado synth -j4 impl -j4'
runCmd 'ipbb vivado package'

# Fin!
