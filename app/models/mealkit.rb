class Mealkit < ActiveRecord::Base
  belongs_to :customer
  validates :customer,   :presence => true
  attr_accessor :mealkit, :mealkits

end
