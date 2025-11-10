const movies = [
  {Title:"The Shawshank Redemption", Genre:"Drama",     Year:1994, IMDB_Rating:9.3},
  {Title:"Inception",                Genre:"Sci-Fi",    Year:2010, IMDB_Rating:8.8},
  {Title:"Parasite",                 Genre:"Thriller",  Year:2019, IMDB_Rating:8.6},
  {Title:"Spirited Away",            Genre:"Animation", Year:2001, IMDB_Rating:8.6},
  {Title:"The Godfather",            Genre:"Crime",     Year:1972, IMDB_Rating:9.2},
  {Title:"Interstellar",             Genre:"Sci-Fi",    Year:2014, IMDB_Rating:8.7},
  {Title:"Whiplash",                 Genre:"Drama",     Year:2014, IMDB_Rating:8.5},
];

// ---- Manual selection sort
function sortManual(arr, key, reverse=false) {
  const a = arr.map(x => ({...x}));
  for (let i = 0; i < a.length - 1; i++) {
    let target = i;
    for (let j = i + 1; j < a.length; j++) {
      const better = reverse ? (a[j][key] > a[target][key]) : (a[j][key] < a[target][key]);
      if (better) target = j;
    }
    if (target !== i) [a[i], a[target]] = [a[target], a[i]];
  }
  return a;
}

function filterManual(arr, predicate) {
  const out = [];
  for (const x of arr) if (predicate(x)) out.push(x);
  return out;
}

// ---- Integradas
function sortBuiltin(arr, key, reverse=false) {
  const a = [...arr].sort((x, y) => (x[key] < y[key] ? -1 : x[key] > y[key] ? 1 : 0));
  return reverse ? a.reverse() : a;
}
function filterBuiltin(arr, predicate) { return arr.filter(predicate); }

// Demo
console.log("Manual sort rating asc:", sortManual(movies, "IMDB_Rating").map(m => m.Title));
console.log("Builtin sort year desc:", sortBuiltin(movies, "Year", true).map(m => m.Title));
console.log("Manual filter rating>8.7:", filterManual(movies, m => m.IMDB_Rating > 8.7).map(m => m.Title));
console.log("Builtin filter Drama:", filterBuiltin(movies, m => m.Genre === "Drama").map(m => m.Title));
