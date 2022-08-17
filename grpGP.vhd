
entity grpGP is   -- generates the grp G and P values for different levels
	port(
			G1 : in bit;
			P1 : in bit;
			G2 : in bit;
			P2 : in bit;
			G : out bit;
			P : out bit);
end grpGP;

architecture gate of grpGP is

	signal W : bit;

	component andGate is
		port(A,B : in bit; C: out bit);
	end component;
	
	component orGate is
		port(X,Y : in bit; Z: out bit);
	end component;
	
begin
	
	andGate_Instance : andGate port map(A => P2, B => P1, C => P);  -- P = Pi and Pi(Prev)
	
	andGate_Instance2 : andGate port map(A => P2, B => G1, C => W);  
																					-- G = (Pi and Gi(Prev)) or Gi
	orGate_Instance : orGate port map(X => W,Y => G2 ,Z => G);	
	
end gate;