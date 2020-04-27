Unit Credits;

Interface
	Uses 
		Crt,
		QJCR6,
		Stars,
		Mouse,
		Foutje;

	Procedure Run_Credits;

Implementation

	Type CreditLine = Record
		Len,X:Byte;
		Line:Packed Array[0..80] of Char;
		FG,BG:Byte;
	End;
	
	Var 
		CLines:Array[1..25] of CreditLine;
		
	function H2D(H:Char):Byte; 
		Begin
		{Not the cleanest but at least the easiest method}
		case H of
			'0':H2D:= 0;
			'1':H2D:= 1;
			'2':H2D:= 2;
			'3':H2D:= 3;
			'4':H2D:= 4;
			'5':H2D:= 5;
			'6':H2D:= 6;
			'7':H2D:= 7;
			'8':H2D:= 8;
			'9':H2D:= 9;
			'A':H2D:=10;
			'B':H2D:=11;
			'C':H2D:=12;
			'D':H2D:=13;
			'E':H2D:=14;
			'F':H2D:=15;
			else Crash('FATAL ERROR! H2D Decorde error');
		end
	end;
	
	procedure GetLine(var BT:tJCRFile; var ret:CreditLine);
	var 
		Ch:Char;		
	Begin 		
		With ret Do Begin
			FG:=H2D(JCR_GetChar(BT));
			BG:=H2D(JCR_GetChar(BT));
			Ch:=JCR_GetChar(BT);
			Assert(ch=' ','Space expected after color read-out');
			Len:=0; 
			While Ch<>#10 Do Begin
				Ch:=JCR_GetChar(BT);
				Line[Len]:=Ch; Len:=Len+1;
				Assert(Len<81,'Credits line maximum exceeded!');
			End;
			X:=40-(Len Div 2);
		End;		
	end;
	
	
	Procedure Load_Credits;
	var
		i:Byte;
		bt:tJCRFile;
	Begin
		For i:=1 to 25 do CLines[i].Len:=0;
		JCR_Open(bt,'Data.JCR','Credits');
		for i:=1 to 25 do begin
			{WriteLn('Credits: ',i:2); { }
			GetLine(bt,Clines[i]);
		end;
		JCR_Close(BT);
	End;
	
	Procedure Run_Credits;
	var
		LX,LY:Byte;
	Begin
		ClrScr;
		repeat
			GetMouse;
			ShowStars;
			For LY:=1 to 24 do with CLines[LY] do for LX:=0 to Len do Begin
				TextColor(FG);
				TextBackground(BG);
				GotoXY(LX+X,LY);
				Write(Line[LX])
			end;
		until Mouse_LeftHit or Mouse_RightHit;
		While KeyPressed do Write(ReadKey);
		ClrScr;
	End;

Begin
	Load_Credits;
End.
