	subroutine flex_tidana_webpage
c
C***********************************************************************
C*
C*  THIS PROGRAM DOES A TIDAL HEIGHTS 'HARMONIC' ANALYSIS OF IRREGULARLY
C*  SAMPLED OBSERVATIONS.  THE ANALYSIS METHOD IS A LEAST SQUARES FIT
C*  USING SVD COUPLED WITH NODAL MODULATION AND INFERENCE(IF SO REQUESTED).  
c*	
c*	The code is based on TOPEX analysis code originally developed by Josef 
c*	Cherniawsky (JAOT, 2001, 18(4): 649-664) and modified by Rob Bell and 
c*	Mike Foreman. Enhancements to that version include
c*
c*	1. Provision for multi-constituent inferences computed directly within
c*	  the least squares matrix rather than as post fit corrections. This
c*	  means that the inferred constituents will affect all constituents, not
c*	  just the reference constituent.
c*
c*	2. An extension to permit the analysis of current observations.
c*
c*	3. Removal of a central time as the basis for the calculation of the
c*	  astronomical arguments V. Now the V value for each observation, as well 
c*	  as those for the nodal corrections f and u (done for the JAOT analysis), 
c*	  are incorporated directly into the overdetermined matrix. These changes
c*	  mean that analyses no longer need be restricted to periods of a year or
c*	  less. (Though as the period approaches 18.6 years, using another "long 
c*	  period" analysis program that solves for the "nodal satellites" directly
c*	  is advisable.)
c* 
C***********************************************************************
C*
C*  FILE REFERENCE NUMBERS OF DEVICES REQUIRED BY THIS PROGRAM.
C*      KR  - INPUT FILE  - CONTAINS THE TIDAL CONSTITUENT INFORMATION.
C*      KR1 - INPUT FILE  - GIVES ANALYSIS TYPE AND TIDAL STATION
C*                          DETAILS.
C*      KR2 - INPUT FILE  - CONTAINS THE OBSERVED TIMES AND HEIGHTS.
C*      LP  - OUTPUT FILE - LINE PRINTER.
C*  PRESENTLY KR,KR1,KR2, AND LP ARE ASSIGNED THE RESPECTIVE VALUES
C*  8,5,9, AND 6.  SEE THE MANUAL OR COMMENT STATEMENTS WITHIN THIS
C*  PROGRAM FOR FURTHER DETAILS ON THEIR USE.
C*
C***********************************************************************
C*
C*  ARRAY DEFINITIONS AND DIMENSION GUIDELINES.
C*
C*  LET    MC      BE THE TOTAL NUMBER OF CONSTITUENTS, INCLUDING Z0
C*                 AND ANY INFERRED CONSTITUENTS, TO BE INCLUDED IN THE
C*                 ANALYSIS; (For T/P, MC=30 > NUMBER OF CONSTITUENTS)
C*         NOBS    BE THE NUMBER OF TIDAL HEIGHT OBSERVATIONS;
C*         NR      BE THE NUMBER OF INPUT RECORDS OF OBSERVED TIDAL
C*                 HEIGHTS (For T/P data, same as NOBS, set to 200)
C*         MPAR    BE 2*MC-1;
C*         NEQ     BE NOBS*2 IF ALL THE OBSERVATIONS ARE EXTREMES AND
C*                 THE DERIVATIVE CONDITION IS TO BE INCLUDED FOR EACH,
C*                 AND NOBS OTHERWISE (= NR for T/P data).
C*  THEN PARAMETERS NMAXP1, AND NMAXPM SHOULD BE AT LEAST MPAR+1, AND 
C*  NEQ+MPAR RESPECTIVELY.  THEY ARE CURRENTLY SET TO 40 AND 240.
C*
C*  NAME(I)        IS THE ARRAY CONTAINING ALL THE CONSTITUENT NAMES,
C*                 INCLUDING Z0 AND ANY INFERRED CONSTITUENTS, TO BE IN
C*                 THE ANALYSIS.  IT SHOULD BE DIMENSIONED AT LEAST MC.
C*  FREQC(I),      ARE THE ARRAYS OF FREQUENCIES IN CYCLES/HR AND
C*  FREQ(I)        RADIANS/HR RESPECTIVELY CORRESPONDING TO THE
C*                 CONSTITUENT NAME(I).  THEY SHOULD BE DIMENSIONED AT
C*                 LEAST MC.
C*  AMP(I),PH(I)   ARE ARRAYS CONTAINING THE RAW AMPLITUDE AND PHASE FOR
C*                 CONSTITUENT NAME(I) AS FOUND VIA THE LEAST SQUARES
C*                 ANALYSIS.  THEY SHOULD BE DIMENSIONED AT LEAST MC.
C*  AMPC(I),PHG(I) ARE ARRAYS CONTAINING THE AMPLITUDE AND PHASE FOR
C*                 CONSTITUENT NAME(I) AFTER CORRECTIONS FOR NODAL
C*                 MODULATION, ASTRONOMICAL ARGUMENT AND INFERRED
C*                 CONSTITUENTS.  THEIR MINIMUM DIMENSION SHOULD BE MC.
C*  ITH(I),ITM(I), ARE ARRAYS CONTAINING THE TIMES IN HOURS AND MINUTES
C*  ht(I)          AND HEIGHTS, OF THE OBSERVED DATA AS IT IS INPUT BY
C*                 RECORD.  THEY SHOULD BE DIMENSIONED ACCORDINGLY( AT
C*                 PRESENT ONLY 6 OBSERVATIONS ARE EXPECTED PER RECORD).
C*  X(I),Y(I)      ARE ARRAYS CONTAINING ALL THE TIMES(IN HOURS AS
C*                 MEASURED FROM THE CENTRE OF THE ANALYSIS PERIOD) AND
C*                 HEIGHTS OF THE OBSERVED DATA.  THEIR MINIMUM
C*                 DIMENSION SHOULD BE NOBS.
C*  NSTN(I)        IS THE ARRAY CONTAINING THE TIDAL STATION NAME.  IT
C*                 SHOULD HAVE MINIMUM DIMENSION 5.
C*  Q(I)           IS THE OVERDETERMINED ARRAY OF EQUATIONS THAT IS
C*                 SOLVED IN THE LEAST SQUARES SENSE BY THE MODIFIED
C*                 GRAM-SCHMIDT ALGORITHM.  IT SHOULD HAVE THE EXACT
C*                 DIMENSION OF NMAXPM BY NMAXP1.
C*  P(I)           IS THE ARRAY CONTAINING THE TIDAL CONSTITUENT SINE
C*                 AND COSINE COEFICIENTS AS FOUND WITH THE LEAST
C*                 SQUARES FIT.  IT SHOULD HAVE MINIMUM DIMENSION MPAR.
C
C   COMMENT: TO ALIGN CHARACTER*5 ARRAY NAME(MC) IN A COMMON BLOCK IT IS
C            ADVISABLE FOR MC BE MULTIPLE OF 4
C***********************************************************************
C
      PARAMETER (MC=70,NR=106000,NMAXP1=MC*2,NMAXPM=NR*2+NMAXP1)
      CHARACTER*5 NAME(MC),KON,KBLANK,KONIN,dum
      CHARACTER*80 MESS(NMAXP1)
      REAL*8 AV,SDEV,SDEV0,SUM1,SUM2,round,rmsr,hr,hrm
      DOUBLE PRECISION X(NR),Y(NR),time(nr),y2(nr)
      CHARACTER*5 KONAN,KONI,KONA
      DIMENSION KONAN(10),KONIN(10,10),R(10,10),ZETA(10,10),ninf(10)
      DIMENSION SIGAN(10),SIGIN(10,10),ampci(10,10,2),phgi(10,10,2)
      DIMENSION Q(NMAXPM,NMAXP1),FREQ(MC)
     1,ITH(NR),ITM(NR),ht(NR),hl(NR),AMP(MC),PH(MC),AMPC(MC,2),PHG(MC,2)
     1,NSTN(5),amp0(16),ph0(16),kdtp(NR),kdtp0(NR),iout(nr),DIF(NR),
     1YD(NR),sal(46),kd(nr),dep(46),ht2(nr)
	 dimension amaj(mc),amin(mc),ainc(mc),g(mc),amaji(10,10),
	1amini(10,10),ainci(10,10),gi(10,10)
	character*3 tz
	character*18 stname
	integer*8 idate,iyr,imo,ida,iho,icc,iyy,imm,ihh,imin
      DIMENSION FREQC(MC) ! ,time(nr)
      common /const/freqc,mf,name
      DOUBLE PRECISION P(NMAXP1),dayi,dayc,hload,CENHR,CUMHR
     1,diff,difm,dxk,xx,yy,y1
