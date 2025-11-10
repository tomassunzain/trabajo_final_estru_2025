using System;
using System.Collections.Generic;
using System.Linq;

class Sale {
    public string InvoiceID { get; set; }
    public string City { get; set; }
    public string CustomerType { get; set; }
    public string Gender { get; set; }
    public string ProductLine { get; set; }
    public double Total { get; set; }
}

class Program {
    static List<Sale> Seed() => new List<Sale> {
        new Sale{InvoiceID="750-67-8428", City="Yangon",   CustomerType="Member", Gender="Female", ProductLine="Health and beauty",      Total=74.26},
        new Sale{InvoiceID="226-31-3081", City="Mandalay", CustomerType="Normal", Gender="Male",   ProductLine="Electronic accessories", Total=15.28},
        new Sale{InvoiceID="631-41-3108", City="Yangon",   CustomerType="Normal", Gender="Male",   ProductLine="Home and lifestyle",     Total=46.33},
        new Sale{InvoiceID="123-19-1176", City="Naypyitaw",CustomerType="Member", Gender="Female", ProductLine="Sports and travel",      Total=58.22},
        new Sale{InvoiceID="373-73-7910", City="Mandalay", CustomerType="Member", Gender="Female", ProductLine="Food and beverages",     Total=33.08},
    };

    // Manual
    static (List<Sale> results, string status) SearchSeq(List<Sale> list, Func<Sale,bool> pred) {
        if (list == null || list.Count == 0) return (new List<Sale>(), "EMPTY");
        var outList = new List<Sale>();
        foreach (var s in list) if (pred(s)) outList.Add(s);
        return outList.Count > 0 ? (outList, "OK") : (new List<Sale>(), "NOT_FOUND");
    }

    static void Main() {
        var sales = Seed();

        var cases = new (string label, Func<Sale,bool> pred)[] {
            ("City=Yangon", s => s.City == "Yangon"),
            ("ProductLine=Food and beverages", s => s.ProductLine == "Food and beverages"),
            ("Gender=Male", s => s.Gender == "Male"),
            ("CustomerType=VIP", s => s.CustomerType == "VIP"),
        };

        foreach (var c in cases) {
            var (res, status) = SearchSeq(sales, c.pred);
            Console.WriteLine($"[MANUAL] {c.label}: status={status}, invoices={string.Join(", ", res.Select(x => x.InvoiceID))}");
        }

        // Integrado (comparación con LINQ)
        var builtin = sales.Where(s => s.City == "Yangon").ToList();
        Console.WriteLine("[BUILTIN] City=Yangon -> " + string.Join(", ", builtin.Select(x => x.InvoiceID)));
    }
}
