----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:47:50 07/15/2017 
-- Design Name: 
-- Module Name:    CPU_calculate - Behavioral 
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

entity CPU_calculate is
    Port ( CLK : in STD_LOGIC;
			  T1 : in  STD_LOGIC;
			  RST : in STD_LOGIC;
           Rupdate : in  STD_LOGIC;
           Raddr : in  STD_LOGIC_VECTOR (2 downto 0);
           Rnew : in  STD_LOGIC_VECTOR (7 downto 0);
			  IRin : in STD_LOGIC_VECTOR(15 downto 0);
			  JZctrl : out STD_LOGIC;
           ALU_out : out  STD_LOGIC_VECTOR(7 downto 0);
           ADDR_out : out  STD_LOGIC_VECTOR(15 downto 0));
end CPU_calculate;

architecture Behavioral of CPU_calculate is

type reg is array(7 downto 0) of std_logic_vector(7 downto 0);

signal regs : reg;
signal A : std_logic_vector(7 downto 0);
signal B : std_logic_vector(7 downto 0);
signal ALUOUT : std_logic_vector(7 downto 0);		

begin

	--数据准备和运算
	process(T1,CLK)
	begin
		-- 尝试不用时序电路
		if(T1 = '1' and T1'event) then
			A <= regs(conv_integer(unsigned(IRin(10 downto 8))));
			B <= regs(conv_integer(unsigned(IRin(2 downto 0))));
		end if;
		if(T1 = '1' and CLK = '1' and CLK'event) then
			case IRin(15 downto 11) is
				when "00000" => null;	-- JMP
				when "00010" => 			-- JZ
					case A is
						when "00000000" => 	JZctrl <= '1';
						when others => 		JZctrl <= '0';
					end case;
				when "00100" => ALUOUT <= unsigned(A) - unsigned(B);	--SUB
				when "00110" => ALUOUT <= unsigned(A) + unsigned(B);	--ADD
				when "01000" => ALUOUT <= IRin(7 downto 0);				--MVI
				when "01010" => ALUOUT <= B;									--MOV
				when "01100" => ALUOUT <= A;									--STA
				when "01110" => null;											--LDA
				when "10000" => ALUOUT <= A;									--OUT
				when "10010" => null;											--IN
				when others => null;
			end case;
		end if;
	end process;
	
ALU_OUT <= ALUOUT;
ADDR_OUT <= Regs(7) & IRin(7 downto 0);
	
	--更新寄存器的值
	process(Rupdate,RST)
	begin
		if(RST = '1') then
			for i in 0 to 7 loop
				regs(i) <= (others => '0');
			end loop;
		elsif(Rupdate'event and Rupdate = '1') then
			regs(conv_integer(unsigned(Raddr))) <= Rnew;
		end if;
	end process;

end Behavioral;