c
c     Additional arrays, for use in the SVD routine (J.Ch., Aug. 1997)
      DOUBLE PRECISION U(NMAXPM,NMAXP1),V(NMAXP1,NMAXP1)
     1      ,COV(NMAXP1,NMAXP1),B(NMAXPM),W(NMAXP1),SIG(NMAXPM),
     1       cor(nmaxp1,nmaxp1)
c
      integer*2 itime(7,nr),level(nr),levelt(nr),leveln(nr),intr(nr)
     1         ,ifl(nr),ishift,itimax(6),idi
      integer*4 ifli
      character*80 fname,fnam6,fnamb,fnam7,fnam8,fnam9,fnamw,fnamo
      character*80 fnaml,fnamt,local,fil33,fnam10,fnam11,fnam12
	character*80 finp   ! Input parameter file  assigned to unit 4 RGB
	character*19 dum1
      logical isdata
      data lu,lp,kr1,kr2/30,6,7,9/ ! revised
      data difm /0.002d0/, FEXCL /2.0/, npoly /0/
      data timax /0.d0/
C***********************************************************************
304	format(A80)
	ibin=0
c
c	FILE I/O
c	KIN is the master input file. 
c	fnam6 is the file to which the output is sent. It is assigned the number
c		lp.
c	fnam7 is file containing the constituents to be included in the analysis,
c		the analysis period, inference parameters, the flag controlling
c		height or current analyses, and site information. It is assigned the
c		number kr1.
c	fnam8 is the file containing all the astronomical argument information 
c		(it should not have to be changed)
c	fnam9 is the file containing the observations and their times. It is
c		assigned the number kr2. 
c	fnam11 is a file to which information on the SVD matrix fit is output when
c		ibin > 0. This info includes matrix covariances which are useful
c		in determining (in)dependence of the chosen constituents.
c	Original, fitted, and residual time series are output to file 25 while
c	the same are also output to file 26 in a format that could be input to
c	Excel for plotting.
c
	KIN=4   ! Input file assigned to unit 4 
