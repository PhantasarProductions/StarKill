{ --- START LICENSE BLOCK ---
Star Kill
Game for DOS



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
Program StarKill;

Uses
  {Internal pascal stuff}
  Crt,

  {My own stuff}
  Cursor,
  Main;

Begin
  WriteLn('Star Kill - (c) Jeroen P. Broks, 2020, Released under the terms of the GPL');
  Delay(1500);
  CursorOff;
  RunMain;
  CursorOn
End.