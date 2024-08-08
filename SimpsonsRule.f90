program simpsonsrule 
implicit none 
real, external::f 
real::x, a, b, h, simpson, fodd, feven 
integer::n, i, m
Print*,"Simspon's Integration Method in Fortran"
Print*,"Please enter the lower limit of integration"
read*,a 
Print*,"Please enter the lower limit of integration"
read*,b 
print*,"Please enter the number of sub-intervals"
read*,n 
h = (b-a)/n 
m = n/2
fodd = 0 
do i=0, m-1 
fodd = fodd + f(a + (2*i + 1)*h)
end do 
do i=2, m-2 
feven = feven + f(a + (2*i)*h)
end do
simpson = (h/3.)*(f(a) + f(b) + 4*fodd + 2*feven)
print*,"Lower limit = ", a 
print*,"Upper limit = ", b 
print*,"The integrated value using Simpson's Rule is: ", simpson 
end program simpsonsrule

real function f(x)
real::x
!print,"Enter a function"
!read*,f 
f = x**2
end