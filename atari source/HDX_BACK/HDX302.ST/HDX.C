/* hdx.c */

/*
 * Atari Hard Disk Installation Utility
 * Copyright 1988 Atari Corp.
 *
 * Associated files
 *	hdx.rsc		resource file
 *	wincap		hard disk database (text file)
 *
 *	hdx.h		object tree definitions
 *	defs.h		constant definitions
 *	part.h		ST structure definitions
 *	ipart.h		IBM structure definitions
 *
 *	hdx.c		top level, user interface (this file)
 *	epart.c		edit partition sizes
 *	fmt.c		disk formatting
 *	part.c		partition reading/writing
 *	sect.c		sector reading, writing, zeroing
 *	string.c	string functions (matching, concat, ...)
 *	assist.c	markbad(), zero()
 *	wincap.c	hard disk parameter / partition size database
 *	st.c		random ST functions (delay, reboot, ...)
 *
 *----
 * 11-May-1988	ml.	Cleaned up the memory management in the program
 *			(ie. for all files).  Memory chunks which are for
 *			sure will be < 32k is allocated using malloc(),
 *			whereas chunks >= 32k is allocated using Malloc().
 *			When using malloc(), you will get the 'Stack Over-
 *			flow message if you are in Supervisor mode and 
 *			you have your own supervisor stack.  To get around
 *			this, have to use mymalloc() (in mymalloc.s).
 * 15-Mar-1988	ml.	Changed interface to Markbad.
 * 11-Jan-1988	ml.	Modified dialogue boxes.
 * 07-Dec-1987	ml.	Started to add in concept of Bad Sector List.
 * ??-Oct-1987  ml.	Partition and Disk type menu now has 15 entries 
 *			instead of 16.
 * 30-Sep-1987	ml.	Inherited 'this' from Landon Dyer.
 * 24-Mar-1986 lmd	Released to software test.
 * 15-Mar-1986 lmd	Hacked up from earlier version by Jim Tittsler.
 * 8-Nov-1988  jye. change and add some codes so that can be used for extended
 *					and big partition.
 * 13-Jun-1989 jye. Change and add some codes so that HDX can be deal with
 *				    acsi and scsi drives.
 *
 */

#include "obdefs.h"
#include "gemdefs.h"
#include "osbind.h"
#include "mydefs.h"
#include "part.h"
#include "bsl.h"
#include "hdx.h"
#include "ipart.h"
#include "addr.h"
#include "error.h"

#define MFM 17

extern char sbuf[];
extern int rebootp;
extern long gbslsiz();
extern long get3bytes();
extern long bslsiz;
extern BYTE *bsl;
extern int uplim;			/* the number of partitions */
extern long sptrk;
extern long spcyl;
extern int ibmpart;
extern int yesscan;
extern long disksiz;
extern long ratio;
extern int typedev;
extern int typedrv;
extern int prevnpart;

/* Globals */
int rebootp = 0;	/* 1: must reboot (not return to desktop) */
int tformat;			/* TRUE: just formatted disk */
int running;		/* 1: continue evnt_multi() loop */
char sbuf[512];		/* error message buffer */
long extsiz;		/* the size of extened partition */
long ostack;				/* old stack pointer */
int toibm;			/* the flag of partition to ibm format */
int ibm2st;			/* the flag for IBM partition to ST */
long bps;			/* bytes per sector */
int npart;			/* number of partition */
int ext;			/* the index of extended partition */
int extend;			/* the index of end extended partition */
int showmany;		/* the flag that show the too much device alert box */
char ttscsi;		/* SCSI hard disk drive */
int needscan;		/* TRUE: if info in the LOGMAP update */
int noinfo;			/* 1: no informations in the wincap */

/*  Logical-to-dev+partition mapping table. */
extern int nlogdevs;		/* #logical devs found */
extern LOGMAP logmap[];		/* logical dev map */
extern int livedevs[];		/* live physical dev flag */
char cachexst;		/* 0: no cache. 1: with cache */

/* Partition related variables */
long mxpsiz = MAXPSIZ;

/* AES (windows and messages) related variables */
int gl_hchar;		/* height of system font (pixels) */
int gl_wchar;		/* width of system font (pixels) */
int gl_wbox;		/* width of box able to hold system font */
int gl_hbox;		/* height of box able to hold system font */

int phys_handle;	/* physical workstation handle */
int handle;		/* virtual workstation handle */
int wi_handle;		/* window handle */

int formw, formh, sx, sy, lx, ly;	/* dialogue box dimensions */
int xdesk, ydesk, hdesk, wdesk;		/* window X, Y, width, height */
int xwork, ywork, hwork, wwork;		/* desktop and work areas */

int msgbuff[8];		/* event message buffer */
int keycode;		/* keycode returned by event-keyboard */
int mx, my;		/* mouse x and y pos. */
int butdown;		/* button state tested for, UP/DOWN */
int ret;		/* dummy return variable */
int pnf;		/* 1: partition or format; 0: zero or markbad */
int hidden;		/* current state of cursor */
int contrl[12];
int intin[128];
int ptsin[128];
int intout[128];
int ptsout[128];	/* storage wasted for idiotic bindings */
int work_in[11];	/* Input to GSX parameter array */
int work_out[57];	/* Output from GSX parameter array */
int pxyarray[10];	/* input point array */

/*
 * Top level;
 * we get control from the desktop.
 */
