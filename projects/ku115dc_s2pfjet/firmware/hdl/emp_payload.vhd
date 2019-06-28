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

  s2pfjet_algo : entity work.jet_trigger_chain_wrapper_0
    port map (
      in_clock_240MHz => clk,
      inReset_0 => rst,
      barrel_inputs_0_0 => d(0).data(29 downto 0),
      barrel_inputs_1_0 => d(1).data(29 downto 0),
      barrel_inputs_2_0 => d(2).data(29 downto 0),
      barrel_inputs_3_0 => d(3).data(29 downto 0),
      barrel_inputs_4_0 => d(4).data(29 downto 0),
      barrel_inputs_5_0 => d(5).data(29 downto 0),
      barrel_inputs_6_0 => d(6).data(29 downto 0),
      barrel_inputs_7_0 => d(7).data(29 downto 0),
      barrel_inputs_8_0 => d(8).data(29 downto 0),
      barrel_inputs_9_0 => d(9).data(29 downto 0),
      barrel_inputs_10_0 => d(10).data(29 downto 0),
      barrel_inputs_11_0 => d(11).data(29 downto 0),
      barrel_inputs_12_0 => d(12).data(29 downto 0),
      barrel_inputs_13_0 => d(13).data(29 downto 0),
      barrel_inputs_14_0 => d(14).data(29 downto 0),
      barrel_inputs_15_0 => d(15).data(29 downto 0),
      barrel_inputs_16_0 => d(16).data(29 downto 0),
      barrel_inputs_17_0 => d(17).data(29 downto 0),
      barrel_inputs_18_0 => d(18).data(29 downto 0),
      barrel_inputs_19_0 => d(19).data(29 downto 0),
      barrel_inputs_20_0 => d(20).data(29 downto 0),
      barrel_inputs_21_0 => d(21).data(29 downto 0),
      barrel_inputs_22_0 => d(22).data(29 downto 0),
      barrel_inputs_23_0 => d(23).data(29 downto 0),
      
      outJets_0_0 => q(0).data(25 downto 0),
      outJets_1_0 => q(1).data(25 downto 0),
      outJets_2_0 => q(2).data(25 downto 0),
      outJets_3_0 => q(3).data(25 downto 0),
      outJets_4_0 => q(4).data(25 downto 0),
      outJets_5_0 => q(5).data(25 downto 0),
      outJets_6_0 => q(6).data(25 downto 0),
      outJets_7_0 => q(7).data(25 downto 0),
      outJets_8_0 => q(8).data(25 downto 0),
      outJets_9_0 => q(9).data(25 downto 0),
      outJets_10_0 => q(10).data(25 downto 0),
      outJets_11_0 => q(11).data(25 downto 0),
      outJets_12_0 => q(12).data(25 downto 0),
      outJets_13_0 => q(13).data(25 downto 0),
      outJets_14_0 => q(14).data(25 downto 0),
      outJets_15_0 => q(15).data(25 downto 0),
      outJets_16_0 => q(16).data(25 downto 0),
      outJets_17_0 => q(17).data(25 downto 0)
      
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
