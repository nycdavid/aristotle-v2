class Pursuit < ActiveRecord::Base
  belongs_to :user

  # Validations
  validates_presence_of :name
end
