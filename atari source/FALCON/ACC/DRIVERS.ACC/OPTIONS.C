/* ======================================================================
 * FILE: OPTIONS.C
 * ======================================================================
 * DATE: November 23, 1992
 *  	 December 15, 1992	Added Print Area Offsets
 *	 January 22, 1993       Removed CheckOS
 *				Used Defines for countries and cm/inches
 *
 * This file handles the options dialog box which allows one to
 * change the parameters of a printer. Note: it is NOT in its own window.
 */
 

/* INCLUDE FILES
 * ======================================================================
 */
#include <sys\gemskel.h>
#include <string.h>
#include <tos.h>
#include <stdio.h>
#include <stdlib.h>

#include "country.h"
#include "drivers.h"
#include "drvhead.h"
#include "device.h"
#include "popmenu.h"
#include "fsmio.h"
#include "fileio.h"
#include "text.h"
#include "mainstuf.h"


/* EXTERNS
 * ======================================================================
 */
extern int AES_Version;


/* PROTOTYPES
 * ======================================================================
 */
void     do_modify( void );
void	 WaitUpButton( void );
void	 ClearCheckMarks( void );
int	 execform( OBJECT *xtree, int start_obj );
void	 DoDrivers( int num );


	
/* DEFINES
 * ======================================================================
 */
typedef struct _menu_id
{
  int  menuid;
  int  curvalue;
  char text[ 10 ];
  int  num_items;
} MENU_ID; 

#define DRAW3D2 0x0200
#define DRAW3D1 0x0100


#define MAX_MENUS	8

#define MQUALITY	0
#define MCOLOR		1
#define MPAGESIZE	2
#define MREZ		3
#define MPORT		4
#define MTRAY		5
#define MHSIZE		6
#define MVSIZE		7


/* EXTERNALS
 * ======================================================================
 */


/* GLOBALS
 * ======================================================================
 */
MENU_ID Menu[ MAX_MENUS ];


char *hsize_text[] = {
			"0123",
			"0123",
			"0123",
			"0123"
		     };
		   
char *vsize_text[] = {
			"0123",
			"0123",
			"0123",
			"0123"
		     };
		     		   
char    title[ 128 ];
char    xtext[6];
char    ytext[6];

int     xres_value;	/* Value of the current XRES and YRES variables */
int     yres_value;	/* for the submenus...				*/
int     Tos_Country;	/* TOS Country Version */
int	SecondPageTable;	/* Existence of a 2nd Page Table */
int	PageOffset;		/* 1 = Page Offsets ON, 0 -> OFF */




/* FUNCTIONS
 * ======================================================================
 */


/* OptionInit()
 * ======================================================================
 */
void
OptionInit( void )
{
      /* Initialize PopUp Menus and Menu IDs */
      InitPopUpMenus();
      SetSubMenuDelay( 300L );
      SetSubDragDelay( 3000L );
      SetArrowClickDelay( 150L );

      Menu[ MQUALITY ].menuid  = InsertPopUpMenu( print_text[0], 2, 2 );
      Menu[ MPAGESIZE ].menuid = InsertPopUpMenu( size_text[0], 5, 5 );
      Menu[ MREZ ].menuid      = InsertPopUpMenu( rez_text[0], 2, 2 );

      Menu[ MCOLOR ].menuid    = InsertPopUpMenu( color_text[0], 4, 4 );
      Menu[ MPORT ].menuid     = InsertPopUpMenu( port_text[0], 2, 2 );
      Menu[ MTRAY ].menuid     = InsertPopUpMenu( tray_text[0], 4, 4 );
}



/* OptionEnd()
 * ======================================================================
 */
void
OptionEnd( void )
{
     DeletePopUpMenu( Menu[ MQUALITY ].menuid );
     DeletePopUpMenu( Menu[ MPAGESIZE ].menuid );
     DeletePopUpMenu( Menu[ MREZ ].menuid );
     DeletePopUpMenu( Menu[ MCOLOR ].menuid );
     DeletePopUpMenu( Menu[ MPORT ].menuid );
     DeletePopUpMenu( Menu[ MTRAY ].menuid );
}
	




