class Pursuit < ActiveRecord::Base
  attr_accessor :pomodoro_length_in_minutes, :pomodoro_length_in_seconds
  belongs_to :user
  has_many :pomodori

  # Validations
  validates_presence_of :name, :user_id

  # Inclusions
  include TimeConversions

  before_save :convert_length_to_seconds!

  def cumulative_time
    pomodori.map { |pom| pom.elapsed_time }
            .inject(0) { |result, element| result + element } 
  end
end
