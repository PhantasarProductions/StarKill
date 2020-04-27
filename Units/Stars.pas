{ --- START LICENSE BLOCK ---
Star Kill
Stars will move over the screen



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
Unit Stars;

{$Undef DEBUGSTAR}

Interface

    Uses
        Crt;

    type TStar = RECORD 
        {oldx,oldy,} x,y,color:byte;
        truey:real;
        speed:real;
        active:Boolean;
    end;

    var
        Star:array[0..10] of TStar;

    procedure InitStars;
    procedure ShowStars;

Implementation 

    Procedure InitStars;
    var 
        i:byte;
    Begin 
        Randomize;
        for i:=0 to 9 do 
        begin
          {star[i].oldx=0;
          star[i].oldy=0;}
          star[i].x:=0;
          star[i].y:=0;
          star[i].Active:=false
        end
    End;

    Procedure NewStar(idx:Byte);
    var
        r:real;
        i:byte;
    begin
        if not star[idx].Active then begin        
            r := (Random(150)+1) / 100;
            star[idx].speed := r;
        {   star[idx].oldx = 0;
            star[idx].oldy = 0; }
            star[idx].truey:=1;
            star[idx].y:=0;
            star[idx].x:=random(77)+1;
            i := random(3);
            case i of
                0: star[idx].color := 8;
                1: star[idx].color := 7;
                2: star[idx].color := 15
            end;
            star[idx].active:=true
        end
    end;

    Procedure DoStar(idx:byte);
    begin
        GotoXY(star[idx].x,star[idx].y);
        Write(#32);       
        star[idx].truey := star[idx].truey + star[idx].speed;
        star[idx].y := Round(Star[idx].truey);
        if star[idx].y>=25 then 
            star[idx].active:=false
        else begin
            GotoXY(star[idx].x,star[idx].y);
            TextColor(star[idx].color);
            Write(#249)
        end;
        TextColor(7)
    end;


    Procedure ShowStars;
    Var
        i:Byte;
    begin
        {$ifdef DEBUGSTAR}
        TextColor(14);
        GotoXY(1,1);
        write('#1',' >> ','Active: ',star[1].active,' (',star[1].x,',',star[1].y,')  ');
        {$ENDIF}
        i := random(10);
        if not star[i].active then NewStar(i);
        for i:=0 to 9 do { }
        {for i:=1 to 1 do { }
            if star[i].active then DoStar(i)        
    end;

end.