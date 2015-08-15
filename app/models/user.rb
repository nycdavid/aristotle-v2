class User < ActiveRecord::Base
  attr_accessor :reset_token

  has_secure_password
  has_many :pursuits

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :timezone, presence: true


  def full_name
    "#{first_name} #{last_name}"
  end

  def todays_productivity
    {
      time: pursuits.map { |pursuit| pursuit.ranged_pomodori("today")[:time] }.sum,
      pomodori: pursuits.map { |pursuit| pursuit.ranged_pomodori("today")[:count] }.sum
    }
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute :reset_digest, User.digest(reset_token)
    update_attribute :reset_sent_at, Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def valid_reset_token?(token)
    Digest::SHA2.hexdigest(token.to_s) == reset_digest
  end

  def now
    TZInfo::Timezone.get(timezone).now
  end

  private

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA2.hexdigest(token.to_s)
  end
end
