
entity andGate3input is
	port(A,B,C : in bit; D: out bit);
end andGate3input;

architecture gate of andGate3input is
begin
	proc1: process(A,B,C) is
	begin
		if (A = '1' and  B = '1' and C = '1') then   --D = '1' only is A = B = C = '1'
			D <= '1';
		else 
			D <= '0';
		end if;
	end process proc1;
end gate;