require 'pry'
require 'erb'

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

artists_index = ERB.new(File.open('lib/templates/artists.erb').read)
@artists = Artist.all

File.open('_site/artists/index.html', 'w+') do |f|
  f << artists_index.result
end

genres_index = ERB.new(File.open('lib/templates/genres.erb').read)
@genres = Genre.all

File.open('_site/genres/index.html', 'w+') do |f|
  f << genres_index.result
end

songs_index = ERB.new(File.open('lib/templates/songs.erb').read)
@songs = Song.all

File.open('_site/songs/index.html', 'w+') do |f|
  f << songs_index.result
end

artist_show = ERB.new(File.open('lib/templates/artist_show.erb').read)
@artists.each do |a|
  @artist = a
  File.open("_site/artists/#{@artist.name.gsub(' ', '_')}.html", "w+") do |f|
    f << artist_show.result
  end
end

genre_show = ERB.new(File.open('lib/templates/genre_show.erb').read)
@genres.each do |g|
  @genre = g
  File.open("_site/genres/#{@genre.name.gsub(' ', '_')}.html", "w+") do |f|
    f << genre_show.result
  end
end

song_show = ERB.new(File.open('lib/templates/song_show.erb').read)
@songs.each do |s|
  @song = s
  File.open("_site/songs/#{@song.name.gsub(' ', '_')}.html", "w+") do |f|
    f << song_show.result
  end
end

