class User < ActiveRecord::Base
  has_secure_password
  has_many :pursuits

  validates_presence_of :email
end
