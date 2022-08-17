
entity andGate is
	port(A,B : in bit; C: out bit);
end andGate;

architecture gate of andGate is
begin
	proc1: process(A,B) is
	begin
		if (A = '1' and  B = '1') then   -- C is 1 only is A = B = '1';
			C <= '1';
		else 
			C <= '0';
		end if;
	end process proc1;
end gate;