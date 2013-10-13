require_relative './spec_helper.rb'

describe "Song" do

  let(:song_name) { "Sweetness" }
  let(:folk) { Genre.new }
  let(:song) { Song.new.tap {|s| s.name = song_name} }
  let(:artist) { Artist.new.tap {|a| a.name = "Jimmy Eat World"} }

  it "can initialize a song" do
    song.should be_an_instance_of(Song)
  end

  it "can have a name" do
    song.name.should eq(song_name)
  end

  it "can have a genre" do
    song.genre = folk
    song.genre.should eq(folk)
    folk.songs.should include(song)
  end

  it "has an artist" do
    song.artist = artist
    song.artist.should eq(artist)
    artist.add_song(song)
    artist.songs.should include(song)
  end
end
