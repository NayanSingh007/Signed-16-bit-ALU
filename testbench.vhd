


entity testbench is
end testbench;

architecture Struct of testbench is 
	
	signal inA, inB, outR :bit_vector(15 downto 0);
	signal inS0, inS1, outZ0,outC: bit;
	
	component ALU is
		port( A : in bit_vector(15 downto 0);
				B : in bit_vector(15 downto 0);
				R : out bit_vector(15 downto 0);
				S0,S1 : in bit;
				Z : out bit;
				C : out bit);
	end component;
	
begin 
		ALU_instance : ALU port map(A=> inA, B => inB, R => outR, S0 => inS0, S1 => inS1, Z => outZ0, C => OutC);
		
		process --inputs
		begin
		
			--5 Cases for Addition Operation
			
			inS0 <= '0';
			inS1 <= '0';
			inA <= "0010010100100110";   -- decimal equivalent = +9510
			inB <= "0100011101001010";   -- decimal equivalent = +18250
			wait for 5 ns;					  -- expected output = +27760
			
			inS0 <= '0';
			inS1 <= '0';
			inA <= "0010010100100110";   -- decimal equivalent = +9510
			inB <= "1011100010110110";   -- decimal equivalent = -18250
			wait for 5 ns;					  -- expected output = -8740
			
			inS0 <= '0';
			inS1 <= '0';
			inA <= "1101101011011010";   -- decimal equivalent = -9510
			inB <= "0100011101001010";   -- decimal equivalent = +18250
			wait for 5 ns;					  -- expected output = +8740
			
			inS0 <= '0';
			inS1 <= '0';
			inA <= "1101101011011010";   -- decimal equivalent = -9510
			inB <= "1011100010110110";   -- decimal equivalent = -18250
			wait for 5 ns;					  -- expected output = -27760
			
			inS0 <= '0';
			inS1 <= '0';
			inA <= "0010010100100110";   -- decimal equivalent = +9510
			inB <= "1101101011011010";   -- decimal equivalent = -9510
			wait for 5 ns;					  -- expected output = +0
			
			
			--5 Cases for Subtraction Operation
			
			inS0 <= '1';
			inS1 <= '0';
			inA <= "0010010100100110";   -- decimal equivalent = +9510
			inB <= "0100011101001010";   -- decimal equivalent = +18250
			wait for 5 ns;					  -- expected output = -8740
			
			inS0 <= '1';
			inS1 <= '0';
			inA <= "0010010100100110";   -- decimal equivalent = +9510
			inB <= "1011100010110110";   -- decimal equivalent = -18250
			wait for 5 ns;					  -- expected output = +27760
			
			inS0 <= '1';
			inS1 <= '0';
			inA <= "1101101011011010";   -- decimal equivalent = -9510
			inB <= "0100011101001010";   -- decimal equivalent = +18250
			wait for 5 ns;					  -- expected output = -27760
			
			inS0 <= '1';
			inS1 <= '0';
			inA <= "1101101011011010";   -- decimal equivalent = -9510
			inB <= "1011100010110110";   -- decimal equivalent = -18250
			wait for 5 ns;					  -- expected output = +8740
			
			inS0 <= '1';
			inS1 <= '0';
			inA <= "0010010100100110";   -- decimal equivalent = +9510
			inB <= "0010010100100110";   -- decimal equivalent = +9510
			wait for 5 ns;					  -- expected output = +0
			
			--4 Cases for NAND Operation
			
			inS0 <= '0';
			inS1 <= '1';
			inA <= "1111111111111111";  -- inputs both -ve
			inB <= "1111111111111111";  --expected output = "0000000000000000";
			wait for 5 ns;					  	  
			
			inS0 <= '0';
			inS1 <= '1';
			inA <= "1110110001110001";  -- inputs -ve and +ve respectively
			inB <= "0000000000001011";  --expected output = "1111111111111110";
			wait for 5 ns;					  
			
			inS0 <= '0';
			inS1 <= '1';
			inA <= "1111111100000000";  -- inputs both -ve 
			inB <= "1111111000000000";  --expected output = "0000000111111111";
			wait for 5 ns;					  
			
			inS0 <= '0';
			inS1 <= '1';
			inA <= "0000000000000000";  -- inputs +ve and -ve respectively
			inB <= "1111111111111111";  --expected output = "1111111111111111";
			wait for 5 ns;					  
			
			--4 Cases for Xor Operation
			
			inS0 <= '1';
			inS1 <= '1';
			inA <= "1111111111111111";  -- inputs both -ve
			inB <= "1111111111111111";  --expected output = "0000000000000000";
			wait for 5 ns;					  
			
			inS0 <= '1';
			inS1 <= '1';
			inA <= "1110110001111000";  -- inputs -ve and +ve respectively
			inB <= "0000000000001010";  --expected output = "1110110001110010";
			wait for 5 ns;					  
			
			inS0 <= '1';
			inS1 <= '1';
			inA <= "1111111100000000";  -- inputs both -ve 
			inB <= "1111111000000000";  --expected output = "0000000100000000";
			wait for 5 ns;					  
			
			inS0 <= '1';
			inS1 <= '1';
			inA <= "0000000000000000";  -- inputs +ve and -ve respectively
			inB <= "1111111111111111";  --expected output = "1111111111111111";
			wait for 5 ns;					  
			
			
		end process;
end Struct;
		
		