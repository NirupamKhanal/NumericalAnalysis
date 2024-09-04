program newtonraphson 
implicit none 
real::x, iteration
print*,"Please enter the initial guess for the root of equation."
read*,x
call ntrap(x, iteration)
print*,"The root of the expression is", x  
end program newtonraphson

real function f(x)
real::x
!print*,"Please enter the equation in terms of x."
!read*,f
f=3*x**2-1
end function 

real function fd(x)
real::x
!print*,"Please enter the first derivative of the equation in terms of x."
!read*,fd
fd=6*x
end function 

subroutine ntrap(x, iteration)
implicit none 
real,external::f,fd
real::error, tol, x
integer:: iteration 
tol = 0.0000001
iteration = 0
do 
    error = - f(x)/fd(x)
    x = x + error
    iteration = iteration+1
    if (abs(error) .gt. tol) exit 
end do
endif 
print*, "Tolerance is ", tol 
Print*, "Iteration is ", iteration 
end subroutine
