	subroutine astr(d1,h,pp,s,p,np,dh,dpp,ds,dp,dnp)
c	this subroutine calculates the following five ephermides
c	of the sun and moon
c	h = mean longitude of the sum
c	pp = mean longitude of the solar perigee
c	s = mean longitude of the moon
c	p = mean longitude of the lunar perigee
c	np = negative of the longitude of the mean ascending node
c	and their rates of change.
c	Units for the ephermides are cycles and for their derivatives
c	are cycles/365 days
c	The formulae for calculating this ephermides were taken from
c	pages 98 and 107 of the Explanatory Supplement to the
c	Astronomical Ephermeris and the American Ephermis and
c	Nautical Almanac (1961)
c
	implicit real*8(a-h,o-z)
	real*8 np
	d2=d1*1.d-4
	f=360.d0
	f2=f/365.d0
	h=279.696678d0+.9856473354d0*d1+.00002267d0*d2*d2
	pp=281.220833d0+.0000470684d0*d1+.0000339d0*d2*d2+
     1  .00000007d0*d2**3
	s=270.434164d0+13.1763965268d0*d1-.000085d0*d2*d2+
     1  .000000039d0*d2**3
	p=334.329556d0+.1114040803d0*d1-.0007739d0*d2*d2-
     1  .00000026d0*d2**3
	np=-259.183275d0+.0529539222d0*d1-.0001557d0*d2*d2-
     1  .00000005d0*d2**3
	h=h/f
	pp=pp/f
	s=s/f
	p=p/f
	np=np/f
	h=h-dint(h)
	pp=pp-dint(pp)
	s=s-dint(s)
	p=p-dint(p)
	np=np-dint(np)
	dh=.9856473354d0+2.d-8*.00002267d0*d1
	dpp=.0000470684d0+2.d-8*.0000339d0*d1
     1  +3.d-12*.00000007d0*d1**2
	ds=13.1763965268d0-2.d-8*.000085d0*d1+
     1  3.d-12*.000000039d0*d1**2
	dp=.1114040803d0-2.d-8*.0007739d0*d1-
     1  3.d-12*.00000026d0*d1**2
	dnp=+.0529539222d0-2.d-8*.0001557d0*d1-
     1  3.d-12*.00000005d0*d1**2
	dh=dh/f2
	dpp=dpp/f2
	ds=ds/f2
	dp=dp/f2
	dnp=dnp/f2
	return
	end
      FUNCTION dpythag(a,b)
      DOUBLE PRECISION a,b,dpythag
      DOUBLE PRECISION absa,absb
      absa=abs(a)
      absb=abs(b)
      if(absa.gt.absb)then
        dpythag=absa*sqrt(1.0d0+(absb/absa)**2)
      else
        if(absb.eq.0.0d0)then
          dpythag=0.0d0
        else
          dpythag=absb*sqrt(1.0d0+(absa/absb)**2)
        endif
      endif
      return
      END
C  (C) Copr. 1986-92 Numerical Recipes Software '%1&&Yw^2.
      SUBROUTINE dsvbksb(u,w,v,m,n,mp,np,b,x)
      INTEGER m,mp,n,np,NMAX
      DOUBLE PRECISION b(mp),u(mp,np),v(np,np),w(np),x(np)
      PARAMETER (NMAX=500)
      INTEGER i,j,jj
      DOUBLE PRECISION s,tmp(NMAX)
      do 12 j=1,n
        s=0.0d0
        if(w(j).ne.0.0d0)then
          do 11 i=1,m
            s=s+u(i,j)*b(i)
11        continue
          s=s/w(j)
        endif
        tmp(j)=s
12    continue
      do 14 j=1,n
        s=0.0d0
        do 13 jj=1,n
          s=s+v(j,jj)*tmp(jj)
13      continue
        x(j)=s
14    continue
      return
      END
C  (C) Copr. 1986-92 Numerical Recipes Software '%1&&Yw^2.
      subroutine dsvd(q,u,v,cov,w,p,b,sig,ic,m,n,mm,nn,toler,jc
     1              ,ssq,res)
c-----------------------------------------------------------------------
c svd uses singular-value-decomposition to calculate the least-squares
c solution p to an overdetermined system of linear equations with 
c coefficient matrix q, which includes right hand side vector b.
c
c there are two ways to use svd:
c 1 given an overdetermined system, svd will orthogonalize
c   a and b and produce the least-squares solution.
c 2 given an orthogonalized a (i.e. output from 1),
c   svd will orthogonalize b with respect to a and produce
c   the least-squares solution. this allows the use of
c   multiple r.h.s. without reorthogonalizing a.
c-----------------------------------------------------------------------
c description of parameters:
c ic     an input code which must be set to 1 or 2
c m      the number of equations (rows of q) to solve.
c n      the total number of columns of q to be used (<nn)
c nn   the number of columns of q, at least n+1.
c mm   the number of rows of q, at least nn+m.
c q      an mm-by-nn array which on entry must contain the 
c        matrix a in its first m rows and n columns, and the vector 
c        b in its first m rows of column mm. on exit the residual 
c        of equation i is stored in q(i,mm), i=1 to m.
c sig    measurement error (standard deviation) for the rhs
c        from the calling program (can be set to 1.)
c u      an mm-by-nn matrix used in svd, replaced by "left" matrix u
c v      an nn-by-nn matrix of n "right" eigenvectors of q (=u)
c w      an nn-diagonal vector(matrix) of n eigenvalues of q (u)
c cov    an output covariance matrix between eigenvectors of q (u)
c toler  an input tolerance, for acceptable matrix condition number
c p      an output array of dimension at least nn containing
c        the least-squares solution in positions 1 to n.
c jc     an output code which is set to the index of the
c        1st dependent column, if such a column is detected.
c ssq    sum of squares of the residuals
c res    the largest residual in magnitude
c-----------------------------------------------------------------------
c history:
c	 written by j. cherniawsky, august 1997
c        last modified              august 1998
c-----------------------------------------------------------------------
      parameter (nwt=100)      ! make nwt > expected value of nn
      implicit real*8 (a-h,o-z)
	dimension q(mm,nn)
      dimension u(mm,nn),v(nn,nn),cov(nn,nn)
     1                ,w(nn),b(mm),p(nn),wti(nwt),sig(mm)
      external dsvdcmp,dsvbksb  ! from Numerical Recipes
      jc=0
      do i=1,mm
        b(i)=q(i,nn)
      enddo
