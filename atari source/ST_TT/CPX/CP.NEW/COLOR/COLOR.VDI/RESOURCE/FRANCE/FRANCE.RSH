#define T0OBJ 0
#define FREEBB 0
#define FREEIMG 0
#define FREESTR 51

BYTE *rs_strings[] = {
"Couleur",
"",
"",
"",
"",
"",
"000",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"0000",
"",
"",
"0000",
"",
"",
"0000",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"",
"R�init.",
"",
"",
"Sauve",
"",
"",
"Confirmer",
"",
"",
"Annuler",
"",
""};

LONG rs_frstr[] = {
0};

BITBLK rs_bitblk[] = {
0};

LONG rs_frimg[] = {
0};

ICONBLK rs_iconblk[] = {
0};

TEDINFO rs_tedinfo[] = {
0L, 1L, 2L, 3, 6, 2, 0x1180, 0x0, -1, 8,1,
3L, 4L, 5L, 3, 6, 2, 0x1180, 0x0, -1, 2,1,
6L, 7L, 8L, 3, 6, 2, 0x1180, 0x0, -1, 4,1,
9L, 10L, 11L, 3, 6, 2, 0x1180, 0x0, -1, 2,1,
12L, 13L, 14L, 3, 6, 2, 0x1180, 0x0, -1, 2,1,
15L, 16L, 17L, 3, 6, 2, 0x1180, 0x0, -1, 2,1,
18L, 19L, 20L, 3, 6, 2, 0x1180, 0x0, -1, 2,1,
21L, 22L, 23L, 3, 6, 2, 0x1180, 0x0, -1, 5,1,
24L, 25L, 26L, 3, 6, 2, 0x1180, 0x0, -1, 5,1,
27L, 28L, 29L, 3, 6, 2, 0x1180, 0x0, -1, 5,1,
30L, 31L, 32L, 3, 6, 2, 0x1180, 0x0, -1, 2,1,
33L, 34L, 35L, 3, 6, 2, 0x1180, 0x0, -1, 2,1,
36L, 37L, 38L, 3, 6, 2, 0x1180, 0x0, -1, 2,1,
39L, 40L, 41L, 3, 6, 2, 0x1180, 0x0, -1, 8,1,
42L, 43L, 44L, 3, 6, 2, 0x1180, 0x0, -1, 6,1,
45L, 46L, 47L, 3, 6, 2, 0x1180, 0x0, -2, 10,1,
48L, 49L, 50L, 3, 6, 2, 0x1180, 0x0, -1, 8,1};

