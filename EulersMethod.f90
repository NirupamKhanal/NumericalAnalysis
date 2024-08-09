program Eulers Method
implicit none
real,external::f
real::x,y,h,xg
integer::n,i 
print*, "Please insert initial value condition of x, i.e. x0"
read*,x
print*, "Please insert initial value condition of y, i.e. y0"
read*,y 
print*, "Please insert the width of the x (i.e. interval) or value of h"
read*,h
print*, "Please insert the value of x at which the solution is found/given"
read*,xg
!print*, "Insert the funciton"
!read*,f
n=int((xg-x)/h+0.5)
do i=1,n 
x=x+h
y=y+h*f(x,y)
enddo
print*,"The value of x and y is", x,y
end 

real function f(x,y)
real::x,y 
!f=#insert function#
end
