# -*- coding: utf-8 -*-
from typing import List, Dict, Tuple, Callable

Sales: List[Dict] = [
    {"InvoiceID":"750-67-8428", "City":"Yangon",   "CustomerType":"Member", "Gender":"Female", "ProductLine":"Health and beauty",        "Total":74.26},
    {"InvoiceID":"226-31-3081", "City":"Mandalay", "CustomerType":"Normal", "Gender":"Male",   "ProductLine":"Electronic accessories",   "Total":15.28},
    {"InvoiceID":"631-41-3108", "City":"Yangon",   "CustomerType":"Normal", "Gender":"Male",   "ProductLine":"Home and lifestyle",       "Total":46.33},
    {"InvoiceID":"123-19-1176", "City":"Naypyitaw","CustomerType":"Member", "Gender":"Female", "ProductLine":"Sports and travel",        "Total":58.22},
    {"InvoiceID":"373-73-7910", "City":"Mandalay", "CustomerType":"Member", "Gender":"Female", "ProductLine":"Food and beverages",       "Total":33.08},
]

# --- Manual (no filter/find) ---
def search_seq(lst: List[Dict], predicate: Callable[[Dict], bool]) -> Tuple[List[Dict], str]:
    if not lst:
        return [], "EMPTY"
    out = []
    for item in lst:
        if predicate(item):
            out.append(item)
    return (out, "OK") if out else ([], "NOT_FOUND")

# Predicados
def by_city(city: str):           return lambda it: it["City"] == city
def by_productline(pl: str):      return lambda it: it["ProductLine"] == pl
def by_gender(g: str):            return lambda it: it["Gender"] == g
def by_customertype(ct: str):     return lambda it: it["CustomerType"] == ct

# --- Integrado (para comparar) ---
def search_builtin(lst: List[Dict], predicate) -> List[Dict]:
    return list(filter(predicate, lst))

if __name__ == "__main__":
    for label, pred in [
        ("City=Yangon", by_city("Yangon")),
        ("ProductLine=Food and beverages", by_productline("Food and beverages")),
        ("Gender=Male", by_gender("Male")),
        ("CustomerType=VIP", by_customertype("VIP")),
    ]:
        res, status = search_seq(Sales, pred)
        print(f"[MANUAL] {label}: status={status}, invoices={[r['InvoiceID'] for r in res]}")

    # Integrado (comparación)
    res2 = search_builtin(Sales, by_city("Yangon"))
    print(f"[BUILTIN] City=Yangon -> {[r['InvoiceID'] for r in res2]}")

    # Stub CSV (opcional)
    # import csv
    # with open('supermarket_sales.csv', newline='', encoding='utf-8') as f:
    #     reader = csv.DictReader(f)
    #     Sales = list(reader)
