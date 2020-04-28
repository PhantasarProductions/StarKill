{ --- START LICENSE BLOCK ---
Star Kill
Main Game Content



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

Version: 20.04.28
--- END LICENSE BLOCK --- }

Unit GameMain;

{$Define QuickEND}

interface

	Uses
		Crt,
		Mouse,
		Timer,
		XMath,
		Audio,
		Stars;

	procedure Game_Init;
	procedure Game_Run;
	
Implementation

	{$I Objects.pas}

	Const ObjMax = 100;
	
	var
		Score:LongInt;
		XLife:LongInt;
		Lives:Byte;
		ShipX:Byte;
		Obj:Array[0..ObjMax] of GameObject;
		LaserX,Lasery:Byte;
		Time:Longint;
		GameOver,Quit:Boolean;
		
	function FreeObject(var ret:byte):Boolean;
	var
		i:Byte;
	label 
		Uit;
	Begin
		for i:=0 to ObjMax do
			if not Obj[i].Active then begin
				ret:=i;
				FreeObject:=true;
				goto Uit;
			end		;
		FreeObject:=false;
		Uit:
	end;
		
	{$I X.pas}
	{$I Bonus.pas}
	{$I Schoppen.pas}
	{$I Harten.pas}
	{$I Ruiten.pas}
	{$I Klaveren.pas}
	{$I Bouncer.pas}
	{$I HeenWeer.pas}
	{$I Triangle.pas}
		
	procedure TopBar;
	var
		i:Integer;
	begin
		ShowStars;
		GotoXY(1,1);
		TextColor(9);
		Write('Score: ');
		TextColor(14);
		Write(Score:9,'   ');
		TextColor(12);
		for i:=1 to Lives do
			Write(#220#219#220#32);
		GotoXY(1,2);
		TextColor(10);
		for i:=1 to 79 do
			Write(#205);
		{Write(GetTimer:5); {Debug}
		if (Score>=XLife) then begin
			if (Lives<5) then Lives:=Lives+1;
			XLife:=XLife+XLife;
			AudioResetQueue;
			for i:=100 to 200 do AudioQueue(i*5,2);			
		end;
	end;
	
	procedure Death;
	var 
		x,y:byte;
		i,j,k,c:byte;
	begin
		x:=ShipX;
		AudioResetQueue;
		for i:=100 downto 5 do AudioQueue(i*10,2);
		for j:=1 to 20 do begin
			for i:=x-1 to x+3 do begin
				y:=random(5)+15;
				for k:=15 to k do Begin
					GotoXY(i,y); 
					Write(' ')
				end;
				for k:=y to 25 do begin
					GotoXY(i,k);
					c:=random(5);
					case c of
						0: TextColor(1);
						1..2:TextColor(4);
						3:TextColor(12)
						else TextColor(14)
					end;
					Write(#178)
				end
			end
		end;
		ClrScr;
		for i:=0 to ObjMax do
			Obj[i].Active:=false
	end;
	
	procedure ManageObject(i:byte); 
	var 
		FoundX:Boolean;
		j:Integer;
	Begin with Obj[i] do begin
		case ObjType of
			1:ProcessX(i);
			2:ProcessBonus(i);
			3:ProcessSchoppen(i);
			4:ProcessHarten(i);
			5:ProcessRuiten(i);
			6:ProcessKlaveren(i);
			7:ProcessBouncer(i);
			8:ProcessHeenEnWeer(i);
			9:ProcessTriangleTorpedo(i);
		end;
		if (Killable) and (X=LaserX) and (Y=LaserY) then begin
			TextColor($14); GotoXY(X,Y); Write('*'); 
			LaserY:=0;
			Active:=false;
			Score:=Score+AwardScore;
			AudioResetQueue;
			for j:=1 to 4 do AudioQueue(Random(2000)+100,1); 
			if ObjType=1 then Begin
				repeat
					FoundX:=false;
					for j:=0 to ObjMax do
						FoundX:=(FoundX) or ((Obj[j].Active) and (Obj[j].ObjType=1));
					if not FoundX then begin Active:=true; Y:=1; X:=Random(70)+5 end
				until FoundX
			end
		end;
		if (Lethal) and (Y=25) and (X>=ShipX) and (X<=ShipX+3) then begin
			Death;
			if Lives=0 then
				GameOver:=true
			else begin
				NewX;
				Lives:=Lives-1
			end
		end
	end end;
	
	procedure ManageObjects;
	var
		i:byte;
		r:Integer;
	begin
		for i:=0 to ObjMax Do if Obj[i].Active Then ManageObject(i);
		if (Score>50) And (Random(1000)=1) then NewX;
		if (Random(2500)=1) then NewBonus;
		if (Random(1200)=1) and (Score> 120) then NewSchoppen;
		if (Random(1500)=1) and (Score> 240) then NewHarten;
		if (Random(2000)=1) and (Score> 350) then NewX;
		if (Random(1000)=1) and (Score> 200) then NewRuiten;
		if (Random(2100)=1) and (Score> 400) then NewKlaveren;
		if (Random(2300)=1) and (Score> 500) then NewBouncer;
		if (Random(1234)=1) and (Score> 600) then NewHeenEnWeer;
		if (Random(1000)=1) and (Score> 700) then NewX;
		if (Random(2000)=1) and (Score> 800) then NewTriangleTorpedo(Score>1000);
	end;
	
	procedure ShipManage;
		var 
			x:byte;
	begin
		x:=Mouse_X+1;
		if x< 3 then x:= 3;
		if x>76 then x:=76;
		if x<>ShipX then begin
			GotoXY(ShipX,25);
			Write('   ')
		end;
		ShipX:=x;
		GotoXY(ShipX,25);
		TextColor( 4); Write(#220);
		TextColor(12); Write(#219);
		TextColor( 4); Write(#220)
	end;
	
	procedure ShowLaser;
	begin
		if LaserY>2 then begin
			GotoXY(LaserX,LaserY); Write(' ');
			LaserY:=LaserY-1;
			TextColor(14);
			GotoXY(LaserX,LaserY); Write(#179)
		end else if Mouse_LeftHit Then begin
			LaserX:=ShipX+1;
			LaserY:=24;
			AudioPlay(750,5);
		end;
	end;
	
	procedure GameOverScreen;
	var 
		CD:Word;
		OT:Longint;
	begin
		AudioResetQueue;
		AudioQueue(261, 99); AudioQueue(0,1); { C  kwart }
		AudioQueue(261, 74); AudioQueue(0,1); { C  achtste + half }
		AudioQueue(261, 24); AudioQueue(0,1); { C  zestiende }
		AudioQueue(261, 99); AudioQueue(0,1); { C  kwart }
		AudioQueue(311, 74); AudioQueue(0,1); { D# achtste + half }
		AudioQueue(293, 24); AudioQueue(0,1); { D  zestiende }
		AudioQueue(293, 74); AudioQueue(0,1); { D  achtste + half }
		AudioQueue(261, 24); AudioQueue(0,1); { C  zestiende }
		AudioQueue(261, 74); AudioQueue(0,1); { C  achtste + half }
		AudioQueue(246, 24); AudioQueue(0,1); { B  Zestiende }
		AudioQueue(261,200); { C  half }
		CD := 400;
		OT := 0;
		repeat
			ShowStars;
			TopBar;
			GotoXY(36,10);
			TextColor(9);
			Write('Game Over');
			AudioCycle;
			if OT<>GetTimer then begin
				OT:=GetTimer;
				CD:=CD-1
			end
		until CD=0;
		clrscr;
	end;
	

	procedure DrawScreen;
	begin
		TopBar;
		ShipManage;
		ShowLaser;
	end;
	
	procedure Game_Init;
	begin
		Score:=0;
		Lives:=3;
		LaserY:=0;
		XLife:=1000;
		GameOver:=false;
		Quit:=false;
		NewX;
	end;
	
	procedure Game_Run;
	begin
		ClrScr;
		AudioResetQueue;
		NoSound;
		repeat
			Time:=GetTimer;
			GetMouse;
			DrawScreen;
			ManageObjects;
			AudioCycle;
			{$ifdef QuickEND}
			if (keypressed) and (readkey=#27) then Halt; 
			{$endif}
		until GameOver Or Quit;
		if GameOver then GameOverScreen;
	end;
	
end.