module UsersHelper
  def region_lookup(timezone)
    ActiveSupport::TimeZone::MAPPING.invert[timezone]
  end
end
