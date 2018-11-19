require 'pry'
class Person
  attr_accessor :name
  @@all_names = []

  def initialize(name)
    @name = name
    self.save
  end

  def save
    @@all_names << self
  end

  def self.all
    @@all_names
  end

  def say_name
    [1,2,3].each do |number|
      @your_name = "Judy"
    end
    puts @your_name
  end

end


binding.pry
puts "goodbye"
