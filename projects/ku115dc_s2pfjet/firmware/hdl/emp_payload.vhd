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

  signal start: std_logic;
  signal done: std_logic;
  signal idle: std_logic;
  signal ready: std_logic;
  signal rst_loc_reg : std_logic_vector(N_REGION - 1 downto 0);       
  constant N_FRAMES_USED : natural := 1;

begin

  s2pfjet_algo : entity work.hls_histogrammer_0
    port map (
      ap_clk => clk,
      ap_rst => rst,
      ap_start => start, 
      ap_done => done, 
      ap_idle => idle,
      ap_ready => ready,
      reset => rst,
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
      
      outJets_0 => q(0).data(25 downto 0),
      outJets_1 => q(1).data(25 downto 0),
      outJets_2 => q(2).data(25 downto 0),
      outJets_3 => q(3).data(25 downto 0),
      outJets_4 => q(4).data(25 downto 0),
      outJets_5 => q(5).data(25 downto 0),
      outJets_6 => q(6).data(25 downto 0),
      outJets_7 => q(7).data(25 downto 0),
      outJets_8 => q(8).data(25 downto 0),
      outJets_9 => q(9).data(25 downto 0),
      outJets_10 => q(10).data(25 downto 0),
      outJets_11 => q(11).data(25 downto 0),
      outJets_12 => q(12).data(25 downto 0),
      outJets_13 => q(13).data(25 downto 0),
      outJets_14 => q(14).data(25 downto 0),
      outJets_15 => q(15).data(25 downto 0),
      outJets_16 => q(16).data(25 downto 0),
      outJets_17 => q(17).data(25 downto 0),
      outJets_18 => q(18).data(25 downto 0),
      outJets_19 => q(19).data(25 downto 0),
      outJets_20 => q(20).data(25 downto 0),
      outJets_21 => q(21).data(25 downto 0),
      outJets_22 => q(22).data(25 downto 0),
      outJets_23 => q(23).data(25 downto 0),
      outJets_24 => q(24).data(25 downto 0),
      outJets_25 => q(25).data(25 downto 0),
      outJets_26 => q(26).data(25 downto 0),
      outJets_27 => q(27).data(25 downto 0),
      outJets_28 => q(28).data(25 downto 0),
      outJets_29 => q(29).data(25 downto 0),
      outJets_30 => q(30).data(25 downto 0),
      outJets_31 => q(31).data(25 downto 0),
      outJets_32 => q(32).data(25 downto 0),
      outJets_33 => q(33).data(25 downto 0),
      outJets_34 => q(34).data(25 downto 0),
      outJets_35 => q(35).data(25 downto 0),
      outJets_36 => q(36).data(25 downto 0),
      outJets_37 => q(37).data(25 downto 0),
      outJets_38 => q(38).data(25 downto 0),
      outJets_39 => q(39).data(25 downto 0),
      outJets_40 => q(40).data(25 downto 0),
      outJets_41 => q(41).data(25 downto 0),
      outJets_42 => q(42).data(25 downto 0),
      outJets_43 => q(43).data(25 downto 0),
      outJets_44 => q(44).data(25 downto 0),
      outJets_45 => q(45).data(25 downto 0),
      outJets_46 => q(46).data(25 downto 0),
      outJets_47 => q(47).data(25 downto 0),
      outJets_48 => q(48).data(25 downto 0),
      outJets_49 => q(49).data(25 downto 0),
      outJets_50 => q(50).data(25 downto 0),
      outJets_51 => q(51).data(25 downto 0),
      outJets_52 => q(52).data(25 downto 0),
      outJets_53 => q(53).data(25 downto 0),
      outJets_54 => q(54).data(25 downto 0),
      outJets_55 => q(55).data(25 downto 0),
      outJets_56 => q(56).data(25 downto 0),
      outJets_57 => q(57).data(25 downto 0),
      outJets_58 => q(58).data(25 downto 0),
      outJets_59 => q(59).data(25 downto 0),
      outJets_60 => q(60).data(25 downto 0),
      outJets_61 => q(61).data(25 downto 0),
      outJets_62 => q(62).data(25 downto 0),
      outJets_63 => q(63).data(25 downto 0),
      outJets_64 => q(64).data(25 downto 0),
      outJets_65 => q(65).data(25 downto 0),
      outJets_66 => q(66).data(25 downto 0),
      outJets_67 => q(67).data(25 downto 0),
      outJets_68 => q(68).data(25 downto 0),
      outJets_69 => q(69).data(25 downto 0),
      outJets_70 => q(70).data(25 downto 0),
      outJets_71 => q(71).data(25 downto 0)
      
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
