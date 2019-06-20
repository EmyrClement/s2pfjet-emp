library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.ipbus.all;
use work.emp_data_types.all;
use work.top_decl.all;

use work.emp_data_types.all;
use work.emp_device_decl.all;
use work.mp7_ttc_decl.all;

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
      barrel_inputs_0 => d(0).data(9 downto 0),
      barrel_inputs_1 => d(1).data(9 downto 0),
      barrel_inputs_2 => d(2).data(9 downto 0),
      barrel_inputs_3 => d(3).data(9 downto 0),
      barrel_inputs_4 => d(4).data(9 downto 0),
      barrel_inputs_5 => d(5).data(9 downto 0),
      barrel_inputs_6 => d(6).data(9 downto 0),
      barrel_inputs_7 => d(7).data(9 downto 0),
      barrel_inputs_8 => d(8).data(9 downto 0),
      barrel_inputs_9 => d(9).data(9 downto 0),
      barrel_inputs_10 => d(10).data(9 downto 0),
      barrel_inputs_11 => d(11).data(9 downto 0),
      barrel_inputs_12 => d(12).data(9 downto 0),
      barrel_inputs_13 => d(13).data(9 downto 0),
      barrel_inputs_14 => d(14).data(9 downto 0),
      barrel_inputs_15 => d(15).data(9 downto 0),
      barrel_inputs_16 => d(16).data(9 downto 0),
      barrel_inputs_17 => d(17).data(9 downto 0),
      barrel_inputs_18 => d(18).data(9 downto 0),
      barrel_inputs_19 => d(19).data(9 downto 0),
      barrel_inputs_20 => d(20).data(9 downto 0),
      barrel_inputs_21 => d(21).data(9 downto 0),
      barrel_inputs_22 => d(22).data(9 downto 0),
      barrel_inputs_23 => d(23).data(9 downto 0),
      tk_hg_inputs_0 => d(24).data(9 downto 0),
      tk_hg_inputs_1 => d(25).data(9 downto 0),
      tk_hg_inputs_2 => d(26).data(9 downto 0),
      tk_hg_inputs_3 => d(27).data(9 downto 0),
      tk_hg_inputs_4 => d(28).data(9 downto 0),
      tk_hg_inputs_5 => d(29).data(9 downto 0),
      tk_hg_inputs_6 => d(30).data(9 downto 0),
      tk_hg_inputs_7 => d(31).data(9 downto 0),
      tk_hg_inputs_8 => d(32).data(9 downto 0),
      tk_hg_inputs_9 => d(33).data(9 downto 0),
      tk_hg_inputs_10 => d(34).data(9 downto 0),
      tk_hg_inputs_11 => d(35).data(9 downto 0),
      tk_hg_inputs_12 => d(36).data(9 downto 0),
      tk_hg_inputs_13 => d(37).data(9 downto 0),
      tk_hg_inputs_14 => d(38).data(9 downto 0),
      tk_hg_inputs_15 => d(39).data(9 downto 0),
      tk_hg_inputs_16 => d(40).data(9 downto 0),
      tk_hg_inputs_17 => d(41).data(9 downto 0),
      tk_hg_inputs_18 => d(42).data(9 downto 0),
      tk_hg_inputs_19 => d(43).data(9 downto 0),
      tk_hg_inputs_20 => d(44).data(9 downto 0),
      tk_hg_inputs_21 => d(45).data(9 downto 0),
      tk_hg_inputs_22 => d(46).data(9 downto 0),
      tk_hg_inputs_23 => d(47).data(9 downto 0),
      hf_inputs_0 => d(48).data(9 downto 0),
      hf_inputs_1 => d(49).data(9 downto 0),
      hf_inputs_2 => d(50).data(9 downto 0),
      hf_inputs_3 => d(51).data(9 downto 0),
      hf_inputs_4 => d(52).data(9 downto 0),
      hf_inputs_5 => d(53).data(9 downto 0),
      hf_inputs_6 => d(54).data(9 downto 0),
      hf_inputs_7 => d(55).data(9 downto 0),
      hf_inputs_8 => d(56).data(9 downto 0),
      hf_inputs_9 => d(57).data(9 downto 0),
      hf_inputs_10 => d(58).data(9 downto 0),
      hf_inputs_11 => d(59).data(9 downto 0),
      hf_inputs_12 => d(60).data(9 downto 0),
      hf_inputs_13 => d(61).data(9 downto 0),
      hf_inputs_14 => d(62).data(9 downto 0),
      hf_inputs_15 => d(63).data(9 downto 0),
      hf_inputs_16 => d(64).data(9 downto 0),
      hf_inputs_17 => d(65).data(9 downto 0),
      hf_inputs_18 => d(66).data(9 downto 0),
      hf_inputs_19 => d(67).data(9 downto 0),
      hf_inputs_20 => d(68).data(9 downto 0),
      hf_inputs_21 => d(69).data(9 downto 0),
      hf_inputs_22 => d(70).data(9 downto 0),
      hf_inputs_23 => d(71).data(9 downto 0),

      barrel_bins_0_0_V => q(0).data(9 downto 0),
      barrel_bins_0_1_V => q(1).data(9 downto 0),
      barrel_bins_0_2_V => q(2).data(9 downto 0),
      barrel_bins_0_3_V => q(3).data(9 downto 0),
      barrel_bins_0_4_V => q(4).data(9 downto 0),
      barrel_bins_0_5_V => q(5).data(9 downto 0),
      barrel_bins_0_6_V => q(6).data(9 downto 0),
      barrel_bins_0_7_V => q(7).data(9 downto 0),
      barrel_bins_0_8_V => q(8).data(9 downto 0),
      barrel_bins_1_0_V => q(9).data(9 downto 0),
      barrel_bins_1_1_V => q(10).data(9 downto 0),
      barrel_bins_1_2_V => q(11).data(9 downto 0),
      barrel_bins_1_3_V => q(12).data(9 downto 0),
      barrel_bins_1_4_V => q(13).data(9 downto 0),
      barrel_bins_1_5_V => q(14).data(9 downto 0),
      barrel_bins_1_6_V => q(15).data(9 downto 0),
      barrel_bins_1_7_V => q(16).data(9 downto 0),
      barrel_bins_1_8_V => q(17).data(9 downto 0),
      barrel_bins_2_0_V => q(18).data(9 downto 0),
      barrel_bins_2_1_V => q(19).data(9 downto 0),
      barrel_bins_2_2_V => q(20).data(9 downto 0),
      barrel_bins_2_3_V => q(21).data(9 downto 0),
      barrel_bins_2_4_V => q(22).data(9 downto 0),
      barrel_bins_2_5_V => q(23).data(9 downto 0),
      barrel_bins_2_6_V => q(24).data(9 downto 0),
      barrel_bins_2_7_V => q(25).data(9 downto 0),
      barrel_bins_2_8_V => q(26).data(9 downto 0),
      tk_hg_bins_0_0_V => q(27).data(9 downto 0),
      tk_hg_bins_0_1_V => q(28).data(9 downto 0),
      tk_hg_bins_0_2_V => q(29).data(9 downto 0),
      tk_hg_bins_0_3_V => q(30).data(9 downto 0),
      tk_hg_bins_0_4_V => q(31).data(9 downto 0),
      tk_hg_bins_0_5_V => q(32).data(9 downto 0),
      tk_hg_bins_0_6_V => q(33).data(9 downto 0),
      tk_hg_bins_0_7_V => q(34).data(9 downto 0),
      tk_hg_bins_0_8_V => q(35).data(9 downto 0),
      tk_hg_bins_0_9_V => q(36).data(9 downto 0),
      tk_hg_bins_0_10_V => q(37).data(9 downto 0),
      tk_hg_bins_0_11_V => q(38).data(9 downto 0),
      tk_hg_bins_1_0_V => q(39).data(9 downto 0),
      tk_hg_bins_1_1_V => q(40).data(9 downto 0),
      tk_hg_bins_1_2_V => q(41).data(9 downto 0),
      tk_hg_bins_1_3_V => q(42).data(9 downto 0),
      tk_hg_bins_1_4_V => q(43).data(9 downto 0),
      tk_hg_bins_1_5_V => q(44).data(9 downto 0),
      tk_hg_bins_1_6_V => q(45).data(9 downto 0),
      tk_hg_bins_1_7_V => q(46).data(9 downto 0),
      tk_hg_bins_1_8_V => q(47).data(9 downto 0),
      tk_hg_bins_1_9_V => q(48).data(9 downto 0),
      tk_hg_bins_1_10_V => q(49).data(9 downto 0),
      tk_hg_bins_1_11_V => q(50).data(9 downto 0),
      tk_hg_bins_2_0_V => q(51).data(9 downto 0),
      tk_hg_bins_2_1_V => q(52).data(9 downto 0),
      tk_hg_bins_2_2_V => q(53).data(9 downto 0),
      tk_hg_bins_2_3_V => q(54).data(9 downto 0),
      tk_hg_bins_2_4_V => q(55).data(9 downto 0),
      tk_hg_bins_2_5_V => q(56).data(9 downto 0),
      tk_hg_bins_2_6_V => q(57).data(9 downto 0),
      tk_hg_bins_2_7_V => q(58).data(9 downto 0),
      tk_hg_bins_2_8_V => q(59).data(9 downto 0),
      tk_hg_bins_2_9_V => q(60).data(9 downto 0),
      tk_hg_bins_2_10_V => q(61).data(9 downto 0),
      tk_hg_bins_2_11_V => q(62).data(9 downto 0),
      hf_bins_0_0_V => q(63).data(9 downto 0),
      hf_bins_0_1_V => q(64).data(9 downto 0),
      hf_bins_0_2_V => q(65).data(9 downto 0),
      hf_bins_0_3_V => q(66).data(9 downto 0),
      hf_bins_0_4_V => q(67).data(9 downto 0),
      hf_bins_0_5_V => q(68).data(9 downto 0),
      hf_bins_1_0_V => q(69).data(9 downto 0),
      hf_bins_1_1_V => q(70).data(9 downto 0),
      hf_bins_1_2_V => q(71).data(9 downto 0),


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
