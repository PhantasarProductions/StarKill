{ --- START LICENSE BLOCK ---
Star Kill
X



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

Version: 20.04.26
--- END LICENSE BLOCK --- }
Procedure NewHarten;
var 
	i:byte;

Begin
	if FreeObject(i) then with Obj[i] do begin
		Active:=true;
		ObjType:=4;
		X:=Random(70)+5;
		Y:=2;
		Lethal:=true;
		Killable:=true;
		AwardScore:=7;
		Color:=$4
	end
end;

Procedure ProcessHarten(i:byte);
var 
	r:byte;
begin with Obj[i] do begin
	if (time mod 2 = 0) and (Time<>TimeStamp) Then begin
		GotoXY(X,Y); Write(' ');
		r:=Random(4)+1;
		case r of
			1: if X> 3 then X:=X-1;
			2: if X<77 then X:=X+1;
			3: if Y> 3 then Y:=Y-1;
			4: if Y<20 then Y:=Y+1;
		end;
		TimeStamp:=time
	end;
	GotoXY(X,Y);
	TextColor(Color);
	Write(#3);
end end;
