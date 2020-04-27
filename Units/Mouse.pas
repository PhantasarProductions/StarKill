{ --- START LICENSE BLOCK ---
Units/Mouse.pas
Simple Mouse Management for Pascal
version: 20.04.26
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
Unit Mouse;

Interface

	Uses 
		Crt,
		Drivers;

	var
		Mouse_LeftDown:Boolean;
		Mouse_RightDown:Boolean;
		Mouse_LeftHit:Boolean;
		Mouse_RightHit:Boolean;
		Mouse_X,Mouse_Y:Byte;
	
	Procedure GetMouse;	
	Procedure DrawMouse;
	
Implementation

	var 
		MouseEvent:TEvent;
		L_LD,L_RD:Boolean;
		OX,OY:Byte;

	Procedure GetMouse;
	Begin
		GetMouseEvent(MouseEvent);
		Mouse_LeftHit :=false;
		Mouse_RightHit:=false;
		Case MouseEvent.What Of
			evMouseDown:Begin
				case MouseEvent.Buttons of
					mbLeftButton:Begin
						Mouse_LeftDown:=true;
						Mouse_LeftHit:=true; {(Mouse_LeftDown) and (Not L_LD);}
						L_LD:=true;
					end;
					mbRightButton:Begin
						Mouse_RightDown:=true;
						Mouse_RightHit:=true;{(Mouse_LeftDown) and (Not L_RD);}
						L_RD:=true;
					end
				end;
			end;
			evMouseUp:Begin
				case MouseEvent.Buttons of
					mbLeftButton:Begin
						Mouse_LeftDown:=false;
						L_LD:=false;
					end;
					mbRightButton:begin
						Mouse_RightDown:=false;
						L_RD:=False;
					end
				end;
			end;
			evMouseMove:Begin
				Mouse_X:=MouseEvent.Where.X;
				Mouse_Y:=MouseEvent.Where.Y;
			end;
		end;
	end;
	
	Procedure DrawMouse;
	begin
		TextBackGround(0);
		if (OX<>Mouse_X) or (OY<>Mouse_Y) then Begin
			if (OX<79) and (OY<24) then begin
				GoToXY(OX+1,OY+1);
				Write(#32);
				if OX<78 then Begin
					Write(#32);
					if OX<77 then Write(#32)
				end;
			end;
			if (OX<79) and (OY<23) then begin
				GoToXY(OX+1,OY+2);
				Write(#32);
				if OX<78 then Write(#32)
			end;
			OX:=Mouse_X;
			OY:=Mouse_Y
		end;
		TextColor(9);
		if (Mouse_X<79) and (Mouse_Y<24) then begin
			GoToXY(Mouse_X+1,Mouse_Y+1);
			Write(#220);
			if Mouse_X<78 then Begin
				Write(#220);
				if Mouse_X<77 then Write(#220)
			end;
		end;
		if (Mouse_X<79) and (Mouse_Y<23) then begin
			GoToXY(Mouse_X+1,Mouse_Y+2);
			Write(#219);
			if Mouse_X<78 then Write(#223)
		end
	end;
	
Begin
	InitEvents;
	HideMouse;
	L_LD:=false;
	L_RD:=false;
	Mouse_LeftDown:=false;
	Mouse_RightDown:=false;
	Mouse_LeftHit:=false;
	Mouse_RightHit:=false;
	Mouse_X:=0;
	Mouse_Y:=0;
end.