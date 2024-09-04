program trapezoidalrule
implicit none 
real, external::f
real::a, b, h, p, sum, result
integer::n, i
print*, "Integration using trapezoidal rule"
print*, "Please enter the lower limit of integration"
read*, a 
print*, "Please enter the upper limit of integration"
read*, b
print*, "Please enter the number of sub-intervals"
read*, n 
h = (b - a)/n 
p = (h/2.)*(f(a)+f(b))
sum = 0 
do i = 1, n-1
sum = sum + h*f(a+i*h)
end do 
result = p + sum 
print*, "The result of the integration is ", result 
end program trapezoidalrule 

real function f(x)
!f=#insert function
f = sqrt(1+x**2)
!f = (1+x**2)**0.5
end
