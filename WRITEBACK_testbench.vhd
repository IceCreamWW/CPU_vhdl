--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:59:31 07/20/2017
-- Design Name:   
-- Module Name:   C:/Users/123/Desktop/Documents/CPU_final(1)/WRITEBACK_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_WriteBack
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
 
ENTITY WRITEBACK_testbench IS
END WRITEBACK_testbench;
 
ARCHITECTURE behavior OF WRITEBACK_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_WriteBack
    PORT(
         T3 : IN  std_logic;
         CLK : IN  std_logic;
         IRin : IN  std_logic_vector(7 downto 0);
         Rtempin : IN  std_logic_vector(15 downto 0);
         JZctrl : IN  std_logic;
         PCupdate : OUT  std_logic;
         PCnew : OUT  std_logic_vector(15 downto 0);
         Rupdate : OUT  std_logic;
         Raddr : OUT  std_logic_vector(2 downto 0);
         Rnew : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal T3 : std_logic := '0';
   signal CLK : std_logic := '0';
   signal IRin : std_logic_vector(7 downto 0) := (others => '0');
   signal Rtempin : std_logic_vector(15 downto 0) := (others => '0');
   signal JZctrl : std_logic := '0';

 	--Outputs
   signal PCupdate : std_logic;
   signal PCnew : std_logic_vector(15 downto 0);
   signal Rupdate : std_logic;
   signal Raddr : std_logic_vector(2 downto 0);
   signal Rnew : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_WriteBack PORT MAP (
          T3 => T3,
          CLK => CLK,
          IRin => IRin,
          Rtempin => Rtempin,
          JZctrl => JZctrl,
          PCupdate => PCupdate,
          PCnew => PCnew,
          Rupdate => Rupdate,
          Raddr => Raddr,
          Rnew => Rnew
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   T3 <= '1' after 10 ns,
			'0' after 20 ns,
			
			'1' after 30 ns,
			'0' after 40 ns,
			
			'1' after 50 ns,
			'0' after 60 ns,
			
			'1' after 70 ns,
			'0' after 80 ns,
			
			'1' after 90 ns,
			'0' after 100 ns;
	
	IRin <= 	"00000000" after 5 ns,	-- JMP 0000111100001111
				"00010000" after 25 ns,	-- JZ	 R0,0101010101010101
				"00010000" after 45 ns,	-- JZ	 R0,1010101010101010
				"00100001" after 65 ns,	-- SUB 
				"01100110" after 85 ns;	-- STA
	
	JZctrl <= '0' after 25 ns,
				 '1' after 45 ns;
	
	Rtempin <= 	"0000111100001111" after 5 ns,
					"0101010101010101" after 25 ns,
					"1010101010101010" after 45 ns,
					"0000000000000001" after 65 ns,
					"0000000000000010" after 85 ns;

END;
