

entity nandOperation is        -- performs the Nand operation on 2 input bit vectors
	port( NA : in bit_vector(15 downto 0);
			NB : in bit_vector(15 downto 0);
			NO : out bit_vector(15 downto 0));
end nandOperation;

architecture gate of nandOperation is
	
	component nandGate is
		port(X,Y : in bit; Z: out bit);
	end component;
	
begin
	
	lvl1:
		for i in 0 to 15 generate
			nandGate_Bit : nandGate port map(X => NA(i) , Y => NB(i) , Z => NO(i) );
		end generate lvl1;
	
end gate;