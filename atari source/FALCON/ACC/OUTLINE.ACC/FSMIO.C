/* FILE: FSMIO.C
 * ====================================================================
 * Handles the disk I/O for the FONTS DA
 *
 * DATE CREATED: January 4, 1990  k. soohoo
 *		 December 7, 1992 c.gee - Still not shipped...
 *		 December 15, 1992 Remove Bitmap and Devices
 *		 January  18, 1993 Added Character Set ID
 *		 January  22, 1993 Writing out extend.sys
 *				   Write out proper date for countries...
 */


/* INCLUDE FILES
 * ====================================================================
 */
#include <sys\gemskel.h>
 
#include "country.h" 
#include "fonthead.h"
#include "text.h"
#include "extend.h"
#include "spdhead.h"
#include "front.h"



/* DEFINES
 * ====================================================================
 */
#define ACTIVE	    0
#define INACTIVE    1




/* Structure to store the global variables required for EXTEND.SYS */
typedef struct fsm
{
   char FontPath[ 128 ];	/* Font Directory Path             */
   long SpeedoCacheSize;	/* Speedo Cache Size		   */
   long BitMapCacheSize;	/* BITmap Cache Size		   */
   int  speedo_percent;		/* Percentage (1-9) for fsm cache  */
   int  Width;			/* Width Tables?		   */
   int  point_size[ MAX_POINTS ]; /* Point Sizes of Current font  */
}XFSM;



/* PROTOTYPES
 * ====================================================================
 */
void 	GetExtendSysPath( void );

char	GetBaseDrive( void );
long	GetBootDrive( void );

#if 0
char	*extract_path( int *offset, int max );
int     kisspace( char thing );
#endif

void 	read_fonts( int flag, int flag2 );

void	ReadOutlineFonts( int flag );
void	ReadUnUsedOutlineFonts( void );
FON_PTR get_single_fsm_font( char *fontname );

void	free_arena_links( void );
void	free_all_fonts( void );

FON_PTR another_font( int flag );
void	Delete_Font( FON_PTR nodeptr );
FON_PTR find_font_in_arena( char *userstring, char *extension );
int	build_list( FON_PTR *top_list, FON_PTR *top_last, int type );
void 	alpha_font_add( FON_PTR *top_list, FON_PTR *top_last, FON_PTR font);

#if 0
int	build_specific_list( FON_PTR *top_list, FON_PTR *top_last, int type );
#endif

int	CountFonts( FON_PTR head_list, int flag );
int	CountSelectedFonts( FON_PTR head_list, int flag );


void	set_font_pts( FON_PTR font, char points[]);
void	CheckForDefaultPointSizes( void );

long	GetFontMin( void );
long	GetCharMin( void );


int	fast_write_extend( void );
int 	write_extend( void );
void	write_pointsizes( FON_PTR font, int new_extend);




/* EXTERNS
 * ====================================================================
 */


/* GLOBALS
 * ====================================================================
 */
DTA *olddma, newdma;		    /* DTA buffers for _our_ searches */
char *bufptr;			    /* ptr to malloc'ed memory...     */
long BufferSize;		    /* Size of ASSIGN.SYS/EXTEND.SYS  */
char baddata[80];		    /* String area for form_alerts.  */
char line_buf[80];

char ExtendPath[20];		    /* Path of EXTEND.SYS	      */
char OldExtendPath[20];	    	    /* Path of EXTEND.OLD	      */
char OutlinePath[128];		    /* Path of Outline Fonts	      */

int  outline_found;		    /* TRUE for found paths to outline*/
int  alen;			    /* # bytes we read 		      */
int  BootDrive;	  		    /* Boot Device - 'A' or 'C' */
char SearchPath[128];		    /* TempSearchStrings        */
char TempPath[128];		    /* TempSearchStrings	*/

FON     font_arena[ MAX_FONTS ];         /* We use a static arena         */
int     free_font[ MAX_FONTS ];	         /* Keeps track of what's open    */
int     font_counter = 0;	         /* # of fonts loaded available   */
int     available_count, installed_count;/* # of active/inactive fonts    */
FON_PTR available_list, installed_list;  /* Linked list pointers to the   */
FON_PTR available_last, installed_last;  /* active/inactive fonts.        */
int     Fonts_Loaded;			 /* Unused Fonts Loaded or not... */

XFSM Current;			/* Current EXTEND.SYS variables */
XFSM Backup;			/* Backup EXTEND.SYS variables  */



/* FUNCTIONS
 * ====================================================================
 */
 


