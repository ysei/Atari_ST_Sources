#define T0OBJ 0
#define T1OBJ 30
#define T2OBJ 37
#define T3OBJ 56
#define T4OBJ 59
#define T5OBJ 77
#define T6OBJ 80
#define T7OBJ 83
#define T8OBJ 88
#define T9OBJ 96
#define T10OBJ 108
#define T11OBJ 113
#define T12OBJ 129
#define T13OBJ 142
#define T14OBJ 148
#define T15OBJ 156
#define T16OBJ 165
#define T17OBJ 168
#define T18OBJ 171
#define T19OBJ 174
#define T20OBJ 177
#define T21OBJ 193
#define T22OBJ 195
#define T23OBJ 200
#define T24OBJ 203
#define T25OBJ 206
#define T26OBJ 220
#define FREEBB 0
#define FREEIMG 6
#define FREESTR 233

BYTE *rs_strings[] = {
" Desk ",
" File ",
" Disk ",
"  About FHDX...     ",
"--------------------",
"1",
"2",
"3",
"4",
"5",
"6",
"  Quit       ",
"  Select Unit",
"  Select Disk Model",
"---------------------",
"  Controller Test",
"  Daisy Chain Test",
"  Format Disk",
"  Input Defect List",
"  Burn-in Test",
"---------------------",
"  Ship",
"---------------------",
"  Atari Hard Disk Utility  ",
"Copyright 1988, 1989, 1990, 1991",
"OK",
"Version 3.5   ",
"by Atari Corporation",
"for the factory",
"Indicate the disk model:",
"Unused",
"OK",
"CANCEL",
"Unused",
"Unused",
"Unused",
"Unused",
"Unused",
"Unused",
"Unused",
"Unused",
"Unused",
"Unused",
"Unused",
"Unused",
"Unused",
"Unused",
"  Hard Disk Format  ",
"Formatting...",
"  Hard Disk Burn-in Test  ",
"Current cycle:",
"0         ",
"Test",
"ing cylinder:",
"0         ",
"Number of bad sectors:",
"0",
"------------------------------------",
"Hit:",
"<ctrl-S> to SUSPEND the test",
"<ctrl-R> to RESUME the test",
"<ctrl-Q> to QUIT the test",
"  PASSED!!  ",
"  Hard Disk Burn-in Test  ",
"XXX  FAILED!!  XXX",
"  Hard Disk Burn-in Test  ",
"  Input Defect List  ",
"Keep current defect list?",
"Yes!",
"No",
"  Input Defect List  ",
"Tester used:",
"Start",
"Cancel",
"MFM",
"RLL",
"  Input Defect List  ",
"Head #",
"Cylinder #",
"Byte offset",
"DONE",
"Next ",
"INPUTTING...",
"",
"",
"@",
"  _",
"9",
"@123",
"  ____",
"9999",
"@2345",
"  _____",
"9",
"  Input Defect List  ",
"Examine the defect list",
"Save the defect list",
"Quit without saving",
"Head#   Cylinder#   Byte offset",
"",
"",
"@@234@2345",
"     _       ____        _____",
"NNNNNNNNNN",
"@@234@2345",
"     _       ____        _____",
"NNNNNNNNNN",
"@@234@2345",
"     _       ____        _____",
"NNNNNNNNNN",
"@@234@2345",
"     _       ____        _____",
"NNNNNNNNNN",
"@@234@2345",
"     _       ____        _____",
"NNNNNNNNNN",
"@@234@2345",
"     _       ____        _____",
"NNNNNNNNNN",
"@@234@2345",
"     _       ____        _____",
"NNNNNNNNNN",
"@@234@2345",
"     _       ____        _____",
"NNNNNNNNNN",
"  EXAMINING... ",
"",
"",
"  Input Defect List  ",
"Head #",
"Cylinder #",
"Byte offset",
"Cancel",
"OK",
"EDITTING...",
"",
"",
"Delete",
"@",
"  _",
"9",
"@123",
"  ____",
"9999",
"@2345",
"  _____",
"9",
"Partition",
"0",
"is too big!",
"Repartition the disk.",
"  OK  ",
"Cannot find partition scheme",
"SH204       ",
"OK",
"Edit WINCAP to include such",
"a partition scheme.",
"",
"for",
"Cannot find format parameters",
"SH204       ",
"OK",
"Edit WINCAP to include format",
"parameters for that disk",
"",
"for",
"model.",
"  PASSED!!  ",
"  Hard Disk Daisy-chain Test  ",
"XXX  WRITE ERROR!!  XXX",
"  Hard Disk Daisy-chain Test  ",
"XXX  READ ERROR!!  XXX",
"  Hard Disk Daisy-chain Test  ",
"XXX  DATA ERROR!!  XXX",
"  Hard Disk Daisy-chain Test  ",
"  Head#   Cyl#   Sector#",
"",
"",
"@23@2@234@23456",
" ___    __     ____   ______",
"NNNNNNNNNNNNNNN",
"@23@2@234@23456",
" ___    __     ____   ______",
"NNNNNNNNNNNNNNN",
"@23@2@234@23456",
" ___    __     ____   ______",
"NNNNNNNNNNNNNNN",
"@23@2@234@23456",
" ___    __     ____   ______",
"NNNNNNNNNNNNNNN",
"@23@2@234@23456",
" ___    __     ____   ______",
"NNNNNNNNNNNNNNN",
"@23@2@234@23456",
" ___    __     ____   ______",
"NNNNNNNNNNNNNNN",
"@23@2@234@23456",
" ___    __     ____   ______",
"NNNNNNNNNNNNNNN",
"@23@2@234@23456",
" ___    __     ____   ______",
"NNNNNNNNNNNNNNN",
"   Bad Sectors Recorded  ",
"",
"",
"Partitioning Disk...",
"The error code is",
"   OK   ",
"",
"     ",
"  PASSED!!  ",
"  Hard Disk Controller Test  ",
"XXX  FAILED!!  XXX",
"  Hard Disk Controller Test  ",
"ACSI:",
"SCSI:",
"IDE:",
"Select a physical unit",
"OK",
"UNIT 0",
"UNIT 1",
"UNIT 1",
"UNIT 0",
"UNIT 0",
"UNIT 1",
"CANCEL",
"0",
"Unit: _",
"9",
"???????????",
"Model: ___________",
"XXXXXXXXXXX",
"ACSI ",
"[3][Disk is not formatted!|Format disk before |proceeding.][   OK   ]\
",
"[3][Turn off the hard disk|NOW!!][   OK   ]",
"[1][Entry is incomplete!|Please complete the entry.][   OK   ]",
"[1][Head number entered is|too big!!|Please re-enter the head|number.\
][   OK   ]",
"[1][Cylinder number entered|is too big!!|Please re-enter cylinder|num\
ber.][   OK   ]",
"[1][Byte offset entered|is too big!!|Please re-enter byte|offset.][  \
 OK   ]",
"[3][Cannot read from File|Allocation Table!|Try reformatting disk.][ \
  OK   ]",
"[3][Cannot write to File|Allocation Table!|Try reformatting disk.][  \
 OK   ]",
"[3][Not enough system memory!|Cannot continue.][   OK   ]",
"[3][Cannot read from Boot|Sector!|Try reformatting disk.][   OK   ]",
"[3][Cannot write to Boot|Sector!|Try reformatting disk.][   OK   ]",
"[3][Cannot read from Root|Sector!|Reject this hard disk.][   OK   ]",
"[3][Cannot write to Root|Sector!|Reject this hard disk.][   OK   ]",
"[3][Root sector is corrupted!|Reject this hard disk.][   OK   ]",
"[3][Cannot write to hard disk!|Try reformatting disk.][   OK   ]",
"[2][Cylinder number entered|is ZERO!|Are you sure it is correct?][  Y\
es  |No!]",
"[3][Cylinder 0 of this hard|disk is bad!|Reject this hard disk.][   O\
K   ]",
"[3][Cannot read Bad Sector|List from disk!|Try reformatting it.][   O\
K   ]",
"[3][Cannot write Bad Sector|List to disk!|Try reformatting it.][    O\
K    ]",
"[3][Bad Sector List is|corrupted!|Try reformatting disk.][   OK   ]",
"[3][Too many logical drives!|You can have no more than |14 logical dr\
ives.][   OK   ]",
"[3][Cannot partition selected|unit!][   OK   ]",
"[3][Cannot format selected unit!][   OK   ]",
"[3][Number of defects is|exceeding the limit!|Reject this hard disk.]\
[   OK   ]",
"[1][The system will reboot|automatically.][   OK   ]",
"[1][No defect is recorded!][   OK   ]",
"[1][Too many bad sectors on disk.|Cannot record all of them.  For|bet\
ter bad-sector handling, back|up your disk and reformat it.][   OK   ]\
",
"[3][Illegal format parameters.|Reformat disk with the|'Format' functi\
on provided.][   OK   ]",
"[3][No 'dc' entry found in|WINCAP for daisy-chain|test!|Edit WINCAP t\
o include|such an entry.][   OK   ]",
"[3][Cannot find WINCAP file!][   OK   ]",
"[3][FHDX cannot be run in|low resolution.][  OK  ]"};

