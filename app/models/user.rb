class User < ActiveRecord::Base
  has_many :meal_kits
  has_secure_password
  validates_presence of :username, :email

end
  
