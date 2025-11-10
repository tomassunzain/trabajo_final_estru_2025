# -*- coding: utf-8 -*-
movies = [
    {"Title":"The Shawshank Redemption","Genre":"Drama","Year":1994,"IMDB_Rating":9.3},
    {"Title":"Inception","Genre":"Sci-Fi","Year":2010,"IMDB_Rating":8.8},
    {"Title":"Parasite","Genre":"Thriller","Year":2019,"IMDB_Rating":8.6},
    {"Title":"Spirited Away","Genre":"Animation","Year":2001,"IMDB_Rating":8.6},
    {"Title":"The Godfather","Genre":"Crime","Year":1972,"IMDB_Rating":9.2},
    {"Title":"Interstellar","Genre":"Sci-Fi","Year":2014,"IMDB_Rating":8.7},
    {"Title":"Whiplash","Genre":"Drama","Year":2014,"IMDB_Rating":8.5},
]

# -------- Manual --------
def sort_manual(lst, key, reverse=False):
    arr = lst[:]  # copia
    n = len(arr)
    for i in range(n-1):
        target = i
        for j in range(i+1, n):
            if (arr[j][key] < arr[target][key]) ^ reverse:  # XOR truco p/asc/desc
                target = j
        if target != i:
            arr[i], arr[target] = arr[target], arr[i]
    return arr

def filter_manual(lst, predicate):
    out = []
    for item in lst:
        if predicate(item):
            out.append(item)
    return out

# -------- Integrada --------
def sort_builtin(lst, key, reverse=False):
    return sorted(lst, key=lambda x: x[key], reverse=reverse)

def filter_builtin(lst, predicate):
    return list(filter(predicate, lst))

# -------- Predicados de ejemplo --------
pred_rating_gt_87 = lambda m: m["IMDB_Rating"] > 8.7
pred_is_drama     = lambda m: m["Genre"] == "Drama"

if __name__ == "__main__":
    print("Manual sort by rating asc:")
    print([m["Title"] for m in sort_manual(movies, "IMDB_Rating")])

    print("Builtin sort by year desc:")
    print([m["Title"] for m in sort_builtin(movies, "Year", reverse=True)])

    print("Manual filter rating > 8.7:")
    print([m["Title"] for m in filter_manual(movies, pred_rating_gt_87)])

    print("Builtin filter Genre == Drama:")
    print([m["Title"] for m in filter_builtin(movies, pred_is_drama)])
