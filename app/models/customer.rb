class Customer < ActiveRecord::Base
  has_many :meal_kits
  has_secure_password
  validates_presence_of :username, :email



end
