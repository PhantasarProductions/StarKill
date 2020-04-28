{ --- START LICENSE BLOCK ---
Units/Audio.pas
Audio
version: 20.04.28
Copyright (C) 2020 Jeroen P. Broks
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

Unit Audio;

Interface

	Uses
		Crt,
		Timer;

	var
		UseAudio:Boolean;
		
	Procedure AudioPlay ( Frequency,  Time :Word );
	Procedure AudioQueue(AFrequency, ATime :Word );
	Procedure AudioResetQueue;
	Procedure AudioCycle;
	Function AudioOn:String;

Implementation

	type 
		TAudioQueue = Record
			Frequency, Time:Word
		end;
		
	Const
		QueueMax = 35;
		
	var 
		CurPlaying:Word;
		CurFreq:Word;
		Queue:Array[1..QueueMax] of TAudioQueue;
		Queued:Word;
		OldCheck:LongInt;
		
	Procedure AudioPlay;
	Begin
		if UseAudio then begin
			if CurFreq<>Frequency then
				if Frequency=0 then NOSound else Sound(Frequency);
			CurFreq:=Frequency;
			CurPlaying:=Time
		end
	end;
	
	Procedure AudioQueue;
	Begin
		if (Queued=0) and (CurPlaying=0) then
			AudioPlay(AFrequency,ATime)
		else if Queued<QueueMax then begin
			Queued:=Queued+1;
			with Queue[Queued] do Begin
				Frequency:=AFrequency;
				Time:=ATime;
			end;
		end
	end;
	
	Procedure AudioResetQueue; Begin Queued:=0 End;
	
	Procedure AudioCycle;
	var i:1..QueueMax;
	Begin
		if (OldCheck<>GetTimer) and (CurPlaying>0) then Begin
			if CurPlaying>0 then CurPlaying:=CurPlaying-1;
			if CurPlaying=0 then Begin
				if Queued=0 then Begin
					CurFreq:=0;
					NoSound
				end Else Begin
					AudioPlay(Queue[1].Frequency,Queue[1].Time);
					for i:=1 to Queued-1 do Queue[i]:=Queue[i+1];
					Queued:=Queued-1
				end;
			OldCheck:=GetTimer;
			end;
		end;
	end;
	
	Function AudioOn:String;
	Begin
		if UseAudio then
			AudioOn:='ON '
		else
			AudioOn:='OFF'
	end;

Begin
	UseAudio:=true;
	CurPlaying:=0;
	Queued:=0;
	CurFreq:=0;
	OldCheck:=GetTimer;
end.