DEFINITION MODULE Storage;

FROM SYSTEM IMPORT ADDRESS, LONGWORD;

(*
 * Allgemein verwendbare Funktionen zur dynamischen Speicherverwaltung.
 * Dieses Modul importiert 'StorBase', um damit Speicher vom GEMDOS
 * anzufordern. Es fordert dazu immer gro�e Bereiche an (Gr��e ist in
 * MOSGlobals.MaxBlSize bestimmbar), die dann ggf. von diesem Modul
 * wiederum in kleinere Portionen aufgeteilt wird. Das hat den Vorteil,
 * da� entgegen der GEMDOS-Verwaltung weniger Speicher f�r die Verwal-
 * tung pro Block verbraucht wird (10 statt 16 Bytes) und die Funktionen
 * auch schneller arbeiten. Au�erdem ist die GEMDOS-Verwaltung selbst auf
 * eine feste, vom freien Speicher unabh�ngige Anzahl von Allokationen
 * beschr�nkt (ca. 20-80). 'Storage' dagegen nutzt den gesamten freien
 * Speicher aus.
 *
 * Bei Erfolg einer Alloc-Funktion liefert 'addr' immer einen Zeiger auf
 * eine gerade Adresse, bei Mi�erfolg ist 'addr'=NIL.
 *
 * Es ist auch m�glich, ungerade Mengen Bytes anzufordern oder freizugeben.
 *)

PROCEDURE ALLOCATE ( VAR addr: ADDRESS; size: LONGCARD );

PROCEDURE DEALLOCATE ( VAR addr: ADDRESS; size: LONGCARD );
  (* Verkleinert Speicherblock um 'size'.                      *)
  (* Ist 'size'=0, wird der gesamte Speicherblock freigegeben. *)

PROCEDURE Available ( size: LONGCARD ): BOOLEAN;
  (* Liefert TRUE, wenn die gefragte Menge Bytes noch frei ist. *)

PROCEDURE MemSize ( addr: ADDRESS ): LONGCARD;
  (* Liefert L�nge des Speicherblocks. Liefert 0L, wenn Block unbelegt ist. *)

PROCEDURE MemAvail (): LONGCARD;
  (* Liefert Anzahl in Bytes des im Augenblick gr��ten belegbaren
   * Speicherbereichs. *)

PROCEDURE AllAvail (): LONGCARD;
  (* Liefert gesamten im Augenblick freien Speicherplatz *)


PROCEDURE TrailAvail (ad: ADDRESS): LONGCARD;
  (*
   * Liefert den noch evtl. freien Bereich direkt hinter dem angegebenen
   * Block. Ist dieser gr��er als Null, kann der Block davor mittels
   * 'Enlarge' (s.u.) um diesen Betrag vergr��ert werden.
   *)

PROCEDURE Enlarge ( VAR addr: ADDRESS; add: LONGCARD; VAR ok: BOOLEAN );
  (*
   * Vergr��ert den Block um 'add' Bytes, falls direkt dahinter entsprechend
   * viel Speicher frei ist.
   * 'ok' liefert entsprechend 'TRUE', wenn dies m�glich war.
   *)

PROCEDURE SysAlloc ( VAR addr: ADDRESS; size: LONGCARD );
  (*
   * Wie ALLOCATE, jedoch wird der angeforderte Speicherbereich nicht bei
   * Beendigung des Programms, das aktiv war, w�hrend der Speicher ange-
   * fordert wurde, freigegeben, sondern erst, wenn 'Storage' beendet
   * wird, also wenn z.B. die Shell verlassen wird.
   *)

PROCEDURE Inconsistent (): BOOLEAN;
  (*
   * Liefert TRUE, wenn die Speicherverwaltung inkonsistent (fehlerhaft)
   * geworden ist. In diesem Fall kann es bei weiteren Storage-Zugriffen
   * zu fatalen Fehler kommen. Deshalb ist dann so bald wie m�glich
   * das System neu zu starten.
   *)

PROCEDURE Keep ( addr: ADDRESS );
  (*
   * Systemfunktion!
   *)

PROCEDURE More ( id: INTEGER; p: ADDRESS );
  (* Systemfunktion! *)

END Storage.
