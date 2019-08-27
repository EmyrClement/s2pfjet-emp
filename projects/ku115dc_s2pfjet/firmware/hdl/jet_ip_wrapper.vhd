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

  s2pfjet_algo : entity work.jet_trigger_chain_wrapper_0
    port map (
      in_clock_240MHz => clk,     
      d0Valid_0 => rst,
      
      barrel_inputs_0_0 => input(0).data,
      barrel_inputs_1_0 => input(1).data,
      barrel_inputs_2_0 => input(2).data,
      barrel_inputs_3_0 => input(3).data,
      barrel_inputs_4_0 => input(4).data,
      barrel_inputs_5_0 => input(5).data,
      barrel_inputs_6_0 => input(6).data,
      barrel_inputs_7_0 => input(7).data,
      barrel_inputs_8_0 => input(8).data,
      barrel_inputs_9_0 => input(9).data,
      barrel_inputs_10_0 => input(10).data,
      barrel_inputs_11_0 => input(11).data,
      barrel_inputs_12_0 => input(12).data,
      barrel_inputs_13_0 => input(13).data,
      barrel_inputs_14_0 => input(14).data,
      barrel_inputs_15_0 => input(15).data,
      barrel_inputs_16_0 => input(16).data,
      barrel_inputs_17_0 => input(17).data,
      barrel_inputs_18_0 => input(18).data,
      barrel_inputs_19_0 => input(19).data,
      barrel_inputs_20_0 => input(20).data,
      barrel_inputs_21_0 => input(21).data,
      barrel_inputs_22_0 => input(22).data,
      barrel_inputs_23_0 => input(23).data,
      
      outBins_0_V  => output(0).data(15 downto 0),
      outBins_1_V  => output(1).data(15 downto 0),
      outBins_2_V  => output(2).data(15 downto 0),
      outBins_3_V  => output(3).data(15 downto 0),
      outBins_4_V  => output(4).data(15 downto 0),
      outBins_5_V  => output(5).data(15 downto 0),
      outBins_6_V  => output(6).data(15 downto 0),
      outBins_7_V  => output(7).data(15 downto 0),
      outBins_8_V  => output(8).data(15 downto 0),
      outBins_9_V  => output(9).data(15 downto 0),
      outBins_10_V => output(10).data(15 downto 0),
      outBins_11_V => output(11).data(15 downto 0),
      outBins_12_V => output(12).data(15 downto 0),
      outBins_13_V => output(13).data(15 downto 0),
      outBins_14_V => output(14).data(15 downto 0),
      outBins_15_V => output(15).data(15 downto 0),
      outBins_16_V => output(16).data(15 downto 0),
      outBins_17_V => output(17).data(15 downto 0)
      
      );

end rtl;


