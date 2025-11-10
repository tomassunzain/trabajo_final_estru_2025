using System;
using System.Collections.Generic;
using System.Linq;

class Movie {
    public string Title { get; set; }
    public string Genre { get; set; }
    public int Year { get; set; }
    public double IMDB_Rating { get; set; }
}

class Program {
    static List<Movie> Seed() => new List<Movie> {
        new Movie{Title="The Shawshank Redemption", Genre="Drama", Year=1994, IMDB_Rating=9.3},
        new Movie{Title="Inception", Genre="Sci-Fi", Year=2010, IMDB_Rating=8.8},
        new Movie{Title="Parasite", Genre="Thriller", Year=2019, IMDB_Rating=8.6},
        new Movie{Title="Spirited Away", Genre="Animation", Year=2001, IMDB_Rating=8.6},
        new Movie{Title="The Godfather", Genre="Crime", Year=1972, IMDB_Rating=9.2},
        new Movie{Title="Interstellar", Genre="Sci-Fi", Year=2014, IMDB_Rating=8.7},
        new Movie{Title="Whiplash", Genre="Drama", Year=2014, IMDB_Rating=8.5},
    };

    // Manual selection sort by key selector
    static List<Movie> SortManual(List<Movie> src, Func<Movie,double> key, bool desc=false) {
        var a = new List<Movie>(src);
        for (int i = 0; i < a.Count - 1; i++) {
            int target = i;
            for (int j = i + 1; j < a.Count; j++) {
                bool better = desc ? key(a[j]) > key(a[target]) : key(a[j]) < key(a[target]);
                if (better) target = j;
            }
            if (target != i) { var tmp = a[i]; a[i] = a[target]; a[target] = tmp; }
        }
        return a;
    }

    static List<Movie> FilterManual(List<Movie> src, Func<Movie,bool> pred) {
        var outList = new List<Movie>();
        foreach (var m in src) if (pred(m)) outList.Add(m);
        return outList;
    }

    // Integradas (LINQ)
    static List<Movie> SortBuiltin(List<Movie> src, Func<Movie,object> key, bool desc=false) =>
        (desc ? src.OrderByDescending(key) : src.OrderBy(key)).ToList();

    static List<Movie> FilterBuiltin(List<Movie> src, Func<Movie,bool> pred) =>
        src.Where(pred).ToList();

    static void Main() {
        var movies = Seed();

        var m1 = SortManual(movies, m => m.IMDB_Rating);
        Console.WriteLine("Manual sort rating asc: " + string.Join(", ", m1.Select(x => x.Title)));

        var b1 = SortBuiltin(movies, m => m.Year, true);
        Console.WriteLine("Builtin sort year desc: " + string.Join(", ", b1.Select(x => x.Title)));

        var m2 = FilterManual(movies, m => m.IMDB_Rating > 8.7);
        Console.WriteLine("Manual filter rating>8.7: " + string.Join(", ", m2.Select(x => x.Title)));

        var b2 = FilterBuiltin(movies, m => m.Genre == "Drama");
        Console.WriteLine("Builtin filter Drama: " + string.Join(", ", b2.Select(x => x.Title)));
    }
}
