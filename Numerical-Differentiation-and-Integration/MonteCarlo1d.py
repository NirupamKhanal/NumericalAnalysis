import numpy as np 

def f(x):
    #func = input("Please enter a function :")
    return 7*x - 8.5*x**2 + 3*x**3 
    #return func 

a = int(input("Please enter the lower limit of integration:"))
b = int(input("Please enter the upper limit of integration:"))
N = int(input("Please enter the total number of random points you want to generate for the integration:"))    
act = float(input("Please enter the actual value of the integration"))

x = []
for i in range(N):
    x.append(np.random.uniform(a, b))
    
summation = 0 
for k in x:
    summation = summation + f(k)

integrated_value = (b - a)/N * summation
print("The integrated value of the function using Monte Carlo method is: ", integrated_value)
error = abs(act - integrated_value) / act * 100 
print("The percentage error from the actual value is: ", error)
