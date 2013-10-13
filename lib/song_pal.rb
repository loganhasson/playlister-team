require 'pry'
class SongPal

  @@songs_info = []

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
      genre = split[1].match(/(?<=\[)\w*(?=\])/).to_s
      binding.pry
    end
  end

    # hash = {"Artist" =>
    #           :genres =>
    #             :folk => [songs]
    #             :rap => [songs]
    #        }

end

SongPal.split_song_info

# Get all the file names from data directory

# Split them up into artist, song name, and genre (hash?)

# For every file, make the artist, then the genre, then the song?