/* GetExtendSysPath()
 * ====================================================================
 * Get the font path from the EXTEND.SYS
 * If there is NO EXTEND.SYS, we substitute C: or A: instead.
 *
 */
void 
GetExtendSysPath( void )
{
	char *fname;
	int  status;

	/* Get the Path to the EXTEND.SYS, EXTEND.OLD and the Outline path*/
	strcpy( ExtendPath, "C:\\EXTEND.SYS" );
	strcpy( OldExtendPath, "C:\\EXTEND.OLD" );
	strcpy( OutlinePath, "C:" );
	ExtendPath[0] = OldExtendPath[0] = OutlinePath[0] = GetBaseDrive();
	status = GetSYSPath( ExtendPath, &OutlinePath[0] );
	outline_found = (( status ) ? ( FALSE ) : ( TRUE ) );
	
	/* Convert to Upper Case */
	fname = &OutlinePath[0];
	fname = strupr( fname );
}




/* GetBaseDrive()
 * ====================================================================
 * Get the A drive or C drive for the ASSIGN.SYS and EXTEND.SYS
 * based upon the boot drive.
 */
char
GetBaseDrive( void )
{
    char Drive;

    Supexec( GetBootDrive );
    Drive = BootDrive + 'A';    
    return( Drive );
}



/* GetBootDrive()
 * ====================================================================
 */
long
GetBootDrive( void )
{
   int *ptr;
   
   ptr = ( int *)0x446L;
   BootDrive = *ptr;
   return( 0L );
}
 

#if 0 
/* extract_path()
 * ====================================================================
 *  Given an index into bufptr, immediately following the keyword that
 *  indicates a path follows, will extract a pointer to the path and
 *  return it.
 */
char
*extract_path( int *offset, int max )
{
	int j;

	/* Goes looking for the start of the path */
	while ( ( bufptr[ *offset ] != '=' ) && ( *offset < max ) )
	{
	  *offset += 1;
	}
	
	*offset += 1;
	while ( ( kisspace(bufptr[*offset])) && ( *offset < max) )
	{
	  *offset += 1;
	}

	/* Properly null terminates the path */
	j = *offset;
	while ((bufptr[j] != '\n') && (j < (max - 1)) && (bufptr[j] != '\r')) {++j;}
	bufptr[j] = '\0';

	return ( &bufptr[*offset] );
}


/* kisspace()
 * ====================================================================
 */
int 
kisspace( char thing )
{
	if ((thing == ' ') || (thing == '\t')) return TRUE;
	else return FALSE;
}
 
#endif

 
/* read_fonts()
 * ====================================================================
 * Reads in the OUtline fronts and inserts them into the list.
 * NOTE: We are reading in only the fonts used in the
 * EXTEND.SYS unless otherwise noted.
 * flag == 0 -> read in only the extend.sys
 * flag == 1 -> read in the unused fonts.
 *
 * flag2 == 0 -> read in the extend.sys file and don't preserve Current.
 * flag2 == 1 -> read in the extend.sys file and preserve the Current.
 * Only when the flag is set do we read in ALL of the fonts.
 * Returns a 0 on file error.
 */
void 
read_fonts( int flag, int flag2 )
{
	/* READ the EXTEND.SYS fonts...*/
        if( !flag )
        {
	   free_all_fonts();
	   ReadOutlineFonts( flag2 );
	   CheckForDefaultPointSizes();
	   Fonts_Loaded = FALSE;
	}
	else
	{
	   /* Clear the linked list pointers */
	   free_arena_links();

	   /* READ the UNUSED OUTLINE FONTS */
	   ReadUnUsedOutlineFonts();
 	   Fonts_Loaded = TRUE;
	}  
	
	/* Create 2 linked lists from the static array -
	 * One is the Installed Fonts linked list.
	 * and the other is the Available Fonts linked list.
	 */
	installed_count = build_list( &installed_list, &installed_last, ACTIVE );
	available_count = build_list( &available_list, &available_last, INACTIVE );
}



/* --------------------------------------------------------------------
 * OUTLINE FONT SECTION
 * ====================================================================
 */



/* ReadOutlineFonts()
 * ====================================================================
 * Read in the outline fonts fromthe extend.sys
 * flag == 0 read in and init the Current variables.
 * flag == 1 read in the fonts fromthe extend.sys only.
 *	     Do not touch the Current Variables.
 */
void
ReadOutlineFonts( int flag )
{
	parse_extend( flag );
}





/* ReadUnUsedOutlineFonts()
 * ====================================================================
 */
