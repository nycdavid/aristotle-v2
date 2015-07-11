module UsersHelper
  def region_lookup(timezone)
    ActiveSupport::TimeZone::MAPPING.invert[timezone]
  end

  def gravatar_image_url
    hash = Digest::MD5.hexdigest current_user.email.downcase
    "http://www.gravatar.com/avatar/#{hash}"
  end

  def display_name
    if current_user.full_name == " "
      truncate current_user.email, length: 20
    else
      current_user.full_name
    end
  end

  def active?(action)
    comparison_string = "#{controller_name}-#{action_name}" 
    if comparison_string == action
      "nav-link--active"
    end
  end
end
