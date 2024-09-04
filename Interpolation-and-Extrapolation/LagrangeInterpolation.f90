program lagrange 
implicit none
real::xg, l, summation 
integer::n, i, j, k
real, dimension(:), allocatable::x, y
print*, "Please enter the number of dimension of array/number of data points: "
read*, n
allocate(x(n))
allocate(y(n))
print*, "Please enter the values of x and corresponding y respectively"
do i = 1, n 
read*, x(i), y(i)
enddo
print*, "Please enter the value of x at which y is to be interpolated"
read*, xg
summation = 0
do j = 1, n
l = 1 
do k = 1, n
if (k .ne. j) then
l = l*(xg - x(k))/(x(j) - x(k))
endif
enddo
summation = summation + l*y(j)
enddo 
print*, "The interpolated value at", xg, "is", summation 
end program lagrange