void
ReadUnUsedOutlineFonts( void )
{
	int     fd, i, error;
	char    nlen;
	FON_PTR temp_fon;
        SPDHDR  Header;

	olddma = Fgetdta();	
	Fsetdta( &newdma );		/* Point to OUR buffer */

	sprintf( SearchPath, "%s\\%s", OutlinePath, "*.SPD" );
	error = Fsfirst( SearchPath, 0 );/* Normal file search for 1st file */
	if( error != E_OK )	/* No such files! */
	{
	   Fsetdta( olddma );	/* Point to OLD buffer */
	   return;		
	}

	do
	{
	   temp_fon = another_font( SPD_FONT );
	   if (temp_fon == (FON_PTR) NULL)
	   {
	     Fsetdta(olddma);	/* Point to OLD buffer */
	     return;
	   }
		
	   sprintf( FFNAME( temp_fon ),"%s", (char *)newdma.d_fname );
	   sprintf( TempPath,"%s\\%s", OutlinePath, FFNAME( temp_fon ) );
	   fd = Fopen( TempPath, 0 );/* Open the file */

	   if( fd < 0 )	/* Bad open */
	   {
#if 0	   
	     sprintf( baddata, alert6, FFNAME( temp_fon ) );
/*	     form_alert( 1, baddata );   */
#endif
             Delete_Font( temp_fon );
	     goto recover;
	   }

           if( Fread( fd, sizeof( SPDHDR ), &Header ) < 0 )
           {
	      Fclose( fd );
	      goto recover;
           }

	   FONTID( temp_fon ) = Header.FontID;
	   strncpy( FCHARSET( temp_fon ), &Header.CharSetID, 2 );
	   
	   FBUFF_SIZE( temp_fon ) = Header.MinFontBuffSize;
	   CBUFF_SIZE( temp_fon ) = Header.MinCharBuffSize;

	   strncpy( FNAME( temp_fon ), &Header.FontFullName[0], FRONT_LENGTH );
	   nlen = strlen( FNAME( temp_fon ) );
	   for( i = ( int )nlen; i < FRONT_LENGTH; ++i )
	        FNAME(temp_fon)[i] = ' ';
	   FNAME( temp_fon )[FRONT_LENGTH] = '\0';

	   SEL( temp_fon ) = FALSE;
	   for( i = 0; i < MAX_POINTS; ++i )
	      POINTS( temp_fon )[i] = (int)NULL;
	   POINTS( temp_fon )[0] = 10;	/* Default point sizes for InActiveFonts */

	   Fclose( fd );
	   /* Make sure the font hasn't already been loaded. */
	   if( find_font_in_arena( FFNAME( temp_fon ), ".SPD" ))
	   {
	     Delete_Font( temp_fon );
	     goto recover;
	   }  
	   font_counter++;		/* increment # of fonts available*/
recover:;

	} while( Fsnext() == E_OK );
	Fsetdta( olddma );	/* Point to OLD buffer */
}




/* get_single_fsm_font()
 * ====================================================================
 * Reads the FSM fonts into the arena and alphabetizes them.
 * RETURNS: Pointer to font in font list.
 *          NULL otherwise.
 */
FON_PTR
get_single_fsm_font( char *fontname )
{
	int     fd, i, error;
	char    nlen;
	FON_PTR temp_fon;
        SPDHDR  Header;

	olddma = Fgetdta();	
	Fsetdta( &newdma );		/* Point to OUR buffer */

	sprintf( SearchPath, "%s\\%s%s", OutlinePath, fontname, ".SPD" );
	error = Fsfirst( SearchPath, 0 );/* Normal file search for 1st file */
	if( error != E_OK )	/* No such files! */
	{
	   Fsetdta( olddma );	/* Point to OLD buffer */
	   return( ( FON_PTR )NULL );		
	}
	
        /* Try to get a slot within the font list.
         * return if the place is full. NO VACANCY
         */ 
	temp_fon = another_font( SPD_FONT );
	if (temp_fon == (FON_PTR)NULL)
	{
	  Fsetdta(olddma);	/* Point to OLD buffer */
	  return( ( FON_PTR )NULL );
	}
	fd = Fopen( SearchPath, 0 );/* Open the file */

	if( fd < 0 )	/* Bad open */
	{
	  goto recover;
	}


        if( Fread( fd, sizeof( SPDHDR ), &Header ) < 0 )
        {
	   Fclose( fd );
	   goto recover;
        }
        
        sprintf( FFNAME( temp_fon ),"%s", (char *)newdma.d_fname );
	FONTID( temp_fon ) = Header.FontID;
        strncpy( FCHARSET( temp_fon ), &Header.CharSetID, 2 );

	FBUFF_SIZE( temp_fon ) = Header.MinFontBuffSize;
	CBUFF_SIZE( temp_fon ) = Header.MinCharBuffSize;

	strncpy( FNAME( temp_fon ), &Header.FontFullName[0], FRONT_LENGTH );
	nlen = strlen( FNAME( temp_fon ) );
	for( i = ( int )nlen; i < FRONT_LENGTH; ++i )
	   FNAME(temp_fon)[i] = ' ';
	FNAME( temp_fon )[FRONT_LENGTH] = '\0';

        /* Initialize the Point Sizes nothingness...*/
	for( i = 0; i < MAX_POINTS; ++i )
	   POINTS( temp_fon )[i] = (int)NULL;
	Fclose( fd );

	/* Check if the font already is installed.*/
	if( find_font_in_arena( FFNAME( temp_fon ), ".SPD" ))
	     goto recover;

	SEL( temp_fon ) = TRUE;		/* Set to INSTALLED */
	font_counter++;			/* increment# of fonts available*/  

	Fsetdta( olddma );	/* Point to OLD buffer */
	return( temp_fon );

recover:;/* Problem with reading the file...*/
/*	form_alert( 1, baddata );*/
        Delete_Font( temp_fon );
	Fsetdta( olddma );	/* Point to OLD buffer */
	return( ( FON_PTR )NULL );
}




