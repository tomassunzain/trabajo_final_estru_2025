const data = {
  UnitPrice: [74.69,15.28,46.33,58.22,33.08],
  Quantity:  [7,5,3,8,4],
  Total:     [516.83,76.40,138.99,465.76,132.32],
};

function mean(a){ return a.reduce((s,x)=>s+x,0)/a.length; }
function std(a){ const m=mean(a); return Math.sqrt(a.reduce((s,x)=>s+(x-m)**2,0)/(a.length-1)); }
function cov(x,y){ const mx=mean(x), my=mean(y); return x.reduce((s,_,i)=>s+(x[i]-mx)*(y[i]-my),0)/(x.length-1); }
function corr(x,y){ return cov(x,y)/(std(x)*std(y)); }

const keys = Object.keys(data);
console.log("Manual correlation matrix:");
for(let i=0;i<keys.length;i++){
  const row = keys.map(kj => corr(data[keys[i]], data[kj]).toFixed(4));
  console.log(keys[i]+":", row);
}