c no need to solve if only rhs has changed
      if(ic.eq.2) go to 10
c define a "design matrix" u(=a) and set-up working arrays
      do j=1,nn
        do i=1,mm
          u(i,j)=q(i,j)
        enddo
      enddo
c compute svd decomposition of u(=a), with a being replaced by its upper
c matrix u, viz a=u*w*transpose(v), and vector w is output of a diagonal 
c matrix of singular values w(i), i=1,n.
      call dsvdcmp(u,m,n,mm,nn,w,v)
c check for small singular values
      wmax=0.d0
      do j=1,n
        if(w(j).gt.wmax) wmax=w(j)
      enddo
      thresh=toler*wmax
      do j=1,n
        if(w(j).lt.thresh) then
          w(j)=0.d0
          if(jc.lt.1) jc=j
        endif
      enddo
   10 eps=1.d-10
c compute summation weights (wti, used below)
      do j=1,n
        wti(j)=0.d0
        if(w(j).gt.eps) then
c         wti(j)=sig(j)*sig(j)/(w(j)*w(j))
          wti(j)=1.d0/(w(j)*w(j))
        endif
      enddo
c use back-substitution to compute the solution p(i), i=1,n
      call dsvbksb(u,w,v,m,n,mm,nn,b,p)
c compute chisq (=ssq) and the largest residual (res)
      ssq=0.
      res=0.
      do i=1,m
        sum=0.d0
        do j=1,n
          sum=sum+p(j)*q(i,j)
        enddo
        resi=abs(b(i)-sum)
        res=max(res,resi)
        ssq=ssq+resi**2
      enddo
c compute variances, covariances, these may need to be given dimension
c of b(i), e.g., using sig(i), but this is better done after return to main
      do i=1,n
        do j=1,i
          sum=0.d0
          do k=1,n
            sum=sum+v(i,k)*v(j,k)*wti(k)
          enddo
          cov(i,j)=sum
          cov(j,i)=sum
        enddo
      enddo
      return
      end
      SUBROUTINE dsvdcmp(a,m,n,mp,np,w,v)
      INTEGER m,mp,n,np,NMAX
      DOUBLE PRECISION a(mp,np),v(np,np),w(np)
      PARAMETER (NMAX=500)
CU    USES dpythag
      INTEGER i,its,j,jj,k,l,nm
      DOUBLE PRECISION anorm,c,f,g,h,s,scale,x,y,z,rv1(NMAX),dpythag
      g=0.0d0
      scale=0.0d0
      anorm=0.0d0
      do 25 i=1,n
        l=i+1
        rv1(i)=scale*g
        g=0.0d0
        s=0.0d0
        scale=0.0d0
        if(i.le.m)then
          do 11 k=i,m
            scale=scale+abs(a(k,i))
11        continue
          if(scale.ne.0.0d0)then
            do 12 k=i,m
              a(k,i)=a(k,i)/scale
              s=s+a(k,i)*a(k,i)
12          continue
            f=a(i,i)
            g=-sign(sqrt(s),f)
            h=f*g-s
            a(i,i)=f-g
            do 15 j=l,n
              s=0.0d0
              do 13 k=i,m
                s=s+a(k,i)*a(k,j)
13            continue
              f=s/h
              do 14 k=i,m
                a(k,j)=a(k,j)+f*a(k,i)
14            continue
15          continue
            do 16 k=i,m
              a(k,i)=scale*a(k,i)
16          continue
          endif
        endif
        w(i)=scale *g
        g=0.0d0
        s=0.0d0
        scale=0.0d0
        if((i.le.m).and.(i.ne.n))then
          do 17 k=l,n
            scale=scale+abs(a(i,k))
17        continue
          if(scale.ne.0.0d0)then
            do 18 k=l,n
              a(i,k)=a(i,k)/scale
              s=s+a(i,k)*a(i,k)
18          continue
            f=a(i,l)
            g=-sign(sqrt(s),f)
            h=f*g-s
            a(i,l)=f-g
            do 19 k=l,n
              rv1(k)=a(i,k)/h
19          continue
            do 23 j=l,m
              s=0.0d0
              do 21 k=l,n
                s=s+a(j,k)*a(i,k)
21            continue
              do 22 k=l,n
                a(j,k)=a(j,k)+s*rv1(k)
22            continue
23          continue
            do 24 k=l,n
              a(i,k)=scale*a(i,k)
24          continue
          endif
        endif
        anorm=max(anorm,(abs(w(i))+abs(rv1(i))))