/* --------------------------------------------------------------------
 * FONT HANDLING SECTION
 * ====================================================================
 */

/* free_arena_links()
 * ====================================================================
 * Free up the linked list pointers in the font arena.
 * Used when we move fonts between installed and available.
 */
void
free_arena_links( void )
{
   FON_PTR curptr;
   int i;
      
   for( i = 0; i < MAX_FONTS; i++ )
   {
       curptr = &font_arena[i];
       FNEXT( curptr ) = FPREV( curptr ) = ( FON_PTR )NULL;
       AFLAG( curptr ) = SFLAG( curptr ) = FALSE;
   }
   installed_list = installed_last = ( FON_PTR )NULL;
   available_list = available_last = ( FON_PTR )NULL;
   installed_count = available_count = 0;
}



/* free_all_fonts()
 * ====================================================================
 * Responsible for resetting all the font parameters to something
 * normal, as well as freeing up all the arena space it's been using.
 * Caller is responsible for re-calling the font reading routines.
 */
void
free_all_fonts( void )
{
	int i;
	FON_PTR curptr;
		
	for (i = 0; i < MAX_FONTS; ++i)
	{
	   /* Free arena space */
	   if( !free_font[i] )
		free_font[i] = TRUE;
	   curptr = &font_arena[i];
/* NOTE - this is not a complete wipe */	   
	   FNEXT( curptr ) = FPREV( curptr ) = ( FON_PTR )NULL;	
	}

	available_list  = ( FON_PTR )NULL;
	available_last  = ( FON_PTR )NULL;
	available_count = 0;

	installed_list  = ( FON_PTR )NULL;
	installed_last  = ( FON_PTR )NULL;
	installed_count = 0;

	font_counter    = 0;
}



/* another_font()
 * ====================================================================
 */
FON_PTR
another_font( int flag )
{
 
	FON_PTR newfont;
	int i;

	/* If there are way too many fonts...*/
	if( font_counter >= MAX_FONTS )
	    return( ( FON_PTR )NULL );

	/* Go looking for an open space in the arena */
	i= 0;
	while( ( i < MAX_FONTS) && ( !free_font[i]) ) { ++i; }
	free_font[i] = FALSE;

	newfont = &font_arena[i];
	FTYPE(newfont)   = flag; /* SPEEDO */
	AFLAG( newfont ) = SFLAG( newfont ) = FALSE;
	FNEXT( newfont ) = FPREV( newfont ) = ( FON_PTR )NULL;
	SEL( newfont )   = FALSE;
	return( newfont );
}





#if 0
/* alpha_bit_add()
 * ====================================================================
 *  Add a font name into the Bitmap font list alphabetically, using strcmp to
 *  determine where the font should be added.
 */
void 
alpha_bit_add( FON_PTR font )
{
        FON_PTR current = available_list;
        
	if( current == ( FON_PTR )NULL )	/* Add to bare list */
	{
	  available_list      = font;
	  available_last      = font;
	  FNEXT( font ) = ( FON_PTR )NULL;
	  FPREV( font ) = ( FON_PTR )NULL;
	  return;
	}
 
	while( current != ( FON_PTR )NULL )
	  current = FNEXT( current );	/* Advance */

	if( current == ( FON_PTR )NULL ) /* Add as last */
	{
	  FNEXT( available_last ) = font;
	  FPREV( font )     = available_last;
	  FNEXT( font )     = ( FON_PTR )NULL;
	  available_last    = font;
	  return;
	}
}
#endif