/* do_modify()
 * ======================================================================
 */
void
do_modify( void )
{
   GRECT rect;
   GRECT xrect;
   int   button;
   int   obj;
   MRETS mk;
   int   menuid;

   long  value;
   int   item;
   int   id;
   int   xobj;
   int   xtitle;
   int   curvalue;
   int   offset;
   char  **txtptr;
   int   i;
   int   output;
   double tempx, tempy;
   int    xstart;   

   int   xdpi,ydpi;
   float Xres,Yres;
            
   ActiveTree( drivetree );

   xres_value = hdr->xres;	/* Set the globals for xres and yres */
   yres_value = hdr->yres;
   ClearCheckMarks();

   /* CJG - Initialize xdpi, ydpi, Xres and Yres */
   xdpi = hdr->X_PIXEL[ hdr->nplanes - 1 ];
   ydpi = hdr->Y_PIXEL[ hdr->nplanes - 1 ];

   /* ZERO BASED - so we add 1 pixel */
   Xres = hdr->xres + 1;
   Yres = hdr->yres + 1;
	        
   Xres /= xdpi;	/* gets us inches */
   Yres /= ydpi;



   Menu[ MQUALITY ].curvalue = hdr->quality;
   strcpy( Menu[ MQUALITY ].text, print_text[ Menu[ MQUALITY ].curvalue + 2 ] );
   
   Menu[ MPAGESIZE ].curvalue = hdr->PageSize;
   strcpy( Menu[ MPAGESIZE ].text, size_text[ Menu[ MPAGESIZE ].curvalue + 5 ] );
   
   Menu[ MCOLOR ].curvalue = max( 0, hdr->nplanes - 1 );
   Menu[ MVSIZE ].curvalue = max( 0, hdr->nplanes - 1 );
   Menu[ MHSIZE ].curvalue = max( 0, hdr->nplanes - 1 );
   strcpy( Menu[ MCOLOR ].text, color_text[ Menu[ MCOLOR ].curvalue ] );

   Menu[ MPORT ].curvalue = hdr->port;   
   strcpy( Menu[ MPORT ].text, port_text[ Menu[ MPORT ].curvalue + 2 ] );
   
   Menu[ MTRAY ].curvalue = hdr->paper_feed;
   strcpy( Menu[ MTRAY ].text, tray_text[ Menu[ MTRAY ].curvalue + 4 ] );
   strcpy( Menu[ MVSIZE ].text, vsize_text[ Menu[ MVSIZE ].curvalue ] );
   strcpy( Menu[ MHSIZE ].text, hsize_text[ Menu[ MHSIZE ].curvalue ] );

   if( hdr->config_map & 0x0040 )	/* Check for Color...*/
   {
      MakeShadow( DCOLOR );
      MakeTouchExit( DCOLOR );
   }
   else
   {
      NoShadow( DCOLOR );
      NoTouchExit( DCOLOR );
   }    
   
   if( hdr->config_map & 0x0001 )  /* Check for Print Quality */
   {
     MakeShadow( DPRINT );
     MakeTouchExit( DPRINT );
   }
   else
   {
      NoShadow( DPRINT );
      NoTouchExit( DPRINT );
   }

   if( hdr->config_map & 0x0100 ) /* Check for Port */
   {
     MakeShadow( DPORT );
     MakeTouchExit( DPORT );
   }
   else
   {
      NoShadow( DPORT );
      NoTouchExit( DPORT );
   }
      
   if( Menu[ MTRAY ].num_items > 1 ) /* Check for Trays */
   {
     MakeShadow( DTRAY );
     MakeTouchExit( DTRAY );
   }
   else
   {
      NoShadow( DTRAY );
      NoTouchExit( DTRAY );
   }
     
   if( Menu[ MPAGESIZE ].num_items > 1 )
   {
     MakeShadow( DPAGE );
     MakeTouchExit( DPAGE );
   }
   else
   {
      /* If there is only the pagetype of OTHER, then display it.*/
      if( Menu[ MPAGESIZE ].curvalue == 4 )
      {
        MakeShadow( DPAGE );
        MakeTouchExit( DPAGE );
      }
      else
      {
        NoShadow( DPAGE );
        NoTouchExit( DPAGE );
      }  
   }
        
   ObString( DPRINT ) = Menu[ MQUALITY ].text;
   ObString( DPAGE )  = Menu[ MPAGESIZE ].text;     
   ObString( DCOLOR ) = Menu[ MCOLOR ].text;
   ObString( DPORT )  = Menu[ MPORT ].text;
   ObString( DTRAY )  = Menu[ MTRAY ].text;    
   ObString( DHSIZE ) = Menu[ MHSIZE ].text;
   ObString( DVSIZE ) = Menu[ MVSIZE ].text;
    
   TedText( DDRIVER ) = title;


   for( i = MQUALITY; i <= MTRAY; i++ )
   {
      CheckItem( Menu[ i ].menuid, Menu[i].curvalue, TRUE );
      SetStartItem( Menu[i].menuid, Menu[i].curvalue );
   }


   /* Check if there is a Second Page Size Table
    * TRUE - YES - there is a second page size table
    * FALSE - No, there is only one page size table.
    */
   SecondPageTable = ( hdr->config_map & 0x2000 );
 
   Deselect( AREAON );
   Deselect( AREAOFF );

   /* Set ON/OFF for Page Offsets */
   if( !mhdr->TopMargin && !mhdr->BottomMargin && !mhdr->LeftMargin &&
       !mhdr->RightMargin )
   {
       /* Page Area Offset is OFF */    
       PageOffset = FALSE;
       Select( AREAOFF );
   }    
   else
   {
       /* Page Area Offset is ON */
       PageOffset = TRUE;
       Select( AREAON );
   }    
       
   
   
   Menu[ MREZ ].curvalue = 0;
   SetStartItem( Menu[ MREZ ].menuid, 0 );
   CheckItem( Menu[ MREZ ].menuid, 0, FALSE );
   CheckItem( Menu[ MREZ ].menuid, 1, FALSE );
   
   Form_center( tree, &rect );
   Form_dial( FMD_START, &rect, &rect );
   Objc_draw( tree, ROOT, MAX_DEPTH, &rect );
   do
   {

      button = form_do( tree, 0 );
      if( button & 0x8000 )
          button &= 0x7FFF;      

      if(( button != DOK ) && ( button != DCANCEL ))
      {		     
         xrect = ObRect( button );
     	 objc_offset( tree, button, &xrect.g_x, &xrect.g_y );

	 /* Fake the BUTTON Select/Deselect with this touchexit */
         do
         {
 	     Graf_mkstate( &mk );
 	     obj = objc_find( tree, ROOT, MAX_DEPTH, mk.x, mk.y );
 	     if( obj != button )
 	     {
 	        if( IsSelected( button ) )
 	          deselect( tree, button );
 	     }

	     if( obj == button )
	     {
	        if( !IsSelected( button ) )
	          select( tree, button );
	     }	 	
         
         }while( mk.buttons );
         
	 if( ( obj == button ) && ( !IsDisabled( obj ) ) )
	 {
	    switch( button )
	    {
	       case DPRINT:  menuid   = Menu[ MQUALITY ].menuid;
			     curvalue = Menu[ MQUALITY ].curvalue;
			     xobj     = MQUALITY;			
			     offset   = 2;
			     txtptr   = print_text;
			     xtitle   = QTITLE;
		 	     break;

	       case DPAGE:   menuid   = Menu[ MPAGESIZE ].menuid;
			     curvalue = Menu[ MPAGESIZE ].curvalue;
			     xobj     = MPAGESIZE;	
			     offset   = 5;
			     txtptr   = size_text;
			     xtitle   = STITLE;
			     break;

	       case DCOLOR:  menuid   = Menu[ MCOLOR ].menuid;
			     curvalue = Menu[ MCOLOR ].curvalue;
			     xobj     = MCOLOR;
			     offset   = 0;
			     txtptr   = color_text;
			     xtitle   = CTITLE;
			     break;

	       case DPORT:   menuid   = Menu[ MPORT ].menuid;
			     curvalue = Menu[ MPORT ].curvalue;
			     xobj     = MPORT;
			     offset   = 2;
			     txtptr   = port_text;
			     xtitle   = PTITLE;
			     break;

	       case DTRAY:   menuid   = Menu[ MTRAY ].menuid;
			     curvalue = Menu[ MTRAY ].curvalue;
			     xobj     = MTRAY;
			     offset   = 4;
			     txtptr   = tray_text;
			     xtitle   = TTITLE;
			     break;
		
	       default:
	       		break;
	       			       
            }
            if( button != DPRINT )
                disable( tree, DPRINT );
                
            if( button != DPAGE )
                disable( tree, DPAGE );
                
            if( button != DCOLOR )
                disable( tree, DCOLOR );
                
            if( button != DPORT )    
                disable( tree, DPORT );
            
            if( button != DTRAY )    
                disable( tree, DTRAY );

            select( tree, xtitle );
            
            value = PopUpMenuSelect( menuid, xrect.g_x, xrect.g_y, curvalue );        
            if( value != -1L )
            {
               item  = (int)value;
               id = (int)( value >> 16L );

	       if( ( item != -1 ) && ( id != Menu[ MREZ ].menuid ))
	       {
                  CheckItem( id, curvalue, FALSE );
                  CheckItem( id, item, TRUE );
                  Menu[ xobj ].curvalue = item;
                  SetStartItem( id, item );

                  strcpy( Menu[ xobj ].text, txtptr[ Menu[ xobj ].curvalue + offset ] );
                  ObString( button ) = Menu[ xobj ].text;
                  Objc_draw( tree, button, MAX_DEPTH, NULL );
                  
                  if( menuid == Menu[ MCOLOR ].menuid )
                  {
		      /* Calculate the new pixel xres and yres values
		       * ensuring that the inches or centimeters remain
		       * the same.
		       */
	              hdr->nplanes = Menu[ MCOLOR ].curvalue + 1;
                      xdpi = hdr->X_PIXEL[ hdr->nplanes - 1 ];
                      ydpi = hdr->Y_PIXEL[ hdr->nplanes - 1 ];

		      /* ZERO BASED - so, we subtract 1 pixel */  
		      xres_value = hdr->xres = ((int)( Xres * (float)xdpi )) - 1;
		      yres_value = hdr->yres = ((int)( Yres * (float)ydpi )) - 1;
		      

                      Menu[ MHSIZE ].curvalue = item;
                      Menu[ MVSIZE ].curvalue = item;
                      strcpy( Menu[ MVSIZE ].text, hsize_text[ Menu[ MVSIZE ].curvalue ] );
                      strcpy( Menu[ MHSIZE ].text, vsize_text[ Menu[ MHSIZE ].curvalue ] );
                      Objc_draw( tree, DHSIZE, MAX_DEPTH, NULL );
                      Objc_draw( tree, DVSIZE, MAX_DEPTH, NULL );
                  }
               }
               
               if( ( item != -1 ) && ( id == Menu[ MREZ ].menuid ) )
               {
                  xdpi = hdr->X_PIXEL[ hdr->nplanes - 1 ];
                  ydpi = hdr->Y_PIXEL[ hdr->nplanes - 1 ];

		  /* ZERO BASED - so we add one pixel */
                  Xres = hdr->xres + 1;
                  Yres = hdr->yres + 1;
	        
                  Xres /= xdpi;	/* gets us inches */
                  Yres /= ydpi;
                  
                  ActiveTree( xytree );


#if UK | FRENCH | GERMAN | SPAIN | ITALY | SWEDEN
 		    sprintf( xtext, "%2.2f", Xres * 2.54 );
		    sprintf( ytext, "%2.2f", Yres * 2.54 ); 
                    TedText( XYUNITS ) = xy2_unit;
#endif

#if USA
 		    sprintf( xtext, "%2.1f", Xres );
		    sprintf( ytext, "%2.1f", Yres );
                    TedText( XYUNITS ) = xy1_unit;
#endif

                  
                  TedText( SETX ) = xtext;
                  TedText( SETY ) = ytext;
                  xstart = (( !item ) ? ( SETX ) : ( SETY ) );
		  output = execform( xytree, xstart );
		  ActiveTree( drivetree );
		  if( output == XYOK )
		  {
                      CheckItem( menuid, curvalue, FALSE );
                      CheckItem( menuid, 4, TRUE ); /* set to OTHER */
                      Menu[ xobj ].curvalue = 4;
                      SetStartItem( menuid, 4 );
                      strcpy( Menu[ xobj ].text, txtptr[ Menu[ xobj ].curvalue + offset ] );
                      ObString( button ) = Menu[ xobj ].text;

		      tempx = atof( xtext );
		      tempy = atof( ytext );
		      
		      if( ( ( tempx > 0.0 ) && ( tempy > 0.0 ) ) &&
		          ( ( tempx <= 99.9 ) && ( tempy <= 99.9 ) ))
		      {

#if UK | FRENCH | GERMAN | SPAIN | ITALY | SWEDEN
		        tempx /= 2.54;
		        tempy /= 2.54;
		        
#endif
		        Xres = tempx;
		        Yres = tempy;

		        /* ZERO BASED - so, we subtract 1 pixel */  
		        xres_value = hdr->xres = ( tempx * xdpi ) - 1;
		        yres_value = hdr->yres = ( tempy * ydpi ) - 1;


#if USA
		         /* If USA, use inches */
		          sprintf( rez_text[0], rez_width, Xres );
		          sprintf( rez_text[1], rez_height, Yres );
#endif

#if UK | FRENCH | GERMAN | SPAIN | ITALY | SWEDEN
		          /* Get us CM for other than USA */
		          sprintf( rez_text[0], rez2_width, Xres * 2.54 );
		          sprintf( rez_text[1], rez2_height, Yres * 2.54 );
#endif

		        
                        SetItem( Menu[ MREZ ].menuid, 0, rez_text[0] );
                        SetItem( Menu[ MREZ ].menuid, 1, rez_text[1] );
                      }  
		  }
		  Objc_draw( tree, ROOT, MAX_DEPTH, NULL );		  
               }
               
            }
	 
	   if( button != DPRINT )
	        enable( tree, DPRINT );
	        
	   if( button != DPAGE )
	        enable( tree, DPAGE );
	        
	   if( button != DCOLOR )
	        enable( tree, DCOLOR );
	        
	   if( button != DPORT )
        	enable( tree, DPORT );
        	
	   if( button != DTRAY )
         	enable( tree, DTRAY );

           deselect( tree, xtitle );
	 }
	 if( IsSelected( button ) )
            deselect( tree, button );
      }
      else
      {
         if( button == DOK )
               Save_Data();
      }
      
   }while( ( button != DCANCEL ) && ( button != DOK ) );
   
   Form_dial( FMD_FINISH, &rect, &rect );
   Deselect( button );

   /* Free up the buffer */
   if( DataBuf )
     free( DataBuf );
}


