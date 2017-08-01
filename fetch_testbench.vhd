--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:48:07 07/20/2017
-- Design Name:   
-- Module Name:   C:/Users/123/Desktop/Documents/CPU_final(1)/FETCH_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_fetch
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
 
ENTITY FETCH_testbench IS
END FETCH_testbench;
 
ARCHITECTURE behavior OF FETCH_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_fetch
    PORT(
         CLK : IN  std_logic;
         T0 : IN  std_logic;
         RST : IN  std_logic;
         PCupdate : IN  std_logic;
         PCnew : IN  std_logic_vector(15 downto 0);
         IRin : IN  std_logic_vector(15 downto 0);
         IRr : OUT  std_logic;
         PCout : OUT  std_logic_vector(15 downto 0);
         IRout : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal T0 : std_logic := '0';
   signal RST : std_logic := '0';
   signal PCupdate : std_logic := '0';
   signal PCnew : std_logic_vector(15 downto 0) := (others => '0');
   signal IRin : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal IRr : std_logic;
   signal PCout : std_logic_vector(15 downto 0);
   signal IRout : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_fetch PORT MAP (
          CLK => CLK,
          T0 => T0,
          RST => RST,
          PCupdate => PCupdate,
          PCnew => PCnew,
          IRin => IRin,
          IRr => IRr,
          PCout => PCout,
          IRout => IRout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   RST <= 	'1',
				'0' after 10 ns,
				'1' after 110 ns;
				
	T0 <= '1' after 10 ns,
			'0' after 20 ns,
			'1' after 50 ns,
			'0' after 60 ns,
			'1' after 90 ns,
			'0' after 100 ns;
			
	IRin <= 	"0000000000001111" after 11 ns,	-- JMP R0,R7 & 00001111 ²âÊÔPCÌø×ª
				(others => 'Z') after 20 ns,
				"1000000100000011" after 51 ns,	
				(others => 'Z') after 60 ns,
				"1111000011110000" after 91 ns,	-- ²âÊÔ PC + 1
				(others => 'Z') after 100 ns;
				
	
	PCupdate <= '1' after 40 ns,
					'0' after 50 ns;
					
	PCnew <= "0000000000001111" after 40 ns;
				
END;