/* Delete_Font()
 * ====================================================================
 * Delete a font simply by removing it from the active list.
 * THIS is ONLY used when we are reading in the fonts from the
 * SYS files.
 */
void
Delete_Font( FON_PTR nodeptr )
{
   int i;
   FON_PTR ptr;

   for( i = 0; i < MAX_FONTS; i++ )
   {
       ptr = &font_arena[i];
       if( nodeptr == ptr )
       {
           free_font[ i ] = TRUE;	/* make it not in use. */
           break;
       }
   }
}



/* find_font_in_arena()
 * ====================================================================
 *  Given the user's string, attempt to match it to an existing font.
 *  If matched successfully, return a pointer to the font's structure.
 * NOTE: Used only when reading in the SYS files.
 * This compares it by going through the arena, not the linked list.
 * NULL - IT is a Font, but its not in the list.
 * -1   - It is NOT a font
 */
FON_PTR 
find_font_in_arena( char *userstring, char *extension )
{
	FON_PTR search;
	int i, comp;
	char *ptr;
	char no_ext[15];

	/* copies 12 characters from the user's string into
	 * the local buffer. Finds the .FNT extension and
	 * and puts a null there. If it DOESN't find a .FNT,
	 * put a NULL at the beginning of the string.
	 */
	 for( i = 0; i < 12; i++ )
	    no_ext[i] = userstring[i];
	 no_ext[12] = '\0';
	 ptr = strstr( no_ext, extension );

	 if( !ptr )
	 {
	    no_ext[0] = '\0';
	    return( ( FON_PTR )NIL );
	 }   
	 else
	 {
	    ptr += 4; /* gets us to the end */
	    *ptr = '\0';
	 }
	    
	 
	/* Run through the bitmap fonts list and find the font
	   we've just been passed.  If the font name is ever bigger
	   than the current search name, we have gone too far!
	 */
	 
	for( i = 0; i < font_counter; ++i )
	{
	   if( !free_font[i] )
	   {	   
	     search = &font_arena[i];
	     comp = strcmp(  no_ext, FFNAME( search ) );
	     if( comp == 0 )
	     {
	        return( ( FON_PTR )search );
	     }
	   }  
	}
	return( FON_PTR )NULL;
}





/* build_list()
 * ====================================================================
 * Build the active or inactive linked list depending on whether
 * we're lookig for Active Fonts or Inactive Fonts.
 * IN: type == ACTIVE | INACTIVE
 * OUT: return a count of the # of that type font found.
 */
int
build_list( FON_PTR *top_list, FON_PTR *top_last, int type )
{
   FON_PTR  curptr;
   int      i     = 0;
   int	    count = 0;
   
   i = 0;
   *top_list = ( FON_PTR )NULL;
   *top_last = ( FON_PTR )NULL;
   
   while ((i < MAX_FONTS) && (!free_font[i]))
   {
       curptr = &font_arena[i];
   
       /* Look for ACTIVE Fonts and SEL() == TRUE
        *                   OR
        * Look for INACTIVE Fonts and !SEL()
        */
       if( ( ( type == ACTIVE ) && ( SEL( curptr ) ) ) ||
           ( ( type == INACTIVE ) && ( !SEL( curptr ) ) )
         )
       {
       	     /* Clear the SELECTED in the dialog box flag */
	     alpha_font_add( top_list, top_last, curptr );
	     count++;
       }
       i++;   
   }
   return( count );
}




/* alpha_font_add()
 * ====================================================================
 *  Add a font name into the FSM font list alphabetically, using strcmp to
 *  determine where the font should be added.
 */
void 
alpha_font_add( FON_PTR *top_list, FON_PTR *top_last, FON_PTR font)
{
	FON_PTR current = *top_list;
	FON_PTR temp;
		
	if( current == ( FON_PTR )NULL )  /* Add to bare list */
	{
	   *top_list   = font;
	   *top_last   = font;
	   FNEXT(font) = (FON_PTR )NULL;
	   FPREV(font) = (FON_PTR )NULL;
	   return;
	}

	while( ( current != ( FON_PTR )NULL ) &&
	       ( strcmp( FNAME( font ), FNAME( current ) ) >= 0 )
	     )
	{
	  current = FNEXT( current );	 /* Advance     */
	}

	if( current == ( FON_PTR )NULL ) /* Add as last */
	{
	  temp          = *top_last;
	  FNEXT( temp ) = font;
	  FPREV(font)   = *top_last;
	  FNEXT(font)   = (FON_PTR )NULL;
	  *top_last     = font;
	  return;
	}

	FPREV(font)    = FPREV(current);  /* Take over prev        */
	FPREV(current) = font;		  /* prev becomes this one */
	FNEXT(font)    = current;	  /* next is current       */
	
	if( FPREV(font) != (FON_PTR )NULL )
	    FNEXT(FPREV(font)) = font;
	
	if (*top_list == current)	/* Insert as first */
	    *top_list = font;
}



