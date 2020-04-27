{ --- START LICENSE BLOCK ---
Star Kill
Stuiterballetje



(c) Jeroen P. Broks, 

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Please note that some references to data like pictures or audio, do not automatically
fall under this licenses. Mostly this is noted in the respective files.

Version: 20.04.27
--- END LICENSE BLOCK --- }
Procedure NewBouncer;
var 
	i:byte;

Begin
	if FreeObject(i) then with Obj[i] do begin
		Active:=true;
		ObjType:=7;
		Face:=true;
		X:=Random(2)+1; 
		DY:=Random(360);
		if X=1 then begin  
			X:=80;
			DX:=-1
		end else begin
			X:=1;
			DX:=1
		end;
		Y:=25-Abs(round(DegSin(DY)*20));
		Lethal:=true;
		Killable:=true;
		AwardScore:=18;
		Color:=Random($F)+1;
	end
end;

Procedure ProcessBouncer(i:byte);
label
	Uit;
begin with Obj[i] do begin
	if (time mod 9 = 0) and (Time<>TimeStamp) Then begin
		GotoXY(X,Y); Write(' ');		
		X:=X+DX;
		if (X<1) or (X>80) then begin
			Active:=false;
			{Pascal has no 'return' keyword, so this is the safer way out!}
			goto uit 
		end;
		DY:=DY+2;
		Y:=25-Abs(round(DegSin(DY)*20));
		if Y=25 then Face:=not Face;
		TimeStamp:=time
	end;
	GotoXY(X,Y);
	TextColor(Color);
	if Face then
		Write(#2)
	else
		Write(#1);
	Uit:
end end;