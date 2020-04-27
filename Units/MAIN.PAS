{ --- START LICENSE BLOCK ---
Star Kill
Main Menu and Chain Manager



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
Unit Main;

Interface
	Uses 
		Crt,
		Stars,
		Drivers,
		GameMain,
		Credits,
		QJCR6,
		Audio,
		Mouse;

    Procedure RunMain;

Implementation

	type 
		TMenuItem = RECORD
			y:Byte;
			x:Byte;
			Item:string;
			ChoiceCode:Byte;
			Enabled:Boolean;
		end;
		
		LogoArray = Array[1..40] of Boolean;
	
	var 
		MenuItem:Array[1..5] Of TMenuItem;
		Logo:array[1..5] of LogoArray;
		
	{
	Procedure MakeLogoLine(l:byte; a:LogoArray);
	var 
		I:byte;
	Begin
		for i:=1 to 40 do
			Logo[l][i]:=a[i]		
	end;
	}
		
	Procedure MakeLogo;
	var
		bt:tJCRFile;
		x,y:byte;
	Begin
			                {                  1                   2                   3                   4}
			                {1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0}
			{
			MakeLogoLine(1,( 0,1,1,1,0,1,1,1,0,0,1,1,0,0,1,1,0,0,0,1,0,0,1,0,1,0,1,0,0,0,1,0,0,0,0,1,0,1,0,1));
			MakeLogoLine(2,( 1,0,0,0,0,0,1,0,0,1,0,0,1,0,1,0,1,0,0,1,0,1,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,1,0,1));
			MakeLogoLine(3,( 0,1,1,0,0,0,1,0,0,1,1,1,1,0,1,1,0,0,0,1,1,0,0,0,1,0,1,0,0,0,1,0,0,0,0,1,0,1,0,1));
			MakeLogoLine(4,( 0,0,0,1,0,0,1,0,0,1,0,0,1,0,1,0,1,0,0,1,0,1,0,0,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0));
			MakeLogoLine(5,( 1,1,1,0,0,0,1,0,0,1,0,0,1,0,1,0,1,0,0,1,0,0,1,0,1,0,1,1,1,0,1,1,1,1,0,1,0,1,0,1));
			* }
			JCR_Open(bt,'Data.JCR','Logo.Num');
			for y:=1 to 5 do begin
				for x:=1 to 40 do Logo[y][x]:=JCR_GetChar(bt)='1';
				if JCR_GetByte(bt)<>10 then begin
					TextColor(4);
					Write('FATAL ERROR! ');
					TextColor(7);
					Write('Logo read error!');
					JCR_CLose(bt);
					halt(1)
				end
			end;
			JCR_Close(bt);
	end;
	
	Procedure ShowLogo;
	var 
		x,y:Byte;
	begin
		TextColor($1E); TextBackGround($1);
		for y:=1 to 5 do for x:=1 to 40 do if Logo[y][x] then begin
			GotoXY((x*2)-1,y);
			Write(#219#219)
		end;
		TextBackground(0);
	end;

	Procedure NewMenuItem(Idx:Byte; Item:String; Choice:Byte);
	Begin
		MenuItem[Idx].Item := Item;
		MenuItem[Idx].y    := 5 + (Idx*2);
		MenuItem[Idx].x    := 40 - Round(Length(Item)/2);
		MenuItem[Idx].ChoiceCode
		                   := Choice;
		MenuItem[Idx].Enabled
		                   := True
	End;

    Function MenuChoice:integer;
    var 
        ret:Integer;
    begin
        ret:=0;
        if (KeyPressed) then if (ReadKey=#27) then ret:=255;
        MenuChoice:=ret;
    end;

    Procedure RunMain;
    var 
        Choice:integer;
        i:Byte;
    begin
		NoSound;
		ClrScr;
		{ ShowMouse; { }
        repeat
            Choice:=MenuChoice;
			GetMouse;
			if Mouse_LeftHit then begin
				AudioPlay(1000,5);								
			end;
            ShowStars;
            ShowLogo;
            for i:=1 to 5 do begin
				gotoxy(MenuItem[i].x,MenuItem[i].y);
				TextColor(7); TextBackGround(0);
				if not MenuItem[i].enabled then
					TextColor(8)
				else if Mouse_Y=MenuItem[i].y-1 then begin
					TextColor(14); TextBackGround(1);
					if Mouse_LeftHit then Choice:=MenuItem[i].ChoiceCode
				end;
				Write(MenuItem[i].Item);
				DrawMouse;
				TextColor(7); TextBackGround(0)
			end;
			case Choice Of
				1: Begin
					Game_Init;
					Game_Run
				   end;
				3: Begin
					UseAudio:=Not UseAudio;
					MenuItem[3].Item:='Audio: '+AudioOn;
					if UseAudio then AudioPlay(300,20)
				   end;
				4: Run_Credits;
			end;
			TextColor(8);
			GotoXY(9,25);
			Write('(c) Jeroen P. Broks, 2020, Released under the terms of the GPL');
			AudioCycle;
        until Choice=255;
        {HideMouse; { }
        TextColor(7);
        ClrScr;
        NoSound;
        WriteLn('Good bye!',#10,#13,'I hope you enjoyed!')
    end;
    
    
Begin
	MakeLogo;
	NewMenuItem(1,'New Game',1);
	NewMenuItem(2,'Continue',2); MenuItem[2].Enabled := False;
	NewMenuItem(3,'Audio: ON',3);
	NewMenuItem(4,'Credits',4);	
	NewMenuItem(5,'Quit',255); MenuItem[5].y := MenuItem[5].y + 2
End.