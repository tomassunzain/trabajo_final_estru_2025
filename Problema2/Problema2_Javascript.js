const Sales = [
  {InvoiceID:"750-67-8428", City:"Yangon",   CustomerType:"Member", Gender:"Female", ProductLine:"Health and beauty",      Total:74.26},
  {InvoiceID:"226-31-3081", City:"Mandalay", CustomerType:"Normal", Gender:"Male",   ProductLine:"Electronic accessories", Total:15.28},
  {InvoiceID:"631-41-3108", City:"Yangon",   CustomerType:"Normal", Gender:"Male",   ProductLine:"Home and lifestyle",     Total:46.33},
  {InvoiceID:"123-19-1176", City:"Naypyitaw",CustomerType:"Member", Gender:"Female", ProductLine:"Sports and travel",      Total:58.22},
  {InvoiceID:"373-73-7910", City:"Mandalay", CustomerType:"Member", Gender:"Female", ProductLine:"Food and beverages",     Total:33.08},
];

// Manual (sin .filter en el núcleo de búsqueda)
function searchSeq(list, predicate) {
  if (!list || list.length === 0) return { results: [], status: "EMPTY" };
  const out = [];
  for (const it of list) if (predicate(it)) out.push(it);
  return out.length > 0 ? { results: out, status: "OK" } : { results: [], status: "NOT_FOUND" };
}

const byCity         = (c)  => (it) => it.City === c;
const byProductLine  = (pl) => (it) => it.ProductLine === pl;
const byGender       = (g)  => (it) => it.Gender === g;
const byCustomerType = (ct) => (it) => it.CustomerType === ct;

for (const [label, pred] of [
  ["City=Yangon", byCity("Yangon")],
  ["ProductLine=Food and beverages", byProductLine("Food and beverages")],
  ["Gender=Male", byGender("Male")],
  ["CustomerType=VIP", byCustomerType("VIP")],
]) {
  const { results, status } = searchSeq(Sales, pred);
  console.log(`[MANUAL] ${label}: status=${status}, invoices=${results.map(r => r.InvoiceID)}`);
}

// Integrado (comparación)
const builtin = Sales.filter(byCity("Yangon"));
console.log(`[BUILTIN] City=Yangon -> ${builtin.map(r => r.InvoiceID)}`);
