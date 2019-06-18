library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.ipbus.all;
use work.emp_data_types.all;
use work.top_decl.all;

use work.emp_data_types.all;
use work.emp_device_decl.all;
use work.mp7_ttc_decl.all;

use work.pf_data_types.all;
use work.pf_constants.all;

entity emp_payload is
  port(
    clk: in std_logic; -- ipbus signals
    rst: in std_logic;
    ipb_in: in ipb_wbus;
    ipb_out: out ipb_rbus;
    clk_payload: in std_logic_vector(2 downto 0);
    rst_payload: in std_logic_vector(2 downto 0);
    clk_p: in std_logic; -- data clock
    rst_loc: in std_logic_vector(N_REGION - 1 downto 0);
    clken_loc: in std_logic_vector(N_REGION - 1 downto 0);
    ctrs: in ttc_stuff_array;
    bc0: out std_logic;
    d: in ldata(4 * N_REGION - 1 downto 0); -- data in
    q: out ldata(4 * N_REGION - 1 downto 0); -- data out
    gpio: out std_logic_vector(29 downto 0); -- IO to mezzanine connector
    gpio_en: out std_logic_vector(29 downto 0) -- IO to mezzanine connector (three-state enables)
    );
  
end emp_payload;

architecture rtl of emp_payload is

  signal rst_loc_reg : std_logic_vector(N_REGION - 1 downto 0);       
  constant N_FRAMES_USED : natural := 1;
  signal start_pf : std_logic_vector(5 downto 0);
  signal d_pf : pf_data_array(N_PF_IP_CORES - 1 downto 0)(N_PF_IP_CORE_IN_CHANS - 1 downto 0);
  signal q_pf : pf_data_array(N_PF_IP_CORES - 1 downto 0)(N_PF_IP_CORE_OUT_CHANS - 1 downto 0);