25    continue
      do 32 i=n,1,-1
        if(i.lt.n)then
          if(g.ne.0.0d0)then
            do 26 j=l,n
              v(j,i)=(a(i,j)/a(i,l))/g
26          continue
            do 29 j=l,n
              s=0.0d0
              do 27 k=l,n
                s=s+a(i,k)*v(k,j)
27            continue
              do 28 k=l,n
                v(k,j)=v(k,j)+s*v(k,i)
28            continue
29          continue
          endif
          do 31 j=l,n
            v(i,j)=0.0d0
            v(j,i)=0.0d0
31        continue
        endif
        v(i,i)=1.0d0
        g=rv1(i)
        l=i
32    continue
      do 39 i=min(m,n),1,-1
        l=i+1
        g=w(i)
        do 33 j=l,n
          a(i,j)=0.0d0
33      continue
        if(g.ne.0.0d0)then
          g=1.0d0/g
          do 36 j=l,n
            s=0.0d0
            do 34 k=l,m
              s=s+a(k,i)*a(k,j)
34          continue
            f=(s/a(i,i))*g
            do 35 k=i,m
              a(k,j)=a(k,j)+f*a(k,i)
35          continue
36        continue
          do 37 j=i,m
            a(j,i)=a(j,i)*g
37        continue
        else
          do 38 j= i,m
            a(j,i)=0.0d0
38        continue
        endif
        a(i,i)=a(i,i)+1.0d0
39    continue
      do 49 k=n,1,-1
        do 48 its=1,30
          do 41 l=k,1,-1
            nm=l-1
            if((abs(rv1(l))+anorm).eq.anorm)  goto 2
            if((abs(w(nm))+anorm).eq.anorm)  goto 1
41        continue
1         c=0.0d0
          s=1.0d0
          do 43 i=l,k
            f=s*rv1(i)
            rv1(i)=c*rv1(i)
            if((abs(f)+anorm).eq.anorm) goto 2
            g=w(i)
            h=dpythag(f,g)
            w(i)=h
            h=1.0d0/h
            c= (g*h)
            s=-(f*h)
            do 42 j=1,m
              y=a(j,nm)
              z=a(j,i)
              a(j,nm)=(y*c)+(z*s)
              a(j,i)=-(y*s)+(z*c)
42          continue
43        continue
2         z=w(k)
          if(l.eq.k)then
            if(z.lt.0.0d0)then
              w(k)=-z
              do 44 j=1,n
                v(j,k)=-v(j,k)
44            continue
            endif
            goto 3
          endif
          if(its.eq.30) pause 'no convergence in svdcmp'
          x=w(l)
          nm=k-1
          y=w(nm)
          g=rv1(nm)
          h=rv1(k)
          f=((y-z)*(y+z)+(g-h)*(g+h))/(2.0d0*h*y)
          g=dpythag(f,1.0d0)
          f=((x-z)*(x+z)+h*((y/(f+sign(g,f)))-h))/x
          c=1.0d0
          s=1.0d0
          do 47 j=l,nm
            i=j+1
            g=rv1(i)
            y=w(i)
            h=s*g
            g=c*g
            z=dpythag(f,h)
            rv1(j)=z
            c=f/z
            s=h/z
            f= (x*c)+(g*s)
            g=-(x*s)+(g*c)
            h=y*s
            y=y*c
            do 45 jj=1,n
              x=v(jj,j)
              z=v(jj,i)
              v(jj,j)= (x*c)+(z*s)
              v(jj,i)=-(x*s)+(z*c)
45          continue
            z=dpythag(f,h)
            w(j)=z
            if(z.ne.0.0d0)then
              z=1.0d0/z
              c=f*z
              s=h*z
            endif
            f= (c*g)+(s*y)
            x=-(s*g)+(c*y)
            do 46 jj=1,m
              y=a(jj,j)
              z=a(jj,i)
              a(jj,j)= (y*c)+(z*s)
              a(jj,i)=-(y*s)+(z*c)
46          continue
47        continue
          rv1(l)=0.0d0
          rv1(k)=f
          w(k)=x
48      continue
3       continue
49    continue
      return
      END
C  (C) Copr. 1986-92 Numerical Recipes Software '%1&&Yw^2.
      SUBROUTINE GDAY(IDD,IMM,IYY,ICC,KD)
C!
C!  GIVEN DAY,MONTH,YEAR AND CENTURY(EACH 2 DIGITS), GDAY RETURNS
C!  THE DAY#, KD BASED ON THE GREGORIAN CALENDAR.
C!  THE GREGORIAN CALENDAR, CURRENTLY 'UNIVERSALLY' IN USE WAS
C!  INITIATED IN EUROPE IN THE SIXTEENTH CENTURY. NOTE THAT GDAY
C!  IS VALID ONLY FOR GREGORIAN CALENDAR DATES.
C
C   KD=1 CORRESPONDS TO JANUARY 1, 0000
C	
c 	Note that the Gregorian reform of the Julian calendar 
c	omitted 10 days in 1582 in order to restore the date
c	of the vernal equinox to March 21 (the day after
c	Oct 4, 1582 became Oct 15, 1582), and revised the leap 
c	year rule so that centurial years not divisible by 400
c	were not leap years.
c
C   THIS ROUTINE WAS WRITTEN BY EUGENE NEUFELD, AT IOS, IN JUNE 1990.
C
      INTEGER NDP(13)
      INTEGER NDM(12)
      DATA NDP/0,31,59,90,120,151,181,212,243,273,304,334,365/
      DATA NDM/31,28,31,30,31,30,31,31,30,31,30,31/
