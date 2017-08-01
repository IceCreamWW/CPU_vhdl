----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:01:00 07/15/2017 
-- Design Name: 
-- Module Name:    CPU_WriteBack - Behavioral 
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

entity CPU_WriteBack is
    Port ( T3 : in  STD_LOGIC;
			  CLK : in STD_LOGIC;
           IRin : in  STD_LOGIC_VECTOR (7 downto 0);
           Rtempin : in  STD_LOGIC_VECTOR (15 downto 0);
           JZctrl : in  STD_LOGIC;
           PCupdate : out  STD_LOGIC;
           PCnew : out  STD_LOGIC_VECTOR (15 downto 0);
           Rupdate : out  STD_LOGIC;
           Raddr : out  STD_LOGIC_VECTOR(2 downto 0);
           Rnew : out  STD_LOGIC_VECTOR (7 downto 0));
end CPU_WriteBack;

architecture Behavioral of CPU_WriteBack is

begin
PCnew <= Rtempin;
Rnew <= Rtempin(7 downto 0);
Raddr <= IRin(2 downto 0);
	process(T3,CLK) 
	begin
		if(T3 = '0') then 
			PCupdate <= '0';
			Rupdate <= '0';
		elsif(T3 = '1' and CLK = '1' and CLK'event) then
			case IRin(7 downto 3) is
				when "00000" => PCupdate <= '1';			--JMP
				when "00010" => PCupdate <= JZctrl;		--JZ
				when "00100" => Rupdate <= '1';			--SUB
				when "00110" => Rupdate <= '1';			--ADD
				when "01000" => Rupdate <= '1';			--MVI
				when "01010" => Rupdate <= '1';			--MOV
				when "01110" => Rupdate <= '1';			--LDA
				when "10010" => Rupdate <= '1';			--IN
				when others => null;
			end case;
		end if;
	end process;
end Behavioral;

