pun_ptr ($516) points to -----
                             |
                             |
------------------------------
|
|
V

_puns:
puns:           dc.w    0               ; # of physical units on user's system

dummy1:         dcb.b   2,-1            ; dummy pun entries for A and B
_pun:
  --More--  pun:            dcb.b   MAXUNITS,0      ; physical unit table

dummy2:         dcb.l   2,0             ; dummy start entries for A and B
_partstart:
start:          dcb.l   MAXUNITS,0      ; partition start table

_cookie:                                ; *** DON'T CHANGE ***
cookie:         dc.l    $41484449       ; cookie = 'AHDI'

_cookptr:
cookptr:        dc.l    0               ; pointer to cookie

_versn:
versn:          dc.w    $0300           ; version number: MMmm

_maxssz:
maxssz:         dc.w    512             ; maximum sector size handled

_idlelmt:                               ; idle time b4 spinning down ACSI 0
idlelmt:        dc.l    $ea60           ;  (in # of _hz_200 clicks) [5 min]

                dcb.l   15,0            ; reserved for future use
