program gauss_quadrature
    implicit none
    integer :: g
    real(8) :: a, b, result

    ! Input the lower and upper limits
    print *, "Enter the lower limit: "
    read *, a
    print *, "Enter the upper limit: "
    read *, b

    ! Input the number of points for the Gaussian formula
    print *, "Number of points to use in Gauss point-formula (2, 3, 4, 5): "
    read *, g

    select case (g)
        case (2)
            result = gauss_2_point(a, b)
            print *, "Result using Gauss 2-point formula is: ", result
        case (3)
            result = gauss_3_point(a, b)
            print *, "Result using Gauss 3-point formula is: ", result
        case (4)
            result = gauss_4_point(a, b)
            print *, "Result using Gauss 4-point formula is: ", result
        case (5)
            result = gauss_5_point(a, b)
            print *, "Result using Gauss 5-point formula is: ", result
        case default
            print *, "Formula not available."
    end select

contains

    ! Define the function to integrate (hardcoded for now)
    real(8) function f(x)
        real(8), intent(in) :: x
        f = exp(-(x**2))  ! Example function; modify as needed
    end function f

    ! Gaussian 2-point formula
    real(8) function gauss_2_point(a, b)
        real(8), intent(in) :: a, b
        real(8) :: w1, w2, x1, x2, F1, F2

        w1 = 1.0d0
        w2 = 1.0d0
        x1 = 1.0d0 / sqrt(3.0d0)
        x2 = -1.0d0 / sqrt(3.0d0)
        F1 = f(((b - a) / 2.0d0) * x1 + (b + a) / 2.0d0)
        F2 = f(((b - a) / 2.0d0) * x2 + (b + a) / 2.0d0)
        gauss_2_point = ((b - a) / 2.0d0) * (w1 * F1 + w2 * F2)
    end function gauss_2_point

    ! Gaussian 3-point formula
    real(8) function gauss_3_point(a, b)
        real(8), intent(in) :: a, b
        real(8) :: w1, w2, w3, x1, x2, x3, F1, F2, F3

        w1 = 5.0d0 / 9.0d0
        w2 = 8.0d0 / 9.0d0
        w3 = 5.0d0 / 9.0d0
        x1 = sqrt(3.0d0 / 5.0d0)
        x2 = 0.0d0
        x3 = -sqrt(3.0d0 / 5.0d0)
        F1 = f(((b - a) / 2.0d0) * x1 + (b + a) / 2.0d0)
        F2 = f(((b - a) / 2.0d0) * x2 + (b + a) / 2.0d0)
        F3 = f(((b - a) / 2.0d0) * x3 + (b + a) / 2.0d0)
        gauss_3_point = ((b - a) / 2.0d0) * (w1 * F1 + w2 * F2 + w3 * F3)
    end function gauss_3_point

    ! Gaussian 4-point formula
    real(8) function gauss_4_point(a, b)
        real(8), intent(in) :: a, b
        real(8) :: w1, w2, w3, w4, x1, x2, x3, x4, F1, F2, F3, F4

        w1 = (18.0d0 + sqrt(30.0d0)) / 36.0d0
        w2 = w1
        w3 = (18.0d0 - sqrt(30.0d0)) / 36.0d0
        w4 = w3
        x1 = sqrt(3.0d0 / 7.0d0 - (2.0d0 / 7.0d0) * sqrt(6.0d0 / 5.0d0))
        x2 = -x1
        x3 = sqrt(3.0d0 / 7.0d0 + (2.0d0 / 7.0d0) * sqrt(6.0d0 / 5.0d0))
        x4 = -x3
        F1 = f(((b - a) / 2.0d0) * x1 + (b + a) / 2.0d0)
        F2 = f(((b - a) / 2.0d0) * x2 + (b + a) / 2.0d0)
        F3 = f(((b - a) / 2.0d0) * x3 + (b + a) / 2.0d0)
        F4 = f(((b - a) / 2.0d0) * x4 + (b + a) / 2.0d0)
        gauss_4_point = ((b - a) / 2.0d0) * (w1 * F1 + w2 * F2 + w3 * F3 + w4 * F4)
    end function gauss_4_point

    ! Gaussian 5-point formula
    real(8) function gauss_5_point(a, b)
        real(8), intent(in) :: a, b
        real(8) :: w1, w2, w3, w4, w5, x1, x2, x3, x4, x5, F1, F2, F3, F4, F5

        w1 = (322.0d0 + 13.0d0 * sqrt(70.0d0)) / 900.0d0
        w2 = w1
        w3 = 128.0d0 / 225.0d0
        w4 = (322.0d0 - 13.0d0 * sqrt(70.0d0)) / 900.0d0
        w5 = w4
        x1 = (1.0d0 / 3.0d0) * sqrt(5.0d0 - 2.0d0 * sqrt(10.0d0 / 7.0d0))
        x2 = -x1
        x3 = 0.0d0
        x4 = (1.0d0 / 3.0d0) * sqrt(5.0d0 + 2.0d0 * sqrt(10.0d0 / 7.0d0))
        x5 = -x4
        F1 = f(((b - a) / 2.0d0) * x1 + (b + a) / 2.0d0)
        F2 = f(((b - a) / 2.0d0) * x2 + (b + a) / 2.0d0)
        F3 = f(((b - a) / 2.0d0) * x3 + (b + a) / 2.0d0)
        F4 = f(((b - a) / 2.0d0) * x4 + (b + a) / 2.0d0)
        F5 = f(((b - a) / 2.0d0) * x5 + (b + a) / 2.0d0)
        gauss_5_point = ((b - a) / 2.0d0) * (w1 * F1 + w2 * F2 + w3 * F3 + w4 * F4 + w5 * F5)
    end function gauss_5_point

end program gauss_quadrature
