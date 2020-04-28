{ --- START LICENSE BLOCK ---
Star Kill
Hall Of Fame



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

Version: 20.04.29
--- END LICENSE BLOCK --- }
Unit HOF;

Interface

	uses
		Foutje,
		Stars,
		Mouse,
		DOS,
		Crt;

	Procedure LoadHOF;
	Procedure SubmitScore(Score:Longint);
	Procedure ViewHOF;
	
Implementation

	Type
		THOF = Record
			Name:string[20];
			Score:LongInt;
			D,M,Y,DOW:Word;
		end;
		
		HOFBase = Array[1..20] of THOF;
		
		HOFFile = File Of HOFBase;
		
	var
		HOFLoaded:Boolean;
		HOFData:HofBase;
		
	Procedure CreateHOF;
	var
		i:Byte;
	Begin
		for i:=1 to 20 do with HOFData[i] do Begin
			Name:='<Nobody>';
			Score:=21 - i;
			D:=0; M:=0; Y:=0
		end
	end;
		
	Procedure LoadHOF;
	var
		Bt:HOFFile;
		ecatch:integer;

	Begin
		assign(BT,'STARKILL.HOF');
		{$I-}
		reset(bt);
		{$I+}
		ECatch:=IOResult;
		Assert((ecatch=2) or (ecatch=0),'Error loading Hall of Fame');
		if ECatch=2 then 
			CreateHOF
		Else Begin
			{$I-}
			Read(Bt,HOFData);
			{$I+}
			Assert(IOResult=0,'Hall of Fame File may be corrupted! You may want to try to delete STARKILL.HOF');
			Close(Bt)
		end
	end;
	
	function LC(C:Char):Char;
	var 
		m:Byte;
	Begin
		m:=ord('a')-ord('A');
		if (C>='A') and (C<='Z') then
			LC:=Chr(ord(C)+m)
		else
			LC:=C;
	end;
	
	Procedure SubmitScore;
	var
		Rank,i:Byte;
		Ch:Char;
		EName:String;
		BT:HofFile;
	Begin
		LoadHOF;
		While KeyPressed do Ch:=ReadKey;
		Rank:=0;
		for i:=20 downto 1 do 
			if HOFData[i].Score<Score then Rank:=i;
		if Rank<>0 then begin
			{Enter high score}
			ClrScr;
			EName:='';
			repeat
				ShowStars;
				GotoXY(1,1);
				TextColor(14); Writeln('With a score of ',Score,' points, you made rank #',rank);
				               WriteLn('in the STAR KILL Hall of Fame!');
				WriteLn;
				TextColor(12); Write('Please enter your name: ');
				TextColor(9); Write(EName); TextColor($1f); Write(#219);
				if KeyPressed then begin
					Ch:=ReadKey;
					case Ch of
						' ':      if Length(EName)<20 then EName := EName + Ch;
						'0'..'9': if Length(EName)<20 then EName := EName + Ch;
						'a'..'z': if Length(EName)<20 then Begin
									if (EName='') or (EName[Length(EName)]=' ') then EName := EName + upcase(Ch) else EName := EName + ch;
								  end;
						'A'..'Z': if Length(EName)<20 then Begin
									if (EName='') or (EName[Length(EName)]=' ') then EName := EName + Ch else EName := EName + LC(ch);								  
								  end;
						#8: if EName<>'' then EName[0] := chr(ord(EName[0])-1);
					end
				end
			until Ch=#13;
			for i:=19 DownTo Rank do
				HOFData[i+1]:=HOFData[i];
			HOFData[Rank].Score:=Score;
			HOFDAta[Rank].Name:=EName;
			With HofData[Rank] Do GetDate(Y,M,D,DOW);
			Assign(BT,'STARKILL.HOF');
			ReWrite(BT);
			Write(BT,HofData);
			Close(BT);
		end
	end;
	
	Procedure ViewHOF;
	var 
		i:Byte;
	Begin
		LoadHOF;
		ClrScr;
		NoSound;
		Repeat
			GetMouse;
			TextColor(14); GOTOXY(1,1); Write('Hall of fame!');
			for i:=1 to 20 do with HOFData[i] do begin
				GotoXY(1,i+2);
				TextColor( 9); Write(i:2,'. ');
				TextColor(10); Write(Name);
				GotoXY(30,i+2);
				TextColor(11); Write(Score:9,'  ');
				TextColor(12);
				if M<>0 then Begin
					Case DOW Of
						0: Write('Sun ');
						1: Write('Mon ');
						2: Write('Tue ');
						3: Write('Wed ');
						4: Write('Thu ');
						5: Write('Fri ');
						6: Write('Sat ');
					end;
					Case M of
						 1: Write('Jan ');
						 2: Write('Feb ');
						 3: Write('Mar ');
						 4: Write('Apr ');
						 5: Write('May ');
						 6: Write('Jun ');
						 7: Write('Jul ');
						 8: Write('Aug ');
						 9: Write('Sep ');
						10: Write('Oct ');
						11: Write('Nov ');
						12: Write('Dec ');
					end;
					Write(D);
					case D of
						1,21,31: Write('st');
						2,22: Write('nd');
						3,23: Write('rd');
						else Write('th');
					end;
					Write(Y:5)
				end
			end;
		until Mouse_LeftHit;
		ClrScr;
		while keypressed do Write(ReadKey);
	end;


Begin
	HOFLoaded := false;
end.