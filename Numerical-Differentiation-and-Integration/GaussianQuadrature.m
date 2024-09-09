f = input('Enter your function: ');
a = input('Lower limit: '); 
b = input('Upper limit: '); 
g = input('Number of points being used in Gauss point-formula (Enter 0 if you want all cases): ');
F = @(t) f(((b-a)*t + (b+a)) / 2); 

switch g 
    case 2
        w1 = 1; w2 = 1; 
        x1 = 1/sqrt(3); x2 = -1/sqrt(3); 
        G2 = ((b-a)/2) * (w1*F(x1) + w2*F(x2));
        fprintf('Result using Gauss 2-point formula is: %.5f\n', G2)
    case 3
        w1 = 5/9; w2 = 8/9; w3 = 5/9; 
        x1 = sqrt(3/5); x2 = 0; x3 = -sqrt(3/5); 
        G3 = ((b-a)/2) * (w1*F(x1) + w2*F(x2) + w3*F(x3));
        fprintf('Result using Gauss 3-point formula is: %.5f\n', G3)
    case 4
        w1 = (18 + sqrt(30)) / 36; w2 = (18 + sqrt(30)) / 36; w3 = (18 - sqrt(30)) / 36; w4 = (18 - sqrt(30)) / 36;
        x1 = sqrt(3/7 - (2/7)*(sqrt(6/5))); x2 = -sqrt(3/7 - (2/7)*(sqrt(6/5))); x3 = sqrt(3/7 + (2/7)*(sqrt(6/5))); x4 = -sqrt(3/7 + (2/7)*(sqrt(6/5)));
        G4 = ((b-a)/2) * (w1*F(x1) + w2*F(x2) + w3*F(x3 + w4*F(x4)));
        fprintf('Result using Gauss 4-point formula is: %.5f\n', G4)
    case 5
        w1 = (322+13*sqrt(70))/900; w2 = (322+13*sqrt(70))/900; w3 = 128/225; w4 = (322-13*sqrt(70))/900; w5 = (322-13*sqrt(70))/900;
        x1 = (1/3)*sqrt(5-2*sqrt(10/7)); x2 = -(1/3)*sqrt(5-2*sqrt(10/7)); x3 = 0; x4 = (1/3)*sqrt(5+2*sqrt(10/7)); x5 = -(1/3)*sqrt(5+2*sqrt(10/7));
        G5 = ((b-a)/2) * (w1*F(x1) + w2*F(x2) + w3*F(x3) + w4*F(x4) + w5*F(x5));
        fprintf('Result using Gauss 5-point formula is: %.5f\n', G5)
    otherwise 
        warning('Formula not available.')
end 