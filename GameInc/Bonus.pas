Procedure NewBonus;
var 
	i:byte;
Begin
	if FreeObject(i) then with Obj[i] do begin
		Active:=true;
		ObjType:=2;
		X:=Random(70)+5;
		Y:=random(15)+5;
		Lethal:=false;
		Killable:=true;
		AwardScore:=(Random(20)+5);
		Color:=$e;
	end
end;

Procedure ProcessBonus(i:byte);
var 
	r:byte;
begin with Obj[i] do begin
	GotoXY(X,Y);
	TextColor(Color);
	Write('$');
	if Random(5000)=1 then Active:=false
end end;
