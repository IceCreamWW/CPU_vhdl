----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:00:15 07/15/2017 
-- Design Name: 
-- Module Name:    CPU_CLK - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU_CLK is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           T : out  STD_LOGIC_VECTOR (3 downto 0));
end CPU_CLK;

architecture Behavioral of CPU_CLK is
begin

	process(rst,clk)
	variable q : std_logic_vector(3 downto 0);
	begin
		if(rst = '1') then
			T <= "0000";
			q := "0001"; 
		elsif(clk = '0' and clk'event) then
			case q is
				when"0001" => 	T <= "0001";		q:="0010";
				when"0010" => 	T <= "0010";		q:="0100";
				when"0100" => 	T <= "0100";		q:="1000";
				when others => T <= "1000";		q:="0001";
			end case;
		end if;
	end process;

end Behavioral;