C!
      LP = 6
C!  TEST FOR INVALID INPUT:
c	write(6,*) ' idd,imm,iyy,icc=',idd,imm,iyy,icc
      IF(ICC.LT.0)THEN
	 WRITE(LP,5000)ICC
	 STOP
      ENDIF
      IF(IYY.LT.0.OR.IYY.GT.99)THEN
	 WRITE(LP,5010)IYY
	 STOP
      ENDIF
      IF(IMM.LE.0.OR.IMM.GT.12)THEN
	 WRITE(LP,5020)IMM
	 STOP
      ENDIF
      IF(IDD.LE.0)THEN
	 WRITE(LP,5030)IDD
	 STOP
      ENDIF
      IF(IMM.NE.2.AND.IDD.GT.NDM(IMM))THEN
	 WRITE(LP,5030)IDD
	 STOP
      ENDIF
      IF(IMM.EQ.2.AND.IDD.GT.29)THEN
	 WRITE(LP,5030)IDD
	 STOP
      ENDIF
      IF(IMM.EQ.2.AND.IDD.GT.28.AND.((IYY/4)*4-IYY.NE.0.OR.(IYY.EQ.0.AND
     .    .(ICC/4)*4-ICC.NE.0)))THEN
	 WRITE(LP,5030)IDD
	 STOP
      ENDIF
5000  FORMAT(' INPUT ERROR. ICC = ',I7)
5010  FORMAT(' INPUT ERROR. IYY = ',I7)
5020  FORMAT(' INPUT ERROR. IMM = ',I7)
5030  FORMAT(' INPUT ERROR. IDD = ',I7)
C!
C!  CALCULATE DAY# OF LAST DAY OF LAST CENTURY:
      KD = ICC*36524 + (ICC+3)/4
C!
C!  CALCULATE DAY# OF LAST DAY OF LAST YEAR:
      KD = KD + IYY*365 + (IYY+3)/4
C!
C!  ADJUST FOR CENTURY RULE:
C!  (VIZ. NO LEAP-YEARS ON CENTURYS EXCEPT WHEN THE 2-DIGIT
C!  CENTURY IS DIVISIBLE BY 4.)
      IF(IYY.GT.0.AND.(ICC-(ICC/4)*4).NE.0) KD=KD-1
C!  KD NOW TRULY REPRESENTS THE DAY# OF THE LAST DAY OF LAST YEAR.
C!
C!  CALCULATE DAY# OF LAST DAY OF LAST MONTH:
      KD = KD + NDP(IMM)
C!
C!  ADJUST FOR LEAP YEARS:
      IF(IMM.GT.2.AND.((IYY/4)*4-IYY).EQ.0.AND.((IYY.NE.0).OR.
     .   (((ICC/4)*4-ICC).EQ.0)))   KD=KD+1
C!  KD NOW TRULY REPRESENTS THE DAY# OF THE LAST DAY OF THE LAST
C!  MONTH.
C!
C!  CALCULATE THE CURRENT DAY#:
      KD = KD + IDD
      RETURN
C!
C!
      ENTRY DMY(IDD,IMM,IYY,ICC,KD)
C!
C!  GIVEN THE (GREGORIAN) DAY#, KD, AS CALCULATED ABOVE IN THIS ROUTINE,
C!  ENTRY DMY RETURNS THE (GREGORIAN) DAY, MONTH, YEAR AND CENTURY.
C!
C!  TEST FOR VALID INPUT:
      IF(KD.LE.0) WRITE(LP,5040)KD
5040  FORMAT(' KD = ',I7,'  INVALID INPUT. DMY STOP.')
C!
C!  SAVE KD
      KKD=KD
C!  CALCULATE ICC AND SUBTRACT THE NUMBER OF DAYS REPRESENTED BY ICC
C!  FROM KKD
C!  JFH IS THE NUMBER OF 400 YEAR INTERVALS UP TO KKD
C!  JCC IS THE NUMBER OF ADDITIONAL CENTURIES UP TO KKD
      JFH = KKD/146097
      KKD = KKD - JFH*146097
      IF(KKD.LT.36525)THEN
	 JCC = 0
      ELSE
	 KKD = KKD - 36525
	 JCC = 1 + KKD/36524
	 KKD = KKD - (JCC-1)*36524
      END IF
      ICC = 4*JFH + JCC
      IF(KKD.EQ.0)THEN
	 ICC = ICC-1
	 IYY = 99
	 IMM = 12
	 IDD = 31
	 RETURN
      ENDIF
C!
C!  CALCULATE IYY. JFY IS THE NUMBER OF FOUR YEAR INTERVALS IN THE
C!  CURRENT CENTURY. THE FIRST FOUR YEAR INTERVAL IS SHORT (1460 DAYS
C!  RATHER THAN 1461)IF THE CURRENT CENTURY IS NOT DIVISIBLE BY 4, AND
C!  IN THIS CASE JCC.NE.0 AS CALCULATED ABOVE.
C!
C!  CALCULATE JFY:
      JFY = 0
      IF(JCC.EQ.0)GOTO 10
      IF(KKD.LT.1460)GOTO 10
      JFY = 1
      KKD = KKD - 1460
10    KK = KKD/1461
      JFY = JFY + KK
      KKD = KKD - KK*1461
