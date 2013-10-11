class Genre

  attr_accessor :name, :songs, :artists

  @@genres = []

  def initialize
    @songs = []
    @artists = []
    @@genres << self
  end

  def self.count
    @@genres.count
  end

  def self.all
    @@genres
  end

  def self.reset_genres
    @@genres.clear
  end

  def self.genres
    all
  end

end