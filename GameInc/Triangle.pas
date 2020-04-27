{ --- START LICENSE BLOCK ---
Star Kill
The Triangle Torpedo



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
Procedure NewTriangleTorpedo(EntireField:boolean);
var 
	i:byte;

Begin
	if FreeObject(i) then with Obj[i] do begin
		Active:=true;
		ObjType:=9;
		X:=Random(70)+5;
		if not EntireField then begin
			if X<40 then X:=1 else X:=80;
		end;
		Y:=1;
		Lethal:=true;
		Killable:=false;
		AwardScore:=5;
		Color:=Random($10)+1;
		
	end
end;

Procedure ProcessTriangleTorpedo(i:byte);
begin with Obj[i] do begin
	if (time mod 2 = 0) and (Time<>TimeStamp) Then begin
		GotoXY(X,Y); Write(' ');
		if ShipX+1>X then X:=X+1 else if ShipX+1<X then X:=X-1;
		Y:=Y+1;
		if Y>25 then begin 
			Y:=1; 
			Active:=false;
			Score:=Score+(abs((ShipX+1)-X)); 
		end;
		TimeStamp:=time
	end;
	if Active then begin
		GotoXY(X,Y);
		TextColor(Color);
		Write(#31);
		AudioPlay(1500-(Y*50),3)
	end;
end end;