WORD IMAG0[] = {
0x7F, 0xFE00, 0xC0, 0x300, 
0x1BF, 0xFD80, 0x37F, 0xFEC0, 
0x6FF, 0xFF60, 0xDFF, 0xFFB0, 
0x1BFF, 0xFFD8, 0x37FF, 0xFFEC, 
0x6FFF, 0xFFF6, 0xDFFF, 0xFFFB, 
0xB181, 0x860D, 0xA081, 0x205, 
0xA4E7, 0x3265, 0xA7E7, 0x3265, 
0xA3E7, 0x3265, 0xB1E7, 0x3205, 
0xB8E7, 0x320D, 0xBCE7, 0x327D, 
0xA4E7, 0x327D, 0xA0E7, 0x27D, 
0xB1E7, 0x867D, 0xBFFF, 0xFFFD, 
0xDFFF, 0xFFFB, 0x6FFF, 0xFFF6, 
0x37FF, 0xFFEC, 0x1BFF, 0xFFD8, 
0xDFF, 0xFFB0, 0x6FF, 0xFF60, 
0x37F, 0xFEC0, 0x1BF, 0xFD80, 
0xC0, 0x300, 0x7F, 0xFE00};

WORD IMAG1[] = {
0x7F, 0xFE00, 0xC0, 0x300, 
0x1BF, 0xFD80, 0x37F, 0xFEC0, 
0x6FF, 0xFF60, 0xDFF, 0xFFB0, 
0x1BFF, 0xFFD8, 0x37FF, 0xFFEC, 
0x6FFF, 0xFFF6, 0xDFFF, 0xFFFB, 
0xB181, 0x860D, 0xA081, 0x205, 
0xA4E7, 0x3265, 0xA7E7, 0x3265, 
0xA3E7, 0x3265, 0xB1E7, 0x3205, 
0xB8E7, 0x320D, 0xBCE7, 0x327D, 
0xA4E7, 0x327D, 0xA0E7, 0x27D, 
0xB1E7, 0x867D, 0xBFFF, 0xFFFD, 
0xDFFF, 0xFFFB, 0x6FFF, 0xFFF6, 
0x37FF, 0xFFEC, 0x1BFF, 0xFFD8, 
0xDFF, 0xFFB0, 0x6FF, 0xFF60, 
0x37F, 0xFEC0, 0x1BF, 0xFD80, 
0xC0, 0x300, 0x7F, 0xFE00};

