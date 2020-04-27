{ --- START LICENSE BLOCK ---
Star Kill
$



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