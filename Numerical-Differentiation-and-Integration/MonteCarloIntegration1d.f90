program montecarlo1
implicit none 
real, external:: f
integer::n, i 
real:: a, b, p, x, summ, integration, answer, error
print*, "Please enter the lower limit of integration"
read*, a 
print*, "Please enter the upper limit of integration"
read*, b 
print*, "Please enter the numbers of randoms numbers you want to generate for the integration"
read*, n 
summ = 0 
do i = 1, n
p = rand()
x = a+p+p*(b-a-1)
summ = summ + f(x)
end do 
integration = summ * (b-a)/n
answer = (b**3 - a**3) / 3 
!answer = integrated expression of the function entered previously
print*, "The integrated value is ", integration 
print*, "The correct answer is ", answer 
error = abs(integration - answer)*100 / answer 
print*, "The percentage error is ", error 
end program montecarlo1

real function f(x)
real::x 
!f = insert function with a print and read prompt
f = x**2
end