WORD IMAG2[] = {
0x7F, 0xFE00, 0xC0, 0x300, 
0x1BF, 0xFD80, 0x37F, 0xFEC0, 
0x6FF, 0xFF60, 0xDFF, 0xFFB0, 
0x1BFF, 0xFFD8, 0x37FF, 0xFFEC, 
0x6FFF, 0xFFF6, 0xDFFF, 0xFFFB, 
0xB181, 0x860D, 0xA081, 0x205, 
0xA4E7, 0x3265, 0xA7E7, 0x3265, 
0xA3E7, 0x3265, 0xB1E7, 0x3205, 
0xB8E7, 0x320D, 0xBCE7, 0x327D, 
0xA4E7, 0x327D, 0xA0E7, 0x27D, 
0xB1E7, 0x867D, 0xBFFF, 0xFFFD, 
0xDFFF, 0xFFFB, 0x6FFF, 0xFFF6, 
0x37FF, 0xFFEC, 0x1BFF, 0xFFD8, 
0xDFF, 0xFFB0, 0x6FF, 0xFF60, 
0x37F, 0xFEC0, 0x1BF, 0xFD80, 
0xC0, 0x300, 0x7F, 0xFE00};

WORD IMAG3[] = {
0x7F, 0xFE00, 0xC0, 0x300, 
0x1BF, 0xFD80, 0x37F, 0xFEC0, 
0x6FF, 0xFF60, 0xDFF, 0xFFB0, 
0x1BFF, 0xFFD8, 0x37FF, 0xFFEC, 
0x6FFF, 0xFFF6, 0xDFFF, 0xFFFB, 
0xB181, 0x860D, 0xA081, 0x205, 
0xA4E7, 0x3265, 0xA7E7, 0x3265, 
0xA3E7, 0x3265, 0xB1E7, 0x3205, 
0xB8E7, 0x320D, 0xBCE7, 0x327D, 
0xA4E7, 0x327D, 0xA0E7, 0x27D, 
0xB1E7, 0x867D, 0xBFFF, 0xFFFD, 
0xDFFF, 0xFFFB, 0x6FFF, 0xFFF6, 
0x37FF, 0xFFEC, 0x1BFF, 0xFFD8, 
0xDFF, 0xFFB0, 0x6FF, 0xFF60, 
0x37F, 0xFEC0, 0x1BF, 0xFD80, 
0xC0, 0x300, 0x7F, 0xFE00};

WORD IMAG4[] = {
0x3FFF, 0xFFFC, 0xC000, 0x3, 
0x9FFF, 0xFFF9, 0xBFFF, 0xFFFD, 
0xDFF8, 0x3FFB, 0x5FE0, 0xFFA, 
0x6FC0, 0x7F6, 0x2F83, 0x83F4, 
0x3787, 0xC3EC, 0x1787, 0xC3E8, 
0x1BFF, 0x83D8, 0xBFF, 0x7D0, 
0xDFE, 0xFB0, 0x5FC, 0x1FA0, 
0x6FC, 0x3F60, 0x2FC, 0x3F40, 
0x37C, 0x3EC0, 0x17C, 0x3E80, 
0x1BF, 0xFD80, 0xBF, 0xFD00, 
0xDC, 0x3B00, 0x5C, 0x3A00, 
0x6C, 0x3600, 0x2F, 0xF400, 
0x37, 0xEC00, 0x17, 0xE800, 
0x1B, 0xD800, 0xB, 0xD000, 
0xD, 0xB000, 0x5, 0xA000, 
0x6, 0x6000, 0x3, 0xC000};

WORD IMAG5[] = {
0x3, 0xC000, 0x6, 0x6000, 
0xD, 0xB000, 0x1B, 0xD800, 
0x37, 0xEC00, 0x6F, 0xF600, 
0xDC, 0x3B00, 0x1BC, 0x3D80, 
0x37C, 0x3EC0, 0x6FC, 0x3F60, 
0xDFC, 0x3FB0, 0x1BFC, 0x3FD8, 
0x37FC, 0x3FEC, 0x6FFC, 0x3FF6, 
0xDFFC, 0x3FFB, 0xBFFC, 0x3FFD, 
0xBFFC, 0x3FFD, 0xDFFC, 0x3FFB, 
0x6FFC, 0x3FF6, 0x37FC, 0x3FEC, 
0x1BFF, 0xFFD8, 0xDFF, 0xFFB0, 
0x6FC, 0x3F60, 0x37C, 0x3EC0, 
0x1BC, 0x3D80, 0xDC, 0x3B00, 
0x6F, 0xF600, 0x37, 0xEC00, 
0x1B, 0xD800, 0xD, 0xB000, 
0x6, 0x6000, 0x3, 0xC000};

LONG rs_frstr[] = {
233L,
234L,
235L,
236L,
237L,
238L,
239L,
240L,
241L,
242L,
243L,
244L,
245L,
246L,
247L,
248L,
249L,
250L,
251L,
252L,
253L,
254L,
255L,
256L,
257L,
258L,
259L,
260L,
261L,
262L,
263L};

BITBLK rs_bitblk[] = {
0};

LONG rs_frimg[] = {
0};

ICONBLK rs_iconblk[] = {
0L, 1L, 157L, 4096,0,0, 8,0,32,32, 0,24,48,8,
2L, 3L, 164L, 4096,0,0, 8,0,32,32, 0,24,48,8,
4L, 5L, 208L, 4096,0,0, 8,0,32,32, 0,24,48,8};