OBJECT rs_object[] = {
-1, 1, 49, G_BOX, NONE, NORMAL, 0x1121L, 12,1538, 32,11,
49, 2, 33, G_BOX, NONE, NORMAL, 0xFF1101L, 256,0, 1567,1545,
33, 3, 28, G_BOX, NONE, NORMAL, 0xFF1100L, 0,256, 1553,1289,
4, -1, -1, G_BOXTEXT, NONE, NORMAL, 0x0L, 0,0, 1553,1,
21, 5, 20, G_BOX, HIDETREE, NORMAL, 0xFF1100L, 1027,257, 14,1032,
6, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1170L, 1280,1792, 1026,2049,
7, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1171L, 4,1792, 1026,2049,
8, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1172L, 775,1792, 1026,2049,
9, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1173L, 1546,1792, 1026,2049,
10, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1174L, 1280,1538, 1026,2049,
11, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1175L, 4,1538, 1026,2049,
12, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1176L, 775,1538, 1026,2049,
13, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1177L, 1546,1538, 1026,2049,
14, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1178L, 1280,1284, 1026,2049,
15, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1179L, 4,1284, 1026,2049,
16, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF117AL, 775,1284, 1026,2049,
17, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF117BL, 1546,1284, 1026,2049,
18, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF117CL, 1280,1030, 1026,2049,
19, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF117DL, 4,1030, 1026,2049,
20, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF117EL, 775,1030, 1026,2049,
4, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF117FL, 1546,1030, 1026,2049,
22, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x1L, 0,257, 771,257,
24, 23, 23, G_BOX, TOUCHEXIT, NORMAL, 0xFF1111L, 0,514, 771,262,
22, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x2L, 0,0, 771,1,
25, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x3L, 0,1032, 771,1,
28, 26, 27, G_BOX, HIDETREE, NORMAL, 0xFF1100L, 1027,257, 526,1032,
27, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1170L, 1,1538, 261,1795,
25, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1171L, 1543,1538, 261,1795,
2, 29, 32, G_BOX, HIDETREE, NORMAL, 0xFF1100L, 1027,257, 526,1032,
30, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1170L, 769,1537, 5,1026,
31, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1171L, 1799,1537, 5,1026,
32, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1172L, 769,2564, 5,1026,
28, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1173L, 1799,2564, 5,1026,
1, 34, 48, G_BOX, NONE, NORMAL, 0xFF1100L, 1297,256, 270,1289,
35, -1, -1, G_BOXCHAR, NONE, NORMAL, 0x52FF1100L, 256,0, 1028,1,
36, -1, -1, G_BOXCHAR, NONE, NORMAL, 0x56FF1100L, 1796,0, 1028,1,
37, -1, -1, G_BOXCHAR, NONE, NORMAL, 0x42FF1100L, 1289,0, 1028,1,
38, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x4L, 256,257, 1028,1,
39, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x5L, 1796,257, 1028,1,
40, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x6L, 1289,257, 1028,1,
42, 41, 41, G_BOX, TOUCHEXIT, NORMAL, 0xFF1111L, 256,514, 1028,518,
40, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x7L, 0,0, 1028,1,
44, 43, 43, G_BOX, TOUCHEXIT, NORMAL, 0xFF1111L, 1796,514, 1028,518,
42, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x8L, 0,0, 1028,1,
46, 45, 45, G_BOX, TOUCHEXIT, NORMAL, 0xFF1111L, 1289,514, 1028,518,
44, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x9L, 0,0, 1028,1,
47, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0xAL, 256,1032, 1028,1,
48, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0xBL, 1796,1032, 1028,1,
33, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0xCL, 1289,1032, 1028,1,
0, 50, 54, G_BOX, NONE, NORMAL, 0xFF1100L, 256,1545, 1567,2561,
52, 51, 51, G_BOX, NONE, NORMAL, 0xFF1100L, 536,0, 1031,2561,
50, -1, -1, G_BOXTEXT, 0x5, NORMAL, 0xDL, 512,1280, 7,1,
53, -1, -1, G_BOXTEXT, 0x5, NORMAL, 0xEL, 512,1280, 1541,1,
54, -1, -1, G_BOXTEXT, 0x7, NORMAL, 0xFL, 1542,1280, 9,1,
49, -1, -1, G_BOXTEXT, 0x25, NORMAL, 0x10L, 784,1280, 775,1};

LONG rs_trindex[] = {
0L};

struct foobar {
	WORD	dummy;
	WORD	*image;
	} rs_imdope[] = {
0};

#define NUM_STRINGS 51
#define NUM_FRSTR 0
#define NUM_IMAGES 0
#define NUM_BB 0
#define NUM_FRIMG 0
#define NUM_IB 0
#define NUM_TI 17
#define NUM_OBS 55
#define NUM_TREE 1

BYTE pname[] = "FRANCE.RSC"; NUM_IB 0
#define NUM_TI 17
#define NUM_OBS 57
#define NUM_TREE 1

BYTE pname[] = "USA.RSC";C";1283,2564,
54, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0xFL, 0,2563, 1283,1,
57, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x10L, 1031,3334, 1283,1,
59, 58, 58, G_BOX, TOUCHEXIT, NORMAL, 0xFF1111L, 256,514, 771,2564,
57, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x11L, 0,2563, 771,1,
60, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x12L, 256,3334, 771,1,
45, -1, -1, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x13L, 256,257, 771,1,
0, 62, 65, G_BOX, NONE, NORMAL, 0xFF1100L, 256,1545, 1567,2561,
63, -1, -1, G_BOXTEXT, 0x5, NORMAL, 0x14L, 1280,1280, 262,1,
64, -1, -1, G_BOXTEXT, 0x7, NORMAL, 0x15L, 1543,1280, 775,1,
65, -1, -1, G_BOXTEXT, 0x5, NORMAL, 0x16L, 272,1280, 775,1,
61, 66, 66, G_BOX, NONE, NORMAL, 0xFF1100L, 536,0, 1031,2561,
65, -1, -1, G_BOXTEXT, 0x25, NORMAL, 0x17L, 768,1280, 1542,1};

LONG rs_trindex[] = {
0L};

struct foobar {
	WORD	dummy;
	WORD	*image;
	} rs_imdope[] = {
0};

#define NUM_STRINGS 72
#define NUM_FRSTR 0
#define NUM_IMAGES 0
#define NUM_BB 0
#define NUM_FRIMG 0
#define NUM_IB 0
#define NUM_TI 24
#define NUM_OBS 67
#define NUM_TREE 1

BYTE pname[] = "USA.RSC";SA.RSC";