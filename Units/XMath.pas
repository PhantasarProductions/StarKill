Unit XMath;

interfact

	function DegSin(degrees:real):real;
	
implementation

	function DegSin;
	var
		rad:real;
	Begin
		rad:= degrees * pi / 180;
		DegSin:=Sin(rad)
	end;
	
end.
