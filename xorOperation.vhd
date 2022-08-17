

entity xorOperation is    -- performs Xor operation on 2 input bit vectors
	port( XA : in bit_vector(15 downto 0);
			XB : in bit_vector(15 downto 0);
			XO : out bit_vector(15 downto 0));
end xorOperation;

architecture gate of xorOperation is
	
	component xorGate is
		port(A,B : in bit; C: out bit);
	end component;
	
begin

	lvl1 :
		for i in 0 to 15 generate
			xorGate_Bit : xorGate port map(A => XA(i) , B => XB(i) , C => XO(i) );
		end generate lvl1;
end gate;