	.globl EndCartAddr
* THIS SHOULD BE THE LAST ADDRESS IN THE CARTRIGE SPACE. AKA THE START OF THE RELOCATED CART.
	.data
	.even
	dc.b	'*END*'
EndCartAddr:
