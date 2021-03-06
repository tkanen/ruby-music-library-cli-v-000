require 'pry'

class Song

  attr_accessor :name, :artist, :genre

  @@all = []

  def self.all
    @@all
  end

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
    save
  end

  def self.create(name, artist = nil, genre = nil)
    song = self.new(name, artist = nil, genre = nil)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.find_by_name(name)
    self.all.detect { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(file)
    artist, title, genre = file.gsub!('.mp3', '').split(' - ')
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)
    song = self.new(title, artist, genre)
  end

  def self.create_from_filename(file)
    self.new_from_filename(file)
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end
end
