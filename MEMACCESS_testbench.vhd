--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:32:21 07/20/2017
-- Design Name:   
-- Module Name:   C:/Users/123/Desktop/Documents/CPU_final(1)/MEMACCESS_testbench.vhd
-- Project Name:  CPU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_MemAccess
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
 
ENTITY MEMACCESS_testbench IS
END MEMACCESS_testbench;
 
ARCHITECTURE behavior OF MEMACCESS_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_MemAccess
    PORT(
         CLK : IN  std_logic;
         T2 : IN  std_logic;
         IRin : IN  std_logic_vector(4 downto 0);
         ALU_in : IN  std_logic_vector(7 downto 0);
         ADDR_in : IN  std_logic_vector(15 downto 0);
         WRm : OUT  std_logic;
         WRio : OUT  std_logic;
         RDm : OUT  std_logic;
         RDio : OUT  std_logic;
         ADDR_out : OUT  std_logic_vector(15 downto 0);
         data : INOUT  std_logic_vector(7 downto 0);
         Rtempout : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal T2 : std_logic := '0';
   signal IRin : std_logic_vector(4 downto 0) := (others => '0');
   signal ALU_in : std_logic_vector(7 downto 0) := (others => '0');
   signal ADDR_in : std_logic_vector(15 downto 0) := (others => '0');

	--BiDirs
   signal data : std_logic_vector(7 downto 0);

 	--Outputs
   signal WRm : std_logic;
   signal WRio : std_logic;
   signal RDm : std_logic;
   signal RDio : std_logic;
   signal ADDR_out : std_logic_vector(15 downto 0);
   signal Rtempout : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_MemAccess PORT MAP (
          CLK => CLK,
          T2 => T2,
          IRin => IRin,
          ALU_in => ALU_in,
          ADDR_in => ADDR_in,
          WRm => WRm,
          WRio => WRio,
          RDm => RDm,
          RDio => RDio,
          ADDR_out => ADDR_out,
          data => data,
          Rtempout => Rtempout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

  T2 <=  '1' after 11 ns,
			'0' after 21 ns,
			
			'1' after 31 ns,
			'0' after 41 ns,
			
			'1' after 51 ns,
			'0' after 61 ns,
			
			'1' after 71 ns,
			'0' after 81 ns,
			
			'1' after 91 ns,
			'0' after 101 ns,
			
			'1' after 111 ns,
			'0' after 121 ns;
	
	IRin <= 	"01100" after 5 ns,		-- STA
				"01110" after 25 ns,		-- LDA
				"10000" after 45 ns,		-- OUT	
				"10010" after 65 ns,		-- IN
				"00000" after 85 ns;		-- JMP
				
	ALU_in <= 	"00000001" after 5 ns,
					"00000010" after 25 ns,
					"00000011" after 45 ns,
					"00000100" after 65 ns,
					"00000101" after 85 ns;
			
	data <= (others => 'Z'),
				X"11" after 30 ns,
				(others => 'Z') after 40 ns,
				X"22" after 70 ns,
				(others => 'Z') after 80 ns;
				
	
	ADDR_in <= 	"0000000000000001" after 5 ns,
					"0000000000000010" after 25 ns,
					"0000000000000011" after 45 ns,
					"0000000000000100" after 65 ns,
					"0000000000000101" after 85 ns;

END;
