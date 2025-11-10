import math
import numpy as np  # solo para la versión integrada

UnitPrice = [74.69, 15.28, 46.33, 58.22, 33.08]
Quantity  = [7, 5, 3, 8, 4]
Total     = [516.83, 76.40, 138.99, 465.76, 132.32]

def mean(lst): return sum(lst) / len(lst)

def stddev(lst):
    μ = mean(lst)
    return math.sqrt(sum((x - μ)**2 for x in lst) / (len(lst)-1))

def covariance(x, y):
    μx, μy = mean(x), mean(y)
    return sum((x[i]-μx)*(y[i]-μy) for i in range(len(x))) / (len(x)-1)

def corr(x, y):
    return covariance(x, y) / (stddev(x) * stddev(y))

def corr_matrix_manual(data):
    keys = list(data.keys())
    M = [[corr(data[i], data[j]) for j in keys] for i in keys]
    return keys, M

data = {"UnitPrice": UnitPrice, "Quantity": Quantity, "Total": Total}
keys, M = corr_matrix_manual(data)
print("Manual correlation matrix:")
for i,k in enumerate(keys):
    print(k, ["{:.4f}".format(v) for v in M[i]])

# --- Integrada ---
arr = np.array([UnitPrice, Quantity, Total])
corr_builtin = np.corrcoef(arr)
print("\nBuiltin numpy.corrcoef:\n", np.round(corr_builtin,4))
