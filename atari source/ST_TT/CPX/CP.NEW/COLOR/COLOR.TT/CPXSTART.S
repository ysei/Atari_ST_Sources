; cpxstart.asm
;=============================================================================
; Startup file for COLOR.CPX
;

; Globals
	.globl	    cpxstart
	.globl		saved
	.globl		usr_vals
	.globl		def_vals
	
; Externs
	.globl	    cpx_init
	
	.text

cpxstart:
   	  jmp cpx_init

	.data

saved:	.dc.w	0			; 0: no user-preference saved yet
							; non-zero: user-preference saved
							
usr_vals:					; saved user-preference
		.dc.w	-1			; bank # (0, ..., or 0xf)
		.dc.w	-1			; bit 0 not set: invert screen
							; bit 1 set: don't invert screen
		.dc.w	-1			; 0: Color mode
							; non-zero: Hypermono mode
		.dcb.w	256*3,-1	; saved RGB intensities for Bank 0
		.dcb.w	240*3,-1	; saved RGB intensities for Bank 1 - 15

def_vals:					; system defaults
		.dc.w	0			; default to Bank 0
		.dc.w	1			; default to screen not inverted
		.dc.w	0			; default to Color mode
		
		.dc.w	0x03E8, 0x03E8, 0x03E8	; default RGB %s for Bank 0
		.dc.w	0x0000, 0x0000, 0x0000
		.dc.w	0x03E8, 0x0000, 0x0000
		.dc.w	0x0000, 0x03E8, 0x0000
		.dc.w	0x0000, 0x0000, 0x03E8
		.dc.w	0x0000, 0x03E8, 0x03E8
		.dc.w	0x03E8, 0x03E8, 0x0000
		.dc.w	0x03E8, 0x0000, 0x03E8
		.dc.w	0x029B, 0x029B, 0x029B
		.dc.w	0x0190, 0x0190, 0x0190
		.dc.w	0x03E8, 0x0258, 0x0258
		.dc.w	0x0258, 0x03E8, 0x0258
		.dc.w	0x0258, 0x0258, 0x03E8
		.dc.w	0x0258, 0x03E8, 0x03E8
		.dc.w	0x03E8, 0x03E8, 0x0258
		.dc.w	0x03E8, 0x0258, 0x03E8
		.dc.w	0x03E8, 0x03E8, 0x03E8
		.dc.w	0x03A5, 0x03A5, 0x03A5
		.dc.w	0x0363, 0x0363, 0x0363
		.dc.w	0x0320, 0x0320, 0x0320
		.dc.w	0x02DD, 0x02DD, 0x02DD
		.dc.w	0x029B, 0x029B, 0x029B
		.dc.w	0x0258, 0x0258, 0x0258
		.dc.w	0x0215, 0x0215, 0x0215
		.dc.w	0x01D3, 0x01D3, 0x01D3
		.dc.w	0x0190, 0x0190, 0x0190
		.dc.w	0x014D, 0x014D, 0x014D
		.dc.w	0x010B, 0x010B, 0x010B
		.dc.w	0x00C8, 0x00C8, 0x00C8
		.dc.w	0x0085, 0x0085, 0x0085
		.dc.w	0x0043, 0x0043, 0x0043
		.dc.w	0x0000, 0x0000, 0x0000
		.dc.w	0x03E8, 0x0000, 0x0000
		.dc.w	0x03E8, 0x0000, 0x0043
		.dc.w	0x03E8, 0x0000, 0x0085
		.dc.w	0x03E8, 0x0000, 0x00C8
		.dc.w	0x03E8, 0x0000, 0x010B
		.dc.w	0x03E8, 0x0000, 0x014D
		.dc.w	0x03E8, 0x0000, 0x0190
		.dc.w	0x03E8, 0x0000, 0x01D3
		.dc.w	0x03E8, 0x0000, 0x0215
		.dc.w	0x03E8, 0x0000, 0x0258
		.dc.w	0x03E8, 0x0000, 0x029B
		.dc.w	0x03E8, 0x0000, 0x02DD
		.dc.w	0x03E8, 0x0000, 0x0320
		.dc.w	0x03E8, 0x0000, 0x0363
		.dc.w	0x03E8, 0x0000, 0x03A5
		.dc.w	0x03E8, 0x0000, 0x03E8
		.dc.w	0x03A5, 0x0000, 0x03E8
		.dc.w	0x0363, 0x0000, 0x03E8
		.dc.w	0x0320, 0x0000, 0x03E8
		.dc.w	0x02DD, 0x0000, 0x03E8
		.dc.w	0x029B, 0x0000, 0x03E8
		.dc.w	0x0258, 0x0000, 0x03E8
		.dc.w	0x0215, 0x0000, 0x03E8
		.dc.w	0x01D3, 0x0000, 0x03E8
		.dc.w	0x0190, 0x0000, 0x03E8
		.dc.w	0x014D, 0x0000, 0x03E8
		.dc.w	0x010B, 0x0000, 0x03E8
		.dc.w	0x00C8, 0x0000, 0x03E8
		.dc.w	0x0085, 0x0000, 0x03E8
		.dc.w	0x0043, 0x0000, 0x03E8
		.dc.w	0x0000, 0x0000, 0x03E8
		.dc.w	0x0000, 0x0043, 0x03E8
		.dc.w	0x0000, 0x0085, 0x03E8
		.dc.w	0x0000, 0x00C8, 0x03E8
		.dc.w	0x0000, 0x010B, 0x03E8
		.dc.w	0x0000, 0x014D, 0x03E8
		.dc.w	0x0000, 0x0190, 0x03E8
		.dc.w	0x0000, 0x01D3, 0x03E8
		.dc.w	0x0000, 0x0215, 0x03E8
		.dc.w	0x0000, 0x0258, 0x03E8
		.dc.w	0x0000, 0x029B, 0x03E8
		.dc.w	0x0000, 0x02DD, 0x03E8
		.dc.w	0x0000, 0x0320, 0x03E8
		.dc.w	0x0000, 0x0363, 0x03E8
		.dc.w	0x0000, 0x03A5, 0x03E8
		.dc.w	0x0000, 0x03E8, 0x03E8
		.dc.w	0x0000, 0x03E8, 0x03A5
		.dc.w	0x0000, 0x03E8, 0x0363
		.dc.w	0x0000, 0x03E8, 0x0320
		.dc.w	0x0000, 0x03E8, 0x02DD
		.dc.w	0x0000, 0x03E8, 0x029B
		.dc.w	0x0000, 0x03E8, 0x0258
		.dc.w	0x0000, 0x03E8, 0x0215
		.dc.w	0x0000, 0x03E8, 0x01D3
		.dc.w	0x0000, 0x03E8, 0x0190
		.dc.w	0x0000, 0x03E8, 0x014D
		.dc.w	0x0000, 0x03E8, 0x010B
		.dc.w	0x0000, 0x03E8, 0x00C8
		.dc.w	0x0000, 0x03E8, 0x0085
		.dc.w	0x0000, 0x03E8, 0x0043
		.dc.w	0x0000, 0x03E8, 0x0000
		.dc.w	0x0043, 0x03E8, 0x0000
		.dc.w	0x0085, 0x03E8, 0x0000
		.dc.w	0x00C8, 0x03E8, 0x0000
		.dc.w	0x010B, 0x03E8, 0x0000
		.dc.w	0x014D, 0x03E8, 0x0000
		.dc.w	0x0190, 0x03E8, 0x0000
		.dc.w	0x01D3, 0x03E8, 0x0000
		.dc.w	0x0215, 0x03E8, 0x0000
		.dc.w	0x0258, 0x03E8, 0x0000
		.dc.w	0x029B, 0x03E8, 0x0000
		.dc.w	0x02DD, 0x03E8, 0x0000
		.dc.w	0x0320, 0x03E8, 0x0000
		.dc.w	0x0363, 0x03E8, 0x0000
		.dc.w	0x03A5, 0x03E8, 0x0000
		.dc.w	0x03E8, 0x03E8, 0x0000
		.dc.w	0x03E8, 0x03A5, 0x0000
		.dc.w	0x03E8, 0x0363, 0x0000
		.dc.w	0x03E8, 0x0320, 0x0000
		.dc.w	0x03E8, 0x02DD, 0x0000
		.dc.w	0x03E8, 0x029B, 0x0000
		.dc.w	0x03E8, 0x0258, 0x0000
		.dc.w	0x03E8, 0x0215, 0x0000
		.dc.w	0x03E8, 0x01D3, 0x0000
		.dc.w	0x03E8, 0x0190, 0x0000
		.dc.w	0x03E8, 0x014D, 0x0000
		.dc.w	0x03E8, 0x010B, 0x0000
		.dc.w	0x03E8, 0x00C8, 0x0000
		.dc.w	0x03E8, 0x0085, 0x0000
		.dc.w	0x03E8, 0x0043, 0x0000
		.dc.w	0x02DD, 0x0000, 0x0000
		.dc.w	0x02DD, 0x0000, 0x0043
		.dc.w	0x02DD, 0x0000, 0x0085
		.dc.w	0x02DD, 0x0000, 0x00C8
		.dc.w	0x02DD, 0x0000, 0x010B
		.dc.w	0x02DD, 0x0000, 0x014D
		.dc.w	0x02DD, 0x0000, 0x0190
		.dc.w	0x02DD, 0x0000, 0x01D3
		.dc.w	0x02DD, 0x0000, 0x0215
		.dc.w	0x02DD, 0x0000, 0x0258
		.dc.w	0x02DD, 0x0000, 0x029B
		.dc.w	0x02DD, 0x0000, 0x02DD
		.dc.w	0x029B, 0x0000, 0x02DD
		.dc.w	0x0258, 0x0000, 0x02DD
		.dc.w	0x0215, 0x0000, 0x02DD
		.dc.w	0x01D3, 0x0000, 0x02DD
		.dc.w	0x0190, 0x0000, 0x02DD
		.dc.w	0x014D, 0x0000, 0x02DD
		.dc.w	0x010B, 0x0000, 0x02DD
		.dc.w	0x00C8, 0x0000, 0x02DD
		.dc.w	0x0085, 0x0000, 0x02DD
		.dc.w	0x0043, 0x0000, 0x02DD
		.dc.w	0x0000, 0x0000, 0x02DD
		.dc.w	0x0000, 0x0043, 0x02DD
		.dc.w	0x0000, 0x0085, 0x02DD
		.dc.w	0x0000, 0x00C8, 0x02DD
		.dc.w	0x0000, 0x010B, 0x02DD
		.dc.w	0x0000, 0x014D, 0x02DD
		.dc.w	0x0000, 0x0190, 0x02DD
		.dc.w	0x0000, 0x01D3, 0x02DD
		.dc.w	0x0000, 0x0215, 0x02DD
		.dc.w	0x0000, 0x0258, 0x02DD
		.dc.w	0x0000, 0x029B, 0x02DD
		.dc.w	0x0000, 0x02DD, 0x02DD
		.dc.w	0x0000, 0x02DD, 0x029B
		.dc.w	0x0000, 0x02DD, 0x0258
		.dc.w	0x0000, 0x02DD, 0x0215
		.dc.w	0x0000, 0x02DD, 0x01D3
		.dc.w	0x0000, 0x02DD, 0x0190
		.dc.w	0x0000, 0x02DD, 0x014D
		.dc.w	0x0000, 0x02DD, 0x010B
		.dc.w	0x0000, 0x02DD, 0x00C8
		.dc.w	0x0000, 0x02DD, 0x0085
		.dc.w	0x0000, 0x02DD, 0x0043
		.dc.w	0x0000, 0x02DD, 0x0000
		.dc.w	0x0043, 0x02DD, 0x0000
		.dc.w	0x0085, 0x02DD, 0x0000
		.dc.w	0x00C8, 0x02DD, 0x0000
		.dc.w	0x010B, 0x02DD, 0x0000
		.dc.w	0x014D, 0x02DD, 0x0000
		.dc.w	0x0190, 0x02DD, 0x0000
		.dc.w	0x01D3, 0x02DD, 0x0000
		.dc.w	0x0215, 0x02DD, 0x0000
		.dc.w	0x0258, 0x02DD, 0x0000
		.dc.w	0x029B, 0x02DD, 0x0000
		.dc.w	0x02DD, 0x02DD, 0x0000
		.dc.w	0x02DD, 0x029B, 0x0000
		.dc.w	0x02DD, 0x0258, 0x0000
		.dc.w	0x02DD, 0x0215, 0x0000
		.dc.w	0x02DD, 0x01D3, 0x0000
		.dc.w	0x02DD, 0x0190, 0x0000
		.dc.w	0x02DD, 0x014D, 0x0000
		.dc.w	0x02DD, 0x010B, 0x0000
		.dc.w	0x02DD, 0x00C8, 0x0000
		.dc.w	0x02DD, 0x0085, 0x0000
		.dc.w	0x02DD, 0x0043, 0x0000
		.dc.w	0x01D3, 0x0000, 0x0000
		.dc.w	0x01D3, 0x0000, 0x0043
		.dc.w	0x01D3, 0x0000, 0x0085
		.dc.w	0x01D3, 0x0000, 0x00C8
		.dc.w	0x01D3, 0x0000, 0x010B
		.dc.w	0x01D3, 0x0000, 0x014D
		.dc.w	0x01D3, 0x0000, 0x0190
		.dc.w	0x01D3, 0x0000, 0x01D3
		.dc.w	0x0190, 0x0000, 0x01D3
		.dc.w	0x014D, 0x0000, 0x01D3
		.dc.w	0x010B, 0x0000, 0x01D3
		.dc.w	0x00C8, 0x0000, 0x01D3
		.dc.w	0x0085, 0x0000, 0x01D3
		.dc.w	0x0043, 0x0000, 0x01D3
		.dc.w	0x0000, 0x0000, 0x01D3
		.dc.w	0x0000, 0x0043, 0x01D3
		.dc.w	0x0000, 0x0085, 0x01D3
		.dc.w	0x0000, 0x00C8, 0x01D3
		.dc.w	0x0000, 0x010B, 0x01D3
		.dc.w	0x0000, 0x014D, 0x01D3
		.dc.w	0x0000, 0x0190, 0x01D3
		.dc.w	0x0000, 0x01D3, 0x01D3
		.dc.w	0x0000, 0x01D3, 0x0190
		.dc.w	0x0000, 0x01D3, 0x014D
		.dc.w	0x0000, 0x01D3, 0x010B
		.dc.w	0x0000, 0x01D3, 0x00C8
		.dc.w	0x0000, 0x01D3, 0x0085
		.dc.w	0x0000, 0x01D3, 0x0043
		.dc.w	0x0000, 0x01D3, 0x0000
		.dc.w	0x0043, 0x01D3, 0x0000
		.dc.w	0x0085, 0x01D3, 0x0000
		.dc.w	0x00C8, 0x01D3, 0x0000
		.dc.w	0x010B, 0x01D3, 0x0000
		.dc.w	0x014D, 0x01D3, 0x0000
		.dc.w	0x0190, 0x01D3, 0x0000
		.dc.w	0x01D3, 0x01D3, 0x0000
		.dc.w	0x01D3, 0x0190, 0x0000
		.dc.w	0x01D3, 0x014D, 0x0000
		.dc.w	0x01D3, 0x010B, 0x0000
		.dc.w	0x01D3, 0x00C8, 0x0000
		.dc.w	0x01D3, 0x0085, 0x0000
		.dc.w	0x01D3, 0x0043, 0x0000
		.dc.w	0x010B, 0x0000, 0x0000
		.dc.w	0x010B, 0x0000, 0x0043
		.dc.w	0x010B, 0x0000, 0x0085
		.dc.w	0x010B, 0x0000, 0x00C8
		.dc.w	0x010B, 0x0000, 0x010B
		.dc.w	0x00C8, 0x0000, 0x010B
		.dc.w	0x0085, 0x0000, 0x010B
		.dc.w	0x0043, 0x0000, 0x010B
		.dc.w	0x0000, 0x0000, 0x010B
		.dc.w	0x0000, 0x0043, 0x010B
		.dc.w	0x0000, 0x0085, 0x010B
		.dc.w	0x0000, 0x00C8, 0x010B
		.dc.w	0x0000, 0x010B, 0x010B
		.dc.w	0x0000, 0x010B, 0x00C8
		.dc.w	0x0000, 0x010B, 0x0085
		.dc.w	0x0000, 0x010B, 0x0043
		.dc.w	0x0000, 0x010B, 0x0000
		.dc.w	0x0043, 0x010B, 0x0000
		.dc.w	0x0085, 0x010B, 0x0000
		.dc.w	0x00C8, 0x010B, 0x0000
		.dc.w	0x010B, 0x010B, 0x0000
		.dc.w	0x010B, 0x00C8, 0x0000
		.dc.w	0x010B, 0x0085, 0x0000
		.dc.w	0x010B, 0x0043, 0x0000
		.dc.w	0x03E8, 0x03E8, 0x03E8
		.dc.w	0x0000, 0x0000, 0x0000
		
		.dc.w	0x03E8, 0x03E8, 0x03E8	; default RGB %s for Bank 1
		.dc.w	0x0000, 0x0000, 0x0000
		.dc.w	0x03A5, 0x03A5, 0x03A5
		.dc.w	0x0363, 0x0363, 0x0363
		.dc.w	0x02DD, 0x02DD, 0x02DD
		.dc.w	0x0258, 0x0258, 0x0258
		.dc.w	0x0320, 0x0320, 0x0320
		.dc.w	0x029B, 0x029B, 0x029B
		.dc.w	0x0215, 0x0215, 0x0215
		.dc.w	0x01D3, 0x01D3, 0x01D3
		.dc.w	0x0190, 0x0190, 0x0190
		.dc.w	0x014D, 0x014D, 0x014D
		.dc.w	0x00C8, 0x00C8, 0x00C8
		.dc.w	0x0043, 0x0043, 0x0043
		.dc.w	0x010B, 0x010B, 0x010B
		.dc.w	0x0085, 0x0085, 0x0085
		
		.dc.w	0x03E8, 0x0000, 0x0000	; default RGB %s for Bank 2
		.dc.w	0x03E8, 0x0000, 0x03E8
		.dc.w	0x03E8, 0x0000, 0x0043
		.dc.w	0x03E8, 0x0000, 0x0085
		.dc.w	0x03E8, 0x0000, 0x010B
		.dc.w	0x03E8, 0x0000, 0x0190
		.dc.w	0x03E8, 0x0000, 0x00C8
		.dc.w	0x03E8, 0x0000, 0x014D
		.dc.w	0x03E8, 0x0000, 0x01D3
		.dc.w	0x03E8, 0x0000, 0x0215
		.dc.w	0x03E8, 0x0000, 0x0258
		.dc.w	0x03E8, 0x0000, 0x029B
		.dc.w	0x03E8, 0x0000, 0x0320
		.dc.w	0x03E8, 0x0000, 0x03A5
		.dc.w	0x03E8, 0x0000, 0x02DD
		.dc.w	0x03E8, 0x0000, 0x0363
		
		.dc.w	0x03A5, 0x0000, 0x03E8	; default RGB %s for Bank 3
		.dc.w	0x0000, 0x0043, 0x03E8
		.dc.w	0x0363, 0x0000, 0x03E8
		.dc.w	0x0320, 0x0000, 0x03E8
		.dc.w	0x029B, 0x0000, 0x03E8
		.dc.w	0x0215, 0x0000, 0x03E8
		.dc.w	0x02DD, 0x0000, 0x03E8
		.dc.w	0x0258, 0x0000, 0x03E8
		.dc.w	0x01D3, 0x0000, 0x03E8
		.dc.w	0x0190, 0x0000, 0x03E8
		.dc.w	0x014D, 0x0000, 0x03E8
		.dc.w	0x010B, 0x0000, 0x03E8
		.dc.w	0x0085, 0x0000, 0x03E8
		.dc.w	0x0000, 0x0000, 0x03E8
		.dc.w	0x00C8, 0x0000, 0x03E8
		.dc.w	0x0043, 0x0000, 0x03E8
		
		.dc.w	0x0000, 0x0085, 0x03E8	; default RGB %s for Bank 4
		.dc.w	0x0000, 0x03E8, 0x0363
		.dc.w	0x0000, 0x00C8, 0x03E8
		.dc.w	0x0000, 0x010B, 0x03E8
		.dc.w	0x0000, 0x0190, 0x03E8
		.dc.w	0x0000, 0x0215, 0x03E8
		.dc.w	0x0000, 0x014D, 0x03E8
		.dc.w	0x0000, 0x01D3, 0x03E8
		.dc.w	0x0000, 0x0258, 0x03E8
		.dc.w	0x0000, 0x029B, 0x03E8
		.dc.w	0x0000, 0x02DD, 0x03E8
		.dc.w	0x0000, 0x0320, 0x03E8
		.dc.w	0x0000, 0x03A5, 0x03E8
		.dc.w	0x0000, 0x03E8, 0x03A5
		.dc.w	0x0000, 0x0363, 0x03E8
		.dc.w	0x0000, 0x03E8, 0x03E8
		
		.dc.w	0x0000, 0x03E8, 0x0320	; default RGB %s for Bank 5
		.dc.w	0x00C8, 0x03E8, 0x0000
		.dc.w	0x0000, 0x03E8, 0x02DD
		.dc.w	0x0000, 0x03E8, 0x029B
		.dc.w	0x0000, 0x03E8, 0x0215
		.dc.w	0x0000, 0x03E8, 0x0190
		.dc.w	0x0000, 0x03E8, 0x0258
		.dc.w	0x0000, 0x03E8, 0x01D3
		.dc.w	0x0000, 0x03E8, 0x014D
		.dc.w	0x0000, 0x03E8, 0x010B
		.dc.w	0x0000, 0x03E8, 0x00C8
		.dc.w	0x0000, 0x03E8, 0x0085
		.dc.w	0x0000, 0x03E8, 0x0000
		.dc.w	0x0085, 0x03E8, 0x0000
		.dc.w	0x0000, 0x03E8, 0x0043
		.dc.w	0x0043, 0x03E8, 0x0000
		
		.dc.w	0x010B, 0x03E8, 0x0000	; default RGB %s for Bank 6
		.dc.w	0x03E8, 0x02DD, 0x0000
		.dc.w	0x014D, 0x03E8, 0x0000
		.dc.w	0x0190, 0x03E8, 0x0000
		.dc.w	0x0215, 0x03E8, 0x0000
		.dc.w	0x029B, 0x03E8, 0x0000
		.dc.w	0x01D3, 0x03E8, 0x0000
		.dc.w	0x0258, 0x03E8, 0x0000
		.dc.w	0x02DD, 0x03E8, 0x0000
		.dc.w	0x0320, 0x03E8, 0x0000
		.dc.w	0x0363, 0x03E8, 0x0000
		.dc.w	0x03A5, 0x03E8, 0x0000
		.dc.w	0x03E8, 0x03A5, 0x0000
		.dc.w	0x03E8, 0x0320, 0x0000
		.dc.w	0x03E8, 0x03E8, 0x0000
		.dc.w	0x03E8, 0x0363, 0x0000
		
		.dc.w	0x03E8, 0x029B, 0x0000	; default RGB %s for Bank 7
		.dc.w	0x02DD, 0x0000, 0x014D
		.dc.w	0x03E8, 0x0258, 0x0000
		.dc.w	0x03E8, 0x0215, 0x0000
		.dc.w	0x03E8, 0x0190, 0x0000
		.dc.w	0x03E8, 0x010B, 0x0000
		.dc.w	0x03E8, 0x01D3, 0x0000
		.dc.w	0x03E8, 0x014D, 0x0000
		.dc.w	0x03E8, 0x00C8, 0x0000
		.dc.w	0x03E8, 0x0085, 0x0000
		.dc.w	0x03E8, 0x0043, 0x0000
		.dc.w	0x02DD, 0x0000, 0x0000
		.dc.w	0x02DD, 0x0000, 0x0085
		.dc.w	0x02DD, 0x0000, 0x010B
		.dc.w	0x02DD, 0x0000, 0x0043
		.dc.w	0x02DD, 0x0000, 0x00C8
		
		.dc.w	0x02DD, 0x0000, 0x0190	; default RGB %s for Bank 8
		.dc.w	0x0043, 0x0000, 0x02DD
		.dc.w	0x02DD, 0x0000, 0x01D3
		.dc.w	0x02DD, 0x0000, 0x0215
		.dc.w	0x02DD, 0x0000, 0x029B
		.dc.w	0x029B, 0x0000, 0x02DD
		.dc.w	0x02DD, 0x0000, 0x0258
		.dc.w	0x02DD, 0x0000, 0x02DD
		.dc.w	0x0258, 0x0000, 0x02DD
		.dc.w	0x0215, 0x0000, 0x02DD
		.dc.w	0x01D3, 0x0000, 0x02DD
		.dc.w	0x0190, 0x0000, 0x02DD
		.dc.w	0x010B, 0x0000, 0x02DD
		.dc.w	0x0085, 0x0000, 0x02DD
		.dc.w	0x014D, 0x0000, 0x02DD
		.dc.w	0x00C8, 0x0000, 0x02DD
		
		.dc.w	0x0000, 0x0000, 0x02DD	; default RGB %s for Bank 9
		.dc.w	0x0000, 0x02DD, 0x01D3
		.dc.w	0x0000, 0x0043, 0x02DD
		.dc.w	0x0000, 0x0085, 0x02DD
		.dc.w	0x0000, 0x010B, 0x02DD
		.dc.w	0x0000, 0x0190, 0x02DD
		.dc.w	0x0000, 0x00C8, 0x02DD
		.dc.w	0x0000, 0x014D, 0x02DD
		.dc.w	0x0000, 0x01D3, 0x02DD
		.dc.w	0x0000, 0x0215, 0x02DD
		.dc.w	0x0000, 0x0258, 0x02DD
		.dc.w	0x0000, 0x029B, 0x02DD
		.dc.w	0x0000, 0x02DD, 0x029B
		.dc.w	0x0000, 0x02DD, 0x0215
		.dc.w	0x0000, 0x02DD, 0x02DD
		.dc.w	0x0000, 0x02DD, 0x0258
		
		.dc.w	0x0000, 0x02DD, 0x0190	; default RGB %s for Bank 10
		.dc.w	0x0258, 0x02DD, 0x0000
		.dc.w	0x0000, 0x02DD, 0x014D
		.dc.w	0x0000, 0x02DD, 0x010B
		.dc.w	0x0000, 0x02DD, 0x0085
		.dc.w	0x0000, 0x02DD, 0x0000
		.dc.w	0x0000, 0x02DD, 0x00C8
		.dc.w	0x0000, 0x02DD, 0x0043
		.dc.w	0x0043, 0x02DD, 0x0000
		.dc.w	0x0085, 0x02DD, 0x0000
		.dc.w	0x00C8, 0x02DD, 0x0000
		.dc.w	0x010B, 0x02DD, 0x0000
		.dc.w	0x0190, 0x02DD, 0x0000
		.dc.w	0x0215, 0x02DD, 0x0000
		.dc.w	0x014D, 0x02DD, 0x0000
		.dc.w	0x01D3, 0x02DD, 0x0000
		
		.dc.w	0x029B, 0x02DD, 0x0000	; default RGB %s for Bank 11
		.dc.w	0x01D3, 0x0000, 0x00C8
		.dc.w	0x02DD, 0x02DD, 0x0000
		.dc.w	0x02DD, 0x029B, 0x0000
		.dc.w	0x02DD, 0x0215, 0x0000
		.dc.w	0x02DD, 0x0190, 0x0000
		.dc.w	0x02DD, 0x0258, 0x0000
		.dc.w	0x02DD, 0x01D3, 0x0000
		.dc.w	0x02DD, 0x014D, 0x0000
		.dc.w	0x02DD, 0x010B, 0x0000
		.dc.w	0x02DD, 0x00C8, 0x0000
		.dc.w	0x02DD, 0x0085, 0x0000
		.dc.w	0x01D3, 0x0000, 0x0000
		.dc.w	0x01D3, 0x0000, 0x0085
		.dc.w	0x02DD, 0x0043, 0x0000
		.dc.w	0x01D3, 0x0000, 0x0043
		
		.dc.w	0x01D3, 0x0000, 0x010B	; default RGB %s for Bank 12
		.dc.w	0x0000, 0x014D, 0x01D3
		.dc.w	0x01D3, 0x0000, 0x014D
		.dc.w	0x01D3, 0x0000, 0x0190
		.dc.w	0x0190, 0x0000, 0x01D3
		.dc.w	0x010B, 0x0000, 0x01D3
		.dc.w	0x01D3, 0x0000, 0x01D3
		.dc.w	0x014D, 0x0000, 0x01D3
		.dc.w	0x00C8, 0x0000, 0x01D3
		.dc.w	0x0085, 0x0000, 0x01D3
		.dc.w	0x0043, 0x0000, 0x01D3
		.dc.w	0x0000, 0x0000, 0x01D3
		.dc.w	0x0000, 0x0085, 0x01D3
		.dc.w	0x0000, 0x010B, 0x01D3
		.dc.w	0x0000, 0x0043, 0x01D3
		.dc.w	0x0000, 0x00C8, 0x01D3
		
		.dc.w	0x0000, 0x0190, 0x01D3	; default RGB %s for Bank 13
		.dc.w	0x01D3, 0x01D3, 0x0000
		.dc.w	0x0000, 0x01D3, 0x01D3
		.dc.w	0x0000, 0x01D3, 0x0190
		.dc.w	0x0000, 0x01D3, 0x010B
		.dc.w	0x0000, 0x01D3, 0x0085
		.dc.w	0x0000, 0x01D3, 0x014D
		.dc.w	0x0000, 0x01D3, 0x00C8
		.dc.w	0x0000, 0x01D3, 0x0043
		.dc.w	0x0000, 0x01D3, 0x0000
		.dc.w	0x0043, 0x01D3, 0x0000
		.dc.w	0x0085, 0x01D3, 0x0000
		.dc.w	0x010B, 0x01D3, 0x0000
		.dc.w	0x0190, 0x01D3, 0x0000
		.dc.w	0x00C8, 0x01D3, 0x0000
		.dc.w	0x014D, 0x01D3, 0x0000
		
		.dc.w	0x01D3, 0x0190, 0x0000	; default RGB %s for Bank 14
		.dc.w	0x0000, 0x0043, 0x010B
		.dc.w	0x01D3, 0x014D, 0x0000
		.dc.w	0x01D3, 0x010B, 0x0000
		.dc.w	0x01D3, 0x0085, 0x0000
		.dc.w	0x010B, 0x0000, 0x0000
		.dc.w	0x01D3, 0x00C8, 0x0000
		.dc.w	0x01D3, 0x0043, 0x0000
		.dc.w	0x010B, 0x0000, 0x0043
		.dc.w	0x010B, 0x0000, 0x0085
		.dc.w	0x010B, 0x0000, 0x00C8
		.dc.w	0x010B, 0x0000, 0x010B
		.dc.w	0x0085, 0x0000, 0x010B
		.dc.w	0x0000, 0x0000, 0x010B
		.dc.w	0x00C8, 0x0000, 0x010B
		.dc.w	0x0043, 0x0000, 0x010B
		
		.dc.w	0x0000, 0x0085, 0x010B	; default RGB %s for Bank 15
		.dc.w	0x0000, 0x0000, 0x0000
		.dc.w	0x0000, 0x00C8, 0x010B
		.dc.w	0x0000, 0x010B, 0x010B
		.dc.w	0x0000, 0x010B, 0x0085
		.dc.w	0x0000, 0x010B, 0x0000
		.dc.w	0x0000, 0x010B, 0x00C8
		.dc.w	0x0000, 0x010B, 0x0043
		.dc.w	0x0043, 0x010B, 0x0000
		.dc.w	0x0085, 0x010B, 0x0000
		.dc.w	0x00C8, 0x010B, 0x0000
		.dc.w	0x010B, 0x010B, 0x0000
		.dc.w	0x010B, 0x0085, 0x0000
		.dc.w	0x03E8, 0x03E8, 0x03E8
		.dc.w	0x010B, 0x00C8, 0x0000
		.dc.w	0x010B, 0x0043, 0x0000
	.end
