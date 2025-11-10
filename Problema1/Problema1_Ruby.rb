movies = [
  {Title:"The Shawshank Redemption", Genre:"Drama",     Year:1994, IMDB_Rating:9.3},
  {Title:"Inception",                Genre:"Sci-Fi",    Year:2010, IMDB_Rating:8.8},
  {Title:"Parasite",                 Genre:"Thriller",  Year:2019, IMDB_Rating:8.6},
  {Title:"Spirited Away",            Genre:"Animation", Year:2001, IMDB_Rating:8.6},
  {Title:"The Godfather",            Genre:"Crime",     Year:1972, IMDB_Rating:9.2},
  {Title:"Interstellar",             Genre:"Sci-Fi",    Year:2014, IMDB_Rating:8.7},
  {Title:"Whiplash",                 Genre:"Drama",     Year:2014, IMDB_Rating:8.5}
]

def sort_manual(arr, key, reverse=false)
  a = arr.map(&:dup)
  (0...(a.length-1)).each do |i|
    target = i
    (i+1...a.length).each do |j|
      if reverse
        target = j if a[j][key] > a[target][key]
      else
        target = j if a[j][key] < a[target][key]
      end
    end
    a[i], a[target] = a[target], a[i] if target != i
  end
  a
end

def filter_manual(arr)
  out = []
  arr.each { |x| out << x if yield(x) }
  out
end

def sort_builtin(arr, key, reverse=false)
  arr.sort_by { |x| x[key] }.yield_self { |a| reverse ? a.reverse : a }
end

def filter_builtin(arr)
  arr.select { |x| yield(x) }
end

puts sort_manual(movies, :IMDB_Rating).map { |m| m[:Title] }
puts sort_builtin(movies, :Year, true).map { |m| m[:Title] }
puts filter_manual(movies) { |m| m[:IMDB_Rating] > 8.7 }.map { |m| m[:Title] }
puts filter_builtin(movies) { |m| m[:Genre] == "Drama" }.map { |m| m[:Title] }