c	OPEN(UNIT=KIN,FILE='tuk75_tidana.inp',STATUS='OLD',
c	OPEN(UNIT=KIN,FILE='victoria_2008_test.inp',STATUS='OLD',
	OPEN(UNIT=KIN,FILE='tofino_jan2008_test.inp',STATUS='OLD',
c	OPEN(UNIT=KIN,FILE='kiw05_mar2008.inp',STATUS='OLD',
c	OPEN(UNIT=KIN,FILE='tcs05_sep07-mar08.inp',STATUS='OLD',
	1ACTION='READ')
      read(KIN,'(a)') fnam6
      read(KIN,'(a)') fnam7
      read(KIN,'(a)') fnam8
      read(KIN,'(a)') fnam9
      read(KIN,'(a)') fnam11
      open(unit=lp,file=fnam6,status='unknown',form='formatted')
      open(unit=kr1,file=fnam7,status='old',form='formatted')
      open(unit=8,file=fnam8,status='old',form='formatted')
      open(unit=kr2,file=fnam9,status='old',form='formatted')
      open(unit=11,file=fnam11,status='unknown',form='formatted')
c	unit 25 stores the residual time series
	read(KIN,'(a)') fname
c	write(lp,*) ' residual time series file=',fname
	open(unit=25,file=fname,status='unknown',form='formatted')
	read(KIN,'(a)') fname
	open(unit=26,file=fname,status='unknown',form='formatted')
C
      KBLANK='     '
      TWPI=3.1415926535898*2.
      FAC=TWPI/360.
C*
C***********************************************************************
C*  READ FROM DEVICE KR1 THE ANALYSIS TYPE AND TIDAL STATION DETAILS.
C*
C*  1)ONE RECORD FOR THE VARIABLES MF 
C*  MF   = THE NUMBER OF CONSTITUENTS, INCLUDING THE CONSTANT TERM Z0,
C*         TO BE IN THE LEAST SQUARES FIT.
C*
C*  2)ONE RECORD FOR EACH OF THE MF CONSTITUENTS TO BE INCLUDED IN THE
C*  FIT.  EACH RECORD CONTAINS THE VARIABLES NAME AND FREQC IN THE
C*  FORMAT (A5,2X,F13.10).  NAME IS THE CONSTITUENT NAME, WHICH SHOULD
C*  BE LEFT JUSTIFIED IN THE ALPHANUMERIC FIELD, WHILE FREQC IS ITS
C*  FREQUENCY MEASURED IN CYCLES PER HOUR.
C*
C*  3) ONE RECORD IN THE FORMAT (8I5) CONTAINING THE FOLLOWING
C*  INFORMATION ON THE TIME PERIOD OF THE ANALYSIS.
C*  ID1,IM1,IY1 - DAY,MONTH,YEAR OF THE BEGINNING OF THE ANALYSIS
C*                PERIOD,
C*  ID2,IM2,IY2 - DAY,MONTH,YEAR OF THE END OF THE ANALYSIS PERIOD.
C*  IC1,IC2     - CENTURY OFR THE BEGINNING AND END OF THE ANALYSIS
C*                PERIOD (ZERO VALUES ARE RESET TO 19)
C*
C*
C*  4)ONE RECORD IN THE FORMAT (I5,5A4,1X,A4,4I5) CONTAINING THE
C*  FOLLOWING TIDAL STATION  INFORMATION.
C*  JSTN      = TIDAL STATION NUMBER,
C*  (NSTN(I),I=1,5) = TIDAL STATION NAME,
C*  ITZ       = TIME ZONE IN WHICH THE OBSERVATIONS WERE RECORDED,
C*  LATD,LATM = STATION LATITUDE IN DEGREES AND MINUTES,
C*  LOND,LONM = STATION LONGITUDE IN DEGREES AND MINUTES.
C*
C*  5)ONE SET RECORDS FOR EACH POSSIBLE INFERENCE. THE FIRST RECORD HAS THE 
C*	CONSITUENT NAME, ITS FREQUENCY, AND THE NUMBER OF CONSTITUENTS TO BE
C*	INFERRED (4X,A5,E16.10,i5), WHILE THERE IS ONE RECORD FOR EACH OF THE 
C*	CONSTITUENTS TO BE INFERRED WITH THE NAME, FREQUENCY, AMPLITUDE RATIO 
C*	(INFERRED TO REFERENCE) AND PHASE DIFFERENCE (GREENWICH PHASE LAG OF 
C*	THE INFERRED CONSTITUENT SUBTRACTED FROM THE GREENWICH PHASE LAG OF THE
C*    (ANALYSED CONSTITUENT IN THE FORMAT(4X,A5,E16.10,2F10.3)
C*
C*  FOR KR1 INPUT, ALL CONSTITUENT NAMES SHOULD BE LEFT JUSTIFIED IN
C*  THE ALPHANUMERIC FIELD, FREQUENCIES ARE MEASURED IN CYCLES/HOUR, AND
C*  ALL CONSTITUENTS MUST BE INCLUDED IN THE LIST IN READ FROM FNAM8.
C
c	write(6,*) ' reading from unit kr1'
      READ(KR1,*) MF,ndef,itrend
	print *, ' number of constituents & degrees of freedom=',mf,ndef
	if(itrend.eq.1) then
	print *, ' a linear trend is included in the analysis'
	else
	print *, ' no linear trend is included'
	end if
c	mf= number of consituents, excluding linear trend. The constant
c	term, Z0 should be first in the list.
c	itrend= 1 if include linear trend
c	itrend= otherwise, no trend
c	ndef=1 if only 1D field to be analysed (eg., elevations)
c	ndef=2 if 2D field: velocity components, EW followed by NS
c	number of unknowns, M, depends on whether we have a linear trend
	if(itrend.eq.1) then
      M=2*MF
	else
	M=2*MF-1
	end if
   10 FORMAT(2I5,F5.2)
      READ(KR1,11) (NAME(I),FREQC(I),I=1,MF)
      print *,(NAME(I),FREQC(I),I=1,MF)
c   11 FORMAT(A5,2X,F13.10)
   11 FORMAT(4x,A5,F16.10)
      READ(KR1,7) ID1,IM1,IY1,ID2,IM2,IY2,IC1,IC2
      print *, ID1,IM1,IY1,ID2,IM2,IY2,IC1,IC2
      IF(IC1.EQ.0) IC1=19
      IF(IC2.EQ.0) IC2=19
    7 FORMAT(16I5)
      READ(KR1,9) JSTN,(NSTN(I),I=1,5),ITZ,LATD,LATM,LOND,LONM
    9 FORMAT(I5,5A4,1X,A4,4I5)
      WRITE(LP,15) ID1,IM1,IC1,IY1,ID2,IM2,IC2,IY2,ITZ
   15 FORMAT(/'THE ANALYSIS PERIOD IS FROM',I3,'/',I2,'/',I2,I2,
     1' TO ',I2,'/',I2,'/',I2,I2,'  IN THE TIME ZONE ',A4)
      WRITE(LP,*)'USING SVD TO SOLVE THE OVERDETERMINED SYSTEM'
c      write(lp,150)ID1,IM1,IC1,IY1,ID2,IM2,IC2,IY2
150	format(2i3,2i2,5x,2i3,2i2)
      CALL GDAY(ID1,IM1,IY1,IC1,kd1)
      KH1=24*kd1
      CALL GDAY(ID2,IM2,IY2,IC2,kd2)
      KH2=24*(kd2+1)
      KHM=(KH1+KH2)/2
	hrm=khm
      CENHR=DFLOAT((KH2-KH1)/2)
c
C***********************************************************************
C*  READ FROM DEVICE KR2 THE OBSERVED TIDAL HEIGHTS/velocities AND TIMES.
C*
	xlat=latd+latm/60.
	xlon=lond+lonm/60.
	istn=9999
	i=0
14	if(ndef.eq.1) then
c	conventional 1D input
	read(kr2,145,end=143) idd,imm,icc,iyy,ihh,imin,htt
	else if (ndef.eq.2) then
c
c	conventional 2D input
	read(kr2,145,end=143) idd,imm,icc,iyy,ihh,imin,htt,htt2
	end if ! ndef
c
c	finished reading in data
c
145	format(6i2,4f10.4)
	isec=0
      CALL GDAY(IDd,IMm,IYy,ICc,KDd)
      if(kdd.lt.kd1) then
c      if(kdd.lt.kd1.or.kdd.gt.kd2) then
        WRITE(LP,*) icc,iyy,imm,idd,ihh,imin
        WRITE(LP,*)'kd, kd1, kd2 =',kdd,kd1,kd2
	write(lp,*) ' observation before analysis period'
c        goto 178
        goto 14
      endif
	i=i+1
	kd(i)=kdd
      itime(1,i)=iyy
      itime(2,i)=imm
      itime(3,i)=idd
      itime(4,i)=ihh
      itime(5,i)=imin
      itime(6,i)=isec
	itime(7,i)=icc
	ht(i)=htt
	if(ndef.eq.2) ht2(i)=htt2
	if(kd(i).le.kd2) go to 14
143	if(kd(i).gt.kd2) then
	nobs=i-1
	else
	nobs=i
	end if
	nrec=nobs
	rewind (kr2)
	if(nobs.le.10) then
	write(lp,*) ' not enough observations: nobs',nobs
        WRITE(LP,*) icc,iyy,imm,idd,ihh,imin
        WRITE(LP,*)'kd, kd1, kd2 =',kdd,kd1,kd2
	go to 142
	end if
c ----------------------------------------------------------------------
c
c	read in the astronomical argument information
c 	and re-calculate the constituent frequencies (latitude not used yet)
c
	print *, ' number of observations=',nobs
      CALL OPNVUF(hrm,KON,VX,ux,FX,xlat)
      DO I=1,MF
        FREQ(I)=FREQC(I)*TWPI
      ENDDO
C
C***********************************************************************
C*  DETERMINE THE CENTRAL HOUR OF THE ANALYSIS PERIOD AND SET UP THE
C*  DEPENDENT AND INDEPENDENT VARIABLES, Y AND X.
C
      lats=int(60.*(60.*(xlat-LATD)-LATM))
      lons=int(60.*(60.*(xlon-LOND)-LONM))
        WRITE(LP,8) JSTN,(NSTN(L),L=1,5),LATD,LATM,LOND,LONM
    8   FORMAT(' STATION # ',I6,' , ',5A4,' LATITUDE'
     1       ,2I3,', LONGITUDE',I4,I3)
      IF(ABS(xlat).LT.5.) xlat=SIGN(5.,xlat)
c
c actually, CUMHR=24.d0*(KD-KHM) (check), but keep same notation as before
c
	k=1
	do 20 i=1,nobs
      CUMHR=-CENHR+24.D0*(KD(i)-kd1)
      time(i)=CUMHR+DFLOAT(ITime(4,i))+(DFLOAT(ITime(5,i))
     1             +DFLOAT(ITime(6,i))/60.d0)/60.d0
      X(K)=time(i)-time(1)
      Y(K)=ht(i)
	if(ndef.eq.2) y2(k)=ht2(i)
      iout(k)=i
      kdtp(k)=kd(i)
      N=K
      K=K+1
20    continue
        WRITE(LP,255)n
  255   FORMAT('NUMBER OF POINTS IN THE ANALYSIS =',I6)
c	
c	read in inference information now as it will be used in the lsq matrix
c
      DO 1020 K=1,10
      READ(KR1,1010)KONAN(K),SIGAN(K),ninf(k)
c      write(6,1010)KONAN(K),SIGAN(K),ninf(k)
      IF(KONAN(K).EQ.KBLANK) GO TO 1040
	do 1021 kk=1,ninf(k)
 1021	read(kr1,1011) KONIN(K,kk),SIGIN(K,kk),R(K,kk),ZETA(K,kk)
 1010 FORMAT(4X,A5,E16.10,i5)
 1011 FORMAT(4X,A5,E16.10,2F10.3)
c	write(lp,*) k,konan(k),kblank
1020  CONTINUE
1040  NIN=K-1
	write(lp,*) ' nin=',nin
c
C***********************************************************************
C*  SETTING UP THE OVERDETERMINED MATRIX AND SOLVING WITH MODIFIED SVD
C
      IREP=0
	do 27 idef=1,ndef   ! loop thru once or twice
      xmid=0.5*(x(1)+x(n))
	do i=1,nmaxpm
	do j=1,nmaxp1
	Q(i,j)=0.0
	end do
	end do
      DO I=1,N
c	if itrend=1, then
c	first 2 parameters are constant and linear trend (per 365 days)
c	fitted as const+trend(t-tmid) where tmid (=xmid) is the middle time
c	of the analysis period (This makes the constant consistent with z0
c	in the old analysis program)
c	If itrend=0 then the second parameter is is associated with the next 
c	constituent
        Q(I,1)=1.
	if(itrend.eq.1) then
        Q(I,2)=(x(i)-xmid)/(24.*365.)
	end if
		if(idef.eq.1) then
		Q(I,NMAXP1)=Y(I)
		else if(idef.eq.2) then
		Q(i,nmaxp1)=y2(i)
		end if ! idef if
		icode=1
c	should only have to assemble lhs of matrix when idef=1
c	but something is not right if don't do it 2nd time too
	  kh=24*kdtp(i)+itime(4,i)
		hr=dfloat(kh)+itime(5,i)/60.d0+itime(6,i)/3600.d0
        CALL SETVUF(hr,KON,VX,ux,FX,xlat)
        DO J=2,MF
            CALL VUF(hr,NAME(j),VX,ux,FX,xlat) 
c	check to see if this constituent is to be used for inference
			inflag=0
			kinf=0
			if(nin.eq.0) go to 500
			do k=1,nin
				if(name(j).eq.konan(k)) then
				inflag=1
				kinf=k
				go to 500
				end if
			end do
500			continue
c			write(lp,*) ' i,j,inflag,kinf=',i,j,inflag,kinf
		if(inflag.eq.0) then
c			ARG=X(I)*FREQ(J)+ux*twpi
			ARG=(vx+ux)*twpi
			if(itrend.eq.1) then
			JJ=2*(J-1)+1
			else
			JJ=2*(J-1)
			end if
			JJ1=JJ+1
			Q(I,JJ)=COS(ARG)*fx
			Q(I,JJ1)=SIN(ARG)*fx
		else
			if(itrend.eq.1) then
			JJ=2*(J-1)+1
			else
			JJ=2*(J-1)
			end if
			JJ1=JJ+1
			ARG1=(vx+ux)*twpi
			Q(I,JJ)=COS(ARG1)*fx
			Q(I,JJ1)=SIN(ARG1)*fx
			do 501 kk=1,ninf(kinf)
			CALL VUF(hr,konin(kinf,kk),VXi,uxi,FXi,xlat) 
c	freq is radians/hr but sigin is cycles/hr 
c			ARG1=X(I)*FREQ(J)+ux*twpi
c			ARG2=(X(I)*sigin(kinf)+uxi)*twpi
			ARG2=(vxi+uxi)*twpi
			c2=cos(arg2)
			s2=sin(arg2)
			arg3=zeta(kinf,kk)*fac
			c3=cos(arg3)
			s3=sin(arg3)
			Q(I,JJ)=q(i,jj)+fxi*r(kinf,kk)*(c2*c3-s2*s3)
			Q(I,JJ1)=q(i,jj1)+fxi*r(kinf,kk)*(c2*s3+s2*c3)
501			continue
		end if
        ENDDO !j
!		else if(idef.eq.2) then
!		Q(i,nmaxp1)=y2(i)
!		icode=2
!		end if ! idef if
      ENDDO  !i

	print *, 'assembled overdetermined matrix and/or rhs'
      NMAX=M
      MEQ=N
      SSQ=1.0
      RES=1.0
      NCOL=NMAX
      NEW=NMAX
c
C***********************************************************************
C*  CALCULATION OF THE STANDARD DEVIATION OF THE RIGHT HAND SIDES OF
C*  THE OVERDETERMINED SYSTEM
C
      AV=0.D0
      DO 64 I=1,MEQ
   64 AV=AV+Q(I,NMAXP1)
      AV=AV/MEQ
      SDEV=0.D0
      DO 65 I=1,MEQ
   65 SDEV=SDEV+(Q(I,NMAXP1)-AV)**2
      SDEV=SDEV/(MEQ-1)
      SDEV=SQRT(SDEV)
      SDEV0=SDEV
 109  CONTINUE
C***********************************************************************
C   USE SINGULAR-VALUE-DECOMPOSITION TO SOLVE THE OVERDETERMINED SYSTEM
C
c	do we need to adjust the value for toler ?
c      TOLER=1.E-4
      TOLER=1.E-5
        DO I=1,NMAXPM
          SIG(I)=1.D0
        ENDDO
c
c	no solution if meq lt m. ie underdetermined system
c	go to next time series
	if(meq.le.m) then
	write(lp,*) ' underdetermined system: no svd solution'
	stop
	end if
	print *, ' applying svd'
      CALL SVD(Q,U,V,COV,W,P,B,SIG,ICODE,MEQ,NMAX,NMAXPM,NMAXP1,TOLER
     1        ,JCODE,SSQ,RES)
      IF(JCODE.GT.0) WRITE(LP,55)JCODE
   55 FORMAT('COLUMN',I5,' IS THE 1ST DEPENDENT COLUMNS IN SVD')
c	write out eigenvalues
	wmax=-1000.
	wmin=1000.
	do i=1,nmax
	if(w(i).gt.wmax) wmax=w(i)
	if(w(i).lt.wmin) wmin=w(i)
	end do
	write(6,*) ' max, min eigenvalues =',wmax,wmin
c	write(6,*) ' all eigenvalues'
c	write(6,56) (w(i),i=1,nmax)
56	format(10e12.5)
C***********************************************************************
	if(ssq.gt.1.e-10) then
      RMSR0=SQRT(SSQ/(MEQ-M))
	else
	rmsr0=0.
	end if
        WRITE(LP,52) RES,SSQ
   52   FORMAT('LARGEST RESIDUAL MAGNITUDE & RESIDUAL SUM OF SQUARES:'
     1        ,2E12.5)
        WRITE(LP,66) SDEV,RMSR0
   66   FORMAT(
     1'ST. DEV. OF RIGHT HAND SIDES OF ORIGINAL OVERDETERMINED SYSTEM:'
     2,E12.5/
     3'                       AND THE ROOT MEAN SQUARE RESIDUAL ERROR:'
     4,E12.5)
c	
c***********************************************************************
c	re-calculate the residual sum of squares again just to check svd routine
c	residuals are stored in (q(i,nn),i=1,m)
c
	rmsr=0.d0
	resmax=0.
		do 100 i=1,n
		yy=q(i,nmaxp1)
		rmsr=rmsr+yy*yy
	if(abs(yy).gt.resmax) then
	resmax=abs(yy)
	imax=i
	end if
100		continue
160	format(' ',7i2,f15.5,f10.5,i6)
	if(rmsr.gt.1.e-10) then
	rmsr=dsqrt(rmsr/(n-m))
	else
	rmsr=0.
	end if
	write(lp,*) ' rms residual: brute force =',rmsr
	write(lp,*) ' max residual: ',resmax,imax
c	close(unit=25)
c
C***********************************************************************
C*  CALCULATE AMPLITUDES AND PHASES
C
c	if itrend=1 then the linear trend is shown as the phase of the constant 
c	Z0 term (& the true phase of Z0 is zero)
c	otherwise, the phase of Z0 is shown as zero
      AMP(1)=P(1)
	if(itrend.eq.1) then
      PH(1)=P(2)
	else
	PH(1)=0.
	end if
      DO 39 I=2,MF
	if(itrend.eq.1) then
        I2=2*(I-1)+1
	else
	  I2=2*(I-1)
	end if
        I21=I2+1
        C=P(I2)
        S=P(I21)
        AAMP=SQRT(C*C+S*S)
        IF(AAMP.LT.1.E-5) GOTO 40
        PH(I)=ATAN2(S,C)/FAC
        IF(PH(I).LT.0.) PH(I)=PH(I)+360.
        GOTO 39
   40   PH(I)=0.
   39   AMP(I)=AAMP
C***********************************************************************
c	Note that with f & u included in the lsq fit, we only need V from routine VUF
C	but we don't want to correct with V for a central hour. Better to include
c	the right V in the lsq fit. This has been done.
c      CALL SETVUF(hrm,KON,VX,ux,FX,xlat)
        AMPC(1,idef)=AMP(1)
        PHG(1,idef)=PH(1)
      DO 45 I=2,MF
c          CALL VUF(hrm,NAME(I),VX,ux,FX,xlat)
        AMPC(I,idef)=AMP(I)
	  phg(i,idef)=ph(i)
c        PHG(I)=VX*360.+PH(I)
c        PHG(I)=AMOD(PHG(I),360.)
   45 CONTINUE
        WRITE(LP,41)
   41  FORMAT('HARMONIC ANALYSIS RESULTS: AMPLITUDES, PHASE LAGS, C, S, 
     1& amp SD estimates, t-test value')
c	write out results for constant term & linear trend
	i=1
	if(cov(1,1).gt.1.e-8) then
	sig1=sqrt(cov(1,1))*rmsr0
	else
	sig1=0.
	end if
	if(itrend.eq.1.and.cov(2,2).gt.1.e-8) then
	sig2=sqrt(cov(2,2))*rmsr0
	else
	sig2=0.
	end if
	sig3=0.
	ttest=0.
      WRITE(LP,43) NAME(I),FREQC(I),AMPC(I,idef),PHG(I,idef),
     1sig1,sig2,sig3,ttest
c	results for the other constituents
        DO 42 I=2,MF
	if(itrend.eq.1) then
		II=2*(I-1)+1
	else
		II=2*(I-1)
	end if
		II1=II+1
c	multiply cov values with residual standard deviation, as described in equation
c	(6) of Cherniasky et al. (2001)
	if(cov(ii,ii).gt.1.e-8) then
	sig1=sqrt(cov(ii,ii))*rmsr0
	else
	sig1=0.
	end if
	if(cov(ii1,ii1).gt.1.e-8) then
	sig2=sqrt(cov(ii1,ii1))*rmsr0
	else
	sig2=0.
	end if
c	from equation 11 in Pawlowicz et al (2002)
	c=ampc(i,idef)*cos(phg(i,idef)*fac)
	s=ampc(i,idef)*sin(phg(i,idef)*fac)
	sig3=sqrt(((c*sig1)**2+(s*sig2)**2)/(c**2+s**2))
	ttest=ampc(i,idef)/sig3
   42   WRITE(LP,43) NAME(I),FREQC(I),AMPC(I,idef),PHG(I,idef),
     1sig1,sig2,sig3,ttest
   43   FORMAT(5X,A5,4X,F12.9,2X,F10.5,2X,F10.3,5x,4f8.3)
c   43   FORMAT(5X,A5,4X,F12.9,15X,F10.5,5X,F10.3,5x,3f10.5,f10.3)
c   42   WRITE(LP,43) NAME(I),FREQC(I),AMP(I),PH(I),AMPC(I),PHG(I)
c   43   FORMAT(5X,A5,4X,F12.9,5X,F10.4,5X,F10.3,5X,F10.4,5X,F10.3)
C***********************************************************************
C*  INFERENCE results are given now
C
	if(nin.eq.0) go to 76
	write(lp,*) ' INFERENCE RESULTS'
	l=0
	do 75 k=1,nin
	do 77 i=2,mf
	if(name(i).eq.konan(k)) go to 78
77	continue
78	i1=i
	do 751 kk=1,ninf(k)
	l=l+1
	ampci(k,kk,idef)=ampc(i1,idef)*r(k,kk)
	phgi(k,kk,idef)=phg(i1,idef)-zeta(k,kk)
	write(lp,79) konin(k,kk),sigin(k,kk),ampci(k,kk,idef),
	1phgi(k,kk,idef)
751	continue
75	continue
	inftot=l
c	write(lp,*) ' total number of inferred constituents=',l
79	format(5x,a5,4x,f12.9,15x,f10.4,5x,f10.4)
76	continue
c
c***********************************************************************
c	compute (Cherniawsky et al (2001), page 653) and rank correlation coefficients
c	largest niter value are computed and shown
c	if itrend=1, then the second part of Z0 is the linear trend coefficient
c
	do 80 i=1,m
	do 80 j=1,i
	cor(i,j)=cov(i,j)/sqrt(cov(i,i)*cov(j,j))
80	continue
	niter=20
	do 81 iter=1,niter
	cormax=0.
	do 82 i=2,m
	im1=i-1
	do 82 j=1,im1
	ac=abs(cor(i,j))
	if(ac.gt.cormax) then
	cormax=ac
	imax=i
	jmax=j
	end if
82	continue
	if(itrend.eq.1) then
	iconst=(imax+1)/2
	jconst=(jmax+1)/2
	else
	iconst=(imax+2)/2
	jconst=(jmax+2)/2
	end if
	write(lp,83) iter,cormax,imax,jmax,name(iconst),name(jconst)
83	format(i5,' largest correlation coefficient is ',f8.3,' at (i,j)='
     1,2i5,' for constituents ',a5,' and ',a5) 
	cor(imax,jmax)=0.
81	continue
c
C***********************************************************************
C*  RECALCULATE THE RESIDUAL ROOT MEAN SQUARE ERROR
c	using re-constructed time series
C
      SDEV=0.D0
      DO 68 I=1,N
        kh=24*kdtp(i)+itime(4,i)
	  hr=24.d0*kdtp(i)+itime(4,i)+itime(5,i)/60.d0+itime(6,i)/3600.d0
        CALL SETVUF(hr,KON,VX,ux,FX,xlat)
	if(itrend.eq.1) then
        SUM1=P(1)+p(2)*(x(i)-xmid)/(365.*24.)
	else
        SUM1=P(1)
	end if
        DO 69 J=2,MF
          CALL VUF(hr,NAME(j),VX,ux,FX,xlat)
c          ARG=X(I)*FREQ(J)+ux*twpi-ph(j)*fac
          ARG=(vx+ux)*twpi-phg(j,idef)*fac
          ADD=fx*AMPc(J,idef)*COS(ARG)
   69     SUM1=SUM1+ADD
		if(nin.eq.0) go to 692
		do 691 k=1,nin
		do 691 kk=1,ninf(k)
          CALL VUF(hr,konin(k,kk),VX,ux,FX,xlat)
c          ARG=(X(I)*sigin(k)+ux)*twpi-phgi(k)*fac
          ARG=(vx+ux)*twpi-phgi(k,kk,idef)*fac
          ADD=fx*AMPci(k,kk,idef)*COS(ARG)
691		SUM1=SUM1+ADD
692       continue
		ic=itime(7,i)
		iy=itime(1,i)
		im=itime(2,i)
		id=itime(3,i)
		ih=itime(4,i)
		imin=itime(5,i)
		if(idef.eq.1) then
		DIF(I)=Y(I)-SUM1
		write(25,145) id,im,ic,iy,ih,imin,sum1,y(i),dif(i),q(i,nmaxp1)
		write(26,146) i,sum1,y(i),dif(i),q(i,nmaxp1)
		else
		dif(i)=y2(i)-sum1
		write(25,145) id,im,ic,iy,ih,imin,sum1,y2(i),dif(i),q(i,nmaxp1)
		write(26,146) i,sum1,y2(i),dif(i),q(i,nmaxp1)
		end if
        SDEV=SDEV+DIF(I)**2
   68 CONTINUE
146	format(i10,4f10.4)
      SSQ=SDEV
      RMSR=SQRT(SSQ/(N-M))
      SDEV=sqrt(ssq/n)
        WRITE(LP,70)N,m,'    ',xlat,xlon,sngl(SDEV0),sngl(SDEV)
   70   format('N,m,LAT,LON,SDEV0,SDEV:  ',2i10,a4,f9.4,f10.4,2f10.2)
c
c
      var=SDEV*SDEV
      do j=1,nmax
        do i=1,nmax
          cov(i,j)=cov(i,j)*var
        enddo
      enddo
      j0=j0+1
      if(ibin.gt.0) then
        write(11) j0,istn,xlat,xlon,meq,nmax,ssq,res,sngl(sdev)
     1           ,jcode
        write(11)(sngl(p(i)),i=1,nmax)
        write(11)(sngl(w(i)),i=1,nmax)
        write(11)((sngl(cov(i,j)),i=1,j),j=1,nmax)
      else
        write(11,110) j0,istn,LATD,LATM,LATS,LOND,LONM,LONS,meq
     1               ,nmax,ssq,res,sdev,jcode
        write(11,113)(nint(10.*p(i)),i=1,nmax)
        write(11,113)(nint(p(i)),i=1,nmax)
        write(11,111)(w(i),i=1,nmax)
        do j=1,nmax
          write(11,113)(nint(cov(i,j)),i=1,nmax)
          write(11,113)(nint(10*cov(i,j)),i=1,nmax)
        enddo
 110    format(3i5,2(i4,2i3),2i4,f11.1,2f9.2,3i4)
 111    format(1pe9.2,13e9.2)
 113    format(15i10)
      endif
c
        IF(NIN.GT.0) THEN
        WRITE(LP,71) RMSR
   71   FORMAT('ROOT MEAN SQUARE RESIDUAL ERROR AFTER INFERENCE IS',
     1          E15.6, //)
        ELSE
        WRITE(LP,72) RMSR
   72   FORMAT('RECALCULATED ROOT MEAN SQUARE RESIDUAL ERROR IS   ',
     1          E15.6, //)
        ENDIF
c
27	continue  ! idef loop
c
c	compute ellipse parameters if ndef=2
	if(ndef.eq.1) go to 142
	do idef=1,ndef
	if(ampc(1,idef).ge.0.) then
	phg(1,idef)=0.
	else
	phg(1,idef)=180.
	ampc(1,idef)=-ampc(1,idef)
	end if
	end do !idef
	write(lp,*) ' ELLIPSE PARAMETERS:                        Major, 
	1  Minor, angle incl,  phase'
	write(lp,*) ' Constituents included directly (not inferred)' 
	DO 149 I=1,MF
	cx=ampc(i,1)*cos(phg(i,1)*fac)
	sx=ampc(i,1)*sin(phg(i,1)*fac)
	cy=ampc(i,2)*cos(phg(i,2)*fac)
	sy=ampc(i,2)*sin(phg(i,2)*fac)
	cxpsy=0.5*(cx+sy)
	cymsx=0.5*(cy-sx)
	cxmsy=0.5*(cx-sy)
	cypsx=0.5*(cy+sx)
	apl=sqrt(cxpsy**2+cymsx**2)
	amn=sqrt(cxmsy**2+cypsx**2)
	if(apl.gt.1.e-5) then
	epl=atan2(cymsx,cxpsy)/fac
	else
	epl=0.
	end if
	if(amn.gt.1.e-5) then
	emin=atan2(cypsx,cxmsy)/fac
	else
	emin=0.
	end if
	amaj(i)=apl+amn
	amin(i)=apl-amn
	gpl=-epl
	gmn=emin
	if(gmn-gpl.lt.0.) gmn=gmn+360.
	g(i)=0.5*(gpl+gmn)
	ainc(i)=0.5*(gmn-gpl)
	if(gmn.lt.0.) gmn=gmn+360.
	if(gmn.gt.360.) gmn=gmn-360.
	if(gpl.lt.0.) gpl=gpl+360.
	if(g(i).lt.0.) g(i)=g(i)+360.
      WRITE(LP,151) NAME(I),FREQC(I),amaj(i),amin(i),ainc(i),g(i)
151   FORMAT(5X,A5,4X,F12.9,15X,2F10.4,2F10.2)
149	continue
c
	if(nin.eq.0) go to 152
	write(lp,*) ' Inferred constituents' 
	do 153 k=1,nin
	do 154 kk=1,ninf(k)
	cx=ampci(k,kk,1)*cos(phgi(k,kk,1)*fac)
	sx=ampci(k,kk,1)*sin(phgi(k,kk,1)*fac)
	cy=ampci(k,kk,2)*cos(phgi(k,kk,2)*fac)
	sy=ampci(k,kk,2)*sin(phgi(k,kk,2)*fac)
	cxpsy=0.5*(cx+sy)
	cymsx=0.5*(cy-sx)
	cxmsy=0.5*(cx-sy)
	cypsx=0.5*(cy+sx)
	apl=sqrt(cxpsy**2+cymsx**2)
	amn=sqrt(cxmsy**2+cypsx**2)
	if(apl.gt.1.e-5) then
	epl=atan2(cymsx,cxpsy)/fac
	else
	epl=0.
	end if
	if(amn.gt.1.e-5) then
	emin=atan2(cypsx,cxmsy)/fac
	else
	emin=0.
	end if
	amaji(k,kk)=apl+amn
	amini(k,kk)=apl-amn
	gpli=-epl
	gmni=emin
	if(gmni-gpli.lt.0.) gmni=gmni+360.
	gi(k,kk)=0.5*(gpli+gmni)
	ainci(k,kk)=0.5*(gmni-gpli)
	if(gmni.lt.0.) gmni=gmni+360.
	if(gmni.gt.360.) gmni=gmni-360.
	if(gpli.lt.0.) gpli=gpli+360.
	if(gi(k,kk).lt.0.) gi(k,kk)=gi(k,kk)+360.
      WRITE(LP,151) konin(k,kk),sigin(k,kk),amaji(k,kk),amini(k,kk),
	1ainci(k,kk),gi(k,kk)
154	continue
153	continue
152	continue
	
178   continue
142	continue
c
      close(lp)
      close(kr1)
      close(10)
      close(11)
      close(13)
	return
c      STOP
      END
