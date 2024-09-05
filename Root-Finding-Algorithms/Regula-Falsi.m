f = input('Enter your function: ');
a = input('Enter the left side of your guess: ');
b = input('Enter the right side of your guess: ');
n = input('Enter the number of interations you want: ');
e = input('Enter your desired tolerance: ');

if f(a)*f(b) < 0 && a < b 
    for i = 1:n
    c = (a*f(b) - b*f(a)) / (f(b) - f(a));
    fprintf('c%d = %.4f\n', i, c)
    if abs(f(c)) < e 
        break
    end
    if f(a)*f(c) < 0 
        b = c;
    elseif f(b)*f(c) < 0 
        a = c;
    end 
    end 
else 
    disp('No root between given interval.')
end
