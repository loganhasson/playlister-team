require 'pry'
require_relative 'artist'
require_relative 'genre'
require_relative 'song'

class SongPal

  @@songs_info = []

  def self.songs_info
    @@songs_info
  end

  def self.get_song_info
    Dir.entries('data/.').map do |f|
      f.gsub('.mp3', '') if !f.start_with?('.')
    end.compact
  end

  def self.split_song_info
    get_song_info.each do |track|
      split = track.split(' - ')
      artist = split[0]
      song = split[1].split(' [')[0]
      genre = split[1].match(/(?<=\[).+?(?=\])/).to_s
      @@songs_info << [artist, song, genre]
    end
  end

  def self.artist_exists?(song)
    Artist.all.select do |a|
      a.name == song[0]
    end
  end

  def self.genre_exists?(song)
    Genre.all.select do |g|
      g.name == song[2]
    end
  end

  def self.create_artists
    songs_info.each do |song|
      if artist_exists?(song).size == 0
        artist = Artist.new.tap { |a| a.name = song[0] }
      else
        artist = artist_exists?(song).first
      end
    end
  end

  def self.create_genres
    songs_info.each do |song|
      if genre_exists?(song).size == 0
        genre = Genre.new.tap { |g| g.name = song[2] }
      else
        genre = genre_exists?(song).first
      end
    end
  end

  def self.find_genre(song)
    Genre.all.each do |g|
      return g if g.name == song[2]
    end
  end

  def self.find_artist(song)
    Artist.all.each do |a|
      return a if a.name == song[0]
    end
  end

  def self.create_songs
    songs_info.each do |song|
      new_song = Song.new.tap do |s|
        s.name = song[1]
        s.genre = find_genre(song)
      end
      find_artist(song).add_song(new_song)
    end
  end

end

SongPal.split_song_info
SongPal.create_artists
SongPal.create_genres
SongPal.create_songs
binding.pry

# For every file, make the artist, then the genre, then the song?