library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.ipbus.all;
use work.emp_data_types.all;

use work.emp_data_types.all;
use work.emp_device_decl.all;
use work.emp_ttc_decl.all;

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

  signal rst_algo: std_logic; 
  
begin

  ipb_out <= IPB_RBUS_NULL;

  magic_reset : process (clk_p)
  begin
    if rising_edge(clk_p) then
      if d(48).data = X"51091AA40951309E" then
        rst_algo <= '1';
      else
        rst_algo <= '0';
      end if;
    end if;
  end process magic_reset;

  
  s2pfjet_algo : entity work.jet_ip_wrapper
    port map (
      clk    => clk_p,
      rst    => rst_algo,
      input  => d(71 downto 0),
      output => q(71 downto 0)
      );

  gMux : for i in 71 downto 0 generate     
    selector_end : process (clk_p)
    begin 
      if rising_edge(clk_p) then
        q(i).strobe <= '1';
        q(i).valid  <= '1'; 
      end if;
    end process selector_end;
  end generate gMux;


  
  bc0 <= '0';
  gpio <= (others => '0');
  gpio_en <= (others => '0');

end rtl;