C!
C!  CALCULATE JYY, THE REMAINING YEARS OF THE CURRENT CENTURY UP TO THE
C!  CURRENT DAY:
      JYY = 0
C!  THE NEXT YEAR IS NOT A LEAP YEAR IF JFY=0 AND JCC.NE.0.
      IF(JFY.EQ.0.AND.JCC.NE.0)GOTO 20
      IF(KKD.LT.366)GOTO 30
      JYY = 1
      KKD = KKD - 366
20    JYYY = KKD/365
      JYY = JYY + JYYY
      KKD = KKD - JYYY*365
30    IYY = 4*JFY + JYY
      IF(KKD.EQ.0) THEN
	 IYY=IYY-1
	 IMM=12
	 IDD=31
	 RETURN
      END IF
C!
C!  SET L=1 IF WE HAVE A LEAP YEAR.
      L=0
      IF(IYY-(IYY/4)*4.NE.0)GOTO 40
      IF(IYY.EQ.0.AND.(ICC-(ICC/4)*4).NE.0)GOTO 40
      L=1
C!
C!  CALCULATE IMM AND IDD
40    IF(KKD.GT.31) GOTO 50
      IMM=1
      IDD=KKD
      RETURN
C!
50    IF(KKD.GT.59)GOTO 60
      IMM = 2
      IDD = KKD-31
      RETURN
C!
60    IF(KKD.GT.60)GOTO 70
      IF(L.EQ.0)GOTO 70
      IMM = 2
      IDD = 29
      RETURN
C!
70    IF(L.EQ.1) KKD=KKD-1
      DO 80 I=4,13
	 IF(KKD.GT.NDP(I))GOTO 80
	 IMM = I-1
	 IDD = KKD - NDP(I-1)
	 RETURN
C!
80    CONTINUE
90    WRITE(LP,5050)
5050  FORMAT(' ERROR IN DMY.')
      STOP
      END
      FUNCTION julday(mm,id,iyyy)
      INTEGER julday,id,iyyy,mm,IGREG
      PARAMETER (IGREG=15+31*(10+12*1582))
      INTEGER ja,jm,jy
      jy=iyyy
      if (jy.eq.0) pause 'julday: there is no year zero'
      if (jy.lt.0) jy=jy+1
      if (mm.gt.2) then
        jm=mm+1
      else
        jy=jy-1
        jm=mm+13
      endif
      julday=int(365.25*jy)+int(30.6001*jm)+id+1720995
      if (id+31*(mm+12*iyyy).ge.IGREG) then
        ja=int(0.01*jy)
        julday=julday+2-ja+int(0.25*ja)
      endif
      return
      END
C  (C) Copr. 1986-92 Numerical Recipes Software #i7&12$.
c
      function mjd(mm,id,iy)
c
c calculates Modified Julian Date (in days), as used by the T/P Pathfinder 
c team (J.Ch., Dec. 9, 1997)
c
      integer jd,julday,mm,id,iy,iyyy
      iyyy=iy
      if(iy.lt.200) iyyy=iy+1900
      jd=julday(mm,id,iyyy)
      mjd=jd-2400001
      return
      end
      subroutine svd(q,u,v,cov,w,p,b,sig,ic,m,n,mm,nn,toler,jc
     1              ,ssq,res)
c-----------------------------------------------------------------------
c svd uses singular-value-decomposition to calculate the least-squares
c solution p to an overdetermined system of linear equations with 
c coefficient matrix q, which includes right hand side vector b.
c
c there are two ways to use svd:
c 1 given an overdetermined system, svd will orthogonalize
c   a and b and produce the least-squares solution.
c 2 given an orthogonalized a (i.e. output from 1),
c   svd will orthogonalize b with respect to a and produce
c   the least-squares solution. this allows the use of
c   multiple r.h.s. without reorthogonalizing a.
c-----------------------------------------------------------------------
c description of parameters:
c ic     an input code which must be set to 1 or 2
c m      the number of equations (rows of q) to solve.
c n      the total number of columns of q to be used (<nn)
c nn   the number of columns of q, at least n+1.
c mm   the number of rows of q, at least nn+m.
c q      an mm-by-nn array which on entry must contain the 
c        matrix a in its first m rows and n columns, and the vector 
c        b in its first m rows of column mm. on exit the residual 
c        of equation i is stored in q(i,nn), i=1 to m.
c sig    measurement error (standard deviation) for the rhs
c        from the calling program (can be set to 1.)
c u      an mm-by-nn matrix used in svd, replaced by "left" matrix u
c v      an nn-by-nn matrix of n "right" eigenvectors of q (=u)
c w      an nn-diagonal vector(matrix) of n eigenvalues of q (u)
c cov    an output covariance matrix between eigenvectors of q (u)
c toler  an input tolerance, for acceptable matrix condition number
c p      an output array of dimension at least nn containing
c        the least-squares solution in positions 1 to n.
c jc     an output code which is set to the index of the
c        1st dependent column, if such a column is detected.
c ssq    sum of squares of the residuals
c res    the largest residual in magnitude
c-----------------------------------------------------------------------
c history:
c	 written by j. cherniawsky, august 1997
c        last modified              august 1998
c-----------------------------------------------------------------------
      parameter (nwt=302)      ! make nwt > expected value of nn
      dimension q(mm,nn)
      double precision u(mm,nn),v(nn,nn),cov(nn,nn)
     1                ,w(nn),b(mm),p(nn),wti(nwt),sig(mm)
      external dsvdcmp,dsvbksb  ! from Numerical Recipes
      jc=0
      do i=1,mm
        b(i)=q(i,nn)
      enddo
