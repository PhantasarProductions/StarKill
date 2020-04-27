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
