
entity xorGate is
	port(A,B : in bit; C: out bit);
end xorGate;

architecture gate of xorGate is
begin
	proc: process(A,B) is				-- if A = B then Output C = 0
	begin
		if (A = B) then 
			C <= '0';
		else 
			C <= '1';
		end if;
	end process proc;
end gate;