class Song

  attr_accessor :name, :artist
  attr_reader :genre, :artist

  @@songs = []

  def initialize
    @@songs << self
  end

  def self.all
    @@songs
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self
  end

end