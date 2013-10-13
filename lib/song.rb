class Song

  attr_accessor :name
  attr_reader :genre, :artist

  def genre=(genre)
    @genre = genre
    genre.songs << self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

end