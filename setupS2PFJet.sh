runCmd() {
    printf "\n\n\n $1 \n\n\n"; read -n 1 -s -r -p $'\x0a Hit any key to continue \x0a \x0a'; eval $1
}

# Setup ipbb env and initialize project
source ~/ipbb-0.4.2/env.sh
ipbb init s2PFJet
cd s2PFJet

ipbb add git https://:@gitlab.cern.ch:8443/p2-xware/firmware/emp-fwk.git -b v0.2.3
ipbb add git https://:@gitlab.cern.ch:8443/cms-cactus/firmware/mp7.git -b ephemeral/phase2-vC
ipbb add git https://github.com/ipbus/ipbus-firmware -b v1.3


# Checkout HLS algo and emp-fwk and synthesize
runCmd 'ipbb add git https://gitlab.cern.ch/sbologna/fpga-clustering.git -b line_data'
runCmd 'ipbb add git https://github.com/bundocka/s2pfjet-emp.git'
cd src/fpga-clustering
runCmd 'vivado_hls FPGAClustering_ExportIP_KU115.tcl'
cd ../../

# Create vivado project
runCmd 'ipbb proj create vivado s2PFJetClust s2pfjet-emp:projects/ku115dc_s2pfjet  -t top.dep'
cd proj/s2PFJetClust


# Build project
runCmd 'ipbb vivado project'

cp ../../src/s2pfjet-emp/projects/includeS2PFJet.tcl ./
runCmd 'vivado -mode batch -source includeS2PFJet.tcl'

runCmd 'ipbb vivado synth -j4 impl -j4'
runCmd 'ipbb vivado package'

# Fin!
