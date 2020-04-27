unit Cursor;

interface
    Procedure CursorOff; 
    Procedure CursorOn; 

implementation

Procedure CursorOff; Assembler;
Asm
    mov ah,3
    mov bx,0
    int 10h
    or ch,20h
    mov ah,1
    mov bx,0
    int 10h
end;

Procedure CursorOn; Assembler;
Asm
  mov ah,3
  mov bx,0
  int 10h
  and ch,255-20h
  mov ah,1
  mov bx,0
  int 10h
end; 


end.