begin

  s2pfjet_algo : entity work.hls_jet_clustering
    port map (
      ap_clk => clk,
      ap_rst => rst,
      ap_start => start, 
      ap_done => done, 
      ap_idle => idle,
      ap_ready => ready,
      inCaloGridPhiSlice_0_V => d(0).data(9 downto 0),
      inCaloGridPhiSlice_1_V => d(1).data(9 downto 0),
      inCaloGridPhiSlice_2_V => d(2).data(9 downto 0),
      inCaloGridPhiSlice_3_V => d(3).data(9 downto 0),
      inCaloGridPhiSlice_4_V => d(4).data(9 downto 0),
      inCaloGridPhiSlice_5_V => d(5).data(9 downto 0),
      inCaloGridPhiSlice_6_V => d(6).data(9 downto 0),
      inCaloGridPhiSlice_7_V => d(7).data(9 downto 0),
      inCaloGridPhiSlice_8_V => d(8).data(9 downto 0),
      inCaloGridPhiSlice_9_V => d(9).data(9 downto 0),
      inCaloGridPhiSlice_10_V => d(10).data(9 downto 0),
      inCaloGridPhiSlice_11_V => d(11).data(9 downto 0),
      inCaloGridPhiSlice_12_V => d(12).data(9 downto 0),
      inCaloGridPhiSlice_13_V => d(13).data(9 downto 0),
      inCaloGridPhiSlice_14_V => d(14).data(9 downto 0),
      inCaloGridPhiSlice_15_V => d(15).data(9 downto 0),
      inCaloGridPhiSlice_16_V => d(16).data(9 downto 0),
      inCaloGridPhiSlice_17_V => d(17).data(9 downto 0),
      inCaloGridPhiSlice_18_V => d(18).data(9 downto 0),
      inCaloGridPhiSlice_19_V => d(19).data(9 downto 0),
      inCaloGridPhiSlice_20_V => d(20).data(9 downto 0),
      inCaloGridPhiSlice_21_V => d(21).data(9 downto 0),
      inCaloGridPhiSlice_22_V => d(22).data(9 downto 0),
      inCaloGridPhiSlice_23_V => d(23).data(9 downto 0),
      inCaloGridPhiSlice_24_V => d(24).data(9 downto 0),
      inCaloGridPhiSlice_25_V => d(25).data(9 downto 0),
      inCaloGridPhiSlice_26_V => d(26).data(9 downto 0),
      inCaloGridPhiSlice_27_V => d(27).data(9 downto 0),
      inCaloGridPhiSlice_28_V => d(28).data(9 downto 0),
      inCaloGridPhiSlice_29_V => d(29).data(9 downto 0),
      inCaloGridPhiSlice_30_V => d(30).data(9 downto 0),
      inCaloGridPhiSlice_31_V => d(31).data(9 downto 0),
      inCaloGridPhiSlice_32_V => d(32).data(9 downto 0),
      inCaloGridPhiSlice_33_V => d(33).data(9 downto 0),
      inCaloGridPhiSlice_34_V => d(34).data(9 downto 0),
      inCaloGridPhiSlice_35_V => d(35).data(9 downto 0),
      inCaloGridPhiSlice_36_V => d(36).data(9 downto 0),
      inCaloGridPhiSlice_37_V => d(37).data(9 downto 0),
      inCaloGridPhiSlice_38_V => d(38).data(9 downto 0),
      inCaloGridPhiSlice_39_V => d(39).data(9 downto 0),
      inCaloGridPhiSlice_40_V => d(40).data(9 downto 0),
      inCaloGridPhiSlice_41_V => d(41).data(9 downto 0),
      inCaloGridPhiSlice_42_V => d(42).data(9 downto 0),
      inCaloGridPhiSlice_43_V => d(43).data(9 downto 0),
      inCaloGridPhiSlice_44_V => d(44).data(9 downto 0),
      inCaloGridPhiSlice_45_V => d(45).data(9 downto 0),
      inCaloGridPhiSlice_46_V => d(46).data(9 downto 0),
      inCaloGridPhiSlice_47_V => d(47).data(9 downto 0),
      inCaloGridPhiSlice_48_V => d(48).data(9 downto 0),
      inCaloGridPhiSlice_49_V => d(49).data(9 downto 0),
      inCaloGridPhiSlice_50_V => d(50).data(9 downto 0),
      inCaloGridPhiSlice_51_V => d(51).data(9 downto 0),
      inCaloGridPhiSlice_52_V => d(52).data(9 downto 0),
      inCaloGridPhiSlice_53_V => d(53).data(9 downto 0),
      inCaloGridPhiSlice_54_V => d(54).data(9 downto 0),
      inCaloGridPhiSlice_55_V => d(55).data(9 downto 0),
      inCaloGridPhiSlice_56_V => d(56).data(9 downto 0),
      inCaloGridPhiSlice_57_V => d(57).data(9 downto 0),
      inCaloGridPhiSlice_58_V => d(58).data(9 downto 0),
      inCaloGridPhiSlice_59_V => d(59).data(9 downto 0),
      inCaloGridPhiSlice_60_V => d(60).data(9 downto 0),
      inCaloGridPhiSlice_61_V => d(61).data(9 downto 0),
      inCaloGridPhiSlice_62_V => d(62).data(9 downto 0),
      inCaloGridPhiSlice_63_V => d(63).data(9 downto 0),
      inCaloGridPhiSlice_64_V => d(64).data(9 downto 0),
      inCaloGridPhiSlice_65_V => d(65).data(9 downto 0),
      inCaloGridPhiSlice_66_V => d(66).data(9 downto 0),
      inCaloGridPhiSlice_67_V => d(67).data(9 downto 0),
      inCaloGridPhiSlice_68_V => d(68).data(9 downto 0),
      inCaloGridPhiSlice_69_V => d(69).data(9 downto 0),
      inCaloGridPhiSlice_70_V => d(70).data(9 downto 0),
      inCaloGridPhiSlice_71_V => d(71).data(9 downto 0),
      inCaloGridPhiSlice_72_V => d(72).data(9 downto 0),
      
      outJets_0_V => q(0).data(25 downto 0),
      outJets_1_V => q(1).data(25 downto 0),
      outJets_2_V => q(2).data(25 downto 0),
      outJets_3_V => q(3).data(25 downto 0),
      outJets_4_V => q(4).data(25 downto 0),
      outJets_5_V => q(5).data(25 downto 0),
      outJets_6_V => q(6).data(25 downto 0),
      outJets_7_V => q(7).data(25 downto 0),
      outJets_8_V => q(8).data(25 downto 0),
      outJets_9_V => q(9).data(25 downto 0),
      outJets_10_V => q(10).data(25 downto 0),
      outJets_11_V => q(11).data(25 downto 0),
      outJets_12_V => q(12).data(25 downto 0),
      outJets_13_V => q(13).data(25 downto 0),
      outJets_14_V => q(14).data(25 downto 0),
      outJets_15_V => q(15).data(25 downto 0),
      outJets_16_V => q(16).data(25 downto 0),
      outJets_17_V => q(17).data(25 downto 0),
      outJets_18_V => q(18).data(25 downto 0),
      outJets_19_V => q(19).data(25 downto 0),
      outJets_20_V => q(20).data(25 downto 0),
      outJets_21_V => q(21).data(25 downto 0),
      outJets_22_V => q(22).data(25 downto 0),
      outJets_23_V => q(23).data(25 downto 0),
      outJets_24_V => q(24).data(25 downto 0),
      outJets_25_V => q(25).data(25 downto 0),
      outJets_26_V => q(26).data(25 downto 0),
      outJets_27_V => q(27).data(25 downto 0),
      outJets_28_V => q(28).data(25 downto 0),
      outJets_29_V => q(29).data(25 downto 0),
      outJets_30_V => q(30).data(25 downto 0),
      outJets_31_V => q(31).data(25 downto 0),
      outJets_32_V => q(32).data(25 downto 0),
      outJets_33_V => q(33).data(25 downto 0),
      outJets_34_V => q(34).data(25 downto 0),
      outJets_35_V => q(35).data(25 downto 0),
      outJets_36_V => q(36).data(25 downto 0),
      outJets_37_V => q(37).data(25 downto 0),
      outJets_38_V => q(38).data(25 downto 0),
      outJets_39_V => q(39).data(25 downto 0),
      outJets_40_V => q(40).data(25 downto 0),
      outJets_41_V => q(41).data(25 downto 0),
      outJets_42_V => q(42).data(25 downto 0),
      outJets_43_V => q(43).data(25 downto 0),
      outJets_44_V => q(44).data(25 downto 0),
      outJets_45_V => q(45).data(25 downto 0),
      outJets_46_V => q(46).data(25 downto 0),
      outJets_47_V => q(47).data(25 downto 0),
      outJets_48_V => q(48).data(25 downto 0),
      outJets_49_V => q(49).data(25 downto 0),
      outJets_50_V => q(50).data(25 downto 0),
      outJets_51_V => q(51).data(25 downto 0),
      outJets_52_V => q(52).data(25 downto 0),
      outJets_53_V => q(53).data(25 downto 0),
      outJets_54_V => q(54).data(25 downto 0),
      outJets_55_V => q(55).data(25 downto 0),
      outJets_56_V => q(56).data(25 downto 0),
      outJets_57_V => q(57).data(25 downto 0),
      outJets_58_V => q(58).data(25 downto 0),
      outJets_59_V => q(59).data(25 downto 0),
      outJets_60_V => q(60).data(25 downto 0),
      outJets_61_V => q(61).data(25 downto 0),
      outJets_62_V => q(62).data(25 downto 0),
      outJets_63_V => q(63).data(25 downto 0),
      outJets_64_V => q(64).data(25 downto 0),
      outJets_65_V => q(65).data(25 downto 0),
      outJets_66_V => q(66).data(25 downto 0),
      outJets_67_V => q(67).data(25 downto 0),
      outJets_68_V => q(68).data(25 downto 0),
      outJets_69_V => q(69).data(25 downto 0),
      outJets_70_V => q(70).data(25 downto 0),
      outJets_71_V => q(71).data(25 downto 0),
      outJets_72_V => q(72).data(25 downto 0)
      
      );


  
  
  ipb_out <= IPB_RBUS_NULL;
  
  -- TODO this is temporary, while isolating segfault
  --gDummy : for i in N_PF_IP_CORE_IN_CHANS - 1 downto 0 generate
  --  d_pf(0)(i) <= d(i).data(31 downto 0);
  --end generate;
  
  --gDummy2 : for i in N_PF_IP_CORE_OUT_CHANS - 1 downto 0 generate
  --   q(i).data(31 downto 0) <= q_pf(0)(i);
  --end generate;



  bc0 <= '0';
  gpio <= (others => '0');
  gpio_en <= (others => '0');

end rtl;
