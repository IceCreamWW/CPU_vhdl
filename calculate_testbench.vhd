--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:47:47 07/20/2017
-- Design Name:   
-- Module Name:   C:/Users/123/Desktop/Documents/CPU_final(1)/CALCULATE_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_calculate
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY CALCULATE_testbench IS
END CALCULATE_testbench;
 
ARCHITECTURE behavior OF CALCULATE_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_calculate
    PORT(
         CLK : IN  std_logic;
         T1 : IN  std_logic;
         RST : IN  std_logic;
         Rupdate : IN  std_logic;
         Raddr : IN  std_logic_vector(2 downto 0);
         Rnew : IN  std_logic_vector(7 downto 0);
         IRin : IN  std_logic_vector(15 downto 0);
         JZctrl : OUT  std_logic;
         ALU_out : OUT  std_logic_vector(7 downto 0);
         ADDR_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal T1 : std_logic := '0';
   signal RST : std_logic := '0';
   signal Rupdate : std_logic := '0';
   signal Raddr : std_logic_vector(2 downto 0) := (others => '0');
   signal Rnew : std_logic_vector(7 downto 0) := (others => '0');
   signal IRin : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal JZctrl : std_logic;
   signal ALU_out : std_logic_vector(7 downto 0);
   signal ADDR_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_calculate PORT MAP (
          CLK => CLK,
          T1 => T1,
          RST => RST,
          Rupdate => Rupdate,
          Raddr => Raddr,
          Rnew => Rnew,
          IRin => IRin,
          JZctrl => JZctrl,
          ALU_out => ALU_out,
          ADDR_out => ADDR_out
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   RST <= '1',
			 '0' after 10 ns,
			 '1' after 260 ns;
	
	T1 <= '1' after 20 ns,
			'0' after 30 ns,
			
			'1' after 60 ns,
			'0' after 70 ns,
			
			'1' after 100 ns,
			'0' after 110 ns,
			
			'1' after 140 ns,
			'0' after 150 ns,
			
			'1' after 180 ns,
			'0' after 190 ns,
			
			'1' after 220 ns,
			'0' after 230 ns;
	
	IRin <= 	"0100000010101010" after 15 ns,		-- MVI R0,10101010
				"0101011100000000" after 55 ns,		-- MOV R7,R0
				"0011000000000111" after 95 ns,		-- ADD R0,R7
				"0110000000000001" after 135 ns,		-- STA R0,00000001
				"0001001000001111" after 175 ns,		-- JZ	 R2,00001111
				"0001000000000011" after 215 ns;		-- JZ  R0,00000011
				
	Rupdate <= '1' after 40 ns,
				  '0' after 50 ns,
				  
				  '1' after 80 ns,
				  '0' after 90 ns,
				  
				  '1' after 120 ns,
				  '0' after 130 ns;
	
	Rnew <= 	"10101010" after 40 ns,
				"10101010" after 80 ns,
				"01010100" after 120 ns;
	
	Raddr <= "000" after 40 ns,
				"111" after 80 ns,
				"000" after 120 ns,
				"001" after 160 ns,
				"111" after 200 ns,
				"011" after 240 ns;

END;
