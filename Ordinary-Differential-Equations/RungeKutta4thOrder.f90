program RK4
implicit none
real,external::f
real::x,y,h,xg, k1, k2, k3, k4, dy
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
k1 = h*f(x, y)
k2 = h*f(x+h/2., y+k1*h/2.)
k3 = h*f(x+h/2., y+k2*h/2.)
k4 = h*f(x+h, y+k3*h)
dy = (1/6.)*(k1 + k4 + 2*k2 + 2*k3)
y = y + dy 
enddo
print*,"The value of x and y is", x,y
end program RK4

real function f(x,y)
real::x,y 
!f=#insert function
f = x + 2*y
end
