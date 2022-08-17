
entity orGate4input is
	port(X,Y,Z,W: in bit; OrOP: out bit);
end orGate4input;

architecture gate of orGate4input is
begin
	proc: process(X,Y,Z,W) is
	begin
		if (W = '0' and  X = '0' and  Y = '0' and Z = '0') then   --OrOP is 0 only when W = X = Y = Z = 0
			OrOP <= '0';
		else 
			OrOP <= '1';
		end if;
	end process proc;
end gate;