#if 0
/* build_specific_list()
 * ====================================================================
 * Build a list of JUST one type of font. Whether its active or not.
 * This is used, for example, in the printer dialog box to show
 * ONLY Bitmap fonts.
 * type == SPD_FONT or BITMAP_FONT
 * OUT: return a count of the # of that type font found.
 */
int
build_specific_list( FON_PTR *top_list, FON_PTR *top_last, int type )
{
   FON_PTR  curptr;
   int      i     = 0;
   int	    count = 0;
   
   i = 0;
   *top_list = ( FON_PTR )NULL;
   *top_last = ( FON_PTR )NULL;
   
   while ((i < MAX_FONTS) && (!free_font[i]))
   {
       curptr = &font_arena[i];
       if( FTYPE( curptr ) == type )
       {
       	     /* Clear the SELECTED in the dialog box flag */
	     alpha_font_add( top_list, top_last, curptr );
	     count++;
       }
       i++;   
   }
   return( count );
}


/* BuildBitMapList()
 * ====================================================================
 * Build the active or inactive linked list depending on whether
 * we're lookig for Active Fonts or Inactive Fonts.
 * For BitMap Fonts ONLY...
 * IN: type == ACTIVE | INACTIVE
 * OUT: return a count of the # of that type font found.
 */
int
BuildBitMapList( FON_PTR *top_list, FON_PTR *top_last, int type )
{
   FON_PTR  curptr;
   int      i     = 0;
   int	    count = 0;
   
   i = 0;
   *top_list = ( FON_PTR )NULL;
   *top_last = ( FON_PTR )NULL;
   
   while ((i < MAX_FONTS) && (!free_font[i]))
   {
       curptr = &font_arena[i];
   
       /* Look for ACTIVE Fonts and SEL() == TRUE
        *                   OR
        * Look for INACTIVE Fonts and !SEL()
        */
       if( FTYPE( curptr ) == BITMAP_FONT )
       {
         if( ( ( type == ACTIVE ) && ( XFLAG( curptr ) ) ) ||
             ( ( type == INACTIVE ) && ( !XFLAG( curptr ) ) )
           )
         {
       	     /* Clear the SELECTED in the dialog box flag */
	     alpha_font_add( top_list, top_last, curptr );
	     count++;
         }
       }	
       i++;   
   }
   return( count );
}
#endif




/* CountFonts
 * ====================================================================
 * Count the number of installed fonts or available fonts
 * and also the type.
 * BITMAP_FONT or SPD_FONT
 */
int
CountFonts( FON_PTR head_list, int flag )
{
   FON_PTR curptr;
   int     count;

   count = 0;
   curptr = head_list;

   while( curptr )
   {
      if( FTYPE( curptr ) == flag )
        count++;
      curptr = FNEXT( curptr );
   }
   return( count );
}


/* CountSelectedFonts()
 * ====================================================================
 * Count the number of Selected Fonts of a specific type.
 * BITMAP_FONT or SPD_FONT
 */
int
CountSelectedFonts( FON_PTR head_list, int flag )
{
   FON_PTR curptr;
   int     count;

   count = 0;
   curptr = head_list;

   while( curptr )
   {
      if( FTYPE( curptr ) == flag )
      {
	if( AFLAG( curptr ) )
           count++;
      }
      curptr = FNEXT( curptr );
   }
   return( count );
}






/* --------------------------------------------------------------------
 * POINT SIZES HANDLING
 * ====================================================================

/* set_font_pts()
 * ====================================================================
 *   Take a line of point sizes and place them into the font.
 *   IN: Pointer to Arena Font.
 *       Array of points.
 */
