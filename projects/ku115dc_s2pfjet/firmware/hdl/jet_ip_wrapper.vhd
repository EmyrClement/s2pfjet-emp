library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.emp_data_types.all;

entity jet_ip_wrapper is
  port (
    clk: in std_logic;
    rst: in std_logic;
    start: in std_logic;
    input: in ldata(71 downto 0);
    done: out std_logic;
    idle: out std_logic;
    ready: out std_logic;
    output : out ldata(71 downto 0)
    );
  
end jet_ip_wrapper;

architecture rtl of jet_ip_wrapper is
  
begin

  s2pfjet_algo : entity work.jet_trigger_chain_wrapper_0
    port map (
      ap_clk => clk,
      ap_rst => rst,
      ap_start => start, -- ??
      ap_done => done, -- ??
      ap_idle => idle, -- ??
      ap_ready => ready, -- ??
      
      barrelLinks_0_0_V => input(0).data,
      barrelLinks_1_0_V => input(1).data,
      barrelLinks_2_0_V => input(2).data,
      barrelLinks_3_0_V => input(3).data,
      barrelLinks_4_0_V => input(4).data,
      barrelLinks_5_0_V => input(5).data,
      barrelLinks_6_0_V => input(6).data,
      barrelLinks_7_0_V => input(7).data,
      barrelLinks_8_0_V => input(8).data,
      barrelLinks_9_0_V => input(9).data,
      barrelLinks_10_0_V => input(10).data,
      barrelLinks_11_0_V => input(11).data,
      barrelLinks_12_0_V => input(12).data,
      barrelLinks_13_0_V => input(13).data,
      barrelLinks_14_0_V => input(14).data,
      barrelLinks_15_0_V => input(15).data,
      barrelLinks_16_0_V => input(16).data,
      barrelLinks_17_0_V => input(17).data,
      barrelLinks_18_0_V => input(18).data,
      barrelLinks_19_0_V => input(19).data,
      barrelLinks_20_0_V => input(20).data,
      barrelLinks_21_0_V => input(21).data,
      barrelLinks_22_0_V => input(22).data,
      barrelLinks_23_0_V => input(23).data,

      outJets_0_V => output(0).data,
      outJets_1_V => output(1).data,
      outJets_2_V => output(2).data,
      outJets_3_V => output(3).data,
      outJets_4_V => output(4).data,
      outJets_5_V => output(5).data,
      outJets_6_V => output(6).data,
      outJets_7_V => output(7).data,
      outJets_8_V => output(8).data,
      outJets_9_V => output(9).data,
      outJets_10_V => output(10).data,
      outJets_11_V => output(11).data,
      outJets_12_V => output(12).data,
      outJets_13_V => output(13).data,
      outJets_14_V => output(14).data,
      outJets_15_V => output(15).data,
      outJets_16_V => output(16).data,
      outJets_17_V => output(17).data
      
      );

end rtl;


