#define T0OBJ 0
#define FREEBB 0
#define FREEIMG 0
#define FREESTR 42

BYTE *rs_strings[] = {
"01234567",
"",
"",
"01234567",
"",
"",
"01234567",
"",
"",
"01234567",
"",
"",
"01234567",
"",
"",
" *.CPX ",
"",
"",
"01234567",
"",
"",
"01234567",
"",
"",
"01234567",
"",
"",
"01234567",
"",
"",
"01234567",
"",
"",
" *.CPZ ",
"",
"",
"Reload",
"OK",
"Cancel",
"ABCDEFGHIJKLMNOPQ",
"_________________",
"ppppppppppppppppp"};

LONG rs_frstr[] = {
0};

BITBLK rs_bitblk[] = {
0};

LONG rs_frimg[] = {
0};

ICONBLK rs_iconblk[] = {
0};

TEDINFO rs_tedinfo[] = {
0L, 1L, 2L, 3, 6, 2, 0x1180, 0x0, -1, 9,1,
3L, 4L, 5L, 3, 6, 2, 0x1180, 0x0, -1, 9,1,
6L, 7L, 8L, 3, 6, 2, 0x1180, 0x0, -1, 9,1,
9L, 10L, 11L, 3, 6, 2, 0x1180, 0x0, -1, 9,1,
12L, 13L, 14L, 3, 6, 2, 0x1180, 0x0, -1, 9,1,
15L, 16L, 17L, 3, 6, 2, 0x11A1, 0x0, -1, 8,1,
18L, 19L, 20L, 3, 6, 2, 0x1180, 0x0, -1, 9,1,
21L, 22L, 23L, 3, 6, 2, 0x1180, 0x0, -1, 9,1,
24L, 25L, 26L, 3, 6, 2, 0x1180, 0x0, -1, 9,1,
27L, 28L, 29L, 3, 6, 2, 0x1180, 0x0, -1, 9,1,
30L, 31L, 32L, 3, 6, 2, 0x1180, 0x0, -1, 9,1,
33L, 34L, 35L, 3, 6, 2, 0x11A1, 0x0, -1, 8,1,
39L, 40L, 41L, 3, 6, 2, 0x1180, 0x0, -2, 18,18};

OBJECT rs_object[] = {
-1, 1, 26, G_BOX, NONE, NORMAL, 0xFF1141L, 0,0, 32,3849,
7, 2, 6, G_BOX, NONE, NORMAL, 0xFF1100L, 2,1281, 1546,5,
3, -1, -1, G_TEXT, TOUCHEXIT, NORMAL, 0x0L, 0,0, 1546,1,
4, -1, -1, G_TEXT, TOUCHEXIT, NORMAL, 0x1L, 0,1, 1546,1,
5, -1, -1, G_TEXT, TOUCHEXIT, NORMAL, 0x2L, 0,2, 1546,1,
6, -1, -1, G_TEXT, TOUCHEXIT, NORMAL, 0x3L, 0,3, 1546,1,
1, -1, -1, G_TEXT, TOUCHEXIT, NORMAL, 0x4L, 0,4, 1546,1,
8, -1, -1, G_BOXTEXT, NONE, NORMAL, 0x5L, 2,768, 525,257,
9, -1, -1, G_BOXCHAR, TOUCHEXIT, NORMAL, 0x1FF1100L, 1804,1281, 770,257,
10, -1, -1, G_BOXCHAR, TOUCHEXIT, NORMAL, 0x2FF1100L, 1804,1285, 770,1,
12, 11, 11, G_BOX, TOUCHEXIT, NORMAL, 0xFF1111L, 1804,1794, 770,3330,
10, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1100L, 0,0, 770,2305,
18, 13, 17, G_BOX, NONE, NORMAL, 0xFF1100L, 1552,1281, 1546,5,
14, -1, -1, G_TEXT, TOUCHEXIT, NORMAL, 0x6L, 0,0, 1546,1,
15, -1, -1, G_TEXT, TOUCHEXIT, NORMAL, 0x7L, 0,1, 1546,1,
16, -1, -1, G_TEXT, TOUCHEXIT, NORMAL, 0x8L, 0,2, 1546,1,
17, -1, -1, G_TEXT, TOUCHEXIT, NORMAL, 0x9L, 0,3, 1546,1,
12, -1, -1, G_TEXT, TOUCHEXIT, NORMAL, 0xAL, 0,4, 1546,1,
20, 19, 19, G_BOX, TOUCHEXIT, NORMAL, 0xFF1111L, 1307,1794, 770,3330,
18, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1100L, 0,0, 770,2305,
21, -1, -1, G_BOXCHAR, TOUCHEXIT, NORMAL, 0x1FF1100L, 1307,1281, 770,257,
22, -1, -1, G_BOXCHAR, TOUCHEXIT, NORMAL, 0x2FF1100L, 1307,1285, 770,1,
23, -1, -1, G_BOXTEXT, NONE, NORMAL, 0xBL, 1552,768, 525,257,
24, -1, -1, G_BUTTON, 0x47, NORMAL, 0x24L, 1,1544, 1033,1,
25, -1, -1, G_BUTTON, 0x45, NORMAL, 0x25L, 780,1544, 8,1,
26, -1, -1, G_BUTTON, 0x45, NORMAL, 0x26L, 1046,1544, 8,1,
0, -1, -1, G_FBOXTEXT, 0x65, NORMAL, 0xCL, 2,2822, 284,513};

LONG rs_trindex[] = {
0L};

struct foobar {
	WORD	dummy;
	WORD	*image;
	} rs_imdope[] = {
0};

#define NUM_STRINGS 42
#define NUM_FRSTR 0
#define NUM_IMAGES 0
#define NUM_BB 0
#define NUM_FRIMG 0
#define NUM_IB 0
#define NUM_TI 13
#define NUM_OBS 27
#define NUM_TREE 1

BYTE pname[] = "MOVE.RSC";