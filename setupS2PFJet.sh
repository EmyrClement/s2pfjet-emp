runCmd() {
    printf "\n\n\n $1 \n\n\n"; read -n 1 -s -r -p $'\x0a Hit any key to continue \x0a \x0a'; eval $1
}

source ~/ipbb-0.5.2/env.sh
ipbb init s2PFJet
cd s2PFJet
ipbb add git https://:@gitlab.cern.ch:8443/p2-xware/firmware/emp-fwk.git -b v0.3.4
ipbb add git https://github.com/ipbus/ipbus-firmware -b v1.7
ipbb add git https://gitlab.cern.ch/ttc/legacy_ttc.git -b v2.1
ipbb add git https://:@gitlab.cern.ch:8443/sbologna/phase-2-jet-trigger-chain.git -b 0.13.1-mbd
ipbb add git https://github.com/bundocka/s2pfjet-emp.git
cd src/phase-2-jet-trigger-chain/
vivado_hls Phase2JetTrigger_ExportIP_KU15P_7x7Jets.tcl
source GetIPs_KU15P.sh
vivado -mode batch -source jet_trigger_chain_KU15P.tcl
cd ../../
ipbb proj create vivado s2PFJetClust s2pfjet-emp:projects/ku15pdc_s2pfjet  -t dc_ku15p_sm1_v2.dep
cd proj/s2PFJetClust
ipbb vivado project
ipbb vivado synth -j4 impl -j4
ipbb vivado package

# Fin!
