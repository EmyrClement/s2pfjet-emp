runCmd() {
    printf "\n\n\n $1 \n\n\n"; read -n 1 -s -r -p $'\x0a Hit any key to continue \x0a \x0a'; eval $1
}

source ~/ipbb-0.4.2/env.sh
ipbb init s2PFJet
cd s2PFJet
ipbb add git https://:@gitlab.cern.ch:8443/p2-xware/firmware/emp-fwk.git -b v0.2.3
ipbb add git https://:@gitlab.cern.ch:8443/cms-cactus/firmware/mp7.git -b ephemeral/phase2-vC
ipbb add git https://github.com/ipbus/ipbus-firmware -b v1.3
ipbb add git https://:@gitlab.cern.ch:8443/sbologna/phase-2-jet-trigger-chain.git -b manual_pack_unpack
ipbb add git https://github.com/bundocka/s2pfjet-emp.git -b fullChainNew
runCmd 'cd src/phase-2-jet-trigger-chain/'
vivado_hls Phase2JetTrigger_ExportIP.tcl
source GetIPs.sh
vivado -mode batch -source jet_trigger_chain.tcl
cd ../../
ipbb proj create vivado s2PFJetClust s2pfjet-emp:projects/ku115dc_s2pfjet  -t top.dep
cd proj/s2PFJetClust
ipbb vivado project
ipbb vivado synth -j4 impl -j4
ipbb vivado package

# Fin!