TEDINFO rs_tedinfo[] = {
82L, 83L, 84L, 3, 6, 2, 0x1180, 0x0, -1, 13,1,
85L, 86L, 87L, 3, 6, 0, 0x1180, 0x0, -1, 2,5,
88L, 89L, 90L, 3, 6, 0, 0x1180, 0x0, -1, 5,8,
91L, 92L, 93L, 3, 6, 0, 0x1180, 0x0, -1, 6,9,
98L, 99L, 100L, 3, 6, 2, 0x1180, 0x0, -1, 32,1,
101L, 102L, 103L, 3, 6, 0, 0x1180, 0x0, -1, 11,32,
104L, 105L, 106L, 3, 6, 0, 0x1180, 0x0, -1, 11,32,
107L, 108L, 109L, 3, 6, 0, 0x1180, 0x0, -1, 11,32,
110L, 111L, 112L, 3, 6, 0, 0x1180, 0x0, -1, 11,32,
113L, 114L, 115L, 3, 6, 0, 0x1180, 0x0, -1, 11,32,
116L, 117L, 118L, 3, 6, 0, 0x1180, 0x0, -1, 11,32,
119L, 120L, 121L, 3, 6, 0, 0x1180, 0x0, -1, 11,32,
122L, 123L, 124L, 3, 6, 0, 0x1180, 0x0, -1, 11,32,
125L, 126L, 127L, 3, 6, 2, 0x11A1, 0x0, -1, 16,1,
134L, 135L, 136L, 3, 6, 2, 0x1180, 0x0, -1, 12,1,
138L, 139L, 140L, 3, 6, 0, 0x1180, 0x0, -1, 2,5,
141L, 142L, 143L, 3, 6, 0, 0x1180, 0x0, -1, 5,8,
144L, 145L, 146L, 3, 6, 0, 0x1180, 0x0, -1, 6,9,
175L, 176L, 177L, 3, 6, 2, 0x1180, 0x0, -1, 25,1,
178L, 179L, 180L, 3, 6, 0, 0x1180, 0x0, -1, 16,30,
181L, 182L, 183L, 3, 6, 0, 0x1180, 0x0, -1, 16,30,
184L, 185L, 186L, 3, 6, 0, 0x1180, 0x0, -1, 16,30,
187L, 188L, 189L, 3, 6, 0, 0x1180, 0x0, -1, 16,30,
190L, 191L, 192L, 3, 6, 0, 0x1180, 0x0, -1, 16,30,
193L, 194L, 195L, 3, 6, 0, 0x1180, 0x0, -1, 16,30,
196L, 197L, 198L, 3, 6, 0, 0x1180, 0x0, -1, 16,30,
199L, 200L, 201L, 3, 6, 0, 0x1180, 0x0, -1, 16,30,
202L, 203L, 204L, 3, 6, 2, 0x11A1, 0x0, -1, 26,1,
226L, 227L, 228L, 3, 6, 0, 0x1180, 0x0, -1, 2,8,
229L, 230L, 231L, 3, 6, 0, 0x1180, 0x0, -1, 12,19};

