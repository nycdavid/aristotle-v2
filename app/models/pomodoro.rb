class Pomodoro < ActiveRecord::Base
  belongs_to :pursuit

  validates_presence_of :elapsed_time
  validates_presence_of :pursuit_id
end
