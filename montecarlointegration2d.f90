program montecarlo2
implicit none 
real, external:: f
integer::n, i 
real:: a, b, c, d, p, q, x, y, summ, integration, answer, error
print*, "Please enter the lower limit of integration with respect to dx:"
read*, a 
print*, "Please enter the upper limit of integration with respect to dx:"
read*, b 
print*, "Please enter the lower limit of integration with respect to dy:"
read*, c
print*, "Please enter the upper limit of integration with respect to dy:"
read*, d 
print*, "Please enter the numbers of randoms numbers you want to generate for the integration"
read*, n 
summ = 0 
do i = 1, n
p = rand()
q = rand()
x = a+p+p*(b-a-1)
y = c+q+q*(d-c-1)
summ = summ + f(x, y)
end do 
integration = summ * (b-a)*(d-c)/n
answer = ((b**3 - a**3) / 3) * ((d**4 - c**4) / 4)
!answer = integrated expression of the function entered previously
print*, "The integrated value is ", integration 
print*, "The correct answer is ", answer 
error = abs(integration - answer)*100 / answer 
print*, "The percentage error is ", error 
end program montecarlo2

real function f(x, y)
real::x, y 
!f = insert function with a print and read prompt
f = x**2*y**3
end