----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:08:31 07/15/2017 
-- Design Name: 
-- Module Name:    CPU_MemAccess - Behavioral 
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

entity CPU_MemAccess is
    Port ( CLK : in STD_LOGIC;
			  T2 : in STD_LOGIC;
			  IRin : in  STD_LOGIC_VECTOR (4 downto 0);
           ALU_in : in  STD_LOGIC_VECTOR (7 downto 0);
           ADDR_in : in  STD_LOGIC_VECTOR (15 downto 0);
           WRm : out  STD_LOGIC;
           WRio : out  STD_LOGIC;
           RDm : out  STD_LOGIC;
           RDio : out  STD_LOGIC;
			  ADDR_out : out STD_LOGIC_VECTOR(15 downto 0);
           data : inout  STD_LOGIC_VECTOR (7 downto 0);
           Rtempout : out  STD_LOGIC_VECTOR (15 downto 0));
end CPU_MemAccess;

architecture Behavioral of CPU_MemAccess is
signal Rtemp : std_logic_vector(15 downto 0);
begin

ADDR_out <= ADDR_in;

	with IRin select	
	Rtemp <= ADDR_in						when "00000",
				ADDR_in 						when "00010",
				"00000000" & data 		when "01110",
				"00000000" & data			when "10010",
				"00000000" & ALU_in		when others;
			
	process(T2,CLK,IRin)
	begin
		if(CLK = '1') then
			WRm <= '1'; RDm <= '1'; WRio <= '1'; RDio <= '1';
			data <= (others => 'Z');
		elsif(T2 = '1' and T2'event) then
			case IRin is
				when "01100" => 	WRm <= '0';  	data <= ALU_in;
				when "01110" =>  	RDm <= '0'; 	data <= (others => 'Z');
				when "10000" =>  	WRio <= '0'; 	data <= ALU_in;
				when "10010" =>  	RDio <= '0';	data <= (others => 'Z');
				when others => null;
			end case;
		end if;
		
		if(CLK'event and CLK = '1' and T2 = '1') then
			Rtempout <= Rtemp;
		end if;
	end process;

end Behavioral;

