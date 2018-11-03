class Customer < ActiveRecord::Base  # holds logic of the app/ AR provides object relationship mapping for customer
  has_many :mealkits
  has_secure_password   # authenticate user / ac macros give access to few method- secure passwords
  validates_presence_of :username, :email, :password
  attr_accessor :mealkit, :mealkits
end
