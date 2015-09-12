class Invitation < ActiveRecord::Base
  belongs_to :user

  validates :code, uniqueness: true

  def invalidate(user)
    self.update_attributes used: true, user_id: user.id
  end
end
