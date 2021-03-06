MODULE TestMem; (*$E MOS *)

FROM SYSTEM IMPORT ADDRESS, ADR, TSIZE, BYTE, WORD, LONGWORD, VAL;

FROM Terminal IMPORT WriteLn, WriteString, Read;

FROM Storage IMPORT MemAvail, AllAvail, ALLOCATE;

FROM StrConv IMPORT CardToStr;

PROCEDURE WriteCard (n: LONGCARD; s: CARDINAL);
  BEGIN
    WriteString (CardToStr (n,s))
  END WriteCard;
  
VAR ch:CHAR; p: ADDRESS; l,m: LONGCARD;

BEGIN
  WriteLn;
  WriteLn;
  WriteString ('Largest free space: ');
  WriteCard (MemAvail (),0);
  WriteLn;
  WriteString ('Full free space   : ');
  WriteCard (AllAvail (),0);
  WriteLn;
  WriteLn;
  WriteString ('Allocating...');
  WriteLn;
  l:= 0;
  m:= 0;
  WHILE AllAvail () > 100L DO
    m:= MemAvail ();
    ALLOCATE (p,m);
    IF p = NIL THEN
      WriteLn;
      WriteString ("Can't allocate ");
      WriteCard (m,0);
      WriteString (' Bytes !');
      Read (ch);
      RETURN
    END;
    l:= l + m;
  END;
  WriteLn;
  WriteString ("Have been allocated ");
  WriteCard (l,0);
  WriteString (' Bytes.');
  Read (ch)
END TestMem.
 
(* $FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$00000173$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$00000429$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C$FFF91E1C�$0000001BT.......T.......T.......T.......T.......T.......T.......T.......T.......T.......$00000413$00000063$00000094$0000006B$00000083$FFF66A49$00000163$0000014B$000003D9$000003E2$000003D9$0000001B$000003D2$0000033E$0000041A$000003F6���*)
