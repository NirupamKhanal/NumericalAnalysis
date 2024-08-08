program bisection
real,external::f 
real::a,b,c
5 print*,"Please insert the value of a and b in such a way that function value at this point is opposite."
read*,a,b 
if( f(a)*f(b) .gt. 0) then
print*,"Enter proper values"
goto 5 
endif
10 c = (a+b)/2
if( f(c) ==0) then 
print*,"The root of the equation is",c 
endif 
if( f(a)*f(c) .gt. 0) then 
a = c 
goto 10
else
b = c
goto 10    
endif 
end program bisection 

real function f(x)
real::x 
!print,"Enter a function"
!read*,f 
f = 3*x-1
end