c no need to solve if only rhs has changed
      if(ic.eq.2) go to 10
c define a "design matrix" u(=a) and set-up working arrays
      do j=1,nn
        do i=1,mm
          u(i,j)=q(i,j)
        enddo
      enddo
c compute svd decomposition of u(=a), with a being replaced by its upper
c matrix u, viz a=u*w*transpose(v), and vector w is output of a diagonal 
c matrix of singular values w(i), i=1,n.
      call dsvdcmp(u,m,n,mm,nn,w,v)
c check for small singular values
      wmax=0.
      do j=1,n
        if(w(j).gt.wmax) wmax=w(j)
      enddo
      thresh=toler*wmax
      do j=1,n
        if(w(j).lt.thresh) then
          w(j)=0.d0
          if(jc.lt.1) jc=j
        endif
      enddo
   10 eps=1.d-10
c compute summation weights (wti, used below)
      do j=1,n
        wti(j)=0.d0
        if(w(j).gt.eps) then
c         wti(j)=sig(j)*sig(j)/(w(j)*w(j))
          wti(j)=1.d0/(w(j)*w(j))
        endif
      enddo
c use back-substitution to compute the solution p(i), i=1,n
      call dsvbksb(u,w,v,m,n,mm,nn,b,p)
c compute chisq (=ssq) and the largest residual (res)
      ssq=0.
      res=0.
      do i=1,m
        sum=0.d0
        do j=1,n
          sum=sum+p(j)*q(i,j)
        enddo
        resi=abs(b(i)-sum)
c	mf addition
	  q(i,nn)=b(i)-sum
        res=max(res,resi)
        ssq=ssq+resi**2
      enddo
c compute variances, covariances, these may need to be given dimension
c of b(i), e.g., using sig(i), but this is better done after return to main
      do i=1,n
        do j=1,i
          sum=0.d0
          do k=1,n
            sum=sum+v(i,k)*v(j,k)*wti(k)
          enddo
          cov(i,j)=sum
          cov(j,i)=sum
        enddo
      enddo
      return
      end
      SUBROUTINE VUF (hr,KONX,Vx,ux,FX,XLAT)
C
C***********************************************************************
C*  THIS SUBROUTINE CALCULATES V (ASTRONOMICAL PHASE ARGUMENT), U AND F
C*  (NODAL MODULATION PHASE AND AMPLITUDE CORRECTIONS) FOR ALL CONSTITU-
C*  ENTS.
c*
C*	This October 1992 version also recalculates the constituent
c	frequencies for the middle of the analysis period
C
C     PARAMETER (MC=28,MC2=MC*2)
      PARAMETER (MC=70,MC2=MC*2)
      character*5 KONTAB(MC),KON,KBLANK,KONCO,KONX
      real*8 d1,h,pp,s,p,enp,dh,dpp,ds,dp,dnp,hh,tau,dtau,hr
      DIMENSION KON(170),V(170),F(170),NJ(170),II(MC2),JJ(MC2),KK(MC2),
     1 LL(MC2),MM(MC2),NN(MC2),SEMI(MC2),u(170)
      DIMENSION EE(180),LDEL(180),MDEL(180),NDEL(180),IR(180),PH(180)
      DIMENSION KONCO(320),COEF(320),indx(170)
      DIMENSION freq(MC)
      common /const/freq,mtot,kontab
      DATA KBLANK/'     '/
C
C***********************************************************************
C*  THE DIMENSION OF KON, VU, F, AND NJ SHOULD BE AT LEAST EQUAL TO THE
C*  TOTAL NUMBER OF POSSIBLE CONSTITUENTS (PRESENTLY 146), THE DIMENSION
C*  OF II, JJ, KK, LL, MM, NN AND SEMI SHOULD BE AT LEAST EQUAL TO THE
C*  NUMBER OF MAIN CONSTITUENTS (PRESENTLY 45), THE DIMENSION OF EE,
C*  LDEL, MDEL, NDEL, IR, AND PH SHOULD BE AT LEAST EQUAL TO THE TOTAL
C*  NUMBER OF SATELLITES TO ALL THE MAIN CONSTITUENTS PLUS THE NUMBER
C*  OF CONSTITUENTS WITH NO SATELLITES (PRESENTLY 162+8),
C*  AND THE DIMENSION OF KONCO, AND COEFF SHOULD BE AT LEAST EQUAL TO
C*  THE SUM FOR ALL SHALLOW WATER CONSTITUENTS OF THE NUMBER OF MAIN
C*  CONSTITUENTS FROM WHICH EACH IS DERIVED (PRESENTLY 251).
C***********************************************************************
C* GIVEN CONSTITUENT KONX , THE NODAL CORRECTIONS V+U AND F ARE RETURNED
C
      DO 20 K=1,NTOTAL
      IF(KON(K).eq.KONX) go to 40
20    CONTINUE
      WRITE(LP,30)KONX
30    FORMAT('VUF STOP.',A5)
      STOP
40    VX=V(K)
      ux=u(k)
      FX=F(K)
      RETURN