OBJECT rs_object[] = {
-1, 1, 6, G_IBOX, NONE, NORMAL, 0x0L, 0,0, 90,25,
6, 2, 2, G_BOX, NONE, NORMAL, 0x1100L, 0,0, 90,513,
1, 3, 5, G_IBOX, NONE, NORMAL, 0x0L, 2,0, 18,769,
4, -1, -1, G_TITLE, NONE, NORMAL, 0x0L, 0,0, 6,769,
5, -1, -1, G_TITLE, NONE, NORMAL, 0x1L, 6,0, 6,769,
2, -1, -1, G_TITLE, NONE, NORMAL, 0x2L, 12,0, 6,769,
0, 7, 18, G_IBOX, NONE, NORMAL, 0x0L, 0,769, 80,19,
16, 8, 15, G_BOX, NONE, NORMAL, 0xFF1100L, 2,0, 20,8,
9, -1, -1, G_STRING, NONE, NORMAL, 0x3L, 0,0, 20,1,
10, -1, -1, G_STRING, NONE, DISABLED, 0x4L, 0,1, 20,1,
11, -1, -1, G_STRING, NONE, NORMAL, 0x5L, 0,2, 20,1,
12, -1, -1, G_STRING, NONE, NORMAL, 0x6L, 0,3, 20,1,
13, -1, -1, G_STRING, NONE, NORMAL, 0x7L, 0,4, 20,1,
14, -1, -1, G_STRING, NONE, NORMAL, 0x8L, 0,5, 20,1,
15, -1, -1, G_STRING, NONE, NORMAL, 0x9L, 0,6, 20,1,
7, -1, -1, G_STRING, NONE, NORMAL, 0xAL, 0,7, 20,1,
18, 17, 17, G_BOX, NONE, NORMAL, 0xFF1100L, 8,0, 13,1,
16, -1, -1, G_STRING, NONE, NORMAL, 0xBL, 0,0, 13,1,
6, 19, 29, G_BOX, NONE, NORMAL, 0xFF1100L, 14,0, 21,11,
20, -1, -1, G_STRING, NONE, NORMAL, 0xCL, 0,0, 21,1,
21, -1, -1, G_STRING, NONE, NORMAL, 0xDL, 0,1, 21,1,
22, -1, -1, G_STRING, NONE, DISABLED, 0xEL, 0,2, 21,1,
23, -1, -1, G_STRING, NONE, NORMAL, 0xFL, 0,3, 21,1,
24, -1, -1, G_STRING, NONE, NORMAL, 0x10L, 0,4, 21,1,
25, -1, -1, G_STRING, NONE, NORMAL, 0x11L, 0,6, 21,1,
26, -1, -1, G_STRING, NONE, NORMAL, 0x12L, 0,7, 21,1,
27, -1, -1, G_STRING, NONE, NORMAL, 0x13L, 0,8, 21,1,
28, -1, -1, G_STRING, NONE, DISABLED, 0x14L, 0,9, 21,1,
29, -1, -1, G_STRING, NONE, NORMAL, 0x15L, 0,10, 21,1,
18, -1, -1, G_STRING, LASTOB, DISABLED, 0x16L, 0,5, 21,1,
-1, 1, 6, G_BOX, NONE, OUTLINED, 0x21100L, 12,1538, 36,13,
2, -1, -1, G_STRING, NONE, NORMAL, 0x17L, 2,2, 31,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0x18L, 2,7, 32,1,
4, -1, -1, G_BUTTON, 0x7, NORMAL, 0x19L, 14,10, 8,1,
5, -1, -1, G_STRING, NONE, NORMAL, 0x1AL, 11,4, 14,1,
6, -1, -1, G_STRING, NONE, NORMAL, 0x1BL, 8,8, 20,1,
0, -1, -1, G_STRING, LASTOB, NORMAL, 0x1CL, 10,3, 15,1,
-1, 1, 18, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 40,16,
2, -1, -1, G_STRING, NONE, NORMAL, 0x1DL, 8,1, 24,1,
3, -1, -1, G_BUTTON, 0x11, NORMAL, 0x1EL, 1,3, 12,1,
4, -1, -1, G_BUTTON, 0x7, NORMAL, 0x1FL, 8,14, 8,1,
5, -1, -1, G_BUTTON, 0x5, NORMAL, 0x20L, 24,14, 8,1,
6, -1, -1, G_BUTTON, 0x11, NORMAL, 0x21L, 14,3, 12,1,
7, -1, -1, G_BUTTON, 0x11, NORMAL, 0x22L, 27,3, 12,1,
8, -1, -1, G_BUTTON, 0x11, NORMAL, 0x23L, 1,5, 12,1,
9, -1, -1, G_BUTTON, 0x11, NORMAL, 0x24L, 14,5, 12,1,
10, -1, -1, G_BUTTON, 0x11, NORMAL, 0x25L, 27,5, 12,1,
11, -1, -1, G_BUTTON, 0x11, NORMAL, 0x26L, 1,7, 12,1,
12, -1, -1, G_BUTTON, 0x11, NORMAL, 0x27L, 14,7, 12,1,
13, -1, -1, G_BUTTON, 0x11, NORMAL, 0x28L, 27,7, 12,1,
14, -1, -1, G_BUTTON, 0x11, NORMAL, 0x29L, 1,9, 12,1,
15, -1, -1, G_BUTTON, 0x11, NORMAL, 0x2AL, 14,9, 12,1,
16, -1, -1, G_BUTTON, 0x11, NORMAL, 0x2BL, 27,9, 12,1,
17, -1, -1, G_BUTTON, 0x11, NORMAL, 0x2CL, 1,11, 12,1,
18, -1, -1, G_BUTTON, 0x11, NORMAL, 0x2DL, 14,11, 12,1,
0, -1, -1, G_BUTTON, 0x31, NORMAL, 0x2EL, 27,11, 12,1,
-1, 1, 2, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 31,8,
2, -1, -1, G_STRING, NONE, NORMAL, 0x2FL, 4,2, 24,1,
0, -1, -1, G_STRING, LASTOB, NORMAL, 0x30L, 9,5, 13,1,
-1, 1, 17, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 38,16,
2, -1, -1, G_STRING, NONE, NORMAL, 0x31L, 4,2, 30,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0x32L, 10,4, 14,1,
5, 4, 4, G_BOX, NONE, NORMAL, 0x1100L, 25,4, 11,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0x33L, 1,0, 10,1,
7, 6, 6, G_BOX, NONE, NORMAL, 0x1100L, 5,6, 6,1,
5, -1, -1, G_STRING, NONE, NORMAL, 0x34L, 2,0, 4,1,
8, -1, -1, G_STRING, NONE, NORMAL, 0x35L, 11,6, 13,1,
10, 9, 9, G_BOX, NONE, NORMAL, 0x1100L, 25,6, 11,1,
8, -1, -1, G_STRING, NONE, NORMAL, 0x36L, 1,0, 10,1,
11, -1, -1, G_STRING, NONE, NORMAL, 0x37L, 2,8, 22,1,
13, 12, 12, G_BOX, NONE, NORMAL, 0x1100L, 25,8, 11,1,
11, -1, -1, G_STRING, NONE, NORMAL, 0x38L, 1,0, 10,1,
14, -1, -1, G_STRING, NONE, DISABLED, 0x39L, 1,10, 36,1,
15, -1, -1, G_STRING, NONE, NORMAL, 0x3AL, 2,11, 4,1,
16, -1, -1, G_STRING, NONE, NORMAL, 0x3BL, 6,12, 28,1,
17, -1, -1, G_STRING, NONE, NORMAL, 0x3CL, 6,13, 28,1,
0, -1, -1, G_STRING, LASTOB, NORMAL, 0x3DL, 6,14, 25,1,
-1, 1, 2, G_BOX, NONE, OUTLINED, 0xFFF163L, 0,1, 81,24,
2, -1, -1, G_BUTTON, 0x7, NORMAL, 0x3EL, 29,10, 23,5,
0, -1, -1, G_BUTTON, LASTOB, NORMAL, 0x3FL, 1558,261, 1059,259,
-1, 1, 2, G_BOX, NONE, OUTLINED, 0xFFF162L, 0,1, 81,24,
2, -1, -1, G_BUTTON, 0x7, NORMAL, 0x40L, 29,10, 23,5,
0, -1, -1, G_BUTTON, LASTOB, NORMAL, 0x41L, 1557,1540, 1061,1027,
-1, 1, 4, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 32,10,
2, -1, -1, G_STRING, NONE, NORMAL, 0x42L, 4,2, 25,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0x43L, 4,5, 26,1,
4, -1, -1, G_BUTTON, 0x17, NORMAL, 0x44L, 4,7, 8,1,
0, -1, -1, G_BUTTON, 0x35, NORMAL, 0x45L, 21,7, 8,1,
-1, 1, 5, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 32,13,
2, -1, -1, G_STRING, NONE, NORMAL, 0x46L, 4,1, 25,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0x47L, 4,5, 12,1,
4, -1, -1, G_BUTTON, 0x7, NORMAL, 0x48L, 5,10, 8,1,
5, -1, -1, G_BUTTON, 0x5, NORMAL, 0x49L, 20,10, 8,1,
0, 6, 7, G_BOX, NONE, NORMAL, 0x1100L, 18,4, 11,3,
7, -1, -1, G_BUTTON, 0x11, NORMAL, 0x4AL, 2,0, 8,1,
5, -1, -1, G_BUTTON, 0x31, SELECTED, 0x4BL, 2,2, 8,1,
-1, 1, 8, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 38,16,
2, -1, -1, G_STRING, NONE, NORMAL, 0x4CL, 7,1, 25,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0x4DL, 3,7, 6,1,
4, -1, -1, G_STRING, NONE, NORMAL, 0x4EL, 12,7, 10,1,
5, -1, -1, G_STRING, NONE, NORMAL, 0x4FL, 25,7, 11,1,
6, -1, -1, G_BUTTON, 0x5, NORMAL, 0x50L, 6,13, 8,1,
7, -1, -1, G_BUTTON, 0x7, NORMAL, 0x51L, 24,13, 8,1,
8, -1, -1, G_BOXTEXT, NONE, SHADOWED, 0x0L, 11,3, 17,2,
0, 9, 11, G_BOX, NONE, NORMAL, 0x1100L, 2,9, 35,1,
10, -1, -1, G_FTEXT, EDITABLE, NORMAL, 0x1L, 1,0, 4,1,
11, -1, -1, G_FTEXT, EDITABLE, NORMAL, 0x2L, 11,0, 7,1,
8, -1, -1, G_FTEXT, 0x28, NORMAL, 0x3L, 24,0, 8,1,
-1, 1, 4, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 33,14,
2, -1, -1, G_STRING, NONE, NORMAL, 0x5EL, 4,2, 25,1,
3, -1, -1, G_BUTTON, 0x7, NORMAL, 0x5FL, 3,5, 27,1,
4, -1, -1, G_BUTTON, 0x5, NORMAL, 0x60L, 3,8, 27,1,
0, -1, -1, G_BUTTON, 0x61, NORMAL, 0x61L, 3,11, 27,1,
-1, 1, 15, G_BOX, NONE, OUTLINED, 0x1100L, 0,0, 39,21,
2, -1, -1, G_BOXCHAR, 0x42, NORMAL, 0x5FF1100L, 0,0, 3,2,
3, -1, -1, G_BOXTEXT, NONE, NORMAL, 0x4L, 0,2, 39,2,
4, -1, -1, G_FTEXT, 0x41, NORMAL, 0x5L, 1,5, 32,1,
5, -1, -1, G_FTEXT, 0x41, NORMAL, 0x6L, 1,7, 32,1,
6, -1, -1, G_FTEXT, 0x41, NORMAL, 0x7L, 1,9, 32,1,
7, -1, -1, G_FTEXT, 0x41, NORMAL, 0x8L, 1,11, 32,1,
8, -1, -1, G_FTEXT, 0x41, NORMAL, 0x9L, 1,13, 32,1,
9, -1, -1, G_FTEXT, 0x41, NORMAL, 0xAL, 1,15, 32,1,
10, -1, -1, G_FTEXT, 0x41, NORMAL, 0xBL, 1,17, 32,1,
11, -1, -1, G_FTEXT, 0x41, NORMAL, 0xCL, 1,19, 32,1,
12, -1, -1, G_BOXTEXT, NONE, NORMAL, 0xDL, 3,0, 36,2,
13, -1, -1, G_BOXCHAR, TOUCHEXIT, NORMAL, 0x1FF1100L, 36,260, 3,2,
15, 14, 14, G_BOX, TOUCHEXIT, NORMAL, 0xFF1121L, 36,6, 3,13,
13, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1100L, 0,1, 3,2,
0, -1, -1, G_BOXCHAR, 0x60, NORMAL, 0x2FF1100L, 36,19, 3,2,
-1, 1, 9, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 38,16,
2, -1, -1, G_STRING, NONE, NORMAL, 0x80L, 7,1, 25,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0x81L, 3,7, 6,1,
4, -1, -1, G_STRING, NONE, NORMAL, 0x82L, 12,7, 10,1,
5, -1, -1, G_STRING, NONE, NORMAL, 0x83L, 25,7, 11,1,
6, -1, -1, G_BUTTON, 0x5, NORMAL, 0x84L, 3,13, 8,1,
7, -1, -1, G_BUTTON, 0x7, NORMAL, 0x85L, 28,13, 8,1,
8, -1, -1, G_BOXTEXT, NONE, SHADOWED, 0xEL, 11,3, 17,2,
9, -1, -1, G_BUTTON, 0x41, NORMAL, 0x89L, 15,13, 8,1,
0, 10, 12, G_BOX, NONE, NORMAL, 0x1100L, 2,9, 35,1,
11, -1, -1, G_FTEXT, EDITABLE, NORMAL, 0xFL, 1,0, 4,1,
12, -1, -1, G_FTEXT, EDITABLE, NORMAL, 0x10L, 11,0, 7,1,
9, -1, -1, G_FTEXT, 0x28, NORMAL, 0x11L, 24,0, 8,1,
-1, 1, 5, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 33,9,
2, -1, -1, G_STRING, NONE, NORMAL, 0x93L, 5,2, 9,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0x94L, 15,2, 1,1,
4, -1, -1, G_STRING, NONE, NORMAL, 0x95L, 17,2, 11,1,
5, -1, -1, G_STRING, NONE, NORMAL, 0x96L, 6,3, 21,1,
0, -1, -1, G_BUTTON, 0x27, NORMAL, 0x97L, 13,6, 8,1,
-1, 1, 7, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 36,11,
2, -1, -1, G_STRING, NONE, NORMAL, 0x98L, 7,1, 28,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0x99L, 11,2, 12,1,
4, -1, -1, G_BUTTON, 0x7, NORMAL, 0x9AL, 14,8, 8,1,
5, -1, -1, G_STRING, NONE, NORMAL, 0x9BL, 7,4, 27,1,
6, -1, -1, G_STRING, NONE, NORMAL, 0x9CL, 7,5, 24,1,
7, -1, -1, G_ICON, NONE, NORMAL, 0x0L, 1,1, 6,2,
0, -1, -1, G_STRING, LASTOB, NORMAL, 0x9EL, 7,2, 3,1,
-1, 1, 8, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 38,13,
2, -1, -1, G_STRING, NONE, NORMAL, 0x9FL, 8,1, 29,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0xA0L, 12,2, 12,1,
4, -1, -1, G_BUTTON, 0x7, NORMAL, 0xA1L, 15,10, 8,1,
5, -1, -1, G_STRING, NONE, NORMAL, 0xA2L, 8,4, 29,1,
6, -1, -1, G_STRING, NONE, NORMAL, 0xA3L, 8,5, 26,1,
7, -1, -1, G_ICON, NONE, NORMAL, 0x1L, 1,1, 6,2,
8, -1, -1, G_STRING, NONE, NORMAL, 0xA5L, 8,2, 3,1,
0, -1, -1, G_STRING, LASTOB, NORMAL, 0xA6L, 8,6, 10,1,
-1, 1, 2, G_BOX, NONE, OUTLINED, 0xFFF163L, 0,1, 81,24,
2, -1, -1, G_BUTTON, 0x7, NORMAL, 0xA7L, 29,10, 23,5,
0, -1, -1, G_BUTTON, LASTOB, NORMAL, 0xA8L, 1813,1796, 805,771,
-1, 1, 2, G_BOX, NONE, OUTLINED, 0xFFF162L, 0,1, 81,24,
2, -1, -1, G_BUTTON, 0x7, NORMAL, 0xA9L, 1305,10, 1309,2564,
0, -1, -1, G_BUTTON, LASTOB, NORMAL, 0xAAL, 1557,1540, 1061,515,
-1, 1, 2, G_BOX, NONE, OUTLINED, 0xFFF162L, 0,1, 81,24,
2, -1, -1, G_BUTTON, 0x7, NORMAL, 0xABL, 1561,10, 797,2564,
0, -1, -1, G_BUTTON, LASTOB, NORMAL, 0xACL, 1557,2308, 1061,515,
-1, 1, 2, G_BOX, NONE, OUTLINED, 0xFFF162L, 0,1, 81,24,
2, -1, -1, G_BUTTON, 0x7, NORMAL, 0xADL, 281,10, 1566,1284,
0, -1, -1, G_BUTTON, LASTOB, NORMAL, 0xAEL, 1557,2052, 1061,1283,
-1, 1, 15, G_BOX, NONE, OUTLINED, 0x1100L, 0,0, 36,20,
2, -1, -1, G_BOXCHAR, 0x42, NORMAL, 0x5FF1100L, 0,0, 2,1,
3, -1, -1, G_BOXTEXT, NONE, NORMAL, 0x12L, 0,1, 36,2,
4, -1, -1, G_FTEXT, NONE, NORMAL, 0x13L, 1,4, 29,1,
5, -1, -1, G_FTEXT, NONE, NORMAL, 0x14L, 1,6, 29,1,
6, -1, -1, G_FTEXT, NONE, NORMAL, 0x15L, 1,8, 29,1,
7, -1, -1, G_FTEXT, NONE, NORMAL, 0x16L, 1,10, 29,1,
8, -1, -1, G_FTEXT, NONE, NORMAL, 0x17L, 1,12, 29,1,
9, -1, -1, G_FTEXT, NONE, NORMAL, 0x18L, 1,14, 29,1,
10, -1, -1, G_FTEXT, NONE, NORMAL, 0x19L, 1,16, 29,1,
11, -1, -1, G_FTEXT, NONE, NORMAL, 0x1AL, 1,18, 29,1,
12, -1, -1, G_BOXTEXT, NONE, NORMAL, 0x1BL, 2,0, 34,1,
13, -1, -1, G_BOXCHAR, TOUCHEXIT, NORMAL, 0x1FF1100L, 34,3, 2,1,
15, 14, 14, G_BOX, TOUCHEXIT, NORMAL, 0xFF1121L, 34,4, 2,15,
13, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1100L, 0,1, 2,2,
0, -1, -1, G_BOXCHAR, 0x60, NORMAL, 0x2FF1100L, 34,19, 2,1,
-1, 1, 1, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 32,9,
0, -1, -1, G_STRING, LASTOB, NORMAL, 0xCDL, 6,4, 20,1,
-1, 1, 4, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 29,9,
2, -1, -1, G_STRING, NONE, NORMAL, 0xCEL, 9,1, 17,1,
3, -1, -1, G_BUTTON, 0x7, NORMAL, 0xCFL, 11,6, 8,1,
4, -1, -1, G_ICON, NONE, NORMAL, 0x2L, 1,1, 6,2,
0, -1, -1, G_STRING, LASTOB, NORMAL, 0xD1L, 9,2, 6,1,
-1, 1, 2, G_BOX, NONE, OUTLINED, 0xFFF163L, 0,1, 81,24,
2, -1, -1, G_BUTTON, 0x7, NORMAL, 0xD2L, 29,10, 23,5,
0, -1, -1, G_BUTTON, LASTOB, NORMAL, 0xD3L, 1814,5, 547,3842,
-1, 1, 2, G_BOX, NONE, OUTLINED, 0xFFF162L, 0,1, 81,24,
2, -1, -1, G_BUTTON, 0x7, NORMAL, 0xD4L, 29,10, 23,5,
0, -1, -1, G_BUTTON, LASTOB, NORMAL, 0xD5L, 279,1540, 1570,771,
-1, 1, 13, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 31,14,
2, -1, -1, G_STRING, NONE, NORMAL, 0xD6L, 2,4, 6,1,
3, -1, -1, G_STRING, NONE, NORMAL, 0xD7L, 2,6, 6,1,
4, -1, -1, G_STRING, NONE, NORMAL, 0xD8L, 2,8, 6,1,
5, -1, -1, G_STRING, NONE, NORMAL, 0xD9L, 5,2, 22,1,
6, -1, -1, G_BUTTON, 0x7, NORMAL, 0xDAL, 5,11, 8,1,
13, 7, 12, G_BOX, NONE, NORMAL, 0x1100L, 10,4, 19,5,
8, -1, -1, G_BUTTON, 0x11, NORMAL, 0xDBL, 0,0, 8,1,
9, -1, -1, G_BUTTON, 0x11, NORMAL, 0xDCL, 10,0, 8,1,
10, -1, -1, G_BUTTON, 0x11, NORMAL, 0xDDL, 10,2, 8,1,
11, -1, -1, G_BUTTON, 0x11, NORMAL, 0xDEL, 0,2, 8,1,
12, -1, -1, G_BUTTON, 0x11, NORMAL, 0xDFL, 0,4, 8,1,
6, -1, -1, G_BUTTON, 0x11, NORMAL, 0xE0L, 10,4, 8,1,
0, -1, -1, G_BUTTON, 0x25, NORMAL, 0xE1L, 19,11, 8,1,
-1, 1, 3, G_BOX, NONE, OUTLINED, 0x1100L, 0,0, 35,1,
2, -1, -1, G_FTEXT, EDITABLE, NORMAL, 0x1CL, 5,0, 7,1,
3, -1, -1, G_FTEXT, EDITABLE, NORMAL, 0x1DL, 17,0, 18,1,
0, -1, -1, G_STRING, LASTOB, NORMAL, 0xE8L, 0,0, 5,1};

