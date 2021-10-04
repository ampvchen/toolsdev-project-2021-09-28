module PagesHelper
  def location_name(location)
    if location.nickname.nil?
      "#{location.city}, #{ location.state.nil? ? location.country : location.state}"
    else
      location.nickname
    end
  end

  def location_long_name(location)
    name = location.city
    if location.state.nil?
      name << ", #{location.country}"
    else
      name << ", #{location.state}"
    end
    name << " (#{location.nickname})" unless location.nickname.nil?
    name
  end
end
