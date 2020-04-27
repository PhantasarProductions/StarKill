{ --- START LICENSE BLOCK ---
Star Kill
Heeft er iemand een klavertje vier?



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
Procedure NewKlaveren;
var 
	i:byte;

Begin
	if FreeObject(i) then with Obj[i] do begin
		Active:=true;
		ObjType:=6;
		X:=Random(70)+5;
		Y:=Random(20)+3;
		Lethal:=true;
		Killable:=true;
		AwardScore:=9;
		Color:=$8
	end
end;

Procedure ProcessKlaveren(i:byte);
begin with Obj[i] do begin
	if (time mod 555 = 0) and (Time<>TimeStamp) Then begin
		GotoXY(X,Y); Write(' ');		
		X:=Random(70)+5;
		Y:=Random(20)+3;
		TimeStamp:=time
	end;
	GotoXY(X,Y);
	TextColor(Color);
	Write(#5);
end end;