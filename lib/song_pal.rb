require 'pry'
require_relative 'artist'

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

  def self.artist_exists?(song_as_array)
    Artist.all.select do |a|
      a.name == song_as_array[0]
    end
  end

  def self.assign_songs_info
    @@songs_info.each do |song|
      if artist_exists?(song).size == 0
        artist = Artist.new.tap { |a| a.name = song[0] }
      else
        artist = artist_exists?(song).first
      end
    end
  end


end

SongPal.split_song_info
SongPal.assign_songs_info

# For every file, make the artist, then the genre, then the song?