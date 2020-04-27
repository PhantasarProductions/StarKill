{ --- START LICENSE BLOCK ---
Units/Foutje.pas
Foutje Bedankt!
version: 20.04.27
Copyright (C)  Jeroen P. Broks
This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
arising from the use of this software.
Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:
1. The origin of this software must not be misrepresented; you must not
claim that you wrote the original software. If you use this software
in a product, an acknowledgment in the product documentation would be
appreciated but is not required.
2. Altered source versions must be plainly marked as such, and must not be
misrepresented as being the original software.
3. This notice may not be removed or altered from any source distribution.
--- END LICENSE BLOCK --- }
Unit Foutje;

	interface
		
		Uses
			Cursor,
			Crt;
	
		Procedure Crash(Err:string);
		Procedure Assert(Condition:Boolean; Err:String);
		
	implementation
	
		Procedure Crash;
		Begin
			TextBackground(0);
			TextColor(7);
			ClrScr;
			CursorOn;
			TextColor($14);
			WriteLn('Fatal Error!');
			TextColor($07);
			WriteLn(Err);
			Halt(20);
		End;
		
		Procedure Assert;
		Begin
			If not Condition Then Crash(Err)
		end;
		
	end.