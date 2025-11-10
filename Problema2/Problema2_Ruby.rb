Sales = [
  {InvoiceID:"750-67-8428", City:"Yangon",   CustomerType:"Member", Gender:"Female", ProductLine:"Health and beauty",      Total:74.26},
  {InvoiceID:"226-31-3081", City:"Mandalay", CustomerType:"Normal", Gender:"Male",   ProductLine:"Electronic accessories", Total:15.28},
  {InvoiceID:"631-41-3108", City:"Yangon",   CustomerType:"Normal", Gender:"Male",   ProductLine:"Home and lifestyle",     Total:46.33},
  {InvoiceID:"123-19-1176", City:"Naypyitaw",CustomerType:"Member", Gender:"Female", ProductLine:"Sports and travel",      Total:58.22},
  {InvoiceID:"373-73-7910", City:"Mandalay", CustomerType:"Member", Gender:"Female", ProductLine:"Food and beverages",     Total:33.08},
]

def search_seq(list)
  return [[], "EMPTY"] if list.nil? || list.empty?
  out = []
  list.each { |item| out << item if yield(item) }
  return [out, "OK"] unless out.empty?
  [[], "NOT_FOUND"]
end

by_city         = ->(c)  { ->(it) { it[:City] == c } }
by_productline  = ->(pl) { ->(it) { it[:ProductLine] == pl } }
by_gender       = ->(g)  { ->(it) { it[:Gender] == g } }
by_customertype = ->(ct) { ->(it) { it[:CustomerType] == ct } }

[
  ["City=Yangon", by_city.call("Yangon")],
  ["ProductLine=Food and beverages", by_productline.call("Food and beverages")],
  ["Gender=Male", by_gender.call("Male")],
  ["CustomerType=VIP", by_customertype.call("VIP")],
].each do |label, pred|
  res, status = search_seq(Sales, &pred)
  puts "[MANUAL] #{label}: status=#{status}, invoices=#{res.map { |r| r[:InvoiceID] }}"
end

# Integrado (comparación)
builtin = Sales.select { |it| it[:City] == "Yangon" }
puts "[BUILTIN] City=Yangon -> #{builtin.map { |r| r[:InvoiceID] }}"
