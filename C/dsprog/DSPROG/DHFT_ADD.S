;		long dhft_add(int sin, int cos, long c, long b, long a);
;		
;		dfeld[n_cnt + i_cnt] = par_c
;			 									 + par_b / 30000 * cos
;			 									 + par_b % 30000) * cos / 30000
;												 + par_a / 30000 * sin
;												 + (par_a % 30000) * sin / 30000;

export  dhft_add, dhft_pow

PAR_A	equ 12
PAR_B equ 8
PAR_C equ D2
COS		equ	D1
SIN		equ D0

; **********************************
; * Special case of a zero cosinus *
; **********************************
dhft_cos_0:
					tst			SIN
					blt.s		dhft_msin
					
					move.l	PAR_A-4(SP),D0
					add.l		PAR_C,D0
					rts

dhft_msin:
					move.l	PAR_A-4(SP),D0
					sub.l		D0,PAR_C
					move.l	PAR_C,D0
					rts
					
; ********************************
; * Special case of a zero sinus *
; ********************************
dhft_sin_0:
					tst			COS
					blt.s		dhft_mcos
					
					move.l	PAR_B-4(SP),D0
					add.l		PAR_C,D0
					rts

dhft_mcos:
					move.l	PAR_B-4(SP),D0
					sub.l		D0,PAR_C
					move.l	PAR_C,D0
					rts

; ************************
; * DHFT-Matrix addition *
; ************************
dhft_add: tst			COS
				  beq.s		dhft_cos_0
				  tst			SIN
				  beq.s		dhft_sin_0

         	link	A6,#0

					movem.l D3/D4,-(SP)
					
					move.l PAR_B(A6),D3
;					divs	 #30000,D3
;					move.w D3,D4
;					swap	 D3

					move.l D3,D4
					lsl			#1,D4							; Methode 3
					swap		D4								;    "
					roxl		#1,D4							;    "
					andi	 #32767,D3
					
					muls	 COS,D3
;					divs	 #30000,D3
					lsl			#1,D3							; Methode 3
					swap		D3								;    "
					roxl		#1,D3							;    "
					ext.l	 D3
					add.l	 D3,PAR_C

					muls	 COS,D4
					add.l	 D4,PAR_C
					
					move.l PAR_A(A6),D3
;					divs	 #30000,D3
;					move   D3,D4
;					swap	 D3

					move.l D3,D4
					lsl			#1,D4							; Methode 3
					swap		D4								;    "
					roxl		#1,D4							;    "
					andi   #32767,D3
					
					muls	 SIN,D3
;					divs	 #30000,D3
					lsl			#1,D3							; Methode 3
					swap		D3								;    "
					roxl		#1,D3							;    "
					ext.l	 D3
					add.l	 D3,PAR_C
					
					muls	 SIN,D4
					add.l	 D4,PAR_C
					
					move.l	PAR_C,D0

					movem.l (SP)+,D3/D4
					unlk		A6
					rts

;   long dhft_pow(long a, int div);

MUL_POW	equ	D0
DIV_POW equ D1

dhft_pow:	movem.l	D3-D5,-(SP)

					move.l	MUL_POW,D2
					divs		DIV_POW,D2
					move		D2,D3
          swap		d2
          				
					move.l	MUL_POW,D4
					move.l	D4,D5			
					andi		#32767,D4
					lsl			#1,D5							
					swap		D5								
					roxl		#1,D5							

					muls		D3,D4
					muls		D3,D5
					swap		D5								; Methode 3
					lsl			#1,D5							;     "
					clr.w	  D5								;     "
					roxr.l	#1,D5							;     "
					add.l		D4,D5
					
					move		D2,D4
					muls		D3,D4
					add.l		D4,D5
					
					muls		D2,D2
					divs		D1,D2
					ext.l		D2
					add.l		D5,D2
					
					movem.l	(SP)+,D3-D5
					move.l	D2,D0
					rts