LONG rs_trindex[] = {
0L,
30L,
37L,
56L,
59L,
77L,
80L,
83L,
88L,
96L,
108L,
113L,
129L,
142L,
148L,
156L,
165L,
168L,
171L,
174L,
177L,
193L,
195L,
200L,
203L,
206L,
220L};

struct foobar {
	WORD	dummy;
	WORD	*image;
	} rs_imdope[] = {
0, &IMAG0[0],
0, &IMAG1[0],
0, &IMAG2[0],
0, &IMAG3[0],
0, &IMAG4[0],
0, &IMAG5[0]};

#define NUM_STRINGS 264
#define NUM_FRSTR 31
#define NUM_IMAGES 6
#define NUM_BB 0
#define NUM_FRIMG 0
#define NUM_IB 3
#define NUM_TI 30
#define NUM_OBS 224
#define NUM_TREE 27

BYTE pname[] = "FHDX.RSC";.RSC";TLINED, 0xFFF162L, 0,1, 81,24,
2, -1, -1, G_BUTTON, 0x7, NORMAL, 0xDEL, 29,10, 23,5,
0, -1, -1, G_BUTTON, LASTOB, NORMAL, 0xDFL, 279,1540, 1570,771,
-1, 1, 10, G_BOX, NONE, OUTLINED, 0x21100L, 0,0, 31,13,
2, -1, -1, G_STRING, NONE, NORMAL, 0xE0L, 5,2, 22,1,
3, -1, -1, G_BUTTON, 0x7, NORMAL, 0xE1L, 5,10, 8,1,
4, -1, -1, G_BUTTON, 0x5, NORMAL, 0xE2L, 19,10, 8,1,
9, 5, 8, G_BOX, NONE, NORMAL, 0x1100L, 10,5, 18,3,
6, -1, -1, G_BUTTON, 0x11, NORMAL, 0xE3L, 0,0, 8,1,
7, -1, -1, G_BUTTON, 0x11, NORMAL, 0xE4L, 10,0, 8,1,
8, -1, -1, G_BUTTON, 0x11, NORMAL, 0xE5L, 10,2, 8,1,
4, -1, -1, G_BUTTON, 0x11, NORMAL, 0xE6L, 0,2, 8,1,
10, -1, -1, G_STRING, NONE, NORMAL, 0xE7L, 2,5, 6,1,
0, -1, -1, G_STRING, LASTOB, NORMAL, 0xE8L, 2,7, 6,1,
-1, 1, 3, G_BOX, NONE, OUTLINED, 0x1100L, 0,0, 35,1,
2, -1, -1, G_FTEXT, EDITABLE, NORMAL, 0x1CL, 5,0, 7,1,
3, -1, -1, G_FTEXT, EDITABLE, NORMAL, 0x1DL, 17,0, 18,1,
0, -1, -1, G_STRING, LASTOB, NORMAL, 0xEFL, 0,0, 5,1};

LONG rs_trindex[] = {
0L,
30L,
37L,
56L,
59L,
77L,
80L,
83L,
88L,
96L,
108L,
113L,
129L,
142L,
148L,
156L,
164L,
172L,
181L,
184L,
187L,
190L,
193L,
209L,
211L,
214L,
217L,
228L};

struct foobar {
	WORD	dummy;
	WORD	*image;
	} rs_imdope[] = {
0, &IMAG0[0],
0, &IMAG1[0],
0, &IMAG2[0],
0, &IMAG3[0],
0, &IMAG4[0],
0, &IMAG5[0],
0, &IMAG6[0],
0, &IMAG7[0]};

#define NUM_STRINGS 269
#define NUM_FRSTR 29
#define NUM_IMAGES 8
#define NUM_BB 0
#define NUM_FRIMG 0
#define NUM_IB 4
#define NUM_TI 30
#define NUM_OBS 232
#define NUM_TREE 28

BYTE pname[] = "FHDX.RSC";