class Customer < ActiveRecord::Base
  has_many :mealkits
  has_secure_password
  validates_presence_of :username, :email, :password

end