main()
{
    running = TRUE;
	pnf = 0;		/* set the flag to it isn't partition yet */
    appl_init();
    phys_handle=graf_handle(&gl_wchar, &gl_hchar, &gl_wbox, &gl_hbox);
    wind_get(0, WF_WORKXYWH, &xdesk, &ydesk, &wdesk, &hdesk);
    open_vwork();
    wi_handle=wind_create(0x0040&0x0080, xdesk, ydesk, wdesk, hdesk);

    hidden = FALSE;
    butdown = TRUE;

	/* doing a checking see if the cache in the system */
	cachexst = (char) chkcache();

    if (!rsrc_load(RESOURCEFILE)) {
	errs("[2][|", RESOURCEFILE, "][ EXIT ]");
	goto punt;
    }

    
    /* Get all addresses of dialogues from resource file */
    if (getalladdr() != OK) {
	errs("[2][|", RESOURCEFILE, "][ EXIT ]");
	goto punt;
    }


    /*
     * Get maximum partition size from
     * wincap "@@" entry.
     */
	/*
    if (wgetent("Parameters", "@@") == OK) {
	if (wgetnum("ms", &mxpsiz) != OK)
	    mxpsiz = MAXPSIZ;
    } else {
    	goto punt;
    }
	*/

    ARROW_MOUSE;

    /* display menu bar */
    menu_bar(menuobj, 1);

	needscan = TRUE;
    while (running) {
    	domulti();
    }

    /*
     * If nothing has been done to the hard disks
     * then just get out, back to the desktop.
     * Otherwise reboot the system.
     */
    menu_bar(menuobj, 0);		/* erase menu bar */

punt:
    /*
     * If we have to reboot,
     * tell the user and then do it.
     *
     */
    if (rebootp) {
	err(autoboot);
	reboot();
    }

    wind_delete(wi_handle);
    v_clsvwk(handle);
    appl_exit();
}


/*
 * Get a single event, process it, and return.
 *
 */
domulti(){
    int event;
    
    event = evnt_multi(MU_MESAG,
			1,1,butdown,
			0,0,0,0,0,
			0,0,0,0,0,
			msgbuff,0,0,&mx,&my,&ret,&ret,&keycode,&ret);

    if (event & MU_MESAG) {
    	wind_update(TRUE);
	switch (msgbuff[0]) {
	    case WM_REDRAW:
		do_redraw(msgbuff[4],msgbuff[5],msgbuff[6],msgbuff[7]);
		break;

	    case MN_SELECTED:
	        BEE_MOUSE;
		switch(msgbuff[3]) {
		    case MNDISK:
			switch (msgbuff[4]) {
			    case DIFORM:
		        	if ((needscan) && (rescan(0,0) == ERROR))	{
						break;	/* don't report medium changed */
					}
			        tformat = TRUE;
					needscan = FALSE;
			        dodiform();
			        tformat = FALSE;
			        break;
			    case DIPART:
		        	if ((needscan)&&(rescan(0,0) == ERROR))	{
						break;	/* don't report medium changed */
					}
					needscan = FALSE;
			        dodipart(-1, NULL, NULL);
			    	break;
			    case DIZERO:
					if (pnf)	{
						err(needboot);
					} else {
		        		if ((needscan)&&(rescan(0,1) == ERROR))	{
							break;	/* don't report medium changed */
						}
						needscan = FALSE;
			        	dodizero();
					}
			        break;
			    case DIMARK:
					if (pnf)	{
						err(needboot);
					} else {
		        		if ((needscan)&&(rescan(0,1) == ERROR))	{
							break;	/* don't report medium changed */
						}
						needscan = FALSE;
			        	dodimark();
					}
			        break;
			    case DISHIP:
		        	if ((needscan)&&(rescan(0,0) == ERROR))	{
						break;	/* don't report medium changed */
					}
					needscan = FALSE;
			        dodiship();
			        break;
			    default:	    break;
			}
			break;

		    case MNFILE:
			switch (msgbuff[4]) {
			    case FIQUIT:
				running = 0;
				break;

			    default:
				break;
			}
			break;
			
		    case MNDESK:
			if(msgbuff[4] == DEABOUT) {
			    strcpy(abtdial[ABVERSN].ob_spec, "Version 3.02");
			    abtdial[ABOK].ob_state = NORMAL;
			    execform(abtdial);
			}
			break;		/* "cannot happen" */
		}

		menu_tnormal(menuobj, msgbuff[3], 1);	/* back to normal */
	        ARROW_MOUSE;
		break;
		
	    case WM_NEWTOP:
	    case WM_TOPPED:
		wind_set(wi_handle, WF_TOP, 0, 0, 0, 0);
		break;

	    case WM_CLOSED:
		running = FALSE;
		break;

	    default:
		break;
	}
	wind_update(FALSE);
    }
}


/*
 * Default partition name (no "pt" entry).
 */
#define	DEF_PARTNAME	"4-6-10"


/*
 * Map from button in format dial.
 */
int pfmt[] = {
    PFMT0, PFMT1, PFMT2, PFMT3,
    PFMT4, PFMT5, PFMT6, PFMT7,
    PFMT8, PFMT9, PFMT10, PFMT11,
    PFMT12, PFMT13, PFMT14, PFMT15
};


/*
 * Handle [FORMAT] item.
 *
 */
dodiform()
{
  extern char bootstop;
  extern char bootend;
  int dev, v, i, br;
  int modesel;			/* flag for mode select */
  long cnt, hdsiz;
  char *s, *d, *wgetstr();
  char bs[512], sendata[32];
  char pnam[128];
  char *seldev = "X", *id = "XXXXX";
  HINFO hinfo;
  char devnames[NAMSIZ];	/* device type name buffer */
  long nbad;
  extern long gbslsiz(), nument(), dsmarkbad();
  long pattern, temp;
  long longrandom();
  char pr_id[10];	/* partition scheme id */
  int mask = 0x0001;
  int set, scsidrv, bsiz, other = 0;
  
  /*
   * Throw up generic formatting/partition warning,
   * then get physical dev they want to clobber.
   */
  yesscan = 0;
  noinfo = 0;
  for (i = 0; i < NAMSIZ; i++)
  	devnames[i] = "\0";
  fwarning[FWARNCN].ob_state = NORMAL;
  fwarning[FWARNOK].ob_state = NORMAL;
  if (execform(fwarning) != FWARNOK) return BAILOUT;

  if ((dev = gphysdev()) < 0) {
      return BAILOUT;
  }
  strcpy(id, "mn");
  br = 0;

  /* display doing SCSI massage */

  if (ttscsi)  {
  	noinfo = 1;
  	goto stfm;
  }
  
  inqfmt:
  /* Get all available disk types from wincap 'mn' entries */  
  wallents(devnames, id);
  if (!*devnames) 	{
  	noinfo = 1;
  	goto stfm;
  }
  
  /* Shove format name text into buttons */
  for (i = 0, s = devnames; i < 14 && *s; ++i) {
      dsknames[pfmt[i]].ob_type = G_BUTTON;	/* button */
      dsknames[pfmt[i]].ob_spec = (long)s;
      dsknames[pfmt[i]].ob_state = NORMAL;
      dsknames[pfmt[i]].ob_flags = SELECTABLE | RBUTTON;
      while (*s++)
	;
  }
  other = i;							/* the other button */
  dsknames[pfmt[i]].ob_type = G_BUTTON;	/* button */
  dsknames[pfmt[i]].ob_spec = "OTHER";
  dsknames[pfmt[i]].ob_state = NORMAL;
  dsknames[pfmt[i]].ob_flags = SELECTABLE | RBUTTON;
  i++;

  /* rest of buttons are invisible and untouchable */
  for (; i < 16; ++i) {
      dsknames[pfmt[i]].ob_type = G_IBOX;	/* invisible box */
      dsknames[pfmt[i]].ob_spec = 0;		/* no thickness */
      dsknames[pfmt[i]].ob_state = DISABLED;	/* nobody home */
      dsknames[pfmt[i]].ob_flags = NONE;		/* disabled */
  }
  
  /* clean up rest of the form and throw it up */
  dsknames[PFOK].ob_state = NORMAL;
  dsknames[PFCN].ob_state = NORMAL;
  if (execform(dsknames) != PFOK)
    return BAILOUT;
  
  /* search for format they picked */
  for (i = 0; i < 16; ++i)
    if (dsknames[pfmt[i]].ob_state & SELECTED)
      break;
  if (i >= 16) {		/* nothing picked */
      return BAILOUT;
  } else if (other == i)	{  /* the OTHER button was selected */
  	  noinfo = 1;
	  goto stfm;
  }
  
	if ((!br) && (!ttscsi))		{
	  	if (wgetent(dsknames[pfmt[i]].ob_spec, "mn") == ERROR)	{
			nofmt[NOSCHFMT].ob_spec = dsknames[pfmt[i]].ob_spec;
			nofmt[NOSCHFMT].ob_state = NORMAL;
			execform(nofmt, 0);
			return ERROR;
		}
		if ((s = wgetstr("br")) != NULL)	{
			strcpy(id, s);
			br = 1;			/* processing the branch */
			goto inqfmt;	/* start over */
		}
	}

stfm:
	modesel = 1;
  if (gfparm(dev, noinfo, &modesel, &hinfo, dsknames[pfmt[i]].ob_spec,id)!= 0) {
      return ERROR;
  }
  
  /* get data pattern to test the disk */
  if (wgetnum("dp", &pattern) != OK) {
      pattern = longrandom();  /* can't find pattern from wincap, make one */
  } else {
      temp = pattern;
      pattern <<= 16;	/* shift pattern to hi word */
      pattern |= temp;
  }


  /*
   * One last chance to bail out.
   */
  *seldev = dev + '0';
  (fmtfnl[FUNIT].ob_spec)->te_ptext = seldev;
  fmtfnl[FMTYES].ob_state = NORMAL;
  fmtfnl[FMTNO].ob_state = NORMAL;
  if (execform(fmtfnl) != FMTYES) return BAILOUT;

  /* For REAL !! */  
  dsplymsg(fmtmsg);

  bsl = 0L;
  
  /* Get size of Bad Sector List */
  if ((bslsiz = gbslsiz(dev)) > 0L) {
      /* Allocate memory for existing BSL */
      if ((bsl = (BYTE *)mymalloc((int)bslsiz*512)) <= 0) {
          ret = err(nomemory);
          goto formend;
      }
      
      /* Read in BSL */
      if ((ret = rdbsl(dev)) != OK) {
          /* Create a new BSL if current one is unusable */
	  	if (creabsl(dev, NEW, 0L) != OK) {
	  	    ret = ERROR;
	  	    goto formend;
	  	}
      } else {
      	  /* Remove USER BSL */
      	  if (creabsl(dev, EXPAND, nument(VENDOR)) != OK) {
      	      ret = ERROR;
      	      goto formend;
      	  }
      }
  } else if (bslsiz == 0L || bslsiz == ERROR) {	/* no bsl or read error */
      if (creabsl(dev, NEW, 0L) != OK) {
          ret = ERROR;
          goto formend;
      }
  } else {	/* bslsiz == MDMERR; medium changed error */
      ret = ERROR;
      goto formend;
  }
  
  /*
   * In supervisor mode
   * set disk format parameters
   * and format the disk.
   */
  ostack = Super(NULL);
  v = OK;				    /* assume everything is OK */
  if (modesel)	{			/* normal mode select ? */
      v = ms(dev, &hinfo);	/* Yes, do noprmal mode set */
  	  /* Find formatted capacity of drive */
      hdsiz = (long)hinfo.hi_cc * (long)hinfo.hi_dhc * (long)hinfo.hi_spt;
  }	else {					/* No, do special mode set */
  	set = typedev & (mask << dev);
	scsidrv = typedrv & (mask << dev);
	bsiz = ((set) || (scsidrv)) ? (16) : (22);
	for (i = 0; i < bsiz; i++)
		sendata[i] = 0;
  	if ((v = mdsense(dev, 0, 0, bsiz, sendata)) == OK)		{
  		for (i = 0; i < bsiz; i++)
  			if (sendata[i])
				break;
  		if (i == bsiz)	{ /* no infomations returned */
			ret = 111;		
			delay();
  			Super(ostack);
			goto formend;
  		}
		hdsiz = get3bytes(sendata+5);
  		delay();				    /* kludge delay */
		v = sqms(dev, sendata);
	}
  }
  disksiz = hdsiz;
  delay();				    /* kludge delay */
  if (v == OK)
  v = format(dev, (UWORD)hinfo.hi_in);  /* format */
  delay();				    /* kludge delay */
  Super(ostack);
  
  if (v != 0) {
      ret = errcode(dev);
      if (tsterr(ret) != OK)
          formaterr(dev);
      ret = ERROR;
      goto formend;
  }
  
  ret = OK;
  rebootp = 1;
formend:
  erasemsg();	/* Erase formatting box */
  if (ret == 111)		/* HDX may not support this drive */
  		ret = err(needinfo);
  if (ret < 0) {
      if (bsl > 0) free(bsl);
      return ERROR;
  }
  
  /*------------------------------------------*
   * Markbad the device destructively.	      *
   * Bad Sectors found are added to the BSL.  *
   * Write BSL to device.		      *
   *------------------------------------------*/
  if ((nbad = dsmarkbad(dev, hdsiz, 1, pattern)) < 0) {
      free(bsl);
      return ERROR;
  }
  if (wrbsl(dev) != OK) {
      free(bsl);
      return ERROR;
  }
  free(bsl);

    
  /*
   * Install boot-stopper in sector image;
   * write root sector to device.
   * 6-13-88  Setting of soft format parameters in root sector sets
   *		the hard disk size only.
   */
  fillbuf(bs, 512L, 0L);	/* create new root sector */
  sbslparm(bs);			/* set BSL parameters */
  if (modesel)	{
  	sfmtparm(bs, &hinfo);
  } else {
  	sdisksiz(bs, disksiz);
  }
  for (d = bs, s = &bootstop, cnt = (long)(&bootend - &bootstop); --cnt;)
    *d++ = *s++;
  Protobt(bs, -1L, -1, 1);	/* make root sector executable */
  
  if ((ret = putroot(dev, bs, (SECTOR)0)) != OK) {
      if (tsterr(ret) != OK)
	  	err(rootwrit);
      return ERROR;
  }

  /*
   * Make a copy of the default partition name.
   * Figure out the partition scheme id.
   */
  if (!noinfo)	{
  	s = wgetstr("pt");
  	strcpy(pnam, s);
  }
  /* ??
  figprid(disksiz, pr_id);
  */
  dodipart(dev, pnam, disksiz);
  return OK;
}



/*
 * Handle [PARTITION] item;
 * if `xdev' is -1, throw up dialog boxes;
 * if `xdev' >= 0, just partition the dev,
 * using `pnam' as the partition type, 
 * and `pr_id' to search for the type.
 *
 */
dodipart(xdev, pnam, hsize)
int xdev;
char *pnam;
long hsize;
{
    int dev, i, ret =OK, fine;
	int choice;
    char *seldev = "X";
    char *s;
    char bs[512];
    PART *pinfo;
	int tem1, tem2;
	long disksiz;
	extern long getdsiz();

    if (xdev < 0) {
	/*
	 * Throw up warning saying that partition is dangerous;
	 * then get physical dev they want to clobber.
	 */
	pwarning[PWARNCN].ob_state = NORMAL;
	pwarning[PWARNOK].ob_state = NORMAL;
	if (execform(pwarning) != PWARNOK) return BAILOUT;
	tformat = FALSE;
	if ((dev = gphysdev()) < 0) {
	    return BAILOUT;
	}
	/*
	 * Let the user edit/pick partitions.
	 */
	fine = 0;
	while (!fine) {
	    if (sfigpart(bs, dev, (PART *)&pinfo) != OK)	{
			if (pinfo > 0)	Mfree(pinfo);
	        return BAILOUT;
		}
	    if ((ret = chkpart(dev, pinfo)) != OK) {
			if (ret < 0)	{	/* size too big */
	    	    err(nexsmem);
	    	} else {	/* some other errors  */
				if (pinfo > 0)	Mfree(pinfo);
				return BAILOUT;
			}
	    } else {
	        fine = 1;
		}
	}

	/* Last chance to bail out */
	*seldev = dev + '0';
	(partfnl[PUNIT].ob_spec)->te_ptext = seldev;
	partfnl[PARTYES].ob_state = NORMAL;
	partfnl[PARTNO].ob_state = NORMAL;
	if (execform(partfnl) != PARTYES)	{
		if (pinfo > 0)	Mfree(pinfo);
	    return BAILOUT;
	}

    } else {
		/* ??
		if ((!noinfo) && (!ttscsi) && (wgetent(pnam, pr_id) != OK)) {
		    nopart[NOSCHPOK].ob_state = NORMAL;
		    (nopart[NOSCHPR].ob_spec)->te_ptext = pnam;
		    execform(nopart);
		    return ERROR;
		}
		*/
		npart = 4;
		ext = NO_EXT;	/* set the extended partition flag to not exists */
		dev = xdev;
		if ((pinfo = (PART *)Malloc((long)sizeof(PART)*npart)) <= 0)	{
			err(nomemory);
			if (pinfo > 0)	Mfree(pinfo);
			return ERROR;
		}
		inipart(pinfo, npart);
		npart = 0;
		setpart(pinfo, pnam, hsize);
		/* ??
		if (ttscsi)		{	 SCSI bus drive 
			setpart(pinfo, hsize);
		} else {			 regular drvie 
			for (i = 0; i < 4; ++i)
			    fillpart(i, &pinfo[i]);
		}
		*/
    }

    /* For REAL!! */
    dsplymsg(partmsg);
    
    bsl = 0L;
    
    /* Get size of BSL */
    if ((bslsiz = gbslsiz(dev)) > 0L) {
    	/* Allocate memory for existing BSL */
    	if ((bsl = (BYTE *)mymalloc((int)bslsiz*512)) <= 0) {
    	    ret = err(nomemory);
    	    goto partend;
    	}
    	    
    	/* Read in BSL */
    	if ((ret = rdbsl(dev)) != OK) {
    	    if (ret == INVALID)
    	        err(cruptbsl);
    	    ret = ERROR;
    	    goto partend;
    	}
    } else if (bslsiz == 0) {
    	ret = err(oldfmt);
		goto partend;
    } else if (bslsiz == ERROR) {
        ret = err(rootread);
        goto partend;
    } else {
        ret = ERROR;
		goto partend;
	}

    
    /* Lay out partition headers */
    if (spheader(dev, &pinfo[0]) != OK) {
        ret = ERROR;
        goto partend;
    }
    
    if (wrbsl(dev) != OK) {		/* write BSL */
        ret = ERROR;
        goto partend;
    }

	/* check and change the structure's id after 'spheader()' */
	changeid(pinfo);

	/* Shove partition parms into root sector */
	if ((ret = getroot(dev, bs, (SECTOR)0)) != 0)	{
		if (tsterr(ret) != OK)
			err(rootread);
		ret = ERROR;
		goto partend;
	}

	if ((ret = stlayroot(bs, dev, pinfo)) != OK)	{
		goto partend;
	}
	tem1 = npart;			/* save the number of partitions */
	tem2 = ext;				/* save the index of extended partition */
    if (rescan(1,0)) {		/* has to be here because map changed	*/
    	ret = ERROR;		/* after partitions are moved around,	*/
    	goto partend;		/* report medium change error.		*/
    }
	npart = tem1;
	ext = tem2;
    /* Partition the device with parameters given in pinfo */
    if (stlaybs(dev, &pinfo[0]) != OK)
        ret = ERROR;
    else
        ret = OK;
    	
    rebootp = 1;
	pnf = 1;		/* set the flag to just doing the partition */
partend:
    if (bsl > 0) free(bsl);
	inipart(pinfo, npart);
	if (pinfo > 0)	Mfree(pinfo);
    erasemsg();
    return (ret);
}


/*
 * get root sector informations and write them into that sector 
 */

stlayroot(bs, dev, part)
char *bs;
int dev;
PART *part;
{
	int i;
	UWORD sum = 0x1234;
	long cnt, disksiz, prvst;
	char *d, *s;
	extern char bootstop;
	extern char bootend;

	/* do the prime partition */
	spart(bs, part, 0, &prvst);	/* set ST partition parameters */
	/*
  	sfmtparm(bs, &hinfo);
  	for (d = bs, s = &bootstop, cnt = (long)(&bootend - &bootstop); --cnt;)
  	  *d++ = *s++;
	*/
	sbslparm(bs);				/* set bsl parameters */
	Protobt(bs, -1L, -1, 1);		/* make root sector executable */
    if ((ret = putroot(dev, bs, (SECTOR)0)) != OK) {
    	if (tsterr(ret) != OK)
    	    err(rootwrit);
    	return(ERROR);
    }
	if (ext == NO_EXT)	return OK;		/* no extended partition */
	/* do the extended partitions */
	extsiz = part[ext].p_siz;
	for (i = 4; i < npart; i++)	{
		if (!(part[i].p_flg & P_EXISTS))	{ 	/* skip if not exists */
			return OK;
		}
		spart(bs, part, i, &prvst);	/* set IBM partition parameters */
		if ((ret = putroot(dev, bs, part[i].p_st)) != OK) {
    		if (tsterr(ret) != OK)
    		    err(rootwrit);
    		return(ERROR);
    	}
	}
	return OK;
}




/*
 * Put information into the root structure
 */

spart(image, pinfo, pnm, prvst)

char *image;			/* root sector buffer */
register PART *pinfo;	/* partition information */
int pnm;				/* partition number */
long *prvst;			/* The previous partition start sector */

{
	PART *rpart;
	long numcyl;
	int i, j;

	if (pnm) 	{
		fillbuf(image, 512L, 0L);
	}
	rpart = &((RSECT *)(image + 0x200 - sizeof(RSECT)))->hd_p[0];
	if (pnm < 4)	{
		for (i = 0; i < NPARTS; i++, rpart++)	{
			if (pinfo->p_flg & P_EXISTS)	{
				rpart->p_flg = P_EXISTS;
				for (j = 0; j < 3; j++)
					rpart->p_id[j] = pinfo->p_id[j];
				rpart->p_st = pinfo->p_st;
				rpart->p_siz = pinfo->p_siz;
			} else {
				rpart->p_flg = 0;
				for (j = 0; j < 3; j++)
					rpart->p_id[j] = 0;
				rpart->p_st = 0L;
				rpart->p_siz = 0L;
			}
			pinfo++;
		}

	} else {	/* pnm => 4 */
		rpart->p_flg = pinfo[pnm].p_flg;
		for (j = 0; j < 3; j++)
			rpart->p_id[j] = pinfo[pnm].p_id[j];
		rpart->p_st = ROOTSECT;
		rpart->p_siz = pinfo[pnm].p_siz - ROOTSECT;
		rpart++;
		if (((pnm + 1) != npart) && (pinfo[pnm+1].p_flg & P_EXISTS)) { 
			/* need extened partition */
			rpart->p_flg = P_EXISTS;
			rpart->p_id[0] = 'X';
			rpart->p_id[1] = 'G';
			rpart->p_id[2] = 'M';
			rpart->p_siz = pinfo[pnm+1].p_siz;
			rpart->p_st = (pnm == 4) ? (pinfo[4].p_siz) :
	    							(pinfo[pnm].p_siz + *prvst);
			*prvst = rpart->p_st;
		}

	}
}



/*
 * Setup partitions on the disk;
 * write boot sectors and zero FATs and root directories.
 *
 */
stlaybs(physdev, pinfo)
int physdev;
register PART *pinfo;
{
	int i, ldev, ret;
	int kindfat;
    SECTOR data, nsect;
    char *devno="X";
    long ndirs;
    UWORD fatsiz;
    BOOT *bs;
	long serialno;
	extern long longrandom();
	extern long cell();
	char *buf;
	long size;

    if ((bslsiz = gbslsiz(physdev)) < 0L) {
        if (bslsiz == ERROR)
            err(rootread);
        return ERROR;
    }
    /* SCAN_BS: pinfo is for scan() and laybs() use */
	if (ext != NO_EXT)	sortpart(pinfo, SCAN_BS);	

    for (i = 0; i < npart; ++i, ++pinfo) {
    	
    	/* don't care if partition does not exist */
		if (!(pinfo->p_flg & P_EXISTS)) {
		    return OK;
		}


	/*
	 * Compute boot sector parameters.
	 */
		if (pinfo->p_siz > disksiz) {		/* partition >? disk size */
		    *devno = i + '0';
		    (part2big[BGPART].ob_spec)->te_ptext = devno;
		    part2big[BGPARTOK].ob_state = NORMAL;
		    execform(part2big);
		    return ERROR;
		}

	/* estimat the bps */
	/* MAXSECT = 16MB - 8 */
	bps = cell((pinfo->p_siz-7)*BPS, (long)MAXSECT);

	/* the real bps */
	bps = BPS * n2power((UWORD)cell(bps, (long)BPS));
	ratio = bps / BPS;
	nsect = pinfo->p_siz / ratio;

	size = (long)BPS * ratio;
	if ((buf = (char *)Malloc(size)) <= 0)	{
		err(nomemory);
		if (buf > 0) Mfree((long)buf);
		return ERROR;
	}

	/*
	 * Install entries in boot sector image;
	 * force sector checksum to zero (non-executable);
	 * write boot sector to media.
	 *
 	 *	512 bytes/sector
	 *	2 or 4 sectors/cluster (partition > 16Mb has 4 spc)
	 *	1 reserved sector (for boot)
	 *	2 FATs
	 *	... dir slots
	 *	... # sectors
	 *	F8 means media is a hard disk
	 *	... FAT size
	 *
	 */
	 
	/* Make a clean boot sector */
	fillbuf(buf, bps, 0L);
	bs = (BOOT *)buf;
        

    /* bytes per sector */
	iw((UWORD *)&bs->b_bps[0], (UWORD)bps);
	
	/* sectors per cluster */
	bs->b_spc = SPC;
	    
	/* number of reserved sectors */
	iw((UWORD *)&bs->b_res[0], (UWORD)1);
	
	/* number of FATs */
	bs->b_nfats = 2;
	

	/*
	 * Compute root directory size
	 * 256 entries, plus fudge on devs > 10Mb
	 */
	if (pinfo->p_siz < 0x5000L) ndirs = NUMEN;
	else ndirs = nsect / 80;	/* 1 dir entry per 80 sectors */
	/* round to nearest sector */
	ndirs = (ndirs + ((UWORD)bps/BPDIR - 1)) & ~((UWORD)bps/BPDIR - 1);	
	iw((UWORD *)&bs->b_ndirs[0], (UWORD)ndirs);
	
	/* number of sectors on media (partition) */
	iw((UWORD *)&bs->b_nsects[0], (UWORD)nsect);

	/* media descriptor */
	bs->b_media = 0xf8;

	/*--------------------------------------------------------------*
	 * Compute FAT size						*
	 *								*
	 * Num entries to map the entire partition			*
	 *	= partition's size in clusters				*
	 *	= partition's size in sectors / spc			*
	 *								*
	 * Num entries in FAT						*
	 *	= Num entries to map partition + reserved entries	*
	 *	= (partition's size in sectors / spc) + 2		*
	 *								*
	 * Num sectors FAT occupies					*
	 *	= Num entries in FAT / Num entries of FAT per sector	*
	 *	= Num entries in FAT / (512 / 2)    <16-bit FAT>	*
	 *	= ((partition's size in sectors / spc) + 2) / 256 + 1	*
	 *					    <+1 to round up>	*
	 *--------------------------------------------------------------*/
	fatsiz = ((((nsect / bs->b_spc) + 2) * 2) / bps) + 1;
	iw((UWORD *)&bs->b_spf[0], (UWORD)fatsiz);

	/* write the serial number to the bs */ 
	Protobt(bs, 0x01000000, -1, -1);

	/*
	 * Write partition's boot sector
	 */
	forcesum((UWORD *)buf, (UWORD)0);	/* force image checksum */
	if ((ret = wrsects(physdev,(UWORD)ratio,buf,(SECTOR)pinfo->p_st))!= OK) {
	    if (tsterr(ret) != OK)
	        err(bootwrit);
	    return ERROR;
	}

	/*
	 * Zero the partition
	 */
	if ((ret = zerosect(physdev, (SECTOR)(pinfo->p_st+ratio),
		     ((UWORD)((fatsiz*2 + ndirs*BPDIR/bps) * ratio)))) != OK) {
	    if (tsterr(ret) != OK)
	        err(hdrwrite);
	    return ERROR;
	}
		     
	/*
	 * Make first 2 entries in FATs more IBM-like.
	 */
	if ((ret = rdsects(physdev,(UWORD)ratio,buf,
						(SECTOR)(pinfo->p_st+ratio)))!= 0){
	    if (tsterr(ret) != OK)
	        err(fatread);
	    return ERROR;
	}
	*(UWORD *)&buf[0] = 0xf8ff;
	*(UWORD *)&buf[2] = 0xffff;
	if ((ret = wrsects(physdev,(UWORD)ratio,
						buf,(SECTOR)(pinfo->p_st+ratio)))!= 0 ||
	    (ret = wrsects(physdev,(UWORD)ratio,buf,
						(SECTOR)(pinfo->p_st+ratio+fatsiz*ratio)))
	    != 0) {
	    if (tsterr(ret) != OK)
	        err(fatwrite);
	    return ERROR;
	}

	/*
	 * Mark bad sectors recorded in the BSL into the FATs.
	 * Calculating parameters:
	 *	ldev - from physdev and i.
	 *	fat0 - always equals 1.
	 *	fatsiz - calculated above.
	 *	data - starts after the boot sector, 2 FATs and rootdir.
	 */

		if (bslsiz > 0) {
			if ((ldev = phys2log(physdev, i)) == ERROR)
				return parterr(physdev);
			data = (SECTOR)1 + (SECTOR)(fatsiz*2) + (SECTOR)(ndirs*BPDIR/bps);
			bsl2fat(ldev, (SECTOR)ratio, (UWORD)(fatsiz*ratio), 
												data*ratio, MEDIA);
		}
		if (buf > 0) Mfree((long)buf);
	}
	return OK;
}




/*
 * Handle [ZERO] item.
 *
 */
dodizero()
{
    int ldev, ret;
    char *seldev = "X";
    int i; 

    zwarning[ZWOK].ob_state = NORMAL;
    zwarning[ZWCN].ob_state = NORMAL;
    if (execform(zwarning) != ZWOK)
	return BAILOUT;
	if (showmany)	err(manyldev);

    if ((ldev = glogdev()) < 0) return BAILOUT;

    /* Find out if logical device has assumed parameters */
    if (chkparm(ldev) != OK) {
    	wronparm[WRONOK].ob_state = NORMAL;
	execform(wronparm);
	return ERROR;
    }
        
    *seldev = ldev;
    (zerofnl[ZDRV].ob_spec)->te_ptext = seldev;
    strcat((zerofnl[ZDRV].ob_spec)->te_ptext, ":");
    zerofnl[ZYES].ob_state = NORMAL;
    zerofnl[ZNO].ob_state = NORMAL;
    if (execform(zerofnl) != ZYES)  return BAILOUT;

    dsplymsg(zeromsg);
    if (zero(ldev) == OK) {
	if (!rebootp) {
	    for (i = 0; i < 10; i++) {
		if (!mediach(ldev-'A')) break;
	    }
	    if (i == 10) {
    		rebootp = 1;
		err(mdach);
            }
	}
    }
    erasemsg();
}


/*
 * Handle [MARKBAD] item.
 *
 */
dodimark()
{
    int ldev, ret;
    int i;

    mwarning[MWARNOK].ob_state = NORMAL;
    mwarning[MWARNCN].ob_state = NORMAL;
    if (execform(mwarning) == MWARNCN)
        return BAILOUT;
	if (showmany)	err(manyldev);

    if ((ldev = glogdev()) < 0)
        return BAILOUT;
        
    /* Find out if logical device has assumed parameters */
    if (chkparm(ldev) != OK) {
    	wronparm[WRONOK].ob_state = NORMAL;
	execform(wronparm);
	return ERROR;
    }
         
    dsplymsg(lmrkmsg);
    if (markbad(ldev) != OK) {
        erasemsg();
    } else {
    	if (!rebootp) {
	    for (i = 0; i < 10; i++) {
		if (!mediach(ldev-'A')) break;
	    }
	    if (i == 10) {
    		rebootp = 1;
		err(mdach);
            }
        }
    }
}


/*
 * Map from button in ship dial.
 */
int sdev[] = {
    SDEV0, SDEV1, SDEV2, SDEV3,
    SDEV4, SDEV5, SDEV6, SDEV7
};

/*
 * Ship selected devices.
 */
dodiship()
{
  int i, seldev[16], selected=0;
  int j, endup, index, doscsi;
  
	/* Set up the dialog box for SCSI or ACSI driver selection */
	typedial[TYPEOK].ob_state = NORMAL;
	typedial[TYPECN].ob_state = NORMAL;
	typedial[SCSIYES].ob_state = NORMAL;
	typedial[ACSIYES].ob_state = NORMAL;
    if (execform(typedial) != TYPEOK)
		return ERROR;
	/* check which type of unit was selected */
	if (typedial[SCSIYES].ob_state & SELECTED)	{
		doscsi = 1;
		index = 8;
	} else if (typedial[ACSIYES].ob_state & SELECTED)	{
		doscsi = 0;
		index = 0;
	} else {
		return ERROR;
	}
    
  /* Throw up generic shipping warning. */
  shipdial[SWARNCN].ob_state = NORMAL;
  shipdial[SWARNOK].ob_state = NORMAL;
  if (execform(shipdial) != SWARNOK) return BAILOUT;
  
  /* Device(s) selected? */
  shipdev[SDEVOK].ob_state = NORMAL;
  shipdev[SDEVCN].ob_state = NORMAL;
  for(i = 0; i < 8; i++) 	/* indicate what's alive */
		shipdev[sdev[i]].ob_state = DISABLED;
  endup = index + 8;
  for(i = index, j = 0; i < endup; i++, j++) 	/* indicate what's alive */
		if (livedevs[i])
			shipdev[sdev[j]].ob_state = NORMAL | SHADOWED;
  
  if (execform(shipdev) != SDEVOK)
      return BAILOUT;
      
  for(i = 0; i < 8; i++) {	/* search for selected unit */
      if (shipdev[sdev[i]].ob_state & SELECTED) {
          seldev[i+index] = 1;
          selected++;
      } else {
      	  seldev[i+index] = 0;
      }
  }
  
  if (!selected) return BAILOUT;	/* nothing is selected */
  
  /* Throw up final shipping warning. */
  shipfnl[SFNLCN].ob_state = NORMAL;
  shipfnl[SFNLOK].ob_state = NORMAL;
  if (execform(shipfnl) != SFNLOK) return BAILOUT;
  
  /* For REAL!!! */
  /* Ship selected devices */
  for (i = 0; i < MAXPHYSDEV; i++) {
      if (seldev[i])
          ship(i);
  }
  
  /* Put out final message about turning off hard disks */
  scommand[TRNOFFOK].ob_state = NORMAL;
  execform(scommand);
}



/*
 * Translate unit number to tree index.
 *
 */
static int physxlat[] = {
    UNIT0, UNIT1, UNIT2, UNIT3,
    UNIT4, UNIT5, UNIT6, UNIT7
};


/*
 * Get physical device#,
 * return devno or -1.
 *
 */
gphysdev()
{
    int i, j, endup, start, index, doscsi;

	/* Set up the dialog box for SCSI or ACSI driver selection */
redogphy:
	typedial[TYPEOK].ob_state = NORMAL;
	typedial[TYPECN].ob_state = NORMAL;
	typedial[SCSIYES].ob_state = NORMAL;
	typedial[ACSIYES].ob_state = NORMAL;
    if (execform(typedial) != TYPEOK)
		return ERROR;
	/* check which type of unit was selected */
	if (typedial[SCSIYES].ob_state & SELECTED)	{
		doscsi = 1;
		index = 8;
	} else if (typedial[ACSIYES].ob_state & SELECTED)	{
		doscsi = 0;
		index = 0;
	} else {
		return ERROR;
	}
    /*
     * Clean up and exec object;
     * shadow devs we KNOW are there.
     */
    physdial[PHYSOK].ob_state = NORMAL;
    physdial[PHYSCN].ob_state = NORMAL;
    
    if (tformat == TRUE) {
    	start = 1;		/* start initializing at unit 0 */
		physdial[physxlat[0]].ob_state = NORMAL;
    } else {
    	start = 0;		/* start initializing at unit 1 */
    }
    
    for (i = start; i < 8; ++i)
		physdial[physxlat[i]].ob_state = DISABLED;
	/*
	if (ttscsi)			 the hard drive is a SCSI drive 
		physdial[physxlat[8]].ob_state = NORMAL;
	*/
	endup = index + 8;
    for (i = index, j = 0; i < endup; ++i, j++)
		if (livedevs[i])
		    physdial[physxlat[j]].ob_state = NORMAL | SHADOWED;

    if (execform(physdial) != PHYSOK)
		return ERROR;
     
    /* search for the selected unit */
    for (i = 0; i < 8; ++i)
		if (physdial[physxlat[i]].ob_state & SELECTED)	{
			if (livedevs[index+i])
	    		return(index+i);
			else	{	
				form_alart(1, nodev);
				goto redogphy;
			}
		}


    return ERROR;			/* if no object selected */
}


/*
 * Translate from logical device number
 * to object number in logical device
 * dialouge box.
 */
int logxlat[] = {
	CCOLON, DCOLON, ECOLON, FCOLON,
	GCOLON, HCOLON, ICOLON, JCOLON,
	KCOLON, LCOLON, MCOLON, NCOLON,
	OCOLON, PCOLON
};


/*
 * Get logical device,
 * return 'C'...'P'
 * or -1.
 *
 */
glogdev()
{
    int i, flg;

    /*
     * Setup tree; selectively enable drive buttons
     * and so on.
     */
    logdial[LOGOK].ob_state = NORMAL;
    logdial[LOGCN].ob_state = NORMAL;
    for (i = 0; i < MAXLOGDEVS; ++i) {
	if (logmap[i].lm_physdev < 0)
	    flg = DISABLED;
	    else flg = NORMAL;
	logdial[logxlat[i]].ob_state = flg;
    }

    if (execform(logdial) != LOGOK) return -1;

    for (i = 0; i < MAXLOGDEVS; ++i)
	if (logdial[logxlat[i]].ob_state & SELECTED)
	    return i + 'C';

    return -1;
}


/*
 * Open virtual workstation.
 *
 */
open_vwork()
{
    int i;

    for (i = 0; i < 10;)
	work_in[i++] = 1;
    work_in[10] = 2;
    handle = phys_handle;
    v_opnvwk(work_in, &handle, work_out);
}


/*
 * Find and redraw all clipping rectangles
 *
 */
do_redraw(xc, yc, wc, hc)
int xc, yc, wc, hc;
{
    GRECT t1, t2;
    int temp[4];

    hide_mouse();
    t2.g_x=xc;
    t2.g_y=yc;
    t2.g_w=wc;
    t2.g_h=hc;
    vsf_interior(handle, 1);
    vsf_color(handle, 0);
    wind_get(wi_handle, WF_FIRSTXYWH, &t1.g_x, &t1.g_y, &t1.g_w, &t1.g_h);
    while (t1.g_w && t1.g_h) {
	if (rc_intersect(&t2, &t1)) {
	    set_clip(t1.g_x, t1.g_y, t1.g_w, t1.g_h);
	    temp[0] = xwork;
	    temp[1] = ywork;
	    temp[2] = xwork + wwork - 1;
	    temp[3] = ywork + hwork - 1;
	    v_bar(handle, temp);
	}
	wind_get(wi_handle, WF_NEXTXYWH, &t1.g_x, &t1.g_y, &t1.g_w, &t1.g_h);
    }

    show_mouse();
}


/*
 * Hide the mouse.
 *
 */
hide_mouse()
{
    if (!hidden) {
	graf_mouse(M_OFF, 0L);
	hidden = TRUE;
    }
}


/*
 * Show the mouse.
 *
 */
show_mouse() 
{
    if (hidden) {
	graf_mouse(M_ON, 0L);
	hidden = FALSE;
    }
}


/*
 * Set clipping rectangle.
 *
 */
set_clip(x, y, w, h)
int x, y, w, h;
{
    int clip[4];

    clip[0] = x;
    clip[1] = y;
    clip[2] = x + w;
    clip[3] = y + h;
    vs_clip(handle, 1, clip);
}


/*
 * "Execute" form,
 * return thingy that caused the exit.
 *
 */
execform(tree)
OBJECT tree[];
{
    int thingy;

    ARROW_MOUSE;
    dsplymsg(tree);
    thingy = form_do(tree, 0);
    erasemsg();
    BEE_MOUSE;
    return thingy;
}


/*
 *  Display a dialogue box on the screen.
 *	Input:
 *		tree - object tree for dialogue box to be displayed.
 *	Output:
 *		formw, formh, sx, sy, lx, ly - dimensions of box.
 */
dsplymsg(tree)
OBJECT *tree;
{
    form_center(tree,&lx, &ly, &formw, &formh);

	/*
    sx = lx + formw / 2;
    sy = ly + formh / 2;
	*/
    
    form_dial(1, 0, 0, 0, 0, lx, ly, formw, formh);
    objc_draw(tree, 0, MAX_DEPTH, 0, 0, wdesk, hdesk);
}


/*
 *  Erase a dialogue box from the screen.
 *	Input:
 *		formw, formh, sx, sy, lx, ly - dimensions of box.
 */
erasemsg()
{
    form_dial(3, 0, 0, 0, 0, lx, ly, formw, formh);
}



/*
 *  Make a long (4-byte) random.
 */ 
long
longrandom()
{
    long pattern;
    
    pattern = Random();
    pattern <<= 16;
    pattern ^= Random();
    
    return (pattern);
}

changeid(part)
PART *part;
{
	int i;
	long psiz;

	for(i = 0; i < npart; i++)	{
		if (i == ext)	continue;
		if (!(part[i].p_flg & P_EXISTS)) return OK;
		if (i > 3)	{
			psiz = part[i].p_siz - ROOTSECT;
		} else {
			psiz = part[i].p_siz;
		}
		if (psiz < MB16)	{
			part[i].p_id[0] = 'G';
			part[i].p_id[1] = 'E';
			part[i].p_id[2] = 'M';
		} else {
			part[i].p_id[0] = 'B';
			part[i].p_id[1] = 'G';
			part[i].p_id[2] = 'M';
		}
	}
}