void
set_font_pts( FON_PTR font, char points[])
{
	int  i   = 0;
	int  k   = 0;
	int  num = atoi( &points[0] );

	if( font == (FON_PTR )NULL )
	    return;

        if( num > MAX_FONT_SIZE )
            num = MAX_FONT_SIZE;

	if( num < MIN_FONT_SIZE )
	    num = MIN_FONT_SIZE;

	/* Checks of the point size already exists */
	i = 0;
	while( ( i < MAX_POINTS ) && ( POINTS(font)[i]) )
	{
	   if( POINTS(font)[i] == num )
	   	break;
	   i++;
	}
	
	/* Adds the new pointsize INTO the array. The above
	 * loop checked if it existed.
	 */
	if( ( i < MAX_POINTS ) && ( POINTS(font)[i] != num ))
	    POINTS(font)[i] = num;
	    
	/* must be non-zero to be used as a default
	 * AND there must be room in fsm_defaults to
	 * put a new font size in there.
	 */
	k = 0;
	while( ( k < MAX_POINTS ) && (POINTS(font)[i]))
	{
	   /* if fsm_default slot is zero, put the font
	    * size here..
	    */
	   if( !Current.point_size[k] )
	       Current.point_size[k] = POINTS(font)[i];
		       
	   /* if font size already is in default, skip it*/
	   if( Current.point_size[k] == POINTS(font)[i] )
	   	break;
	   k++;
	}   
}


/* CheckForDefaultPointSizes()
 * ====================================================================
 */
void
CheckForDefaultPointSizes( void )
{
    int i;
    FON_PTR curptr;
    
    /* There can be NO ZERO point size, so if it is ZERO, 
     * we have NO point sizes at this point. This routine is
     * called AFTER we have parsed the extend.sys AND have
     * tried checking fonts.
     */
    i = 0;    
    while ((i < MAX_FONTS) && (!free_font[i]))
    {
       curptr = &font_arena[i];
 
       /* Look for OUtline fonts that have no point sizes.
        * If the first point size slot is ZERO, then we have no point
        * sizes.
        */
       if( ( FTYPE( curptr ) == SPD_FONT ) && ( !POINTS(curptr)[0] ))
       {
	   POINTS( curptr )[0] = 10;	/* Default point sizes for InActive Fonts */
       }
       i++;   
    }
    
}



/* GetFontMin()
 * ====================================================================
 */
long
GetFontMin( void )
{
   FON_PTR  curptr;
   long     size;
   
   size = 0L;
   curptr = installed_list;
   while( curptr )
   {
      if( FTYPE( curptr ) == SPD_FONT )
      {
         if( FBUFF_SIZE( curptr ) > size )
          size = FBUFF_SIZE( curptr );
      }    
      curptr = FNEXT( curptr );
   }
   return( size );
}


/* GetCharMin()
 * ====================================================================
 */
long
GetCharMin( void )
{
   FON_PTR  curptr;
   long     size;
   
   size = 0L;
   curptr = installed_list;
   while( curptr )
   {
     if( FTYPE( curptr ) == SPD_FONT )
     {
       if( CBUFF_SIZE( curptr ) > size )
         size = CBUFF_SIZE( curptr );
     }  
     curptr = FNEXT( curptr );
   }
   return( size );
}



/* --------------------------------------------------------------------
 * WRITE EXTEND.SYS STUFF
 * ====================================================================
 */
 

/* fast_write_extend()
 * ====================================================================
 */
int
fast_write_extend( void )
{
  int out;
  
  MF_Save();
  out = write_extend();
  MF_Restore();
  return( out );
}



/* write_extend()
 * ====================================================================
 * Write out the 'EXTEND.SYS file over the old ( or nonexistent one ).
 */