C
C***********************************************************************
C*  THE ASTRONOMICAL ARGUMENTS AND THEIR RATES OF CHANGE,
C*  S0,H0,P0,ENP0,PP0,DS,DH,DP,DNP,DPP,  ARE READ FROM TWO RECORDS IN
C*  THE FORMAT(5F13.10):
C*     S0  = MEAN LONGITUDE OF THE MOON (CYCLES) AT 000 ET 1/1/1976.
C*     H0  = MEAN LONGITUDE OF THE SUN.
C*     P0  = MEAN LONGITUDE OF THE LUNAR PERIGEE.
C*     ENP0= NEGATIVE OF THE MEAN LONGITUDE OF THE ASCENDING NODE.
C*     PP0 = MEAN LONGITUDE OF THE SOLAR PERIGEE (PERIHELION).
C*     DS,DH,DP,DNP,DPP ARE THEIR RESPECTIVE RATES OF CHANGE OVER A 365
C*     DAY PERIOD AS OF 000 ET 1/1/1976.
C
      ENTRY OPNVUF(hr,KONX,VX,ux,FX,XLAT)
      KR=8
      LP=6
      PI=3.1415926536
      TWOPI=2.*PI
c	These values are no longer used though they are still
c	read in. More accurate polynomial approximations are 
c	now employed.
      READ(KR,50)S0,H0,P0,ENP0,PP0,DS,DH,DP,DNP,DPP
 50   FORMAT(5F13.10)
C
C***********************************************************************
C*  HERE THE MAIN CONSTITUENTS AND THEIR DOODSON NUMBERS ARE READ IN
C*  FORMAT (6X,A5,1X,6I3,F5.2,I4). THE VALUES ARE RESPECTIVELY
C*     KON    = CONSTITUENT NAME
C*  II,JJ,KK,LL,MM,NN = THE SIX DOODSON NUMBERS
C*     SEMI   = PHASE CORRECTION
C*     NJ     = THE NUMBER OF SATELLITES FOR THIS CONSTITUENT.
C*  THE END OF ALL MAIN CONSTITUENTS IS DENOTED BY A BLANK CARD.
C
      JBASE=0
      DO 90 K=1,1000
      READ(KR,60)KON(K),II(K),JJ(K),KK(K),LL(K),MM(K),NN(K),SEMI(K),
     2 NJ(K)
      IF(KON(K).eq.KBLANK) go to 100
70    J1=JBASE+1
      IF(NJ(K).GE.1) GO TO 75
      NJ(K)=1
      JL=J1
      PH(J1)=0.
      EE(J1)=0.
      LDEL(J1)=0
      MDEL(J1)=0
      NDEL(J1)=0
      IR(J1)=0
      GO TO 90
75    JL=JBASE+NJ(K)
C
C***********************************************************************
C*  IF NJ>0, INFORMATION ON THE SATELLITE CONSTITUENTS IS READ , THREE
C*  SATELLITES PER CARD, IN THE FORMAT (11X,3(3I3,F4.2,F7.4,1X,I1,1X)).
C*  FOR EACH SATELLITE THE VALUES READ ARE
C*     LDEL,MDEL,NDEL = THE CHANGES IN THE LAST THREE DOODSON NUMBERS
C*                  FROM THOSE OF THE MAIN CONSTITUENT.
C*     PH     = THE PHASE CORRECTION
C*     EE     = THE AMPLITUDE RATIO OF THE SATELLITE TIDAL POTENTIAL TO
C*            THAT OF THE MAIN CONSTITUENT.
C*     IR     = 1 IF THE AMPLITUDE RATIO HAS TO BE MULTIPLIED BY THE
C*            LATITUDE CORRECTION FACTOR FOR DIURNAL CONSTITUENTS
C*            2 IF THE AMPLITUDE RATIO HAS TO BE MULTIPLIED BY THE
C*            LATITUDE CORRECTION FACTOR FOR SEMI-DIURNAL CONSTI-
C*            TUENTS.
C*            OTHERWISE IF NO CORRECTION IS REQUIRED TO THE AMPLITUDE
C*            RATIO.
C
      READ(KR,80)(LDEL(J),MDEL(J),NDEL(J),PH(J),EE(J),IR(J),J=J1,JL)
90    JBASE=JL
60    FORMAT(6X,A5,1X,6I3,F5.2,I4)
80    FORMAT((11X,3(3I3,F4.2,F7.4,1X,I1,1X)))
100   NTIDAL=K-1
C
C***********************************************************************
C*  THE SHALLOW WATER CONSTITUENTS AND THE MAIN CONSTITUENTS FROM WHICH
C*  THEY ARE DERIVED ARE READ IN HERE WITH THE FORMAT
C*  (6X,A5,I1,2X,4(F5.2,A5,5X)). THE VALUES ARE RESPECTIVELY
C*     KON    = NAME  OF THE SHALLOW WATER CONSTITUENT
C*     NJ     = NUMBER OF MAIN CONSTITUENTS FROM WHICH IT IS DERIVED.
C*     COEF,KONCO = COMBINATION NUMBER AND NAME OF THESE MAIN
C*              CONSTITUENTS.
C*  THE END OF THESE CONSTITUENTS IS DENOTED BY A BLANK CARD.
C
      JBASE=0
      K1=NTIDAL+1
      DO 160 K=K1,1000
      J1=JBASE+1
      J4=J1+3
      READ(KR,130)KON(K),NJ(K),(COEF(J),KONCO(J),J=J1,J4)
      IF(KON(K).eq.KBLANK) go to 170
160   JBASE=JBASE+NJ(K)
130   FORMAT(6X,A5,I1,2X,4(F5.2,A5,5X))
170   NTOTAL=K-1
      RETURN
