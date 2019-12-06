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
      in_clock_360MHz => clk,     
      d0Valid => rst,
      
      inChargedInputs_0  => input(40).data,
      inChargedInputs_1  => input(41).data,
      inChargedInputs_2  => input(42).data,
      inChargedInputs_3  => input(43).data,
      inChargedInputs_4  => input(44).data,
      inChargedInputs_5  => input(45).data,
      inChargedInputs_6  => input(46).data,
      inChargedInputs_7  => input(47).data,
      inChargedInputs_8  => input(48).data,
      inChargedInputs_9  => input(49).data,
      
      inMuonInputs_0     => input(50).data,
      inMuonInputs_1     => input(51).data,
      inNeutralInputs_0  => input(52).data,
      inNeutralInputs_1  => input(53).data,
      inNeutralInputs_2  => input(54).data,
      inNeutralInputs_3  => input(55).data,
      inNeutralInputs_4  => input(56).data,

      inPhotonInputs_0   => input(57).data,
      inPhotonInputs_1   => input(58).data,
      inPhotonInputs_2   => input(59).data,
      inPhotonInputs_3   => input(60).data,
      inPhotonInputs_4   => input(61).data,
      inPhotonInputs_5   => input(62).data,
      inPhotonInputs_6   => input(63).data,

      inChargedInputs_10 => input(0).data,
      inChargedInputs_11 => input(1).data,
      inChargedInputs_12 => input(2).data,
      inChargedInputs_13 => input(3).data,

      inNeutralInputs_5  => input(4).data,
      inNeutralInputs_6  => input(5).data,
      inNeutralInputs_7  => input(6).data,
      inNeutralInputs_8  => input(7).data,
      inNeutralInputs_9  => input(8).data,
      
                                  
      inPhotonInputs_7   => input(9).data,
      inPhotonInputs_8   => input(10).data,
      inPhotonInputs_9   => input(11).data,


                                  
      outJets_0 => output(0).data,
      outJets_1 => output(1).data,
      outJets_2 => output(2).data,
      outJets_3 => output(3).data,
      outJets_4 => output(4).data,
      outJets_5 => output(5).data,
      outJets_6 => output(6).data,
      outJets_7 => output(7).data,
      outJets_8 => output(8).data


      
      );

end rtl;


