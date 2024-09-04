program SecantMethod
implicit none 
real:: a, b, c, Fa, Fb, Fc, eps
print*, "Enter first point: "
read*, a
print*, "Enter last point: "
read*, b
print*, "Enter error: "
read*, eps

!f(x) = x - 0.5*cos(x)
!Fa = a - 0.5*cos(a)
!Fb = b - 0.5*cos(b) 
Fa = a**2 - 2
Fb = b**2 - 2
c = (a-((b-a)/(Fb - Fa)*Fa))
!Fc = c - 0.5*cos(c)
Fc = c**2 - 2
do 
    if(abs(Fb-Fa)>eps) exit
        if(Fc*Fa < 0) then
        a = c 
        !Fa = a - 0.5*cos(a)
        !Fb = b - 0.5*cos(b)
        Fa = a**2 - 2
        Fb = b**2 - 2
        c = (a-((b-a)/(Fb - Fa)*Fa))
        !Fc = c - 0.5*cos(c)
        Fc = c**2 - 2

        else 
        b = c
        !Fa = a - 0.5*cos(a)
        !Fb = b - 0.5*cos(b)
        Fa = a**2 - 2
        Fb = b**2 - 2
        c = (a-((b-a)/(Fb - Fa)*Fa))
        !Fc = c - 0.5*cos(c)
        Fc = c**2 - 2
        end if
end do
print*, "Fa = ", Fa
print*, "Fb = ", Fb
print*, "Fc = ", Fc
print*, "a = ", a
print*, "b = ", b
print*, "c = ", c
print*, "Margin of error = ", eps

end program