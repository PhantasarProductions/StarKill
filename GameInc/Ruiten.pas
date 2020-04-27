{ --- START LICENSE BLOCK ---
Star Kill
Diamonds are forever



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
Procedure NewRuiten;
var 
	i:byte;

Begin
	if FreeObject(i) then with Obj[i] do begin
		Active:=true;
		ObjType:=5;
		X:=Random(70)+5;
		Y:=2;
		Lethal:=true;
		Killable:=true;
		AwardScore:=15;
		DX:=1;
		DY:=1;
		Color:=$4
	end
end;

Procedure ProcessRuiten(i:byte);
begin with Obj[i] do begin
	if (time mod 4 = 0) and (Time<>TimeStamp) Then begin
		GotoXY(X,Y); Write(' ');
		X:=X+DX;
		Y:=Y+DY;
		if X< 2 then DX:= 1;
		if X>78 then DX:=-1;
		if Y< 2 then DY:= 1;
		if Y>24 then DY:=-1;
		TimeStamp:=time
	end;
	GotoXY(X,Y);
	TextColor(Color);
	Write(#4);
end end;