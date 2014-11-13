class Pursuit < ActiveRecord::Base
  attr_accessor :pomodoro_length_in_minutes, :pomodoro_length_in_seconds
  belongs_to :user

  # Validations
  validates_presence_of :name

  # Inclusions
  include TimeConversions

  before_save :convert_length_to_seconds!
end
