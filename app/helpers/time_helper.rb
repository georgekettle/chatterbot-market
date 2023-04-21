module TimeHelper
  def created_at_timestamp(object, time_zone = nil)
    object.created_at.in_time_zone(time_zone).strftime('%l:%M %p').sub(' AM ', ' am ').sub(' PM ', ' pm ')
  end
end