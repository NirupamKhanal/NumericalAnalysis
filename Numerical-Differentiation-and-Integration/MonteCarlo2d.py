import numpy as np 

def f(x, y):
    #func = input("Please enter a function :")
    return 7*x**3*y**2
    #return func 

a = int(input("Please enter the lower limit of integration with respect to dx:"))
b = int(input("Please enter the upper limit of integration with respect to dx:"))
c = int(input("Please enter the lower limit of integration with respect to dy:"))
d = int(input("Please enter the upper limit of integration with respect to dy:"))
N = int(input("Please enter the total number of random points you want to generate for the integration:"))    
act = float(input("Please enter the actual value of the integration"))

x = []
y = []
for i in range(N):
    x.append(np.random.uniform(a, b))
    y.append(np.random.uniform(c, d))
    
summation = 0 
for i in range(N):
    summation = summation + f(x[i], y[i])

integrated_value = (b - a)*(d - c)/N * summation
print("The integrated value of the function using Monte Carlo method is: ", integrated_value)
error = abs(act - integrated_value) / act * 100 
print("The percentage error from the actual value is: ", error)
