----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:44:04 07/14/2017 
-- Design Name: 
-- Module Name:    CPU_fetch - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU_fetch is
    Port ( CLK : in STD_LOGIC;
			  T0 : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           PCupdate : in  STD_LOGIC;
           PCnew : in  STD_LOGIC_VECTOR (15 downto 0);
			  IRin : in STD_LOGIC_VECTOR(15 downto 0);
           IRr : out  STD_LOGIC;
           PCout : out  STD_LOGIC_VECTOR (15 downto 0);
           IRout : out  STD_LOGIC_VECTOR (15 downto 0));
end CPU_fetch;

architecture Behavioral of CPU_fetch is
signal IR : std_logic_vector(15 downto 0);
signal PC : std_logic_vector(15 downto 0);
begin

IR <= IRin;
IRr <= T0;
	
	
	--PC所有更新
	process(RST,CLK,PCupdate,T0,PCnew)
	begin
		if(RST = '1') then
			PC <= "0000000000000000";
		elsif(PCupdate = '1') then
			PC <= PCnew;
		elsif(CLK'event and CLK = '1' and T0 = '1') then
			PC <= unsigned(PC) + 1;
		end if;
	end process;
	
	--送地址
	process(T0)
	begin
		if(T0'event and T0 = '1') then
			PCout <= PC;
		end if;
	end process;
	
	--IR更新
	process(IR,CLK,T0) 
	begin
		if(CLK'event and CLK = '1' and T0 = '1') then
			IRout <= IR;
		end if;
	end process;
end Behavioral;

