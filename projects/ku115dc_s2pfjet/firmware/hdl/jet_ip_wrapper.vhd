library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.emp_data_types.all;

entity jet_ip_wrapper is
  port (
    clk: in std_logic;
    rst: in std_logic;
    input: in ldata(71 downto 0);
    output : out ldata(71 downto 0)
    );
  
end jet_ip_wrapper;

architecture rtl of jet_ip_wrapper is
  
begin

  s2pfjet_algo : entity work.hls_histogrammer_0
    port map (
      ap_clk => clk,     
      inReset => rst,
      
      barrel_inputs_0 => input(0).data,
      barrel_inputs_1 => input(1).data,
      barrel_inputs_2 => input(2).data,
      barrel_inputs_3 => input(3).data,
      barrel_inputs_4 => input(4).data,
      barrel_inputs_5 => input(5).data,
      barrel_inputs_6 => input(6).data,
      barrel_inputs_7 => input(7).data,
      barrel_inputs_8 => input(8).data,
      barrel_inputs_9 => input(9).data,
      barrel_inputs_10 => input(10).data,
      barrel_inputs_11 => input(11).data,
      barrel_inputs_12 => input(12).data,
      barrel_inputs_13 => input(13).data,
      barrel_inputs_14 => input(14).data,
      barrel_inputs_15 => input(15).data,
      barrel_inputs_16 => input(16).data,
      barrel_inputs_17 => input(17).data,
      barrel_inputs_18 => input(18).data,
      barrel_inputs_19 => input(19).data,
      barrel_inputs_20 => input(20).data,
      barrel_inputs_21 => input(21).data,
      barrel_inputs_22 => input(22).data,
      barrel_inputs_23 => input(23).data,
      
      barrel_bins_0_0_V => output(0).data(9 downto 0), 
      barrel_bins_0_1_V => output(1).data(9 downto 0), 
      barrel_bins_0_2_V => output(2).data(9 downto 0), 
      barrel_bins_0_3_V => output(3).data(9 downto 0), 
      barrel_bins_0_4_V => output(4).data(9 downto 0), 
      barrel_bins_0_5_V => output(5).data(9 downto 0), 
      barrel_bins_0_6_V => output(6).data(9 downto 0), 
      barrel_bins_0_7_V => output(7).data(9 downto 0), 
      barrel_bins_0_8_V => output(8).data(9 downto 0), 
      barrel_bins_1_0_V => output(9).data(9 downto 0), 
      barrel_bins_1_1_V => output(10).data(9 downto 0),
      barrel_bins_1_2_V => output(11).data(9 downto 0),
      barrel_bins_1_3_V => output(12).data(9 downto 0),
      barrel_bins_1_4_V => output(13).data(9 downto 0),
      barrel_bins_1_5_V => output(14).data(9 downto 0),
      barrel_bins_1_6_V => output(15).data(9 downto 0),
      barrel_bins_1_7_V => output(16).data(9 downto 0),
      barrel_bins_1_8_V => output(17).data(9 downto 0),
      barrel_bins_2_0_V => output(18).data(9 downto 0),
      barrel_bins_2_1_V => output(19).data(9 downto 0),
      barrel_bins_2_2_V => output(20).data(9 downto 0),
      barrel_bins_2_3_V => output(21).data(9 downto 0),
      barrel_bins_2_4_V => output(22).data(9 downto 0),
      barrel_bins_2_5_V => output(23).data(9 downto 0),
      barrel_bins_2_6_V => output(24).data(9 downto 0),
      barrel_bins_2_7_V => output(25).data(9 downto 0),
      barrel_bins_2_8_V => output(26).data(9 downto 0),
      barrel_bins_3_0_V => output(27).data(9 downto 0),
      barrel_bins_3_1_V => output(28).data(9 downto 0),
      barrel_bins_3_2_V => output(29).data(9 downto 0),
      barrel_bins_3_3_V => output(30).data(9 downto 0),
      barrel_bins_3_4_V => output(31).data(9 downto 0),
      barrel_bins_3_5_V => output(32).data(9 downto 0),
      barrel_bins_3_6_V => output(33).data(9 downto 0),
      barrel_bins_3_7_V => output(34).data(9 downto 0),
      barrel_bins_3_8_V => output(35).data(9 downto 0),
      barrel_bins_4_0_V => output(36).data(9 downto 0),
      barrel_bins_4_1_V => output(37).data(9 downto 0),
      barrel_bins_4_2_V => output(38).data(9 downto 0),
      barrel_bins_4_3_V => output(39).data(9 downto 0),
      barrel_bins_4_4_V => output(40).data(9 downto 0),
      barrel_bins_4_5_V => output(41).data(9 downto 0),
      barrel_bins_4_6_V => output(42).data(9 downto 0),
      barrel_bins_4_7_V => output(43).data(9 downto 0),
      barrel_bins_4_8_V => output(44).data(9 downto 0),
      barrel_bins_5_0_V => output(45).data(9 downto 0),
      barrel_bins_5_1_V => output(46).data(9 downto 0),
      barrel_bins_5_2_V => output(47).data(9 downto 0),
      barrel_bins_5_3_V => output(48).data(9 downto 0),
      barrel_bins_5_4_V => output(49).data(9 downto 0),
      barrel_bins_5_5_V => output(50).data(9 downto 0),
      barrel_bins_5_6_V => output(51).data(9 downto 0),
      barrel_bins_5_7_V => output(52).data(9 downto 0),
      barrel_bins_5_8_V => output(53).data(9 downto 0),
      barrel_bins_6_0_V => output(54).data(9 downto 0),
      barrel_bins_6_1_V => output(55).data(9 downto 0),
      barrel_bins_6_2_V => output(56).data(9 downto 0),
      barrel_bins_6_3_V => output(57).data(9 downto 0),
      barrel_bins_6_4_V => output(58).data(9 downto 0),
      barrel_bins_6_5_V => output(59).data(9 downto 0),
      barrel_bins_6_6_V => output(60).data(9 downto 0),
      barrel_bins_6_7_V => output(61).data(9 downto 0),
      barrel_bins_6_8_V => output(62).data(9 downto 0),
      barrel_bins_7_0_V => output(63).data(9 downto 0),
      barrel_bins_7_1_V => output(64).data(9 downto 0),
      barrel_bins_7_2_V => output(65).data(9 downto 0),
      barrel_bins_7_3_V => output(66).data(9 downto 0),
      barrel_bins_7_4_V => output(67).data(9 downto 0),
      barrel_bins_7_5_V => output(68).data(9 downto 0),
      barrel_bins_7_6_V => output(69).data(9 downto 0),
      barrel_bins_7_7_V => output(70).data(9 downto 0),
      barrel_bins_7_8_V => output(71).data(9 downto 0)
      );

end rtl;


