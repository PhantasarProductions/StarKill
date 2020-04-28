{ --- START LICENSE BLOCK ---
Star Kill
Schop 'm voor z'n klote!



(c) Jeroen P. Broks, 2020

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

Version: 20.04.28
--- END LICENSE BLOCK --- }
Procedure NewSchoppen;
var 
	i:byte;
Begin
	if FreeObject(i) then with Obj[i] do begin
		Active:=true;
		ObjType:=3;
		X:=Random(70)+5;
		Y:=1;
		Lethal:=true;
		Killable:=true;
		AwardScore:=12;
		Color:=$8;
	end
end;

Procedure ProcessSchoppen(i:byte);
begin with Obj[i] do begin
	if (time mod 3 = 0) and (Time<>TimeStamp) Then begin
		GotoXY(X,Y); Write(' ');
		Y:=Y+1;
		if Y>25 then begin Y:=1; Active:=false; end;
		TimeStamp:=time
	end;
	GotoXY(X,Y);
	TextColor(Color);
	Write(#6);
end end;