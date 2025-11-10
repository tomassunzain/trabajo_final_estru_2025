data = {
  UnitPrice: [74.69,15.28,46.33,58.22,33.08],
  Quantity:  [7,5,3,8,4],
  Total:     [516.83,76.40,138.99,465.76,132.32]
}

def mean(a); a.sum / a.size.to_f; end
def stddev(a)
  m = mean(a)
  Math.sqrt(a.map { |x| (x - m)**2 }.sum / (a.size - 1))
end
def covariance(x,y)
  mx,my = mean(x),mean(y)
  x.zip(y).map { |xi,yi| (xi-mx)*(yi-my) }.sum / (x.size - 1)
end
def corr(x,y)
  covariance(x,y)/(stddev(x)*stddev(y))
end

keys = data.keys
manual = keys.map { |i| keys.map { |j| corr(data[i], data[j]) } }
puts "Manual correlation matrix:"
keys.each_with_index { |k,i| puts "#{k}: #{manual[i].map { |v| v.round(4) }}" }

# --- Integrada (usando Matrix y Enumerable) ---
require 'matrix'
arr = Matrix[*data.values]
builtin = arr.to_a.map.with_index { |r,i| 
  arr.to_a.map.with_index { |_,j| 
    n = r.size
    mx,my = mean(arr.row(i).to_a), mean(arr.row(j).to_a)
    cov = (0...n).map { |k| (arr[i,k]-mx)*(arr[j,k]-my) }.sum / (n-1)
    cov/(stddev(arr.row(i).to_a)*stddev(arr.row(j).to_a))
  } 
}
puts "\nBuiltin simulated corr (Ruby lacks native):"
builtin.each { |r| p r.map { |x| x.round(4) } }