C
C***********************************************************************
C*  NTIDAL IS THE NUMBER OF MAIN CONSTITUENTS
C*  NTOTAL IS THE NUMBER OF CONSTITUENTS (MAIN + SHALLOW WATER)
C*  FOR  THE GIVEN TIME hr, THE TABLE OF F AND V+U VALUES IS
C*  CALCULATED FOR ALL THE CONSTITUENTS.
C*     F IS THE NODAL MODULATION ADJUSTMENT FACTOR FOR AMPLITUDE
C*     U IS THE NODAL MODULATION ADJUSTMENT FACTOR FOR PHASE
C*     V IS THE ASTRONOMICAL ARGUMENT ADJUSTMENT FOR PHASE.
c
c	setvuf calculates the V,u,f values at time hr for all constituents
C
      ENTRY SETVUF(hr,KONX,VX,ux,FX,XLAT)
      SLAT=SIN(PI*XLAT/180.)
c      CALL GDAY(1,1,76,19,KD)
c      YEARS=(hr/24.D0-KD)/365.00D0
C
C***********************************************************************
C*  THE ASTRONOMICAL ARGUMENTS ARE CALCULATED BY LINEAR APPROXIMATION
C*  AT THE MID POINT OF THE ANALYSIS PERIOD.
C
c      S=S0+YEARS*DS
c      H=H0+YEARS*DH
c      P=P0+YEARS*DP
c      ENP=ENP0+YEARS*DNP
c      PP=PP0+YEARS*DPP
c	day number measured from January 0.5 1900 (i.e.,
c	1200 UT December 31, 1899
      d1=hr/24.d0
      call gday(31,12,99,18,kd0)
      d1=d1-dfloat(kd0)-0.5d0
      call astr(d1,h,pp,s,p,enp,dh,dpp,ds,dp,dnp)
      INT24=24
      INTDYS=int((hr+0.00001)/INT24)
      HH=hr-dfloat(INTDYS*INT24)
      TAU=HH/24.D0+H-S
      dtau=365.d0+dh-ds
C
C***********************************************************************
C*  ONLY THE FRACTIONAL PART OF A SOLAR DAY NEED BE RETAINED FOR COMPU-
C*  TING THE LUNAR TIME TAU.
C
      JBASE=0
      DO 210 K=1,NTIDAL
      do 209 l=1,mtot
      if(kon(k).eq.kontab(l)) then
c      FREQ(l)=(II(K)*DTAU+JJ(K)*DS+KK(K)*DH+LL(K)*DP+MM(K)*DNP+
c     1NN(K)*DPP)/(365.*24.)
      indx(k)=l
      end if
209   continue
      VDBL=II(K)*TAU+JJ(K)*S+KK(K)*H+LL(K)*P+MM(K)*ENP+NN(K)*PP+SEMI(K)
      IV=VDBL
      IV=(IV/2)*2
      Vv=VDBL-IV
      J1=JBASE+1
      JL=JBASE+NJ(K)
      SUMC=1.
      SUMS=0.
      DO 200 J=J1,JL
C
C***********************************************************************
C*  HERE THE SATELLITE AMPLITUDE RATIO ADJUSTMENT FOR LATITUDE IS MADE
C
      RR=EE(J)
      L=IR(J)+1
      GO TO (901,902,903),L
  902 RR=EE(J)*0.36309*(1.-5.*SLAT*SLAT)/SLAT
      GO TO 901
  903 RR=EE(J)*2.59808*SLAT
  901 CONTINUE
      UUDBL=LDEL(J)*P+MDEL(J)*ENP+NDEL(J)*PP+PH(J)
      IUU=UUDBL
      UU=UUDBL-IUU
      SUMC=SUMC+RR*COS(UU*TWOPI)
      SUMS=SUMS+RR*SIN(UU*TWOPI)
  200 CONTINUE
      F(K)=SQRT(SUMC*SUMC+SUMS*SUMS)
      v(k)=vv
      U(K)=ATAN2(SUMS,SUMC)/TWOPI
210   JBASE=JL
C
C***********************************************************************
C*  HERE F AND V+U OF THE SHALLOW WATER CONSTITUENTS ARE COMPUTED FROM
C*  THE VALUES OF THE MAIN CONSTITUENT FROM WHICH THEY ARE DERIVED.
C
      JBASE=0
      K1=NTIDAL+1
      IF(K1.GT.NTOTAL) RETURN
      DO 270 K=K1,NTOTAL
      F(K)=1.0
      V(K)=0.0
      u(k)=0.
      iflag=0
      do 269 lk=1,mtot
      if(kon(k).eq.kontab(lk)) then
c      FREQ(lk)=0.
      iflag=1
      go to 268
      end if
269   continue
268   J1=JBASE+1
      JL=JBASE+NJ(K)
      DO 260 J=J1,JL
      KM1=K-1
      DO 240 L=1,KM1
      IF(KON(L).eq.KONCO(J)) go to 250
240   CONTINUE
      WRITE(LP,241)KONCO(J)
241   FORMAT('  SETVUF STOP.',A5)
      STOP
250   F(K)=F(K)*F(L)**ABS(COEF(J))
      V(K)=V(K)+COEF(J)*V(L)
      U(K)=U(K)+COEF(J)*U(L)
c      if(iflag.eq.1) FREQ(lk)=FREQ(lk)+COEF(J)*FREQ(indx(L))
260   continue
270   JBASE=JL
      RETURN
      END
