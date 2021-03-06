;
; Modifier l'�paisseur et l'extr�mit� des lignes
; Assembleur              LIGNES.ASM
;

               .INCLUDE 'GEM_INEX.ASM'

gemdos         = 1
crawcin        = 7
cconws         = 9

               .TEXT 

main:          jsr        gem_init

               pea        clrscr        ;Effacer l'�cran
               move.w     #cconws,-(sp)
               trap       #gemdos
               addq.l     #6,sp

; Param�trage de l'�paisseur de la ligne

               move.w     #16,contrl    ;Opcode de fonction
               move.w     #1,contrl+2
               move.w     #1,contrl+4
               clr.w      contrl+6
               clr.w      contrl+8
               move.w     handle,contrl+12

               move.w     #33,ptsin     ;�paisseur de la ligne
               clr.w      ptsin+2

               jsr        vdi

               clr.w      d3            ;Variable pour la boucle

loop:          
; S�lection des styles de d�but et de fin de ligne

               move.w     #108,contrl   ;Opcode de fonction
               clr.w      contrl+2
               clr.w      contrl+4
               move.w     #2,contrl+6
               clr.w      contrl+8
               move.w     handle,contrl+12

               move.w     d3,intin      ;Origine de la ligne
               move.w     d3,intin+2    ;Extr�mit� de la ligne

               jsr        vdi

; trac� de la ligne

               move.w     #6,contrl     ;Opcode de fonction
               move.w     #2,contrl+2   ;Relier 2 points
               clr.w      contrl+4
               clr.w      contrl+6
               clr.w      contrl+8
               move.w     handle,contrl+12

               move.w     #20,ptsin     ;Coordonn�es
               move.w     d3,d4
               mulu.w     #70,d4
               addi.w     #20,d4
               move.w     d4,ptsin+2
               move.w     d4,ptsin+6
               move.w     #300,ptsin+4

               jsr        vdi

; Fin de la boucle:

               addq.w     #1,d3
               cmpi.w     #3,d3
               bne        loop

               move.w     #crawcin,-(sp)          ;Attendre appui touche
               trap       #gemdos
               addq.l     #2,sp

               jsr        gem_exit

               clr.w      -(sp)
               trap       #gemdos


               .DATA 

clrscr:        .DC.b 27,'E',0

               .END 



