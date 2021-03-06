DEFINITION MODULE VDIEscapes;


(*      Megamax-Modula II GEM Library (Escape-Funkionen)
 *
 *      geschrieben von Manuel Chakravarty
 *
 *      Version 2.2     V#0023      Erstellt M�rz 87 - Januar 88
 *)
 
(*      In den ROM's befinden sich nur die ersten 19 VDI-Escape-Routine
 *      (bis 'RemoveCursor). Mit Hilfe des GDOS sind aber alle in diesem
 *      Modul aufgef�hrten Prozeduren verwendbar. Eine Ausnahme bilden
 *      'SetLineOffset' und 'InitSystemFont', da diese beiden Routine
 *      schon im ROM vorhanden sind, sie werden in der Regel aber nur
 *      systemintern vom GEM verwendet.
 *
 *      HINWEIS: In der aktuellen Modulversion sind noch nicht alle GDOS
 *               Routinen implementiert. Die nicht implementierten sind
 *               gekennzeichnet.
 *)
 
 
FROM    SYSTEM   IMPORT ADDRESS;
 
FROM    GrafBase IMPORT Rectangle, Point;

FROM    GEMEnv   IMPORT DeviceHandle;


PROCEDURE GetCharCells (    handle       : DeviceHandle;
                        VAR rows, columns: CARDINAL);

        (*  Erfragt die Anzahl der Zeilen und Spalten des Textbildschirms.
         *  Ist ein Wert gleich 'MaxCard', so kann der Cursor in dieser
         *  Richtung nicht positsioniert werden.
         *)

PROCEDURE ExitCursorMode (handle: DeviceHandle);

        (*  Es wird von alphanumerischer auf grafische Ausgabe umgeschaltet.
         *)

PROCEDURE EnterCursorMode (handle: DeviceHandle);
        
        (*  Hiermit schaltet man von grafischer auf alphanumerische Ausgabe.
         *)
         
         
(*  Die folgenden vier Routinen bewegen den Cursor um je eine Zeichen-
 *  position. St��t er dabei an einem Bildschirmrand an, so bleibt er
 *  dort stehen und alle weiteren Versuche ihn in diese Richtung zu be-
 *  wegen werden ignoriert.
 *)

PROCEDURE CursorUp (handle: DeviceHandle);
        
        (*  Bewegt den Cursor um eine Zeile nach oben.
         *)

PROCEDURE CursorDown (handle: DeviceHandle);

        (*  Bewegt den Cursor um eine Zeile nach unten.
         *)

PROCEDURE CursorRight (handle: DeviceHandle);

        (*  Bewegt den Cursor um eine Spalte nach rechts.
         *)

PROCEDURE CursorLeft (handle: DeviceHandle);

        (*  Bewegt den Cursor um eine Spalte nach links.
         *)


PROCEDURE CursorHome (handle: DeviceHandle);

        (*  Der Textcursor wird in die Ecke links oben positioniert.
         *)

PROCEDURE EraseToEndOfScreen (handle: DeviceHandle);

        (*  Diese Routine l�scht den Textbildschirm bei der Cursorposition
         *  beginnend bis zur rechten, unteren Ecke.
         *)

PROCEDURE EraseToEndOfLine (handle: DeviceHandle);
 
        (*  Hiermit wird die Zeile, in der der Cursor steht von der Cursor-
         *  position bis zum Zeilenende gel�scht.
         *)

PROCEDURE LocateCursor (handle: DeviceHandle; column, row: CARDINAL);

        (*  Der Textcursor wird in der Spalte 'column' und der Zeile 'row'
         *  positioniert.
         *)

PROCEDURE CursorText (handle: DeviceHandle; REF str: ARRAY OF CHAR);

        (*  Ab der aktuellen Cursorposition wird der in 'str' ange-
         *  gebene Text ausgegeben.
         *)

PROCEDURE ReverseVideoOn (handle: DeviceHandle);

        (*  Nach diesem Aufruf werden alle auszugebenden Zeichen invers
         *  dargestellt.
         *)

PROCEDURE ReverseVideoOff (handle: DeviceHandle);

        (*  Die Zeichen, die nach Aufruf dieser Routine ausgegeben werden,
         *  werden normal dargestellt.
         *)

PROCEDURE GetCursorLocation (    handle     : DeviceHandle;
                             VAR column, row: CARDINAL);

        (*  Spalte 'column' und Zeile 'row', in der sich der Cursor augen-
         *  blicklich befindet, wird ermittelt.
         *)

PROCEDURE TabletStatus (handle: DeviceHandle): BOOLEAN;

        (*  Erfragt, ob eine Maus, ein Joystick, ein Grafiktablett oder
         *  ein �hnliches Ger�t angeschlossen ist.
         *)

PROCEDURE HardCopy (handle: DeviceHandle);

        (*  Gibt eine Bildschirmhardcopy auf den Drucker aus.
         *  Entspricht <ALT>+<Help>
         *)

PROCEDURE DisplayCursor (handle     : DeviceHandle;
                         row, column: CARDINAL);

        (*  Stellt den Grafikcursor auf dem Bildschirm dar. Beim Atari
         *  werden die Parameter 'row' und 'column' ignoriert.
         *  Entspricht 'VDInputs.ShowCursor (TRUE)'
         *)

PROCEDURE RemoveCursor (handle: DeviceHandle);
        
        (*  Der Grafikcursor wird wieder vom Bildschirm entfernt.
         *  Entspricht 'VDInputs.HideCursor'
         *)
         

(*      Folgende Routinen sind nur bei geladenem GDOS verf�gbar.
 *)
 
PROCEDURE FormAdvance (handle: DeviceHandle);

        (*  Ist nur wirkungsvoll, falls das angesprochene Ger�t ein Drucker
         *  ist. In diesem Fall wird ein Seitenvorschub erzeugt.
         *  Der Datenpuffer wird nicht gel�scht.
         *)

PROCEDURE OutputWindow (handle: DeviceHandle; frame: Rectangle);

        (*  Die zu diesem Zeitpunkt f�r 'handle' gepufferten Ausgabebefehle
         *  werden ausgef�hrt. Dabei ist die Ausgabe auf den Rechteckbereich
         *  'frame' beschr�nkt.
         *  Auch hier mu� 'handle' die Ger�tekennung eines Druckers sein.
         *)
         
PROCEDURE ClearDisplayList (handle: DeviceHandle);

        (*  Der Druckerpuffer des durch 'handle' beschriebenen Druckers
         *  wird gel�scht.
         *)
         
         
TYPE    AspectRatio     = (noAspect, pixelAspect, sideAspect);
        ScaleMode       = (sameScl, seperateScl);
         
PROCEDURE OutputBitImage (    handle : DeviceHandle;
                          REF fname  : ARRAY OF CHAR;
                              aspect : AspectRatio;
                              scaling: ScaleMode;
                              numPts : CARDINAL;
                              frame  : Rectangle);

        (*  Ein File, das ein Bitmuster enth�lt wird auf den Drucker ausge-
         *  geben.
         *
         *  'handle'    -- Die Ger�tekennung
         *  'fname'     -- Name des auszudruckenden Files
         *
         *  'aspect' nimmt folgende Werte an:
         *
         *    'noAspect'    -- kein Aspect Ratio
         *    'pixelAspect' -- es wird darauf geachtet, da� ein Pixel gleiche
         *                     Breite und H�he hat
         *    'sideRatio'   -- es wird darauf geachtet, da� das Bild die
         *                     Kantenl�ngen des Ausgabeger�tes voll ausnutzt
         *
         *  F�r 'scaling' gilt:
         *
         *    'sameScl'     -- Einheitliche Ma�stabs�nderung
         *    'seperateScl' -- die horizontale Ma�stabsver�nderung ist nicht
         *                     an die vertikale gebunden und umgekehrt
         *
         *  'numPts' bestimmt wieviele Punkte von 'frame' genutzt werden:
         *
         *    '0' -- 'frame' wird ignoriert und das die Ausma�e des auszu-
         *           gebenden Bereichs bestimmende Rechteck wird aus dem
         *           File ausgelesen
         *    '1' -- Die Position von 'frame' bestimmt die Position der Ausgabe
         *    '2' -- 'frame' bestimmt sowohl die Position, als auch die H�he
         *           und Breite der Ausgabe
         *
         *  ACHTUNG: In dieser Version nicht implementiert.
         *)
         
PROCEDURE SelectPalette (handle: DeviceHandle; palette: CARDINAL);

        (*  Hiermit wird eine Farbpalette gesetzt. 'palette' kann folgende
         *  Werte annehmen:
         *
         *    '0' -- Rot, Gr�n, Braun
         *    '1' -- Cyan, Magenta, Wei�
         *
         *  Ist nach Aufruf dieser Funktion 'GemError () = TRUE', so konnte
         *  die gew�nschte Palette nicht gesetzt werden. Mit 'ErrorNumber'
         *  kann die ersatzweise gesetzte Palette erfragt werden.
         *
         *  Hinweis: Diese Funktion ist normalerweise nur f�r einen IBM-
         *           Farbmonitor in mittlerer Aufl�sung bestimmt.
         *
         *  ACHTUNG: In dieser Version nicht implementiert.
         *)
         
PROCEDURE GetFilmTypes (    handle: DeviceHandle;
                        VAR films : ARRAY OF CHAR);

        (*  'handle' mu� die Kennung eines Polaroid-Bild-Recorders sein.
         *  Die Routine liefert in 'films' die Information zu 5 Filmen
         *  (Film-Typ, Hersteller, ASA-Wert). Dabei sind f�r jeden Film
         *  25 Zeichen reserviert. Werden diese nicht voll ausgenutzt, so
         *  werden sie mit Leerzeichen aufgef�llt.
         *  Wird ein Array �bergeben, das weniger als 5 * 25 = 125 Zeichen
         *  fa�t, so wird ein Laufzeitfehler ausgel�st.
         *
         *  ACHTUNG: In dieser Version nicht implementiert.
         *)
         
TYPE    IndexArray      = ARRAY [0..7], [0..1] OF CHAR;
         
PROCEDURE GetDriverState (    handle    : DeviceHandle;
                          VAR port, film: CARDINAL;
                          VAR lightness : INTEGER;
                          VAR interlace : BOOLEAN;
                          VAR planes    : CARDINAL;
                          VAR indexes   : IndexArray);
                          
        (*  Auch diese Routine ist f�r eine Polaroid-Bild-Recorder gedacht.
         *  Sie erfragt den Ger�testatus. Dabei haben die gelieferten Para-
         *  meter folgende Bedeutung:
         *
         *  'port'      -- Nummer des �bertragungsports (bei 0 beginnend)
         *  'film'      -- Filmnummer (0 bis 4)
         *  'lightness' -- Belichtung (-3 bis 3)
         *  'interlace' -- '= TRUE' ~ interlaced Bild
         *  'planes'    -- Anzahl der Farbebene (1 bis 4)
         *  'indexes'   -- Zwei-Zeichen-Code f�r den Farbindex
         *
         *  ACHTUNG: In dieser Version nicht implementiert.
         *)
         
PROCEDURE SetDriverState (handle    : DeviceHandle;
                          port, film: CARDINAL;
                          lightness : INTEGER;
                          interlace : BOOLEAN;
                          planes    : CARDINAL;
                          indexes   : IndexArray);
                          
        (*  Setzt die mit 'GetDriverState' erfragten Parameter.
         *
         *  ACHTUNG: In dieser Version nicht implementiert.
         *)
         
PROCEDURE SaveDriverState (handle: DeviceHandle);

        (*  Speichert die mit 'SetDriverState' gesetzten Parameter auf
         *  Diskette.
         *
         *  ACHTUNG: In dieser Version nicht implementiert.
         *)
         
PROCEDURE SuppressPaletteMsg (handle: DeviceHandle);

        (*  Die Fehlermeldungen eines Polaroid-Bild-Recorder-Ger�tetreibers
         *  werden unterdr�ckt.
         *
         *  ACHTUNG: In dieser Version nicht implementiert.
         *)
         
CONST   noErrorPE      = 0;  (* Kein Fehler *)
        shutterOpenPE  = 1;  (* Verschlu� f�r Belichtung ge�ffnet *)
        noPortPE       = 2;  (* Es ist kein Port festgelegt *)
        pltNotAvailPE  = 3;  (* Palette am Port nicht verf�gbar *)
        interuptPE     = 4;  (* Die Viedeoverbindung ist unterbrochen *)
        noMemPE        = 5;  (* Kein Speicher vom Betriebssystem erh�ltlich*)
        noBufferMemPE  = 6;  (* Speicher im Puffer reicht nicht aus *)
        memNotFreePE   = 7;  (* Speicher ist nicht frei *)
        noFilePE       = 8;  (* Ger�tetreiber-File wirde nicht gefunden *)
        wrongTypePE    = 9;  (* File besitzt den falschen Typ *)
        filmReadyPE    = 10; (* Der Film ist entwicklungsfertig *)
        
         
PROCEDURE PaletteError (handle: DeviceHandle): CARDINAL;

        (*  Hiermit kann man den Status bzw. eventuelle Fehler bei den
         *  Operationen mit einem Polaroid-Bild-Recorder erfragen.
         *
         *  ACHTUNG: In dieser Version nicht implementiert.
         *)

PROCEDURE MetafileExtents (handle: DeviceHandle; min, max: Point);

        (*  Die Gr��eninformationen im Metafile-Vorspann werden erneuert.
         *  Dabei geben 'min' bzw. 'max' den x/y-Wert des minimalen bzw.
         *  maximalen Rechtecks an.
         *)

PROCEDURE WriteToMetafile (    handle  : DeviceHandle;
                               numIntin: CARDINAL;
                           REF intin   : ARRAY OF INTEGER;
                               numPtsin: CARDINAL;
                           REF ptsin   : ARRAY OF INTEGER);
                           
        
        (*  Mit dieser Prozedur kann man benutzerdefinierte Kommandos in
         *  ein Metafile schreiben.
         *
         *  'intin[0]'  -- Hier wird der vom Benutzer definierte Sub-
         *                 Opcode eingetragen, der das Kommando identi-
         *                 fiziert (sollte gr��er als 100 sein).
         *  'intin[1..]'-- In den �brigen Elementen von 'intin' sollten
         *                 die vom Benutzer f�r dieses Kommando bestimmten
         *                 Parameter �bergeben werden.
         *  'ptsin[0..]'-- Ebenso hier.
         *)



PROCEDURE SetVDIFileName (handle: DeviceHandle; REF fname: ARRAY OF CHAR);

        (*  Der Name eines Metafiles wird von dem Standardnamen 'GEMFILE.GEM'
         *  in 'fname' umbenannte. Optional kann auch ein Pfad mit angegeben
         *  werden. Dieser Aufruf mu� dem entsprechenden 'OpenDevice'-Aufruf
         *  direkt folgen, sonst wird er ignoriert.
         *)
         
         
(*      Die folgenden beiden Funktionen sind im ROM vorhanden, es ist also
 *      kein GDOS notwendig.
 *
 *      ACHTUNG: Die beiden Routine sind von Atari nicht offiziell doku-
 *               mentiert und sollten daher nur in Ausnahmef�llen benutzt
 *               werden.
 *)
 
PROCEDURE SetLineOffset (handle: DeviceHandle; offset: INTEGER);

        (*  Bestimmt den Offset zum Anfang des logischen Bildschirms (in
         *  Zeilen). Standardwert ist 0.
         *)
         
PROCEDURE InitSystemFont (handle: DeviceHandle; fontHeader: ADDRESS);

        (*  Der Zeichensatz wird als Systemzeichensatz installiert.
         *  Dabei zeigt 'fontHeader' auf den Begin des Font-Headers
         *  (siehe 'LineA').
         *
         *  Hinweis: Die Breite der Zeichenzelle jedes Characters aus dem
         *           Zeichensatz mu� 8 Pixel betragen.
         *)
         
         
END VDIEscapes.