int 
write_extend( void )
{
	FON_PTR curptr;
	int new_extend;
	char line_buf[80];
	long time;
	long i;
	int  error;

	olddma = Fgetdta();	
	Fsetdta( &newdma );		/* Point to OUR buffer */
	
	/* Now look for EXTEND.SYS and rename it to EXTEND.OLD */
	error = Fsfirst( ExtendPath, 0 );
	if( error == E_OK )
	{
	   strcpy( line_buf, OldExtendPath );
	   Fdelete( OldExtendPath );
	   Frename( 0, ExtendPath, OldExtendPath );
	}

	if( ( new_extend = Fcreate( ExtendPath, 0 ) ) < 0 )
	{
	  form_alert(1, alerte11 );
	  return( 1 );
	}

	sprintf( line_buf, ";\r\n" );
	Fwrite( new_extend, ( long )strlen( line_buf), line_buf );
	sprintf( line_buf, etitle1 );
	Fwrite( new_extend, ( long )strlen( line_buf ), line_buf );
	time = Gettime();

#if USA	
	sprintf(line_buf, msg1, 
		(int )((time  >> 21) & 0x0F),
		(int )((time  >> 16) & 0x1F),
		(int )(((time >> 25) & 0x7F) + 1980),
		(int )((time  >> 11) & 0x1F),
		(int )((time  >> 5)  & 0x3F) );
#endif

#if UK | FRENCH | GERMAN | SPAIN | ITALY 
	sprintf(line_buf, msg1, 
		(int )((time  >> 16) & 0x1F),
		(int )((time  >> 21) & 0x0F),
		(int )(((time >> 25) & 0x7F) + 1980),
		(int )((time  >> 11) & 0x1F),
		(int )((time  >> 5)  & 0x3F) );
#endif


#if SWEDEN
	sprintf(line_buf, msg1, 
		(int )(((time >> 25) & 0x7F) + 1980),
		(int )((time  >> 16) & 0x1F),
		(int )((time  >> 21) & 0x0F),
		(int )((time  >> 11) & 0x1F),
		(int )((time  >> 5)  & 0x3F) );
#endif

		
	Fwrite(new_extend, (long )strlen(line_buf), line_buf);
	sprintf(line_buf, ";\r\n");
	Fwrite(new_extend, (long )strlen(line_buf), line_buf);

	/* Write the path to the fonts */
	sprintf(line_buf, "PATH = %s", Current.FontPath);
	for( i = strlen( line_buf ); i && line_buf[i] != '\\'; i-- );
	if( !i )
	   strcat( line_buf, "\\" );
	strcat( line_buf, "\r\n" );   
	Fwrite(new_extend, (long )strlen(line_buf), line_buf);

	/* Write out how big the bitmap cache is gonna be */
	sprintf(line_buf, "BITCACHE = %ld\r\n", Current.BitMapCacheSize*1024L);
	Fwrite(new_extend, (long )strlen(line_buf), line_buf);

	/* Write out how big the outline fonts cache is gonna be */
	/* AND how to divide up the outline cache buffer	 */
	sprintf(line_buf, "FSMCACHE = %ld,%d\r\n", Current.SpeedoCacheSize * 1024L, Current.speedo_percent );
	Fwrite(new_extend, (long )strlen(line_buf), line_buf);

	/* Write out if we pre-generate a width table */
	sprintf(line_buf, "WIDTHTABLES = %d\r\n", Current.Width );
	Fwrite(new_extend, (long )strlen(line_buf), line_buf);

	curptr = installed_list;
	while( curptr != (FON_PTR )NULL)
	{
	   if (SEL( curptr))
	   {
	     if( FTYPE( curptr ) == SPD_FONT )
	     {
	        sprintf(line_buf, "FONT = %s\r\n", FFNAME(curptr));
	        Fwrite(new_extend, (long )strlen(line_buf), line_buf);

	        sprintf( line_buf, "POINTS =");
	        Fwrite(new_extend, (long )strlen(line_buf), line_buf);
	        write_pointsizes( curptr, new_extend);
	        sprintf( line_buf, "\r\n");
	        Fwrite(new_extend, (long )strlen(line_buf), line_buf);
	     }   
	   }
	   curptr = FNEXT( curptr );
	}

	Fclose(new_extend);
	Fsetdta( olddma );		/* Point to OLD buffer */
	return( 0 );
}


/* write_pointsizes()
 * ====================================================================
 * Write out the point sizes into the 'EXTEND.SYS'
 */
void
write_pointsizes( FON_PTR font, int new_extend)
{
   int  i, idx;
   int  already_set;
   char linebuf[80];

   for( i = 0, already_set = 0; i < MAX_POINTS; ++i )
      already_set |= POINTS(font)[i];

   if( !already_set )
   {
      /* Write out default point sizes */
      for( i = 0; ( i < MAX_POINTS ) && ( Current.point_size[i] != 0 ); ++i )
      {
         if( i != 0 )
           sprintf( linebuf, ",%d", Current.point_size[i] );
         else
	   sprintf( linebuf, "%d", Current.point_size[i] );
	 Fwrite( new_extend, ( long )strlen( linebuf ), linebuf );
      }
   }
   else
   {
      /* Write out point sizes */
      for( i = 0, idx = 0; i < MAX_POINTS; ++i )
      {
         if( POINTS(font)[i] )
         {
   	   if( idx != 0 )
	     sprintf( linebuf, ",%d", POINTS( font )[i] );
	   else
	     sprintf( linebuf, "%d", POINTS( font )[i] );
	   Fwrite( new_extend, ( long )strlen( linebuf ), linebuf );
	   ++idx;
	 }
      }
   }
}