/* WaitUpButton()
 * ======================================================================
 */
void
WaitUpButton( void )
{
   MRETS mk;

   do
   {
      Graf_mkstate( &mk );
   }while( mk.buttons );
}


/* ClearCheckMarks()
 * ======================================================================
 */
void
ClearCheckMarks( void )
{
     int    i,j;
     long   length;
     int    mask;
     int    xdpi,ydpi;
     float  Xres,Yres;
     char   *ptr;
          
     xdpi = hdr->X_PIXEL[ hdr->nplanes - 1 ];
     ydpi = hdr->Y_PIXEL[ hdr->nplanes - 1 ];

     /* ZERO BASED - so we add 1 pixel */
     Xres = hdr->xres + 1;
     Yres = hdr->yres + 1;
	        
     Xres /= xdpi;	/* gets us inches */
     Yres /= ydpi;



#if USA
       sprintf( rez_text[0], rez_width, Xres );
       sprintf( rez_text[1], rez_height, Yres );
#endif


#if UK | FRENCH | GERMAN | SPAIN | ITALY | SWEDEN
       sprintf( rez_text[0], rez2_width, Xres * 2.54 );
       sprintf( rez_text[1], rez2_height, Yres * 2.54 );
#endif
       
     
/* We must clear the array completely. Strings are terminated with '\0'
 * and must be nulled out to the next string.
 */
     for( i = 0; i < 2; i++ )
     {
        length = strlen( rez_text[i] );
        ptr    = rez_text[i];
        ptr    += length;
        for( j = (int)length; j < 19; j++ )
           *ptr++ = '\0';
     }
 
     for( i = 0; i < 2; i++ )
     {
       CheckItem( Menu[ MQUALITY ].menuid, i, FALSE );
       CheckItem( Menu[ MPORT ].menuid, i, FALSE );
       SetItem( Menu[ MREZ ].menuid, i, rez_text[i] );
     }
     mask = 0x0002;
     Menu[ MPAGESIZE ].num_items = 0;
     for( i = 0; i < 5; i++ )
     {
       CheckItem( Menu[ MPAGESIZE ].menuid, i, FALSE );
       if( hdr->config_map & mask )
       {
          EnableItem( Menu[ MPAGESIZE ].menuid, i );
          Menu[ MPAGESIZE ].num_items++;
       }   
       else
	  DisableItem( Menu[ MPAGESIZE ].menuid, i );
       mask = mask << 1;
     }  


     for( i = 0; i < 3; i++ )
     { 
       CheckItem( Menu[ MCOLOR ].menuid, i, FALSE );
       Menu[ MCOLOR ].num_items = hdr->total_planes - 1;
     }

     mask = 0x0200;
     Menu[ MTRAY ].num_items     = 0;
     for( i = 0; i < 4; i++ )
     {
       CheckItem( Menu[ MTRAY ].menuid, i, FALSE );

       if( hdr->config_map & mask )
       {
          EnableItem( Menu[ MTRAY ].menuid, i );
          Menu[ MTRAY ].num_items++;
       }   
       else   
	  DisableItem( Menu[ MTRAY ].menuid, i );
       mask = mask << 1;
           
       CheckItem( Menu[ MHSIZE ].menuid, i, FALSE );
       sprintf( vsize_text[i], "%d", hdr->Y_PIXEL[i] );
       sprintf( hsize_text[i], "%d", hdr->X_PIXEL[i] );
     }     

     /* check for wot's available */
     
     Menu[ MVSIZE ].num_items    = 0;
     Menu[ MHSIZE ].num_items    = 0;
     Menu[ MQUALITY ].num_items  = 2;
     Menu[ MPORT ].num_items     = 2;
     Menu[ MHSIZE ].curvalue     = Menu[ MVSIZE ].curvalue = 0;
}


/* execform()
 * ================================================================
 * Custom routine to put up a standard dialog box and wait for a key.
 */
int
execform( OBJECT *xtree, int start_obj )
{
   GRECT rect;
   GRECT xrect;
   int button;
   
   xrect.g_x = xrect.g_y = 10;
   xrect.g_w = xrect.g_h = 36;
   
   Form_center( xtree, &rect );
   Form_dial( FMD_START, &xrect, &rect );
   Objc_draw( xtree, ROOT, MAX_DEPTH, &rect );
   button = form_do( xtree, start_obj );
   Form_dial( FMD_FINISH, &xrect, &rect );
   Deselect( button );
   return( button );
}




/* DoDrivers()
 * =======================================================================
 * Handles the FPrinter Popup menu.
 */
void
DoDrivers( int num )
{
   sprintf( FPath, "%s\\%s", bitmap_path, &drivers[ cdriver_array[ num ] ] );
      
   MF_Save();
   if( AES_Version >= 0x0320 )
      graf_mouse( BUSYBEE, 0L );

   if( Read_Data() )
   {
        OptionInit();
        MF_Restore();
        do_modify();
        OptionEnd();
   }
   
   ActiveTree( ad_front );
   MF_Restore();
}


