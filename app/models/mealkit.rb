class Mealkit < ActiveRecord::Base
  belongs_to :customer
  attr_accessor :mealkit, :mealkits

end
